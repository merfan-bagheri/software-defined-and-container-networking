#!/bin/bash

# Check if the script was called with two arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <arg1> <arg2> <num>"
    exit 1
fi

arg1=$1
arg2=$2
num=$3

echo "$arg1 pinging $num times $arg2"

if [ "$arg1" == "node1" ]; then
    ns="ns1"
elif [ "$arg1" == "node2" ]; then
    ns="ns2"
elif [ "$arg1" == "node3" ]; then
    ns="ns3"
elif [ "$arg1" == "node4" ]; then
    ns="ns4"
else
    ns="router"
fi

if [ "$arg2" == "node1" ]; then
    dest="172.0.0.2"
elif [ "$arg2" == "node2" ]; then
    dest="172.0.0.3"
elif [ "$arg2" == "node3" ]; then
    dest="10.10.0.2"
elif [ "$arg2" == "node4" ]; then
    dest="10.10.0.3"
else
    dest="10.10.0.1"
fi


ip netns exec $ns ping -c$num $dest 
