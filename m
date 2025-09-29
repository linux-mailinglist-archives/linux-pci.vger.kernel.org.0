Return-Path: <linux-pci+bounces-37181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8850BA7FC9
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 07:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796F83A2E8E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 05:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1806734BA53;
	Mon, 29 Sep 2025 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fn0IatEb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEB27E05B
	for <linux-pci@vger.kernel.org>; Mon, 29 Sep 2025 05:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759123160; cv=none; b=oJ67BVU40TifyNvrXccMGDgnQLUqf2IomuuUrHPxV+eW7pVlb2YBRtQJlfwCt/sgRMGMDZdreHYsX2gb+9hBhbW8Q29Y9DRzEpv2qWmpMmPV3aedUft+uuaQsqsgaFSpivKeEFfT4O4GvIAtFFCmVMaNts0ImAEQ+9aLpgNeJp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759123160; c=relaxed/simple;
	bh=UPZ3+KuBbGQeoZwX3LukSjOY7az2Sby/FoOOGToSn/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XEo5rKQEQ3Ese9QUeU/2dKfIImxIl4TflWAKkFoflVxGsbE1Iy1axsMsWRpMmrlLntQP1B7sZODThqroKPeqa5PXEE/dXvECbqBSjUWjDzTKxFUUR+OgftCNlTrvZcRKFIXO1MnG9Ryqs9BLP9la5AEaorUP3iPCd6BnbaVTES0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fn0IatEb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759123158; x=1790659158;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UPZ3+KuBbGQeoZwX3LukSjOY7az2Sby/FoOOGToSn/c=;
  b=fn0IatEbgGzJDebaBAR9s4qAxhyBPi5hQfiUifo4GEbuaD+AWQX28zh8
   XyUNluh8HbPi9/bm2/LIamn07DkWy4kbkNx0eLMxXasd+SKghdvOXdf6V
   pKei/ctplCQJ9WdlWWylVAGUxh2nEuTgpxqT8sSo3aXxeM/7IL3SBdx5E
   Etr8TUycbXkfLZTbu0hWo080HJMFgLGYrECtSWIs5jpYgScLpc0H/K4h6
   rGoVFlm516yy8dTrv6SIILXOpsn9esxcXjtowM1+gKj6iO01AxX3CcC77
   EZEnP5/qA8ZJCITX29LJF6Y32vV0522AbB3j/ga2DwhpUs9NWFkFt1gqI
   Q==;
X-CSE-ConnectionGUID: qyGtZ/VDReOUhL9MvkT3pw==
X-CSE-MsgGUID: c0XpVNzAR6CLmAzfJYVhAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61269604"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61269604"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 22:19:17 -0700
X-CSE-ConnectionGUID: dlS8AFiYRZqwG7mTwH2+Qw==
X-CSE-MsgGUID: yhqr4gvoRx6QKA9+3JtKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; 
   d="scan'208";a="178564962"
Received: from baandr0id001.iind.intel.com ([10.66.253.151])
  by fmviesa009.fm.intel.com with ESMTP; 28 Sep 2025 22:19:16 -0700
From: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	Kaushlendra Kumar <kaushlendra.kumar@intel.com>
Subject: [PATCH] PCI: Add BAR index validation in pci_mmap_resource_range()
Date: Mon, 29 Sep 2025 10:47:30 +0530
Message-Id: <20250929051730.232952-1-kaushlendra.kumar@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add validation to ensure the BAR index is valid before accessing PCI
resource information in pci_mmap_resource_range(). This prevents
potential out-of-bounds access when an invalid BAR index is passed
to the function.

The check uses the existing pci_bar_index_is_valid() helper to validate
the BAR index early in the function, returning -EINVAL for invalid
indices before any resource operations are performed.

Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
---
 drivers/pci/mmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index 8da3347a95c4..7a26abc3169f 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -28,6 +28,9 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 	unsigned long size;
 	int ret;
 
+	if (!pci_bar_index_is_valid(bar))
+		return -EINVAL;
+
 	size = ((pci_resource_len(pdev, bar) - 1) >> PAGE_SHIFT) + 1;
 	if (vma->vm_pgoff + vma_pages(vma) > size)
 		return -EINVAL;
-- 
2.34.1


