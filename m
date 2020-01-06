Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3668413150F
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgAFPqV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 6 Jan 2020 10:46:21 -0500
Received: from mail-oln040092253090.outbound.protection.outlook.com ([40.92.253.90]:29376
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726296AbgAFPqU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 10:46:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOSj6CRr58jctI0ATNauPciMXHti+KvROTZpjC+72E0yTZtu/BkhjYNVrHvmRsHRIfDWi0ZYDdeWLjwziCcFK+5KU7PQKSjTnsJsO0loc+aGHAO96ITeJTae9rzcANldWHr1La2Mgv3JnVBMVgIH4oEKwa8ekMyWr84CusKNHUjUqXvmZueAhhG07cG0PH35uapvGeSw+ClZ42qasklk6V7mN/kgZ9RNzwXDCKkwk7xiyIsC5xdlAT4iZEc3NsJ8IHRWCLYdLxAPTVBnecAXa8rZiE3t5Lz3ak7HUgTw0r5+CZgE7CT79rE4j/rMTTJK9oGD+uptGQxbk6VoS0Ataw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGnTUvsC0uK3qtzun2Zm0yN0WNEWlC4l55GFY4FQn6Q=;
 b=GCkV5wmD66Za7i2cClkRCDZTcm98M4jGgOveQoPvQnC9u/3nd/4OeTvSVEGhZBnI0L+7NNJjdAv2rVMMkueNgP9lzZi00hsAuoE2UQxouFESVgBSDpCk7ipxQixyiIoJyjhOu67S+J6cgzIVwppCwqPRAdxgMrYCsC2BAkylS7OfOqEO0Q4HJMmHXFbN//STmQ9OJb2vrmzO7JDRG/9FWBRriru+KnYEY3kqHtWJrUS7Rfkk7boc/SIVPB7vLwds8KsKmELGJIy+LMPDyl06/s3ZzR5MNDmrZlgsr+oguNLl6bUrfSdqrAGn5LKK0jwc60pBHfp85wDm+thAc6ktgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT163.eop-APC01.prod.protection.outlook.com
 (10.152.252.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11; Mon, 6 Jan
 2020 15:46:13 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.59) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 15:46:13 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2602.016; Mon, 6 Jan 2020
 15:46:13 +0000
Received: from nicholas-dell-linux (49.196.2.242) by ME1PR01CA0093.ausprd01.prod.outlook.com (2603:10c6:200:18::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 15:46:11 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 3/3] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Topic: [PATCH v1 3/3] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Thread-Index: AQHVxKhsW0Uf1buztU2rOF7joqMPrw==
Date:   Mon, 6 Jan 2020 15:46:13 +0000
Message-ID: <PSXP216MB0438C2BFD0FD3691ED9C83F4803C0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME1PR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:200:18::26) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:643A909AC0518A0F88E39B29C4B2FC61FD2C6EF960742CFC2A24392BE4E9737C;UpperCasedChecksum:727BD72A48BB5822C2F4C571F69641DC6FE3CC3614D3F4F4E4F4533619EC1B8C;SizeAsReceived:7837;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ltgiV1HLTSnB0O9qba1eYowxIPDFy20O]
x-microsoft-original-message-id: <20200106154604.GA2545@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 486e6211-f70e-43df-d70c-08d792bf8f02
x-ms-exchange-slblob-mailprops: Xo9mRxKQURSkEW8nYp9BQ2W3swfFj29dRAC6BB1iFggR4i+AG/qo+mPPkKSjfVCvhQQsptIhqz4M6MKeIucLP+wX81jqcM+GNJOT6nG0xEaseaXbTCZgLHxO5IVPCzPc+j9hh06dD7gVWPfgtNtPL80ajgfM0+OBuMUnU/7vziFSYnhuiuzs4oaQsRs11fq3s/lx3/Kec01FasZO+1n3TF08VcQixAjYQuG9QnpCCSCs/r0cfoPRCK/J8sqyhYe2Q9raSV+rBgK7CTqVbxdLi1V9rLLEB6zOTnoN0OBMJm/Nc56aBoo59Xnt2in/sur78E76JraJjKcHNd3pCHTVk/5yc1FL0/mox2RKw+CCyV4uFSPjcZz7WxANQ3LaKpLww2lcpEO/YzNDpSK3apbH4KDsALvioxHmyuVvTFOdKQvHf+GC0hUxtQ89Knd4iOzoZCFsSwHdvALNXVaLW2gxoTgnar3RdAj00xNTegF4Py99RdMqooWnE+DrLy4S+Ew3eO/OE+gNe09QPPvHMkwXB+tfPMXZ4hlJMUdUSlMpzHLFS7jSNWp13D+kfBb9zkgIqlUCjiE6KPI9uS7smJix+7HuvHXdrkwBbTFWaJPfLNzVvjuzZbcWEXoxJZQ9ISeqONOQsNV0RYMTw260PXmUHeoYm7hXLkOkhHOxs/z9l/nXfpvvE0drwq1hygPzrYXBXfEZrQckwJE+ve6fjjPd5VQn0/mS/AL+GuKQRj8EQeYG9K70SZMTJiB3UD7uF79fb87wf846yO2lOUF6HR26yfzEb4SWkM44maED6I5UldXbLCOrZPHXpUSKtMNeYKEhFq6lojZy4o8McgE0E4Od+SALppoVh+rBVvvRtsn3teRJ+k7X6p+0FgTDmAx8w4GRmQawjtzt21kQhGKb/QMbLJTIO1n23EujoOBMhxUFki5ZTvitnaFPpg==
x-ms-traffictypediagnostic: PU1APC01HT163:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S1tN2epC96C3c6fU6gXyOHRnWHmuqADrxk9wOtRSes3jwKsSHoka07WnP/NSVPtVMZHvOsuuvFv2nF3YU5k+VB+q6MI/Je1jJaFCPhLpZu1ZTrpxyGopRsQNuxKpRA8N0/kJWXUfG3Knr9dL7Px0AUyIFf6SkA9T5vBoNvyyJH5H+bdS3tm1s3zib2/HIWuzZRrx8nNAWlu0bahxPF72f2P1wIjc9g8R0mADhSsC5U8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <397E1A0C8276CD4CA1DFDFBFDE660831@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e6211-f70e-43df-d70c-08d792bf8f02
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:46:13.4999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT163
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
2.24.1

