Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2A45966B9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiHQB1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 21:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiHQB0t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 21:26:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C8C94ECA;
        Tue, 16 Aug 2022 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699600; x=1692235600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TfH8U3az1ocYU61EZ8Cvcu4tqGk6sRSmSQIqJwT466k=;
  b=iuO2+Vjn1yTbTS+0XUMHMadxwdinIZUrNK3+mV+ObJidxsRZ9aK0bOyi
   /oMaEdZbMEHaVSjm4vtBDXwumY1XqFbBQZsmYaCLB4X7t4iemJiuj89oo
   +qdfW3cfhFVVCuxvgAR9FgJnwL4T+G+lZMTy6WUGZhH2r3CXqgtt4OSdN
   NEuHSW5/yFP1nS4Bd8VTSmALx5xFnMuCzblwA6bwXpQbmsS0/8DrmcHqq
   FDYQ9EvqVkW/kwW2nRImRImqRrV0JPnkoARwki9X/EKqg59xleHhvNPe8
   gL+Biq0AIblAcZMEvsz4c37x4y4fFZkE+h9wxzFHxNiOEWqBemrBy1/WB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293649295"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293649295"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696587988"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 18:26:35 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v11 11/13] iommu: Prepare IOMMU domain for IOPF
Date:   Wed, 17 Aug 2022 09:20:22 +0800
Message-Id: <20220817012024.3251276-12-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds some mechanisms around the iommu_domain so that the I/O page
fault handling framework could route a page fault to the domain and
call the fault handler from it.

Add pointers to the page fault handler and its private data in struct
iommu_domain. The fault handler will be called with the private data
as a parameter once a page fault is routed to the domain. Any kernel
component which owns an iommu domain could install handler and its
private parameter so that the page fault could be further routed and
handled.

This also prepares the SVA implementation to be the first consumer of
the per-domain page fault handling model. The I/O page fault handler
for SVA is copied to the SVA file with mmget_not_zero() added before
mmap_read_lock().

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 include/linux/iommu.h         |  3 ++
 drivers/iommu/iommu-sva-lib.h |  8 +++++
 drivers/iommu/io-pgfault.c    |  7 +++++
 drivers/iommu/iommu-sva-lib.c | 58 +++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         |  4 +++
 5 files changed, 80 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 790bdc007f54..bd6331a4dbae 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -98,6 +98,9 @@ struct iommu_domain {
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
+						      void *data);
+	void *fault_data;
 	union {
 		struct {
 			iommu_fault_handler_t handler;
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 8909ea1094e3..1b3ace4b5863 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -26,6 +26,8 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
+enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data);
 
 #else /* CONFIG_IOMMU_SVA */
 static inline int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
@@ -63,5 +65,11 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 {
 	return -ENODEV;
 }
+
+static inline enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	return IOMMU_PAGE_RESP_INVALID;
+}
 #endif /* CONFIG_IOMMU_SVA */
 #endif /* _IOMMU_SVA_LIB_H */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..aee9e033012f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
  * request completes, outstanding faults will have been dealt with by the time
  * the PASID is freed.
  *
+ * Any valid page fault will be eventually routed to an iommu domain and the
+ * page fault handler installed there will get called. The users of this
+ * handling framework should guarantee that the iommu domain could only be
+ * freed after the device has stopped generating page faults (or the iommu
+ * hardware has been set to block the page faults) and the pending page faults
+ * have been flushed.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index f5a9adde7491..79a9d43bdfe1 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -173,3 +173,61 @@ u32 iommu_sva_get_pasid(struct iommu_sva *handle)
 	return domain->mm->pasid;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
+
+/*
+ * I/O page fault handler for SVA
+ */
+enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	vm_fault_t ret;
+	struct vm_area_struct *vma;
+	struct mm_struct *mm = data;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &fault->prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	if (!mmget_not_zero(mm))
+		return status;
+
+	mmap_read_lock(mm);
+
+	vma = find_extend_vma(mm, prm->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (prm->perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= VM_READ;
+
+	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	return status;
+}
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c77860695de3..3ad32aa7523a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,6 +29,8 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 
+#include "iommu-sva-lib.h"
+
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 
@@ -3307,6 +3309,8 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
+	domain->iopf_handler = iommu_sva_handle_iopf;
+	domain->fault_data = mm;
 
 	return domain;
 }
-- 
2.25.1

