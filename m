Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57218DF490
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 19:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfJURtS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 13:49:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:46782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfJURtS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 13:49:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:49:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="187618179"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.12])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 10:49:17 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] PCI: vmd: Add indirection layer to vmd irq lists
Date:   Mon, 21 Oct 2019 05:47:39 -0600
Message-Id: <1571658459-5668-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
References: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_MAXSMP and other debugging options enabled, the size of an
srcu_struct can grow quite large. These are embedded in the vmd_irq_list
struct, and a N=64 allocation can exceed MAX_ORDER, violating reclaim
rules.

This patch changes the irq list array into an array of pointers to irq
lists to avoid allocation failures with greater msix counts.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index c4de95a..096006e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -92,7 +92,7 @@ struct vmd_dev {
 	char __iomem		*cfgbar;
 
 	int msix_count;
-	struct vmd_irq_list	*irqs;
+	struct vmd_irq_list	**irqs;
 
 	struct pci_sysdata	sysdata;
 	struct resource		resources[3];
@@ -194,7 +194,7 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	unsigned long flags;
 
 	if (vmd->msix_count == 1)
-		return &vmd->irqs[0];
+		return vmd->irqs[0];
 
 	/*
 	 * White list for fast-interrupt handlers. All others will share the
@@ -204,17 +204,17 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	case PCI_CLASS_STORAGE_EXPRESS:
 		break;
 	default:
-		return &vmd->irqs[0];
+		return vmd->irqs[0];
 	}
 
 	raw_spin_lock_irqsave(&list_lock, flags);
 	for (i = 1; i < vmd->msix_count; i++)
-		if (vmd->irqs[i].count < vmd->irqs[best].count)
+		if (vmd->irqs[i]->count < vmd->irqs[best]->count)
 			best = i;
-	vmd->irqs[best].count++;
+	vmd->irqs[best]->count++;
 	raw_spin_unlock_irqrestore(&list_lock, flags);
 
-	return &vmd->irqs[best];
+	return vmd->irqs[best];
 }
 
 static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
@@ -764,15 +764,22 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	for (i = 0; i < vmd->msix_count; i++) {
-		err = init_srcu_struct(&vmd->irqs[i].srcu);
+		vmd->irqs[i] = devm_kcalloc(&dev->dev, 1, sizeof(**vmd->irqs),
+					    GFP_KERNEL);
+		if (!vmd->irqs[i])
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < vmd->msix_count; i++) {
+		err = init_srcu_struct(&vmd->irqs[i]->srcu);
 		if (err)
 			return err;
 
-		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		vmd->irqs[i].index = i;
+		INIT_LIST_HEAD(&vmd->irqs[i]->irq_list);
+		vmd->irqs[i]->index = i;
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
+				       "vmd", vmd->irqs[i]);
 		if (err)
 			return err;
 	}
@@ -793,7 +800,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-		cleanup_srcu_struct(&vmd->irqs[i].srcu);
+		cleanup_srcu_struct(&vmd->irqs[i]->srcu);
 }
 
 static void vmd_remove(struct pci_dev *dev)
@@ -817,7 +824,7 @@ static int vmd_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
+                devm_free_irq(dev, pci_irq_vector(pdev, i), vmd->irqs[i]);
 
 	pci_save_state(pdev);
 	return 0;
@@ -832,7 +839,7 @@ static int vmd_resume(struct device *dev)
 	for (i = 0; i < vmd->msix_count; i++) {
 		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
 				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
+				       "vmd", vmd->irqs[i]);
 		if (err)
 			return err;
 	}
-- 
1.8.3.1

