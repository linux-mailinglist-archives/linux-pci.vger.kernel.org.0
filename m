Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5414141D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 23:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAQWaf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 17:30:35 -0500
Received: from mga03.intel.com ([134.134.136.65]:34039 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgAQWaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:31 -0800
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="219052215"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:30:30 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <iommu@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v4 4/7] iommu/vt-d: Use pci_real_dma_dev() for mapping
Date:   Fri, 17 Jan 2020 09:27:26 -0700
Message-Id: <1579278449-174098-5-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
References: <1579278449-174098-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI device may have a DMA requester on another bus, such as VMD
subdevices needing to use the VMD endpoint. This case requires the real
DMA device when mapping to IOMMU.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/iommu/intel-iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0c8d81f..01a1b0f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -782,6 +782,8 @@ static struct intel_iommu *device_to_iommu(struct device *dev, u8 *bus, u8 *devf
 			return NULL;
 #endif
 
+		pdev = pci_real_dma_dev(dev);
+
 		/* VFs aren't listed in scope tables; we need to look up
 		 * the PF instead to find the IOMMU. */
 		pf_pdev = pci_physfn(pdev);
@@ -2428,6 +2430,13 @@ static struct dmar_domain *find_domain(struct device *dev)
 		     dev->archdata.iommu == DUMMY_DEVICE_DOMAIN_INFO))
 		return NULL;
 
+	if (dev_is_pci(dev)) {
+		struct pci_dev *pdev;
+
+		pdev = pci_real_dma_dev(to_pci_dev(dev));
+		dev = &pdev->dev;
+	}
+
 	/* No lock here, assumes no domain exit in normal case */
 	info = dev->archdata.iommu;
 	if (likely(info))
-- 
1.8.3.1

