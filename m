Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE2A713CB70
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgAOR4B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:56:01 -0500
Received: from mail-oln040092255017.outbound.protection.outlook.com ([40.92.255.17]:27756
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbgAOR4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:56:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idvfxJ6xN8v7SDGb+LeCdOKhtPah8B0S37JxJ/9I/mIvKAHrudfhZ/GVfasww8gvyleENpWe0y8VGkAecHbvdImFxLuhb5ap0Im1lgSXz5purN28X9YpMW4WcQLoVg+kfvDYXah6kBPPXCIdTG8QDlP4s8+BP/MwToNmxsIQSLoFJZnv1LrRRMniCM/MshzPwGMaQHNbjsXmfKbgkmX81ZkxFW76HhQuK+l1EDBYABtn2gn7HabsQoSpMHK0j9/sEkJzhdlAKpaO6+7Y0IyxHlEfWH+OHJEDpVwiR3EEhgN9NR5bdyUFZfAalmEf0CW2HUtTRQKS7AjTtswHz4fJTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf+Z2yJIOrqjXisRPyrcNWYECIr0LzUvlXlsAKaB2RU=;
 b=bY0BV4qRZnswwycXDeYANt03cx4nTjXyZqrGwRkNjd3zrGD8EVEvQStPb2XAm+5HgC9CeJFxIfALKDFyxvLTGYnYAflZW1Xn8LHHp7ysEzyqApkCDO9lAIVr2jgTG9oHtFIAodfL+O90C1IjvQ6m9qJOfqSn73JjR3BTgRHIjbAFtSQ2ljaiSHwdmGPTwFJWISfbwzyFSsNyncQfWwFg5l9g7mIR33MkIOuXFfr1VBwGSm44q3FVnsa7a9uvkB6LBgW0z3dn+FdWv1zHIIkbebXOkfdTpbaw/au0hrUXsb+c9y0B7gp7dycObW2nVZc1T6tGS6tR+x0TxiQLvF7LjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT074.eop-APC01.prod.protection.outlook.com
 (10.152.253.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:55:55 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:55:55 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:55:55 +0000
Received: from nicholas-dell-linux (61.69.138.108) by MEXPR01CA0144.ausprd01.prod.outlook.com (2603:10c6:200:2e::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Wed, 15 Jan 2020 17:55:53 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 2/3] PCI: Change pci_bus_distribute_available_resources()
 args to struct resource
Thread-Topic: [PATCH v2 2/3] PCI: Change
 pci_bus_distribute_available_resources() args to struct resource
Thread-Index: AQHVy80IJ28WXgSE4ESOni8G7RXQsQ==
Date:   Wed, 15 Jan 2020 17:55:55 +0000
Message-ID: <PSXP216MB04381698213B5D19B3A7D22580370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0144.ausprd01.prod.outlook.com
 (2603:10c6:200:2e::29) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:9DB488DE1FD4DF8E01F847FC82BEA236620588B11ED82E0AD6D2BAAE033BCC23;UpperCasedChecksum:B2C4B0F2921317CB80EDA8A56CB2707C830B10B6E01973529CC5B6A283D964CC;SizeAsReceived:7817;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [fQZ4ODuM3IkQlLUkzYB/3aNzoG0nc73N]
x-microsoft-original-message-id: <20200115175547.GA4507@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bac1b8c7-48f5-438f-5140-08d799e42aec
x-ms-exchange-slblob-mailprops: zswcL9HXbeVV5DRQNiFD0ULmQNyfwccSqUhyOR+Ebg+10hJ0JFYV70ZTCmDUqM8ILZbgpCh0Xyw8yJuBBHUZIjAxygT8pfjgRa4lGgBlSqKPOXi02hIO4YE71Bn2xCpXiibPvG1OwIsIQkbAqZUjTRhJvTOL1UznmQUCp/Y6W2IURk4d7vOT21a0+/AT4BNfq0mOHT4SAanmgh9bDr6lfw7i8obwuxADBfAxIkz+e6q2X6BgQ4kHMm0DHDKS4YV48hdjgRZhLvoSpoGU+LzFb3utA+UOKT5DjuZXnOZP/TkUMq8I+SR55u+Hko1p9md7Rpa2W2PAlN4Bz3Wq/MM/jWgujw0O5wmbCDgAs3DP6paDnOJ557iyRLFU1s7l3/rXzaqso6VUSFp9AUf1VjTjTGwqVSgDsFNM6YnvNqJYiNSkMuR2O0NT1HcKDkWu7hzn0O4YBENj5N3nxAeEhwUF8719h1x/S9ccPMIMyhzouiz5bHKFELtG4l7gwYjxoyw7rCVbAZoqBXLCZfQzWWv8NWf2GJ9hPwwozaSDX62X4JgMRDtbXab9O3Vv2B8R5VoL893SnJGaOEDz/7A8j1/11kGEESsmlxrjTDSls4/9NKRpZXHu2bP5/qx/RgwhevGZdMH7pntIm4WBUxduypvIKjkbS28xM/cCMptPTK3bhtEXhMkzLRR5eo+URIRiFZv++cdS1bQWHsv7FYtQzARLygL5PfFi+r5n9NPI643qeib3tZMon73H61ZOLOgyJF3q
x-ms-traffictypediagnostic: PU1APC01HT074:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AkmBM5ORe8qFEXC9RAc4BvQGJr+mSeVsBpmrdIK6CMqI9ICD3aPqUb7u9RpPkW4wRT0Xgqc9RaJeg6meuQX7UJIHcbFbNTrlkEARNMkkovnHWZWW4jbYyjbX4/IBsoxN79DG6lVsIo//AcNTGpZDIzR5Y1d5rUDXYsDZgN2zqZ3Fv4sauLty1oY/YS3hS67t
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E45E93AAE7B47F48923DC5C72591CD2E@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bac1b8c7-48f5-438f-5140-08d799e42aec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:55:55.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT074
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change pci_bus_distribute_available_resources() arguments from
resource_size_t to struct resource to add more information required to
get the alignment correct for bridge windows with alignment >1M. This is
in preparation for the following patch:
"PCI: Consider alignment of hot-added bridges when distributing available resources"

We require (size, alignment), instead of just (size) which is what is
currently available. The change from resource_size_t to struct resource
does just that.

Note that the struct resource arguments are passed by value and not by
reference. We do not want to pass by reference and change the resource
size of the parent bridge window. We only want the size information.

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 66 +++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 465a8b565..269082261 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1859,11 +1859,13 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
 
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 					    struct list_head *add_list,
-					    resource_size_t available_io,
-					    resource_size_t available_mmio,
-					    resource_size_t available_mmio_pref)
+					    struct resource io,
+					    struct resource mmio,
+					    struct resource mmio_pref)
 {
 	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
+	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp;
+	resource_size_t avail_io, avail_mmio, avail_mmio_pref;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1878,10 +1880,10 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * calculated in __pci_bus_size_bridges() which covers all the
 	 * devices currently connected to the port and below.
 	 */
-	extend_bridge_window(bridge, io_res, add_list, available_io);
-	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
+	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
+	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
 	extend_bridge_window(bridge, mmio_pref_res, add_list,
-			     available_mmio_pref);
+			     resource_size(&mmio_pref));
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -1904,8 +1906,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
 		if (dev->subordinate)
 			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
