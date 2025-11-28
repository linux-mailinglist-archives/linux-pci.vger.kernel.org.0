Return-Path: <linux-pci+bounces-42260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40FFC91E00
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D320D3AE0C0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6D32570E;
	Fri, 28 Nov 2025 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9cc+tEc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3331D2F1FD3;
	Fri, 28 Nov 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330663; cv=none; b=JhNFcw0PzpMiZSeYzw/Oh44lXL2DxGwqUg+hgd5w2JLpJ8ByLiJ3E/s7yBxtb0kmnaGh/4Kei2StDZkqegg4n8KOp4GIsNPhfooHSn2cQW/SaTpvNTPy4u+6K7gUHe5j/eI+0JKMce9r9aYDWaE2zlvZRp2aKdNe7A7ucTt72zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330663; c=relaxed/simple;
	bh=p1K7iuDhai8jqvLoc236iWaHbkXWlAAYEFEd5ZuRe0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGX8hNDTzLlKnUWkSr8WjcJINLQXmwxHpFNMLjxR5+oh80DxcatXG5BIOrX9MSiJZLZWpOO8kNi8gCEcRgjmTWfIkCOZy4x6PsXuUthUdPaIEMPrvzXfLPbHnbHkvFpxQ2nTuA41jPibXaFtp8CEB+ipjVaFP6NfHPlLwfO8x88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9cc+tEc; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330661; x=1795866661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p1K7iuDhai8jqvLoc236iWaHbkXWlAAYEFEd5ZuRe0c=;
  b=D9cc+tEc6zhslz2F5qDTkwpVRlejZ2EkI7014gj3vMNQ6tpmm/xrDIoS
   5Np+ORPdyEvWP1m36JSPFuSf/Be+rsViDXuGu5jDM0SzLqHjNR+tPWC0e
   Hj45YByTOadaMV7f8NmsiTi3KpgUFwIJrt0l0m6e6Z2TGGRi+mU6Wnx/4
   xfXpBWDGa9enyaK6M/ClImLZ8AxpD1AZjF7YnIChtVOD1NORg8iD9S9r9
   /MySDBoDijY6z2A8RzMp51Hy/VjvW/O+6SCXNPoMyyoGwL+xX45DlqQeS
   OpcVDW/9hGtXuFMBc5PPEFaaAXmakbdgrKwaVUT+/QbOgzn6fkQ6RrZnJ
   A==;
X-CSE-ConnectionGUID: mEm0Lx7JRAunKmPKZ4TDCQ==
X-CSE-MsgGUID: v4BrHCx1TYOs532Ukg6Erw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66437147"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66437147"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:51:00 -0800
X-CSE-ConnectionGUID: n1W1ctP5TxqRhXIEMC7iiA==
X-CSE-MsgGUID: UaNtbjQ/T36y9w/W5OjahA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="230725467"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/4] PCI: Stop over-estimating bridge window size
Date: Fri, 28 Nov 2025 13:50:20 +0200
Message-Id: <20251128115021.4287-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
References: <20251128115021.4287-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

New way to calculate the bridge window head alignment produces
tight-fit, that is, it does not leave any gaps between the resources.
Similarly, relaxed tail alignment does not leave extra tail room.

Start to use bridge window calculation that does not over-estimate
the size of the required window.

pbus_upstream_space_available() can be removed.

Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

This is relatively risky change when it comes to regressions. In static
setups things are likely okay (in my own testing, many systems had zero
differences or just one bridge window among many that was shrunk some, no
resulting any issue). In cases where resources are discovered later
(hotplug, pwrctrl, delayed enumeration, etc.) the difference might matter
more, if a reduced size results in resources not fitting. Those might be
addressable by provinding pci=hp*size=xx parameter which is the canonical
way to prepare for unknown, instead of relying on artifacts of the bridge
window alignment algorithm.

 drivers/pci/setup-bus.c | 97 +++--------------------------------------
 1 file changed, 5 insertions(+), 92 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 93f6b0750174..6f4bb2d19cc1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1263,68 +1263,6 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
 	return head_align;
 }
 
-/**
- * pbus_upstream_space_available - Check no upstream resource limits allocation
- * @bus:	The bus
- * @res:	The resource to help select the correct bridge window
- * @size:	The size required from the bridge window
- * @align:	Required alignment for the resource
- *
- * Check that @size can fit inside the upstream bridge resources that are
- * already assigned. Select the upstream bridge window based on the type of
- * @res.
- *
- * Return: %true if enough space is available on all assigned upstream
- * resources.
- */
-static bool pbus_upstream_space_available(struct pci_bus *bus,
-					  struct resource *res,
-					  resource_size_t size,
-					  resource_size_t align)
-{
-	struct resource_constraint constraint = {
-		.max = RESOURCE_SIZE_MAX,
-		.align = align,
-	};
-	struct pci_bus *downstream = bus;
-
-	while ((bus = bus->parent)) {
-		if (pci_is_root_bus(bus))
-			break;
-
-		res = pbus_select_window(bus, res);
-		if (!res)
-			return false;
-		if (!res->parent)
-			continue;
-
-		if (resource_size(res) >= size) {
-			struct resource gap = {};
-
-			if (find_resource_space(res, &gap, size, &constraint) == 0) {
-				gap.flags = res->flags;
-				pci_dbg(bus->self,
-					"Assigned bridge window %pR to %pR free space at %pR\n",
-					res, &bus->busn_res, &gap);
-				return true;
-			}
-		}
-
-		if (bus->self) {
-			pci_info(bus->self,
-				 "Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
-				 res, &bus->busn_res,
-				 (unsigned long long)size,
-				 pci_name(downstream->self),
-				 &downstream->busn_res);
-		}
-
-		return false;
-	}
-
-	return true;
-}
-
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -1351,7 +1289,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
 	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
-	resource_size_t aligns2[28] = {};/* Alignments from 1MB to 128TB */
 	int order, max_order;
 	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
@@ -1410,13 +1347,8 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 				continue;
 			}
 			size += max(r_size, align);
-			/*
-			 * Exclude ranges with size > align from calculation of
-			 * the alignment.
-			 */
-			if (r_size <= align)
-				aligns[order] += align;
-			aligns2[order] += align;
+
+			aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
 
@@ -1430,38 +1362,19 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	old_size = resource_size(b_res);
 	win_align = window_alignment(bus, b_res->flags);
-	min_align = calculate_mem_align(aligns, max_order);
+	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, min_size, 0, 0, old_size, min_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
 
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
 		b_res->flags &= ~IORESOURCE_DISABLED;
 	}
 
-	if (bus->self && size0 &&
-	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
-		min_align = calculate_head_align(aligns2, max_order);
-		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
-		resource_set_range(b_res, min_align, size0);
-		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
-			 b_res, &bus->busn_res);
-	}
-
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
 		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
-					  old_size, add_align);
-
-		if (bus->self && size1 &&
-		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
-			min_align = calculate_head_align(aligns2, max_order);
-			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
-						  old_size, win_align);
-			pci_info(bus->self,
-				 "bridge window %pR to %pR requires relaxed alignment rules\n",
-				 b_res, &bus->busn_res);
-		}
+					  old_size, win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.39.5


