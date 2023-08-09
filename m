Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11B9774FFB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Aug 2023 02:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjHIAoz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 20:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjHIAoz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 20:44:55 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 738F51BC1
        for <linux-pci@vger.kernel.org>; Tue,  8 Aug 2023 17:44:49 -0700 (PDT)
Received: (qmail 178269 invoked by uid 1000); 8 Aug 2023 20:44:48 -0400
Date:   Tue, 8 Aug 2023 20:44:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     USB mailing list <linux-usb@vger.kernel.org>,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH] Fix nomenclature for USB and PCI wireless devices
Message-ID: <57da7c80-0e48-41b5-8427-884a02648f55@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A mouse that uses a USB connection is called a "USB mouse" device (or
"USB mouse" for short), not a "mouse USB" device.  By analogy, a WiFi
adapter that connects to the host computer via USB is a "USB wireless"
device, not a "wireless USB" device.  (The latter term more properly
refers to a defunct Wireless USB specification, which described a
technology for sending USB protocol messages over an ultra wideband
radio link.)

Similarly for a WiFi adapter card that plugs into a PCIe slot: It is a
"PCIe wireless" device, not a "wireless PCIe" device.

Rephrase the text in the kernel source where the word ordering is
wrong.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

 drivers/net/wireless/ath/ath10k/pci.c               |    2 
 drivers/net/wireless/ath/ath10k/usb.c               |    2 
 drivers/net/wireless/ath/ath11k/pci.c               |    2 
 drivers/net/wireless/ath/ath12k/pci.c               |    2 
 drivers/net/wireless/atmel/at76c50x-usb.c           |    8 +--
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c |   12 ++---
 drivers/net/wireless/legacy/rndis_wlan.c            |    2 
 drivers/net/wireless/mediatek/mt76/mt7603/Kconfig   |    2 
 drivers/net/wireless/mediatek/mt76/mt7615/Kconfig   |    2 
 drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig   |    4 -
 drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig   |    4 -
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig   |    2 
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig   |    2 
 drivers/net/wireless/mediatek/mt7601u/Kconfig       |    2 
 drivers/net/wireless/purelifi/plfxlc/Kconfig        |    2 
 drivers/net/wireless/ralink/rt2x00/Kconfig          |    2 
 drivers/net/wireless/realtek/rtw88/pci.c            |    2 
 drivers/net/wireless/realtek/rtw88/usb.c            |    2 
 drivers/net/wireless/realtek/rtw89/pci.c            |    2 
 drivers/net/wireless/zydas/zd1201.c                 |    6 +-
 drivers/platform/x86/eeepc-laptop.c                 |    2 
 drivers/staging/wlan-ng/prism2usb.c                 |   48 ++++++++++----------
 22 files changed, 57 insertions(+), 57 deletions(-)

Index: usb-devel/drivers/net/wireless/ath/ath10k/usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath10k/usb.c
+++ usb-devel/drivers/net/wireless/ath/ath10k/usb.c
@@ -1126,5 +1126,5 @@ static struct usb_driver ath10k_usb_driv
 module_usb_driver(ath10k_usb_driver);
 
 MODULE_AUTHOR("Atheros Communications, Inc.");
-MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN USB devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Atheros USB 802.11ac WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
Index: usb-devel/drivers/net/wireless/atmel/at76c50x-usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/atmel/at76c50x-usb.c
+++ usb-devel/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -10,7 +10,7 @@
  * Copyright (c) 2007 Kalle Valo <kalle.valo@iki.fi>
  * Copyright (c) 2010 Sebastian Smolorz <sesmo@gmx.net>
  *
- * This file is part of the Berlios driver for WLAN USB devices based on the
+ * This file is part of the Berlios driver for USB WLAN devices based on the
  * Atmel AT76C503A/505/505A.
  *
  * Some iw_handler code was taken from airo.c, (C) 1999 Benjamin Reed
@@ -143,7 +143,7 @@ static const struct usb_device_id dev_ta
 	{ USB_DEVICE(0x0cde, 0x0001), USB_DEVICE_DATA(BOARD_503_ISL3861) },
 	/* Dynalink/Askey WLL013 (intersil) */
 	{ USB_DEVICE(0x069a, 0x0320), USB_DEVICE_DATA(BOARD_503_ISL3861) },