+				add_list, io, mmio, mmio_pref);
 		return;
 	}
 
@@ -1918,9 +1919,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * extra space reduced by the minimal required space for the
 	 * non-hotplug bridges.
 	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
+	remaining_io = avail_io = resource_size(&io);
+	remaining_mmio = avail_mmio = resource_size(&mmio);
+	remaining_mmio_pref = avail_mmio_pref = resource_size(&mmio_pref);
 
 	for_each_pci_bridge(dev, bus) {
 		const struct resource *res;
@@ -1933,15 +1934,15 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * bridge and devices below it occupy.
 		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && available_io > resource_size(res))
+		if (!res->parent && avail_io > resource_size(res))
 			remaining_io -= resource_size(res);
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && available_mmio > resource_size(res))
+		if (!res->parent && avail_mmio > resource_size(res))
 			remaining_mmio -= resource_size(res);
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && available_mmio_pref > resource_size(res))
+		if (!res->parent && avail_mmio_pref > resource_size(res))
 			remaining_mmio_pref -= resource_size(res);
 	}
 
@@ -1950,7 +1951,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * resource space between hotplug bridges.
 	 */
 	for_each_pci_bridge(dev, bus) {
-		resource_size_t align, io, mmio, mmio_pref;
+		resource_size_t align;
 		struct pci_bus *b;
 
 		b = dev->subordinate;
@@ -1963,19 +1964,24 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * account.
 		 */
 		align = pci_resource_alignment(bridge, io_res);
-		io = div64_ul(available_io, hotplug_bridges);
-		io = min(ALIGN(io, align), remaining_io);
-		remaining_io -= io;
+		io_per_hp = div64_ul(avail_io, hotplug_bridges);
+		io_per_hp = min(ALIGN(io_per_hp, align), remaining_io);
+		remaining_io -= io_per_hp;
 
 		align = pci_resource_alignment(bridge, mmio_res);
-		mmio = div64_ul(available_mmio, hotplug_bridges);
-		mmio = min(ALIGN(mmio, align), remaining_mmio);
-		remaining_mmio -= mmio;
+		mmio_per_hp = div64_ul(avail_mmio, hotplug_bridges);
+		mmio_per_hp = min(ALIGN(mmio_per_hp, align), remaining_mmio);
+		remaining_mmio -= mmio_per_hp;
 
 		align = pci_resource_alignment(bridge, mmio_pref_res);
-		mmio_pref = div64_ul(available_mmio_pref, hotplug_bridges);
-		mmio_pref = min(ALIGN(mmio_pref, align), remaining_mmio_pref);
-		remaining_mmio_pref -= mmio_pref;
+		mmio_pref_per_hp = div64_ul(avail_mmio_pref, hotplug_bridges);
+		mmio_pref_per_hp = min(ALIGN(mmio_pref_per_hp, align),
+			remaining_mmio_pref);
+		remaining_mmio_pref -= mmio_pref_per_hp;
+
+		io.end = io.start + io_per_hp - 1;
+		mmio.end = mmio.start + mmio_per_hp - 1;
+		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
 
 		pci_bus_distribute_available_resources(b, add_list, io, mmio,
 						       mmio_pref);
@@ -1985,19 +1991,15 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 						     struct list_head *add_list)
 {
-	resource_size_t available_io, available_mmio, available_mmio_pref;
-	const struct resource *res;
+	struct resource available_io, available_mmio, available_mmio_pref;
 
 	if (!bridge->is_hotplug_bridge)
 		return;
 
 	/* Take the initial extra resources from the hotplug port */
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 0];
-	available_io = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
-	available_mmio = resource_size(res);
-	res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
-	available_mmio_pref = resource_size(res);
+	available_io = bridge->resource[PCI_BRIDGE_RESOURCES + 0];
+	available_mmio = bridge->resource[PCI_BRIDGE_RESOURCES + 1];
+	available_mmio_pref = bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
 	pci_bus_distribute_available_resources(bridge->subordinate,
 					       add_list, available_io,
-- 
2.25.0

