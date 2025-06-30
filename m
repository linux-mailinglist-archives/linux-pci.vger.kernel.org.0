Return-Path: <linux-pci+bounces-31084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A1EAEE0A6
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 16:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD8C1899888
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCC828BABC;
	Mon, 30 Jun 2025 14:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efTAB9h/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7118FDBE;
	Mon, 30 Jun 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293633; cv=none; b=lL8mFIwxX2hOw+Da9nDJ8Hgy3Og76yId45xKqX2VVHOGesZwofL1YPECFm7B1u8zZV7JUFOn+H2ZQkQ2Wa7fET38zUUURXhAN0+6/XETtoHBvv+TOGDiraYWt8BBVo8SUJi4oZfkkOmst3x0ruKna9YBQxZaemZxrJ6DYSfkeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293633; c=relaxed/simple;
	bh=BOSVZ4oyyk6nUXo+A86LApeIJk8Fffmw2alkxLv2SbE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWeN/nnbqvpQys2NVyHUUPONfVOyTk5ZbrCDpuPcl5Rq1fLpcASK/27ubRXvB47aTBuwxpolbP9mHG8Blc4NRGrX58uWIi4GKWbwbCVJKHe3U7FtL6t2CH5BE1ijfDfmzgFzptiw+yDrbt3lFxuRE940TwQqzocK4dVs1fR8mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efTAB9h/; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293632; x=1782829632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BOSVZ4oyyk6nUXo+A86LApeIJk8Fffmw2alkxLv2SbE=;
  b=efTAB9h/RejkpEIO5unIzOdvsTVM2JAQ728tq9mzZwHexgoMNLJJS9kH
   dfCHFQJ5l19O4scVmsFSeZsbvSz2Kf4jZZeiDC6a8xqhuZVrtNoyZnm6q
   bdlXNQKaRDVluHZXCVZ7NMuZbGKZ3aRMGC28Gc6n0jhWecwLf1fsIphHk
   boWzaKXQOo78F19y9PH+sGRgGvCP34wNQz33eQSp2VkIP1Id4qVU085o9
   dXmeMF8IcyLrsZ/8ZcL1mqEa6TyoyGbBbyeNdxGyaFf7DhcrJH8hbWiaB
   A5/GMdN3G2swpORrOGslwqwyxp8AIjEdF+zUOr1/s77bIptmTk3Jtnm9b
   A==;
X-CSE-ConnectionGUID: uoNrpRDaT+asYWLWotI5qg==
X-CSE-MsgGUID: 8CR4qVW+Sp6ZtxASoCOefA==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53395845"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53395845"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:27:12 -0700
X-CSE-ConnectionGUID: voRy+8cdTY2q/XI7hMWnBQ==
X-CSE-MsgGUID: PM9Z93qJTxqXXNFxVMfgAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="152865089"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:27:08 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] PCI: Fix pdev_resources_assignable() disparity
Date: Mon, 30 Jun 2025 17:26:40 +0300
Message-Id: <20250630142641.3516-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
References: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pdev_sort_resources() uses pdev_resources_assignable() helper to decide
if device's resources cannot be assigned. pbus_size_mem(), on the other
hand, does not do the same check. This could lead into a situation
where a resource ends up on realloc_head list but is not on the head
list, which is turn prevents emptying the resource from the
realloc_head list in __assign_resources_sorted().

A non-empty realloc_head is unacceptable because it triggers an
internal sanity check as show in this log with a device that has class
0 (PCI_CLASS_NOT_DEFINED):

pci 0001:01:00.0: [144d:a5a5] type 00 class 0x000000 PCIe Endpoint
pci 0001:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
pci 0001:01:00.0: ROM [mem 0x00000000-0x0000ffff pref]
pci 0001:01:00.0: enabling Extended Tags
pci 0001:01:00.0: PME# supported from D0 D3hot D3cold
pci 0001:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0001:00:00.0 (capable of 31.506 Gb/s with 16.0 GT/s PCIe x2 link)
pcieport 0001:00:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 01-ff] add_size 100000 add_align 100000
pcieport 0001:00:00.0: bridge window [mem 0x40000000-0x401fffff]: assigned
------------[ cut here ]------------
kernel BUG at drivers/pci/setup-bus.c:2532!
Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
...
Call trace:
 pci_assign_unassigned_bus_resources+0x110/0x114 (P)
 pci_rescan_bus+0x28/0x48

Use pdev_resources_assignable() also within pbus_size_mem() to skip
processing of non-assignable resources which removes the disparity in
between what resources pdev_sort_resources() and pbus_size_mem()
consider. As non-assignable resources are no longer processed, they are
not added to the realloc_head list, thus the sanity check no longer
triggers.

This disparity problem is very old but only now became apparent after
the commit 2499f5348431 ("PCI: Rework optional resource handling") that
made the ROM resources optional when calculating bridge window sizes
which required adding the resource to the realloc_head list.
Previously, bridge windows were just sized larger than necessary.

Fixes: 2499f5348431 ("PCI: Rework optional resource handling")
Reported-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f90d49cd07da..24863d8d0053 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1191,6 +1191,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			resource_size_t r_size;
 
 			if (r->parent || (r->flags & IORESOURCE_PCI_FIXED) ||
+			    !pdev_resources_assignable(dev) ||
 			    ((r->flags & mask) != type &&
 			     (r->flags & mask) != type2 &&
 			     (r->flags & mask) != type3))
-- 
2.39.5


