Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45494116D65
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 14:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfLINAC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 08:00:02 -0500
Received: from mail-oln040092255087.outbound.protection.outlook.com ([40.92.255.87]:6247
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLINAC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 08:00:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sly9mk8GGp6Zq2Rtbc37z+xUlKpcaQ5J4XEAFMVn/0ItWtzBi3ptAMWCemmvQAWF8Aq7N9bE+++DokeeCDBD5ocYqKi80mx9mi5WI3p0Y6r5UYyjX2F+H8+BCsyFKv2vl4EavFjoKqD5Ppvd4bOiBeL+Tk21ikc/Hk28lcM5NwgyQBl7mis0zjximZH//d3nGnMTK5UMblS2QkqYRNPx9YpnSFIuGb/O+HjsXWQGdXoJagHhFxQM4pU2yg7TmXLSPsQwHedavhuizv8x3ZUbk/00Aq3/c0E2jhtlcbE5tjHaO30M5kNvyxiTnIyX/0jp33GeRnmgqFQsXXZgFCcCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J33yRl9Y2sqr6U3Uqe7kpzMmVIwCHSxyWSJOLz/W43k=;
 b=NTLyY4/zSM1Ur7+wyq4Tjx10Xh23QXBuhIGweTioUsx7um1fYRd8o4ZJTAq+7sltSS/TMrLB0s0Cnh5EchvvvrrG/koiUvtGa2yOjXFpPgvhiZbrc/EcPIhexZAZzBSCAWKkODbYXcA12DvoBuokaz5VvKkBVZD9aGak6zCkcqMzk9THcPFUBmPPWx8LdrEGQmloJmnv/t7DVCJvYkuQrVj7k1IdtCFC31RzHz5sZaGn2zR7hosNjjWb92EfPX0qA1X//Y/oj7u4Zk4LaP3xb9nYyecZCALXDXzDmYPAolX1iQnFeKfjbWWf7tbLj+1LzVikch6Db3UX6SqqMcnR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.248.51) by HK2APC01HT145.eop-APC01.prod.protection.outlook.com
 (10.152.249.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 12:59:51 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT003.mail.protection.outlook.com (10.152.248.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 12:59:50 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 12:59:50 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v12 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v12 1/4] PCI: Consider alignment of hot-added bridges
 when distributing available resources
Thread-Index: AQHVrpCKw/jSqscLuUygM8Wo72oCqQ==
Date:   Mon, 9 Dec 2019 12:59:50 +0000
Message-ID: <PSXP216MB0438239B3B4EC096E39E1CD980580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0020.ausprd01.prod.outlook.com
 (2603:10c6:1:14::32) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:305BD8B41944432731A3F8CCD31A1C90C27119A7FDAEB7EE77D0B6FEF2D73A3B;UpperCasedChecksum:DD3A3D451854E4D28EBC50871CABC14836D8008F2BCE265041A2DF63255EB781;SizeAsReceived:7644;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [IRjDK5xfcaUPOUNXREy3l5piBIWNb7ZnkiTYyLGsG5Oe6kJl1I4ZWUpqXu6+J3oOvLFmF5rD3Do=]
x-microsoft-original-message-id: <20191209125941.GA3009@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: c9f8bc59-a69b-412f-aacb-08d77ca7ad30
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?inBjZRGSCZnDtjlsTQkDSW/U0MH078bZbYz0PV88+XbGdkPGzfBitNHm6hoV?=
 =?us-ascii?Q?ltFJK9p6L2o+hVKLWOHoOBapf7/gTkuJ64vN9/Wmi4ncDg9XgU6Yu6otUevi?=
 =?us-ascii?Q?LDqRZd/49h0bqI22wVAn+qrapGzULXNo7WxhKA61e8Pxl9lqYg7Vk7l51n2U?=
 =?us-ascii?Q?hW+3hHzFKPyBus6Itj1l4EvdMVg0/7bJEWnj96YE7PFUpoMqv8plgILLeMC6?=
 =?us-ascii?Q?uVXyJ8ec2kDbtfiuGsF1qwugTkH1Z07drZdaviXdRVC6SOCfaN0p6LwcU0PT?=
 =?us-ascii?Q?9SXthMQFNw0PbQQNYqDQL2NNjfSBclntaLcF7CpeQinoR/w22vED/Ip7x+Gc?=
 =?us-ascii?Q?y3NR/55XjmYo0VNof5ByVACVkqsX5r8UyPH19cD52HFcsiwtcP9YtJVMAoRV?=
 =?us-ascii?Q?nZQ2xQwHVyiN3hl5G8jyOsdYpD65EkJU0C89TMAHV7XdfAo+m5A3ZjYezBdR?=
 =?us-ascii?Q?p7KgFpP0thB5dyBd4afefUMGZqFI6JN8va8N5HzeSVhBYDBtLhTtl/X/kMmR?=
 =?us-ascii?Q?1vU6dD43AsSNstFWL6OtIRgJrvGlebD+zt0CtuSr/NWZTCuvQZ8dLu5vUQDj?=
 =?us-ascii?Q?6nblJwmFdWgbAIP6Tvq8B84Dd2LegH0Eg17QfrwSdzw6wXC5DZRPnlHT1svj?=
 =?us-ascii?Q?Baghl3P/KV8+9NbbVtTsJ+/piHmgX0rjuBl3cDBPzbCK3Lc+KBWh8j9z99H7?=
 =?us-ascii?Q?QBrmtuJKUETjhyTEgWPDUZPzzrEGzpzIO6rwUha5wsZwHLsXthbc+thXW6l1?=
 =?us-ascii?Q?o0iUdIop51iOhydDkpvtixUheg4ubG+o8oUlGenqFyQlM1uQd4N3IsY70McO?=
 =?us-ascii?Q?CxbF0EPBD3kOtsUHxGm6GRiGqdutvb8MFxv/b14nG4Qj6q2YlmDrJmzoapTx?=
 =?us-ascii?Q?s147u/bvi/JHIdhZ8YDzScTx13LmK+An1kgbGbxVSPdc/yXCsLPecIOIh0cY?=
 =?us-ascii?Q?oA7C2k8bYUXbjY2IvMjh2Q=3D=3D?=
x-ms-traffictypediagnostic: HK2APC01HT145:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ds1LkNy06jo/vzNSk3GfAuNZRLLYxxjaZRfKcIGsf8OfjJnI4CANoTNQ0YC18YXB2fepyorll2pdqczer7XcBlNOJzn0Ko5bSH/hjqJPLgUEcIrNZLxcUOK6TUNIo8ljco05I4JCaCVa6S1RYihyv2wBNtQJoZvRJHVOEcFQF9iXqHjelJYRgKi1SHDQPGqyvpzPx+XiY2GS4J0jbvZ+Fkvzyqyrp6OZ5ceb96Io8mM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <926ECF76B8852B4CA2663EE1D4AE59C9@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f8bc59-a69b-412f-aacb-08d77ca7ad30
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 12:59:50.6953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT145
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rewrite pci_bus_distribute_available_resources to better handle bridges
with different resource alignment requirements. Pass more details
arguments recursively to track the resource start and end addresses
relative to the initial hotplug bridge. This is especially useful for
Thunderbolt with native PCI enumeration, enabling external graphics
cards and other devices with bridge alignment higher than 1MB.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f27982620..8c990f981 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1858,12 +1858,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 }
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
-					    struct list_head *add_list,
-					    resource_size_t available_io,
-					    resource_size_t available_mmio,
-					    resource_size_t available_mmio_pref)
+	struct list_head *add_list, struct resource io,
+	struct resource mmio, struct resource mmio_pref)
 {
-	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1873,15 +1871,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
 	/*
-	 * Update additional resource list (add_list) to fill all the
-	 * extra resource space available for this port except the space
-	 * calculated in __pci_bus_size_bridges() which covers all the
-	 * devices currently connected to the port and below.
+	 * The alignment of this bridge is yet to be considered, hence it must
+	 * be done now before extending its bridge window.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, available_io);
-	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
+	align = pci_resource_alignment(bridge, io_res);
+	if (!io_res->parent && align)
+		io.start = ALIGN(io.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_res);
+	if (!mmio_res->parent && align)
+		mmio.start = ALIGN(mmio.start, align);
+
+	align = pci_resource_alignment(bridge, mmio_pref_res);
+	if (!mmio_pref_res->parent && align)
+		mmio_pref.start = ALIGN(mmio_pref.start, align);
+
+	/*
+	 * Update the resources to fill as much remaining resource space in the
+	 * parent bridge as possible, whilst considering alignment.
+	 */
+	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
 	extend_bridge_window(bridge, mmio_pref_res, add_list,
-			     available_mmio_pref);
+			     resource_size(&mmio_pref));
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -1902,108 +1914,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 */
 	if (hotplug_bridges + normal_bridges == 1) {
 		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
+		if (dev->subordinate)
 			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
-		}
+				add_list, io, mmio, mmio_pref);
 		return;
 	}
 
