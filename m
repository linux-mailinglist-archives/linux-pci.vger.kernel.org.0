Return-Path: <linux-pci+bounces-2562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23B83D229
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 02:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F6F4B274C1
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 01:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3515CC;
	Fri, 26 Jan 2024 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmtPGp5Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841EAD49;
	Fri, 26 Jan 2024 01:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706233236; cv=none; b=FUXLoXyjgcx28LHWSU/HyOaGZs61Ya8GiCfMzSYPQT38spFcdkYOofMdXKFJ/2G16kQ6KzyDy9BsXX8OsdMEqn4x3fUcSsOn455h69PLKSE1t7hXRXCeR/I8H/Awf2ony0apOzepOUzlNXYVKRYtgwqMVla3SxNNJo+BsGrdHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706233236; c=relaxed/simple;
	bh=CXF2rO6vNLbMO2Xepa62X8TKjLOzx8JqzSpWfxi/P1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XytKy78fwvtULrwrJmndeYuHHg8Lm5qXlD8QwLZQbo99MMtWgTLpj+RXX0YjzR5M1Rvx3FBvJPycaIMPpizPwWF42TkvFKFO5lCcVvbkcYUiG2deA4t+QpcdGk7vpnZrMsddK0XbN8qXfy4n+lr98NLQqiGwB6TmtUkGU9t6eEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmtPGp5Q; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706233234; x=1737769234;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CXF2rO6vNLbMO2Xepa62X8TKjLOzx8JqzSpWfxi/P1o=;
  b=GmtPGp5QysgKMBQXcedCph5byAWJ0JoEBzm8d0ke6+/copJbqESQVgRP
   pAFVRKmQ+mVKVjpFYX3pL8X+V7ASbLiOGYYz+jZeqX3Su6Yp5fKdnm+cT
   abd4r67w06ByFc8EU/vkyP0NC4j9bnbzUKfF8QKT3JMMdAxL5FXxO+85r
   66qHlLSszIeaohO6jlxR160QMjDUgR6YbvJKftw3gQ0hNnn8ghU0sWac9
   MpHXMKG/hXBuI3B23+V2SInA926SU8kQ8LKOtZb5LvwGQhclnGkgQV3G5
   gL8GiUO49YOESt6F94LJ62r0/LOuZ6TixlcSNdxIY7Svf/+mLplBV6t/O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="15718487"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15718487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 17:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2533129"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by fmviesa003.fm.intel.com with ESMTP; 25 Jan 2024 17:40:30 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: baolu.lu@linux.intel.com,
	bhelgaas@google.com,
	robin.murphy@arm.com,
	jgg@ziepe.ca
Cc: kevin.tian@intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	lukas@wunner.de,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH v11 3/5] iommu/vt-d: simplify parameters of qi_submit_sync() ATS invalidation callers
Date: Thu, 25 Jan 2024 20:40:00 -0500
Message-Id: <20240126014002.481294-4-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
References: <20240126014002.481294-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fold parameters back to struct device_domain_info *info instead of extract
and pass them, thus decrease the number of the parameter passed for
following functions

qi_flush_dev_iotlb()
qi_flush_dev_iotlb_pasid()
quirk_extra_dev_tlb_flush()

no function change.

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c   | 26 ++++++++++++++++++++++----
 drivers/iommu/intel/iommu.c  | 26 +++++++-------------------
 drivers/iommu/intel/iommu.h  | 17 ++++++++---------
 drivers/iommu/intel/nested.c |  9 ++-------
 drivers/iommu/intel/pasid.c  |  9 ++-------
 drivers/iommu/intel/svm.c    |  7 +++----
 6 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..ab5e1760bd59 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1517,11 +1517,20 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	qi_submit_sync(iommu, &desc, 1, 0);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
+void qi_flush_dev_iotlb(struct intel_iommu *iommu,
+			struct device_domain_info *info, u64 addr,
+			unsigned int mask)
 {
+	u16 sid, qdep, pfsid;
 	struct qi_desc desc;
 
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
+
 	/*
 	 * VT-d spec, section 4.3:
 	 *
@@ -1590,11 +1599,20 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 }
 
 /* PASID-based device IOTLB Invalidate */
-void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
+void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
+			      struct device_domain_info *info, u64 addr, u32 pasid,
+			      unsigned int size_order)
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+	u16 sid, qdep, pfsid;
+
+	if (!info || !dev_is_pci(info->dev))
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
 
 	/*
 	 * VT-d spec, section 4.3:
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 6fb5f6fceea1..65bd867dafdd 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1310,16 +1310,11 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
 static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
 				    u64 addr, unsigned int mask)
 {
-	u16 sid, qdep;
-
 	if (!info || !info->ats_enabled)
 		return;
 
-	sid = info->bus << 8 | info->devfn;
-	qdep = info->ats_qdep;
-	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-			   qdep, addr, mask);
-	quirk_extra_dev_tlb_flush(info, addr, mask, IOMMU_NO_PASID, qdep);
+	qi_flush_dev_iotlb(info->iommu, info, addr, mask);
+	quirk_extra_dev_tlb_flush(info, addr, IOMMU_NO_PASID, mask);
 }
 
 static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
@@ -1342,11 +1337,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
 		if (!info->ats_enabled)
 			continue;
 
-		qi_flush_dev_iotlb_pasid(info->iommu,
-					 PCI_DEVID(info->bus, info->devfn),
-					 info->pfsid, dev_pasid->pasid,
-					 info->ats_qdep, addr,
-					 mask);
+		qi_flush_dev_iotlb_pasid(info->iommu, info, addr, dev_pasid->pasid, mask);
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
@@ -4990,9 +4981,8 @@ static void __init check_tylersburg_isoch(void)
  *
  * As a reminder, #6 will *NEED* this quirk as we enable nested translation.
  */
