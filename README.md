# AM-CakeML Environment

This is a collection of scripts which automate the setup of the CakeML attestation manager and associated blockchain in various environments.

The scripts can be used to setup the AM in on an arbitrary Linux machine (see "Running the demo (on the test bed)" for an example), but it also provides Dockerfiles which setup the environment in either Fedora- or Ubuntu-based images.

The scripts use some heavy automation to perform all the setup for the TPM, blockchain initialization, smart contract accounts, and propagates the generated contract and account IDs to the necessary config files and CakeML source.

## Building Docker images

To build the container, you need:

- Docker
- git
    - Your git user needs to have SSH access to the `ku-mst` repo.

Then, build the container with `make`. You can optionally specify a remote registry using the `DOCKER_REGISTRY` environment variable.

There are 2 versions of the container, one based on `ubuntu:22.04` and one based on `fedora:36`. You can build these with `make image_ubuntu` and `make image_fedora` respectively.

If you want to install the demo files to a non-root directory, export the `AT_PREFIX` variable. This variable should NOT end with a `/`.

## Running the demo (in Docker)

Once the container is built, you can run it using `make run_{ubuntu|fedora}`, which will drop you in a Bash shell.

There, you can use my crappy `daymon` process manager to start the background services for the demo:

```shell
source /scripts/daymon.sh
daymon_start mine
daymon_start tpm
daymon_start demo.server  # or demo.serverClient
```

Then, you can run the client demo:

```shell
cd /am-cakeml/build/apps/demo/clientdemo ../../../apps/demo/client/example_client.ini
```

## Running the demo (on the test bed)

> There are several environment variables which can be specified during setup to modify things like the blockchain port, demo server IP and port, and others. For an example, see `scripts/test-bed.sh`.

I've tested this on honesty and validity.

```shell
source scripts/test-bed.sh
cd ..
./am-docker/scripts/setup-full.sh
```

Then, start the server on one host:

```shell
source ~/at-demo/scripts/test-bed.sh
daymon_start mine
daymon_start demo.server
tail -f ~/at-demo/var/log/daymon/demo.server.log
```

Then, on a different node, run the client:

```shell
source ~/at-demo/scripts/test-bed.sh
cd ~/at-demo/am-cakeml
./build/apps/demo/clientdemo ./apps/demo/client/example_client.ini
```

(The setup scripts will automatically replace the IP addresses / port numbers in code based on the environment variables configured by the `scripts/test-bed.sh` script.)

