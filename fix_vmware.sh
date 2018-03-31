#!/bin/bash

sudo sucd /tmp
cp /usr/lib/vmware/modules/source/vmmon.tar .
tar xf vmmon.tar
rm vmmon.tar
wget https://raw.githubusercontent.com/mkubecek/vmware-host-modules/fadedd9c8a4dd23f74da2b448572df95666dfe12/vmmon-only/linux/hostif.c
mv -f hostif.c vmmon-only/linux/hostif.c 
tar cf vmmon.tar vmmon-only
rm -fr vmmon-only
sudo mv -f vmmon.tar /usr/lib/vmware/modules/source/vmmon.tar 
sudo vmware-modconfig --console --install-all