-void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
-			       unsigned long address, unsigned long mask,
-			       u32 pasid, u16 qdep)
+void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
+			       unsigned long address, unsigned long mask)
 {
 	u16 sid;
 
@@ -5001,11 +4991,9 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 
 	sid = PCI_DEVID(info->bus, info->devfn);
 	if (pasid == IOMMU_NO_PASID) {
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, address, mask);
+		qi_flush_dev_iotlb(info->iommu, info, address, mask);
 	} else {
-		qi_flush_dev_iotlb_pasid(info->iommu, sid, info->pfsid,
-					 pasid, qdep, address, mask);
+		qi_flush_dev_iotlb_pasid(info->iommu, info, address, pasid, mask);
 	}
 }
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index d02f916d8e59..f68f17476d85 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1037,18 +1037,17 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did,
 		      u16 sid, u8 fm, u64 type);
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 		    unsigned int size_order, u64 type);
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
-
+void qi_flush_dev_iotlb(struct intel_iommu *iommu,
+			struct device_domain_info *info, u64 addr,
+			unsigned int mask);
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		     unsigned long npages, bool ih);
 
-void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order);
-void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
-			       unsigned long address, unsigned long pages,
-			       u32 pasid, u16 qdep);
+void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
+			      struct device_domain_info *info, u64 addr,
+			      u32 pasid, unsigned int size_order);
+void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
+			       unsigned long address, unsigned long mask);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index f26c7f1c46cc..d15f72b55940 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -78,18 +78,13 @@ static void nested_flush_dev_iotlb(struct dmar_domain *domain, u64 addr,
 {
 	struct device_domain_info *info;
 	unsigned long flags;
-	u16 sid, qdep;
 
 	spin_lock_irqsave(&domain->lock, flags);
 	list_for_each_entry(info, &domain->devices, link) {
 		if (!info->ats_enabled)
 			continue;
-		sid = info->bus << 8 | info->devfn;
-		qdep = info->ats_qdep;
-		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
-				   qdep, addr, mask);
-		quirk_extra_dev_tlb_flush(info, addr, mask,
-					  IOMMU_NO_PASID, qdep);
+		qi_flush_dev_iotlb(info->iommu, info, addr, mask);
+		quirk_extra_dev_tlb_flush(info, IOMMU_NO_PASID, addr, mask);
 	}
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 953592125e4a..5dacdea3cab7 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -208,7 +208,6 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 			       struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
-	u16 sid, qdep, pfsid;
 
 	info = dev_iommu_priv_get(dev);
 	if (!info || !info->ats_enabled)
@@ -217,10 +216,6 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	if (pci_dev_is_disconnected(to_pci_dev(dev)))
 		return;
 
-	sid = info->bus << 8 | info->devfn;
-	qdep = info->ats_qdep;
-	pfsid = info->pfsid;
-
 	/*
 	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
 	 * devTLB flush w/o PASID should be used. For non-zero PASID under
@@ -228,9 +223,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 	 * efficient to flush devTLB specific to the PASID.
 	 */
 	if (pasid == IOMMU_NO_PASID)
-		qi_flush_dev_iotlb(iommu, sid, pfsid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb(iommu, info, 0, 64 - VTD_PAGE_SHIFT);
 	else
-		qi_flush_dev_iotlb_pasid(iommu, sid, pfsid, pasid, qdep, 0, 64 - VTD_PAGE_SHIFT);
+		qi_flush_dev_iotlb_pasid(iommu, info, 0, pasid, 64 - VTD_PAGE_SHIFT);
 }
 
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 40edd282903f..abc226220029 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -181,11 +181,10 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
 	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-					 svm->pasid, sdev->qdep, address,
+		qi_flush_dev_iotlb_pasid(sdev->iommu, info, address, svm->pasid,
 					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, sdev->qdep);
+		quirk_extra_dev_tlb_flush(info, svm->pasid, address,
+					  order_base_2(pages));
 	}
 }
 
-- 
2.31.1


