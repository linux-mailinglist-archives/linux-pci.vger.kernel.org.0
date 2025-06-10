Return-Path: <linux-pci+bounces-29304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A4AD3380
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB50B3B3A2F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A0128C5B4;
	Tue, 10 Jun 2025 10:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KqH/fSHL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A187A28C5AB;
	Tue, 10 Jun 2025 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550883; cv=none; b=GNPxKgGIaTBT632Q2ATSOu/EFKu8vVlH/RP2ZtkhTawq+b+CzKxiRzoOBlZhFXfPozaLFWhgOqc6S5A17ONssnvSzK5uSyVMoQlrrQ21LMUszCfa+ULBjAQF9MmnFn3ZLSTBaEyMO0ruqu2kITxwrVvdIEtSVE8u54U83PiuX9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550883; c=relaxed/simple;
	bh=qcdDHfnbKy3u6503ewGEShCVDp3LAsaF1Jy2SSxNrpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7FVpgkPVMKHDgZ93Bn4I9t9zjhbWb1mwzKFnCXEvIhpx5eZt8YUK5x14kgYqzaoBDxTNy9Q8vBGk4LtiCXJ4aPrvmDj+ZS6C5XxXXmNlsgTZk3HWCyPTHd38uKgrsYpyM6qM4E1rZkztb98ebHb7NbyXGidb3qmDeojky1AX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KqH/fSHL; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749550882; x=1781086882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcdDHfnbKy3u6503ewGEShCVDp3LAsaF1Jy2SSxNrpM=;
  b=KqH/fSHLB4K4rGtrVA0p0OOg1bPi3/ElGiLnB/5RGjifz5DvvmaIvybk
   aImysMV67RX7Jg5APKYd/HPKhDi1p8NiMuaopDyfXK6uU3X9bgdoz1sGW
   vmUOKpuST74U5VtZEfSjVncT30heMJjR5vucwXFJ0bUf8GsCN5B5XM6+o
   LxrJWlM5dcofnz6PesIDb3b4PYtYAFtXZ3hrLU18H/Q/npBHAsOHUftO+
   /Xp75uIFaN2Yi0Zj4yac0N0gOC5t9YtZ8kXmnwMu4KPO5dng0SfAZOz92
   VvpC/pVZLLl5sdL3mjzseHGotePVHleKsU4bt0fcCG1Ri8to48RANGdjQ
   w==;
X-CSE-ConnectionGUID: MTOvO12iSgWTIs48YxtU9Q==
X-CSE-MsgGUID: iuu3TfE4Qd64Dm4BWbP3qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51739092"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51739092"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:22 -0700
X-CSE-ConnectionGUID: tkD/4BfORo+gfxtv07x4ZA==
X-CSE-MsgGUID: QjMvb63cTXGtE8bbKUoO3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147370217"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:18 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] PCI: Relaxed tail alignment should never increase min_align
Date: Tue, 10 Jun 2025 13:21:00 +0300
Message-Id: <20250610102101.6496-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com>
References: <20250610102101.6496-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When using relaxed tail alignment for the bridge window,
pbus_size_mem() also tries to minimize min_align, which can under
certain scenarios end up increasing min_align from that found by
calculate_mem_align().

Ensure min_align is not increased by the relaxed tail alignment.

Eventually, it would be better to add calculate_relaxed_head_align()
similar to calculate_mem_align() which finds out what alignment can be
used for the head without introducing any gaps into the bridge window
to give flexibility on head address too. But that looks relatively
complex algorithm so it requires much more testing than fixing the
immediate problem causing a regression.

Fixes: 67f9085596ee ("PCI: Allow relaxed bridge window tail sizing for optional resources")
Reported-by: Rio <rio@r26.me>
Tested-by: Rio <rio@r26.me>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 07c3d021a47e..f90d49cd07da 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1169,6 +1169,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
+	resource_size_t relaxed_align;
 
 	if (!b_res)
 		return -ENOSPC;
@@ -1246,8 +1247,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	if (bus->self && size0 &&
 	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
 					   size0, min_align)) {
-		min_align = 1ULL << (max_order + __ffs(SZ_1M));
-		min_align = max(min_align, win_align);
+		relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
+		relaxed_align = max(relaxed_align, win_align);
+		min_align = min(min_align, relaxed_align);
 		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
 		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
 			 b_res, &bus->busn_res);
@@ -1261,8 +1263,9 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		if (bus->self && size1 &&
 		    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
 						   size1, add_align)) {
-			min_align = 1ULL << (max_order + __ffs(SZ_1M));
-			min_align = max(min_align, win_align);
+			relaxed_align = 1ULL << (max_order + __ffs(SZ_1M));
+			relaxed_align = max(min_align, win_align);
+			min_align = min(min_align, relaxed_align);
 			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
 						  resource_size(b_res), win_align);
 			pci_info(bus->self,
-- 
2.39.5


