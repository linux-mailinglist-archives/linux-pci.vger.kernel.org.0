Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2535BE34
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 16:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbfGAO0U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 1 Jul 2019 10:26:20 -0400
Received: from mail-oln040092254057.outbound.protection.outlook.com ([40.92.254.57]:39968
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728090AbfGAO0U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 10:26:20 -0400
Received: from PU1APC01FT027.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT229.eop-APC01.prod.protection.outlook.com
 (10.152.252.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Mon, 1 Jul
 2019 14:26:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.60) by
 PU1APC01FT027.mail.protection.outlook.com (10.152.252.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Mon, 1 Jul 2019 14:26:13 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 14:26:13 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: [PATCH v7 8/8] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH v7 8/8] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVMBjvqV0RKtw8Ak6fj/QX5/LnSQ==
Date:   Mon, 1 Jul 2019 14:26:13 +0000
Message-ID: <SL2P216MB01875E7B53742E46B53F820280F90@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:10:1::30) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:0491EC7E998529029537C9166345947E22827050F8FE0A7ABA42EE12E0661AB2;UpperCasedChecksum:7F834409EF0D15F526E804CCEF51FAA354189B661292B6015E0A66B2237F2177;SizeAsReceived:7740;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qOTMwuQhe05QBO2JJaiCjQbv6eU213CbqdrqmtJJ+k2hCE8Gal/GVr64Sjyi0r9KFq4wsC+pcL4=]
x-microsoft-original-message-id: <20190701142558.GA5338@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT229;
x-ms-traffictypediagnostic: PU1APC01HT229:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-message-info: ytnBVmlXWhAwbeHYbRAvaR/da1tEG0nSV388QAd6mwmywHdL3WzqEeq/aAvfiLjRwwVBa3p18VOEWgzimb0HKj8uu2YiDXdwAqjANTI1SAL+R02/nbzH0xmhI7LTWU9KXz4WwN0sgXoBQd5ow1QvXIkUKavQ/aWb4AvERRa/ZGN+Sm1sbydJ24OIMqQysukA
Content-Type: text/plain; charset="us-ascii"
Content-ID: <955A3DC6DF62EE4E8C686282AA5D1281@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 156990db-d3ff-45aa-22a7-08d6fe30120e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 14:26:13.7738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT229
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Background
==========================================================================

Currently, the kernel can sometimes assign the MMIO_PREF window
additional size into the MMIO window, resulting in double the MMIO
additional size, even if the MMIO_PREF window was successful.

This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
fails. In the next pass, because MMIO_PREF is already assigned, the
attempt to assign MMIO_PREF returns an error code instead of success
(nothing more to do, already allocated).

Example of problem (more context can be found in the bug report URL):

Mainline kernel:
pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M

Patched kernel:
pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M

This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
with the same configuration, with a Ubuntu mainline kernel and a kernel
patched with this patch series.

This patch is vital for the next patch in the series. The next patch
allows the user to specify MMIO and MMIO_PREF independently. If the
MMIO_PREF is set to be very large, this bug will end up more than
doubling the MMIO size. The bug results in the MMIO_PREF being added to
the MMIO window, which means doubling if MMIO_PREF size == MMIO size.
With a large MMIO_PREF, without this patch, the MMIO window will likely
fail to be assigned altogether due to lack of 32-bit address space.

Patch notes
==========================================================================

Change find_free_bus_resource() to not skip assigned resources with
non-null parent.

Add checks in pbus_size_io() and pbus_size_mem() to return success if
resource returned from find_free_bus_resource() is already allocated.

This avoids pbus_size_io() and pbus_size_mem() returning error code to
__pci_bus_size_bridges() when a resource has been successfully assigned
in a previous pass. This fixes the existing behaviour where space for a
resource could be reserved multiple times in different parent bridge
windows. This also greatly reduces the number of failed BAR messages in
dmesg when Linux assigns resources.

See related from Logan Gunthorpe (same problem, different solution):
https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u

Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=203243

Reported-by: Kit Chow <kchow@gigaio.com>
Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 drivers/pci/setup-bus.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 873df5482..df4bf43b5 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -752,13 +752,18 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
 }
 
 /*
- * Helper function for sizing routines: find first available bus resource
- * of a given type.  Note: we intentionally skip the bus resources which
- * have already been assigned (that is, have non-NULL parent resource).
+ * Helper function for sizing routines: find first bus resource of a given
+ * type. Note: we do not skip the bus resources which have already been
+ * assigned (r->parent != NULL). This is because a resource that is already
+ * assigned (nothing more to be done) will be indistinguishable from one that
+ * failed due to lack of space if we skip assigned resources. If the caller
+ * function cannot tell the difference then it might try to place the
+ * resources in a different window, doubling up on resources or causing
+ * unforeseeable issues.
  */
-static struct resource *find_free_bus_resource(struct pci_bus *bus,
-					       unsigned long type_mask,
-					       unsigned long type)
+static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
+						   unsigned long type_mask,
+						   unsigned long type)
 {
 	int i;
 	struct resource *r;
@@ -766,7 +771,7 @@ static struct resource *find_free_bus_resource(struct pci_bus *bus,
 	pci_bus_for_each_resource(bus, r, i) {
 		if (r == &ioport_resource || r == &iomem_resource)
 			continue;
-		if (r && (r->flags & type_mask) == type && !r->parent)
+		if (r && (r->flags & type_mask) == type)
 			return r;
 	}
 	return NULL;
@@ -866,14 +871,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
-							IORESOURCE_IO);
+	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
+							   IORESOURCE_IO);
 	resource_size_t size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
 	resource_size_t min_align, align;
 
 	if (!b_res)
 		return;
+	if (b_res->parent)
+		return;
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -978,7 +985,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -986,6 +993,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (!b_res)
 		return -ENOSPC;
+	if (b_res->parent)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
-- 
2.20.1

