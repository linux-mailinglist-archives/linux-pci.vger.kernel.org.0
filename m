Return-Path: <linux-pci+bounces-34588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A20B31D80
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C85BB40933
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 15:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C2E3128C7;
	Fri, 22 Aug 2025 14:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5cus/ZX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D912FFDD2;
	Fri, 22 Aug 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874759; cv=none; b=gfMAtSCiruzH5wIb7eoncVOTpAEQFY3nCL7oTq+41BQUqZfkYYgGoHDpQax4zYvTGMzKXvt3rSouN/5b9jTJ1GPFLK0Q1E9rL3c93oTxjKvC0Xs4kVVc3Fg9JAMJlMm5y4skVVJBLe4DqwPZEsGmMmy5cRaAAHnSEzzrz63EDNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874759; c=relaxed/simple;
	bh=Woq5i6B7u1BorPfYsOyd3IhFrLH3KrP16o8bmzdNAgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx//KdvwUaWj4kJIMwotgw25FvHmpy/GrkW0Pq23Q9nHbdrML4HJNo9iQp18WmpeUtM05cxiycxj9xt5jpk6ZTiEwskF7nW5PXvWt6gObXm1CTNYCu/uyylw7iFHtSdOEANLvVychfTcSOkJw5k4OTvqoyUY5/e9Etl/Zds/zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5cus/ZX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755874757; x=1787410757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Woq5i6B7u1BorPfYsOyd3IhFrLH3KrP16o8bmzdNAgc=;
  b=T5cus/ZXtVl3Lu/wTe3Mxri6ufqRGgHITRossUh7LIsmTGk+UJcUn4fD
   2RMwoZFWWOsQbMbrNBJxtYyExsDJ4b5SW8E8e6sBw+TxgDQEGEB34xNqA
   k5flQMaadVvzeU1wpduFcLddTAmWr/5pkd8hWm7O33xWsFz4NWp5Bn3Hp
   sOewq4DgDiCQPSGQCV8SRtlDwjl/MRbe0QrNrd7wETpFFfx4eM10n6dKo
   ALL44wLf5tIoPa9A52ep8BfpPSw+yrOae2+yEm2ZR4byDSO+Devtw2cp9
   5vlI9psgUtIdHJmDoMxxTAUlCC8r16NPdy6wUJmlPk9E3x5gRMe/+ORHs
   w==;
X-CSE-ConnectionGUID: 2JONFelPQAOX/4evrXgUsw==
X-CSE-MsgGUID: xohRjbklQ72b10VABym81w==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="57201604"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="57201604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:17 -0700
X-CSE-ConnectionGUID: 2CZi8veKRJ6pf21LAS/Ivg==
X-CSE-MsgGUID: U31QFJe4TCKDYDvfFz/SHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="199695308"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 07:59:09 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 19/24] PCI: Use pbus_select_window_for_type() during mem window sizing
Date: Fri, 22 Aug 2025 17:56:00 +0300
Message-Id: <20250822145605.18172-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
References: <20250822145605.18172-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_bus_size_bridges() goes to great lengths of helping
pbus_size_mem() in which types it should put into a particular bridge
window, requiring passing up to three resource type into
pbus_size_mem().

Instead of having complex logic __pci_bus_size_bridges() and a
non-straightforward interface between those functions, use
pbus_select_window_for_type() and pbus_select_window() to find the
correct bridge window and compare if the resources belong to that
window.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 111 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 87 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 281ca5c73c97..28133a9c5f51 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1284,24 +1284,22 @@ static bool pbus_upstream_space_available(struct pci_bus *bus,
  * pbus_size_mem() - Size the memory window of a given bus
  *
  * @bus:		The bus
- * @mask:		Mask the resource flag, then compare it with type
- * @type:		The type of free resource from bridge
- * @type2:		Second match type
- * @type3:		Third match type
+ * @type:		The type of bridge resource
  * @min_size:		The minimum memory window that must be allocated
  * @add_size:		Additional optional memory window
  * @realloc_head:	Track the additional memory window on this list
  *
- * Calculate the size of the bus and minimal alignment which guarantees
- * that all child resources fit in this size.
+ * Calculate the size of the bus resource for @type and minimal alignment
+ * which guarantees that all child resources fit in this size.
  *
- * Return -ENOSPC if there's no available bus resource of the desired
- * type.  Otherwise, set the bus resource start/end to indicate the
- * required size, add things to realloc_head (if supplied), and return 0.
+ * Sets the bus resource start/end to indicate the required size if there an
+ * available unassigned bus resource of the desired @type.
+ *
+ * Adds optional resource requests to the @realloc_head list if it is
+ * supplied.
  */
-static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
-			 unsigned long type, unsigned long type2,
-			 unsigned long type3, resource_size_t min_size,
+static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
+			 resource_size_t min_size,
 			 resource_size_t add_size,
 			 struct list_head *realloc_head)
 {
@@ -1309,19 +1307,18 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
 	resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
 	int order, max_order;
-	struct resource *b_res = find_bus_resource_of_type(bus,
-					mask | IORESOURCE_PREFETCH, type);
+	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
 	resource_size_t relaxed_align;
 
 	if (!b_res)
-		return -ENOSPC;
+		return;
 
 	/* If resource is already assigned, nothing more to do */
 	if (b_res->parent)
-		return 0;
+		return;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -1338,11 +1335,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			if (!pdev_resources_assignable(dev) ||
 			    !pdev_resource_should_fit(dev, r))
 				continue;
-
-			if ((r->flags & mask) != type &&
-			    (r->flags & mask) != type2 &&
-			    (r->flags & mask) != type3)
+			if (b_res != pbus_select_window(bus, r))
 				continue;
+
 			r_size = resource_size(r);
 
 			/* Put SRIOV requested res to the optional list */
@@ -1428,7 +1423,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			pci_info(bus->self, "disabling bridge window %pR to %pR (unused)\n",
 				 b_res, &bus->busn_res);
 		b_res->flags |= IORESOURCE_DISABLED;
-		return 0;
+		return;
 	}
 
 	resource_set_range(b_res, min_align, size0);
