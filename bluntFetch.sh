#!/bin/bash

#
#	bluntFetch version 1.0
#		Authored by: blunt4286
#		Dependencies:
#				- lolcat, lspci (maybe?)
#		MIT License
#		Copyright (c) 2024 blunt4286 (https://github.com/blunt4286)
#		Full text of MIT License available in License.txt

# ASCII logo (choose your own)
logo="                                  
▗▖   █ █  ▐▌▄▄▄▄     ■  ▗▄▄▄▖▗▞▀▚▖   ■  ▗▞▀▘▐▌   
▐▌   █ ▀▄▄▞▘█   █ ▗▄▟▙▄▖▐▌   ▐▛▀▀▘▗▄▟▙▄▖▝▚▄▖▐▌   
▐▛▀▚▖█      █   █   ▐▌  ▐▛▀▀▘▝▚▄▄▖  ▐▌      ▐▛▀▚▖
▐▙▄▞▘█              ▐▌  ▐▌          ▐▌      ▐▌ ▐▌
                    ▐▌              ▐▌
"

# OS Info
user=$(whoami)
sysName=$(uname -a | awk '{print $2}')
os=$(hostnamectl | grep "Operating System" | awk -F ': ' '{print $2}')
kernel=$(uname -r)
shell=$(basename "$SHELL")
term=$(echo $TERM | awk -F'-' '{print $2}')
mem=$(free -m | awk '/Mem/ {print $3 " / " $2 " MB"}')
memUsed=$(free -m | awk '/Mem/ {print $3}')
memTotal=$(free -m | awk '/Mem/ {print $2}')
memPercentUsed=$((memUsed * 100 / memTotal))
cpu_name=$(lscpu | grep "Model name" | awk -F': ' '{print $2}' | sed 's/^ *//;s/ *$//')
cpu_freq=$(lscpu | grep "CPU max MHz" | awk -F': ' '{printf " %.1f GHz", $2/1000}')
gpu=$(lspci | grep -i "vga" | awk '{print $12 $13 $14 $15}' | sed 's/\([a-zA-Z]\)\([0-9]\)/\1 \2/g' | sed 's/[[]//g; s/[]]//g')
init=$(ps -p 1 -o comm=)
dewm=$(echo $DESKTOP_SESSION)
uptime=$(uptime -p | awk '{print $2 " " $3 " " $4 " " $5}')
root_space=$(df -h / | awk 'NR==2 {print $3 " / " $2 }')
# Loop for detecting all mounted drives excluding tmpfs, boot, efi
# drives=$(df -h | grep -Ev 'tmpfs|boot|efi' | awk '{print $3 " - " $2 " / " $4}')


# Display Info
clear

# ASCII logo
echo "$logo" | lolcat

# cowsay "...and those who tasted the bite of his sword named him... the DOOMSLAYER" | lolcat

# Info in a column next to the logo
# echo "=====================================================" | lolcat
echo -en "\033[1m$user\033[0m" | lolcat
echo -n "@"
echo -e "\033[1m$sysName\033[0m" | lolcat
echo "--------------"
echo -en "\033[1mos\033[0m        : " | lolcat
echo -n $os
	if [ "$os" = "Arch Linux" ]; then
		echo -e "\033[1m btw...\033[0m" | lolcat
	fi
echo -en "\033[1mlx\033[0m        : " | lolcat
echo $kernel
echo -en "\033[1msh\033[0m        : " | lolcat
echo $shell
echo -en "\033[1mterm\033[0m      : " | lolcat
echo $term
echo -en "\033[1mmem\033[0m       : " | lolcat
echo -en "$mem "
echo -e "(\033[1m$memPercentUsed%\033[0m)" | lolcat 
echo -en "\033[1mcpu\033[0m       : " | lolcat
echo -n $cpu_name
echo -n " @ " | lolcat
echo $cpu_freq 
echo -en "\033[1mgpu\033[0m       : " | lolcat
echo $gpu
echo -en "\033[1minit\033[0m      : " | lolcat
echo -n $init
	if [ "$init" = "systemd" ]; then
    		echo " (his name is Len-(len)-Lennart...)" | lolcat
	fi
echo -en "\033[1mde/wm\033[0m     : " | lolcat
echo $dewm
echo -en "\033[1mup\033[0m        : " | lolcat
echo $uptime
echo -en "\033[1mroot\033[0m      : " | lolcat
echo $root_space


# Display drive info
#    echo "/         : $root_space"
# while IFS= read -r line; do
#
#    echo "Drive     : $line"
# done <<< "$drives"

# End the script
echo ""

