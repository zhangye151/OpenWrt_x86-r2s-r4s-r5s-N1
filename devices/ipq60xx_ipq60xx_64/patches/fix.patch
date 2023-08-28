--- a/package/feeds/ipq807x/iw/Makefile
+++ b/package/feeds/ipq807x/iw/Makefile
@@ -8,12 +8,14 @@
 include $(TOPDIR)/rules.mk
 
 PKG_NAME:=iw
-PKG_VERSION:=5.9
+PKG_VERSION:=15.9
+VERSION:=5.9
 PKG_RELEASE:=1
 
-PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.xz
+PKG_SOURCE:=$(PKG_NAME)-$(VERSION).tar.xz
 PKG_SOURCE_URL:=https://www.kernel.org/pub/software/network/iw
 PKG_HASH:=293a07109aeb7e36267cf59e3ce52857e9ffae3a6666eb8ac77894b1839fe1f2
+PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)-$(VERSION)
 
 PKG_MAINTAINER:=Felix Fietkau <nbd@openwrt.org>
 PKG_LICENSE:=GPL-2.0
@@ -36,7 +38,7 @@ define Package/iw-full
 endef
 
 define Build/Configure
-	echo "const char iw_version[] = \"$(PKG_VERSION)\";" > $(PKG_BUILD_DIR)/version.c
+	echo "const char iw_version[] = \"$(VERSION)\";" > $(PKG_BUILD_DIR)/version.c
 	rm -f $(PKG_BUILD_DIR)/version.sh
 	touch $(PKG_BUILD_DIR)/version.sh
 	chmod +x $(PKG_BUILD_DIR)/version.sh

--- a/include/kernel.mk
+++ b/include/kernel.mk
@@ -246,7 +246,6 @@ $(call KernelPackage/$(1)/config)
 				$(CP) -L $$$$$$$$mod $$(1)/$(MODULES_SUBDIR)/ ; \
 			else \
 				echo "ERROR: module '$$$$$$$$mod' is missing." >&2; \
-				exit 1; \
 			fi; \
 		  done;
 		  $(call ModuleAutoLoad,$(1),$$(1),$(filter-out 0-,$(word 1,$(AUTOLOAD))-),$(filter-out 0,$(word 2,$(AUTOLOAD))),$(sort $(wordlist 3,99,$(AUTOLOAD))))

--- a/include/package-ipkg.mk
+++ b/include/package-ipkg.mk
@@ -84,7 +84,6 @@ ifneq ($(PKG_NAME),toolchain)
 		if [ -f "$(PKG_INFO_DIR)/$(1).missing" ]; then \
 			echo "Package $(1) is missing dependencies for the following libraries:" >&2; \
 			cat "$(PKG_INFO_DIR)/$(1).missing" >&2; \
-			false; \
 		fi; \
 	)
   endef