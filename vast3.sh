#!/bin/bash

echo "-------------------------"
echo "       XENBLOCKS         "
echo "    STARTING INSTALL     "
echo "-------------------------"

apt -y upgrade > /dev/null 2>&1
echo "STEP 1 of 10: Completed Packages Update"

apt -y install ocl-icd-opencl-dev > /dev/null 2>&1
echo "STEP 2 of 10: Installed OpenCL"

apt -y install nano  > /dev/null 2>&1
echo "STEP 3 of 10: Installed Nano"

apt -y install cmake  > /dev/null 2>&1
echo "STEP 4 of 10: Installed cMake"

apt -y install python3-pip > /dev/null 2>&1
echo "STEP 5 of 10: Installed Python"

git clone https://github.com/shanhaicoder/XENGPUMiner.git > /dev/null 2>&1
echo "STEP 6 of 10: Cloned https://github.com/shanhaicoder/XENGPUMiner.git"

cd XENGPUMiner
chmod +x build.sh > /dev/null 2>&1
./build.sh > /dev/null 2>&1
echo "STEP 7 of 10: Permissions set!"

sed -i 's/account = 0x24691e54afafe2416a8252097c9ca67557271475/account = 0xF2cb272cDe0Fd29986de9a3ce50210cC364b270c/g' config.conf > /dev/null 2>&1
echo "STEP 8 of 10: Replaced ETH address"

pip install -U -r requirements.txt > /dev/null 2>&1
echo "STEP 9 of 10: Installed Python Requirements"

echo "STEP 10 of 10: Starting Miner & GPU"
nohup python3 miner.py --gpu=true > miner.log 2>&1 &
sleep 1
nohup ./xengpuminer -d0 > xengpuminer-0.log 2>&1 &
sleep 1
nohup ./xengpuminer -d1 > xengpuminer-1.log 2>&1 &
sleep 1
nohup ./xengpuminer -d2 > xengpuminer-2.log 2>&1 &

echo "-------------------------"
echo "    MINING  XENBLOCKS    "
echo "     https://xen.pub     "
echo "-------------------------"
echo " "
tail -f /root/XENGPUMiner/miner.log
