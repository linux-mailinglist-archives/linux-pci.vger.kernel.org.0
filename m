Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F13D9E146C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 10:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbfJWIh5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 04:37:57 -0400
Received: from mail-oln040092253082.outbound.protection.outlook.com ([40.92.253.82]:30623
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390353AbfJWIh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 04:37:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1+DO0lc65TiSt8pe40FYKEsbbaIVYBZv4ESihAkmTXuvvE66mPkmNrlGDO+4pTaVrxmTer5XK/joiaRKm/bcELlzYz2tvnICGTC1oZigGK6I10HmW7+Vowgc1A74Yz3BZtg/JtCU2cIaVIpoRLhXQT1SwOykx8IxEoQc2baI8QJj0GQXbl0LyUocIZpph+5zu1P49ZcRDrKDM/W9b1gRtzRAMW9DBlW7XO9JYJJBVSPWRjACdcoeAaOCcSCOQIurvI+fyZgbkLaQUaIXc0kyKqjC6HO+O+13KZUVEUTekPRCJeIyJPOBuWMClKLD0oPid4rQACOm0eo2K/34+Ud0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnPf9fo8tADOYYwG6DbGZXUs2olY4KmiP1tfy+jSTq0=;
 b=jxgPjfXoleMoADm53SSxXvKVvdCZayc8djdFfkau2/BWy3BiwXzh5gnH8wJkcMKnGg12+NUNpbeLoktOxoFeM8w/mHKRttLLoo/ZUZjVwhGad4dJKeCspacYQ4rNuCkjs2q05+bQdzirFv8ogl0lHjuxf2cEeYE3duinqo8XbG4dX9O0aPnq2I2568ow0rOOxLy7t4+sWC+mrpjUvIfc6Atz7PFEUfs+MzkcPXXupT6XumpoYxF10KH4eHhZ7mW9O4QGqKVpKKysqcYfit0NCh9SzqFavLNNP8rXrO4BkDZ4LEKH2PVGULMRBpFxUr02Sn6KPt63MUQyKFG89/78hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT086.eop-APC01.prod.protection.outlook.com
 (10.152.253.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 08:37:48 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT009.mail.protection.outlook.com (10.152.252.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.14 via Frontend Transport; Wed, 23 Oct 2019 08:37:48 +0000
Received: from PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266]) by PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 ([fe80::707c:4884:c137:2266%5]) with mapi id 15.20.2367.025; Wed, 23 Oct 2019
 08:37:48 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
Thread-Topic: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Index: AQHViX0m6toKrk1OzESm1M80C1WD2w==
Date:   Wed, 23 Oct 2019 08:37:48 +0000
Message-ID: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:4d::13) To PSXP216MB0183.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:b::17)
x-incomingtopheadermarker: OriginalChecksum:8BFD5BF37D82C8EA85A8BA34EF2BF8F4F91DC0E4D7E6B948B7135546413ED7B2;UpperCasedChecksum:7D423CB8EE7FCD8F8E1B3841F25ED7621FF02D52C1A0A7FCACCFFA42AD5BF395;SizeAsReceived:7749;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [xiGx/98xIeIfYqA6eBsyb4UFnne5xVY2Uw+aXcsHEGo=]
x-microsoft-original-message-id: <20191023083740.GA3877@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT086:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7E/88aIvlljn17/eXAWrAUlE9y7vKfR/qy7OaUvF+Dx0tPL7kc1uXRD5Qo4sNS+OChnubg4ter5eMzb5ctXgL3aOtz+LvqmHa3Nv2q/KdNTSjp2b7svYzUTX6odaJcQ+EnlgwEzXRHWv07BdKageIOfEjc9XQG2Y4wg/jHA9EcVVYtsfcXTlGNAe70FdpwMB
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DF046B5D888C6944B8D9050510A4F27E@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bba039bf-3c14-4e6c-bb01-08d7579448c1
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 08:37:48.6595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT086
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add kernel parameter pci=hpmmiosize=nn[KMG] to set MMIO bridge window
size for hotplug bridges.

Add kernel parameter pci=hpmmioprefsize=nn[KMG] to set MMIO_PREF bridge
window size for hotplug bridges.

Leave pci=hpmemsize=nn[KMG] unchanged, to prevent disruptions to
existing users. This sets both MMIO and MMIO_PREF to the same size.

