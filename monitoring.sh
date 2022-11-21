#!bin/bash
archi=$(uname -a)
pcpu=$(lscpu | grep "Socket" | cut -d " " -d 24)
vcpu=$(lscpu | grep "CPU(s)" | head -n 1 | cut -d " " -f 27)
tram=$(free -m | grep Mem | awk '{print $2}')
uram=$(free -m | grep Mem | awk '{print $3}')
pram=$(free -m | grep Mem | awk '{printf("%.2f", $3/$2*100)}')
