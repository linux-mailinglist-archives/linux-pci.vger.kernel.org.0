Return-Path: <linux-pci+bounces-1409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5123A81EBBF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 04:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DCAB222C8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 03:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B74D23BE;
	Wed, 27 Dec 2023 03:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwtX9O+9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7B23C9;
	Wed, 27 Dec 2023 03:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703646567; x=1735182567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6EZM0STQUmP7aVHDp+0lhBXnIJUofqomOyzh9k1hZec=;
  b=gwtX9O+9e31vCkBTMXutUNJ4Lrxp0zNADNkENmSQ2lKMkNgCvg1PjWJY
   3gIboFEMoIisICdB9M9kCuKnjjNcXv7lE53x0IkDUOMeImRZyqBmv8WUt
   igtD62CYk/PB70tGGYX++tLnVJFZ+mkFsEmErKTMKgVJj8aTOj5WYp3TE
   uYxfG3IBE5lNLEd8O1QZKmJpk2ATghR0aRXtDkbJC3GKaNNwEwRlj3Mdx
   aGbOFX3Fcn7IL4T/zdtYq1ab2pW3iss3+iQb7dK1NfohvpuMlSwk7+mXP
   nIgB71L/Gac7cCRvTHxqvUjHFBiZ0cMFwXLT49IKJeasiD67YyQinJ8Lc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="15077222"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="15077222"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 19:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="19839122"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orviesa002.jf.intel.com with ESMTP; 26 Dec 2023 19:09:24 -0800
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
Subject: [RFC PATCH v8 1/5] iommu/vt-d: add flush_target_dev member to struct intel_iommu and pass device info to all ATS invalidation functions
Date: Tue, 26 Dec 2023 22:09:14 -0500
Message-Id: <20231227030918.536413-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231227030918.536413-1-haifeng.zhao@linux.intel.com>
References: <20231227030918.536413-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As iommu is a pointer member of device_domain_info, so can't play
trick like container_of() to get the info and device instance for
qi_submit_sync() low level function to check device status, add a
flush_target_dev member to struct inte_iommu and pass dev info to
all device-TLB invalidation (a.k.a ATS invalidation) functions.

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
index ce030c5b5772..e892c5c7560a 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -731,6 +731,8 @@ struct intel_iommu {
 	void *perf_statistic;
 
 	struct iommu_pmu *pmu;
+
+	struct device *flush_target_dev; /* the target device TLB to be invalidated. */
 };
 
 /* PCI domain-device relationship */
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..1c87fb1b1039 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -485,6 +485,7 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
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


