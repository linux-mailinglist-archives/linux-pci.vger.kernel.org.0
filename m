Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96B7F3073
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfKGNvE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 7 Nov 2019 08:51:04 -0500
Received: from mail-oln040092255021.outbound.protection.outlook.com ([40.92.255.21]:11229
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388982AbfKGNvD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 08:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFufD2IaSmEay0lU1KaW54GmoYbBI9q72K5quGTPcy++UVL6U+a2gCA5iy5e/X/vVaNh8AxCIFUrJCtL7l26wR18ebQMkLEGw0dBRyOHK6nKqDGUQQPRJfiP6xCC2SvqnYQgU1QniSH0PPeXlbOO9pqOm3G1MTc1uw+Zs9invVEq9VNaZcJzZSoeyjwfmS4FIAsj2e0ZFdQ6QFqM/9GRUaWOsWo9U0FqxingiPhaO9lAFQVpmzRnK21K1uevzRj53qA218yLPlqSyzfF93T3Rsu/gtDLU99kKqx8ri8U0uuDyvzT+l1boJafRixliCxc79KsiS0KwE6oqrzwdyZT2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI+uufuPP9sC6LXTJYNWkFbGvGXFQCkOzWtMJCqcTMU=;
 b=LLr/ohQEFqITjrZG7yG9Pjvn+t9LFvX2gVQmfPFn0CkMvdx8TrOKc5KcDmbXQZs27TZQpGr/XfkGfeLIembQcjh96MOAGngpN3h6ERavXa1WpDaARd5cdVXUpsmgz9dhzLKhZ665Hg3rFSShQuXgyPxpwLUvooaedSEBm1m5BpZl5gV4zmDcxM6sKzD3ATiqYPOu+a9R2AKVq3O4VzWKn1tTPyFGTXoGNo8zThcaDpoTKvk8Xs1ieuRBWhLOxfgqlrySs8zusxrzguKCMgp2or2ClRWvi1/XL98b3zKb/bQCMlOVQydJyixTgKHlAw8mZbzDkzU5XELa0Acumum42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT033.eop-APC01.prod.protection.outlook.com
 (10.152.252.55) by PU1APC01HT215.eop-APC01.prod.protection.outlook.com
 (10.152.253.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.20; Thu, 7 Nov
 2019 13:50:58 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.252.57) by
 PU1APC01FT033.mail.protection.outlook.com (10.152.252.223) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Thu, 7 Nov 2019 13:50:58 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2430.020; Thu, 7 Nov 2019
 13:50:58 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being assigned
 to MMIO window
Thread-Topic: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVlXJhu/GZEUU1TEqW4eFw21Odow==
Date:   Thu, 7 Nov 2019 13:50:57 +0000
Message-ID: <PS2P216MB07554FF63C34AFBCE04BD55D80780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0094.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::27) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:1BD63F89AF17C8A985E24271CA4C6FA43429E886C298EEEBB2F5A7C5CD2C4D15;UpperCasedChecksum:1A0B6C98FC573AEB5216C9CE327B7BD283149DE138FDD99C2047F96123CBA6BD;SizeAsReceived:7698;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [5+85QQlwJLUPeNZKHoIE2V95Ql8OOACjhImoPMbK4sCzt4wmOrgWSscWGHhOqUR3QHxlGd8o9hQ=]
x-microsoft-original-message-id: <20191107135049.GA2226@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 938733c8-0ce4-4bd4-5592-08d76389842f
x-ms-exchange-slblob-mailprops: =?us-ascii?Q?apgo5D0uMOH7R4Jh+Ss+wm6YNDg3QpWRKuL1spoRVb5kRv9dXynUE0daLHK7?=
 =?us-ascii?Q?1jVuYM6OQ6RDcJ7wWAKrhlUNuR67h/lWuzLmWaL6lhHKFEOs6J0Q5hjpmgzQ?=
 =?us-ascii?Q?F52nOGRYYViY/2yu8NqhpZj4Vm/OsvDcPzLdZGNl9Jlo0bmTxwECIYeSLxMW?=
 =?us-ascii?Q?T+Xs5517Sn5rm8Ct4AqcbsgjLwgGuR57HWgLOjk4mtU5vaNDFLr2A8HoC15e?=
 =?us-ascii?Q?3pBLJwbKsd3kBoOYsFcvbZ04Kl5WA1TDzMoa16Z1iC6p0RXn9Ec6XK5htaf/?=
 =?us-ascii?Q?3atCIadwK/N7cVXZYDi1Nsg4YGGocpyVvd6ib2Sr83Oae+Q40zCsGl8nUUgH?=
 =?us-ascii?Q?BF1SqDg+v9b1z4NEyFTjH6YsODtDC7vflzLf3gdHiQXzkD8ADMWl5VpQiPH9?=
 =?us-ascii?Q?DkzCvD8Ung02MlorRS22dDo1JEFta3QxRqXwE49Xg5SuC1ZAmT3GLzsPrh8T?=
 =?us-ascii?Q?CgGU1F6kLA59YB/Kf2gaqfLANt+rENPv/xNzbNhkExyGuzv47qM23RWJxMRZ?=
 =?us-ascii?Q?t5SMfkqAbwTO+vSPNZoneBurbO0lLfHnKCiyWz0lMjUelEDcTaw3kXRonRRJ?=
 =?us-ascii?Q?tXvM6schKU1mBcSRy+TmHckUsH2fFnYiO08MADCHMUOfybEraEJW0hXSk4bl?=
 =?us-ascii?Q?bd/W0rc6HN5I9tiZ2tQqLP6Avn05dabFRjwbniqBH2tW2TBfNkVUA2LYGCWR?=
 =?us-ascii?Q?Divb4z51D4XOtHKBFAkmfyNZRA/1BBh7ZuwAbWL12n1w/Xa0lO5TEEXdgOag?=
 =?us-ascii?Q?mo5EBU9ThbHYCoeVM5MZjpIZ6VuP0rC1v9XgOJDHROPpfHf6hpy1vTIZgd/r?=
 =?us-ascii?Q?y6hvx2UKQmFc0TTh2k8cAOCDG55K1jLQHp1WvXVdBLcTWRepxv0gsa49j+DI?=
 =?us-ascii?Q?R0vRq5kApvrUUhTA/fFXsOf63LTLZJw/K4Li3nHPmUef+Fe8l+HrK8nlC2i7?=
 =?us-ascii?Q?IdHJu/z9NIJEFXABxs7de5xfGL0MT665bOpfVCj4LKMxhVrl9WFSZQ=3D=3D?=
