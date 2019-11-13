Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58E4FB1E0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 14:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfKMN4k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 08:56:40 -0500
Received: from mail-oln040092255031.outbound.protection.outlook.com ([40.92.255.31]:45946
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726190AbfKMN4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 08:56:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK7zB3i9SSZjH8PTJZ0DZldFATDT0Ni2rkVFanBEABHOxRHS6cPcWMGV/Xi6QTYqT5crVHQVcBBLSy8jkUITgHQxs+iHEWwYXG0MH7R9UsMXG+87s5Cso75WHQBRnYhD8+BMAExnbHsHj/O+auY3CnH8K0WHQP+PSgUXJ7IZI26IR/j7+1jy0OxtnHpZHjvUR3GXw+HyOCn5ZggpxioAewbvzkBRw+SSYIjmefOCQrtSQhsn26WeLHB9CskRL4Eum9dQaVb+ixdtTm0yksMV/W6AbYgXtygIpEP2ENnUJNF2p2jmp8OZbO3cSw1Nn7eupgjTzBiO/W9HQm5ZQ9pVNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Lo8wVNBWQGgp23tAlbWJA3vZbvn8qDfNIMCGXf1DME=;
 b=IG6w5pZpM+mUpAppjiJdVBjP2/C+bFr3xMw7+O2fIz1CcrnJp1SlDzatHrw19MM4skBfeVqChspKQfSxmkxTufXSRhqVgpN/3AoT5Um7sZ9yKnmeOCCjEzN8uDmH6/lFHzpeM8l5RKYkVpE3oN81XduRuRiDmb5yXfWcZq3rkb2y7t7Zzpu6xoNIaQE5TbpVuOibJ6cN8CYp+kkzgbOHKvD7Zc0WKDPXGA7KrgBgGectZ0xA6I0R7qKXY6oQG6/ySzyw40Gn7uQSX/osVmb0VR9KMxhpJmbR2la2kUnn/QXlaWZUNopyHm/yQGLDrAG/a0DnfvXNLNp3WJeeLmkBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT035.eop-APC01.prod.protection.outlook.com
 (10.152.252.57) by PU1APC01HT043.eop-APC01.prod.protection.outlook.com
 (10.152.253.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 13:56:31 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT035.mail.protection.outlook.com (10.152.252.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 13:56:31 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 13:56:31 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v9 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v9 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVmionW5Vccx4lI06a8AnSKZg2ew==
Date:   Wed, 13 Nov 2019 13:56:31 +0000
Message-ID: <PS2P216MB0755B47C5DC8DE1D1C4C8D0B80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0096.ausprd01.prod.outlook.com
 (2603:10c6:0:19::29) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:2E1463CB15FA671BCCBA58F049DA5247C041178DDC41974C57C97904CE0A0897;UpperCasedChecksum:B122233A00DB3CC652348A5B1F2ED1215487554FE11CB996B00DA2509237E1AC;SizeAsReceived:7717;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [yrz4/Z7Yxgydo6tMoyjJr2ksk5OApWB5XrYJTY1oGCICWHUBFBnvEGA+Wq2aX10Gn4q2rcbtTTE=]
x-microsoft-original-message-id: <20191113135622.GA3216@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: ab963db1-a6ab-49b1-0c66-08d7684149a2
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?KE5ywuOaN5jF7dXX3ZDU2SplAw6YV8u2U37Af1nkGT6pnkkJjrOMMFLpBdmz?=
 =?us-ascii?Q?OGiJH7ju0TdrMpzRLZbHXMKdScg/D10OAROT3XpteQc5XcseKe8SYeXObfii?=
 =?us-ascii?Q?/8gi8+5x0KZcVCe6g3igqfEHMaOUQoVRcq59BE1wIi4rXnlaNSqS5ok/c3xW?=
 =?us-ascii?Q?hCCuJ2zdIzEyAi50hzmnZ/Y4uDjd4Fg7gjIapnoJCAMQ9gLjFGl54i8DgtO8?=
 =?us-ascii?Q?3Z13Kr7BeGMnCyrAswfOf0VZUekRaFJnxI0QcTgmQ+nqt0q7qJrCX1kcHDcz?=
 =?us-ascii?Q?uVa107pIZa7Vcuaah4T1PXGTx6KO7LX8mujz4XkOmYb8JDm7pBVW7rHlPBlv?=
 =?us-ascii?Q?VC1q4z62gf59Gsodu/kRNPFsSVH6DISSJFbuWDXgEb7cliahllNA/YnX5IuC?=
 =?us-ascii?Q?kXMmcXFvoypD5HsWwPGBn8TKO1ENvUFkZijf08RZj0+J6v8LcX4WIZ30ecVo?=
 =?us-ascii?Q?3+Vs9Zo7DZ3BhgoxcZGqIMZZd4WYP8Rx9PtygQE5oOYAhVMpptXqQGOwq8uS?=
 =?us-ascii?Q?wS+MEdopYUImW2MU4hfNWq4ZnBMtQSNnfaOyZpTZ7yUojZuLJ3QCN2Kr6PPG?=
 =?us-ascii?Q?95p7XacmKu7ITaPIsOuAOgZiSYwy8HqDYIjQxS66li//m9ewqY5Gd1I0m8zq?=
 =?us-ascii?Q?qfFwVbCkbVmRMZqstaBKtrvkl28ivnxm04s1qrwN8sgjgnjeY49x6FdHC8zo?=
 =?us-ascii?Q?CHc4xNOr3Li/bEo04MvIhydTXTZP/mTr/wvxfTJIO89hOCqvOwnoYJq4ZeHx?=
 =?us-ascii?Q?BFHUWOCNUSZNfkk58lc77UlwRAJIVVK1xQKuV+fJyUCcg3bqaOdXauksqrlU?=
 =?us-ascii?Q?xAgHWI5MuQSuZ3iRz+Q3rrQ928lLWPRLG/8jR0y7vfZB/bDouGaOUWKL+KRB?=
 =?us-ascii?Q?zZwWfJpdbceb4HlWwfQzRZFneoLlCALmPg7kK6iquAgFGsPR3eTdAMAOAir/?=
 =?us-ascii?Q?yS0594KcuKhyMSMNyMwHsRGUyaVTofzC?=
x-ms-traffictypediagnostic: PU1APC01HT043:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDnIC3B+utzr4jT5UXC+HaQ9I5fou5EGr45YO/0VRrvUmlqCTNMt6BBGX9zLlMwlww9nhGfI0pEr9YdjA8VnAUKFJDT1zsN0JDh25lXGuFCzGtcbzf0WtUxLZhr3DWrnkljZB/3TMchduvk6qG7etqKKzg2KtfvfsTQWK1xKFgl1sve6A+4F0QidfMWbvCwH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C09BD4211172C24FB9BFB74A2313C0AA@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ab963db1-a6ab-49b1-0c66-08d7684149a2
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 13:56:31.7962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT043
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
index e7dbe2170..bd8231560 100644
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
2.23.0

