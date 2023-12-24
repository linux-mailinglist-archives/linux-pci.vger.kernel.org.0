Return-Path: <linux-pci+bounces-1331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29E081D7F3
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 06:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DB11F21BF7
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 05:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A184EEBC;
	Sun, 24 Dec 2023 05:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jK8ZMZc2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D423D1;
	Sun, 24 Dec 2023 05:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703394431; x=1734930431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hbYMtDZh9ecb4qJKXmKPBSVsqOybIrCUz10/DVpOxCs=;
  b=jK8ZMZc2yTOWfiBVwM2eTpsd/56/spVNhhdlbRXoht1dVMBqbuebhnoi
   AnBUwR0Y9uhNhOFXiA0wytZUIyrpBifvuRMrcpNPmALp5wRtwSWJFy4UB
   wi/XZqND+MkMyjostf9cDNbij/fzS8BFjthHkowB6oif7I53iZul4oGQl
   zBEQCVAyOwfB7pbGebv2TYRvolHwdTBt2Zey0j8W0FaY2XkX7KCaMScVR
   ubU1mRJ0GvBuHY6p3FfCbs6Xo0NYXYd5ZshesyzGkvWLGsnMtp5RLxuJw
   CbTU9jT21ogpa1ydqFlgYXPj9mS2XoKdGcXgbXSIYalWgO98BngLJvg47
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="399005125"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="399005125"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2023 21:07:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10933"; a="780982580"
X-IronPort-AV: E=Sophos;i="6.04,300,1695711600"; 
   d="scan'208";a="780982580"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by fmsmga007.fm.intel.com with ESMTP; 23 Dec 2023 21:07:08 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 3/4] iommu/vt-d: add flush_target_dev member to struct intel_iommu and pass device info to all needed functions
Date: Sun, 24 Dec 2023 00:06:56 -0500
Message-Id: <20231224050657.182022-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
References: <20231224050657.182022-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As iommu is a pointer member of device_domain_info, so can't play
trick like container_of() to get the info and device instance for
qi_submit_sync() low level function usage, add a flush_target_dev
member to struct inte_iommu and pass dev info to all devTLB flush
functions.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 1 +
 drivers/iommu/intel/iommu.h | 2 ++
 drivers/iommu/intel/pasid.c | 1 +
 drivers/iommu/intel/svm.c   | 1 +
 4 files changed, 5 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..c3724f1d86dc 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1461,6 +1461,7 @@ static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 
 	sid = info->bus << 8 | info->devfn;
 	qdep = info->ats_qdep;
+	info->iommu->flush_target_dev = info->dev;
 	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
 			   qdep, addr, mask);
 	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index ce030c5b5772..6c7e67f0bf28 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -731,6 +731,8 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+
+	struct device *flush_target_dev; /* the target device devTLB to be flushed. */
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 7dbee9931eb6..a08bdbec90eb 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -488,6 +488,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	qdep = info->ats_qdep;
 	pfsid = info->pfsid;
 
+	info->iommu->flush_target_dev = info->dev;
 	/*
 	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
 	 * devTLB flush w/o PASID should be used. For non-zero PASID under
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ac12f76c1212..d42a99801cdf 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -181,6 +181,7 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
 	if (info->ats_enabled) {
+		info->iommu->flush_target_dev = info->dev;
 		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
 					 svm->pasid, sdev->qdep, address,
 					 order_base_2(pages));
-- 
2.31.1


