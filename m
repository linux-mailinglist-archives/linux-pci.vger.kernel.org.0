Return-Path: <linux-pci+bounces-1515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D81D81FA2E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 18:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DF21C2285F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC0101C2;
	Thu, 28 Dec 2023 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQaN7dYI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35408F9C2;
	Thu, 28 Dec 2023 17:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782936; x=1735318936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wiw3f8LpISoCCs0eCxO8R6tIE4T0LHnT5p1cf2FrqlU=;
  b=JQaN7dYIn38u/I8AKFUNcPRATiQEM1DPbBU4VlicrKKMjGxT5IiswIKY
   X2jBCMO6xG1JsUvQK5VU+L6r0fZJEri3wL+3RtkVPe2Evx3oHpnTJPx9v
   d4s+dBP+D4RXVTrIU2KDZCJ6fBEd8j0OPOKQ7+Tp8FoXJcrJjJ5Kb6s0H
   sm0Eywl71yxTaTmgn8qnXUExGZlF+swZmjtbq304qtkyJLgiIsPE90oBL
   PcteBYcfuZ+thOu7XP/+GdrjGlF+/dxMSkb/5N/pNUNl4iMQqN3oBTkax
   9lrY9ikiJP2jw8KuiN6Ne5mozc9zXOEiqJy6zdmaeoA+vWRe/vWBWNQG1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="18119304"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="18119304"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 09:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="771757401"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="771757401"
Received: from ply01-vm-store.bj.intel.com ([10.238.153.201])
  by orsmga007.jf.intel.com with ESMTP; 28 Dec 2023 09:02:12 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: kevin.tian@intel.com,
	bhelgaas@google.com,
	baolu.lu@linux.intel.com,
	dwmw2@infradead.org,
	will@kernel.org,
	robin.murphy@arm.com,
	lukas@wunner.de
