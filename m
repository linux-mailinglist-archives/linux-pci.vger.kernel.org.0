Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70AE6F1CA9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbfKFRmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 12:42:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:23987 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfKFRmH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 12:42:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="192539723"
Received: from mton-linux-test2.lm.intel.com (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2019 09:42:05 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/3] PCI: vmd: Align IRQ lists with child device vectors
Date:   Wed,  6 Nov 2019 04:40:07 -0700
Message-Id: <1573040408-3831-3-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to provide better affinity alignment along the entire storage
stack, VMD IRQ lists can be assigned to in a manner where the underlying
IRQ can be affinitized the same as the child (NVMe) device.

This patch changes the assignment of child device vectors in IRQ lists
from a round-robin strategy to a matching-entry strategy. NVMe
affinities are deterministic in a VMD domain when these devices have the
same vector count as limited by the VMD MSI domain or cpu count. When
one or more child devices are attached on a VMD domain, this patch
aligns the NVMe submission-side affinity with the VMD completion-side
affinity as it completes through the VMD IRQ list.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 57 ++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index ebe7ff6..7aca925 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -75,13 +75,10 @@ struct vmd_irq {
  * struct vmd_irq_list - list of driver requested IRQs mapping to a VMD vector
  * @irq_list:	the list of irq's the VMD one demuxes to.
  * @srcu:	SRCU struct for local synchronization.
- * @count:	number of child IRQs assigned to this vector; used to track
- *		sharing.
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
-	unsigned int		count;
 	unsigned int		index;
 };
 
@@ -184,37 +181,32 @@ static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
 	return 0;
 }
 
-/*
- * XXX: We can be even smarter selecting the best IRQ once we solve the
- * affinity problem.
- */
 static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *desc)
 {
-	int i, best = 1;
-	unsigned long flags;
-
-	if (vmd->msix_count == 1)
-		return vmd->irqs[0];
-
-	/*
-	 * White list for fast-interrupt handlers. All others will share the
-	 * "slow" interrupt vector.
-	 */
-	switch (msi_desc_to_pci_dev(desc)->class) {
-	case PCI_CLASS_STORAGE_EXPRESS:
-		break;
-	default:
-		return vmd->irqs[0];
+	int entry_nr = desc->msi_attrib.entry_nr;
+
+	if (vmd->msix_count == 1) {
+		entry_nr = 0;
+	} else {
+
+		/*
+		 * White list for fast-interrupt handlers. All others will
+		 * share the "slow" interrupt vector.
+		 */
+		switch (msi_desc_to_pci_dev(desc)->class) {
+		case PCI_CLASS_STORAGE_EXPRESS:
+			break;
+		default:
+			entry_nr = 0;
+		}
 	}
 
-	raw_spin_lock_irqsave(&list_lock, flags);
-	for (i = 1; i < vmd->msix_count; i++)
-		if (vmd->irqs[i]->count < vmd->irqs[best]->count)
-			best = i;
-	vmd->irqs[best]->count++;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
+	if (entry_nr > vmd->msix_count)
+		entry_nr = 0;
 
-	return vmd->irqs[best];
+	dev_dbg(desc->dev, "Entry %d using VMD IRQ list %d/%d\n",
+		desc->msi_attrib.entry_nr, entry_nr, vmd->msix_count - 1);
+	return vmd->irqs[entry_nr];
 }
 
 static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
@@ -243,15 +235,8 @@ static void vmd_msi_free(struct irq_domain *domain,
 			struct msi_domain_info *info, unsigned int virq)
 {
 	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
-	unsigned long flags;
 
 	synchronize_srcu(&vmdirq->irq->srcu);
-
-	/* XXX: Potential optimization to rebalance */
-	raw_spin_lock_irqsave(&list_lock, flags);
-	vmdirq->irq->count--;
-	raw_spin_unlock_irqrestore(&list_lock, flags);
-
 	kfree(vmdirq);
 }
 
-- 
1.8.3.1