-	/* EZ connect 11Mpbs Wireless USB Adapter SMC2662W v1 */
+	/* EZ connect 11Mpbs USB Wireless Adapter SMC2662W v1 */
 	{ USB_DEVICE(0x0d5c, 0xa001), USB_DEVICE_DATA(BOARD_503_ISL3861) },
 	/* BenQ AWL300 */
 	{ USB_DEVICE(0x04a5, 0x9000), USB_DEVICE_DATA(BOARD_503_ISL3861) },
@@ -195,7 +195,7 @@ static const struct usb_device_id dev_ta
 	{ USB_DEVICE(0x04a5, 0x9001), USB_DEVICE_DATA(BOARD_503) },
 	/* 3Com 3CRSHEW696 */
 	{ USB_DEVICE(0x0506, 0x0a01), USB_DEVICE_DATA(BOARD_503) },
-	/* Siemens Santis ADSL WLAN USB adapter WLL 013 */
+	/* Siemens Santis ADSL USB WLAN adapter WLL 013 */
 	{ USB_DEVICE(0x0681, 0x001b), USB_DEVICE_DATA(BOARD_503) },
 	/* Belkin F5D6050, version 2 */
 	{ USB_DEVICE(0x050d, 0x0050), USB_DEVICE_DATA(BOARD_503) },
@@ -238,7 +238,7 @@ static const struct usb_device_id dev_ta
 	{ USB_DEVICE(0x1915, 0x2233), USB_DEVICE_DATA(BOARD_505_2958) },
 	/* Xterasys XN-2122B, IBlitzz BWU613B/BWU613SB */
 	{ USB_DEVICE(0x12fd, 0x1001), USB_DEVICE_DATA(BOARD_505_2958) },
-	/* Corega WLAN USB Stick 11 */
+	/* Corega USB WLAN Stick 11 */
 	{ USB_DEVICE(0x07aa, 0x7613), USB_DEVICE_DATA(BOARD_505_2958) },
 	/* Microstar MSI Box MS6978 */
 	{ USB_DEVICE(0x0db0, 0x1020), USB_DEVICE_DATA(BOARD_505_2958) },
Index: usb-devel/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
+++ usb-devel/drivers/net/wireless/intersil/orinoco/orinoco_usb.c
@@ -129,18 +129,18 @@ MODULE_FIRMWARE("orinoco_ezusb_fw");
 
 #define USB_AVAYA8_VENDOR_ID     0x0D98
 #define USB_AVAYAE_VENDOR_ID     0x0D9E
-#define USB_AVAYA_WIRELESS_ID    0x0300 /* Avaya Wireless USB Card */
+#define USB_AVAYA_WIRELESS_ID    0x0300 /* Avaya USB Wireless Card */
 
 #define USB_AGERE_VENDOR_ID      0x0D4E /* Agere Systems */
-#define USB_AGERE_MODEL0801_ID   0x1000 /* Wireless USB Card Model 0801 */
-#define USB_AGERE_MODEL0802_ID   0x1001 /* Wireless USB Card Model 0802 */
-#define USB_AGERE_REBRANDED_ID   0x047A /* WLAN USB Card */
+#define USB_AGERE_MODEL0801_ID   0x1000 /* USB Wireless Card Model 0801 */
+#define USB_AGERE_MODEL0802_ID   0x1001 /* USB Wireless Card Model 0802 */
+#define USB_AGERE_REBRANDED_ID   0x047A /* USB WLAN Card */
 
 #define USB_ELSA_VENDOR_ID       0x05CC
 #define USB_ELSA_AIRLANCER_ID    0x3100 /* ELSA AirLancer USB-11 */
 
 #define USB_LEGEND_VENDOR_ID     0x0E7C
-#define USB_LEGEND_JOYNET_ID     0x0300 /* Joynet WLAN USB Card */
+#define USB_LEGEND_JOYNET_ID     0x0300 /* Joynet USB WLAN Card */
 
 #define USB_SAMSUNG_VENDOR_ID    0x04E8
 #define USB_SAMSUNG_SEW2001U1_ID 0x5002 /* Samsung SEW-2001u Card */
@@ -154,7 +154,7 @@ MODULE_FIRMWARE("orinoco_ezusb_fw");
 #define USB_FUJITSU_E1100_ID     0x1002 /* connect2AIR WLAN E-1100 USB */
 
 #define USB_2WIRE_VENDOR_ID      0x1630
