Return-Path: <linux-pci+bounces-29305-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FB3AD337E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 12:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D571164088
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D0728C2D4;
	Tue, 10 Jun 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GGIES0IX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31F728C5AB;
	Tue, 10 Jun 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550893; cv=none; b=eWrq5lWVCORrL9C2SvjVrIDQYdYHU4seNgXpaLDAcUwbuQNx34rRzRABmdU4IxNxbpr1UTi26o9EVoKyuEDOf+6jhSK7K8Gr/yoFZeMPk335jZBzlOjtqllG4pyh8bsnatVmkjAR1bcQWkf2dOhayfg1U8wxruuPldICtVNtbqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550893; c=relaxed/simple;
	bh=+j8zMJW2Wcl191iL6HqEJHAtauDOyM2xYMzu/jk0I2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Elg2VP880OH7nt3I/dghybeyVcNMRbRIHxEMiIhdruOmVXQGN3koyeK8USRowTmMXjXFn2YBe/r6TnrlLCaPSdBiyLqCN0WVlaqxuqBlzPYuusnrCZKLofW96Gj9ODBioB1TiYYmhz/A3/6WQFUOBWzhinCqrX6sZ1B5VAm7fLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GGIES0IX; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749550892; x=1781086892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+j8zMJW2Wcl191iL6HqEJHAtauDOyM2xYMzu/jk0I2g=;
  b=GGIES0IXyyhoQqYeSbE/3AZyjdK+8RaSPAhq2IPISwNXZyTX6k7cEJMw
   skcwIcDCn13OCnl9SAhc9i0fLcjXWQ/xiPlRApBTrIw/kMlfdTRjUNDF6
   0Ooc7U/Jb7FEqnm/T/DU0wPnkQg83Ip/hHF7D8L4W0aqBWodt48B2lJN6
   BGESh6j0JgXS2uiZUiMQEm0CW8tuQFqZ6h9GUN/n7gb4TcdwrBxjdw2C8
   AYq8UFjl5OfWxy6aG54p6qHDWjZc5UvSUKAF6OQXvoiigTVAGMNADph2B
   f8omGFJMVoCF4KJ7kkXm9Bhi0Mg9+YxpVuyXLcyVL07rP28sw7tbN3Ygs
   Q==;
X-CSE-ConnectionGUID: Ho7Z4CxaReuR4N0IFYS8qQ==
X-CSE-MsgGUID: M915R6yIQuaZvm3/Uz20oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51739106"
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="51739106"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:32 -0700
X-CSE-ConnectionGUID: 5HoJXnS4SZGzW5uZ3skH8g==
X-CSE-MsgGUID: 1mkblKhkQTugaNQT0+OXJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,224,1744095600"; 
   d="scan'208";a="147370287"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 03:21:29 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] PCI: Fix pdev_resources_assignable() disparity
Date: Tue, 10 Jun 2025 13:21:01 +0300
Message-Id: <20250610102101.6496-3-ilpo.jarvinen@linux.intel.com>
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

The reporter was perhaps not happy with this fix as behavior of PCI core
isn't identical after this fix even if this patch fixes the problem on
the PCI core side which causes the internal sanity check to fire.

It seems that in the reporter's case, an out-of-tree driver was involved
that performed things and made assumptions a driver should not do in its
probe function such as assuming a bridge window is assigned even if there
are not child resources to be put into it (the child device in reporter's
case doesn't have a valid class and gets therefore skipped by the resource
fitting/assignment):

https://lore.kernel.org/all/bd579412-d07c-476d-8932-55c1f69adc9f@linaro.org/

In other words, the out-of-tree driver relies on the disparity in the
PCI core's resource fitting code which is now eliminated by this fix.

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


