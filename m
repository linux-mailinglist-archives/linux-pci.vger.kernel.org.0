Return-Path: <linux-pci+bounces-43418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A37FCD1313
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 57A5A303A32F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC05431C567;
	Fri, 19 Dec 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pl7ZmB81"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716C2550CD;
	Fri, 19 Dec 2025 17:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166072; cv=none; b=CDWBGxhLi7bmTHPaDABs1BzS37R+Q068t0aKFsn6WCp1OjkChbrJmTJH4cu1zdTaiotFU+Nl4y0vXKWliuWvkeJZNJ9Hdl3L4dahr7Z3vK9GQ4zaXSmZVsVMdP5vLuRwdXx8alAR3XJE464wCf2rliC27d8mMpfuZuJXtFABY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166072; c=relaxed/simple;
	bh=t30lVJQEU6WT/a/Bxul6FfcQqHWRcb1g3HQCiYFMj0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKaNcqaQpYtq2+12VTXhgEjHbTvtBa0TN4STnlvheqyHT/BSKAKO1dFVi6H4KPJzATBI7h8l3WG0RTRiFlhZ7ubaCaXxTW5Nh2Ag/XaddDePzJvzcz6v06/mpb0wZOntiXvF2YHRpdTAZa+fc3to8DdvTxsqrS5GkJw19KLopeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pl7ZmB81; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166071; x=1797702071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t30lVJQEU6WT/a/Bxul6FfcQqHWRcb1g3HQCiYFMj0Y=;
  b=Pl7ZmB81WOzPnvsXz4YjpMe5mH1S8vcRXJRVnC9AwCBXwmFlYyzdAKnH
   rNWyKXTYJIAodZIy8O7MLZejs1ZLFPGjs/lCRR787kBJcPC+pvURG6Oz4
   G+nSAQL8cN8gNvWhGV2W6YNcXg4N+crarIkREl3Cb+iIKC+9du/8MMKLb
   3EcHmJBMHiXTFX48Ine02t2KT7vrs7XSq6VY1pXQpU8XHJAW2UIiie+cl
   Yoq980nmno3sGWHbzkxTqF36jtRWiutrS7omQRJqH29yUq+6Z9TZk6xQS
   AIJ31OwHJI8St0QYcPGCbtWcw5A2ktV0lEIB8OFY8RIp3RkKg4aWyhpWN
   w==;
X-CSE-ConnectionGUID: TYTj+lz1Rumi56wFb2cb8w==
X-CSE-MsgGUID: K5lXugAWQamRzLUEDeI/gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173812"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173812"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:11 -0800
X-CSE-ConnectionGUID: YBmqRLY5TF6KTNaL629YKg==
X-CSE-MsgGUID: 3sfBLDXpSZS5YWxDhadX/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198974833"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>
Subject: [PATCH 03/23] PCI: Stop over-estimating bridge window size
Date: Fri, 19 Dec 2025 19:40:16 +0200
Message-Id: <20251219174036.16738-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
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
 drivers/pci/setup-bus.c | 97 +++--------------------------------------
 1 file changed, 5 insertions(+), 92 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 80e5a8fc62e7..612288716ba8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1267,68 +1267,6 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
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
@@ -1355,7 +1293,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
 	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
-	resource_size_t aligns2[28] = {};/* Alignments from 1MB to 128TB */
 	int order, max_order;
 	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
@@ -1414,13 +1351,8 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
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
 
@@ -1434,38 +1366,19 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
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


