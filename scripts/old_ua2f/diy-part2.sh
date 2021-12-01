#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.100.1/g' package/base-files/files/bin/config_generate

# 取消bootstrap为默认主题
#sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
# 修改默认主题为argon_new
#sed -i 's/luci-theme-bootstrap/luci-theme-argon_new/g' ./feeds/luci/collections/luci/Makefile

# 固件版本栏自定义用户名
sed -i "s/Openwrt /passenger compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ Openwrt /g" $ZZZ

# 清除登录密码
sed -i  's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g'  openwrt/package/lean/default-settings/files/zzz-default-settings

# UA2F内核配置加入CONFIG_NETFILTER_NETLINK_GLUE_CT
target=$(grep "^CONFIG_TARGET" .config --max-count=1 | awk -F "=" '{print $1}' | awk -F "_" '{print $3}')
for configFile in $(ls target/linux/$target/config*)
do
    echo -e "\nCONFIG_NETFILTER_NETLINK_GLUE_CT=y" >> $configFile
done
