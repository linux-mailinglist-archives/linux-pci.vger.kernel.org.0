Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9605D13150D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAFPp6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:45:58 -0500
Received: from mail-oln040092254033.outbound.protection.outlook.com ([40.92.254.33]:31564
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPp6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:45:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OI0XbR/5LzyMsGAYaiakEY43GU4Mu2xSj6aLkzOht803fgdKomj5qO3wi/GZBqhtiIeUNym1VBRoFVcO3TlcF474WS1+GnpPzyA4UBWl+ecZeF73Hcz5Px/vQggaJlIM5L6KV4nFYOAtI3SAjQ5wJDRr+Dqk534VkssMkQ89MaXaIU92+5YZNoSIGC8mFAAamtFtssWNWy8uXM3Q5F5VsGjCSG/i/FL0m0aSMxydAqMe/O7XBOJhV0lDnTS6JfvDjGvxYyQ5sdoSIUm6dI6/C5BB8i0N+FA0rTdaIF9VTslJ08J8afBM1rumZ7okBvGDVboHAFp1s6aoGs0fTwEALg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzr39wj4PMW+uXxJqxajMB4Qj8HPjDTwndKpF4w1Wo8=;
 b=T8+a/59fYsk2y3J3/Q8YUGdnzq54AWRhcOS7wrd44QDz/vA4EyfXzU7+mbYu82n/bd9i5XprQxyM0OAzopRSHMEInay7h28ZDJKXCGWSVY1wiuCilVoE8fK2oe4mvbJHmG6a/PXSe0a+e0NFVA/GMit6a4jyeq00nTBeOuP9+t95niVQPJkeF9f7C9EnGkQvU/5H7lIUxur1c/aBwBm3Z4IOTx2km9/Os9i8xsYK5GrRCntJQq0dUMTJASbd9DJfha1/dTJh9/h3aX6UcXxmKbaqGeOjsbI+WC034rhshorUnDH2ZGz15TG+fzfhztj0iGVN3U8m6Rg+8xlt8ly1nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.56) by PU1APC01HT094.eop-APC01.prod.protection.outlook.com
 (10.152.253.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:45:52 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:45:52 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:45:52 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME1PR01CA0148.ausprd01.prod.outlook.com (2603:10c6:200:1b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:45:50 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 2/3] PCI: Change pci_bus_distribute_available_resources()
 args to struct resource
Thread-Topic: [PATCH v1 2/3] PCI: Change
 pci_bus_distribute_available_resources() args to struct resource
Thread-Index: AQHVxKhgFwDouE0OnEatmrv8tmhE0g==
Date:   Mon, 6 Jan 2020 15:45:52 +0000
Message-ID: <PSXP216MB0438587C47CBEDF365B1EA27803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0148.ausprd01.prod.outlook.com
 (2603:10c6:200:1b::33) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:BB478DE5C042FDBE3E49BDDA5AFB013216A0F63C9DCE0A95EC68D7D9438898A7;UpperCasedChecksum:FE75A1D7B739D3F466CED63A20D87EFE36E4BBBE0B61728CFE232C4A82DE2122;SizeAsReceived:7825;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [iCCerjgjaBHeAqtCmCnVXcjJqhq8vOw8]
x-microsoft-original-message-id: <20200106154544.GA2542@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 6392ce1d-8285-4db5-32d2-08d792bf825b
x-ms-exchange-slblob-mailprops: mBy7Mai7yE6pvqwJQ6Mx8ls6+U3+cSxq7Htmw4JdSyhCanzeEIryiYk2xXhHYB8Mg6XC0fkFpO16vK4rky0i2xkfRnv1JdNR8f/C/XXAbdfA5Tu4TOcMmY5Uw1IGBORBRD6yx1kjBWU87z7lhd/fhC81qK4/GI57yx2CDWE7VRAOhWD+u3FQMphMSB871uc0RX+gSGZ7Br5SD05HmwaaGjwH9L75aEPvIbem8AB1N78UFpGcwHfRT5PXjbSujJ20UFZONW7A/YvJD1INOGcoNAMxeXxvH8bulR7qqgY6njt6BGQD7CNG/ITB2uSVSOsWoQ/TXN3PUCuzKJRLKj9ZIDgOTUtH51CBMBtHqs2IhYqq3VWYlc00Z+WY3y2YtJkfcqiz3bEFIVWXShkO3FQMego5zFhIyvIFTVW81cShVoTt62ep1IQNsOmJhLV1xocShUcYmv0TYVsWRpJ/nfTzesVsXdwJuJ2KGKf4QMB5WMChAi4T7hBzNIAU2oxFxRO58v4nD7fdBYOsQeErDeqIZViM53x2YKv7axpI+E/VdgLE1Oiy1T0G6Lw8I4zYCbB/A5tK7B96ZFCa5ghK+U5UPxj/HsSHr9mllM86Ki5gGJ6xnbZo4FsOSfSFmeAS2oTFG1xT8gMQfu9Hkj3jiy6WlY4yJpvNxAnYA+RPFtSF1YG+BtSSHxKrEfxtZkbG9hDDQMGJaAHK3psBmeTuz96U87M5Cbf2zvSv
x-ms-traffictypediagnostic: PU1APC01HT094:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5iVbhvcF02BkooVDyNNSZJYx+t9VoBtj2Jso5sSZZQOs5qz6JU5ZaMkHItx9vKRKRrHbJUhcJ1OCIihjkWcp9qyaC51QrdbQIE72Hf1bugdYJ5MHMxo7nywcPAm8eqw8UGLCVYSNS3OgLagOdZ7mQ5ZmEkboQ0n4jKdZh9p9zKHU1/t3Ey7VY217Gk62Zgec
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBB701D31420B349B7932319F4A75E31@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392ce1d-8285-4db5-32d2-08d792bf825b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:45:52.2956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT094
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Change pci_bus_distribute_available_resources() arguments from
resource_size_t to struct resource to add more information required to
get the alignment correct for bridge windows with alignment >1M.

We require (size, alignment), instead of just (size) which is what is
currently available. The change from resource_size_t to struct resource
does just that.

Note that the struct resource arguments are passed by value and not by
reference. We do not want to pass by reference and change the resource
size of the parent bridge window. We only want the size information.

No functional changes.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
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
2.24.1

