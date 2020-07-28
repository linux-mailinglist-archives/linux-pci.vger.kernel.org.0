Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C25F231385
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgG1UHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:63207 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgG1UHG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:06 -0400
IronPort-SDR: I2cMD3r8E2SaLG6/KX5qErQAx2JUNxM2fLRGBLZdyiwBwEla7s0ReZCOw2+mfYTCvkyemUZx39
 PSoMth2H6zOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287338"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287338"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:05 -0700
IronPort-SDR: tGra9B13nfi/LhtvV1fjMB9SKuqSjw11Y+DgSmNYygxEgFB/MzQtvwbVBmvYjINVUN8KiEi359
 OG/XVFQwsIwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756385"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:04 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 4/6] PCI: vmd: Create IRQ allocation helper
Date:   Tue, 28 Jul 2020 13:49:43 -0600
Message-Id: <20200728194945.14126-5-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves the IRQ allocation and SRCU initialization code to a new helper.
No functional changes.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 94 ++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 703c48171993..3214d785fa5d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -528,6 +528,55 @@ static int vmd_get_bus_number_start(struct vmd_dev *vmd)
 	return 0;
 }
 
+static irqreturn_t vmd_irq(int irq, void *data)
+{
+	struct vmd_irq_list *irqs = data;
+	struct vmd_irq *vmdirq;
+	int idx;
+
+	idx = srcu_read_lock(&irqs->srcu);
+	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
+		generic_handle_irq(vmdirq->virq);
+	srcu_read_unlock(&irqs->srcu, idx);
+
+	return IRQ_HANDLED;
+}
+
+static int vmd_alloc_irqs(struct vmd_dev *vmd)
+{
+	struct pci_dev *dev = vmd->dev;
+	int i, err;
+
+	vmd->msix_count = pci_msix_vec_count(dev);
+	if (vmd->msix_count < 0)
+		return -ENODEV;
+
+	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
+						PCI_IRQ_MSIX);
+	if (vmd->msix_count < 0)
+		return vmd->msix_count;
+
+	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
+				 GFP_KERNEL);
+	if (!vmd->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < vmd->msix_count; i++) {
+		err = init_srcu_struct(&vmd->irqs[i].srcu);
+		if (err)
+			return err;
+
+		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
+				       vmd_irq, IRQF_NO_THREAD,
+				       "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -663,24 +712,10 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	return 0;
 }
 
-static irqreturn_t vmd_irq(int irq, void *data)
-{
-	struct vmd_irq_list *irqs = data;
-	struct vmd_irq *vmdirq;
-	int idx;
-
-	idx = srcu_read_lock(&irqs->srcu);
-	list_for_each_entry_rcu(vmdirq, &irqs->irq_list, node)
-		generic_handle_irq(vmdirq->virq);
-	srcu_read_unlock(&irqs->srcu, idx);
-
-	return IRQ_HANDLED;
-}
-
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
-	int i, err;
+	int err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
 		return -ENOMEM;
@@ -703,32 +738,9 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
 		return -ENODEV;
 
-	vmd->msix_count = pci_msix_vec_count(dev);
-	if (vmd->msix_count < 0)
-		return -ENODEV;
-
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX);
-	if (vmd->msix_count < 0)
-		return vmd->msix_count;
-
-	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
-				 GFP_KERNEL);
-	if (!vmd->irqs)
-		return -ENOMEM;
-
-	for (i = 0; i < vmd->msix_count; i++) {
-		err = init_srcu_struct(&vmd->irqs[i].srcu);
-		if (err)
-			return err;
-
-		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
-				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
-		if (err)
-			return err;
-	}
+	err = vmd_alloc_irqs(vmd);
+	if (err)
+		return err;
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-- 
2.27.0

