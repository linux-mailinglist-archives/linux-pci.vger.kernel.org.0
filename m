Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7780C1A869A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Apr 2020 19:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbgDNRE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Apr 2020 13:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391162AbgDNREZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Apr 2020 13:04:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9263C061A10
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d77so13808089wmd.3
        for <linux-pci@vger.kernel.org>; Tue, 14 Apr 2020 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VGMc5wLgmgx1eLWq9RQ7RG7NMxWRw2tpIDY5WHUtd3w=;
        b=s8kwev4qB+FwMlvJnZIEgUlpsfPv5PqQmyfezwvPiaaBckIACLW3XMkbvKRq6DnKDi
         t2UKqeUTPQYcigtkMp+zlJsyJsWC29+hzyF/YILdw1kem5LX+rUdahvgddngTIewGKPI
         Ls9qOOWbX1+GZLw2eHVDQ0C+3Q+XuIo7i0CpC5yzUkrPvbUvTws6yMxrz4kHGk4gH7S2
         lLF7B3VkEZoHfACdrS90vN31rEj3/80zND2C7VWgfzHYgNywd5gdWfI831crvwFJA6Fr
         T0J9K0/WC/Dm3PeoZXFwuI8vTy1x6RYRQz3w1oY7B7IC5RAT8PsArjVC3oEpvuMEqYG7
         NofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VGMc5wLgmgx1eLWq9RQ7RG7NMxWRw2tpIDY5WHUtd3w=;
        b=aJ1sVZDN8VFWWkbytwOZXREtPoHT3cKrMLU5e7jhnWmcsKy5Azs9iZ2zq60Ysomw1e
         ZSrMaZmTMcTc/xuEC1hEGi39Jo1tkjHoTMlNvpnCnQZCK3SpMksoMuXr3lcxpHKPGZco
         B4OFliGZtHolYQkvynoxdqZTaz2HL3SeTYmsQ5iz4Xw27mSg/QQoRGF34ou23g85u4bF
         rBuMoHHtD2Ojf1zf12mC8g+wFT9OqbFgX+2nPoR+gIXuDyPldsOEgwFBUSAnpfiP7AJM
         QsVWdWPtz81PibPaMQ8Zs4G1mwJ4OO4VxytvBqUEdcbbQi2NO1DlYz1PyB1htB6kBR63
         kIOg==
X-Gm-Message-State: AGi0Pub2XHr8LoqLitXuDHkUefYc3xyJ4zHShOThvZpE239ZPRtmScCV
        TAKXL7RO80mX7L4e8OaTueu3Bg==
X-Google-Smtp-Source: APiQypL42n0W5SIMAbcNDaJARHcsQO61MSaD9RMrsbqmlsVv6uHGjdhQFjv16aEzCb2QZXgo0ox3nw==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr775518wmc.62.1586883863302;
        Tue, 14 Apr 2020 10:04:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id x18sm19549147wrs.11.2020.04.14.10.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:04:22 -0700 (PDT)
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
Subject: [PATCH v5 04/25] iommu/sva: Search mm by PASID
Date:   Tue, 14 Apr 2020 19:02:32 +0200
Message-Id: <20200414170252.714402-5-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414170252.714402-1-jean-philippe@linaro.org>
References: <20200414170252.714402-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/linux/iommu.h     |  9 +++++++++
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5a3d092c2568a..4b9c25d7246d5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1081,6 +1081,15 @@ void iommu_debugfs_setup(void);
 static inline void iommu_debugfs_setup(void) {}
 #endif
 
+#ifdef CONFIG_IOMMU_SVA
+extern struct mm_struct *iommu_sva_find(int pasid);
+#else /* !CONFIG_IOMMU_SVA */
+static inline struct mm_struct *iommu_sva_find(int pasid)
+{
+	return NULL;
+}
+#endif /* !CONFIG_IOMMU_SVA */
+
 #ifdef CONFIG_IOMMU_PAGE_FAULT
 extern int iommu_queue_iopf(struct iommu_fault *fault, void *cookie);
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 7fecc74a9f7d6..b177d6cbf4fff 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -525,3 +525,22 @@ int iommu_sva_get_pasid_generic(struct iommu_sva *handle)
 	return bond->io_mm->pasid;
 }
 EXPORT_SYMBOL_GPL(iommu_sva_get_pasid_generic);
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
+ * Returns the mm corresponding to this PASID, or an error if not found. A
+ * reference to the mm is taken, and must be released with mmput().
+ */
+struct mm_struct *iommu_sva_find(int pasid)
+{
+	return ioasid_find(&shared_pasid, pasid, __mmget_not_zero);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_find);
-- 
2.26.0

