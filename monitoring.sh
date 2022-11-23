#!bin/bash
archi=$(uname -a)
phycpu=$(lscpu | grep "Socket" | cut -d " " -f 24)
vcpu=$(lscpu | grep "CPU(s)" | head -n 1 | cut -d " " -f 27)
tram=$(free -m | grep Mem | awk '{print $2}')
uram=$(free -m | grep Mem | awk '{print $3}')
pram=$(free -m | grep Mem | awk '{printf("%.2f", $3/$2*100)}')
tdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{td+=$2} END {print td}')
udisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ud+=$3} END {print ud}')
pdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{td+=$2} {ud+=$3} END {printf("%d", ud/td*100)}')
pcpu=$(uptime | awk '{printf("%.1f%%", $(NF-2))}')
lb=$(who -b | cut -d " " -f 13-14)
lvma=$(lsblk | grep "lvm" | wc -l)
lvms=$(if [ $lvma -eq 0 ]; then echo 'no'; else echo 'yes'; fi)
#install net-tools
acnt=$(cat /proc/net/sockstat{,6} | grep "TCP:" | cut -d " " -f 3)
ausr=$(users | wc -l)
ip=$(hostname -I)
mac=$(ip link show | awk '$1 == "link/ether" {print $2}')
nsudo=$(journalctl | grep sudo | grep COMMAND | wc -l)
wall "#Architecture: $archi
#CPU physical : $phycpu
#vCPU : $vcpu
#Memory Usage: $uram/${tram}Mb ($pram%)     
#Disk Usage: $udisk/${tdisk}Gb ($pdisk%)            
#CPU load: $pcpu
#Last boot: $lb
#LVM use: $lvms
#Connections TCP : $acnt ESTABLISHED
#User log: $ausr
#Network: IP $ip($mac)
#Sudo : $nsudo cmd"
