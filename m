Return-Path: <linux-pci+bounces-43417-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4635ECD1340
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68D8730AFBE2
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E236231C567;
	Fri, 19 Dec 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AdZW13Mm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74482F7AB0;
	Fri, 19 Dec 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166065; cv=none; b=XI0i5OAn/U6YPXaRrA/cwZuLW3SDoo7yNVf3wKiDYCp8ejNrDUtgeSC8l3b6/TKmAuikzLm0cmM/kvWZXDsN3IwT9/HU5XWvtSO2kuJ26cybk6QptJo2MRtMqOcZQ80OZHLNh032QBEpH58QUjIAI1WdJFBgQ7Uo11U/TgDfSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166065; c=relaxed/simple;
	bh=iDk5PDFyCbkxThYZSXCCggnIbQTec9fz3huwZNw1Nfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HiZxAw0DAT9SmadAZMhrh9ZxFMI8i7p5kBrO71xrheba+U08tzYyK+aFCoxSgDr6mKX6tExrpMVvHwkhD1j9TcyXN5ORuO8wY9+XlDB7nrW76FyJhKci7ttC5IOJZf5m0gm61G2vY/IFdSM459pPGP5GYgq3mJZBuTFQLBKjxfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AdZW13Mm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166064; x=1797702064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iDk5PDFyCbkxThYZSXCCggnIbQTec9fz3huwZNw1Nfg=;
  b=AdZW13Mm+t0yKW0fcd7uN1Lq8JKb0LNrZ3ASbjzAjg6Y+1Y2Nlu5AkUz
   aJybeH2mL4AOZcPrs5QrfuqOVK3LN6+Cq0V2pbBDV3gM5fy3WFs5xZGFQ
   4pTaO+FFt8fekPz2mvCOLOO/Qmcgz/jbGBn+BKccwsDkRX23mWC3TaTis
   gtrhSzAFLBYj0NmhSTOrKzYZFd0YkRrIkanjflZDZUOyd899P3kAEdT5i
   oc9HbRWdfT8MBL5PsOiYcTOkX/DakbU4gMHBVX8qjFD+Bq9DdwCvmvHtK
   O/FDJaHAO668Aoq2JoKAq0HN8uA2H7/7aqyLyUQmbTYxFOqBW6VSu4Aj7
   A==;
X-CSE-ConnectionGUID: wX+rZM77Qd6Hbk6y53mmxg==
X-CSE-MsgGUID: a+CwPzFrRb6DxbedzunCqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173796"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173796"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:03 -0800
X-CSE-ConnectionGUID: FGM9Y0nBQKWT7mp1g/DL1A==
X-CSE-MsgGUID: YdgUYVN6SHS1IN/srEpldw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198974810"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	stable@vger.kernel.org
Subject: [PATCH 02/23] PCI: Rewrite bridge window head alignment function
Date: Fri, 19 Dec 2025 19:40:15 +0200
Message-Id: <20251219174036.16738-3-ilpo.jarvinen@linux.intel.com>
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

The calculation of bridge window head alignment is done by
calculate_mem_align() [*]. With the default bridge window alignment, it
is used for both head and tail alignment.

The selected head alignment does not always result in tight-fitting
resources (gap at d4f00000-d4ffffff):

    d4800000-dbffffff : PCI Bus 0000:06
      d4800000-d48fffff : PCI Bus 0000:07
        d4800000-d4803fff : 0000:07:00.0
          d4800000-d4803fff : nvme
      d4900000-d49fffff : PCI Bus 0000:0a
        d4900000-d490ffff : 0000:0a:00.0
          d4900000-d490ffff : r8169
        d4910000-d4913fff : 0000:0a:00.0
      d4a00000-d4cfffff : PCI Bus 0000:0b
        d4a00000-d4bfffff : 0000:0b:00.0
          d4a00000-d4bfffff : 0000:0b:00.0
        d4c00000-d4c07fff : 0000:0b:00.0
      d4d00000-d4dfffff : PCI Bus 0000:15
        d4d00000-d4d07fff : 0000:15:00.0
          d4d00000-d4d07fff : xhci-hcd
      d4e00000-d4efffff : PCI Bus 0000:16
        d4e00000-d4e7ffff : 0000:16:00.0
        d4e80000-d4e803ff : 0000:16:00.0
          d4e80000-d4e803ff : ahci
      d5000000-dbffffff : PCI Bus 0000:0c

