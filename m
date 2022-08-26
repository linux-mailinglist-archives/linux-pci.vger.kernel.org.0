Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF515A2791
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344027AbiHZMSX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiHZMSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 08:18:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AC9DDB50;
        Fri, 26 Aug 2022 05:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661516279; x=1693052279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p46IW5hB0frkoIsI5N8rinjwV0JyL0jp2/821fQMZm0=;
  b=a5EG4pNNsWbLCiuLNl6xBrHyZ/0TS8xZWOMjsWsi2XFoYe7HZoMgZq99
   hsyiHGNn2y5GEGtf+tcuwsZBjc9ypcP1/ANJjZ4l0Q0otzfiqiQDd4Qyw
   WG86IYtFWiY1sqLPK09jx+NEEA2bbAhZEDArMI/zzS8RSu2KHgMereYZX
   YzO54FJ/hT6OpWZ/icpdOaj62ldlrjRe3ktQwYOXZ1/PttcIJIbAqyD+L
   jDgb4HgWDa9yEQgtHUilz5cmG6lcQQaqFhoLK11jV0Uwd5377x26JchT0
   ot2b7cHaoAm80GiyaAZHyliuTKC6+6Sbb69BooJBXsYMkMzBzALHJDc2X
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="292072151"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="292072151"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:17:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606747682"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:17:54 -0700
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
Subject: [PATCH v12 08/17] iommu: Make free of iommu_domain_ops optional
Date:   Fri, 26 Aug 2022 20:11:32 +0800
Message-Id: <20220826121141.50743-9-baolu.lu@linux.intel.com>
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

So that the drivers are able to implement static singleton instance for
some special domains. The blocking domain is an example. The driver has
no need to allocate different memory for each blocking domain allocation
request. Hence, no need for a free callback.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/iommu/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index e985f4d5895f..630e1b64ed89 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1972,7 +1972,8 @@ void iommu_domain_free(struct iommu_domain *domain)
 	if (domain->type == IOMMU_DOMAIN_SVA)
 		mmdrop(domain->mm);
 	iommu_put_dma_cookie(domain);
-	domain->ops->free(domain);
+	if (domain->ops->free)
+		domain->ops->free(domain);
 }
 EXPORT_SYMBOL_GPL(iommu_domain_free);
 
-- 
2.25.1

