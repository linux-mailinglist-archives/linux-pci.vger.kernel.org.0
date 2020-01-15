Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADD013CB75
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2020 18:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAOR4U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jan 2020 12:56:20 -0500
Received: from mail-oln040092253041.outbound.protection.outlook.com ([40.92.253.41]:35765
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbgAOR4U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 12:56:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJmwvtZ/WucwBU3mchGlmJTe1Ctcna5om0E8TiKEiJXj33pUSJXLWSPwzKHJgYyjZjlDcMmbk4z25IoAxna05YGv4yUjW3IukZ3Bo0I265l45ZiGZ9aBlzNFd3Fdsm0bIEYs4TzlWLt8i19pxgcYGI3xu2GLI3eagHiMtMzFlpGPJdZggqex63pW89/ZmNAuvB8ShHRiHDrqUyDx8GOCyIpP32bg9/Gj0jKuwoResmOarh/R5VhvO7z9MgvWuMxr+fOHrcCnV/LHsRe21XMjuAuVwXOtXRCJ5hJ3hpMTAi2KiQBt5onzESCK7ynqMNpYG5y8L3+B2TRAl5zcssIS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEQe7Iih79GnSXeJEsBmkJIAY/cL4JwPgrFmrbpT5lc=;
 b=Qgutj72eaR+60yhSRxlleB58F59JM3YeXfVT4UzMymcMPGvRzmtSbKb3zqFO1h0cuqRLrpbl+yo+L1aUrFjGSM/PqLE3tZ4+sP0zwdH+GgyDWq3Kqfgxkjrp7IMq9FbeG2Qlrc1otH9k/Zys7hRKZQmFZdJqZcHYuDT7lwPlzb68QW6OUtJUqHD4dRnoAXTTzoHIDsX9Gh1DCE6t0MTEiKcimT/dhxjLBNOmx13ZVjxBJN+Zr9C8XzHYuaW26n8yDAnoycxzm+2295zWwvhmhLzxxeMNSsZ3j074A6iG0UkYlWDCGjRQKiRRNmum0tY/t8mW4CPObWD5PLbHlAq/CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT115.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT127.eop-APC01.prod.protection.outlook.com
 (10.152.253.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Wed, 15 Jan
 2020 17:56:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT115.mail.protection.outlook.com (10.152.252.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Wed, 15 Jan 2020 17:56:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2623.018; Wed, 15 Jan
 2020 17:56:14 +0000
Received: from nicholas-dell-linux (61.69.138.108) by ME4P282CA0001.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:90::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Wed, 15 Jan 2020 17:56:12 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v2 3/3] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v2 3/3] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVy80UqszJ0J6vUkOxHSiku/VLiw==
Date:   Wed, 15 Jan 2020 17:56:14 +0000
Message-ID: <PSXP216MB043850B82390137D625ACB4780370@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0001.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::11) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:00C797530CBEBAF3A516F16B31241C14F0153178C8D1502DCAC6CB8E110CC6E9;UpperCasedChecksum:08E9F82DD3841E2349353B6D5BE7EB87FD170E346DD0CC696F53397E3AE901D7;SizeAsReceived:7826;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ux6msHsNw4nbVPHXSk46Po4f4nRwWDAt]
x-microsoft-original-message-id: <20200115175606.GA4509@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f47a197f-3f31-4d4a-4e23-08d799e43652
x-ms-exchange-slblob-mailprops: Xo9mRxKQURQLKonzPJ6/VvFsyF9p9aaO1jrIKmQss9FvRHjhTo3YyBr4oUjXOFNkdWz0S/b3aza7CCbNDOfHmZPcNsDNtB2f6KafbeOkjDs8cpsdfG6cc/Supjkd1udFoC4vJVsBDKPmUjJVVfCh4zjJu2vyeCZ0JIINWT3W031w3S2O3dhirErB80lCF0BQ3cak8YZB5xcEoF0Ow1OGlRx/N5PhLUtUWLApKABNsqyY4UcbSisXAmI1Oxf3r+hdu+KQd/zVh4cXvEVo78z7VI4SClythyftW1FfgUF3ghpQsT+vKf9QZLfHlbBq8jVDqMyNZACV9hnGT/bBlXZ0BIPJq7kwnD6Ji991G6OKPwYgD7MW0eqToenyJlLV11QgsiGJJCPgEfE0CxwXedjDHtS6OriktGqzGM61e4RxQq+uqZxxNgDNYYpFwLEASAdpuWiPTPx1U0y+tfuzvMR0Rhoo6AgNWsKWGsqMrYnBDM48JcoVtdGfunCuhcmPhMGmYEQSNORpt0u7bp5qsORFvN1HfFyoPVYyBz54p7biCyccCiZESRp5q+B5U6md7ezUQaMK9ZfVbifCnIbe/Sev3DHRuDbQ+Rim7Tfx3TWLfoqQCQlDXH1P/gQ5vZ3xrGLasqHIJr9kHlMhDQefad7tX2vHBTDAJMvGFxRyKh09No2YhKVigCTzrpbJzPtcMwgsWLo8Gcq1LE9QAmAA4tVVe9Fo2z80nlKvzVHhnEy05wQ10sYY2v7afjc+IWdTX0jn1FY9QK/8r+SThHIA1PPAfTQk+KqhZvfGj8+vyrEg5vEaQN0Pg7SNzdngz1q/sRJANNcDAQ6jwfrBgYylJbL3/9WXVnwEA+7IJ9NIyyjStgBRa+CN447LUHTuWxpOYjExy1cNc4mU66CfDstbQfUOf9Sq5LfC1T0YOoSj/l+bu1mWGn07DFLU+g==
x-ms-traffictypediagnostic: PU1APC01HT127:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gZxTq7qMYeE9eexjuDicOMtukXIu+U4BTrCiUa9UpNC9DBRPnDum14EPTrvo58ENCdDsM0wi9tJuiUZJKeTPJCNOx9lqiZvluWCmBZomPYbvic5RWGSRuX3AlNteGVGJcQBxCMqVEc4hmtwNI3yqgXggB7ZdlViCGeTJAlebe3rARBwG05Z+CAF9QqxGpAbYqbMs7jCRc64AY51Uahk0ROBdpsWlj1ox8SvUFfskMzU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1010D0DAD21C9E49ACA3165AB5525DE4@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f47a197f-3f31-4d4a-4e23-08d799e43652
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 17:56:14.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT127
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change pci_bus_distribute_available_resources() to better handle bridges
with different resource alignment requirements.

