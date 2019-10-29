Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BDE8BC7
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 16:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389965AbfJ2P2d convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 29 Oct 2019 11:28:33 -0400
Received: from mail-oln040092253072.outbound.protection.outlook.com ([40.92.253.72]:47232
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390034AbfJ2P2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 11:28:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb+LOOcu3q4XvftwOSkVd1vB8HM2jDHPi1Wv+4oIK+Hsk3p6DzM3WczuLeVuHpJAXfL5tugeQOqIDhtYOCaPTE6ZW0jnOXfpGl9tQAF5HhNuwcthVt4tVsiRo2UrZO4bRQK1noIsN+mPRAfC2DVAQty1AVKeFEHNV84Ytcp6tvnavWywf2SQUG6sd8GW4z7acI+Y3WEcqAlCVZm6AJprN7A0piPmX02H0l6yFxAstJDtbhCKoMOUdhFd1C16p9GKLK3urAma+A6uzjEE8lrft3fkdvg9daLrL10kMgH7Czqy+gjzJF9l9K+ACMcK6iOCJ89NN93SGJmRCO3YvhME9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xLHuSr6FqdEP5Mt3XmB0egJcPY2SZdnT54+XaXc4cU=;
 b=BCCnRY6AK2wCdzBoorx1eWvX8YZV+0/v2XK7ttUCKser5j4YNd+2lBXDajPWWjSn3MQ0mZFYmFYVbshx5AYdCMZaOdq9WpVF4NBb8NOShARO10Utww2HNqhKRiFM9ML4XzomVjGFde1mHi6gDC1+l8buE7oF9LsH/gbX4w8t9iQzMr3zgJMJSP6gTlVb2dB2uK0FDgOAuaR8p3+1DuQTWYDJ5gnvB4BmZ4dIULkbEwuNDGouPi7wT10sWrGNMIxycwNWWp745mXJCBU93Olj8okvyfT3PeZhLCLvbSA3yFqcS5u9HbC/5TwyxzAi4OHDVhyOtfeFNeOtjn0yWWOA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT018.eop-APC01.prod.protection.outlook.com
 (10.152.252.58) by PU1APC01HT019.eop-APC01.prod.protection.outlook.com
 (10.152.253.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Tue, 29 Oct
 2019 15:28:21 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.53) by
 PU1APC01FT018.mail.protection.outlook.com (10.152.253.189) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Tue, 29 Oct 2019 15:28:21 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.028; Tue, 29 Oct 2019
 15:28:21 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v9 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v9 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVjm1/vZ/dokkVoUKpkBYfhzTu5A==
Date:   Tue, 29 Oct 2019 15:28:21 +0000
Message-ID: <SL2P216MB01875C65EE9820B6A69D208580610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:10:1::26) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:CFA11F12F5E42A4BE191B1FFA583585118F79F2E47C93067E258CEEB6E1DDA62;UpperCasedChecksum:BE278943FBEF3CBAFA13C85BAF63A809E299EEBB8F83E2A138BBE7BD68395679;SizeAsReceived:7558;Count:46
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [jBBJBs5BpJdERD+cSo9Nl0vUzgu51ayHG+2Us6PUM6Fcx8QDq9G4bx8E/xhkWvqGtoU52tQ/kxI=]
x-microsoft-original-message-id: <20191029152813.GA1914@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 46
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT019:
x-ms-exchange-purlcount: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evidtvGuMlMiI2MfAmEKyzz41l6WxFMoaQTJD26ZQSZxU1YwtEgMRcjfAcIEiPUKxofe0p5OPFPsUHlvVftqJQ9uqSWBrIw7zl1l9cHFlhcO4351c8hFe9Jnf85XxnFrgTr4rDW7ni83DX91IPC7G1jziM9W0eceDhgXByTG3tB8u2wupyhSCagTFYgsvJkbUuE7qR9Tkwfx2vUOiPWRCAyUgynVpVqKRCaqOR5ZzhE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D9EAC3E622891499EA1375C662F4A59@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e015c361-1c92-4c4d-3742-08d75c84a152
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 15:28:21.2360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT019
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

