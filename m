Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1CB5FB223
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 15:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMOHv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 09:07:51 -0500
Received: from mail-oln040092254081.outbound.protection.outlook.com ([40.92.254.81]:15767
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMOHv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 09:07:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkKBHngWGAS45VAQpG0GtO5Sxap1/DgJY/ZNyQ1SGoSaNvCBve70n6gPdi0aiCxlY2Y/ImghJc2c2CzH8ts4wlWctUvn/jY0KPJBgP5v/OOEY50UVvn/xeOekNanVB4H7yv9TVq9tqNB4Ae2LRLvOjX/C/8Nn3Ij1I/5MmAQlt2BCxEvPctH5HoixXNXtJ6a9Ix3FsbQsTdWYtE1bR70Rwxjk9C7NXaFfPDybCw2qA3rnZvkJOuH4HBP3CdHzKyojQZpdgynH4Icf6l0N8w9T2pqUY0fvWdDNC/L7yWWBZXOS8Fg33dbkvkTRrz7/ppMCIjUKNp0EVKar7/D37e96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXP2TzRbbeY+fqr5HfDW7prpUb9MuvQ4LU6v6T20PaI=;
 b=m6qTZSv/OR/uFdCtCVqyH9CCpXgf0c/gXh82USG68dQxU4JcKDTDyDg393B7m3NedrEr0ILI1jPjzNxnAvKOiHnUk2jKzOtg5SiuB7pOoNCFWzI9PdiplTUrVjVm6vDKoQMj8S3SFN5UZs6JJMpkSqvlNQQdLlpM/MEx/tF7uv9lRF9QqXUn5GlFgHAeZkMAuVZ9h1UJncFFx6j/d1FhkZXpx+CJ+duTyfkA1FHTFatbGjFM/gFt/eKOxp7yYaDybYctP8MnTOr4rEebucXRiXav9tkxb6Ojh8IOBeMFaLm7U2sfmLZGO84+jILBaKDS+56WPSNIUCEqMaPtlmIqfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT025.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT082.eop-APC01.prod.protection.outlook.com
 (10.152.251.168) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 14:07:43 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT025.mail.protection.outlook.com (10.152.250.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22 via Frontend Transport; Wed, 13 Nov 2019 14:07:43 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 14:07:42 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v11 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v11 1/4] PCI: Consider alignment of hot-added bridges
 when distributing available resources
Thread-Index: AQHVmiu3OgcTMRwsvk20eJUwCNMwtQ==
Date:   Wed, 13 Nov 2019 14:07:42 +0000
Message-ID: <PS2P216MB07558F0E543D5E61A141D78D80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0088.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::21) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:406BB8736E2F2A4D18C5266BA993946C81F754A4B45B9748BFFA1AACE892985D;UpperCasedChecksum:2BBE68D2C820641AD0C51855A180CE8D47CC5761DC610BDB311CFAE6CEB795F4;SizeAsReceived:7726;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/qCbzFqPs0HmALH2/FMs9swGrG7c7t2EMilXNDzp5j0bdk8l+kVsmeLNHiSUOuM7OMVabippH+c=]
x-microsoft-original-message-id: <20191113140734.GA3819@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 4e04ab76-c87f-4fb2-4d0e-08d76842d9a8
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?KE5ywuOaN5jF7dXX3ZDU2SplAw6YV8u2U37Af1nkGT6pnkkJjrOMMFLpBdmz?=
 =?us-ascii?Q?OGiJH7ju0TdrMpzRLZbHXMKdScg/D10OAROT3XpteQc5XcseKe8SYeXObfii?=
 =?us-ascii?Q?/8gi8+5x0KZcVCe6g3igqfEHMaOUQoVRcq59BE1wIi4rXnlaNSqS5ok/c3xW?=
 =?us-ascii?Q?hCCuJ2zdIzEyAi50hzmnZ/Y4uDjd4Fg7gjIapnoJCAMQ9gLjFGl54i8DgtO8?=
 =?us-ascii?Q?3Z13Kr7BeGMnCyrAswfOf0VZUekRaFJnxI0QcTgmQ+nqt0q7qJrCX1kcHDcz?=
 =?us-ascii?Q?uVa107pIZa7Vcuaah4T129+9ZgSvCdX02DTVcX/od2sfGWSKZLsUPuSBWcvy?=
 =?us-ascii?Q?yr1mEvWngFAy9eB55ypKRfKb+YqAd1Hpd0riaUc5IT0VSdO7mrhYWkyno3B6?=
 =?us-ascii?Q?qjP7SGNep+bNoIi92HZbEGEYSp1sWZbJbaRSyo5QFXntXzPrr2Z2zq+2M7sv?=
 =?us-ascii?Q?nwXISgYG6eazTh05ugt1C/Ezr4d2B3uaTVzRgBuDsrHJG/yXkXC2UpCwgpcP?=
 =?us-ascii?Q?4xllFlyh663k+tdx+mNv1jYx+AFMUA8xY8d5Ufzpvgkuk76e/O15Dr5PoC9T?=
 =?us-ascii?Q?PrKmScQMXWUZHpc/l5/cswOw/0p0Q9VWNjeGCUjW7fUw2/i5n0kf/xEQBncH?=
 =?us-ascii?Q?bx09mB+H1DqsI+CED8Hj8b0B1IDz3+rAIncNRIc5gDSOIeuYxW6OKDav/rK2?=
 =?us-ascii?Q?ncl/3qn/Cz0GMA9+K3LamkDzxbvZn88AhYoR3Im236Dpcj2AvwwmBw4B4hxo?=
 =?us-ascii?Q?oRNy9zwQKH0WEtqZqIZlf2ePT/2Filv7j6R6TCZ5uHRRRS1oxeKdsnij8Gta?=
 =?us-ascii?Q?w3rJnvtldQnfEnH8zomgsLb6rO4B5YpswPztr82a2K6gI3VHUeInWaRFRWw8?=
 =?us-ascii?Q?0DHj7yOW58rh5g0SnLHXMu4Q124Pi4F7Q1BCVAm4UUHE2YRrR6ckUyoiyg68?=
 =?us-ascii?Q?NPiHrR5ov2uVuuhbLFSwUAutUlakxNG0?=
