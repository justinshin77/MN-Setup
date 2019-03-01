#!/bin/bash

sudo touch /var/swap.img

sudo chmod 600 /var/swap.img

sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000

mkswap /var/swap.img

sudo swapon /var/swap.img

sudo printf "/var/swap.img none swap sw 0 0" >> /etc/fstab

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get dist-upgrade -y

sudo apt-get install nano htop git -y

sudo apt-get install build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils software-properties-common -y

sudo apt-get install libboost-all-dev -y

sudo add-apt-repository ppa:bitcoin/bitcoin -y

sudo apt-get update -y

sudo apt-get install libdb4.8-dev libdb4.8++-dev -y

wget https://github.com/qbic-platform/qbic_v2.0/releases/download/v1.0/qbiccoin-Ubuntu-16.04x64.tar.gz

chmod -R 755 /root/qbiccoin-Ubuntu-16.04x64.tar.gz

tar xvzf /root/qbiccoin-Ubuntu-16.04x64.tar.gz

mkdir /root/qbiccoin

mkdir /root/.qbiccoin

cp /root/qbiccoind /root/qbiccoin

cp /root/qbiccoin-cli /root/qbiccoin

chmod -R 755 /root/qbiccoin

chmod -R 755 /root/.qbiccoin

sudo apt-get install -y pwgen

GEN_PASS=`pwgen -1 20 -n`

IP_ADD=`curl ipinfo.io/ip`

printf "%b\n rpcuser=qbiccoinrpc\nrpcpassword=${GEN_PASS}\nserver=1\nlisten=1\nmaxconnections=256\ndaemon=1\nrpcallowip=127.0.0.1\nexternalip=${IP_ADD}" > /root/.qbiccoin/qbiccoin.conf

cd /root/qbiccoin

./qbiccoind

sleep 10

masternodekey=$(./qbiccoin-cli masternode genkey)

./qbiccoin-cli stop

printf "%b\n masternode=1\nmasternodeprivkey=$masternodekey" >> /root/.qbiccoin/qbiccoin.conf

./qbiccoind -daemon

cd /root/.qbiccoin

printf "Masternode private key: $masternodekey"

printf "Welcome to the qbiccoin world"
