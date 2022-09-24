Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0D5E86AE
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiIXAT0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 20:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbiIXASr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 20:18:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCA913B02A;
        Fri, 23 Sep 2022 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663978717; x=1695514717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nTBCdGKexYCHUJx9Vu/JLrB95BP+arp/FT6C/BQTnXY=;
  b=DvSXWyH1B+HTIxnnaPnFKGROy5MRkn09HjNA9fEBOxS3gcIYpDJ5dAfb
   3LST/86p3kJlb9+GKoik8eJG2BEdM5MYTsRzHjdWc1Vft3ZK+MtWPfIls
   +Ggh7iX8Am1v8qu1xtjDhSw602qtJuuflGhyetY5CD9Gkxkyblgf4R4KR
   m+lBAx22nt7V9pn+6Nf4INL07lEryfR+v8pIcKJhG/kq9obOHbsk6i4cu
   kinT5x750Y8pJ5AcNIjJ9e999/hbrnWhniIRDrDl98E23p1NDpHeuU+C7
   zlRBVbeQlinSjiXGOOLYr14aWAqWMvxgAq66um8A1tOqpBzHHPR6AFNGM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="281090429"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="281090429"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="682856891"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2022 17:18:32 -0700
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
Subject: [PATCH v14 06/13] iommu: Add IOMMU SVA domain support
Date:   Sat, 24 Sep 2022 08:11:57 +0800
Message-Id: <20220924001204.4005613-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
References: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The SVA iommu_domain represents a hardware pagetable that the IOMMU
hardware could use for SVA translation. This adds some infrastructures
to support SVA domain in the iommu core. It includes:

- Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
  type. The IOMMU drivers that support allocation of the SVA domain
  should provide its own SVA domain specific iommu_domain_ops.
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
index 5d2b78ac5416..776baa375967 100644
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
@@ -685,6 +698,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
@@ -1055,6 +1070,12 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
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
index bf22992beb98..6a1cd2018e30 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
+#include <linux/sched/mm.h>
 
 #include "dma-iommu.h"
 
@@ -1934,6 +1935,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		mmdrop(domain->mm);
 	iommu_put_dma_cookie(domain);
 	domain->ops->free(domain);
 }
@@ -3383,3 +3386,20 @@ struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
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
2.34.1

