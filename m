Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8A97668D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2019 14:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfGZMxb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 26 Jul 2019 08:53:31 -0400
Received: from mail-oln040092255029.outbound.protection.outlook.com ([40.92.255.29]:3520
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfGZMxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jul 2019 08:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJ9Z9T8NaKkl/19Pn2CTVKBROhpsxJLqlGtcjq3CDq5Egk0ERV/QD8vloIkT2sSTU0Grm/sXOqmNkeBjzHhjR5jHEzy0y5lyuVF5kGYotvhTRhtr5exmSglHtYyIMTqsznt+oGpnCsmbjp1A4dM3kCxyKFBIJn2MFOfThMSS1dLyJy0HQdTOvVKZ4QiRffOUxemUXaK9zCyStLYnT1pFpZBn4bgNsrqipfEHb8EE+BxqxyLyEx6v5rcszqDloRLuEdFhApTiFFATVcz2m5FaOK5BLliKwdzT27Bw8ltm83sOGDx5rTg84C1tUpTIhyxo5CknFFeVoNNDpflhKsqcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bioli1XZ8d5XFf9cvbecmLNJ4RDmNqBlOAOgkp4XqCo=;
 b=VLiRi5CNlzciAP/j+Iz2Bb8TTNPrk2uI08jKNNOTxImbQxknABt6twbeW5JpVU7D/sQ+75ZmBkOh8nTpgHjjIiJw3Hg69a4sCmqB+lI5WSSuRoBhtD3MWgs/KavwmQlcTl+Y6KU0VDU5S1v1aKxBPgsTv0q7c+DVhrDQLBDjBkM1HVO86eOyKCO56brDR1neGI7bl7EYNVyN5msiWG1PKuiksOoyufGE0PH6NIyZFS4Mm1vyWqYatLGR715bPgRCESqisfRCKFDBPV0qAfRzzinFR5KSc2Drwx+b3UhwhFR1v/N2wLylXwqB85kiS/KFVJhMdiy/4sNR3s/31RsFDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT060.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT066.eop-APC01.prod.protection.outlook.com
 (10.152.253.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Fri, 26 Jul
 2019 12:53:20 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT060.mail.protection.outlook.com (10.152.253.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Fri, 26 Jul 2019 12:53:20 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 12:53:20 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVQ7EZa70KBVuJtk2j2TFbHr0vZg==
Date:   Fri, 26 Jul 2019 12:53:19 +0000
Message-ID: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0134.ausprd01.prod.outlook.com
 (2603:10c6:10:5::26) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:47754D7354C80742D0004359592A680CB65BDBC0431E1C6FCE5F2B066517666A;UpperCasedChecksum:0DA8F17D06563CA70FBD9BDC512B8A6374D441E14FECF3FE922C82F022C1DC7C;SizeAsReceived:7777;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ymRpG//KQ9gWu8edM1EgMdtdIfut6q93lwXTHN1Bv4gDB8OuTCcl5MnkLlMvgExT6lmRhS9cNus=]
x-microsoft-original-message-id: <20190726125303.GA2619@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT066;
x-ms-traffictypediagnostic: PU1APC01HT066:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: SIhAnh4R1g1LJlS1w+169MLXAZLE8RUYPk0o4qCDePvSUBZLasFMiWzN3xUIDnACMp3rOsvobIY7SCGKD0AnH93gwCd4NRthbMCrJMWSCQ7wUS7aWLGTatkv8pk6Cwg8atywXbz1YbTyLy0OBge7H9MffqqswZl07XH8+wdNT9ESIZkqmvL1UmuVV7xBphto
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC8D0EDD65149E49A217F8882167A8A0@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa0119-cc89-4f0a-b9d0-08d711c83c1c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 12:53:19.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT066
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

Change extend_bridge_window to resize the actual resource, rather than
using add_list and dev_res->add_size. If an additional resource entry
exists for the given resource, zero out the add_size field to avoid it
interfering. Because add_size is considered optional when allocating,
using add_size could cause issues in some cases, because successful
resource distribution requires sizes to be guaranteed. Such cases
include hot-adding nested hotplug bridges in one enumeration, and
potentially others which are yet to be encountered.

Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=199581

Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 79b1fa651..6835fd64c 100644
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
+		resource_size(&mmio_pref));
 
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
+	 * Reduce the available resource space by what the
+	 * bridge and devices below it occupy.
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
+		io.start = io.end + 1;
+		mmio.start = mmio.end + 1;
+		mmio_pref.start = mmio_pref.end + 1;
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
2.22.0

