Return-Path: <linux-pci+bounces-34556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B24B317E6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB0E35A2138
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66862FAC05;
	Fri, 22 Aug 2025 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jkHPu2Dt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300F91A01BF;
	Fri, 22 Aug 2025 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866065; cv=none; b=XcMJKugVgzVW1GCre7LqqSqesFkg1nLb99PFXDsAt62TFzc4BF5Mwagfgfkc8yVTvMHbbRIMuK6G+929xV9PZ/KDqPvtKwW9Jh6pnJbHRcqFxR1H91ne426ckWOY9iW5PDiAdrYGbXV23uKuUNxfNnpYjI8Pid4PZ/7aexFSAyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866065; c=relaxed/simple;
	bh=K44nXn+2YaS890q9Kr4KiGxSXGC4Gk3/nni3cyZeO20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3cgOQBcpvIvNSmt3Uxf/OCMabE7tY2je7thAQHllrTQiVnds1tLnrKnrPUFr1dra+0rn6NJYMPgwvbx6t7jCvTU1LlyKTsNeKrhwwPJyZop0pi4pmXiRgK/lIzsk+vLNcGaeQWzbzL69Hj/AuSZnvvTSgamYTcYQd6oiptMgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jkHPu2Dt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755866064; x=1787402064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K44nXn+2YaS890q9Kr4KiGxSXGC4Gk3/nni3cyZeO20=;
  b=jkHPu2DtRbvPNjdZMiow8CzdgQ7tCzDA3jRzwQcSUjhZJN9aD3n/W/7S
   ckuovbWFqRiBtxYd86GwmFZ2oKOSkUBVcB/GpVypOjhQwAGtgtQq1n3T4
   TmgnpNVfSpuDKDnTvsZPvTsgDzSPzjNMgIdfgKwwxIdYtXzXgh/ccqthR
   Pd8qG0tbSHEGKEnH/HDLlSGsQU8srwkiUTl/hYswWiATleaXAMYj0ndes
   S5bjQoXKNrMR8DC5kXC70KXl19N/xFKWWByJYPMncRaFfE6aAmDgCHRcz
   wLXxLV04wFI0Ww+HtVTN+1v+9YSQqdPnkzjndK/276nkFejiQB1HZCHr6
   g==;
X-CSE-ConnectionGUID: hZaSJLUiTaWsJKEn+i3aqw==
X-CSE-MsgGUID: 9MmdMTotT7eLHuSvXBEH9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="83587595"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="83587595"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:23 -0700
X-CSE-ConnectionGUID: 0Ym8VL6/Q8mIrmePHOE0sg==
X-CSE-MsgGUID: yMUY+Y8/S2Wkw0ZFT2b9Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192360830"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] PCI: Relaxed tail alignment should never increase min_align
Date: Fri, 22 Aug 2025 15:33:57 +0300
Message-Id: <20250822123359.16305-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
References: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
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
Reported-by: Rio Liu <rio@r26.me>
Closes: https://lore.kernel.org/all/o2bL8MtD_40-lf8GlslTw-AZpUPzm8nmfCnJKvS8RQ3NOzOW1uq1dVCEfRpUjJ2i7G2WjfQhk2IWZ7oGp-7G-jXN4qOdtnyOcjRR0PZWK5I=@r26.me/
Tested-by: Rio Liu <rio@r26.me>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 7853ac6999e2..527f0479e983 100644
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
+			relaxed_align = max(relaxed_align, win_align);
+			min_align = min(min_align, relaxed_align);
 			size1 = calculate_memsize(size, min_size, add_size, children_add_size,
 						  resource_size(b_res), win_align);
 			pci_info(bus->self,
-- 
2.39.5