The arguments io, mmio and mmio_pref represent the start and end
addresses of resource, in which we must fit the current bridge window.

The steps taken by pci_bus_distribute_available_resources():

	- For io, mmio and mmio_pref, increase .start to align with the
	  alignment of the current bridge window (otherwise the current
	  bridge window may not fit within the available range).

	- For io, mmio and mmio_pref, adjust the current bridge window
	  to the size after the above.

	- Count the number of hotplug bridges and normal bridges on this
	  bus.

	- If the total number of bridges is one, give that bridge all of
	  the resources and return.

	- If there are no hotplug bridges, return.

	- For io, mmio and mmio_pref, increase .start by the amount
	  required for each bridge resource on the bus for non hotplug
	  bridges, giving extra room to make up for alignment of those
	  resources.

	- For io, mmio and mmio_pref, calculate the resource size per
	  hotplug bridge which is available after the previous steps.

	- For io, mmio and mmio_pref, distribute the resources to each
	  hotplug bridge, with the sizes calculated above.

The motivation for fixing this is Thunderbolt with native PCI
enumeration, enabling external graphics cards and other devices with
bridge alignment higher than 1MB. This fixes the use case where the user
hot-adds Thunderbolt devices containing PCI devices with BAR
alignment >1M and having the resources fail to assign.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 77 ++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 269082261..8b39b9ebb 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1863,9 +1863,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 					    struct resource mmio,
 					    struct resource mmio_pref)
 {
-	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
-	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp;
-	resource_size_t avail_io, avail_mmio, avail_mmio_pref;
+	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
 	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
@@ -1874,6 +1872,23 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	mmio_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 1];
 	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
 
