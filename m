Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B822216AED5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 19:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBXSYv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 13:24:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45976 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBXSYu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 13:24:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id g3so11537145wrs.12
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgVOPZ49x+1WrAdlWgbH+8j706qx2NuqDvbYc/uYWqQ=;
        b=DVVCVC36hOalbx91/U6kWD3ccIyGZj7ZRW5vpODSj3gu99YZ5+LCzw4kQfmBti4iJW
         I5ScSgKsJDdcwatGi5aA2Qx5/ffbToJmmMzZ0xftW+g2u6cChxL8uMOCYwct5IVk707S
         2FuW+tN52SNX4qyRaGUM2rAAJxuwMk1Fq+u9P0FhmYP9BIpo4PCfwht7+KJOtLqVYX09
         zXN9rgCcbRujvfDXfatzgxkjUn76Zuiq06G0lQzeP6mQUtufL30DcY2NyWUj7SjEqnJY
         IYeeZ+Y5NWWRqXvsEAL/j2Ic6zO4+PGLo4Wxn3yw4PROGnWprozGZFdCjKu3vnhPwHKa
         sP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgVOPZ49x+1WrAdlWgbH+8j706qx2NuqDvbYc/uYWqQ=;
        b=TK4GWz7opr8yF4hM0tTdZGHjDzXZx0ltJkDNfz9Dc6uoAY1jqgJ16wTnSmY3/q4XhS
         R6iD9k766ExaxvNPSFnyKuS/e782EiIvX+7UH9zVEEiCnFKR70qaUEw9oCVsH6suQ11S
         j5zpvDxRgeXDs9quRiULMZrtsKkrplfiPPCgiCs2ENxipnBfvTmTGkRBt7qfD8tZd6uc
         E/4cpU8+4f1GOj9kgFqsG07HQTTEzvxdUbWf2cNJIijcxfcoHJwDKRC3YtfDJ4vMGZoN
         gLoQE8QXb28bCN82hDmiR0y0ML5gxeg7XaU7dkv72+6NSPAOWfYTG9Qxf6qEx/p5PodA
         UF9Q==
X-Gm-Message-State: APjAAAVlAxROj0DDbmKa4wJ6eXYwJVkchKgxZ7qnske3Rnb3s9CMuFI2
        FTCAxo8MOAY7UcbZ6EW95eDEOA==
X-Google-Smtp-Source: APXvYqySTJeCzOmWaA354F9WnN4bUCNey753ZHQTjm+04zgAPahujuB+OVrEUHRHVNITM4h9f5/NJw==
X-Received: by 2002:a5d:4847:: with SMTP id n7mr67178382wrs.30.1582568688179;
        Mon, 24 Feb 2020 10:24:48 -0800 (PST)
Received: from localhost.localdomain ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id n3sm304255wmc.27.2020.02.24.10.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 10:24:47 -0800 (PST)
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
Subject: [PATCH v4 17/26] iommu/arm-smmu-v3: Implement mm operations
Date:   Mon, 24 Feb 2020 19:23:52 +0100
Message-Id: <20200224182401.353359-18-jean-philippe@linaro.org>
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

Hook SVA operations to support sharing page tables with the SMMUv3:

* dev_enable/disable/has_feature for device drivers to modify the SVA
  state.
* sva_bind/unbind and sva_get_pasid to bind device and address spaces.
* The mm_attach/detach/invalidate/free callbacks from iommu-sva

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/Kconfig       |   1 +
 drivers/iommu/arm-smmu-v3.c | 176 +++++++++++++++++++++++++++++++++++-
 2 files changed, 175 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 211684e785ea..05341155d34b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -434,6 +434,7 @@ config ARM_SMMU_V3
 	tristate "ARM Ltd. System MMU Version 3 (SMMUv3) Support"
 	depends on ARM64
 	select IOMMU_API
+	select IOMMU_SVA
 	select IOMMU_IO_PGTABLE_LPAE
 	select GENERIC_MSI_IRQ_DOMAIN
 	help
diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 54bd6913d648..3973f7222864 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -36,6 +36,7 @@
 #include <linux/amba/bus.h>
 
 #include "io-pgtable-arm.h"
+#include "iommu-sva.h"
 
 /* MMIO registers */
 #define ARM_SMMU_IDR0			0x0
@@ -1872,7 +1873,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_share_asid(u16 asid)
 	return NULL;
 }
 
-__maybe_unused
 static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 {
 	u16 asid;
@@ -1969,7 +1969,6 @@ static struct arm_smmu_ctx_desc *arm_smmu_alloc_shared_cd(struct mm_struct *mm)
 	return ERR_PTR(ret);
 }
 
