Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74E16AEB0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgBXSYg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36597 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgBXSYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so11584456wru.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1PrCtZ92DmYIwAPbSp2v0XRYBlM5YZLGBrm+uzQwJw=;
        b=k7mwUwe4f2eaHon/rtOusNwQtFja3+krXzwRGZ76SMD3QIwZYajs0PGl8nhuOu3e/Q
         1apHjKKThGa9F78oa6DJmFMg6Kv3M0zbTmO8+Eugcb2SS/fYXhJ75yn9RhWShh6+ftqW
         SUfddUdmPp4ujwFKVXozNBlY07/fSNyDISwYswJ30vRiZLJreuqTJ9fsed4djsvvIOny
         CMUJVS9RaKMUHia7+nXA9mZRl4QIa/ovZElpv9c2ACyb/VTFsnCnfWqipmg5gOCNeNSo
         PYeBPGGuW7xmjQCqEwsgxBu69OnvQazgX6XmX1S0LvnK/9wPepXn8vuUv4vl+VoCv6/L
         MvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1PrCtZ92DmYIwAPbSp2v0XRYBlM5YZLGBrm+uzQwJw=;
        b=FTwEskBGU4c+/ApJyugS1SHmjXxkrqTavxPtoBk5VmocBCikDKMORPb/8O/PTkp4/a
         ivHjBBBJGj+VvkY30N4ggG3EMHIEv4A6C16YPlTCzcL8iFnCDvLkEjDg+H/9IFU7HE3P
         vSrUlrJXynYdatMDeONJyv+/O83UdbaryYW1W0VB5D+0aSKfPOUP4kz15jI7/bXI4q9D
         mbQrZdvhNAcim/HkqQ5yGLcCWew5GEWdnu2v4hz4uV4B6+x4N7nTmABSbaXIshZ157NL
         Iwa2eZBAQU5BNTtqoILFIJ2j0HykDTFrpWdDsRByy/Evxs1d6fE5vcfV9Okpns6yIl3i
         momA==
X-Gm-Message-State: APjAAAW8L6mI/QuG3CdTey647uqyG6EviwV1N4jNwKplu5Gcf2/2QNCZ
        AVbOvpmXVP58tEcpG85qNCRofg==
X-Google-Smtp-Source: APXvYqyJoaGCAZwRcxK03cHvWfZ3rPd9BodvC//3q8tPBefjV5p8k/3KCURkzx9rn1YbvnVHRvzLqg==
X-Received: by 2002:adf:e908:: with SMTP id f8mr4337597wrm.37.1582568674081;
        Mon, 24 Feb 2020 10:24:34 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:33 -0800 (PST)
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
Subject: [PATCH v4 04/26] iommu/sva: Search mm by PASID
Date:   Mon, 24 Feb 2020 19:23:39 +0100
Message-Id: <20200224182401.353359-5-jean-philippe@linaro.org>
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

The fault handler will need to find an mm given its PASID. This is the
reason we have an IDR for storing address spaces, so hook it up.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/iommu-sva.c | 19 +++++++++++++++++++
 include/linux/iommu.h     |  9 +++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 64f1d1c82383..bfd0c477f290 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -559,3 +559,22 @@ int iommu_sva_get_pasid_generic(struct iommu_sva *handle)
 	return pasid;
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
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e7bc47ba24f8..e52a8731e7a9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1091,6 +1091,15 @@ void iommu_debugfs_setup(void);
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
 
-- 
2.25.0

