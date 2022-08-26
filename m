Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497B55A2797
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343699AbiHZMS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbiHZMSN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:18:13 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A4D9D64;
        Fri, 26 Aug 2022 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516293; x=1693052293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YmFC8zLHQfeuODp8Z0sRULA2gpiKXokbwxdTZ3Q4dXs=;
  b=eWqVvirG/o7L4M++A4on/GdVj4TOd7+CFbaYyzdK290M87n1+F7ZVx35
   +IPKEivKzm85xTgK8V+ojDiCuwWE+Ki03l9T2nKyoNMiHekWIDFdCF2nA
   rWPLj0BF3t7YfCPBdkUUdMZMWf96ezlv5Q8KtI6Mr8ISTFdvGTBD01SX5
   EUkQG3ne68AMwhgPDZdGZO067BA4Bhb1LWLqQx3OHAvtzWVSWEyYITqqB
   oWWj4zbMTr7jVeiXFdlgKhK28RUGS3bxHFE0L7RdnJraRxICTC/v6jW0w
   /jpH+1dy2bORE4f0asyn4lJO89NDlVSeMk3GVX2Q79sxJJo80tOqCP8dG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="320587365"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="320587365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747749"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:18:08 -0700
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
Subject: [PATCH v12 11/17] arm-smmu-v3: Add blocking domain support
Date:   Fri, 26 Aug 2022 20:11:35 +0800
Message-Id: <20220826121141.50743-12-baolu.lu@linux.intel.com>
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

The ARM SMMUv3 hardwares support blocking DMA transactions by clearing
the translation table entries. This implements a real blocking domain
to avoid using an empty UNMANAGED domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f88541be8213..5520a9607758 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -88,6 +88,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ 0, NULL},
 };
 
+static void arm_smmu_detach_dev(struct arm_smmu_master *master);
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -2004,10 +2006,28 @@ static bool arm_smmu_capable(enum iommu_cap cap)
 	}
 }
 
+static int blocking_domain_attach_dev(struct iommu_domain *domain,
+				      struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+
+	arm_smmu_detach_dev(master);
+	return 0;
+}
+
+static struct iommu_domain blocking_domain = {
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev	= blocking_domain_attach_dev
+	}
+};
+
 static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 {
 	struct arm_smmu_domain *smmu_domain;
 
+	if (type == IOMMU_DOMAIN_BLOCKED)
+		return &blocking_domain;
+
 	if (type != IOMMU_DOMAIN_UNMANAGED &&
 	    type != IOMMU_DOMAIN_DMA &&
 	    type != IOMMU_DOMAIN_DMA_FQ &&
-- 
2.25.1

