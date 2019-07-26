Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A818766A9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfGZMyu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:54:50 -0400
Received: from mail-oln040092255092.outbound.protection.outlook.com ([40.92.255.92]:35478
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726384AbfGZMyt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCuUvZhCV13r0AYMXY554PWqE05zWM2HiAVH+/l8MCX6WLjvRvCccI/jfpyjrPQ8shRJ+seohrLxCy3rBrhySLqlhluNg2dJi9nA9d5d5i2cZpk/EGLMCnwAiqS5oDr8lAsEt+7LZxGaO6ilLPHG2rkgLty6AcODAnKOI9obVFbcwA4Wg9zaU3BA9c7nzHADp10eEDutk7qldFCkbx6jznxFpa9p0LeWlwXlIEjbkPc8rk4diBvGv+C4caK+/soEcbGy0KeEQo57nUrPALY6YZyYrq805erBtKWlOympjK1K/1m/fxGDquqr4ytPsqhkLdfewNocfs1qvllRdGH0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRVbsPLsJ2RDoJJrhQwJFND7c2yJG8Vmg/tW2vlNot0=;
 b=lrXJMbL2k79HIa5t8Urqp9bpRurVDj3H+zfA8Nfex8LQ1KiOhrumykTIBwrRzGH9Fj0NSOrLQDaREvZ9Bp7QprVcdTH6SKoXZAJ3wcQ/gzwV65VEYLplvEum0eW/TbxDgvHXCBeyoFE8RQFjiWimV85+b8vgK+/Bk4W6ATv5vTCf1xLolAfkdypZKfaxuam0Ha69U+G9b+eFbapPoojhHMBnHr01m1Z0pqi4NdKOJHn1N9hfiZchY3YXPF4Os+eIbBc4vygdsHL/MZ2T7tnAwy8es24OiBknj2+bDtMvNekDJNxqHcDNg+Jr8naj/Upkh9IdIstb8WlLvPl7KDQUoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT031.eop-APC01.prod.protection.outlook.com
 (10.152.253.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:54:44 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:54:44 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:54:44 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 5/6] PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
Thread-Topic: [PATCH v8 5/6] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Index: AQHVQ7FMspRm/nOOq06+h4K2TYRXfw==
Date:   Fri, 26 Jul 2019 12:54:44 +0000
Message-ID: <SL2P216MB0187C45A8B38504D855A1DEA80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0087.ausprd01.prod.outlook.com
 (2603:10c6:0:19::20) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:7904D446BDF1852EFFE6FDB4BB5F0262388002C1BF8E64F2AE77D231692D61E5;UpperCasedChecksum:0148DBD9BA6B36A8BD8BDFFCD0BE294878E5D64F5219A2668F6C92C7982ED642;SizeAsReceived:7689;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [9VW2HNlcwUT/mQLmBNhclUpPO5Z3lUJp25S8lW//O4k8KmkOkbv63em1TF7OGyQIbq+zVgsZnF4=]
x-microsoft-original-message-id: <20190726125427.GA2724@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT031;
x-ms-traffictypediagnostic: PU1APC01HT031:
x-microsoft-antispam-message-info: l5zX5A0LdXIcXW2DmJoFxnU9fi6lWhvVkrX7EH9GGJsb5EXVZVoGHvphdeg74aGAjGVQVm9+r0WakkYWlJ3HkXlrYLNGXjP/ya8YS3pBOy+2rR8MK8RdH6sOj7EdO8/NzfE4vKtXLSe7WwthLS3bjuhbSYsbY3dq8V8XgobfNQt0FSseWTvo9I0Hsyt/8uKc
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F32A956BD537C429F22733A56837CEF@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2417f20b-35c3-4119-095e-08d711c86e58
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:54:44.1687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT031
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
 drivers/pci/setup-bus.c                       | 25 +++++++++++--------
 include/linux/pci.h                           |  3 ++-
 4 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 46b826fcb..9bc54cb99 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3467,8 +3467,15 @@
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
index 29ed5ec1a..6b3857cad 100644
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
@@ -6281,8 +6283,17 @@ static int __init pci_setup(char *str)
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
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7e1dc892a..345ecf16d 100644
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
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9e700d9f9..1bde5763a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2031,7 +2031,8 @@ extern u8 pci_dfl_cache_line_size;
 extern u8 pci_cache_line_size;
 
 extern unsigned long pci_hotplug_io_size;
-extern unsigned long pci_hotplug_mem_size;
+extern unsigned long pci_hotplug_mmio_size;
+extern unsigned long pci_hotplug_mmio_pref_size;
 extern unsigned long pci_hotplug_bus_size;
 
 /* Architecture-specific versions may override these (weak) */
-- 
2.22.0

