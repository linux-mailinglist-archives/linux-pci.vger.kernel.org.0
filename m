Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05A35A27A6
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiHZMT6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbiHZMTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:19:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58F4DEA7A;
        Fri, 26 Aug 2022 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516322; x=1693052322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cod6y9BV4MmE8AUriWIbGWZoeNxV9YeHCqFPn2OmOAQ=;
  b=Vx/4ESCQP6NKbPSA0zXfLsaU3CAzqdBngr1KNE8xLUDYhG1GNLxbcHeF
   pWnO+xX3SS0RjfnBzwv1hcFOwKHko0S2wx3v6BcPt2VFYgcLKsoMKnAGL
   95+ivv+vIzMCALf7qS+qPsYmfFRsyCLoDNnloZTUAkRpW2jOl3jpRhmV0
   PRxZh60yyq3VuO3lyVshR+ZPPuU6Hn+F4uJ4flAuTbMItemDsmgc24pP5
   YMoQdJyTKdQq0/cYjEfu2xgHeheme7wbF7CjJcX1YxqeGQ9w6fRglK118
   sPmeajZ15Sv33YCaeiJvMcrZ40oU1xDNpJbn/7kC4Q+9iPiiRtq4lyDoG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320587443"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320587443"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:18:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747880"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:18:37 -0700
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
Subject: [PATCH v12 17/17] iommu: Rename iommu-sva-lib.{c,h}
Date:   Fri, 26 Aug 2022 20:11:41 +0800
Message-Id: <20220826121141.50743-18-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826121141.50743-1-baolu.lu@linux.intel.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rename iommu-sva-lib.c[h] to iommu-sva.c[h] as it contains all code
for SVA implementation in iommu core.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/{iommu-sva-lib.h => iommu-sva.h}  | 6 +++---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 2 +-
 drivers/iommu/intel/iommu.c                     | 2 +-
 drivers/iommu/intel/svm.c                       | 2 +-
 drivers/iommu/io-pgfault.c                      | 2 +-
 drivers/iommu/{iommu-sva-lib.c => iommu-sva.c}  | 2 +-
 drivers/iommu/iommu.c                           | 2 +-
 drivers/iommu/Makefile                          | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/iommu/{iommu-sva-lib.h => iommu-sva.h} (95%)
 rename drivers/iommu/{iommu-sva-lib.c => iommu-sva.c} (99%)

diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva.h
similarity index 95%
rename from drivers/iommu/iommu-sva-lib.h
rename to drivers/iommu/iommu-sva.h
index 1b3ace4b5863..7215a761b962 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva.h
@@ -2,8 +2,8 @@
 /*
  * SVA library for IOMMU drivers
  */
-#ifndef _IOMMU_SVA_LIB_H
-#define _IOMMU_SVA_LIB_H
+#ifndef _IOMMU_SVA_H
+#define _IOMMU_SVA_H
 
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
@@ -72,4 +72,4 @@ iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 	return IOMMU_PAGE_RESP_INVALID;
 }
 #endif /* CONFIG_IOMMU_SVA */
-#endif /* _IOMMU_SVA_LIB_H */
+#endif /* _IOMMU_SVA_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e7473e879b3c..c5471fa0299c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -10,7 +10,7 @@
 #include <linux/slab.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 #include "../../io-pgtable-arm.h"
 
 struct arm_smmu_mmu_notifier {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f6e145973bc9..a3c5b1a1203b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -31,7 +31,7 @@
 #include <linux/amba/bus.h>
 
 #include "arm-smmu-v3.h"
-#include "../../iommu-sva-lib.h"
+#include "../../iommu-sva.h"
 
 static bool disable_bypass = true;
 module_param(disable_bypass, bool, 0444);
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b8c0afc7f0ac..f5ae4f7f916d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -27,7 +27,7 @@
 
 #include "iommu.h"
 #include "../irq_remapping.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 #include "pasid.h"
 #include "cap_audit.h"
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 3be41b0291e5..028ad54732c5 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -24,7 +24,7 @@
 #include "iommu.h"
 #include "pasid.h"
 #include "perf.h"
-#include "../iommu-sva-lib.h"
+#include "../iommu-sva.h"
 #include "trace.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index d046d89cec55..e5b8b9110c13 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -11,7 +11,7 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 /**
  * struct iopf_queue - IO Page Fault queue
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva.c
similarity index 99%
rename from drivers/iommu/iommu-sva-lib.c
rename to drivers/iommu/iommu-sva.c
index 520ec0b4ed85..54b4a66583d4 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva.c
@@ -6,7 +6,7 @@
 #include <linux/sched/mm.h>
 #include <linux/iommu.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static DEFINE_MUTEX(iommu_sva_lock);
 static DECLARE_IOASID_SET(iommu_sva_pasid);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4dbf9d5436de..9e84f58440dd 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -29,7 +29,7 @@
 #include <trace/events/iommu.h>
 #include <linux/sched/mm.h>
 
-#include "iommu-sva-lib.h"
+#include "iommu-sva.h"
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 44475a9b3eea..c1763476162b 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -27,6 +27,6 @@ obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
 obj-$(CONFIG_HYPERV_IOMMU) += hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
-obj-$(CONFIG_IOMMU_SVA) += iommu-sva-lib.o io-pgfault.o
+obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o io-pgfault.o
 obj-$(CONFIG_SPRD_IOMMU) += sprd-iommu.o
 obj-$(CONFIG_APPLE_DART) += apple-dart.o
-- 
2.25.1

