Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C6E2A366B
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 23:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgKBWWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 17:22:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:15589 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgKBWWo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Nov 2020 17:22:44 -0500
IronPort-SDR: /O92pNPr+AYFexXBNYvpZesJfjzk6UMThncFJj+7z2xRgVdPwOdz5WZuo3gvd67tA29xGAocsj
 ijn+HrNwFTkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165457656"
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="165457656"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 14:22:43 -0800
IronPort-SDR: B7u3Wl+APnBTwMvWDBj3WP6LGbQXecyenlRuNb9bqs71gdsquAxZqu/wB6DEPDUjlot7LM7yGZ
 rY+MdvhPO82w==
X-IronPort-AV: E=Sophos;i="5.77,446,1596524400"; 
   d="scan'208";a="470540561"
Received: from kothasre-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.134.99.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 14:22:39 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v4] PCI: vmd: Offset Client VMD MSI-X vectors
Date:   Mon,  2 Nov 2020 15:22:23 -0700
Message-Id: <20201102222223.92978-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Client VMD platforms have a software-triggered MSI-X vector 0 that will
not forward hardware-remapped MSI from the sub-device domain. This
causes an issue with VMD platforms that use AHCI behind VMD and have a
single MSI-X vector remapped to VMD vector 0. Add a VMD MSI-X vector
offset for these platforms.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Tested-by: Jian-Hong Pan <jhp@endlessos.org>
---
v3->v4: Rebase for v5.10

drivers/pci/controller/vmd.c | 37 +++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f375c21ceeb1..c31e4d5cb146 100644
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
@@ -199,11 +206,11 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
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
 	 * White list for fast-interrupt handlers. All others will share the
@@ -213,11 +220,12 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
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
@@ -550,8 +558,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-						PCI_IRQ_MSIX);
+	vmd->msix_count = pci_alloc_irq_vectors(dev, vmd->first_vec + 1,
+						vmd->msix_count, PCI_IRQ_MSIX);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
@@ -719,6 +727,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	unsigned long features = (unsigned long) id->driver_data;
 	struct vmd_dev *vmd;
 	int err;
 
@@ -743,13 +752,16 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
 		return -ENODEV;
 
+	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
+		vmd->first_vec = 1;
+
 	err = vmd_alloc_irqs(vmd);
 	if (err)
 		return err;
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
@@ -818,13 +830,16 @@ static const struct pci_device_id vmd_ids[] = {
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
2.25.1