+	/*
+	 * The alignment of this bridge is yet to be considered, hence it must
+	 * be done now before extending its bridge window.
+	 */
+	align = pci_resource_alignment(bridge, io_res);
+	if (!io_res->parent && align)
+		io.start = min(ALIGN(io.start, align), io.end + 1);
+
+	align = pci_resource_alignment(bridge, mmio_res);
+	if (!mmio_res->parent && align)
+		mmio.start = min(ALIGN(mmio.start, align), mmio.end + 1);
+
+	align = pci_resource_alignment(bridge, mmio_pref_res);
+	if (!mmio_pref_res->parent && align)
+		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
+			mmio_pref.end + 1);
+
 	/*
 	 * Update additional resource list (add_list) to fill all the
 	 * extra resource space available for this port except the space
@@ -1919,12 +1934,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * extra space reduced by the minimal required space for the
 	 * non-hotplug bridges.
 	 */
-	remaining_io = avail_io = resource_size(&io);
-	remaining_mmio = avail_mmio = resource_size(&mmio);
-	remaining_mmio_pref = avail_mmio_pref = resource_size(&mmio_pref);
-
 	for_each_pci_bridge(dev, bus) {
-		const struct resource *res;
+		resource_size_t used_size;
+		struct resource *res;
 
 		if (dev->is_hotplug_bridge)
 			continue;
@@ -1934,24 +1946,39 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * bridge and devices below it occupy.
 		 */
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 0];
-		if (!res->parent && avail_io > resource_size(res))
-			remaining_io -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(io.start, align) - io.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent)
+			io.start = min(io.start + used_size, io.end + 1);
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 1];
-		if (!res->parent && avail_mmio > resource_size(res))
-			remaining_mmio -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent)
+			mmio.start = min(mmio.start + used_size, mmio.end + 1);
 
 		res = &dev->resource[PCI_BRIDGE_RESOURCES + 2];
-		if (!res->parent && avail_mmio_pref > resource_size(res))
-			remaining_mmio_pref -= resource_size(res);
+		align = pci_resource_alignment(dev, res);
+		align = align ? ALIGN(mmio_pref.start, align) -
+			mmio_pref.start : 0;
+		used_size = align + resource_size(res);
+		if (!res->parent)
+			mmio_pref.start = min(mmio_pref.start + used_size,
+				mmio_pref.end + 1);
 	}
 
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
-		resource_size_t align;
 		struct pci_bus *b;
 
 		b = dev->subordinate;
@@ -1963,28 +1990,16 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		 * hotplug-capable downstream ports taking alignment into
 		 * account.
 		 */
-		align = pci_resource_alignment(bridge, io_res);
-		io_per_hp = div64_ul(avail_io, hotplug_bridges);
-		io_per_hp = min(ALIGN(io_per_hp, align), remaining_io);
-		remaining_io -= io_per_hp;
-
-		align = pci_resource_alignment(bridge, mmio_res);
-		mmio_per_hp = div64_ul(avail_mmio, hotplug_bridges);
-		mmio_per_hp = min(ALIGN(mmio_per_hp, align), remaining_mmio);
-		remaining_mmio -= mmio_per_hp;
-
-		align = pci_resource_alignment(bridge, mmio_pref_res);
-		mmio_pref_per_hp = div64_ul(avail_mmio_pref, hotplug_bridges);
-		mmio_pref_per_hp = min(ALIGN(mmio_pref_per_hp, align),
-			remaining_mmio_pref);
-		remaining_mmio_pref -= mmio_pref_per_hp;
-
 		io.end = io.start + io_per_hp - 1;
 		mmio.end = mmio.start + mmio_per_hp - 1;
 		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
 
 		pci_bus_distribute_available_resources(b, add_list, io, mmio,
 						       mmio_pref);
+
+		io.start += io_per_hp;
+		mmio.start += mmio_per_hp;
+		mmio_pref.start += mmio_pref_per_hp;
 	}
 }
 
-- 
2.25.0