-	if (hotplug_bridges == 0)
-		return;
-
 	/*
-	 * Calculate the total amount of extra resource space we can
-	 * pass to bridges below this one.  This is basically the
-	 * extra space reduced by the minimal required space for the
-	 * non-hotplug bridges.
+	 * Reduce the available resource space by what the bridge and devices
+	 * below it occupy.
 	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
-
 	for_each_pci_bridge(dev, bus) {
-		const struct resource *res;
+		resource_size_t used_size;
+		struct resource *res;
 
 		if (dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Reduce the available resource space by what the
-		 * bridge and devices below it occupy.
-		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && available_io > resource_size(res))
-			remaining_io -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(io.start, align) - io.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&io))
+			io.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && available_mmio > resource_size(res))
-			remaining_mmio -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio))
+			mmio.start += used_size;
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && available_mmio_pref > resource_size(res))
-			remaining_mmio_pref -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio_pref.start, align) -
+				mmio_pref.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio_pref))
+			mmio_pref.start += used_size;
 	}
 
+	if (!hotplug_bridges)
+		return;
+
 	/*
-	 * Go over devices on this bus and distribute the remaining
-	 * resource space between hotplug bridges.
+	 * Distribute any remaining resources equally between
+	 * the hotplug-capable downstream ports.
 	 */