@@ -1441,7 +1436,6 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			   (unsigned long long) (size1 - size0),
 			   (unsigned long long) add_align);
 	}
-	return 0;
 }
 
 unsigned long pci_cardbus_resource_alignment(struct resource *res)
@@ -1546,12 +1540,11 @@ static void pci_bus_size_cardbus(struct pci_bus *bus,
 void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	unsigned long mask, prefmask, type2 = 0, type3 = 0;
 	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
 			additional_mmio_pref_size = 0;
 	struct resource *pref;
 	struct pci_host_bridge *host;
-	int hdr_type, ret;
+	int hdr_type;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		struct pci_bus *b = dev->subordinate;
@@ -1601,71 +1594,15 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
 			     additional_io_size, realloc_head);
 
-		/*
-		 * If there's a 64-bit prefetchable MMIO window, compute
-		 * the size required to put all 64-bit prefetchable
-		 * resources in it.
-		 */
-		mask = IORESOURCE_MEM;
-		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		if (pref && (pref->flags & IORESOURCE_MEM_64)) {
-			prefmask |= IORESOURCE_MEM_64;
-			ret = pbus_size_mem(bus, prefmask, prefmask,
-				prefmask, prefmask,
-				realloc_head ? 0 : additional_mmio_pref_size,
-				additional_mmio_pref_size, realloc_head);
-
-			/*
-			 * If successful, all non-prefetchable resources
-			 * and any 32-bit prefetchable resources will go in
-			 * the non-prefetchable window.
-			 */
-			if (ret == 0) {
-				mask = prefmask;
-				type2 = prefmask & ~IORESOURCE_MEM_64;
-				type3 = prefmask & ~IORESOURCE_PREFETCH;
-			}
-		}
-
-		/*
-		 * If there is no 64-bit prefetchable window, compute the
-		 * size required to put all prefetchable resources in the
-		 * 32-bit prefetchable window (if there is one).
-		 */
-		if (!type2) {
-			prefmask &= ~IORESOURCE_MEM_64;
-			ret = pbus_size_mem(bus, prefmask, prefmask,
-				prefmask, prefmask,
-				realloc_head ? 0 : additional_mmio_pref_size,
-				additional_mmio_pref_size, realloc_head);
-
-			/*
-			 * If successful, only non-prefetchable resources
-			 * will go in the non-prefetchable window.
-			 */
-			if (ret == 0)
-				mask = prefmask;
-			else
-				additional_mmio_size += additional_mmio_pref_size;
-
-			type2 = type3 = IORESOURCE_MEM;
+		if (pref) {
+			pbus_size_mem(bus,
+				      IORESOURCE_MEM | IORESOURCE_PREFETCH |
+				      (pref->flags & IORESOURCE_MEM_64),
+				      realloc_head ? 0 : additional_mmio_pref_size,
+				      additional_mmio_pref_size, realloc_head);
 		}
 
-		/*
-		 * Compute the size required to put everything else in the
-		 * non-prefetchable window. This includes:
-		 *
-		 *   - all non-prefetchable resources
-		 *   - 32-bit prefetchable resources if there's a 64-bit
-		 *     prefetchable window or no prefetchable window at all
-		 *   - 64-bit prefetchable resources if there's no prefetchable
-		 *     window at all
-		 *
-		 * Note that the strategy in __pci_assign_resource() must match
-		 * that used here. Specifically, we cannot put a 32-bit
-		 * prefetchable resource in a 64-bit prefetchable window.
-		 */
-		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
+		pbus_size_mem(bus, IORESOURCE_MEM,
 			      realloc_head ? 0 : additional_mmio_size,
 			      additional_mmio_size, realloc_head);
 		break;
-- 
2.39.5