The two new parameters conform to the style of pci=hpiosize=nn[KMG].

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 .../admin-guide/kernel-parameters.txt         |  9 ++++++-
 drivers/pci/pci.c                             | 17 ++++++++++---
 drivers/pci/pci.h                             |  3 ++-
 drivers/pci/setup-bus.c                       | 25 +++++++++++--------
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a84a83f88..cfe8c2b67 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3492,8 +3492,15 @@
 		hpiosize=nn[KMG]	The fixed amount of bus space which is
 				reserved for hotplug bridge's IO window.
 				Default size is 256 bytes.
+		hpmmiosize=nn[KMG]	The fixed amount of bus space which is
+				reserved for hotplug bridge's MMIO window.
+				Default size is 2 megabytes.
+		hpmmioprefsize=nn[KMG]	The fixed amount of bus space which is
+				reserved for hotplug bridge's MMIO_PREF window.
+				Default size is 2 megabytes.
 		hpmemsize=nn[KMG]	The fixed amount of bus space which is
-				reserved for hotplug bridge's memory window.
+				reserved for hotplug bridge's MMIO and
+				MMIO_PREF window.
 				Default size is 2 megabytes.
 		hpbussize=nn	The minimum amount of additional bus numbers
 				reserved for buses below a hotplug bridge.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a97e2571a..f3adab84b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -85,10 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
 unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
 
 #define DEFAULT_HOTPLUG_IO_SIZE		(256)
-#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
+#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
 /* pci=hpmemsize=nnM,hpiosize=nn can override this */
 unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
-unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
+unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
+unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
 
 #define DEFAULT_HOTPLUG_BUS_SIZE	1
 unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
@@ -6286,8 +6288,17 @@ static int __init pci_setup(char *str)
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
 				pci_hotplug_io_size = memparse(str + 9, &str);
+			} else if (!strncmp(str, "hpmmiosize=", 11)) {
+				pci_hotplug_mmio_size =
+					memparse(str + 11, &str);
+			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
+				pci_hotplug_mmio_pref_size =
+					memparse(str + 15, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
-				pci_hotplug_mem_size = memparse(str + 10, &str);
+				pci_hotplug_mmio_size =
+					memparse(str + 10, &str);
+				pci_hotplug_mmio_pref_size =
+					memparse(str + 10, &str);
 			} else if (!strncmp(str, "hpbussize=", 10)) {
 				pci_hotplug_bus_size =
 					simple_strtoul(str + 10, &str, 0);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947ee3..9faa55a15 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -218,7 +218,8 @@ extern const struct device_type pci_dev_type;
 extern const struct attribute_group *pci_bus_groups[];
 
 extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_mmio_size;
+extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /**
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e7dbe2170..24fc4c715 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1178,7 +1178,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+		additional_mmio_pref_size = 0;
 	struct resource *b_res;
 	int ret;
 
@@ -1212,7 +1213,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pci_bridge_check_ranges(bus);
 		if (bus->self->is_hotplug_bridge) {
 			additional_io_size  = pci_hotplug_io_size;
-			additional_mem_size = pci_hotplug_mem_size;
+			additional_mmio_size = pci_hotplug_mmio_size;
+			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
 		}
 		/* Fall through */
 	default:
@@ -1230,9 +1232,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (b_res[2].flags & IORESOURCE_MEM_64) {
 			prefmask |= IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-				  prefmask, prefmask,
-				  realloc_head ? 0 : additional_mem_size,
-				  additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, all non-prefetchable resources
@@ -1254,9 +1256,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		if (!type2) {
 			prefmask &= ~IORESOURCE_MEM_64;
 			ret = pbus_size_mem(bus, prefmask, prefmask,
-					 prefmask, prefmask,
-					 realloc_head ? 0 : additional_mem_size,
-					 additional_mem_size, realloc_head);
+				prefmask, prefmask,
+				realloc_head ? 0 : additional_mmio_pref_size,
+				additional_mmio_pref_size, realloc_head);
 
 			/*
 			 * If successful, only non-prefetchable resources
@@ -1265,7 +1267,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mmio_size +=
+					additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1285,8 +1288,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		 * prefetchable resource in a 64-bit prefetchable window.
 		 */
 		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
-				realloc_head ? 0 : additional_mem_size,
-				additional_mem_size, realloc_head);
+			realloc_head ? 0 : additional_mmio_size,
+			additional_mmio_size, realloc_head);
 		break;
 	}
 }
-- 
2.23.0

