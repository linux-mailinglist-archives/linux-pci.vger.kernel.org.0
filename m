Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B17F81D9E89
	for <lists+linux-pci@lfdr.de>; Tue, 19 May 2020 20:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgESSCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 May 2020 14:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgESSCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 May 2020 14:02:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6725C08C5C0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u188so220731wmu.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2020 11:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0kdAS+3V4p7jXN1k79MYNGRv9Y+4JMnAcNVoiF0l70=;
        b=Y4EdnjwYGiovh5kRncy2PI1+5V23I9EidrfOm90dz7a75obSThtBtY4iz/6hLBVCho
         5gutgO9+jYJaqa3AP50b579CyD3Xo8Os+g5ZMtz+rvzj3KIv4+JVix3pPmzIdWGBJpUr
         mRdFDzxwXg8P6rMBwMIB7hmJCUHwiDSjb9udlALkBO4crYuf5bUdIRrst4t2//W5+BIr
         qDjRWz0EZjqj5ojI8fljkyY6ePbeArnslKBHUJdWTLeNiK8/mjqfUvalHtpMS9aAXXYY
         1FNHNPtwsiFRQScSD/UobANFMpQMISm2uWThO2evgtfehAQl/p6SzjFc3OPNw3sSLGHi
         TQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0kdAS+3V4p7jXN1k79MYNGRv9Y+4JMnAcNVoiF0l70=;
        b=Hkxu0ee1Pj+O3H5ndOYE1H24m32+rS72yCwKmBqMnJvpKGI8b+NOeUMd1YTTQn+Lth
         i7i+MM7kkoq5jDHyVAUNgXDDRYGVwEoFtVuX7hUnxkXi7uU5Xl79rlL0euDxniAtmN8Q
         2yGVa2dTGJCJbASdupmvFm/mtB50OaFsi2CWG+a9br8j9HZIYJ+bR/fcBYHvPNqXuYt1
         c94wpOJOflbBTGfnzxqKSCO1gJSLFV20EM+NJ+vlRs9gLpoMAbU+wJxbfVZqIf4wUSaE
         ieWKG866WNrGBnn8afiBNUDHDcQS3hRUi1Dvvr5BMXceLqRjs6Rg+r8bQS0g+Lbc/R3D
         Am6A==
X-Gm-Message-State: AOAM531D8ffZcKmHwtC7vhUq5nhimljH45jxalPQRIiRjFJ4Se9JLEGg
        /HbH7b2PTSjigMnqT1NVTHPC7w==
X-Google-Smtp-Source: ABdhPJxiur973rQO7P0is4n9bTcqUoLADPVJgaczJU1ETHTcZpVacHBincB+tnOWfVKyZnCnndXCAg==
X-Received: by 2002:a7b:c3da:: with SMTP id t26mr575120wmj.146.1589911319392;
        Tue, 19 May 2020 11:01:59 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id 1sm510496wmz.13.2020.05.19.11.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:01:58 -0700 (PDT)
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
Subject: [PATCH v7 15/24] iommu/arm-smmu-v3: Add SVA device feature
Date:   Tue, 19 May 2020 19:54:53 +0200
Message-Id: <20200519175502.2504091-16-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519175502.2504091-1-jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implement the IOMMU device feature callbacks to support the SVA feature.
At the moment dev_has_feat() returns false since I/O Page Faults isn't
yet implemented.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/arm-smmu-v3.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index a9f6f1d7014e..b016b61cee23 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -703,6 +703,8 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	bool				sva_enabled;
+	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
 
@@ -3013,6 +3015,19 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	/*
+	 * Checking that SVA is disabled ensures that this device isn't bound to
+	 * any mm, and can be safely detached from its old domain. Bonds cannot
+	 * be removed concurrently since we're holding the group mutex.
+	 */
+	mutex_lock(&sva_lock);
+	if (master->sva_enabled) {
+		mutex_unlock(&sva_lock);
+		dev_err(dev, "cannot attach - SVA enabled\n");
+		return -EBUSY;
+	}
+	mutex_unlock(&sva_lock);
+
 	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -3161,6 +3176,7 @@ static int arm_smmu_add_device(struct device *dev)
 	master->smmu = smmu;
 	master->sids = fwspec->ids;
 	master->num_sids = fwspec->num_ids;
+	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -3230,6 +3246,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
+	WARN_ON(master->sva_enabled);
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
@@ -3349,6 +3366,109 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
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
+	bool enabled = false;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	if (!master)
+		return false;
+
+	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		mutex_lock(&sva_lock);
+		enabled = master->sva_enabled;
+		mutex_unlock(&sva_lock);
+		return enabled;
+	default:
+		return false;
+	}
+}
+
+static int arm_smmu_dev_enable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	master->sva_enabled = true;
+	mutex_unlock(&sva_lock);
+
+	return 0;
+}
+
+static int arm_smmu_dev_disable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	if (!list_empty(&master->bonds)) {
+		dev_err(dev, "cannot disable SVA, device is bound\n");
+		mutex_unlock(&sva_lock);
+		return -EBUSY;
+	}
+	master->sva_enabled = false;
+	mutex_unlock(&sva_lock);
+
+	return 0;
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
+		return arm_smmu_dev_disable_sva(dev);
+	default:
+		return -EINVAL;
+	}
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -3367,6 +3487,10 @@ static struct iommu_ops arm_smmu_ops = {
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.put_resv_regions	= generic_iommu_put_resv_regions,
+	.dev_has_feat		= arm_smmu_dev_has_feature,
+	.dev_feat_enabled	= arm_smmu_dev_feature_enabled,
+	.dev_enable_feat	= arm_smmu_dev_enable_feature,
+	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
 };
 
-- 
2.26.2

