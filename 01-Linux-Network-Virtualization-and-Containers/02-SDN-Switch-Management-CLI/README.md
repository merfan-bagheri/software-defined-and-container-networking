# Problem 2 (Container Runtime) 35 + 10 points

In this problem, you are going to implement a container runtime (a very simple version of Docker). You can use any language to do this (Python, Bash, Golang, etc.). Your container runtime is a CLI that takes a parameter, `hostname`, and creates the container. After running your CLI like this:

```
your-cli myhostname
```

We should enter in the bash that exists in new namespaces and has `myhostname` as its hostname. Also, by running

```
ps fax
```

in the container, we should see the bash process as PID 1. Your container runtime must have these features:

- Creates these new namespaces for the container: `net`, `mnt`, `pid`, `uts`
- The container has a filesystem other than the host's root, and its root is a directory that has contents of the Ubuntu 20.04 filesystem (like `ubuntu:20.04` image on DockerHub). Each container has its own separate root filesystem on the host.
- [BONUS] The CLI has a second optional argument in **megabytes** that limits memory usage of the container.

## Deliverables

- The files needed for your CLI to run.
- A document named `README.md` explaining how to run the CLI.

# Problem Explanation
# Please note, if you want to run a bash script from your command line interface (CLI), you should first make it executable with this code:
```bash
   chmod +x script.sh
   ```
This code implements a simple container runtime using Bash. The key features of the implementation are:

1. **Namespace Creation**: The container runtime creates new namespaces for the container, including `net`, `mnt`, `pid`, and `uts`.
2. **Rootfs Setup**: The container has a separate filesystem from the host's root, and its root is a directory containing the contents of the Ubuntu 20.04 filesystem. This is achieved using the `debootstrap` tool.
3. **Memory Limit**: The container runtime takes an optional argument to set a memory limit for the container, and enforces this limit using the cgroup memory subsystem.

## Bootstrap Process

The code uses the `debootstrap` tool to install the Ubuntu 20.04 filesystem into the container's root filesystem directory. This eliminates the need to maintain the files required to generate the filesystem, as `debootstrap` will handle the download and setup of the necessary files.

## Filesystem Maintenance

Since the container runtime uses `debootstrap` to set up the container's root filesystem, there is no need to maintain the files required to generate the filesystem. The `debootstrap` tool will handle the download and setup of the necessary files, making the container runtime more portable and easier to maintain.

## Running the Container Runtime

To run the container runtime and create a new container, first switch to the root user using the following command:

```
sudo su
```

Then, use the following command to create a new container:

```
./cli.sh <HOSTNAME> <ROOT_PATH> <MEMORY_USAGE_LIMIT_IN_MEGABYTE>
```

If you run the `ps fax` command to see the current processes:

```
root@SDMN:/# ps fax
    PID TTY      STAT   TIME COMMAND
      1 ?        S      0:00 bash
      8 ?        R+     0:00 ps fax
root@SDMN:/#
```

If you want to test the memory limitation, you can set the limitation to 20 megabytes and run this command:

```
./main.sh erfan /tmp/mycontainer/rootfs 20
dd if=/dev/urandom of=/dev/null bs=21M count=2
```

This command will create a container with a memory limit of 20 megabytes. If you run the `dd` command inside the container, which requires more than 20 megabytes of memory, the container will be killed by the bash and filesystem due to the memory limit.

If you run the above, you will see:

```
root@SDMN:/# dd if=/dev/urandom of=/dev/null bs=21M count=2
Killed
root@SDMN:/# dd if=/dev/urandom of=/dev/null bs=15M count=2
2+0 records in
2+0 records out
31457280 bytes (31 MB, 30 MiB) copied, 0.0669993 s, 470 MB/s
root@SDMN:/# 
```