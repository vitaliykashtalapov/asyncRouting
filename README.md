i build it for FreshTomato ver. 2024.1 (linux kernel 2.6) but should work on every linux-based device 'cos using standart packages from busy box (except "noising" for confuse listening equipment, for noising you should install nping from, for example, entware)

how i start this (with shell script on startup):
mkdir /mnt/systo1
mkdir /mnt/FirstStorage
mkdir /mnt/bckp
echo "UUID=ed3ef3cb-5af3-4b10-9ebf-127f3e866d19 /opt ext4 rw, noatime 0 2" >> /etc/fstab
echo "UUID=439d1e21-e872-48be-9fc9-37b275ef3d98 /mnt/systo1 ext4 rw, noatime 1 2" >> /etc/fstab
echo "UUID=ce11f2c2-a2a2-4cb9-bdc6-ce73ce92935d /mnt/FirstStorage ext4 rw, noatime 1 2" >> /etc/fstab
echo "UUID=1155ebe0-1957-4489-9e1f-31c62f361add /mnt/bckp ext4 rw, noatime 1 2" >> /etc/fstab
sleep 5
mount /opt
mount /mnt/systo1
mount /mnt/FirstStorage
sleep 20
service mysql start
sh /mnt/systo1/scripts/routing/upAsymRouteWG.sh >> /mnt/systo1/logs/routing/upAsymRouteWG.log


...actually not sure this is interesting for someone, if so, just give me know by pressing star and i'll give more detailed instruction
