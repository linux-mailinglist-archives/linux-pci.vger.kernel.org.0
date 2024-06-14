Return-Path: <linux-pci+bounces-8797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF75908951
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBE21F2829A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59478194AFD;
	Fri, 14 Jun 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/0HRfur"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E95194AF3;
	Fri, 14 Jun 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359614; cv=none; b=gz3qT0zhjp4DQy3p/MjF/cjjrUc7j+KyQQ4iiJS+zZepKtq7KXNACdhUOmwSiQqoNr7uPnSxN/9NzNJz/8qT0Ux2bWFpAXykp3ptRI7/412u+HN2hlcAHKjjEs0yd4BGpJ6eOD/UMHO35Itr2W7MMMesUGA7e1GTqW4MsOZguV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359614; c=relaxed/simple;
	bh=2ybDsU0ZTyNiNs9381IROwZv24wezPthu0zRlBzvDnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTbt67MnUO0ut0taPG5jXjAyYpt/4+m54owQAT8CWkUJc2wMiBDK0CRDkBV/1doJMHnWqmx9qPCoNVE3CzhG30kA30u2pHHUl72UUc3fOl8jTkih1vl6eGH5OOSs7LowcQIE+AJu9mWo1fr6Tt7vaKj5lJCCPKXlI6u+xWjFaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n/0HRfur; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359613; x=1749895613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ybDsU0ZTyNiNs9381IROwZv24wezPthu0zRlBzvDnE=;
  b=n/0HRfurMfK9zHi5oF2eDzBh7DrRXW4Valc+gfFZFSXpDkm4yXtPNeoY
   z+O0ApXrLCAIXxdFszlhYyTC2fQQ9gnBwmUBGypzfaifIpoqJm39vGmty
   FL6x/G+QHWF/cwcAXB3oJFkgUImTaOTgSXN534mrPcA0HZZBxeg+kgDNb
   hiFq2rq8pInLEwAfuxAb7D4IfXxmVD+/jJT8/odqBnLiqtgLwAROwFn3Y
   XkfnUd3xr2rjXQ0IW+9v0eAo6pXLM0S8dvH8MY61gWoMWZT9lxlFESOy6
   DfwlGRO1jRpezKXsdr2jCWPu8hvoaz79xvnaZQeJvP3ihZi+aokOfR/fM
   w==;
X-CSE-ConnectionGUID: YnNzD3KVS8WzcrMsLstzCQ==
X-CSE-MsgGUID: W4JK/tGtR72iwawHv2gawg==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15388979"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="15388979"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:53 -0700
X-CSE-ConnectionGUID: B6kYxiMFR7yEN15B3j9W5A==
X-CSE-MsgGUID: 7LZkjDPCTWqeBrOOEejDcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="77933746"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 03:06:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
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
Subject: [PATCH v2 3/4] PCI: Use align and resource helpers, and SZ_* in quirk_s3_64M()
Date: Fri, 14 Jun 2024 13:06:05 +0300
Message-Id: <20240614100606.15830-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
References: <20240614100606.15830-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


