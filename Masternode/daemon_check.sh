#!/bin/bash
HOME=/root
LOGNAME=root
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
LANG=en_US.UTF-8
SHELL=/bin/sh
PWD=/root

previousBlock=$(cat /usr/local/bin/Masternode/blockcount)
currentBlock=$(commercium-cli getblockcount)

commercium-cli getblockcount > /usr/local/bin/Masternode/blockcount

if [ "$previousBlock" == "$currentBlock" ]; then
  commercium-cli stop
  sleep 60
  rm -f /root/.Commercium/banlist.dat
  rm -f /root/.Commercium/mncache.dat
  rm -f /root/.Commercium/mnpayments.dat
  rm -f /root/.Commercium/netfulfilled.dat
  rm -f /root/.Commercium/debug.log
  commerciumd -reindex
fi
