Return-Path: <linux-pci+bounces-31083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14657AEE0A5
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 16:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D40A3A1EB1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D0628C2C2;
	Mon, 30 Jun 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NH1IPdDJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB028C5A0;
	Mon, 30 Jun 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293624; cv=none; b=fmF2SyvrK8+ESgXKQ4GMYJEJiPr7T84yQAltbXgXszQr+AtkkHblFzW5fk75b0NbTwY1/2pAsbT5T9zApi570gkN6eJQ+RKf+ON3Gp/UsunfQQ3ciqjSnioq3ixWTcPgtGHaVRc/NE66eVIk1y8scRVQQ/hCA2BoaDy0fmOlGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293624; c=relaxed/simple;
	bh=qcdDHfnbKy3u6503ewGEShCVDp3LAsaF1Jy2SSxNrpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQ2EkvFf8O3QTqBR9kfezZ785BDeBaq4vO9xw6/h/mO38OOKPjTDfR/yEXxnrq9Z1vYrwU7heKFGKtxQm6h8SrMeUQ2w7ZORCKezFs8UQ+t4vY/A60Vt2TSN29UYVus1YO0da968gJCdj8ymwf8e2sXXTug0mdgVABPHLvEPe2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NH1IPdDJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293623; x=1782829623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qcdDHfnbKy3u6503ewGEShCVDp3LAsaF1Jy2SSxNrpM=;
  b=NH1IPdDJGJUzZyZS3fcFJz+TFyn4Kl7qEtUaP0JSsg1l8MgHimHIhRrj
   ugN55MQng5NxlLBYBD+QMyO9RYmgHmp4vrsZ9lubhQY5uc+RFIhWEEWqM
   KW6Svp+GetUDG3LVHXj4paFw2Y52W2sPuHxgJq/LKLJR6HgTI/DcGCKXs
   n7/qq4VPnD0uYCFtYK8b51EWc73TrOvktMGHxOMettj/NfRI7ocH7/p2A
   HZpbOSKR5XiHemF0c5GTwkDG/iabUBms/bpmDUWsSRyT+sLjrz9l8fTOz
   +BtMX2I7lJZuaThxIxKeTlwcKl4DoW+xh1z1eUpXwzAa35ejkZYJWMs1e
   g==;
X-CSE-ConnectionGUID: ZW4fuNA+TFaSijR9yjj/rA==
X-CSE-MsgGUID: 1T59dgB8Sqmhaxq7c/7/vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="53395833"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="53395833"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:27:02 -0700
X-CSE-ConnectionGUID: D0j+A4P1ToyuJCXnHQosWA==
X-CSE-MsgGUID: pl3NITLCQ2WgRs7uEH8w5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="152865059"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:26:59 -0700
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
Subject: [PATCH v2 1/3] PCI: Relaxed tail alignment should never increase min_align
Date: Mon, 30 Jun 2025 17:26:39 +0300
Message-Id: <20250630142641.3516-2-ilpo.jarvinen@linux.intel.com>
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


