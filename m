Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224BBE19AC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 14:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfJWMMg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 08:12:36 -0400
Received: from mail-oln040092255053.outbound.protection.outlook.com ([40.92.255.53]:43897
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391208AbfJWMMf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 08:12:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2y8TKuNTnWc/cVbid7EYaGvdpKK7PhA4FtMIcmfiWKCaRsY9DaF4K0JNrKBkVL50ucfaeI/0NlhlZuce46859AFOhirSzRezsimoZajOf/cwUFRWSBjGlA+4Sp+wkk9WJehYtBnqq6eHrzoaebGp6792NFkkz1PcOAW8zSlUq+1YciRkhElTVpOF4wAMLT2Fr4d2mo7a6ZhSTLHdt4433j72tFVLUN5kArlfp8LPPYXaD1LQsQadg/6yIZ+R6xz7IFmPXxjn+GhAZM+QAe6JrxzZBH97jZzRYHOEcPp7zfOo8xW5rJzzw56i76Pl9KhtNIS5ZASpe7tC4xdILUzBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7CZVvxa2Xc3npnG0RNoHz+au1c3N7sDZ2cCkbjaSz6I=;
 b=cZQ2tX+bSpEtcZVjedwF4bWPy86EzRkk3uXPbnx16dOyGTqHig9W8eMm/vUB4Llo6/Els0lY+hRy9PvYKdJ6//remFhaOb0qezKhUVmiRTMC6sg9NJBTJCHkSZRMNPC73pyziBevZBNooTtaShGdWP6LZczj/tbWJqTZOwiQVNlkz2OmaMJVm782SH06wwEeHReRX2f1pho/evlcHFzjARfF2jzCikvmZCsZlCDRuTDLN+gJ7XysaIBXJBYtdu2QcouTeEwq18nVKILTZANaaM2nghT/bgS/VKDpbcSTM53l4nhQxkWrVBOFaA+ceGg+Lta0sWBY2TfPJV44/GvArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT022.eop-APC01.prod.protection.outlook.com
 (10.152.253.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 12:12:29 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.58) by
 PU1APC01FT009.mail.protection.outlook.com (10.152.252.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 12:12:29 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 12:12:29 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v2 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
Thread-Topic: [PATCH v2 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Index: AQHViZskmoGSmBjPlkKlRTahWX6YYA==
Date:   Wed, 23 Oct 2019 12:12:29 +0000
Message-ID: <SL2P216MB0187E4D0055791957B7E2660806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0086.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::26) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:F81D6982ADF92EBEB81F6D242F93ACF3FE1840BF83B4E7133895C15B7A39AB8F;UpperCasedChecksum:E99E1DA0BD6EB757345B5011B2A15083C7B895634EF1EC856CE01B1614125BB9;SizeAsReceived:7443;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [lR8VBdmZnZu3u60qcGz05dQWcVsvIqEqjlMorKVB/bo=]
x-microsoft-original-message-id: <20191023121222.GA18696@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT022:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uwZpPdm6PPfhw8phkbyeDSBDTy8x0OlxjCQlWhE98KhwxYyd4DDgzlDjHY7VnI6bUWSva7WA4kGfaXkcR/cCMmnG3UlHUDogM4DB0sXsTZkl7hQdfdx1S/T5Qy292ZQ2Zi9ovH9Vy3SKc74Hg0vc/GppuF5q24pvClPWxkyepOIfF31o2PvcGD/hp1AcRbpC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88B49A2AE3BD09448EA052F6D46BFFA6@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b55d8346-8a9b-45ec-ccba-08d757b2467e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 12:12:29.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT022
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
 drivers/pci/pci.c                             | 13 +++++++---
 drivers/pci/pci.h                             |  3 ++-
 drivers/pci/setup-bus.c                       | 24 ++++++++++---------
 4 files changed, 33 insertions(+), 16 deletions(-)

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
index a97e2571a..e0406c663 100644
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
@@ -6286,8 +6288,13 @@ static int __init pci_setup(char *str)
 				pcie_ecrc_get_policy(str + 5);
 			} else if (!strncmp(str, "hpiosize=", 9)) {
 				pci_hotplug_io_size = memparse(str + 9, &str);
+			} else if (!strncmp(str, "hpmmiosize=", 11)) {
+				pci_hotplug_mmio_size = memparse(str + 11, &str);
+			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
+				pci_hotplug_mmio_pref_size = memparse(str + 15, &str);
 			} else if (!strncmp(str, "hpmemsize=", 10)) {
-				pci_hotplug_mem_size = memparse(str + 10, &str);
+				pci_hotplug_mmio_size = memparse(str + 10, &str);
+				pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size;
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
index e7dbe2170..93fd2070a 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1178,7 +1178,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
 	unsigned long mask, prefmask, type2 = 0, type3 = 0;
-	resource_size_t additional_mem_size = 0, additional_io_size = 0;
+	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
+			additional_mmio_pref_size = 0;
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
@@ -1265,7 +1267,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			if (ret == 0)
 				mask = prefmask;
 			else
-				additional_mem_size += additional_mem_size;
+				additional_mmio_size += additional_mmio_pref_size;
 
 			type2 = type3 = IORESOURCE_MEM;
 		}
@@ -1285,8 +1287,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
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

