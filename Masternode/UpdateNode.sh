#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root
LOGFILE='/usr/local/bin/Masternode/update.log'
dt=`date '+%d/%m/%Y %H:%M:%S'`
latestrelease=$(curl --silent https://api.github.com/repos/CommerciumBlockchain/CommerciumContinuum/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
localrelease=$(commercium-cli -version | awk -F' ' '{print $NF}' | cut -d "-" -f1)
if [ -z "$latestrelease" ] || [ "$latestrelease" == "$localrelease" ]; then 
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: There is no New Update latest release is $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
exit;
else
echo >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
echo "[$dt]==> Info: Starting Update 3DCoin core to $latestrelease" >> $LOGFILE
echo "[$dt]    ==============================================================" >> $LOGFILE
cd ~
localfile=${localrelease//[Vv]/CommerciumContinuum-}
echo "[$dt]==> Info: Remove file $localfile" >> $LOGFILE
rm -rf $localfile
link="https://github.com/CommerciumBlockchain/CommerciumContinuum/archive/$latestrelease.tar.gz"
echo "[$dt]==> Info: Download Last Update $link" >> $LOGFILE
wget $link  || { echo "[$dt]==> Error: When Download $link" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Extract $latestrelease.tar.gz" >> $LOGFILE
tar -xvzf $latestrelease.tar.gz || { echo "[$dt]==> Error: When Extracting $latestrelease.tar.gz" >> $LOGFILE && exit;  }
file=${latestrelease//[Vv]/Commercium-Continuum-}
cd $file  || { echo "[$dt]==> Error: File $file not found" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Start Compiling Commercium core $latestrelease" >> $LOGFILE
./zcutil/fetch-params.sh  || { echo "[$dt]==> Error: When Compiling Commerciumn core" >> $LOGFILE && exit;  }
echo "[$dt]==> Info: Stop Commercium core $localrelease" >> $LOGFILE
commercium-cli stop
sleep 10
echo "[$dt]==> Info: Make install            " >> $LOGFILE
./zcutil/build.sh || { echo "[$dt]==> Error: When make install" >> $LOGFILE && exit && commerciumd;  }
cd ~
cp $file/src/commerciumd /usr/local/bin
cp $file/src/commercium-cli /usr/local/bin
cp $file/src/commercium-tx /usr/local/bin
cp $file/src/commercium-gtest /usr/local/bin
echo "[$dt]==> Info: Remove $latestrelease.tar.gz" >> $LOGFILE
rm $latestrelease.tar.gz
echo "[$dt]==> Info: Remove $file" >> $LOGFILE
rm -rf $file
echo "[$dt]==> Info: Rebooting " >> $LOGFILE 
echo "[$dt]    ==============================================================" >> $LOGFILE
reboot
fi
