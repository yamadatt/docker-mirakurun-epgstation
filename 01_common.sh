#!/bin/bash
timedatectl
sudo apt update && sudo apt upgrade -y
mkdir ~/git
sudo apt install -y dkms git curl samba vim

# docker install
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
docker --version
sudo usermod -aG docker $USER

# docker-compose install
sudo curl -L "https://github.com/docker/compose/releases/download/v2.17.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v


# cardドライバのインストール
sudo apt install -y libpcsclite-dev pcscd pcsc-tools libccid
pcsc_scan 

# 不要サービスの停止
sudo systemctl stop pcscd.socket
sudo systemctl disable pcscd.socket
sudo systemctl status pcscd.socket

# チューナーのインストール
cd ~/git
git clone https://github.com/nns779/px4_drv
cd px4_drv/fwtool/
make
wget http://plex-net.co.jp/plex/pxw3u4/pxw3u4_BDA_ver1x64.zip -O pxw3u4_BDA_ver1x64.zip
unzip -oj pxw3u4_BDA_ver1x64.zip pxw3u4_BDA_ver1x64/PXW3U4.sys
./fwtool PXW3U4.sys it930x-firmware.bin
sudo mkdir -p /lib/firmware
sudo cp it930x-firmware.bin /lib/firmware/
cd ../
sudo cp -a ./ /usr/src/px4_drv-0.2.1
sudo dkms add px4_drv/0.2.1
sudo dkms install px4_drv/0.2.1

lsmod | grep -e ^px4_drv

read -p "ドライバがインストールされました。enterキーを押すとリブートします。"
sudo reboot

