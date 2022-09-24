Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71025E86A7
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 02:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiIXAS4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 20:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiIXAS2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 20:18:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794ED12416A;
        Fri, 23 Sep 2022 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663978707; x=1695514707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EMDXCRdwqlGlnOwAqWbXNb8UnPKBXi5/6JNHQV9oHYo=;
  b=DaZ8HFTId6oIn2On+EsSbK+RGXnIeSYnK5QUSIL2OUY765BFbzQyEezm
   9AWdCts6pbQuCowh2Y0PQzPUkbnCXdEfGYXMqugLU/13Myjd3gy8DXedd
   Y6LNBL2RD1dFQHpRRs6CHG8aBZTcuIMn3HyOmBQ84y8nFrTpuHBBA1/Iv
   lf70rAAcBXo6h/6hLjCJopeeKUcSEsjWNDJpN5Dwb0ipjSqGWJoyW1O6w
   WXzOAFHDVoaD3WWNDmaq/F9PsNzolq+zxjtiEjfsxeh5dHhifhfwSZqw0
   hzS1q1kBZ3RM32j08F5sFjr8x/zzEbsiw/q4UZxV/q3GEA3ztnEeF/fSQ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10479"; a="280452617"
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="280452617"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 17:18:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,340,1654585200"; 
   d="scan'208";a="682856847"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 23 Sep 2022 17:18:22 -0700
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
Subject: [PATCH v14 04/13] PCI: Enable PASID only when ACS RR & UF enabled on upstream path
Date:   Sat, 24 Sep 2022 08:11:55 +0800
Message-Id: <20220924001204.4005613-5-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
References: <20220924001204.4005613-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Requester ID/Process Address Space ID (PASID) combination
identifies an address space distinct from the PCI bus address space,
e.g., an address space defined by an IOMMU.

But the PCIe fabric routes Memory Requests based on the TLP address,
ignoring any PASID (PCIe r6.0, sec 2.2.10.4), so a TLP with PASID that
SHOULD go upstream to the IOMMU may instead be routed as a P2P
Request if its address falls in a bridge window.

To ensure that all Memory Requests with PASID are routed upstream,
only enable PASID if ACS P2P Request Redirect and Upstream Forwarding
are enabled for the path leading to the device.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 drivers/pci/ats.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..f9cc2e10b676 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,6 +382,9 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
+	if (!pci_acs_path_enabled(pdev, NULL, PCI_ACS_RR | PCI_ACS_UF))
+		return -EINVAL;
+
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.34.1

