#!/bin/bash
mount -o remount,rw /
cd opt/nvram
curl -O -k https://raw.githubusercontent.com/unlock01020/G1/main/nvram.cfg
