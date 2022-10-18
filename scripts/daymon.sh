#!/bin/bash -e
# A basic process manager
# Garrett Mills <shout@garrettmills.dev>
#
# USAGE:
#
# daymon_init
# daymon_configure http python -m http.server --port 3000
# daymon_start http
# daymon_stop http
# daymon_restart http
#

AT_PREFIX="${AT_PREFIX:-}"
export DAYMON_ROOT="${AT_PREFIX}/var/run/daymon"
export DAYMON_PIDS="${DAYMON_ROOT}/pid"
export DAYMON_SCRIPTS="${DAYMON_ROOT}/script"
export DAYMON_LOGS="${AT_PREFIX}/var/log/daymon"

# Initialize Daymon's working directories.
function daymon_init() {
    mkdir -p "${DAYMON_PIDS}"
    mkdir -p "${DAYMON_SCRIPTS}"
    mkdir -p "${DAYMON_LOGS}"
}

# Check whether the given service is running.
function daymon_running() {
    local pname
    pname=$1

    if [ -f "${DAYMON_PIDS}/${pname}.pid" ]; then
        if ps -p $(cat "${DAYMON_PIDS}/${pname}.pid") > /dev/null 2>&1; then
            return 0
        else
            rm -f "${DAYMON_PIDS}/${pname}.pid"
            return 1
        fi
    else
        return 1
    fi
}

# Register a new service with Daymon
# Example: daymon_configure http python -m http.server --port 3000
function daymon_configure() {
    local pname
    pname=$1
    local pcmd
    pcmd="${@:2}"

    local logfile
    logfile="${DAYMON_LOGS}/${pname}.log"

    local scriptfile
    scriptfile="${DAYMON_SCRIPTS}/${pname}.sh"

    local pidfile
    pidfile="${DAYMON_PIDS}/${pname}.pid"

    echo "#!/bin/bash -xe" > "$scriptfile"
    echo "$pcmd > '$logfile' 2>&1 &" >> "$scriptfile"
    echo 'echo -n $! >"'"${pidfile}"'"' >> "$scriptfile"
    chmod +x "$scriptfile"
}

# Check whether there is a configured service with the given name
function daymon_has_service() {
    local pname
    pname=$1

    local scriptfile
    scriptfile="${DAYMON_SCRIPTS}/${pname}.sh"

    [ -f "$scriptfile" ] && return 0 || return 1
}

# Start the service with the given name
# Example: daymon_start http
function daymon_start() {
    local pname
    pname="$1"

    local pcmd
    pcmd="${@:2}"

    local scriptfile
    scriptfile="${DAYMON_SCRIPTS}/${pname}.sh"

    if ! [ -z "$pcmd" ] || ! daymon_has_service $pname; then
        daymon_configure $pname $pcmd
    fi

    nohup "$scriptfile" 0<&- &> /dev/null &
}

# Stop a service with the given name.
# Example: daymon_stop http
function daymon_stop() {
    local pname
    pname=$1

    if ! daymon_running $pname; then
        return 0
    fi

    local pid
    pid=$(cat "${DAYMON_PIDS}/${pname}.pid")

    kill -s TERM $pid

    for (( i=0; i<10; ++i )); do
        if daymon_running $pname; then
            sleep 1
        else
            return 0
        fi
    done

    kill -9 $pid

    for (( i=0; i<10; ++i )); do
        if daymon_running $pname; then
            sleep 1
        else
            return 0
        fi
    done

    if daymon_running $pname; then
        return 1
    fi

    return 0
}

# Restart a service with the given name.
# Example: daymon_restart http
function daymon_restart() {
    local pname
    pname=$1

    if daymon_stop $pname && daymon_start $pname; then
        return 0
    fi

    return 1
}

