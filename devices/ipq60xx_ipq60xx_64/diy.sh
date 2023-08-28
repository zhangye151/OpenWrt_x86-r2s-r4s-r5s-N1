#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

rm -rf target/linux/feeds
mv -f ipq807x_v5.4/ipq60xx target/linux/ipq60xx

rm -rf package/feeds
./scripts/feeds install -a -p ipq807x -f
./scripts/feeds install -a -p kiddin9 -f
./scripts/feeds install -a

sed -i "/CONFIG_KERNEL_/d" .config

#sed -i "/KernelPackage,ipt-nat6/d" package/feeds/ipq807x/linux/modules/netfilter.mk

echo "
CONFIG_FEED_ipq807x=n
" >> .config

 rm -rf devices/common/patches/mt7922.patch

sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/feeds/ipq807x/hostapd/Makefile
sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/network/config/netifd/Makefile
sed -i "s/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2099-12-06/" package/system/procd/Makefile
sed -i "s/ath5k ath6kl ath6kl-sdio ath6kl-usb ath9k ath9k-common ath9k-htc ath10k //" package/feeds/ipq807x/mac80211/ath.mk

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += wireless-regdb ethtool kmod-sched-cake wpad-openssl/' target/linux/ipq60xx/Makefile

sed -i "/KernelPackage,crypto-aead/d" package/kernel/linux/modules/crypto.mk
sed -i "/KernelPackage,fs-xfs/d" package/kernel/linux/modules/fs.mk
sed -i "/KernelPackage,br-netfilter/d" package/kernel/linux/modules/netfilter.mk
sed -i "/KernelPackage,switch-ar8xxx/d" package/kernel/linux/modules/netdevices.mk

#rm -rf feeds/kiddin9/{rtl*,base-files,fullconenat-nft,mbedtls,oaf,wireguard,fullconenat}
rm -rf feeds/kiddin9/{base-files,fullconenat-nft,oaf,rkp-ipid,shortcut-fe} package/feeds/packages/{v4l2loopback,ovpn-dco,libpfring} package/kernel/{nat46,ath10k-ct,button-hotplug} package/feeds/ipq807x/{wireguard,batman-adv} package/kernel/mt76
rm -rf package/feeds/ipq807x/qca-diag
sed -i "s/SUBTARGET:=generic/SUBTARGET:=ipq60xx_64/" target/linux/ipq60xx/generic/target.mk

mv -f target/linux/ipq60xx/generic target/linux/ipq60xx/ipq60xx_64

sed -i "s/SUBTARGETS:=generic /SUBTARGETS:=ipq60xx_64 /" target/linux/ipq60xx/Makefile

