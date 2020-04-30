Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC01BFE99
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgD3OkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727915AbgD3OkZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7DBC035494
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so7249476wrx.3
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iB79dQWmb3AvvVXZjQ0zsRWqvSDeK4D4Xz99psG6JTA=;
        b=kqqBCMB8wIC1y8Rio6R5IHwLudVi7bFHNMpl4mEWV+Y0muWKmz6UZdqzNbGIyv5bpm
         ftjPpJIsHT6qnfm1WBiwXzW0T9u+mx+BLucZZwSt+n6HlLu3OSGZht29vm6F8Fq8duSi
         0TYRzwrsU8ORGEfBJC7KXIFiwOnmGJYql/QapNaZMjA07wOmNmtpjrTa1KxyQZxnN62Z
         meBoHmfPL1kKNc3YQBwMO5g0U/lUxxsuQYzgsH2pPZ1Ihf9zgWxIu2o1K0uh+IY+I4GC
         l8gVonWj4kZ5mCvht3R6nzU1dVk4MyhI6+2z+1XxRDDZELQYysBCbFL9Ocg1hZBxd3G7
         mkow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iB79dQWmb3AvvVXZjQ0zsRWqvSDeK4D4Xz99psG6JTA=;
        b=eagabgW782XuNCEMlymORaCC4TIitdS37ak/8Td+vvHhD2a5WpxXqhnmqTf2aR6P5W
         SkvkUUfsht+chl0X2gUxqHj1oERF5nhPWFIZj6SsxJ9DVzCz0oJmOQnttc97HcOWmbWJ
         qThlNFd3AqVsEY/BSLF2JKWA4ygkgsPrE3AQbRz6rb8oGIUkQAWvzrNcMl2nxrb4VvQg
         FfWesguVbiHsEgDsBcJD+IlxiHjH1C/OsSWScrT3FHY6E2FDnFJcoeSybpi2ztdtoGcp
         Yz8dYC6hBJVc0CYEG67HMNtmxSurpM1D3JN4AFWMjWcgSqfsT76d+MDKMgvTHprZVuh4
         ULdQ==
X-Gm-Message-State: AGi0PubiQICF4Ev6wIMX/1CRmYZkWXtaKAMD5u7lxu1fefg64nERpe8S
        Dn+StJkZKmmDRCPoh5GSlRkLmw==
X-Google-Smtp-Source: APiQypKo5YoV4AJzsHf9kucHEPOc1ER//OsvvC5CHY6aaljoQYE5sAtc1uK8eedAg1itVao5PaJXJA==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr4154957wrc.43.1588257623760;
        Thu, 30 Apr 2020 07:40:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:22 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 05/25] iommu/iopf: Handle mm faults
Date:   Thu, 30 Apr 2020 16:34:04 +0200
Message-Id: <20200430143424.2787566-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
v5->v6: select CONFIG_IOMMU_SVA
---
 drivers/iommu/Kconfig      |  1 +
 drivers/iommu/io-pgfault.c | 79 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 4f33e489f0726..1e64ee6592e16 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -109,6 +109,7 @@ config IOMMU_SVA
 
 config IOMMU_PAGE_FAULT
 	bool
+	select IOMMU_SVA
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 38732e97faac1..09a71dc4de20a 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,9 +7,12 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
+#include "iommu-sva.h"
+
 /**
  * struct iopf_queue - IO Page Fault queue
  * @wq: the fault workqueue
@@ -68,8 +71,57 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
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
@@ -104,6 +156,29 @@ static void iopf_handle_group(struct work_struct *work)
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
2.26.2

