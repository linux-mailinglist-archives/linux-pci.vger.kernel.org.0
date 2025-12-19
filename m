Return-Path: <linux-pci+bounces-43420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7F7CD132E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 702903035D06
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2878D2550CD;
	Fri, 19 Dec 2025 17:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYA9jbLi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8732E135;
	Fri, 19 Dec 2025 17:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166091; cv=none; b=DICMSZeu7EIViZqeytQQMJ3A8aQmjPAP4DBmLeu04qbJ21ocZ0RGpWtwoB+WIXtp02+1My/c7q5UHaewZ5h/F4eFHgo832F0ZijJGBv4RHX9O5dY3+S4u/bMI+0AAnDdsDnCwa+oN8m0hEzfT2z9Kwo7ddvpTLL6rYorSZkOes0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166091; c=relaxed/simple;
	bh=2khM7urutIILia6aPBQpLXUSbEISIdV1dOEQaICjbEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRl6LApAbbW5DTii9TF+jwrKx4NsRc1p/1XW3+KuKo3F8f/RFWpmNH5T35LY5VoGMjpjx4BvDvzVnqnQ/lYDvSsXiCZh9DzFXwhbB47V4T3mWGusfuR2Vgq7eLgNxQWSRvYopI77zDPX9Uk6g8bygRpk7LXktg92HHI9jg6CB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYA9jbLi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166089; x=1797702089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2khM7urutIILia6aPBQpLXUSbEISIdV1dOEQaICjbEY=;
  b=dYA9jbLiOcUf+oYPrYD1pCsYhooH2vxvXGAOWxH5y60Wez0IzYlRrZi6
   TVKPjSIcYTAMIG6uonCqb4zXkxQu60ttVGey1OqS0OLnkWn57C6dOFh08
   P1fsscya4prR4euYRbYw606IicQo0dh2BjOAAQsAdeCvEk6eho8wZapMU
   AFGGoDknz4LYQ0kC5u4vFYcxDRG8Rn2XJuvVD2wPf+ojwCeh0FYFCNl2c
   WJYckRQ29+uYB/P1mkp1gswHWUK1KbV2jdl6BdnPWDUU/soJoNxQLCuvu
   lPHkFf4F/2FCDTJHUK71x5s/KOApEQFzuiOlBhEEdwgx2afMY9mdeOVu7
   g==;
X-CSE-ConnectionGUID: zY2vcjjLSbaj0MzXOXIGhw==
X-CSE-MsgGUID: FdN4zo+pQGi4qNerTiXm1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68062497"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68062497"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:28 -0800
X-CSE-ConnectionGUID: jXZv9FnQTCKDOTtpgWbkJw==
X-CSE-MsgGUID: +zhCO223TbSuPnHdfM/HhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199747896"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:25 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 05/23] PCI: Remove old_size limit from bridge window sizing
Date: Fri, 19 Dec 2025 19:40:18 +0200
Message-Id: <20251219174036.16738-6-ilpo.jarvinen@linux.intel.com>
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

calculate_memsize() applies lower bound to the resource size before
aligning the resource size making it impossible to shrink bridge window
resources. I've not found any justification for this lower bound and
nothing indicated it was to work around some HW issue.

Prior to the commit 3baeae36039a ("PCI: Use pci_release_resource()
instead of release_resource()"), releasing a bridge window during BAR
resize resulted in clearing start and end address of the resource.
Clearing addresses destroys the resource size as a side-effect,
therefore nullifying the effect of the old size lower bound.

After the commit 3baeae36039a ("PCI: Use pci_release_resource() instead
of release_resource()"), BAR resize uses the aligned old size, which
results in exceeding what fits into the parent window in some cases:

xe 0030:03:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
xe 0030:03:00.0: BAR 0 [mem 0x620c000000000-0x620c000ffffff 64bit]: releasing
xe 0030:03:00.0: BAR 2 [mem 0x6200000000000-0x620000fffffff 64bit pref]: releasing
pci 0030:02:01.0: bridge window [mem 0x6200000000000-0x620001fffffff 64bit pref]: releasing
pci 0030:01:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref]: releasing
pci 0030:00:00.0: bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref]: was not released (still contains assigned resources)
pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] free space at [mem 0x6200400000000-0x62007ffffffff 64bit pref]
pci 0030:00:00.0: Assigned bridge window [mem 0x6200000000000-0x6203fbff0ffff 64bit pref] to [bus 01-04] cannot fit 0x4000000000 required for 0030:01:00.0 bridging to [bus 02-04]

The old size of 0x6200000000000-0x6203fbff0ffff resource was used as
the lower bound which results in 0x4000000000 size request due to
alignment. That exceed what can fit into the parent window.

Since the lower bound never even was enforced fully because the
resource addresses were cleared when the bridge window is released,
remove the old_size lower bound entirely and trust the calculated
bridge window size is enough.

This same problem may occur on io window side but seems less likely to
cause issues due to general difference in alignment. Removing the lower
bound may have other unforeseen consequences in case of io window so
it's better to do leave as -next material if no problem is reported
related to io window sizing (BAR resize shouldn't touch io windows
anyway).

Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Fixes: 3baeae36039a ("PCI: Use pci_release_resource() instead of release_resource()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 612288716ba8..8660449f59bd 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1071,16 +1071,13 @@ static resource_size_t calculate_memsize(resource_size_t size,
 					 resource_size_t min_size,
 					 resource_size_t add_size,
 					 resource_size_t children_add_size,
-					 resource_size_t old_size,
 					 resource_size_t align)
 {
 	if (size < min_size)
 		size = min_size;
-	if (old_size == 1)
-		old_size = 0;
 
 	size = max(size, add_size) + children_add_size;
-	return ALIGN(max(size, old_size), align);
+	return ALIGN(size, align);
 }
 
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
@@ -1298,7 +1295,6 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	resource_size_t children_add_size = 0;
 	resource_size_t children_add_align = 0;
 	resource_size_t add_align = 0;
-	resource_size_t old_size;
 
 	if (!b_res)
 		return;
@@ -1364,11 +1360,10 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 		}
 	}
 
-	old_size = resource_size(b_res);
 	win_align = window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, min_size, 0, 0, old_size, win_align);
+	size0 = calculate_memsize(size, min_size, 0, 0, win_align);
 
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
@@ -1378,7 +1373,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
 		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
-					  old_size, win_align);
+					  win_align);
 	}
 
 	if (!size0 && !size1) {
-- 
2.39.5


