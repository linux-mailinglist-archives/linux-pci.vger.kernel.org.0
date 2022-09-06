Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BDD5AE8CA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240204AbiIFMwS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 08:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240201AbiIFMvo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 08:51:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7E162AB1;
        Tue,  6 Sep 2022 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662468693; x=1694004693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qQyFkEWviMfsMG9OKIQ+XyIS5uKvhS+tiiRPYnK30xk=;
  b=E7n5XLGG3eRdkuJ58UwgFdXtTlzJTY6wXAG6BKV7+TRHubO/drO55Q+n
   uK4/4rW/z+YhID1qxmVawtZmWYm96sTpQwQeNwQZZutE/oxLJdEVN0CMi
   qM1A7THwW58WvVPGRzX2NPyfkFLCt3eCaLq/NFU3nL6aV1o4tMSKsYuxc
   xdqRQiVBc6423Ff1WYcBtCyiqh5QzZHB4aiX28msIokAwrBx8DP7ncu/t
   eaZnoK4sPZZ2EEvsYHSJO2/c0ylMNHiOh/uoPyyy+evlouLFQ1TzNHMH7
   aJKVYVnP8e1xLaDnp+ACbPPkNECQBiSFDIjj/7j1LnS/iEn8tvCT2D9MV
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="276976903"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="276976903"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:51:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="591252952"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2022 05:51:23 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Date:   Tue,  6 Sep 2022 20:44:52 +0800
Message-Id: <20220906124458.46461-8-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906124458.46461-1-baolu.lu@linux.intel.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
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

The VT-d driver will also need to support setting a DMA domain to a
PASID of device. Current SVA implementation uses different data
structures to track the domain and device PASID relationship. That's
the reason why we need to check the domain type in remove_dev_pasid
callback. Eventually we'll consolidate the data structures and remove
the need of domain type check.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/intel/iommu.h | 10 ++++++++
 drivers/iommu/intel/iommu.c | 25 ++++++++++++++++++++
 drivers/iommu/intel/svm.c   | 47 +++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 91312aabdd53..8310bc2f5f0d 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -751,6 +751,8 @@ void intel_svm_unbind(struct iommu_sva *handle);
 u32 intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+struct iommu_domain *intel_svm_domain_alloc(void);
+void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid);
 
 struct intel_svm_dev {
 	struct list_head list;
@@ -776,6 +778,14 @@ struct intel_svm {
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
+static inline struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	return NULL;
+}
+
+static inline void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+}
 #endif
 
 #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 64d30895a4c8..bca38dd79569 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4156,6 +4156,8 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
 		return domain;
 	case IOMMU_DOMAIN_IDENTITY:
 		return &si_domain->domain;
+	case IOMMU_DOMAIN_SVA:
+		return intel_svm_domain_alloc();
 	default:
 		return NULL;
 	}
@@ -4746,6 +4748,28 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
 }
 
+static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
+	struct iommu_domain *domain;
+
+	/* Domain type specific cleanup: */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
+	if (domain) {
+		switch (domain->type) {
+		case IOMMU_DOMAIN_SVA:
+			intel_svm_remove_dev_pasid(dev, pasid);
+			break;
+		default:
+			/* should never reach here */
+			WARN_ON(1);
+			break;
+		}
+	}
+
+	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
+}
+
 const struct iommu_ops intel_iommu_ops = {
 	.capable		= intel_iommu_capable,
 	.domain_alloc		= intel_iommu_domain_alloc,
@@ -4758,6 +4782,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.dev_disable_feat	= intel_iommu_dev_disable_feat,
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
+	.remove_dev_pasid	= intel_iommu_remove_dev_pasid,
 	.pgsize_bitmap		= SZ_4K,
 #ifdef CONFIG_INTEL_IOMMU_SVM
 	.sva_bind		= intel_svm_bind,
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 2420fa5c2360..8fe7cff78356 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -928,3 +928,50 @@ int intel_svm_page_response(struct device *dev,
 	mutex_unlock(&pasid_mutex);
 	return ret;
 }
+
+void intel_svm_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	mutex_lock(&pasid_mutex);
+	intel_svm_unbind_mm(dev, pasid);
+	mutex_unlock(&pasid_mutex);
+}
+
+static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct device_domain_info *info = dev_iommu_priv_get(dev);
+	struct intel_iommu *iommu = info->iommu;
+	struct mm_struct *mm = domain->mm;
+	struct iommu_sva *sva;
+	int ret = 0;
+
+	mutex_lock(&pasid_mutex);
+	sva = intel_svm_bind_mm(iommu, dev, mm);
+	if (IS_ERR(sva))
+		ret = PTR_ERR(sva);
+	mutex_unlock(&pasid_mutex);
+
+	return ret;
+}
+
+static void intel_svm_domain_free(struct iommu_domain *domain)
+{
+	kfree(to_dmar_domain(domain));
+}
+
+static const struct iommu_domain_ops intel_svm_domain_ops = {
+	.set_dev_pasid		= intel_svm_set_dev_pasid,
+	.free			= intel_svm_domain_free
+};
+
+struct iommu_domain *intel_svm_domain_alloc(void)
+{
+	struct dmar_domain *domain;
+
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+	domain->domain.ops = &intel_svm_domain_ops;
+
+	return &domain->domain;
+}
-- 
2.25.1

