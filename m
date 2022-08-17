Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2325966A9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Aug 2022 03:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiHQB0L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 21:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbiHQB0K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 21:26:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743D175495;
        Tue, 16 Aug 2022 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660699569; x=1692235569;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Do6sVtxouBaogNOhnjSvTVEDqqNan3ooGCy6TMbkYzE=;
  b=iLACEwv1iZoquRfbPKvdhcyrPzfUqp79d4BKExhubKTzErFZ+mvofVss
   JM02RkMf5XGMk1xRCJi3tUufe9pfu2XiEcCA+z2ssqzlfZMo05rhD9krc
   RQs5NynDbygIhj4CQgqGeSg3NAKuTL8ZJnrRPfe19oVnVeFHXY/iQURC+
   ZfPv6bXwrJkS23fHE3e8XuaF2yNGqi73jPMxuyJm+pelDecXqZ0mxfVEL
   72LtazBNORmaNRC+FiI6Uk+k54IeVce6K+pl+81+CqQkekeg1ANvcA3Kl
   PWYlNUghNvkXQprUh+Lr2lyixKYbfE32c2OhsQNbTGmK+Q2QJANBSC5H0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="293649199"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="293649199"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 18:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="696587895"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2022 18:26:03 -0700
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
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v11 04/13] PCI: Allow PASID only when ACS enforced on upstreaming path
Date:   Wed, 17 Aug 2022 09:20:15 +0800
Message-Id: <20220817012024.3251276-5-baolu.lu@linux.intel.com>
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

Some configurations of the PCI fabric will route device originated TLP
packets based on the memory addresses. These configurations are
incompatible with PASID as the PASID packets form a distinct address
space. For instance, any configuration where switches are present
without ACS enabled is incompatible.

This enhances the pci_enable_pasid() interface by requiring the ACS to
support Source Validation, Request Redirection, Completer Redirection,
and Upstream Forwarding. This effectively means that devices cannot
spoof their requester ID, requests and completions cannot be redirected,
and all transactions are forwarded upstream, even as it passes through a
bridge where the target device is downstream.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/pci/ats.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index c967ad6e2626..0715e48e7973 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -382,6 +382,11 @@ int pci_enable_pasid(struct pci_dev *pdev, int features)
 	if (!pasid)
 		return -EINVAL;
 
+	if (!pci_acs_path_enabled(pdev, NULL,
+				  PCI_ACS_SV | PCI_ACS_RR |
+				  PCI_ACS_CR | PCI_ACS_UF))
+		return -EINVAL;
+
 	pci_read_config_word(pdev, pasid + PCI_PASID_CAP, &supported);
 	supported &= PCI_PASID_CAP_EXEC | PCI_PASID_CAP_PRIV;
 
-- 
2.25.1