-#define USB_2WIRE_WIRELESS_ID    0xff81 /* 2Wire Wireless USB adapter */
+#define USB_2WIRE_WIRELESS_ID    0xff81 /* 2Wire USB Wireless adapter */
 
 
 #define EZUSB_REQUEST_FW_TRANS		0xA0
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt76x2/Kconfig
@@ -9,7 +9,7 @@ config MT76x2E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7612/MT7602/MT7662-based wireless PCIe
+	  This adds support for MT7612/MT7602/MT7662-based PCIe wireless
 	  devices, which comply with IEEE 802.11ac standards and support
 	  2SS to 866Mbit/s PHY rate.
 
@@ -22,7 +22,7 @@ config MT76x2U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7612U-based wireless USB 3.0 dongles,
+	  This adds support for MT7612U-based USB 3.0 wireless dongles,
 	  which comply with IEEE 802.11ac standards and support 2SS to
 	  866Mbit/s PHY rate.
 
Index: usb-devel/drivers/net/wireless/mediatek/mt7601u/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt7601u/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt7601u/Kconfig
@@ -4,4 +4,4 @@ config MT7601U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7601U-based wireless USB dongles.
+	  This adds support for MT7601U-based USB wireless dongles.
Index: usb-devel/drivers/net/wireless/purelifi/plfxlc/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/purelifi/plfxlc/Kconfig
+++ usb-devel/drivers/net/wireless/purelifi/plfxlc/Kconfig
@@ -3,7 +3,7 @@ config PLFXLC
 	tristate "pureLiFi X, XL, XC device support"
 	depends on CFG80211 && MAC80211 && USB
 	help
-	   This option adds support for pureLiFi LiFi wireless USB
+	   This option adds support for pureLiFi LiFi USB wireless
 	   adapters. The pureLiFi X, XL, XC USB devices are based on
 	   802.11 OFDM PHY but uses light as the transmission medium.
 	   The driver supports common 802.11 encryption/authentication
Index: usb-devel/drivers/net/wireless/ralink/rt2x00/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/ralink/rt2x00/Kconfig
+++ usb-devel/drivers/net/wireless/ralink/rt2x00/Kconfig
@@ -170,7 +170,7 @@ config RT2800USB_RT35XX
 config RT2800USB_RT3573
 	bool "rt2800usb - Include support for rt3573 devices (EXPERIMENTAL)"
 	help
-	  This enables support for RT3573 chipset based wireless USB devices
+	  This enables support for RT3573 chipset based USB wireless devices
 	  in the rt2800usb driver.
 
 config RT2800USB_RT53XX
