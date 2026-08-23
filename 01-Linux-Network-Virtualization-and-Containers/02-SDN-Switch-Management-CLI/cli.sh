#!/bin/bash

# Get the hostname and root filesystem path from command line arguments
hostname=$1
rootfs_path=$2
memory_limit_MB=$3

# Create the root filesystem directory if it doesn't exist
mkdir -p $rootfs_path

# Use debootstrap to install Ubuntu 20.04 filesystem into the container root filesystem
debootstrap --variant=minbase focal $rootfs_path

# Set memory limit if provided, otherwise don't limit the memory(limit the memory usage for the parent of my container)
if [ -n "$memory_limit_MB" ]; then
    echo "Memory limit set to $memory_limit_MB MB"
    mkdir -p /sys/fs/cgroup/memory/mycontainer
    echo $((memory_limit_MB * 1024 * 1024)) > /sys/fs/cgroup/memory/mycontainer/memory.limit_in_bytes
    echo $((memory_limit_MB * 1024 * 1024)) > /sys/fs/cgroup/memory/mycontainer/memory.memsw.limit_in_bytes
    echo $$ > /sys/fs/cgroup/memory/mycontainer/tasks
else
    echo "Memory limit not set, not limiting the memory"
fi

# Use unshare to create new namespaces for the container
unshare --uts --ipc --net --pid --mount --fork chroot $rootfs_path /bin/bash -c "
  mount -t proc proc /proc;
  hostname $hostname;
  exec bash"


# set limitation on container new filesystem
# unshare --uts --ipc --net --pid --mount --fork chroot $rootfs_path /bin/bash -c "
#   mount -t proc proc /proc;
#   hostname $hostname;
#   mkdir -p /sys/fs/cgroup/memory/mycontainer;
#   echo $((memory_limit_MB * 1024 * 1024)) > /sys/fs/cgroup/memory/mycontainer/memory.limit_in_bytes;
#   echo $((memory_limit_MB * 1024 * 1024)) > /sys/fs/cgroup/memory/mycontainer/memory.memsw.limit_in_bytes;
#   echo $$ > /sys/fs/cgroup/memory/mycontainer/tasks;
#   clear;
#   exec bash"