x-ms-traffictypediagnostic: SG2APC01HT082:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6VW6JCOPmTVl6aDNQISN+8zTelPV8aRGM95ywG3bimMYmYQnMQdOyrt/KTar4yFc+hXjJDgS7UrY/liIw7dzwbQQl+lh7wmGZzS8yDmiaUyCjGodFCsm+OIRYvCXdOnl2uwyVE5biMHwX4gcEtKVBLohZj85+0WFwVxI6eKYC0ab8UpCTcUh2LVxTziImcf7
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <909C5A9FBC52DC45954B253AC8EC6BE9@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e04ab76-c87f-4fb2-4d0e-08d76842d9a8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 14:07:42.9068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT082
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

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 144 +++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 75 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e7dbe2170..2e71efccc 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1840,12 +1840,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
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
@@ -1855,15 +1853,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
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
+	 * parent bridge as possible, while considering alignment.
+	 */
+	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
 	extend_bridge_window(bridge, mmio_pref_res, add_list,
-			     available_mmio_pref);
+			     resource_size(&mmio_pref));
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -1884,108 +1896,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
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
+		struct resource *res;
+		resource_size_t used_size;
 
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
+			mmio_pref.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent && used_size <= resource_size(&mmio_pref))
+			mmio_pref.start += used_size;
 	}
 
+	if (!hotplug_bridges)
+		return;
+
+	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
+	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
+	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
+		hotplug_bridges);
+
 	/*
 	 * Go over devices on this bus and distribute the remaining
 	 * resource space between hotplug bridges.
 	 */
 	for_each_pci_bridge(dev, bus) {
-		resource_size_t align, io, mmio, mmio_pref;
-		struct pci_bus *b;
-
-		b = dev->subordinate;
-		if (!b || !dev->is_hotplug_bridge)
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

