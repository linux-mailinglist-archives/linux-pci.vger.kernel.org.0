Return-Path: <linux-pci+bounces-7152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBC8BDFA1
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB335B203EC
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63F01509A0;
	Tue,  7 May 2024 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MsSCrJSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98FF14EC4D;
	Tue,  7 May 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077553; cv=none; b=EXzGhCuN6ru0ZQir+E5I+7ne/QOKoMvmaBeYQigyTYO58Dgu6jVNB4CB3PbjArUBVR+nxqoCRpVMXEfQqEuvZV8vcsNb5ngInnKfuF73gRsXakpz1QfS6TSAjvZUQiPowKkxRAYNriGB5//+KXGvpdakrZC3v7h4UmnVW9fuc2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077553; c=relaxed/simple;
	bh=KAj0RxikzJoUJzlDAVpvqjT/K/KSlR+Z+qURBJkcFOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhfoM0g/9hv8FYeR8weTpuF5IRq1qVT5fm2VIqFWBIS6poG0tZqaAYoyWNejX52OVLjsfqqg4onEP65C4qXYTGutBv4wbRd1b2VipwY/sTzgHGiQbWmgN5qqzNdUS9p9KWVxPTGYrO9wut/f+VfRbuLXDKNwSPt3JKo9rrp8yQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MsSCrJSv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077552; x=1746613552;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KAj0RxikzJoUJzlDAVpvqjT/K/KSlR+Z+qURBJkcFOM=;
  b=MsSCrJSvjaMFsM2dwsI4U3o2oNsToUj3LL18hytM+8I2egfAzzl/WXJm
   rcWbVOEWttfkCEv6QqPknzJ0V3fo179O1IZK9mH7JUvvqtHW1ggwpdVus
   yrNaEQU4pFsJCoqGSTt4kbYPu1T8u2tFb/3BNput6fIOCXuUwIC5WD0yh
   T0ZD+xGHevQQOmUHuCcpkoNNT/4I4TKu60g+HpadWlE9ZBibK5pS00Cch
   y6EY7QGf2XPM0CzW3QHVtA4I5fXiydJ59+0NdvRgMPPcP8hiJknSUVbkk
   MNLblKvTCD5zCxujZRBLn5O3Jv6PK0HC9NUHIHKzrc5suk1wc/kuD4mc/
   A==;
X-CSE-ConnectionGUID: Sn+lI999Rc6ujkyvr2nuKw==
X-CSE-MsgGUID: d/evep70QcyB2WtwSX/HiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="36243489"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="36243489"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:25:51 -0700
X-CSE-ConnectionGUID: gbH9mbRRR8W+w5dovI6hCA==
X-CSE-MsgGUID: NI5U66wNQeWTJHMc3mA3Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="33307465"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:25:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lidong Wang <lidong.wang@intel.com>
Subject: [PATCH v3 1/8] PCI: Fix resource double counting on remove & rescan
Date: Tue,  7 May 2024 13:25:16 +0300
Message-Id: <20240507102523.57320-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() keeps the size of the optional resources in
children_add_size. When calculating the PCI bridge window size,
calculate_memsize() lower bounds size by old_size before adding
children_add_size and performing the window size alignment. This
results in double counting for the resources in children_add_size
because old_size may be based on the previous size of the bridge
window after it has already included children_add_size (that is,
size1 in pbus_size_mem() from an earlier invocation of that
function).

As a result, on repeated remove of the bus & rescan cycles the resource
size keeps increasing when children_add_size is non-zero as can be seen
from this extract:

iomem0:  23fffd00000-23fffdfffff : PCI Bus 0000:03
iomem1:  20000000000-200001fffff : PCI Bus 0000:03
iomem2:  20000000000-200002fffff : PCI Bus 0000:03
iomem3:  20000000000-200003fffff : PCI Bus 0000:03
iomem4:  20000000000-200004fffff : PCI Bus 0000:03

Solve the double counting by moving old_size check later in
calculate_memsize() so that children_add_size is already accounted for.

After the patch, the bridge window retains its size as expected:

iomem0:  23fffd00000-23fffdfffff : PCI Bus 0000:03
iomem1:  20000000000-200000fffff : PCI Bus 0000:03
iomem2:  20000000000-200000fffff : PCI Bus 0000:03

Fixes: a4ac9fea016f ("PCI : Calculate right add_size")
Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 909e6a7c3cc3..141d6b31959b 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -829,11 +829,9 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
-- 
2.39.2


