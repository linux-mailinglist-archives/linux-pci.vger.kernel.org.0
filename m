Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54585A2790
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbiHZMSM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbiHZMR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:17:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522BEDD4F8;
        Fri, 26 Aug 2022 05:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516275; x=1693052275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BlPDAsITnFdD30Pt137P5Fo8l26pHF5dP5Ti1dDDyHg=;
  b=ZHFtGUfLaeHdYpbojDYNHq1gu2bi5rvmuIkH0zlUl5IB9f75KRG1gPnX
   xT7xJcx3geSKiMdn8Zrn2ckaJg2nVYifbP4Z3LW6rgbgfKOQQFttuxLJq
   Zezs+cUnrMzJ6Zy4bJEzqpjcpSbuxi/A9jXyUxnQKoockJhiIojXA5Tx+
   T6dhXunn7i75ct7Am53bQSYheHMjlwuVEmjT4AaFPFBTBv3q2f5VMuKtc
   09fd8VrB6uy4rj7ClVSgDDmDujOzjEVXmj+tkfHeR826woch6wULSe7GU
   9icmhuOlo+LaJEcTiQ+0Y5OcKxLhQiRZfFe41Ta4bd6RbhlXMRIejKVQd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="292072128"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292072128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747653"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:49 -0700
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
Subject: [PATCH v12 07/17] iommu: Try to allocate blocking domain when probing device
Date:   Fri, 26 Aug 2022 20:11:31 +0800
Message-Id: <20220826121141.50743-8-baolu.lu@linux.intel.com>
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

Allocate the blocking domain when probing devices if the driver supports
blocking domain allocation. Otherwise, revert to the previous behavior,
that is, use UNMANAGED domain instead when the blocking domain is needed.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/iommu.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 2c9488d966ab..e985f4d5895f 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -318,6 +318,10 @@ int iommu_probe_device(struct device *dev)
 	mutex_lock(&group->mutex);
 	iommu_alloc_default_domain(group, dev);
 
+	/* Try to allocate a blocking domain */
+	group->blocking_domain = __iommu_domain_alloc(dev->bus,
+						      IOMMU_DOMAIN_BLOCKED);
+
 	/*
 	 * If device joined an existing group which has been claimed, don't
 	 * attach the default domain.
@@ -1778,6 +1782,10 @@ int bus_iommu_probe(struct bus_type *bus)
 		/* Try to allocate default domain */
 		probe_alloc_default_domain(bus, group);
 
+		/* Try to allocate blocking domain */
+		group->blocking_domain =
+				__iommu_domain_alloc(bus, IOMMU_DOMAIN_BLOCKED);
+
 		if (!group->default_domain) {
 			mutex_unlock(&group->mutex);
 			continue;
@@ -3165,18 +3173,15 @@ static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
 	if (group->blocking_domain)
 		return 0;
 
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
-	}
+	/*
+	 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
+	 * create an empty domain instead.
+	 */
+	group->blocking_domain = __iommu_domain_alloc(dev->dev->bus,
+						      IOMMU_DOMAIN_UNMANAGED);
+	if (!group->blocking_domain)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.25.1

