Return-Path: <linux-pci+bounces-42259-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C568EC91DF7
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4396352211
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 11:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17963254A3;
	Fri, 28 Nov 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9h3ippw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A16B2F1FD3;
	Fri, 28 Nov 2025 11:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330654; cv=none; b=BFuhpXkCKjj5DTmBGX31ADCz5MglT9TaikeLtW4G9+0urDl356LuqFZ+9AdVKFm3DOQdBehpJm1cRghxYVbbPlvROXebsxXkpFQDsLwPvZZJlQP/fiEDDnglPaZAK+jKtp+0zkg2c82jvmwhy5DMWhe62NpxnSoh/MYYU16su2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330654; c=relaxed/simple;
	bh=J3EqdeNEnlMVvV/TxElDoaTOZx5Kx11YfAHlUJndQpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbyx23wkNp1bc8XJOfiy8rodAxwmUKmro0RzCMMAO6aakYIkU9f13Xl3yE4nszeRn8ppxXbD8Kvh7r1Cn4JAb8yJP7+UsMS626/SZseDhNn9SNFq+T2kvaTNI5oQ/OBGaE0MaioWJdRcljs8J+2q6Gtyzl/jjoLOdNyKre3s9gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9h3ippw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764330652; x=1795866652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J3EqdeNEnlMVvV/TxElDoaTOZx5Kx11YfAHlUJndQpQ=;
  b=f9h3ippw1mcJkoTJUR1tx/wKeeHj0kfyyFsKOPWKUzhD1fQnQA23FXhK
   4sohkeF5oy6u0hJM6aTwTknQds5MnnwAvwz7RagboCkbVuUREjv3giACs
   rjlWL6d4IJqJ7A3yzD6gZtQhlkajqvgo+cUSJphQXfbjJn6Nb7rOBc7aH
   PklDONF3Es/1Z4UrgU28GNVEmjfjk7TCuSO0XBzdic8RsBiCjcuq4/8cL
   Y7yQhAnhQcuR1nff6sLJhHdIeRaCUi6vooQFFGTZtpCdEK4Dvgwz5ErZO
   fuh+be/w17R1PlS7A/RqyZldIPmzXRb1XTXFTTS2kASeQD3Jts4HGcRpI
   A==;
X-CSE-ConnectionGUID: ycel80B9Q+eXgtUnMD1pzQ==
X-CSE-MsgGUID: tGgTyPxSS3uHpNxS1huAPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66437133"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66437133"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:51 -0800
X-CSE-ConnectionGUID: Y67/q+RZRqqSJrm6e/T0qQ==
X-CSE-MsgGUID: ado3sna4RGKRGYinYh2Tzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="230725425"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 03:50:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] PCI: Rewrite bridge window head alignment function
Date: Fri, 28 Nov 2025 13:50:19 +0200
Message-Id: <20251128115021.4287-3-ilpo.jarvinen@linux.intel.com>
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
apply the new approach when using relaxed alignment.

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
index 70d021ffb486..93f6b0750174 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1224,6 +1224,45 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
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
@@ -1311,13 +1350,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
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
@@ -1327,7 +1366,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	if (b_res->parent)
 		return;
 
-	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
 
@@ -1378,6 +1416,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 			 */
 			if (r_size <= align)
 				aligns[order] += align;
+			aligns2[order] += align;
 			if (order > max_order)
 				max_order = order;
 
@@ -1402,9 +1441,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, b_res, size0, min_align)) {
-		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
-		relaxed_align = max(relaxed_align, win_align);
-		min_align = min(min_align, relaxed_align);
+		min_align = calculate_head_align(aligns2, max_order);
 		size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
 		resource_set_range(b_res, min_align, size0);
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
@@ -1418,9 +1455,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
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


