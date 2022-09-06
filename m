Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC42C5AE8CB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240271AbiIFMwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 08:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240270AbiIFMvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 08:51:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F66CD2A;
        Tue,  6 Sep 2022 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468694; x=1694004694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hAOwKG3Hd2GS1XKYYgKl9AxAN7LeM5F3y46hHWU5mkg=;
  b=gNk1nMPfXv0s3J2QZB42kDREIuQoLlpw/XoLSvjN/m90zoyx9rgz0X4F
   EPZShoy5RbB6wElyHXnUiZcG/sQ2C+0QMGg3cOa2p8XluldFwXOINlScw
   9nqihHkHBiaLkkwTu2eDw8QYT6Bss9T25sFKmoYkTbSavU0bOjrq6JHGB
   Dr8hodSMMwGHuHi7xEXIWQuZ9HqgDAvDpEddl2NT59ed193OArcGOPUAK
   89DyQUa4TrJIBSaAdKrGWfo+NpqnzVZq7qFRLnrXe45POHcfmcKYU2cOD
   0lnAVELnc4Rmmu1jQNCG06j1rX136vxwHENZg20kJxhiYlp4FJgWzvxDC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276321112"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276321112"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591252980"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 05:51:29 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v13 08/13] arm-smmu-v3/sva: Add SVA domain support
Date:   Tue,  6 Sep 2022 20:44:53 +0800
Message-Id: <20220906124458.46461-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906124458.46461-1-baolu.lu@linux.intel.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for SVA domain allocation and provide an SVA-specific
iommu_domain_ops. This implementation is based on the existing SVA
code. Possible cleanup and refactoring are left for incremental
changes later.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 61 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 15 +++++
 3 files changed, 90 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d2ba86470c42..5aa853e98d38 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -758,6 +758,9 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(void);
+void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -803,5 +806,16 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+
+static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+{
+	return NULL;
+}
+
+static inline void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
+						 struct device *dev,
+						 ioasid_t id)
+{
+}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f155d406c5d5..503f2b79d11a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -549,3 +549,64 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+void arm_smmu_sva_remove_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t id)
+{
+	struct mm_struct *mm = domain->mm;
+	struct arm_smmu_bond *bond = NULL, *t;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	mutex_lock(&sva_lock);
+	list_for_each_entry(t, &master->bonds, list) {
+		if (t->mm == mm) {
+			bond = t;
+			break;
+		}
+	}
+
+	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
+		list_del(&bond->list);
+		arm_smmu_mmu_notifier_put(bond->smmu_mn);
+		kfree(bond);
+	}
+	mutex_unlock(&sva_lock);
+}
+
+static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t id)
+{
+	int ret = 0;
+	struct iommu_sva *handle;
+	struct mm_struct *mm = domain->mm;
+
+	mutex_lock(&sva_lock);
+	handle = __arm_smmu_sva_bind(dev, mm);
+	if (IS_ERR(handle))
+		ret = PTR_ERR(handle);
+	mutex_unlock(&sva_lock);
+
+	return ret;
+}
+
+static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
+{
+	kfree(domain);
+}
+
+static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
+	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,
+	.free			= arm_smmu_sva_domain_free
+};
+
+struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+{
+	struct iommu_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	domain->ops = &arm_smmu_sva_domain_ops;
+
+	return domain;
+}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f88541be8213..f39e65ca834c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2008,6 +2008,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type == IOMMU_DOMAIN_SVA)
+		return arm_smmu_sva_domain_alloc();
+
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
@@ -2817,6 +2820,17 @@ static int arm_smmu_dev_disable_feature(struct device *dev,
 	}
 }
 
+static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (WARN_ON(IS_ERR(domain)) || !domain)
+		return;
+
+	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
+}
+
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
@@ -2825,6 +2839,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.device_group		= arm_smmu_device_group,
 	.of_xlate		= arm_smmu_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
+	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
 	.dev_disable_feat	= arm_smmu_dev_disable_feature,
 	.sva_bind		= arm_smmu_sva_bind,
-- 
2.25.1

