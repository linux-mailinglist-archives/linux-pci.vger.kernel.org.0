Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66245A2785
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343799AbiHZMSJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343803AbiHZMRw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:17:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650ADC0BB;
        Fri, 26 Aug 2022 05:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516270; x=1693052270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqP5UvRszp3RzVBtau5vxk1E5hu2velGhlvMUw+e0rs=;
  b=VzF9OxoChUJAoBqadIg9ZhGN3MRDoJ+0TJX27u+D8VXbU0JnGZgk/n+T
   6PTyeqvz4HhvBmGIxSKjozdlqNfutzjW/oQWd3lJOrO+azqRjKpOmpuyR
   Q1zGoid9KLkhc+u4L2d29p5I540gEqDvoh6zNXBLcRaVihbWu632jMhXj
   kYSpJT2/NXKWdax3giCijemt5hpfoX9MzS+T9mjv1XxtAAV5PZhLT5ueI
   /SLSQYNCuH7aRxUFKoL7134ZK+CPysjOYh/ksP+3bSVkXukZnVAJla0hl
   8vsnynDLcIJi11gdlk2YK9EPD7mx0E1i+HzVxEOAfeVPPDO0CUxgQHAT+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="292072118"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292072118"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747598"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:44 -0700
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
Subject: [PATCH v12 06/17] iommu: Add IOMMU SVA domain support
Date:   Fri, 26 Aug 2022 20:11:30 +0800
Message-Id: <20220826121141.50743-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826121141.50743-1-baolu.lu@linux.intel.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sva iommu_domain represents a hardware pagetable that the IOMMU
hardware could use for SVA translation. This adds some infrastructure
to support SVA domain in the iommu common layer. It includes:

- Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
  type. The IOMMU drivers that support allocation of the SVA domain
  should provide its own sva domain specific iommu_domain_ops.
- Add a helper to allocate an SVA domain. The iommu_domain_free()
  is still used to free an SVA domain.

The report_iommu_fault() should be replaced by the new
iommu_report_device_fault(). Leave the existing fault handler with the
existing users and the newly added SVA members excludes it.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h | 25 +++++++++++++++++++++++--
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 5e9553a7de0d..836aa480961c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,8 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
+
 /*
  * This are the possible domain-types
  *
@@ -77,6 +79,8 @@ struct iommu_domain_geometry {
  *				  certain optimizations for these domains
  *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
  *				  invalidation.
+ *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process addresses
+ *				  represented by mm_struct's.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
@@ -86,15 +90,24 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
-	iommu_fault_handler_t handler;
-	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	union {
+		struct {
+			iommu_fault_handler_t handler;
+			void *handler_token;
+		};
+		struct {	/* IOMMU_DOMAIN_SVA */
+			struct mm_struct *mm;
+			int users;
+		};
+	};
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -683,6 +696,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
@@ -1058,6 +1073,12 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return false;
 }
 
+static inline struct iommu_domain *
+iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
+{
+	return NULL;
+}
+
 static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
 					    struct device *dev, ioasid_t pasid)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 26aca46193c3..2c9488d966ab 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
+#include <linux/sched/mm.h>
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
@@ -1960,6 +1961,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		mmdrop(domain->mm);
 	iommu_put_dma_cookie(domain);
 	domain->ops->free(domain);
 }
@@ -3384,3 +3387,20 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
 	return domain;
 }
 EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev_pasid);
+
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return NULL;
+
+	domain->type = IOMMU_DOMAIN_SVA;
+	mmgrab(mm);
+	domain->mm = mm;
+
+	return domain;
+}
-- 
2.25.1

