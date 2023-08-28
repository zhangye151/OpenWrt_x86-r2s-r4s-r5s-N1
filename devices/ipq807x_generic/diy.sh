#!/bin/bash
shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))

make defconfig
svn co https://github.com/coolsnowwolf/lede/trunk/package/qca package/qca
rm -rf  package/kernel/{qca-nss-dp,qca-ssdk}

sed -i 's/DEFAULT_PACKAGES +=/DEFAULT_PACKAGES += kmod-qca-nss-dp kmod-qca-nss-drv-64 kmod-qca-nss-drv-pppoe-64 kmod-qca-nss-ecm-64 kmod-qca-nss-drv-bridge-mgr-64 kmod-qca-nss-drv-vlan-mgr-64 nss-firmware-ipq8074/' target/linux/ipq807x/Makefile
sed -i "s/CONFIG_ALL_NONSHARED=y/CONFIG_ALL_NONSHARED=n/" .config
sed -i "s/CONFIG_ALL_KMODS=y/CONFIG_ALL_KMODS=n/" .config
make defconfig
sed -i "s/# CONFIG_ALL_NONSHARED is not set/CONFIG_ALL_NONSHARED=y/" .config
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0600-5.15-qca-nss-ecm-support-CORE.patch -o target/linux/ipq807x/patches-5.15/0600-5.15-qca-nss-ecm-support-CORE.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0601-5.15-netfilter-export-udp_get_timeouts-function.patch -o target/linux/ipq807x/patches-5.15/0601-5.15-netfilter-export-udp_get_timeouts-function.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0602-5.15-qca-add-pppoe-offload-support.patch -o target/linux/ipq807x/patches-5.15/0602-5.15-qca-add-pppoe-offload-support.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0605-5.15-qca-add-add-nss-bridge-mgr-support.patch -o target/linux/ipq807x/patches-5.15/0605-5.15-qca-add-add-nss-bridge-mgr-support.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0606-5.15-qca-nss-ecm-bonding-add-bond_get_id.patch -o target/linux/ipq807x/patches-5.15/0606-5.15-qca-nss-ecm-bonding-add-bond_get_id.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0607-5.15-qca-nss-ecm-Add-bridge-join-and-leave-netdev-cmds.patch -o target/linux/ipq807x/patches-5.15/0607-5.15-qca-nss-ecm-Add-bridge-join-and-leave-netdev-cmds.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0902-5.15-arm64-provide-dma-cache-routines-with-same-API-as-32.patch -o target/linux/ipq807x/patches-5.15/0902-5.15-arm64-provide-dma-cache-routines-with-same-API-as-32.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0903-5.15-arm64-mm-export-__dma_inv_area-and-__dma_clean_area.patch -o target/linux/ipq807x/patches-5.15/0903-5.15-arm64-mm-export-__dma_inv_area-and-__dma_clean_area.patch
curl -sfL https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/ipq807x/patches-5.15/0905-export-ns.patch -o target/linux/ipq807x/patches-5.15/0905-export-ns.patch

sed -i '/rm -rf $(KDIR)\/tmp/d' include/image.mk

rm -rf feeds/kiddin9/{rtl8821cu,rtl88x2bu} package/kernel/mt76 devices/common/patches/mt7922.patch
