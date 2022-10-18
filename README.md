# AM-CakeML Environment

This is a recipe for a Docker container that comes pre-configured with the `ku-mst` blockchain, IBM TPM emulator, and the `am-cakeml` attestation manager.

The `Dockerfile` uses some heavy automation to perform all the setup for the TPM, blockchain initialization, smart contract accounts, and propagates the generated contract and account IDs to the necessary config files and CakeML source.

## Building

To build the container, you need:

- Docker
- git
    - Your git user needs to have SSH access to the `ku-mst` repo.

Then, build the container with `make`. You can optionally specify a remote registry using the `DOCKER_REGISTRY` environment variable.

There are 2 versions of the container, one based on `ubuntu:22.04` and one based on `fedora:36`. You can build these with `make image_ubuntu` and `make image_fedora` respectively.

If you want to install the demo files to a non-root directory, export the `AT_PREFIX` variable. This variable should NOT end with a `/`.

## Running the demo

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