This has not been caused problems (for years) with the default bridge
window tail alignment that grossly over-estimates the required tail
alignment leaving more tail room than necessary. With the introduction
of relaxed tail alignment that leaves no extra tail room whatsoever,
any gaps will immediately turn into assignment failures.

Introduce head alignment calculation that ensures no gaps are left and
apply the new approach when using relaxed alignment. We may want to
consider using it for the normal alignment eventually, but as the first
step, solve only the problem with the relaxed tail alignment.

([*] I don't understand the algorithm in calculate_mem_align().)

Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220775
Reported-by: Malte Schröder <malte+lkml@tnxip.de>
Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---

Little annoyingly, there's difference in what aligns array contains
between the legacy alignment approach (which I dare not to touch as I
really don't understand what the algorithm tries to do) and this new
head aligment algorithm, both consuming stack space. After making the
new approach the only available approach in the follow-up patch, only
one array remains (however, that follow-up change is also somewhat
riskier when it comes to regressions).

That being said, the new head alignment could work with the same aligns
array as the legacy approach, it just won't necessarily produce an
optimal (the smallest possible) head alignment when if (r_size <=
align) condition is used. Just let me know if that approach is
preferred (to save some stack space).
---
 drivers/pci/setup-bus.c | 53 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4b918ff4d2d8..80e5a8fc62e7 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1228,6 +1228,45 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	return min_align;
 }
 
+/*
+ * Calculate bridge window head alignment that leaves no gaps in between
+ * resources.
+ */
+static resource_size_t calculate_head_align(resource_size_t *aligns,
+					    int max_order)
+{
+	resource_size_t head_align = 1;
+	resource_size_t remainder = 0;
+	int order;
+
+	/* Take the largest alignment as the starting point. */
+	head_align <<= max_order + __ffs(SZ_1M);
+
+	for (order = max_order - 1; order >= 0; order--) {
+		resource_size_t align1 = 1;
+
+		align1 <<= order + __ffs(SZ_1M);
+
+		/*
+		 * Account smaller resources with alignment < max_order that
+		 * could be used to fill head room if alignment less than
+		 * max_order is used.
+		 */
+		remainder += aligns[order];
+
+		/*
+		 * Test if head fill is enough to satisfy the alignment of
+		 * the larger resources after reducing the alignment.
+		 */
+		while ((head_align > align1) && (remainder >= head_align / 2)) {
+			head_align /= 2;
+			remainder -= head_align;
+		}
+	}
+
+	return head_align;
+}
+
 /**
  * pbus_upstream_space_available - Check no upstream resource limits allocation
  * @bus:	The bus
@@ -1315,13 +1354,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 {
 	struct pci_dev *dev;
 	resource_size_t min_align, win_align, align, size, size0, size1 = 0;
-	resource_size_t aligns[28]; /* Alignments from 1MB to 128TB */
+	resource_size_t aligns[28] = {}; /* Alignments from 1MB to 128TB */
+	resource_size_t aligns2[28] = {};/* Alignments from 1MB to 128TB */
 	int order, max_order;
 	struct resource *b_res = pbus_select_window_for_type(bus, type);
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
-	resource_size_t relaxed_align;
 	resource_size_t old_size;
 
 	if (!b_res)
@@ -1331,7 +1370,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	if (b_res->parent)
 		return;
 
-	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
 
@@ -1382,6 +1420,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 			 */
 			if (r_size <= align)
 				aligns[order] += align;
+			aligns2[order] += align;
 			if (order > max_order)
 				max_order = order;
 
@@ -1406,9 +1445,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
-		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
-		relaxed_align = max(relaxed_align, win_align);
-		min_align = min(min_align, relaxed_align);
+		min_align = calculate_head_align(aligns2, max_order);
 		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
 		resource_set_range(b_res, min_align, size0);
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
@@ -1422,9 +1459,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 		if (bus->self && size1 &&
 		    !pbus_upstream_space_available(bus, b_res, size1, add_align)) {
-			relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
-			relaxed_align = max(relaxed_align, win_align);
-			min_align = min(min_align, relaxed_align);
+			min_align = calculate_head_align(aligns2, max_order);
 			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
 						  old_size, win_align);
 			pci_info(bus->self,
-- 
2.39.5


