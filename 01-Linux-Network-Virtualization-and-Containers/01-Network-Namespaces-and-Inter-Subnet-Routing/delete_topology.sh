#!/bin/bash

# Delete Network Namespaces
sudo ip netns del ns1
sudo ip netns del ns2
sudo ip netns del ns3
sudo ip netns del ns4
sudo ip netns del router

# Delete Virtual Ethernet Pairs
sudo ip link del node1
sudo ip link del node2
sudo ip link del node3
sudo ip link del node4
sudo ip link del node1br1
sudo ip link del node2br1
sudo ip link del node3br2
sudo ip link del node4br2
sudo ip link del h1r1
sudo ip link del h2r2

# Delete Bridges
sudo ip link del br1
sudo ip link del br2
sudo ip link del r1