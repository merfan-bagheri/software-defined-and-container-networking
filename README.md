# 🌐 Software-Defined & Container Networking (SDMN)

[![CI](https://github.com/merfan-bagheri/software-defined-and-container-networking/actions/workflows/ci.yml/badge.svg)](https://github.com/merfan-bagheri/software-defined-and-container-networking/actions/workflows/ci.yml)
[![Linux](https://img.shields.io/badge/Linux-Kernel%20Networking-FCC624?logo=linux&logoColor=black)](https://www.kernel.org/)
[![Docker](https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Bash](https://img.shields.io/badge/Bash-Shell%20Scripting-4EAA25?logo=gnubash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/Python-HTTP%20Microservices-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

> **Author**: Muhammaderfan Bagherinejad ([GitHub](https://github.com/merfan-bagheri) • [LinkedIn](https://www.linkedin.com/in/merfan-bagheri))

---

## 📖 Overview

This repository explores low-level **Linux Kernel Networking, Network Virtualization, Software-Defined Routing, and Container Networking**. It implements practical architectures for isolated network namespaces (`netns`), virtual ethernet (`veth`) interconnects, Linux software bridging (`brctl`/`ip link`), inter-subnet routing gateways, and Dockerized microservices.

```mermaid
graph TD
    subgraph "Subnet A: 172.0.0.0/24"
        NS1["Namespace ns1\n172.0.0.2"] ---|veth1| BR1["Linux Bridge br0\n(Root Namespace)"]
        NS2["Namespace ns2\n172.0.0.3"] ---|veth2| BR1
    end

    subgraph "Routing Gateway"
        BR1 ---|veth-r1| ROUTER["Router Namespace\neth0: 172.0.0.1\neth1: 10.10.1.1"]
        ROUTER ---|veth-r2| BR2["Linux Bridge br1\n(Root Namespace)"]
    end

    subgraph "Subnet B: 10.10.1.0/24"
        BR2 ---|veth3| NS3["Namespace ns3\n10.10.1.2"]
        BR2 ---|veth4| NS4["Namespace ns4\n10.10.1.3"]
    end
```

---

## 📂 Repository Structure

```
01-Linux-Network-Virtualization-and-Containers/
├── 01-Network-Namespaces-and-Inter-Subnet-Routing/  # Network namespaces, veth pairs & routing
│   ├── Images/                                     # Architecture and topology diagrams
│   │   ├── pic_1.png
│   │   ├── pic_2.png
│   │   └── pic_3.png
│   ├── create_topology.sh                          # Automated namespace, bridge, and routing setup
│   ├── delete_topology.sh                          # Clean teardown script
│   ├── ping.sh                                     # Namespace-aware connectivity test script
│   └── README.md                                   # Theoretical & practical documentation
├── 02-SDN-Switch-Management-CLI/                   # Open vSwitch / SDN Controller CLI Interface
│   ├── cli.sh                                      # Command-line interface tool
│   └── README.md                                   # CLI documentation and command specifications
└── 03-Dockerized-HTTP-Microservice/                # Containerized Microservice & HTTP Server
    ├── Dockerfile                                  # Container build definition
    ├── HTTPServer.py                               # Python HTTP server handling network requests
    └── README.md                                   # Container setup, build, and execution guide
```

---

## 🚀 Key Modules & Capabilities

### 1. 🔌 Linux Network Namespaces & Virtual Routing ([`01-Network-Namespaces-and-Inter-Subnet-Routing`](01-Linux-Network-Virtualization-and-Containers/01-Network-Namespaces-and-Inter-Subnet-Routing/))
- **Automated Topology Generation**: Shell script initializing multi-subnet environments across isolated namespaces (`ns1`-`ns4` + `router`).
- **Bridge & Gateway Configuration**: Emulates hardware switches and Layer-3 routers using virtual ethernet pairs (`veth`) and kernel IP forwarding (`sysctl -w net.ipv4.ip_forward=1`).
- **Dynamic Ping Utility**: Test end-to-end connectivity across subnets via designated gateways.

### 2. 💻 SDN / Switch Management CLI ([`02-SDN-Switch-Management-CLI`](01-Linux-Network-Virtualization-and-Containers/02-SDN-Switch-Management-CLI/))
- Interactive CLI utility enabling dynamic query and manipulation of network flow tables, ports, and interface states.

### 3. 🐳 Dockerized Network Services ([`03-Dockerized-HTTP-Microservice`](01-Linux-Network-Virtualization-and-Containers/03-Dockerized-HTTP-Microservice/))
- Lightweight Python HTTP server deployed inside isolated Docker containers to simulate microservice endpoints and analyze container-to-container latency and packet flow.

---

## 🛠️ Quickstart Guide

### Prerequisites
- Linux OS (Ubuntu 20.04 / 22.04 LTS recommended)
- `iproute2`, `bridge-utils`, `iptables`, `docker`

### Setup Network Topology
```bash
cd 01-Linux-Network-Virtualization-and-Containers/01-Network-Namespaces-and-Inter-Subnet-Routing
chmod +x create_topology.sh delete_topology.sh ping.sh

# Build virtual network topology
sudo ./create_topology.sh

# Test ping between isolated namespaces
sudo ./ping.sh ns1 ns3

# Teardown topology
sudo ./delete_topology.sh
```

### Run Dockerized Service
```bash
cd 01-Linux-Network-Virtualization-and-Containers/03-Dockerized-HTTP-Microservice
docker build -t sdmn-http-server .
docker run -d -p 8080:8080 --name sdmn-service sdmn-http-server
curl http://localhost:8080
```

---

## 📜 License
Distributed under the [MIT License](LICENSE).
