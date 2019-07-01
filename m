Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660E25BE15
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbfGAOWu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:22:50 -0400
Received: from mail-oln040092253101.outbound.protection.outlook.com ([40.92.253.101]:29710
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727064AbfGAOWu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:22:50 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT071.eop-APC01.prod.protection.outlook.com
 (10.152.253.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:22:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:22:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:22:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 1/8] PCI: Simplify pci_bus_distribute_available_resources()
Thread-Topic: [PATCH v7 1/8] PCI: Simplify
 pci_bus_distribute_available_resources()
Thread-Index: AQHVMBhy/j20QAW14Ea8AXyV6YBqSg==
Date:   Mon, 1 Jul 2019 14:22:43 +0000
Message-ID: <SL2P216MB01872FED744839B3F42ED38380F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0145.ausprd01.prod.outlook.com
 (2603:10c6:0:30::30) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:B230098E27C8EDA92CC7E2DBE1387CD9CC8D631EA0F50958B205DE44B3456819;UpperCasedChecksum:41E9E1A05564A214069764DF0052BE4F90A6BD480842D23F50CB52839FD60D45;SizeAsReceived:7687;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [kdAE7IwH8mYXH30fIrStVqN88iK95+Oa20R+Wx5L8ge+FEYn+KAqewpZZqMQ3NLDOWOKNAC7nXI=]
x-microsoft-original-message-id: <20190701142227.GA5156@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT071;
x-ms-traffictypediagnostic: PU1APC01HT071:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: hYHyYsxG0xfjs6MVFuZN62th1RBTazy/a9++SSayg/dhx2bfZSY6J0H5rz0pNB+siFmDMRQlthFD1M5F4LaJ3Wf/pgqJrta9f3axUTyjnjBs1WOkSk/JX3Kj711F6gGEuHd+eTnJTnEDurRWUoshPdwkKWNPfkY28xDwXHnKj21YrNk5tLDxa/tftoltGAMH
Content-Type: text/plain; charset="us-ascii"
Content-ID: <058E6F501B00A346BF0D296F2597AF77@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 82559e89-cf13-4106-de24-08d6fe2f948a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:22:43.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT071
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reorder pci_bus_distribute_available_resources() to group related code
together.  No functional change intended.

Link: https://lore.kernel.org/r/PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
Based-on-patch-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
[bhelgaas: extracted from larger patch]

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0cdd5ff38..af28af898 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1860,16 +1860,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	extend_bridge_window(bridge, mmio_pref_res, add_list,
 			     available_mmio_pref);
 
-	/*
-	 * Calculate the total amount of extra resource space we can
-	 * pass to bridges below this one.  This is basically the
-	 * extra space reduced by the minimal required space for the
-	 * non-hotplug bridges.
-	 */
-	remaining_io = available_io;
-	remaining_mmio = available_mmio;
-	remaining_mmio_pref = available_mmio_pref;
-
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
 	 * are on this bus.  We will distribute the additional available
@@ -1882,6 +1872,31 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			normal_bridges++;
 	}
 
+	/*
+	 * There is only one bridge on the bus so it gets all available
+	 * resources which it can then distribute to the possible hotplug
+	 * bridges below.
+	 */
+	if (hotplug_bridges + normal_bridges == 1) {
+		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
+		if (dev->subordinate) {
+			pci_bus_distribute_available_resources(dev->subordinate,
+				add_list, available_io, available_mmio,
+				available_mmio_pref);
+		}
+		return;
+	}
+
+	/*
+	 * Calculate the total amount of extra resource space we can
+	 * pass to bridges below this one.  This is basically the
+	 * extra space reduced by the minimal required space for the
+	 * non-hotplug bridges.
+	 */
+	remaining_io = available_io;
+	remaining_mmio = available_mmio;
+	remaining_mmio_pref = available_mmio_pref;
+
 	for_each_pci_bridge(dev, bus) {
 		const struct resource *res;
 
@@ -1905,21 +1920,6 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 			remaining_mmio_pref -= resource_size(res);
 	}
 
-	/*
-	 * There is only one bridge on the bus so it gets all available
-	 * resources which it can then distribute to the possible hotplug
-	 * bridges below.
-	 */
-	if (hotplug_bridges + normal_bridges == 1) {
-		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
-		if (dev->subordinate) {
-			pci_bus_distribute_available_resources(dev->subordinate,
-				add_list, available_io, available_mmio,
-				available_mmio_pref);
-		}
-		return;
-	}
-
 	/*
 	 * Go over devices on this bus and distribute the remaining
 	 * resource space between hotplug bridges.
-- 
2.20.1

