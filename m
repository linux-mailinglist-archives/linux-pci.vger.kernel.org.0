Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6416AEB3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgBXSYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41926 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgBXSYh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so11578987wrw.8
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4BAEKhOJP+vfPilA/A1esaPeb85rQ2xVF1xbquVY184=;
        b=M99vGkY31vfp3/5YFldshvaVVuOLujfh7ojFCDTnoKW41IMEWZ1aa749ylDMF02mL8
         EsF76A/xd0+D9G0LiMy/75wIjbUpTj5ggp4qwOihccmc7SvybU8lVP0RrXN+zijYA5Qc
         apJfsPNlPuSkqhHR1soKd4ou/vRywxfhU5WwI8xMxkH50xEZuIxIVA73IGnf8LHXAHCj
         UjbtPVxpTDPbVdR0XSSIE6QUa8HgvKgCyzUv3n8pFmnjopnM1ov1eMApD+8zJk5ozwNB
         OxiUpbtucYRP2+G9IoH1N/DTaBxGAqy/M1yy3lxCR8X1HtuJnfAnMQlEHu+w73fAfXiH
         B1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4BAEKhOJP+vfPilA/A1esaPeb85rQ2xVF1xbquVY184=;
        b=W9IDQ3RBUH3DYE+NJpTb/PJm26VfWt5bxXOrt4OXylN9fDAqD+ht6Da3dGRKEO/+O9
         wijnYGdWZq/fv5lztlvrymgF7x7nBmdCVLbTzmM1eRM9QMGfIci4x7abFaprRf2ELIpB
         stXRn22NWhybxtjcM12BUt7g5MhMrDqi7zyi5WJz1yO+MtO0AFGvbzY4yd7Cp07RImy9
         o44OVNlJj0yUAGtITItxt3l0B9zr6bq6pcPpjaU/xPlYheL2CPDumhWGwbInKCPg1z0U
         cJvvd6/7j/x5k5UgxAuTGtNCS4Z5ws8yGE4BVJB/+XGFDDNSn+7NuRZZiA4zmNncWNvJ
         B5ZQ==
X-Gm-Message-State: APjAAAWGzC6ZV8TCghxYOXx454+25+tw468NO64W5beqBJQ61AN0ufR4
        UQ9+sl9KjNZcwF7QVuwkh3eR6Q==
X-Google-Smtp-Source: APXvYqzHbo1uSnOjPvq1dly/T3bNuAsEH0s+K/Vbu0r956R09tVR+hP/VVgCejHxcU6EI1GRu4bYzg==
X-Received: by 2002:a5d:4651:: with SMTP id j17mr69088399wrs.237.1582568675196;
        Mon, 24 Feb 2020 10:24:35 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:34 -0800 (PST)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, baolu.lu@linux.intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [PATCH v4 05/26] iommu/iopf: Handle mm faults
Date:   Mon, 24 Feb 2020 19:23:40 +0100
Message-Id: <20200224182401.353359-6-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200224182401.353359-1-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

When a recoverable page fault is handled by the fault workqueue, find the
associated mm and call handle_mm_fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/io-pgfault.c | 86 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 76e153c59fe3..ffa9f14e0803 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -7,6 +7,7 @@
 
 #include <linux/iommu.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -76,8 +77,65 @@ static int iopf_complete(struct device *dev, struct iopf_fault *iopf,
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
+
+	/*
+	 * If the process exits while we're handling the fault on its mm, we
+	 * can't do mmput(). exit_mmap() would release the MMU notifier, calling
+	 * iommu_notifier_release(), which has to flush the fault queue that
+	 * we're executing on... So mmput_async() moves the release of the mm to
+	 * another thread, if we're the last user.
+	 */
+	mmput_async(mm);
+
+	return status;
 }
 
 static void iopf_handle_group(struct work_struct *work)
@@ -111,6 +169,30 @@ static void iopf_handle_group(struct work_struct *work)
  *
  * Add a fault to the device workqueue, to be handled by mm.
  *
+ * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
+ * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
+ * expect a response. It may be generated when disabling a PASID (issuing a
+ * PASID stop request) by some PCI devices.
+ *
+ * The PASID stop request is triggered by the mm_exit() callback. When the
+ * callback returns from the device driver, no page request is generated for
+ * this PASID anymore and outstanding ones have been pushed to the IOMMU (as per
+ * PCIe 4.0r1.0 - 6.20.1 and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some
+ * PCI devices will wait for all outstanding page requests to come back with a
+ * response before completing the PASID stop request. Others do not wait for
+ * page responses, and instead issue this Stop Marker that tells us when the
+ * PASID can be reallocated.
+ *
+ * It is safe to discard the Stop Marker because it is an optimization.
+ * a. Page requests, which are posted requests, have been flushed to the IOMMU
+ *    when mm_exit() returns,
+ * b. We flush all fault queues after mm_exit() returns and before freeing the
+ *    PASID.
+ *
+ * So even though the Stop Marker might be issued by the device *after* the stop
+ * request completes, outstanding faults will have been dealt with by the time
+ * we free the PASID.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
-- 
2.25.0