Index: usb-devel/drivers/net/wireless/realtek/rtw88/usb.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/realtek/rtw88/usb.c
+++ usb-devel/drivers/net/wireless/realtek/rtw88/usb.c
@@ -927,5 +927,5 @@ void rtw_usb_disconnect(struct usb_inter
 EXPORT_SYMBOL(rtw_usb_disconnect);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ac wireless USB driver");
+MODULE_DESCRIPTION("Realtek USB 802.11ac wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
Index: usb-devel/drivers/net/wireless/zydas/zd1201.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/zydas/zd1201.c
+++ usb-devel/drivers/net/wireless/zydas/zd1201.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *	Driver for ZyDAS zd1201 based wireless USB devices.
+ *	Driver for ZyDAS zd1201 based USB wireless devices.
  *
  *	Copyright (c) 2004, 2005 Jeroen Vreeken (pe1rxq@amsat.org)
  *
@@ -23,8 +23,8 @@
 #include "zd1201.h"
 
 static const struct usb_device_id zd1201_table[] = {
-	{USB_DEVICE(0x0586, 0x3400)}, /* Peabird Wireless USB Adapter */
-	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 Wireless USB Adapter */
+	{USB_DEVICE(0x0586, 0x3400)}, /* Peabird USB Wireless Adapter */
+	{USB_DEVICE(0x0ace, 0x1201)}, /* ZyDAS ZD1201 USB Wireless Adapter */
 	{USB_DEVICE(0x050d, 0x6051)}, /* Belkin F5D6051 usb  adapter */
 	{USB_DEVICE(0x0db0, 0x6823)}, /* MSI UB11B usb  adapter */
 	{USB_DEVICE(0x1044, 0x8004)}, /* Gigabyte GN-WLBZ101 */
Index: usb-devel/drivers/staging/wlan-ng/prism2usb.c
===================================================================
--- usb-devel.orig/drivers/staging/wlan-ng/prism2usb.c
+++ usb-devel/drivers/staging/wlan-ng/prism2usb.c
@@ -11,45 +11,45 @@
 
 static const struct usb_device_id usb_prism_tbl[] = {
 	PRISM_DEV(0x04bb, 0x0922, "IOData AirPort WN-B11/USBS"),
-	PRISM_DEV(0x07aa, 0x0012, "Corega Wireless LAN USB Stick-11"),
-	PRISM_DEV(0x09aa, 0x3642, "Prism2.x 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1668, 0x0408, "Actiontec Prism2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1668, 0x0421, "Actiontec Prism2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x1915, 0x2236, "Linksys WUSB11v3.0 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x066b, 0x2212, "Linksys WUSB11v2.5 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x066b, 0x2213, "Linksys WUSB12v1.1 11Mbps WLAN USB Adapter"),
+	PRISM_DEV(0x07aa, 0x0012, "Corega USB Wireless LAN Stick-11"),
+	PRISM_DEV(0x09aa, 0x3642, "Prism2.x 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1668, 0x0408, "Actiontec Prism2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1668, 0x0421, "Actiontec Prism2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x1915, 0x2236, "Linksys WUSB11v3.0 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x066b, 0x2212, "Linksys WUSB11v2.5 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x066b, 0x2213, "Linksys WUSB12v1.1 11Mbps USB WLAN Adapter"),
 	PRISM_DEV(0x0411, 0x0016, "Melco WLI-USB-S11 11Mbps WLAN Adapter"),
-	PRISM_DEV(0x08de, 0x7a01, "PRISM25 IEEE 802.11 Mini USB Adapter"),
-	PRISM_DEV(0x8086, 0x1111, "Intel PRO/Wireless 2011B LAN USB Adapter"),
+	PRISM_DEV(0x08de, 0x7a01, "PRISM25 USB IEEE 802.11 Mini Adapter"),
+	PRISM_DEV(0x8086, 0x1111, "Intel PRO/Wireless 2011B USB LAN Adapter"),
 	PRISM_DEV(0x0d8e, 0x7a01, "PRISM25 IEEE 802.11 Mini USB Adapter"),
-	PRISM_DEV(0x045e, 0x006e, "Microsoft MN510 Wireless USB Adapter"),
+	PRISM_DEV(0x045e, 0x006e, "Microsoft MN510 USB Wireless Adapter"),
 	PRISM_DEV(0x0967, 0x0204, "Acer Warplink USB Adapter"),
 	PRISM_DEV(0x0cde, 0x0002, "Z-Com 725/726 Prism2.5 USB/USB Integrated"),
-	PRISM_DEV(0x0cde, 0x0005, "Z-Com Xl735 Wireless 802.11b USB Adapter"),
-	PRISM_DEV(0x413c, 0x8100, "Dell TrueMobile 1180 Wireless USB Adapter"),
-	PRISM_DEV(0x0b3b, 0x1601, "ALLNET 0193 11Mbps WLAN USB Adapter"),
-	PRISM_DEV(0x0b3b, 0x1602, "ZyXEL ZyAIR B200 Wireless USB Adapter"),
-	PRISM_DEV(0x0baf, 0x00eb, "USRobotics USR1120 Wireless USB Adapter"),
+	PRISM_DEV(0x0cde, 0x0005, "Z-Com Xl735 USB Wireless 802.11b Adapter"),
+	PRISM_DEV(0x413c, 0x8100, "Dell TrueMobile 1180 USB Wireless Adapter"),
+	PRISM_DEV(0x0b3b, 0x1601, "ALLNET 0193 11Mbps USB WLAN Adapter"),
+	PRISM_DEV(0x0b3b, 0x1602, "ZyXEL ZyAIR B200 USB Wireless Adapter"),
+	PRISM_DEV(0x0baf, 0x00eb, "USRobotics USR1120 USB Wireless Adapter"),
 	PRISM_DEV(0x0411, 0x0027, "Melco WLI-USB-KS11G 11Mbps WLAN Adapter"),
 	PRISM_DEV(0x04f1, 0x3009, "JVC MP-XP7250 Builtin USB WLAN Adapter"),
 	PRISM_DEV(0x0846, 0x4110, "NetGear MA111"),
 	PRISM_DEV(0x03f3, 0x0020, "Adaptec AWN-8020 USB WLAN Adapter"),
-	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 / Hawking HighDB Wireless USB Adapter"),
-	PRISM_DEV(0x2001, 0x3700, "DWL-122 Wireless USB Adapter"),
-	PRISM_DEV(0x2001, 0x3702, "DWL-120 Rev F Wireless USB Adapter"),
+	PRISM_DEV(0x2821, 0x3300, "ASUS-WL140 / Hawking HighDB USB Wireless Adapter"),
+	PRISM_DEV(0x2001, 0x3700, "DWL-122 USB Wireless Adapter"),
+	PRISM_DEV(0x2001, 0x3702, "DWL-120 Rev F USB Wireless Adapter"),
 	PRISM_DEV(0x50c2, 0x4013, "Averatec USB WLAN Adapter"),
-	PRISM_DEV(0x2c02, 0x14ea, "Planex GW-US11H WLAN USB Adapter"),
-	PRISM_DEV(0x124a, 0x168b, "Airvast PRISM3 WLAN USB Adapter"),
+	PRISM_DEV(0x2c02, 0x14ea, "Planex GW-US11H USB WLAN Adapter"),
+	PRISM_DEV(0x124a, 0x168b, "Airvast PRISM3 USB WLAN Adapter"),
 	PRISM_DEV(0x083a, 0x3503, "T-Sinus 111 USB WLAN Adapter"),
 	PRISM_DEV(0x0411, 0x0044, "Melco WLI-USB-KB11 11Mbps WLAN Adapter"),
-	PRISM_DEV(0x1668, 0x6106, "ROPEX FreeLan 802.11b USB Adapter"),
-	PRISM_DEV(0x124a, 0x4017, "Pheenet WL-503IA 802.11b USB Adapter"),
+	PRISM_DEV(0x1668, 0x6106, "ROPEX FreeLan USB 802.11b Adapter"),
+	PRISM_DEV(0x124a, 0x4017, "Pheenet WL-503IA USB 802.11b Adapter"),
 	PRISM_DEV(0x0bb2, 0x0302, "Ambit Microsystems Corp."),
-	PRISM_DEV(0x9016, 0x182d, "Sitecom WL-022 802.11b USB Adapter"),
+	PRISM_DEV(0x9016, 0x182d, "Sitecom WL-022 USB 802.11b Adapter"),
 	PRISM_DEV(0x0543, 0x0f01,
 		  "ViewSonic Airsync USB Adapter 11Mbps (Prism2.5)"),
 	PRISM_DEV(0x067c, 0x1022,
-		  "Siemens SpeedStream 1022 11Mbps WLAN USB Adapter"),
+		  "Siemens SpeedStream 1022 11Mbps USB WLAN Adapter"),
 	PRISM_DEV(0x049f, 0x0033,
 		  "Compaq/Intel W100 PRO/Wireless 11Mbps multiport WLAN Adapter"),
 	{ } /* terminator */
Index: usb-devel/drivers/net/wireless/legacy/rndis_wlan.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/legacy/rndis_wlan.c
+++ usb-devel/drivers/net/wireless/legacy/rndis_wlan.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Driver for RNDIS based wireless USB devices.
+ * Driver for RNDIS based USB wireless devices.
  *
  * Copyright (C) 2007 by Bjorge Dijkstra <bjd@jooz.net>
  * Copyright (C) 2008-2009 by Jussi Kivilinna <jussi.kivilinna@iki.fi>
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt7603/Kconfig
@@ -5,7 +5,7 @@ config MT7603E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7603E wireless PCIe devices and the WLAN core
+	  This adds support for MT7603E PCIe wireless devices and the WLAN core
 	  on MT7628/MT7688 SoC devices. This family supports IEEE 802.11n 2x2
 	  to 300Mbps PHY rate
 
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -11,7 +11,7 @@ config MT7615E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7615-based wireless PCIe devices,
+	  This adds support for MT7615-based PCIe wireless devices,
 	  which support concurrent dual-band operation at both 5GHz
 	  and 2.4GHz, IEEE 802.11ac 4x4:4SS 1733Mbps PHY rate, wave2
 	  MU-MIMO up to 4 users/group and 160MHz channels.
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt76x0/Kconfig
@@ -10,7 +10,7 @@ config MT76x0U
 	depends on MAC80211
 	depends on USB
 	help
-	  This adds support for MT7610U-based wireless USB 2.0 dongles,
+	  This adds support for MT7610U-based USB 2.0 wireless dongles,
 	  which comply with IEEE 802.11ac standards and support 1x1
 	  433Mbps PHY rate.
 
@@ -22,7 +22,7 @@ config MT76x0E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7610/MT7630-based wireless PCIe devices,
+	  This adds support for MT7610/MT7630-based PCIe wireless devices,
 	  which comply with IEEE 802.11ac standards and support 1x1
 	  433Mbps PHY rate.
 
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -7,7 +7,7 @@ config MT7915E
 	depends on PCI
 	select RELAY
 	help
-	  This adds support for MT7915-based wireless PCIe devices,
+	  This adds support for MT7915-based PCIe wireless devices,
 	  which support concurrent dual-band operation at both 5GHz
 	  and 2.4GHz IEEE 802.11ax 4x4:4SS 1024-QAM, 160MHz channels,
 	  OFDMA, spatial reuse and dual carrier modulation.
Index: usb-devel/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
===================================================================
--- usb-devel.orig/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
+++ usb-devel/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -7,7 +7,7 @@ config MT7996E
 	depends on MAC80211
 	depends on PCI
 	help
-	  This adds support for MT7996-based wireless PCIe devices,
+	  This adds support for MT7996-based PCIe wireless devices,
 	  which support concurrent tri-band operation at 6GHz, 5GHz,
 	  and 2.4GHz IEEE 802.11be 4x4:4SS 4096-QAM, 320MHz channels.
 
Index: usb-devel/drivers/net/wireless/realtek/rtw88/pci.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/realtek/rtw88/pci.c
+++ usb-devel/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1828,5 +1828,5 @@ void rtw_pci_shutdown(struct pci_dev *pd
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ac wireless PCI driver");
+MODULE_DESCRIPTION("Realtek PCI 802.11ac wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
Index: usb-devel/drivers/net/wireless/realtek/rtw89/pci.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/realtek/rtw89/pci.c
+++ usb-devel/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3939,5 +3939,5 @@ void rtw89_pci_remove(struct pci_dev *pd
 EXPORT_SYMBOL(rtw89_pci_remove);
 
 MODULE_AUTHOR("Realtek Corporation");
-MODULE_DESCRIPTION("Realtek 802.11ax wireless PCI driver");
+MODULE_DESCRIPTION("Realtek PCI 802.11ax wireless driver");
 MODULE_LICENSE("Dual BSD/GPL");
Index: usb-devel/drivers/net/wireless/ath/ath10k/pci.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath10k/pci.c
+++ usb-devel/drivers/net/wireless/ath/ath10k/pci.c
@@ -3816,7 +3816,7 @@ static void __exit ath10k_pci_exit(void)
 module_exit(ath10k_pci_exit);
 
 MODULE_AUTHOR("Qualcomm Atheros");
-MODULE_DESCRIPTION("Driver support for Qualcomm Atheros 802.11ac WLAN PCIe/AHB devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Atheros PCIe/AHB 802.11ac WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* QCA988x 2.0 firmware files */
Index: usb-devel/drivers/net/wireless/ath/ath11k/pci.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath11k/pci.c
+++ usb-devel/drivers/net/wireless/ath/ath11k/pci.c
@@ -1034,7 +1034,7 @@ static void ath11k_pci_exit(void)
 
 module_exit(ath11k_pci_exit);
 
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN PCIe devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11ax WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
 
 /* firmware files */
Index: usb-devel/drivers/net/wireless/ath/ath12k/pci.c
===================================================================
--- usb-devel.orig/drivers/net/wireless/ath/ath12k/pci.c
+++ usb-devel/drivers/net/wireless/ath/ath12k/pci.c
@@ -1409,5 +1409,5 @@ static void ath12k_pci_exit(void)
 
 module_exit(ath12k_pci_exit);
 
-MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11be WLAN PCIe devices");
+MODULE_DESCRIPTION("Driver support for Qualcomm Technologies PCIe 802.11be WLAN devices");
 MODULE_LICENSE("Dual BSD/GPL");
Index: usb-devel/drivers/platform/x86/eeepc-laptop.c
===================================================================
--- usb-devel.orig/drivers/platform/x86/eeepc-laptop.c
+++ usb-devel/drivers/platform/x86/eeepc-laptop.c
@@ -1394,7 +1394,7 @@ static int eeepc_acpi_add(struct acpi_de
 	 * and machine-specific scripts find the fixed name convenient.  But
 	 * It's also good for us to exclude multiple instances because both
 	 * our hwmon and our wlan rfkill subdevice use global ACPI objects
-	 * (the EC and the wlan PCI slot respectively).
+	 * (the EC and the PCI wlan slot respectively).
 	 */
 	result = eeepc_platform_init(eeepc);
 	if (result)
