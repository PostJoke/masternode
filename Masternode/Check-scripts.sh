
#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
latestversion=$(curl --silent https://raw.githubusercontent.com/PostJoke/masternode/master/Masternode/Version | grep '"version":' | sed -E 's/.*"([^"]+)".*/\1/')
localversion=$(cat /usr/local/bin/Masternode/Version | grep '"version":' | sed -E 's/.*"([^"]+)".*/\1/')
if [ -z "$latestversion" ] || [ "$latestversion" == "$localversion" ]; then 
exit;
else
cd /usr/local/bin/Masternode
rm -f Update-scripts.sh
wget https://raw.githubusercontent.com/PostJoke/masternode/master/Masternode/Update-scripts.sh
bash Update-scripts.sh
fi