Cc: linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v10 1/5] iommu/vt-d: add pci_dev parameter to qi_submit_sync and refactor callers
Date: Thu, 28 Dec 2023 12:02:02 -0500
Message-Id: <20231228170206.720675-2-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
References: <20231228170206.720675-1-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/iommu/intel/dmar.c          | 45 +++++++++++++++++++++--------
 drivers/iommu/intel/iommu.c         | 26 +++++------------
 drivers/iommu/intel/iommu.h         | 17 +++++------
 drivers/iommu/intel/irq_remapping.c |  2 +-
 drivers/iommu/intel/pasid.c         | 11 ++-----
 drivers/iommu/intel/svm.c           | 13 ++++-----
 6 files changed, 58 insertions(+), 56 deletions(-)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 23cb80d62a9a..3d661f2b7946 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1344,7 +1344,7 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
  * can be part of the submission but it will not be polled for completion.
  */
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options)
+		   unsigned int count, unsigned long options, struct pci_dev *pdev)
 {
 	struct q_inval *qi = iommu->qi;
 	s64 devtlb_start_ktime = 0;
@@ -1476,7 +1476,7 @@ void qi_global_iec(struct intel_iommu *iommu)
 	desc.qw3 = 0;
 
 	/* should never fail */
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
@@ -1490,7 +1490,7 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
@@ -1514,14 +1514,25 @@ void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask)
+void qi_flush_dev_iotlb(struct intel_iommu *iommu,
+			struct device_domain_info *info, u64 addr, unsigned mask)
 {
+	struct pci_dev *pdev = NULL;
+	u16 sid, qdep, pfsid;
 	struct qi_desc desc;
 
+	if (!info || !info->ats_enabled)
+		return;
+
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
+
+	if (dev_is_pci(info->dev))
+		pdev = to_pci_dev(info->dev);
 	/*
 	 * VT-d spec, section 4.3:
 	 *
@@ -1545,7 +1556,7 @@ void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, pdev);
 }
 
 /* PASID-based IOTLB invalidation */
@@ -1586,16 +1597,26 @@ void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 				QI_EIOTLB_AM(mask);
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /* PASID-based device IOTLB Invalidate */
-void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid,  u16 qdep, u64 addr, unsigned int size_order)
+void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
+				  struct device_domain_info *info, u64 addr, u32 pasid,
+				  unsigned int size_order)
 {
 	unsigned long mask = 1UL << (VTD_PAGE_SHIFT + size_order - 1);
 	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
+	struct pci_dev *pdev = NULL;
+	u16 sid, qdep, pfsid;
+
+	if (!info || !dev_is_pci(info->dev))
+		return;
+	pdev = to_pci_dev(info->dev);
 
+	sid = info->bus << 8 | info->devfn;
+	qdep = info->ats_qdep;
+	pfsid = info->pfsid;
 	/*
 	 * VT-d spec, section 4.3:
 	 *
@@ -1639,7 +1660,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
 		desc.qw1 |= QI_DEV_EIOTLB_SIZE;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, pdev);
 }
 
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
@@ -1649,7 +1670,7 @@ void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
 
 	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
 			QI_PC_GRAN(granu) | QI_PC_TYPE;
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 /*
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 897159dba47d..4dfbb493cd85 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1454,16 +1454,11 @@ static void iommu_disable_pci_caps(struct device_domain_info *info)
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
@@ -1486,11 +1481,7 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
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
@@ -5183,9 +5174,8 @@ static void __init check_tylersburg_isoch(void)
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
 
@@ -5194,11 +5184,9 @@ void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
 
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
index ce030c5b5772..c19d93fd72e9 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -865,23 +865,22 @@ void qi_flush_context(struct intel_iommu *iommu, u16 did,
 		      u16 sid, u8 fm, u64 type);
 void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
 		    unsigned int size_order, u64 type);
-void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			u16 qdep, u64 addr, unsigned mask);
+void qi_flush_dev_iotlb(struct intel_iommu *iommu,
+			struct device_domain_info *info, u64 addr, unsigned mask);
 
 void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32 pasid, u64 addr,
 		     unsigned long npages, bool ih);
 
-void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid, u16 pfsid,
-			      u32 pasid, u16 qdep, u64 addr,
-			      unsigned int size_order);
-void quirk_extra_dev_tlb_flush(struct device_domain_info *info,
-			       unsigned long address, unsigned long pages,
-			       u32 pasid, u16 qdep);
+void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
+				  struct device_domain_info *info, u64 addr, u32 pasid,
+				  unsigned int size_order);
+void quirk_extra_dev_tlb_flush(struct device_domain_info *info, u32 pasid,
+			       unsigned long address, unsigned long mask);
 void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
 			  u32 pasid);
 
 int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
-		   unsigned int count, unsigned long options);
+		   unsigned int count, unsigned long options, struct pci_dev *pdev);
 /*
  * Options used in qi_submit_sync:
  * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 29b9e55dcf26..f834afa3672d 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -153,7 +153,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, int index, int mask)
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	return qi_submit_sync(iommu, &desc, 1, 0);
+	return qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static int modify_irte(struct irq_2_iommu *irq_iommu,
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 74e8e4c17e81..715943531091 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -467,7 +467,7 @@ pasid_cache_invalidation_with_pasid(struct intel_iommu *iommu,
 	desc.qw2 = 0;
 	desc.qw3 = 0;
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static void
@@ -475,16 +475,11 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
 			       struct device *dev, u32 pasid)
 {
 	struct device_domain_info *info;
-	u16 sid, qdep, pfsid;
 
 	info = dev_iommu_priv_get(dev);
 	if (!info || !info->ats_enabled)
 		return;
 
-	sid = info->bus << 8 | info->devfn;
-	qdep = info->ats_qdep;
-	pfsid = info->pfsid;
-
 	/*
 	 * When PASID 0 is used, it indicates RID2PASID(DMA request w/o PASID),
 	 * devTLB flush w/o PASID should be used. For non-zero PASID under
@@ -492,9 +487,9 @@ devtlb_invalidation_with_pasid(struct intel_iommu *iommu,
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
index ac12f76c1212..02719b96e6df 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -181,11 +181,10 @@ static void __flush_svm_range_dev(struct intel_svm *svm,
 
 	qi_flush_piotlb(sdev->iommu, sdev->did, svm->pasid, address, pages, ih);
 	if (info->ats_enabled) {
-		qi_flush_dev_iotlb_pasid(sdev->iommu, sdev->sid, info->pfsid,
-					 svm->pasid, sdev->qdep, address,
+		qi_flush_dev_iotlb_pasid(sdev->iommu, info, address, svm->pasid,
+					 order_base_2(pages));
+		quirk_extra_dev_tlb_flush(info, svm->pasid, address,
 					 order_base_2(pages));
-		quirk_extra_dev_tlb_flush(info, address, order_base_2(pages),
-					  svm->pasid, sdev->qdep);
 	}
 }
 
@@ -543,7 +542,7 @@ void intel_drain_pasid_prq(struct device *dev, u32 pasid)
 			QI_DEV_IOTLB_PFSID(info->pfsid);
 qi_retry:
 	reinit_completion(&iommu->prq_complete);
-	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
+	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN, NULL);
 	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
 		wait_for_completion(&iommu->prq_complete);
 		goto qi_retry;
@@ -646,7 +645,7 @@ static void handle_bad_prq_event(struct intel_iommu *iommu,
 		desc.qw3 = 0;
 	}
 
-	qi_submit_sync(iommu, &desc, 1, 0);
+	qi_submit_sync(iommu, &desc, 1, 0, NULL);
 }
 
 static irqreturn_t prq_event_thread(int irq, void *d)
@@ -811,7 +810,7 @@ int intel_svm_page_response(struct device *dev,
 				ktime_to_ns(ktime_get()) - prm->private_data[0]);
 		}
 
-		qi_submit_sync(iommu, &desc, 1, 0);
+		qi_submit_sync(iommu, &desc, 1, 0, NULL);
 	}
 out:
 	return ret;
-- 
2.31.1


