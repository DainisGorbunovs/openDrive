#!/bin/bash
# Script mounts a BitLocker drive and unmounts

if mountpoint -q "/media/dis"; then
	echo "Unmounting drive"
	sudo bash << EOF
	umount "/media/dis"
	rmdir "/media/dis"
	umount "/mnt/dislck"
	rmdir "/mnt/dislck"
EOF
	echo "Drive unmounted"
else
	echo "Mounting drive"
	echo "Write BitLocker password for drive"
	read -s drivePw

	sudo bash << EOF
	if ! mountpoint -q "/mnt/dislck"; then
		if [ ! -d "/mnt/dislck" ]; then
			mkdir "/mnt/dislck"
		fi
		dislocker -v -V "/dev/sdc1" -u$drivePw -- "/mnt/dislck"
	fi
	if [ ! -d "/media/dis" ]; then
		mkdir "/media/dis"
	fi
	mount -o loop "/mnt/dislck/dislocker-file" "/media/dis"
EOF
	echo "Drive mounted"
fi