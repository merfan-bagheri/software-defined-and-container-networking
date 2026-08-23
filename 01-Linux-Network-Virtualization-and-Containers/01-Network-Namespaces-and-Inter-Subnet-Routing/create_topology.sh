# Create Network Namespaces
sudo ip netns add ns1
sudo ip netns add ns2
sudo ip netns add router
sudo ip netns add ns3
sudo ip netns add ns4

# Create Virtual Ethernet Pairs
sudo ip link add node1 type veth peer name node1br1
sudo ip link add node2 type veth peer name node2br1
sudo ip link add node3 type veth peer name node3br2
sudo ip link add node4 type veth peer name node4br2
sudo ip link add r1 type veth peer name br1r1
sudo ip link add r2 type veth peer name br2r2

# Bring Up Network Interfaces
sudo ip link set node1 up
sudo ip link set node2 up
sudo ip link set node3 up
sudo ip link set node4 up
sudo ip link set node1br1 up
sudo ip link set node2br1 up
sudo ip link set node3br2 up
sudo ip link set node4br2 up

sudo ip link set r1 up
sudo ip link set r2 up
sudo ip link set br1r1 up
sudo ip link set br2r2 up

# Move Virtual Ethernet Devices to Namespaces
sudo ip link set node1 netns ns1
sudo ip link set node2 netns ns2
sudo ip link set node3 netns ns3
sudo ip link set node4 netns ns4

sudo ip link set r1 netns router
sudo ip link set r2 netns router

# Set Up Interfaces within Namespaces
sudo ip netns exec ns1 ip link set node1 up
sudo ip netns exec ns2 ip link set node2 up
sudo ip netns exec ns3 ip link set node3 up
sudo ip netns exec ns4 ip link set node4 up

sudo ip netns exec router ip link set r1 up
sudo ip netns exec router ip link set r2 up

# Assign IP Addresses to Interfaces
sudo ip netns exec ns1 ip addr add 172.0.0.2/24 dev node1
sudo ip netns exec ns2 ip addr add 172.0.0.3/24 dev node2
sudo ip netns exec ns3 ip addr add 10.10.0.2/24 dev node3
sudo ip netns exec ns4 ip addr add 10.10.0.3/24 dev node4

sudo ip netns exec router ip addr add 172.0.0.1/24 dev r1
sudo ip netns exec router ip addr add 10.10.0.1/24 dev r2

sudo ip netns exec ns1 ip route add default via 172.0.0.1
sudo ip netns exec ns2 ip route add default via 172.0.0.1
sudo ip netns exec ns3 ip route add default via 10.10.0.1
sudo ip netns exec ns4 ip route add default via 10.10.0.1

# Create and Configure a Bridge
sudo ip link add br1 type bridge
sudo ip link set br1 up
sudo ip link add br2 type bridge
sudo ip link set br2 up

sudo ip link set node1br1 master br1
sudo ip link set node2br1 master br1
sudo ip link set node3br2 master br2
sudo ip link set node4br2 master br2

sudo ip link set br1r1 master br1
sudo ip link set br2r2 master br2

sudo ip netns exec router sysctl -w net.ipv4.ip_forward=1

# Test Connectivity
sudo ip netns exec ns1 ping -c3 10.10.0.2
sudo ip netns exec ns1 ping -c3 10.10.0.3
sudo ip netns exec ns1 ping -c3 172.0.0.3
sudo ip netns exec ns4 ping -c3 10.10.0.2
sudo ip netns exec ns4 ping -c3 172.0.0.2
sudo ip netns exec ns4 ping -c3 172.0.0.3

