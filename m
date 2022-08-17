Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69955966BA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 03:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbiHQB0u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 21:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiHQB0e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 21:26:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC4192F4A;
        Tue, 16 Aug 2022 18:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699590; x=1692235590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOVWFVoqFAEMa00of79jsWxJXxmGtoytB1mgbOakG7I=;
  b=NpI9U1Ft4o0seGecup2Z9O9shUfIXFV2mW6ZTWMdJw3376QGIEM4tVbM
   pzhbs4YUJhxvXqAecR3rSD/GSrrf25d3IzRAMoyksbjjxtUrl8BVgfp4i
   i8l8v9ChnNfHeA3QuUPzOZccJdqG99YLdpQyVK9fRd9gLNs7NDTbQhZJB
   Xk1FBz2oVcp3oy03VF1pX0s9CYgoF6AA2jM5ke6WUaQK898dSF5E/6jx3
   x9gB8yFXr0FbbP7oQYUwHQuT/MmQ2HBXG/buVVMuRSDCE4xRuPKR08Ej6
   jNZzJas4vbu0vl20fe1Oj8AbnfcZCYP3Rv48yVbteTDqnp6JzO45Szu/0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293649248"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293649248"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:26:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696587938"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 18:26:22 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v11 08/13] arm-smmu-v3/sva: Add SVA domain support
Date:   Wed, 17 Aug 2022 09:20:19 +0800
Message-Id: <20220817012024.3251276-9-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 76 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
 3 files changed, 85 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index d2ba86470c42..96399dd3a67a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -758,6 +758,7 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
 void arm_smmu_sva_unbind(struct iommu_sva *handle);
 u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
 void arm_smmu_sva_notifier_synchronize(void);
+struct iommu_domain *arm_smmu_sva_domain_alloc(void);
 #else /* CONFIG_ARM_SMMU_V3_SVA */
 static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
 {
@@ -803,5 +804,10 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 }
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
+
+static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
+{
+	return NULL;
+}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index f155d406c5d5..43564b61c726 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -549,3 +549,79 @@ void arm_smmu_sva_notifier_synchronize(void)
 	 */
 	mmu_notifier_synchronize();
 }
+
+static void arm_smmu_sva_block_dev_pasid(struct iommu_domain *domain,
+					 struct device *dev, ioasid_t id)
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
+	struct mm_struct *mm;
+	struct iommu_sva *handle;
+
+	/*
+	 * Detach the domain if a blocking domain is set. Check the
+	 * right domain type once the IOMMU driver supports a real
+	 * blocking domain.
+	 */
+	if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
+		domain = iommu_get_domain_for_dev_pasid(dev, id);
+		if (!domain)
+			return -EINVAL;
+		arm_smmu_sva_block_dev_pasid(domain, dev, id);
+
+		return 0;
+	}
+
+	mm = domain->mm;
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
+	.free			= arm_smmu_sva_domain_free,
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
index f88541be8213..057f7c8824d7 100644
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
-- 
2.25.1

