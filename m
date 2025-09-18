Return-Path: <linux-pci+bounces-36406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8C9B8395C
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 10:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99901622E46
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 08:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23D32FF141;
	Thu, 18 Sep 2025 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9M8txaz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89CB2F5315;
	Thu, 18 Sep 2025 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185333; cv=none; b=AU39NZtRFIapcGxKIbseoRh4zKgjjzbhGc4LLSYrSccmNe8SAoy0C+0M1eu6eUSeQzczQpaZVQi+nGWipCvuJ4kSt/DhJfUQ7vREejKVWRGQGolWAwmh4Y7vDz5Dj1rFzUYAX1kZYDNgmcat4R5NfIgOKUVn9d1fYH7ivaVCl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185333; c=relaxed/simple;
	bh=HXWQdDsbefm3PuZ+d8+OcEN8g08SGDzBtWifzKKgjfo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KShBCuzSSnHkqeXi5gEuGKkyFwxFIySbZ/q1VM0SV4vfKP8Kfj1ycAAoGT2etaTjSl4pJOgEC8/pu6G/ZZk0HpHr3hHlmykneWNHQ71Oy3xD4s7WqLxAySLHu2UQwBInBccOply/bWIbt/Ro0A5ji3Ki3N4B6jusiyQoH0iiI3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9M8txaz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758185332; x=1789721332;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HXWQdDsbefm3PuZ+d8+OcEN8g08SGDzBtWifzKKgjfo=;
  b=X9M8txazkEZLRdtgk8odGIyYI4UoGnwY/3q/38Myfg9pssvI0JuS1OxK
   NUNZfk86dTY/K3HDHwEBpxa0gO9XRPuvNP4GjMmhwuHg6xS1vo5pnMaPm
   MPqaoKiS6KkKP52K8tqpl7CCfZAikYk/m8dH++2t1kMXWLu680zBcLSkL
   SjNqN73OHdtdnzP/rvSIwwkcmjaCSgiKGfN3JhobKe4FeUuF9oeHV/uBA
   x3je00QFd4tagpoGy2/jycvj3X5B/YmJSnmtgMZQxGDGRzKkakckwUudi
   hdH76uC+y/LNn24+7UvkocKq1bZCjekzeHHcW6W9VfD0fMknAXmkKCSqR
   w==;
X-CSE-ConnectionGUID: JBhropZsSLe2OkTLpPKr/w==
X-CSE-MsgGUID: m5n53isDT3izRBQgs6hSjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="64325708"
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="64325708"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 01:48:51 -0700
X-CSE-ConnectionGUID: tbd38+u4TguQK4ophI7O3w==
X-CSE-MsgGUID: 8PsEr+wrTFS4EOzBGuQ9wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="175404818"
Received: from indlpbc065983.iind.intel.com ([10.49.120.87])
  by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2025 01:48:49 -0700
From: George Abraham P <george.abraham.p@intel.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	giovanni.cabiddu@intel.com,
	George Abraham P <george.abraham.p@intel.com>
Subject: [PATCH] PCI/TPH: Skip Root Port completer check for RC_END devices
Date: Thu, 18 Sep 2025 14:19:40 +0530
Message-Id: <20250918084940.1334124-1-george.abraham.p@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Root Complex Integrated Endpoint devices (PCI_EXP_TYPE_RC_END) are
directly integrated into the root complex and do not have an
associated Root Port in the traditional PCIe hierarchy. The current
TPH implementation incorrectly attempts to find and check a Root Port's
TPH completer capability for these devices.

Add a check to skip Root Port completer type verification for RC_END
devices, allowing them to use their full TPH requester capability
without being limited by a non-existent Root Port's completer support.

For RC_END devices, the root complex itself acts as the TPH completer,
and this relationship is handled differently than the standard
endpoint-to-Root-Port model.

Signed-off-by: George Abraham P <george.abraham.p@intel.com>
---
 drivers/pci/tph.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..c61456d24f61 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -397,10 +397,13 @@ int pcie_enable_tph(struct pci_dev *pdev, int mode)
 	else
 		pdev->tph_req_type = PCI_TPH_REQ_TPH_ONLY;
 
-	rp_req_type = get_rp_completer_type(pdev);
+	/* Check if the device is behind a Root Port */
+	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END) {
+		rp_req_type = get_rp_completer_type(pdev);
 
-	/* Final req_type is the smallest value of two */
-	pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+		/* Final req_type is the smallest value of two */
+		pdev->tph_req_type = min(pdev->tph_req_type, rp_req_type);
+	}
 
 	if (pdev->tph_req_type == PCI_TPH_REQ_DISABLE)
 		return -EINVAL;

base-commit: c29008e61d8e75ac7da3efd5310e253c035e0458
-- 
2.40.1


