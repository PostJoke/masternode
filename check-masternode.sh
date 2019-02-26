#!/bin/bash
RED='\033[0;97;41m'
STD='\033[0;0;39m'
GREEN='\e[1;97;42m'
BLUE='\e[1;97;44m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
LOG='Masternodes-check.log'

function valid_ip()
{
    local  ip=$1
    local  stat=1

    if [[ $ip =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        OIFS=$IFS
        IFS='.'
        ip=($ip)
        IFS=$OIFS
        [[ ${ip[0]} -le 255 && ${ip[1]} -le 255 \
            && ${ip[2]} -le 255 && ${ip[3]} -le 255 ]]
        stat=$?
    fi
    return $stat
}

clear
echo "" 
echo  -e "${BLUE} C H E C K  C O M M E R C I U M  M A S T E R N O D E S ${STD}"
echo "" 
read -p "Same SSH Port and Password for all vps's? (Y/N)" -n 1 -r
echo ""   # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]; then
sleep 2
echo  -e "Please enter your vps ip's: ${RED}( Exemple: 111.111.111.111-222.222.222.222-... )${STD}"

unset ip
while [ -z ${ip} ]; do
read -p "IP HERE: " ip
done

unset port
while [ -z ${port} ]; do
read -p "SSH PORT: " port
done

unset rootpass
while [ -z ${rootpass} ]; do
read -s -p "PASSWORD: " rootpass
done

vpsip=$(echo $ip | tr "-" " ")
echo > $LOG
for i in $vpsip
do
if valid_ip $i; 
then 
dt=`date '+%d/%m/%Y %H:%M:%S'`
echo ""   # (optional) move to a new line
echo ""   # (optional) move to a new line
echo  -e "${GREEN} Connexion Vps ip $i ${STD}\n" 
echo  -e "${RED} Commercium Core Vps ip $i Data          ${STD}"
sshpass -p $rootpass ssh -p$port -o StrictHostKeyChecking=no root@$i "
printf '${YELLOW}Commercium Core Last Block: ${NC}'
commercium-cli getblockcount  || { echo 'Commercium core not running'; }
printf '${YELLOW}Commercium Core RPC client version: ${NC}' 
commercium-cli -version | awk -F'"' '"' '"'{print $NF}'"' | cut -d '-' -f1
printf '${RED} ------------------------------------------------ ${STD}\n' 
echo '' 
sleep 2
exit;"

sshpass -p $rootpass ssh -p$port -o StrictHostKeyChecking=no root@$i "
echo '[$dt]    ==============================================================' 
echo '[$dt]==> Info: Vps ip: $i                                              '
echo '[$dt]    =============================================================='
printf '[$dt]==> Info: Commercium Core Last Block: $blook'; commercium-cli getblockcount || { echo 'Commercium core not running';  }
printf '[$dt]==> Info: Commercium Core RPC client version: '; commercium-cli -version | awk -F'"' '"' '"'{print $NF}'"' | cut -d '-' -f1
echo '[$dt]    =============================================================='
echo '' 
sleep 2
exit;" >> $LOG || { echo "[$dt]==> Error: VPS IP $i connexion failed" >> $LOG && echo " " >> $LOG;  }

else 
echo "" 
echo "" 
echo -e "${RED} $i invalid IP ................... ${STD}"
fi

done
elif [[ $REPLY =~ ^[Nn]$ ]]; then

sleep 2
echo  -e "Please enter your vps's data: 'Host:Password:SSHPort' ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22-222.222.222.222:Wz65D232Fty:165-... )${STD}"

unset ip
while [ -z ${ip} ]; do
read -p "DATA HERE: " ip
done

data=$(echo $ip | tr "-" " ")
echo > $LOG
for i in $data
do
vpsdata=$(echo $i | tr ":" "\n")
declare -a array=($vpsdata)
host=${array[0]}
pass=${array[1]}
port=${array[2]}
if [ -z "$pass" ] || [ -z "$port" ] || [ -z "$host" ]
then
echo -e "Please enter a correct vps's data ${RED}( Exemple: 111.111.111.111:ERdX5h64dSer:22 222.222.222.222:Wz65D232Fty:165 ... )${STD}"
else
dt=`date '+%d/%m/%Y %H:%M:%S'`
echo  ""  # (optional) move to a new line
echo  ""  # (optional) move to a new line
echo  -e "${GREEN} Connexion Vps ip $host ${STD}\n" 
echo  -e "${RED} Commercium Core Vps ip $host Data          ${STD}"
sshpass -p $pass ssh -p$port -o StrictHostKeyChecking=no root@$host "
printf '${YELLOW} Commercium Core Last Block: ${NC}'
commercium-cli getblockcount  || { echo 'Commercium core not running'; }
printf '${YELLOW} Commercium Core RPC client version: ${NC}' 
commercium-cli -version | awk -F'"' '"' '"'{print $NF}'"' | cut -d '-' -f1
printf '${RED} ------------------------------------------------ ${STD}\n' 
echo '' 
sleep 2
exit;"

sshpass -p $pass ssh -p$port -o StrictHostKeyChecking=no root@$host "
echo '[$dt]    ==============================================================' 
echo '[$dt]==> Info: Vps ip: $host                                              '
echo '[$dt]    =============================================================='
printf '[$dt]==> Info: Commercium Core Last Block: $blook'; commercium-cli getblockcount || { echo 'Commercium core not running';  }
printf '[$dt]==> Info: Commercium Core RPC client version: '; commercium-cli -version | awk -F'"' '"' '"'{print $NF}'"' | cut -d '-' -f1
echo '[$dt]    =============================================================='
echo '' 
sleep 2
exit;" >> $LOG || { echo "[$dt]==> Error: VPS IP $host connexion failed" >> $LOG && echo " " >> $LOG;  }
fi
done
else
exit;
fi
