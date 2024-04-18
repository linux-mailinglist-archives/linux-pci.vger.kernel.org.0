Return-Path: <linux-pci+bounces-6440-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B5A8A9F16
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67B71C20E70
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4816EBF9;
	Thu, 18 Apr 2024 15:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNxQzZkN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4BE16C68D
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455511; cv=none; b=f9Jr5U5xwnIhEOvAlb9aL6ickt5sJM1ysKtovM9Eq89onbh0WSfX06nAx7BnHKwAldIwdp+oP1pNAWal5vIe8lA89vbjLRYcyAGlDOaZOFpcg/3iv/EoJBgxyjTckb9U1eqzIPSxbHDxyN3Inyic1viODsvxHEhcsc7CkHgei2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455511; c=relaxed/simple;
	bh=R3E3sXddsLXECQjS/OLimDZaspfmXv+H9hZxH2MU5g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMENRu7FMvvuwNQ87gAQm/RYWBSPdo8JejpkqJIgc9/cEmD7QULZN1Xvf/sv+0PxHqBWOyZrmQdfrSKePvr9iHRwzBB3HdRTld69mwm4nV+/C8mpDd1rBregp4INQHyCcGyXJmo5L7y0UtigTjB8t29vgJkJdJKCosCRjoJuFwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNxQzZkN; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455509; x=1744991509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R3E3sXddsLXECQjS/OLimDZaspfmXv+H9hZxH2MU5g8=;
  b=WNxQzZkNeOpDD/kaByDzE4Q2sEP1q7iLWJJ+3yxJhAz74Xz/qWYj6OoV
   fbJU7569fn2AQPrY+JxVpdyu5/mFG8njG6BUp1vlIGsR/hobAxjgyXyWC
   cPdIPca4W5aS9YO3L0sYoe8XtBTfBeEcG/pYKbLXJitxPy4JNDp36soby
   a9+cvB1XxjHblNzwkwKq7wKwauot7nCoZKB79JMMGx5lP8IYz6qRqVYau
   tMY/l3PGiNNrSCcmuCTU7UXyZBmaMi5eSWycFfHnViXk61eh8hfpmsulK
   rISw+uN64R0LS42Z7jrIMziQAD86MeeclQxJ+b+tTh9zVOuAOqOPKXopi
   A==;
X-CSE-ConnectionGUID: iOVRUO7USNerHN3suJ/CqQ==
X-CSE-MsgGUID: EaycyUaeSmGOGSf1qWZ53g==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20401211"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20401211"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:51:48 -0700
X-CSE-ConnectionGUID: s5Mj9wRhSamoVH8IXgdKBQ==
X-CSE-MsgGUID: hY8Fad13SnigwBLQm3FKNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23094994"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:51:48 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	<linux-pci@vger.kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3] PCI: vmd: Disable MSI remap only for low MSI count
Date: Thu, 18 Apr 2024 11:26:09 -0400
Message-Id: <20240418152609.290301-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VMD MSI remapping is disabled by default for all the CPUs with 28c0 VMD
deviceID. We used to disable remapping because drives supported more
vectors than the VMD so the performance was better without remapping.
Now with CPUs that support more than 64 (128 VMD MSIx vectors for gen4
VMD) we no longer need to disable this feature.

Note, pci_msix_vec_count() failure is translated to ENODEV per typical
expectations that drivers may return ENODEV when some driver-known
fundamental detail of the device is missing.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
v1->v2: Updating commit message.
v2->v3: Use VMD MSI count instead of cpu count.
v3->v4: Updating commit message.
---
 drivers/pci/controller/vmd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 769eedeb8802..ba63af70bb63 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -34,6 +34,8 @@
 #define MB2_SHADOW_OFFSET	0x2000
 #define MB2_SHADOW_SIZE		16
 
+#define VMD_MIN_MSI_VECTOR_COUNT 64
+
 enum vmd_features {
 	/*
 	 * Device may contain registers which hint the physical location of the
@@ -807,13 +809,20 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	sd->node = pcibus_to_node(vmd->dev->bus);
 
+	vmd->msix_count = pci_msix_vec_count(vmd->dev);
+	if (vmd->msix_count < 0)
+		return -ENODEV;
+
 	/*
 	 * Currently MSI remapping must be enabled in guest passthrough mode
 	 * due to some missing interrupt remapping plumbing. This is probably
 	 * acceptable because the guest is usually CPU-limited and MSI
 	 * remapping doesn't become a performance bottleneck.
+	 * Disable MSI remapping only if supported by VMD hardware and when
+	 * VMD MSI count is less than or equal to minimum MSI count.
 	 */
 	if (!(features & VMD_FEAT_CAN_BYPASS_MSI_REMAP) ||
+	    vmd->msix_count > VMD_MIN_MSI_VECTOR_COUNT ||
 	    offset[0] || offset[1]) {
 		ret = vmd_alloc_irqs(vmd);
 		if (ret)
-- 
2.31.1


