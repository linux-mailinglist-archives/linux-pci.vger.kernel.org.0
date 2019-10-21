Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B8EDF48F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 19:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfJURtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 13:49:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:46782 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727171AbfJURtR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Oct 2019 13:49:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:49:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="187618174"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.12])
  by orsmga007.jf.intel.com with ESMTP; 21 Oct 2019 10:49:17 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/2] Revert "x86/PCI: VMD: Eliminate index member from IRQ list"
Date:   Mon, 21 Oct 2019 05:47:38 -0600
Message-Id: <1571658459-5668-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
References: <1571658459-5668-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit b31822277abcd7c83d1c1c0af876da9ccdf3b7d6.

In b3182227, index_from_irqs() was added to calculate the irq list index
from the array of irqs, in order to shrink vmd_irq_list for performance.

Due to the embedded srcu_struct within the vmd_irq_list struct having a
varying size depending on a number of factors, the vmd_irq_list struct
no longer guarantees optimal granularity.

This patch removes this unneccesary complexity and is a prep patch for
adding another layer of indirection to the vmd irq lists.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3..c4de95a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -82,6 +82,7 @@ struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
+	unsigned int		index;
 };
 
 struct vmd_dev {
@@ -108,12 +109,6 @@ static inline struct vmd_dev *vmd_from_bus(struct pci_bus *bus)
 	return container_of(bus->sysdata, struct vmd_dev, sysdata);
 }
 
-static inline unsigned int index_from_irqs(struct vmd_dev *vmd,
-					   struct vmd_irq_list *irqs)
-{
-	return irqs - vmd->irqs;
-}
-
 /*
  * Drivers managing a device in a VMD domain allocate their own IRQs as before,
  * but the MSI entry for the hardware it's driving will be programmed with a
@@ -126,11 +121,10 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct vmd_irq *vmdirq = data->chip_data;
 	struct vmd_irq_list *irq = vmdirq->irq;
-	struct vmd_dev *vmd = irq_data_get_irq_handler_data(data);
 
 	msg->address_hi = MSI_ADDR_BASE_HI;
 	msg->address_lo = MSI_ADDR_BASE_LO |
-			  MSI_ADDR_DEST_ID(index_from_irqs(vmd, irq));
+			  MSI_ADDR_DEST_ID(irq->index);
 	msg->data = 0;
 }
 
@@ -230,7 +224,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	struct msi_desc *desc = arg->desc;
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
-	unsigned int index, vector;
+	unsigned int vector;
 
 	if (!vmdirq)
 		return -ENOMEM;
@@ -238,8 +232,7 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	INIT_LIST_HEAD(&vmdirq->node);
 	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
-	index = index_from_irqs(vmd, vmdirq->irq);
-	vector = pci_irq_vector(vmd->dev, index);
+	vector = pci_irq_vector(vmd->dev, vmdirq->irq->index);
 
 	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
@@ -776,6 +769,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
+		vmd->irqs[i].index = i;
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, IRQF_NO_THREAD,
 				       "vmd", &vmd->irqs[i]);
-- 
1.8.3.1

