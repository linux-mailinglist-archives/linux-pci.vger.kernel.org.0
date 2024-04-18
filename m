Return-Path: <linux-pci+bounces-6441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B96E8A9F42
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1D41C235F1
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 15:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94316F83F;
	Thu, 18 Apr 2024 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PAmZK5B7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5BF16D4C0
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713455816; cv=none; b=Pqdyt0M+x8lPae0mzBSaSHHN9rU0sBKum9yH0tvVgnXCHaVgO5VbJ4pEg5CAdtjTf9z6HvY1SMicDJDUBuWftK8fALPXtl93D9Q1VhaRfq5JFyyCH9p8YNu3P0bDlNYwI2VZT0oHk556L4YRxmEMhM9+pkGxScw6fTSd+mv+mDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713455816; c=relaxed/simple;
	bh=CuCUtcEhpYdjf/mbbIa4HGilOqc4yp877YVRmkCeqoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=b6KjDwfug1TqmvplRvxqPNvXcpDgEa7FUsElu9Fch+OmQ1YD/Ck5xCwI4l618KsUrJrzYuLJAjgyOghYudC7bERQ/TCZQcvVpnBvShzPtJJJs+VDGdFG4/31tkjtS4osqUgjiaLBCWHwctk8ubmGkdat+aOX8lN15ypRkGQgCOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PAmZK5B7; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713455814; x=1744991814;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CuCUtcEhpYdjf/mbbIa4HGilOqc4yp877YVRmkCeqoQ=;
  b=PAmZK5B7d91LbNvlK+t/OBSVu8MvxtAzOyVgjFWU0yYYKdHkWAhrGu1a
   eYVIoejpmbzYgmLEKw/cTeZI29jl/hcAjN8+9GacI3ufjifFC7XlNsOGC
   /6h2ITsxYil60sLodQJYM5y7F+lo/wWKfSDlh2OgrV3kdJg3VkQLZZsR4
   V7t6FDeoVREteOHaASJa4wirZ0sgOw4B3eB6L2/2D2zw2MQ9JpnLOX8v3
   ON8iC3yvXoeDyPnVLLyczeYbPKPfDXqev0/1J1fsJgrhC792IWfqP0ajB
   YPCPXlUBQbBGAq4J/PBP/7qxUAPcGpwRxGoJmLG0/l+xNV9nIHLAqAGJD
   w==;
X-CSE-ConnectionGUID: dvHCOI42RqyBpYwdeLXaPw==
X-CSE-MsgGUID: VZzK2/vLQhiar56yc3zLaw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="9236141"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="9236141"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:56:53 -0700
X-CSE-ConnectionGUID: wduSyPp4RnyMaPlSuyGYaA==
X-CSE-MsgGUID: LvCmvWmMS/6H71TpNVBLzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="53961344"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.230.30])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 08:56:54 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: nirmal.patel@linux.intel.com,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v4] PCI: vmd: Disable MSI remap only for low MSI count
Date: Thu, 18 Apr 2024 11:31:21 -0400
Message-Id: <20240418153121.291534-1-nirmal.patel@linux.intel.com>
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
Now with CPUs that support more than 64 (128 VMD MSIx vectors for gen5)
we no longer need to disable this feature.

Note, pci_msix_vec_count() failure is translated to ENODEV per typical
expectations that drivers may return ENODEV when some driver-known
fundamental detail of the device is missing.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
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


