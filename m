Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC63A1BFE92
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD3OkX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727077AbgD3OkW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33941C035495
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so2101001wra.7
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q1hatq5aHJx0R9t8uwCtyn8RhcKvbal/ky2u44TDT94=;
        b=MCxsvKs90x61N1oHzFrmVtQMdyghKsGyTHvvdPRwSEBey9Uq7axJbJ07O8bAxBIe5n
         CEZB46onPbKWAF0h+5dud8ZtxQdd65J9fyVAQTwzYTUDkfVTAeFzxYI6HxgJosS3vYe1
         Msx6igRoBSv8E+/+bnophcNGlT84MJ4AtufsoNBtgnzsiSlx8Npu+a8mYBFYIVoJZ/aw
         Lb10HHaDmfBzmOhPJoysfpSLSp+khb9XGFd9xyiWbeAktOvrUDYTbiN1JmCrG+RB5qJH
         pZneZseQkQCxH45G6HtCd7hcoqmHh06Mb0PWkAV0Fzk8yecal8e3zAuw2AgM3oIpTe91
         MooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q1hatq5aHJx0R9t8uwCtyn8RhcKvbal/ky2u44TDT94=;
        b=L/STw57txQ0s3IHKsYphwqSO6V+G204om7jR9oI9HmKICIdonBraSK5lw8qwU+AjEy
         EGQlBJam5NuU+3V3haTGz/88FSqOXehfIg12uTRCA9wBEc/HytSSFKxq7EPmRfje1zur
         jAJN65KfNpzIRf2+NZM/cWWm2PND583FA4Nrzz0lqUbOIkxMjo+T0ea33rjrdRaF4wMO
         krkYlTNdrIpB4RYShuGRKaFBNPFfaqTw3hH+8e+kMue1OuxqQyQEoESJdwTU3nloHZC+
         6ifMpsjj8unsfLd1Rlfy8jtBQRZp7NHemMEWvRJRQAhozQ27OBr2hZ2ILrUSaN+6M4yz
         H4+g==
X-Gm-Message-State: AGi0PuZ3JrVSWc3kOG3UE1vuijxTApUuTcxMwYwZblGH/cnUYuqOT9gA
        cmA/QreYjKCzqde6zH5emOh8bw==
X-Google-Smtp-Source: APiQypKmA3hmCuHCbQ57+52GKfslTBCMUy7QnU27YXVTt1gy0M70oLF4dUSLPGv+PyNWWYWlo+FzKQ==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr4212778wrv.75.1588257620897;
        Thu, 30 Apr 2020 07:40:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:19 -0700 (PDT)
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
Subject: [PATCH v6 03/25] iommu/sva: Add PASID helpers
Date:   Thu, 30 Apr 2020 16:34:02 +0200
Message-Id: <20200430143424.2787566-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Let IOMMU drivers allocate a single PASID per mm. Store the mm in the
IOASID set to allow refcounting and searching mm by PASID, when handling
an I/O page fault.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig     |  5 +++
 drivers/iommu/Makefile    |  1 +
 drivers/iommu/iommu-sva.h | 15 +++++++
 drivers/iommu/iommu-sva.c | 85 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+)
 create mode 100644 drivers/iommu/iommu-sva.h
 create mode 100644 drivers/iommu/iommu-sva.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 58b4a4dbfc78b..5327ec663dea1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -102,6 +102,11 @@ config IOMMU_DMA
 	select IRQ_MSI_IOMMU
 	select NEED_SG_DMA_LENGTH
 
+# Shared Virtual Addressing library
+config IOMMU_SVA
+	bool
+	select IOASID
+
 config FSL_PAMU
 	bool "Freescale IOMMU support"
 	depends on PCI
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 9f33fdb3bb051..40c800dd4e3ef 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -37,3 +37,4 @@ obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
diff --git a/drivers/iommu/iommu-sva.h b/drivers/iommu/iommu-sva.h
new file mode 100644
index 0000000000000..78f806fcacbe3
--- /dev/null
+++ b/drivers/iommu/iommu-sva.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SVA library for IOMMU drivers
+ */
+#ifndef _IOMMU_SVA_H
+#define _IOMMU_SVA_H
+
+#include <linux/ioasid.h>
+#include <linux/mm_types.h>
+
+int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max);
+void iommu_sva_free_pasid(struct mm_struct *mm);
+struct mm_struct *iommu_sva_find(ioasid_t pasid);
+
+#endif /* _IOMMU_SVA_H */
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
new file mode 100644
index 0000000000000..3e07b71bde918
--- /dev/null
+++ b/drivers/iommu/iommu-sva.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helpers for IOMMU drivers implementing SVA
+ */
+#include <linux/mutex.h>
+#include <linux/sched/mm.h>
+
+#include "iommu-sva.h"
+
+static DEFINE_MUTEX(iommu_sva_lock);
+static DECLARE_IOASID_SET(shared_pasid);
+
+/**
+ * iommu_sva_alloc_pasid - Allocate a PASID for the mm
+ * @mm: the mm
+ * @min: minimum PASID value (inclusive)
+ * @max: maximum PASID value (inclusive)
+ *
+ * Try to allocate a PASID for this mm, or take a reference to the existing one
+ * provided it fits within the [min, max] range. On success the PASID is
+ * available in mm->pasid, and must be released with iommu_sva_free_pasid().
+ *
+ * Returns 0 on success and < 0 on error.
+ */
+int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
+{
+	int ret = 0;
+	ioasid_t pasid;
+
+	if (min == INVALID_IOASID || max == INVALID_IOASID ||
+	    min == 0 || max < min)
+		return -EINVAL;
+
+	mutex_lock(&iommu_sva_lock);
+	if (mm->pasid) {
+		if (mm->pasid >= min && mm->pasid <= max)
+			ioasid_get(mm->pasid);
+		else
+			ret = -EOVERFLOW;
+	} else {
+		pasid = ioasid_alloc(&shared_pasid, min, max, mm);
+		if (pasid == INVALID_IOASID)
+			ret = -ENOMEM;
+		else
+			mm->pasid = pasid;
+	}
+	mutex_unlock(&iommu_sva_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iommu_sva_alloc_pasid);
+
+/**
+ * iommu_sva_free_pasid - Release the mm's PASID
+ * @mm: the mm.
+ *
+ * Drop one reference to a PASID allocated with iommu_sva_alloc_pasid()
+ */
+void iommu_sva_free_pasid(struct mm_struct *mm)
+{
+	mutex_lock(&iommu_sva_lock);
+	if (ioasid_free(mm->pasid))
+		mm->pasid = 0;
+	mutex_unlock(&iommu_sva_lock);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_free_pasid);
+
+/* ioasid wants a void * argument */
+static bool __mmget_not_zero(void *mm)
+{
+	return mmget_not_zero(mm);
+}
+
+/**
+ * iommu_sva_find() - Find mm associated to the given PASID
+ * @pasid: Process Address Space ID assigned to the mm
+ *
+ * On success a reference to the mm is taken, and must be released with mmput().
+ *
+ * Returns the mm corresponding to this PASID, or an error if not found.
+ */
+struct mm_struct *iommu_sva_find(ioasid_t pasid)
+{
+	return ioasid_find(&shared_pasid, pasid, __mmget_not_zero);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
-- 
2.26.2

