Return-Path: <linux-pci+bounces-8653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCDE904EA4
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F64288EA1
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CCB16D4F8;
	Wed, 12 Jun 2024 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RGvDZY9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E4A16D4E9;
	Wed, 12 Jun 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718182650; cv=none; b=bTe3EUoyvnxHsYxhtNRCHFoV9baqoVXVLl0KOHeSKCWn7Mbs6Nne8k5QvZsUv3nWyMzcOqd5XqSBzBwz2FwbxibvY1SP6on/XtyxyKatjZKh5hJYtHmzrGlwLFdFcYSUPUUcke0a9hIqEIcSRwJ3lIES0RcmMln5nKyc1YiqTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718182650; c=relaxed/simple;
	bh=rSWAv76CS9DrIAWgkBXjqcWjEwCJ0bzwSYtZQcOfclA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQV9TQyfKEvxwPylW6EW9hQqVBELc+LKGh/Q8X/6zRlbMvct1fKmFwK0JHRN581yCn4DALywSNIGwrkiYOU8bbq7DiMoAxAZRCMaLHwLjcJbE2dXw33Jqi7Z91zcmOxsjrvqsedysvG7YG4tCb1hkYzUbIB8uE75vaUOVk6iNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGvDZY9Q; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718182648; x=1749718648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rSWAv76CS9DrIAWgkBXjqcWjEwCJ0bzwSYtZQcOfclA=;
  b=RGvDZY9Q91QtwHhbe7JYK7AIl4J/EoQlswJZ0/gx3W0hWgi5qlUrl/V/
   JhDbMVfrhiDwPv5KuGWyABi6Z4qAa7Pcn2SCDpp2D4RWO3yCIbuJxBc8o
   77kx+7yzfe981kO0yIY0KVWnzqO8Mk6NQmZcgb288MhHalJypMAXvdrWS
   uCgccEMMh0SwPCNHejRf4KtDqCznTwEjM4WsnZvJiJiCAIkX3QxyfQLl4
   6G2w4moQ39EyFrLiStYrJzaQm3K4fv9Fkw0sNKYicrW4UF6HFM6qSQBwD
   dyBCC9jt58R3SHTRvMOoAdFCR5Yd0KgkJ3zTWlyQJABk8nHMAiZpqZ3h7
   w==;
X-CSE-ConnectionGUID: UvLfX0hHQ56z3EQviJTPyA==
X-CSE-MsgGUID: G9PRM/BRTIWaXs4fGLgu4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18792158"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18792158"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:57:28 -0700
X-CSE-ConnectionGUID: 4zlu8W8fQYeg647hM6IZDw==
X-CSE-MsgGUID: hUjTRGRTQfiyGkT8Z6hV4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39582944"
Received: from unknown (HELO localhost) ([10.245.247.204])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 01:57:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	Robert Richter <rric@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()
Date: Wed, 12 Jun 2024 11:56:29 +0300
Message-Id: <20240612085629.5015-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use IS_ALIGNED(), resource_size(), and SZ_* defines in quirk_s3_64M().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index bde0f5388d06..125fc1cbad95 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -591,7 +592,7 @@ static void quirk_s3_64M(struct pci_dev *dev)
 {
 	struct resource *r = &dev->resource[0];
 
-	if ((r->start & 0x3ffffff) || r->end != r->start + 0x3ffffff) {
+	if (!IS_ALIGNED(r->start, SZ_64M) || resource_size(r) != SZ_64M) {
 		r->flags |= IORESOURCE_UNSET;
 		resource_set_range(r, 0, SZ_64M);
 	}
-- 
2.39.2