x-ms-traffictypediagnostic: PU1APC01HT215:
x-ms-exchange-purlcount: 2
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BOeN1wcc3lRnrCLTF5IsqeMmWgNr//yGXtzBgmb3AoD0imzFyO6bJWQSv6oULE+s72HgGNxxD0KSj+jqCKxaSwmxqVE+CxvKdwpk6IB2T7Q+LuCFG5FksXYsswZ9Sa2cv70/aSj2HeMkAwoRLt27BWXQRDHMBup96uqIoigyEJHGphiGyXuSUMbp0UtIHfv1Gy3zlSzg3uXB2ie61+eMaxnlB4rqSpQqPw4YIkLJbG4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2E581EF043F344F96E7C3795F3B5FB9@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 938733c8-0ce4-4bd4-5592-08d76389842f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 13:50:57.8967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT215
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
---
 drivers/pci/setup-bus.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e7dbe2170..f97c36a1e 100644
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
 	int i;
-	struct resource *r;
+	struct resource *r, *r_assigned = NULL;
 
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
@@ -866,14 +874,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
 
 	if (!b_res)
 		return;
+	if (b_res->parent)
+		return;
 
 	min_align = window_alignment(bus, IORESOURCE_IO);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -978,7 +988,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
 	int order, max_order;
-	struct resource *b_res = find_free_bus_resource(bus,
+	struct resource *b_res = find_bus_resource_of_type(bus,
 					mask | IORESOURCE_PREFETCH, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
@@ -986,6 +996,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 
 	if (!b_res)
 		return -ENOSPC;
+	if (b_res->parent)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
-- 
2.23.0

