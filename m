Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E4F1A869C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391162AbgDNREa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391287AbgDNRE0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D224C061A41
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so14955330wml.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IomOGED94uQ/sc+mw27XI7cICJqvlx4xPsMfu0J0FYY=;
        b=GCakNvEsC05vdQy4s9DM45xHnKiEYteUAcD7FyLCP/uTecd/VeAwPmTWPNoushPNYV
         RNOeq6evl2T3CwdSNOB3ZpQ8cQguPZLXa9JzggKMQe0IU5xiemwq49jBFoG/HPGeV5jO
         t5dRmLK1E+Zg1wNi1JpDKCqwSf5Ft+LyS2I11G3Rk/AuaDJ9hliSq44RchEHC4khzI/7
         FQ+xSbVGbSikxMid35s3BjzOuv/5EQZX04YWVmmNkddVLvKqNh1lYoDuSClEnEiZ8YjH
         NZ4PeV/mancwfAQfD0talcSAEJdsbDvnh3PrfKQsvpIiQI7cQ+G3rTKfZSYDXsO+GCmi
         Ua2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IomOGED94uQ/sc+mw27XI7cICJqvlx4xPsMfu0J0FYY=;
        b=uWdLGxf03OvR6nMq7izPNDNtqi/3llsM/1m4yDbE2RK9fP6yQzCUyZfq4MHz+XCNVT
         UQpghaLMPTDqSRQbFNeWvSX5yBDBpOZEcTHnMap65yG9BhqsY9YyQxcf3dfJVmR5X5vN
         AumNi/blNbZ+j0o8D6yuze98Nz54xhcEXTaC4LSzOQdkm4mMuZW3NG6xp0MbePZsT/M9
         zmByUuO89Xl+ehvsZsaw+Oai4E/QDVDCyGw6ubMxRIpqtJyDeUnc0S1+mMLD7LLsxWeG
         4icxYjuPm9cvmkm3o1UaLNlBnSPnjFPzqbJvKUfVDbMkEo2MLuon6Y2bl49UAEFBXunL
         TSCQ==
X-Gm-Message-State: AGi0Pubk7dj9/S+cRQsCyOLbbqDQZs1pYTcXbwOGMvyo7Zk1fphj3HSw
        bLZHt3hViFjnK+JbkRKyFK+5Bw==
X-Google-Smtp-Source: APiQypKbiaMvR8TIzKGaRea1UGF3OINaumxymb+GpCM64htK1x8XN0yXUI9IxJx+k4Q82m6PfxgfWw==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr776491wma.108.1586883864753;
        Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v5 05/25] iommu/iopf: Handle mm faults
Date:   Tue, 14 Apr 2020 19:02:33 +0200
Message-Id: <20200414170252.714402-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v4->v5: no need to call mmput_async() anymore, since the MMU release()
        doesn't flush the IOPF queue anymore.
---
 drivers/iommu/io-pgfault.c | 77 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 5bba8e6a13be2..fd4244023b33f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,6 +7,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -76,8 +77,57 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
 static enum iommu_page_response_code
 iopf_handle_single(struct iopf_fault *iopf)
 {
-	/* TODO */
-	return -ENODEV;
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &iopf->fault.prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	mm = iommu_sva_find(prm->pasid);
+	if (IS_ERR_OR_NULL(mm))
+		return status;
+
+	down_read(&mm->mmap_sem);
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
+	ret = handle_mm_fault(vma, prm->addr, fault_flags);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+
+	return status;
 }
 
 static void iopf_handle_group(struct work_struct *work)
@@ -112,6 +162,29 @@ static void iopf_handle_group(struct work_struct *work)
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is issued by the device driver before unbind(). Once
+ * it completes, no page request is generated for this PASID anymore and
+ * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
+ * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
+ * for all outstanding page requests to come back with a response before
+ * completing the PASID stop request. Others do not wait for page responses, and
+ * instead issue this Stop Marker that tells us when the PASID can be
+ * reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when the stop request completes.
+ * b. We flush all fault queues on unbind() before freeing the PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * we free the PASID.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
-- 
2.26.0

