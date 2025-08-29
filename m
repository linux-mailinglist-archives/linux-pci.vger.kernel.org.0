Return-Path: <linux-pci+bounces-35116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8C9B3BC3E
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 409621CC2CD8
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD631B105;
	Fri, 29 Aug 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1bYRDkd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A67A31A57B;
	Fri, 29 Aug 2025 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473224; cv=none; b=DXMbliuOodhgBP1H/rf1tRXrymzhWNyk+JGSPRsHnnYTduKrH6CZ/uu2uGg/y/m0v4q4uE6vXHqIF2v0dtZLncOgWUVZHRDGzlBpF5/WkErRqn/rxPIAYo3pU9YSodb2YP5MkLzk/bkIuEpkvkkRbBlDg1Fm3WYAcU/5bXRpak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473224; c=relaxed/simple;
	bh=+NtJ+Uue6BNbxIbx+lobKHWr+5pQ6wDU3MkHBfUh5N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnVCNfjIezzMDK05H4uZFC+RgNQStsBOIzwi7FN0J42+EAnJpLIM1IwHAwbYN6l7DJQy9n7Q/lgG59n7JrY+ul3nKfDMDD1ar1y12DYa7wlhWd52IlMEXeX+E4FL40oaCXVsvkykUlmCrIMhMjJMXbPmgTEzrCHlfBBVc86ius8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1bYRDkd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473224; x=1788009224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+NtJ+Uue6BNbxIbx+lobKHWr+5pQ6wDU3MkHBfUh5N8=;
  b=I1bYRDkdqQrSqcm+TttNlykJBS0CuAJPAqkJVzsikAutYGoLDwez3ThW
   E8YontTSgUlW5uJS1IX+KkEcL6NhEAms83vYZAYGdcMa2pt01Z6jbdxT7
   iHUmFhlue1LM+hkzXjQ6MV8iGIo2EaaBDv7Tg8VKqXlh8mhxXmEZBpJeJ
   tm8P7nud/yrUwPghX45WtwMUMbRRi7iXV5SZI8zfas82A/aAV5sXrmB3Y
   TXjT8U2pjfuTLAJcTCWpJsidOnUOYCMupb+lRHxDwlRK/LSTXx/JORuvM
   2Zh0xdf0YiGOJ75PHCBizbG9OKYEwTQ1KHS5in1tNCjZdHYz/8+EnoU+P
   Q==;
X-CSE-ConnectionGUID: 3NjHi6PbQdeydb/yOatrDg==
X-CSE-MsgGUID: /HHRxUd8SdO8JEZ9L1pRMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62587510"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62587510"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:43 -0700
X-CSE-ConnectionGUID: oX/DVL9AQDqqfbd2c6dOOg==
X-CSE-MsgGUID: N/3i7VQ1SZGIaa4UX+LucA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="175656793"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 19/24] PCI: Use pbus_select_window_for_type() during mem window sizing
Date: Fri, 29 Aug 2025 16:11:08 +0300
Message-Id: <20250829131113.36754-20-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_bus_size_bridges() goes to great lengths of helping pbus_size_mem()
in which types it should put into a particular bridge window, requiring
passing up to three resource type into pbus_size_mem().

Instead of having complex logic in __pci_bus_size_bridges() and a
non-straightforward interface between those functions, use
pbus_select_window_for_type() and pbus_select_window() to find the correct
bridge window and compare if the resources belong to that window.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 111 +++++++++-------------------------------
 1 file changed, 24 insertions(+), 87 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 865bacae9cac..720159bca54d 100644
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
+ * Set the bus resource start/end to indicate the required size if there an
+ * available unassigned bus resource of the desired @type.
+ *
+ * Add optional resource requests to the @realloc_head list if it is
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