-__maybe_unused
 static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 {
 	if (arm_smmu_free_asid(cd)) {
@@ -2958,6 +2957,12 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	smmu = master->smmu;
 
+	if (iommu_sva_enabled(dev)) {
+		/* Did the previous driver forget to release SVA handles? */
+		dev_err(dev, "cannot attach - SVA enabled\n");
+		return -EBUSY;
+	}
+
 	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -3057,6 +3062,81 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 	return ops->iova_to_phys(ops, iova);
 }
 
+static void arm_smmu_mm_invalidate(struct device *dev, int pasid, void *entry,
+				   unsigned long iova, size_t size)
+{
+	/* TODO: Invalidate ATC */
+}
+
+static int arm_smmu_mm_attach(struct device *dev, int pasid, void *entry,
+			      bool attach_domain)
+{
+	struct arm_smmu_ctx_desc *cd = entry;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	/*
+	 * If another device in the domain has already been attached, the
+	 * context descriptor is already valid.
+	 */
+	if (!attach_domain)
+		return 0;
+
+	return arm_smmu_write_ctx_desc(smmu_domain, pasid, cd);
+}
+
+static void arm_smmu_mm_detach(struct device *dev, int pasid, void *entry,
+			       bool detach_domain)
+{
+	struct arm_smmu_ctx_desc *cd = entry;
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (detach_domain) {
+		arm_smmu_write_ctx_desc(smmu_domain, pasid, NULL);
+
+		/*
+		 * The ASID allocator won't broadcast the final TLB
+		 * invalidations for this ASID, so we need to do it manually.
+		 * For private contexts, freeing io-pgtable ops performs the
+		 * invalidation.
+		 */
+		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
+	}
+
+	/* TODO: invalidate ATC */
+}
+
+static void *arm_smmu_mm_alloc(struct mm_struct *mm)
+{
+	return arm_smmu_alloc_shared_cd(mm);
+}
+
+static void arm_smmu_mm_free(void *entry)
+{
+	arm_smmu_free_shared_cd(entry);
+}
+
+static struct io_mm_ops arm_smmu_mm_ops = {
+	.alloc		= arm_smmu_mm_alloc,
+	.invalidate	= arm_smmu_mm_invalidate,
+	.attach		= arm_smmu_mm_attach,
+	.detach		= arm_smmu_mm_detach,
+	.release	= arm_smmu_mm_free,
+};
+
+static struct iommu_sva *
+arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1)
+		return ERR_PTR(-EINVAL);
+
+	return iommu_sva_bind_generic(dev, mm, &arm_smmu_mm_ops, drvdata);
+}
+
 static struct platform_driver arm_smmu_driver;
 
 static
@@ -3175,6 +3255,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = fwspec->iommu_priv;
 	smmu = master->smmu;
+	iommu_sva_disable(dev);
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
@@ -3294,6 +3375,90 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 	iommu_dma_get_resv_regions(dev, head);
 }
 
+static bool arm_smmu_iopf_supported(struct arm_smmu_master *master)
+{
+	return false;
+}
+
+static bool arm_smmu_dev_has_feature(struct device *dev,
+				     enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		if (!(master->smmu->features & ARM_SMMU_FEAT_SVA))
+			return false;
+
+		/* SSID and IOPF support are mandatory for the moment */
+		return master->ssid_bits && arm_smmu_iopf_supported(master);
+	default:
+		return false;
+	}
+}
+
+static bool arm_smmu_dev_feature_enabled(struct device *dev,
+					 enum iommu_dev_features feat)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return iommu_sva_enabled(dev);
+	default:
+		return false;
+	}
+}
+
+static int arm_smmu_dev_enable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_to_master(dev);
+	struct iommu_sva_param param = {
+		.min_pasid = 1,
+		.max_pasid = 0xfffffU,
+	};
+
+	param.max_pasid = min(param.max_pasid, (1U << master->ssid_bits) - 1);
+	return iommu_sva_enable(dev, &param);
+}
+
+static int arm_smmu_dev_enable_feature(struct device *dev,
+				       enum iommu_dev_features feat)
+{
+	if (!arm_smmu_dev_has_feature(dev, feat))
+		return -ENODEV;
+
+	if (arm_smmu_dev_feature_enabled(dev, feat))
+		return -EBUSY;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return arm_smmu_dev_enable_sva(dev);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int arm_smmu_dev_disable_feature(struct device *dev,
+					enum iommu_dev_features feat)
+{
+	if (!arm_smmu_dev_feature_enabled(dev, feat))
+		return -EINVAL;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		return iommu_sva_disable(dev);
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -3312,6 +3477,13 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.dev_has_feat		= arm_smmu_dev_has_feature,
+	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
+	.dev_enable_feat	= arm_smmu_dev_enable_feature,
+	.dev_disable_feat	= arm_smmu_dev_disable_feature,
+	.sva_bind		= arm_smmu_sva_bind,
+	.sva_unbind		= iommu_sva_unbind_generic,
+	.sva_get_pasid		= iommu_sva_get_pasid_generic,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.25.0

