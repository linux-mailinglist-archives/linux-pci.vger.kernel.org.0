Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2EA1BFEBD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 16:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgD3Okk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728238AbgD3Okj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Apr 2020 10:40:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28AEC035495
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so2102279wra.7
        for <linux-pci@vger.kernel.org>; Thu, 30 Apr 2020 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+Y465Sni3J3luu7XimUOxgL9xc/SbRMYs8QGnoYtwY=;
        b=TtWZcvpylTP3NKbk1Qf+IfameDvqZwRMdS3q3fg9H/lGyRYGkfrFQHeCjVudgdRINK
         Dq9MBXVYhLCootNKcVgNxJ0FpLgrlim5f8lBDkhqOHb4VlcZ0hgTMzBs9d8jFICV8fxd
         KUaJwiZ/OQ/gYRUVE9gc/aIwRBe6IYvQieRFWK0Azug7U8btG7FcOaY/Rl26e4sAz3/Z
         RZCe40RFC/rBtjCjoR1VIZgcnqrMnLBOx8zWFTiYXhg9MCah5cXaoQvRl2P+hicnxqoW
         WZX2CnayKDPy2Ftc0OhUQymVBrwqr0Ejdo1y1yZof/qNkV3kOYRJQ/n9IxhuHsljv10x
         hQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+Y465Sni3J3luu7XimUOxgL9xc/SbRMYs8QGnoYtwY=;
        b=OvX6av7JUoDHmbZQt6Z+tPXmiXnuSbtvV+FjqeeJKVrO50U2vGVZy4ZHiMZUkUgpGa
         diYtVNlXFRrR/QxBlY1RouWFtKEBdJUqv90rH1DiLgFHSBx217GUVQCXQiQVmKSohQ+8
         a4l53CKdmlOyOw/cxj7KzbzoBwYl9Ub09uJ42L9xg3S6/TAJPH1XAviuXG5f+U10Bg73
         vwrfKIVEj/7KnpLhRnxqWM9Sf2/2KUsO4atpg6sdvxusPJvJmR7FsNOAxmUEq68fHhun
         lyvFMrz55Hv4h+IZopJc2IDMQJBx7uafza6LU332VMkeGHXaZSAPoowLNHEa4/R8MzqM
         2LSw==
X-Gm-Message-State: AGi0PuZDX5sm9cg/o2/TdyXCJ/+81ZHPi4l3CPU/9KpCxDxRgMAT286t
        Y65q7rQSiRxwUfabtvUs1AOupw==
X-Google-Smtp-Source: APiQypLNwodkDrJdjB7I+V7HVBZt0+iw9yRn6csSeR+Ms37qAdkN8Vx1hciLeFRaXiPs0nPP5OwXew==
X-Received: by 2002:adf:8169:: with SMTP id 96mr3141118wrm.283.1588257637544;
        Thu, 30 Apr 2020 07:40:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:171b:226e:c200:c43b:ef78:d083:b355])
        by smtp.gmail.com with ESMTPSA id n2sm4153286wrt.33.2020.04.30.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 07:40:36 -0700 (PDT)
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
Subject: [PATCH v6 16/25] iommu/arm-smmu-v3: Add SVA device feature
Date:   Thu, 30 Apr 2020 16:34:15 +0200
Message-Id: <20200430143424.2787566-17-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430143424.2787566-1-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
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
 drivers/iommu/arm-smmu-v3.c | 125 ++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9b90cc57a609b..c7942d0540599 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -700,6 +700,8 @@ struct arm_smmu_master {
 	u32				*sids;
 	unsigned int			num_sids;
 	bool				ats_enabled;
+	bool				sva_enabled;
+	struct list_head		bonds;
 	unsigned int			ssid_bits;
 };
 
@@ -738,6 +740,7 @@ struct arm_smmu_option_prop {
 
 static DEFINE_XARRAY_ALLOC1(asid_xa);
 static DEFINE_SPINLOCK(contexts_lock);
+static DEFINE_MUTEX(arm_smmu_sva_lock);
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -3003,6 +3006,19 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	/*
+	 * Checking that SVA is disabled ensures that this device isn't bound to
+	 * any mm, and can be safely detached from its old domain. Bonds cannot
+	 * be removed concurrently since we're holding the group mutex.
+	 */
+	mutex_lock(&arm_smmu_sva_lock);
+	if (master->sva_enabled) {
+		mutex_unlock(&arm_smmu_sva_lock);
+		dev_err(dev, "cannot attach - SVA enabled\n");
+		return -EBUSY;
+	}
+	mutex_unlock(&arm_smmu_sva_lock);
+
 	arm_smmu_detach_dev(master);
 
 	mutex_lock(&smmu_domain->init_mutex);
@@ -3151,6 +3167,7 @@ static int arm_smmu_add_device(struct device *dev)
 	master->smmu = smmu;
 	master->sids = fwspec->ids;
 	master->num_sids = fwspec->num_ids;
+	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
 	/* Check the SIDs are in range of the SMMU and our stream table */
@@ -3220,6 +3237,7 @@ static void arm_smmu_remove_device(struct device *dev)
 
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
+	WARN_ON(master->sva_enabled);
 	arm_smmu_detach_dev(master);
 	iommu_group_remove_device(dev);
 	iommu_device_unlink(&smmu->iommu, dev);
@@ -3339,6 +3357,109 @@ static void arm_smmu_get_resv_regions(struct device *dev,
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
+		mutex_lock(&arm_smmu_sva_lock);
+		enabled = master->sva_enabled;
+		mutex_unlock(&arm_smmu_sva_lock);
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
+	mutex_lock(&arm_smmu_sva_lock);
+	master->sva_enabled = true;
+	mutex_unlock(&arm_smmu_sva_lock);
+
+	return 0;
+}
+
+static int arm_smmu_dev_disable_sva(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&arm_smmu_sva_lock);
+	if (!list_empty(&master->bonds)) {
+		dev_err(dev, "cannot disable SVA, device is bound\n");
+		mutex_unlock(&arm_smmu_sva_lock);
+		return -EBUSY;
+	}
+	master->sva_enabled = false;
+	mutex_unlock(&arm_smmu_sva_lock);
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
@@ -3357,6 +3478,10 @@ static struct iommu_ops arm_smmu_ops = {
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

