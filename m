Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BB45AE8BF
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbiIFMvI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbiIFMu7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 08:50:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DC55301C;
        Tue,  6 Sep 2022 05:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468657; x=1694004657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xJb2ujLWIghxWSKF4394g+Zts6PWE+8ivyph6c5ThSc=;
  b=Sqe/v6hdrHQ5GxtZSme3DD5hsLDF7ttdO1Ba+q1J0JMqlpmLm/SbsVtW
   ZN7EA77N1ey/2lUM9uxL/Zwizru8ZOMd+6UgN7oeYI8UUKPYl8gwPD+u5
   9PJK5tDgznk4+1+EBIOMZ82pp6mdRlTAyuVsGrJzCHBpXcLMGS5vE0Ftu
   TQDYS0cfaAGilvrH7GhooEtvAnyoY/IN9oVOXAAuM9ZX96DagASBm7XU4
   O/mopM7iSzoFXMGMTQ2Zycq1xmiGYdGwv03aFYoc1YEz18dud0lwmDUMK
   FIFH4N+7iYVyG4r3gI+AaaTemWP9bDz208iFLelwWKwfGh0v4pDC/vzCA
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283578063"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283578063"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591252828"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 05:50:52 -0700
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
Subject: [PATCH v13 01/13] iommu: Add max_pasids field in struct iommu_device
Date:   Tue,  6 Sep 2022 20:44:46 +0800
Message-Id: <20220906124458.46461-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906124458.46461-1-baolu.lu@linux.intel.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use this field to keep the number of supported PASIDs that an IOMMU
hardware is able to support. This is a generic attribute of an IOMMU
and lifting it into the per-IOMMU device structure makes it possible
to allocate a PASID for device without calls into the IOMMU drivers.
Any iommu driver that supports PASID related features should set this
field before enabling them on the devices.

In the Intel IOMMU driver, intel_iommu_sm is moved to CONFIG_INTEL_IOMMU
enclave so that the pasid_supported() helper could be used in dmar.c
without compilation errors.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h                       | 2 ++
 drivers/iommu/intel/iommu.h                 | 4 ++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 1 +
 drivers/iommu/intel/dmar.c                  | 7 +++++++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ea30f00dc145..ed172cbdabf2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -322,12 +322,14 @@ struct iommu_domain_ops {
  * @list: Used by the iommu-core to keep a list of registered iommus
  * @ops: iommu-ops for talking to this iommu
  * @dev: struct device for sysfs handling
+ * @max_pasids: number of supported PASIDs
  */
 struct iommu_device {
 	struct list_head list;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *fwnode;
 	struct device *dev;
+	u32 max_pasids;
 };
 
 /**
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 74b0e19e23ee..c4831d2bee93 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -478,8 +478,6 @@ enum {
 #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
 #define VTD_FLAG_SVM_CAPABLE		(1 << 2)
 
-extern int intel_iommu_sm;
-
 #define sm_supported(iommu)	(intel_iommu_sm && ecap_smts((iommu)->ecap))
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
@@ -794,6 +792,7 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 extern const struct iommu_ops intel_iommu_ops;
 
 #ifdef CONFIG_INTEL_IOMMU
+extern int intel_iommu_sm;
 extern int iommu_calculate_agaw(struct intel_iommu *iommu);
 extern int iommu_calculate_max_sagaw(struct intel_iommu *iommu);
 extern int dmar_disabled;
@@ -809,6 +808,7 @@ static inline int iommu_calculate_max_sagaw(struct intel_iommu *iommu)
 }
 #define dmar_disabled	(1)
 #define intel_iommu_enabled (0)
+#define intel_iommu_sm (0)
 #endif
 
 static inline const char *decode_prq_descriptor(char *str, size_t size,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d32b02336411..f88541be8213 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3521,6 +3521,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
 	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
+	smmu->iommu.max_pasids = 1UL << smmu->ssid_bits;
 
 	/*
 	 * If the SMMU supports fewer bits than would fill a single L2 stream
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 5a8f780e7ffd..3528058d253e 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1104,6 +1104,13 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 
 	raw_spin_lock_init(&iommu->register_lock);
 
+	/*
+	 * A value of N in PSS field of eCap register indicates hardware
+	 * supports PASID field of N+1 bits.
+	 */
+	if (pasid_supported(iommu))
+		iommu->iommu.max_pasids = 2UL << ecap_pss(iommu->ecap);
+
 	/*
 	 * This is only for hotplug; at boot time intel_iommu_enabled won't
 	 * be set yet. When intel_iommu_init() runs, it registers the units
-- 
2.25.1

