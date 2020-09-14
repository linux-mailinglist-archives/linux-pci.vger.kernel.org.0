Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2D6269592
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 21:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgINTVU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 15:21:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:18267 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgINTVR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Sep 2020 15:21:17 -0400
IronPort-SDR: DRqgCoHFJCFNEYU3zEg+dLFk139oWN3CWr7dd6aOb4RySNlm4PhpLCGnhyNm4YZipIaOxHJD4v
 izebsSotP20g==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="156542110"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="156542110"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 12:21:16 -0700
IronPort-SDR: paO6iQs1oHYbLadfdp2Hvk10746J7Ty3NOg0h+jEFQ0W/uiEsWRR+/35xEBrDJkJkYSIcc2qgH
 FXQc5qPDe56Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="507258189"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2020 12:21:16 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v3] PCI: vmd: Offset Client VMD MSI-X vectors
Date:   Mon, 14 Sep 2020 15:01:28 -0400
Message-Id: <20200914190128.5114-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Client VMD platforms have a software-triggered MSI-X vector 0 that will
not forward hardware-remapped MSI from the sub-device domain. This
causes an issue with VMD platforms that use AHCI behind VMD and have a
single MSI-X vector remapped to VMD vector 0. Add a VMD MSI-X vector
offset for these platforms.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
v3: Commit MSI-X cleanup
    vmd_next_irq check fix per Keith

 drivers/pci/controller/vmd.c | 37 +++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f69ef8c89f72..10c0d20190e0 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -53,6 +53,12 @@ enum vmd_features {
 	 * vendor-specific capability space
 	 */
 	VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP	= (1 << 2),
+
+	/*
+	 * Device may use MSI-X vector 0 for software triggering and will not
+	 * be used for MSI remapping
+	 */
+	VMD_FEAT_OFFSET_FIRST_VECTOR		= (1 << 3),
 };
 
 /*
@@ -104,6 +110,7 @@ struct vmd_dev {
 	struct irq_domain	*irq_domain;
 	struct pci_bus		*bus;
 	u8			busn_start;
+	u8			first_vec;
 };
 
 static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
@@ -199,25 +206,26 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
  */
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
 {
-	int i, best = 1;
 	unsigned long flags;
+	int i, best;
 
-	if (vmd->msix_count == 1)
-		return &vmd->irqs[0];
+	if (vmd->msix_count == 1 + vmd->first_vec)
+		return &vmd->irqs[vmd->first_vec];
 
 	/*
-	 * White list for fast-interrupt handlers. All others will share the
+	 * Allow list for fast-interrupt handlers. All others will share the
 	 * "slow" interrupt vector.
 	 */
 	switch (msi_desc_to_pci_dev(desc)->class) {
 	case PCI_CLASS_STORAGE_EXPRESS:
 		break;
 	default:
-		return &vmd->irqs[0];
+		return &vmd->irqs[vmd->first_vec];
 	}
 
 	raw_spin_lock_irqsave(&list_lock, flags);
-	for (i = 1; i < vmd->msix_count; i++)
+	best = vmd->first_vec + 1;
+	for (i = best; i < vmd->msix_count; i++)
 		if (vmd->irqs[i].count < vmd->irqs[best].count)
 			best = i;
 	vmd->irqs[best].count++;
@@ -629,6 +637,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	unsigned long features = (unsigned long) id->driver_data;
 	struct vmd_dev *vmd;
 	int i, err;
 
@@ -653,12 +662,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
 		return -ENODEV;
 
+	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
+		vmd->first_vec = 1;
+
 	vmd->msix_count = pci_msix_vec_count(dev);
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX);
+	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
+						vmd->msix_count, PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
@@ -755,13 +767,16 @@ static const struct pci_device_id vmd_ids[] = {
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW_VSCAP |
-				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+				VMD_FEAT_HAS_BUS_RESTRICTIONS |
+				VMD_FEAT_OFFSET_FIRST_VECTOR,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.18.1

