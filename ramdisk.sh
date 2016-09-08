#!/bin/bash
sudo mkdir -p /media/ramdisk
sudo mount -t tmpfs -o size=8192M tmpfs /media/ramdisk/