-	for_each_pci_bridge(dev, bus) {
-		resource_size_t align, io, mmio, mmio_pref;
-		struct pci_bus *b;
+	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
+	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
+	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
+		hotplug_bridges);
 
-		b = dev->subordinate;
-		if (!b || !dev->is_hotplug_bridge)
+	for_each_pci_bridge(dev, bus) {
+		if (!dev->subordinate || !dev->is_hotplug_bridge)
 			continue;
 
-		/*
-		 * Distribute available extra resources equally between
-		 * hotplug-capable downstream ports taking alignment into
-		 * account.
-		 */
-		align = pci_resource_alignment(bridge, io_res);
-		io = div64_ul(available_io, hotplug_bridges);
-		io = min(ALIGN(io, align), remaining_io);
-		remaining_io -= io;
-
-		align = pci_resource_alignment(bridge, mmio_res);
-		mmio = div64_ul(available_mmio, hotplug_bridges);
-		mmio = min(ALIGN(mmio, align), remaining_mmio);
-		remaining_mmio -= mmio;
+		io.end = io.start + io_per_hp - 1;
+		mmio.end = mmio.start + mmio_per_hp - 1;
+		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
 
-		align = pci_resource_alignment(bridge, mmio_pref_res);
-		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
-		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
-		remaining_mmio_pref -= mmio_pref;
+		pci_bus_distribute_available_resources(dev->subordinate,
+			add_list, io, mmio, mmio_pref);
 
-		pci_bus_distribute_available_resources(b, add_list, io, mmio,
-						       mmio_pref);
+		io.start += io_per_hp;
+		mmio.start += mmio_per_hp;
+		mmio_pref.start += mmio_pref_per_hp;
 	}
 }
 
 static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 						     struct list_head *add_list)
 {
-	resource_size_t available_io, available_mmio, available_mmio_pref;
-	const struct resource *res;
+	struct resource io, mmio, mmio_pref;
 
 	if (!bridge->is_hotplug_bridge)
 		return;
 
 	/* Take the initial extra resources from the hotplug port */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	available_io = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	available_mmio = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
-	available_mmio_pref = resource_size(res);
+	io = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	mmio = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	mmio_pref = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
-	pci_bus_distribute_available_resources(bridge->subordinate,
-					       add_list, available_io,
-					       available_mmio,
-					       available_mmio_pref);
+	pci_bus_distribute_available_resources(bridge->subordinate, add_list,
+					       io, mmio, mmio_pref);
 }
 
 void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
-- 
2.24.0

