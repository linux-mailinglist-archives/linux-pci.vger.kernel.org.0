Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD4FB3AC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfKMPZh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 10:25:37 -0500
Received: from mail-oln040092253010.outbound.protection.outlook.com ([40.92.253.10]:8610
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727721AbfKMPZh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 10:25:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FD47yMNSptXPfIyvCDx5yZr1IySjWAw3UyOVznJfzB/1juwGkZHzjEkJmFi7e6CgHvAtWmMHI+ULAs3EqcMBscCedwfmfJWF0Onf6NLqhCKLQJRKAhbLgDn87rwvyZEBQupDXnCWqJkaOmw8XbpIVhYZAVk2mt0KJM3bveY2gXUKG3qaWqES6/9uQzt7yQDphfnQ4xW3xk8yRPx8/fjPhcU68FxIR9oJ1Uko0JNa+8Uw978jzO2Vlns52O75juOSIQVMTgEbebL/vd7gcAkF0yz6+kQ4QrZUwYU2Pzp0DdtIF8sSCOXxzjNBE79nk7ksm6CkTsPSTOPTuoPLf9XXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNrwh3AJ6U+tQAt8B77xRMoXezYNJGxfM63DqmGMy7I=;
 b=oChKCSWzIRPzZk0fw6U2S6UEPvUFTRnL+PR9lY+sEUuN8R0IL4jQrvVDJ+cb6ndafb5usM4JPtfl5PFWJiJCeZeTRgv/X5K09zaltkxTD7v21/wbOI37ela+LGMGxRS1HvwCFTjb2vhdndp/KZ5hJVt6VdwcqOocRp7N0YoAQ5nDcDIRvMMkEUcE3ekVZKuQrEteJnHjeehfa8Bl66H0NGbMsKuZrC6AozDVspDnoosec6XCIPFZTKN4ch18FK5oPXs1nfTzT4DbK5GB0oh3n6LpC2GmHt9dep3fe/BsssLSLDtKgi7CdNP7ZQ+I2wh17EjNaVSt+Ab95T00Zx8CXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT007.eop-APC01.prod.protection.outlook.com
 (10.152.250.55) by SG2APC01HT016.eop-APC01.prod.protection.outlook.com
 (10.152.250.223) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 15:25:28 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
 SG2APC01FT007.mail.protection.outlook.com (10.152.250.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 15:25:28 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 15:25:28 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVmjaUpBZrOiNs+EaePGmphxD+QQ==
Date:   Wed, 13 Nov 2019 15:25:28 +0000
Message-ID: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0139.ausprd01.prod.outlook.com
 (2603:10c6:0:30::24) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:B8B4D604FE598439E89D49B3271F42440E37D0D88DF5E64EFD4350D4096A5ECB;UpperCasedChecksum:AF7196EEAE44E004F9E478D5340C23B508F15D714B2F85930FF60B0926909E81;SizeAsReceived:7692;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [O818VoSQaju8eeBQkpaEfe9UYHffiMHNrAhfS3Cmmgp1un52Va67Z0OeNuHP6ExV1ZL8/upp+Ko=]
x-microsoft-original-message-id: <20191113152518.GA5035@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1119ab0b-23f1-4327-3dc7-08d7684db691
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?apgo5D0uMOHB83Q3IAA1jupPfhIWbrOgudL4TKq5QpkyHt7bZMMJXejlmsQc?=
 =?us-ascii?Q?bOHrqVW3i9NsHn2XJQuOR+aB4QYtyu5l4RCMqvgeu3lXCvh8+NeyLke2skhG?=
 =?us-ascii?Q?OFVZsN9W1RqsOqjL1bPEEx7D/XBwLDKbvAOkGYwSFhRYXLHkL2195pmSL1+I?=
 =?us-ascii?Q?YgpZ/pjtbkL80et9TEZHBblzEwfjx4z3xroos5afo2PMq+taLOjIvo/tApJG?=
 =?us-ascii?Q?gp3QRuDF6M1OKx2xybClkWx6pF8KkIKMubRWoZikous++QOYR5h2JIO3Ngbw?=
 =?us-ascii?Q?HX2rdm4C6rfHynDZakJwWIcwgWXKAazr/r/6jC3X9sUaZ4X/IghUmagxari+?=
 =?us-ascii?Q?raWaZ0fqvWRw15cLVxXyLCEd9wgqlheutQX9sHLPk0XWYA5aawueLjhhQB1s?=
 =?us-ascii?Q?ahy+524TS/9bAxixbX75iFrteXpIUhfTrxbAURbIzD70NzzRJAjmxRg+Y7Pi?=
 =?us-ascii?Q?ilm/NiNAfnPRrv9i5I21mpw/h0jlsnC5XsFRLQtGHMvIjGKtN/lZTgaL+lsa?=
 =?us-ascii?Q?fpXwU5SOQw0ro+bWvKEgz11SxSjBoui1FhoGeD2kZ7Y1Y2ZghwlqVObxGiVN?=
 =?us-ascii?Q?ikgUCnTpsAs4eoiQ7p81R1uYLMytKA1NWhy8SSU46xP0q7DynxSNn00g2yMp?=
 =?us-ascii?Q?poheDOEZYxsP0b8lo3TekXlphNR/d2amd3QA77OrKMmNNuskLKNCMYG7znC4?=
 =?us-ascii?Q?rDycf07T4vJH/2AhvZmeyTIhsTy9Y24CilALSNMr7h8Xrwf5Z/J+W2CnkJ7C?=
 =?us-ascii?Q?hJfI/EUUWtGXOccNJpESPYMw9sAT66qoICZWBQPyQGEw4h8K5EE1sABf7K9x?=
 =?us-ascii?Q?0VzzvBto0DIJScbNZxLZj5NSLlS6yUi3Kn8WDuGw8bU+D8koIuvm2ebYPGz+?=
 =?us-ascii?Q?ljgXosZZnHPH0uXfttauaL9UGWdJxMLgkKbes2P7l+w+sx1eG9Q1uqgGrChL?=
 =?us-ascii?Q?5J59HEf36Z4HihRjt2JHrGJ2UIQMMvZ/5E39ESNqBl4l+cNsbQxGog=3D=3D?=
x-ms-traffictypediagnostic: SG2APC01HT016:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1z6mmAmRby381ZwmzY01UruLvMDdcVVNuHQu8YlJ7ZpCvElIva1ePMweQIeXDe94e91iqTP9cGbIegdXkjSsx0NEZOxI0aNruZrUR8xlYD0Mo0ep3QWwceDtjEMvwFh0WWQt6ruRQGrkU1RahpAyHDwFMKNDTCBmiTDfkB3xnOjiGuirn+sP7cCB49t4J7k
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E0A4F96E5AFB047B0486FDF93B35B5D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1119ab0b-23f1-4327-3dc7-08d7684db691
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 15:25:28.4485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT016
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently, the kernel can sometimes assign the MMIO_PREF window
additional size into the MMIO window, resulting in extra MMIO additional
size, despite the MMIO_PREF additional size being assigned successfully
into the MMIO_PREF window.

This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
fails. In the next pass, because MMIO_PREF is already assigned, the
attempt to assign MMIO_PREF returns an error code instead of success
(nothing more to do, already allocated). Hence, the size which is
actually allocated, but thought to have failed, is placed in the MMIO
window.

Example of problem (more context can be found in the bug report URL):

Mainline kernel:
pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M

Patched kernel:
pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M

This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
with the same configuration, with a Ubuntu mainline kernel and a kernel
patched with this patch.

The bug results in the MMIO_PREF being added to the MMIO window, which
means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
the MMIO window will likely fail to be assigned altogether due to lack
of 32-bit address space.

Change find_free_bus_resource() to do the following:
- Return first unassigned resource of the correct type.
- If none of the above, return first assigned resource of the correct type.
- If none of the above, return NULL.

Returning an assigned resource of the correct type allows the caller to
distinguish between already assigned and no resource of the correct type.

Rename find_free_bus_resource to find_bus_resource_of_type().

Add checks in pbus_size_io() and pbus_size_mem() to return success if
resource returned from find_free_bus_resource() is already allocated.

This avoids pbus_size_io() and pbus_size_mem() returning error code to
__pci_bus_size_bridges() when a resource has been successfully assigned
in a previous pass. This fixes the existing behaviour where space for a
resource could be reserved multiple times in different parent bridge
windows.

Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243

Reported-by: Kit Chow <kchow@gigaio.com>
Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6b64bf909..f382f449b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -752,24 +752,32 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 }
 
 /*
- * Helper function for sizing routines: find first available bus resource
- * of a given type.  Note: we intentionally skip the bus resources which
- * have already been assigned (that is, have non-NULL parent resource).
+ * Helper function for sizing routines.
+ * Assigned resources have non-NULL parent resource.
+ *
+ * Return first unassigned resource of the correct type.
+ * If none of the above, return first assigned resource of the correct type.
+ * If none of the above, return NULL.
+ *
+ * Returning an assigned resource of the correct type allows the caller to
+ * distinguish between already assigned and no resource of the correct type.
  */
-static struct resource *find_free_bus_resource(struct pci_bus *bus,
-					       unsigned long type_mask,
-					       unsigned long type)
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
+						  unsigned long type_mask,
+						  unsigned long type)
 {
+	struct resource *r, *r_assigned = NULL;
 	int i;
-	struct resource *r;
 
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
 		if (r && (r->flags & type_mask) == type && !r->parent)
 			return r;
+		if (r && (r->flags & type_mask) == type && !r_assigned)
+			r_assigned = r;
 	}
-	return NULL;
+	return r_assigned;
 }
 
 static resource_size_t calculate_iosize(resource_size_t size,
@@ -866,8 +874,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
-							IORESOURCE_IO);
+	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
+								IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
@@ -875,6 +883,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 	if (!b_res)
 		return;
 
+	/* If resource is already assigned, nothing more to do. */
+	if (b_res->parent)
+		return;
+
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
@@ -978,7 +990,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -987,6 +999,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (!b_res)
 		return -ENOSPC;
 
+	/* If resource is already assigned, nothing more to do. */
+	if (b_res->parent)
+		return 0;
+
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
-- 
2.24.0

