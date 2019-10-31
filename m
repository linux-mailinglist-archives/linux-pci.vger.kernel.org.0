Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4003EB7CD
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2019 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfJaTKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Oct 2019 15:10:43 -0400
Received: from mga11.intel.com ([192.55.52.93]:31964 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfJaTKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 31 Oct 2019 15:10:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 12:10:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,252,1569308400"; 
   d="scan'208";a="230975755"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.12])
  by fmsmga002.fm.intel.com with ESMTP; 31 Oct 2019 12:10:41 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Paul McKenney <paulmck@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2] PCI: vmd: Add indirection layer to vmd irq lists
Date:   Thu, 31 Oct 2019 07:08:53 -0600
Message-Id: <1572527333-6212-1-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With CONFIG_MAXSMP and CONFIG_PROVE_LOCKING, the size of an srcu_struct can
grow quite large. In one compilation instance it produced a 74KiB data
structure. These are embedded in the vmd_irq_list struct, and a N=64 allocation
can exceed MAX_ORDER, violating reclaim rules.

  struct srcu_struct {
          struct srcu_node   node[521];                    /*     0 75024 */
          /* --- cacheline 1172 boundary (75008 bytes) was 16 bytes ago --- */
          struct srcu_node *         level[4];             /* 75024    32 */
          struct mutex       srcu_cb_mutex;                /* 75056   128 */
          /* --- cacheline 1174 boundary (75136 bytes) was 48 bytes ago --- */
          spinlock_t                 lock;                 /* 75184    56 */
          /* --- cacheline 1175 boundary (75200 bytes) was 40 bytes ago --- */
          struct mutex       srcu_gp_mutex;                /* 75240   128 */
          /* --- cacheline 1177 boundary (75328 bytes) was 40 bytes ago --- */
          unsigned int               srcu_idx;             /* 75368     4 */

          /* XXX 4 bytes hole, try to pack */

          long unsigned int          srcu_gp_seq;          /* 75376     8 */
          long unsigned int          srcu_gp_seq_needed;   /* 75384     8 */
          /* --- cacheline 1178 boundary (75392 bytes) --- */
          long unsigned int          srcu_gp_seq_needed_exp; /* 75392     8 */
          long unsigned int          srcu_last_gp_end;     /* 75400     8 */
          struct srcu_data *         sda;                  /* 75408     8 */
          long unsigned int          srcu_barrier_seq;     /* 75416     8 */
          struct mutex       srcu_barrier_mutex;           /* 75424   128 */
          /* --- cacheline 1180 boundary (75520 bytes) was 32 bytes ago --- */
          struct completion  srcu_barrier_completion;      /* 75552    80 */
          /* --- cacheline 1181 boundary (75584 bytes) was 48 bytes ago --- */
          atomic_t                   srcu_barrier_cpu_cnt; /* 75632     4 */

          /* XXX 4 bytes hole, try to pack */

          struct delayed_work work;                        /* 75640   152 */

          /* XXX last struct has 4 bytes of padding */

          /* --- cacheline 1184 boundary (75776 bytes) was 16 bytes ago --- */
          struct lockdep_map dep_map;                      /* 75792    32 */

          /* size: 75824, cachelines: 1185, members: 17 */
          /* sum members: 75816, holes: 2, sum holes: 8 */
          /* paddings: 1, sum paddings: 4 */
          /* last cacheline: 48 bytes */
  };

With N=64 VMD IRQ lists, this would allocate 4.6MiB in a single call. This
violates MAX_ORDER reclaim rules when PAGE_SIZE=4096 and
MAX_ORDER_NR_PAGES=1024, and invokes the following warning in mm/page_alloc.c:

  /*
   * There are several places where we assume that the order value is sane
   * so bail out early if the request is out of bound.
   */
  if (unlikely(order >= MAX_ORDER)) {
  	WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));
  	return NULL;
  }

This patch changes the irq list array into an array of pointers to irq
lists to avoid allocation failures with greater msix counts.

This patch also reverts commit b31822277abcd7c83d1c1c0af876da9ccdf3b7d6.
The index_from_irqs() helper was added to calculate the irq list index
from the array of irqs, in order to shrink vmd_irq_list for performance.

Due to the embedded srcu_struct within the vmd_irq_list struct having a
varying size depending on a number of factors, the vmd_irq_list struct
no longer guarantees optimal data structure size and granularity.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
Added Paul to make him aware of srcu_struct size with these options

v1->v2:
Squashed the revert into this commit
changed n=1 kcalloc to kzalloc

 drivers/pci/controller/vmd.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3..8bce647 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -82,6 +82,7 @@ struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
+	unsigned int		index;
 };
 
 struct vmd_dev {
@@ -91,7 +92,7 @@ struct vmd_dev {
 	char __iomem		*cfgbar;
 
 	int msix_count;
-	struct vmd_irq_list	*irqs;
+	struct vmd_irq_list	**irqs;
 
 	struct pci_sysdata	sysdata;
 	struct resource		resources[3];
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
 
@@ -200,7 +194,7 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
 	unsigned long flags;
 
 	if (vmd->msix_count == 1)
-		return &vmd->irqs[0];
+		return vmd->irqs[0];
 
 	/*
 	 * White list for fast-interrupt handlers. All others will share the
@@ -210,17 +204,17 @@ static struct vmd_irq_list *vmd_next_irq(struct vmd_dev *vmd, struct msi_desc *d
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
@@ -771,14 +764,22 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		return -ENOMEM;
 
 	for (i = 0; i < vmd->msix_count; i++) {
-		err = init_srcu_struct(&vmd->irqs[i].srcu);
+		vmd->irqs[i] = devm_kzalloc(&dev->dev, sizeof(**vmd->irqs),
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
+		INIT_LIST_HEAD(&vmd->irqs[i]->irq_list);
+		vmd->irqs[i]->index = i;
 		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
 				       vmd_irq, IRQF_NO_THREAD,
-				       "vmd", &vmd->irqs[i]);
+				       "vmd", vmd->irqs[i]);
 		if (err)
 			return err;
 	}
@@ -799,7 +800,7 @@ static void vmd_cleanup_srcu(struct vmd_dev *vmd)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-		cleanup_srcu_struct(&vmd->irqs[i].srcu);
+		cleanup_srcu_struct(&vmd->irqs[i]->srcu);
 }
 
 static void vmd_remove(struct pci_dev *dev)
@@ -823,7 +824,7 @@ static int vmd_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
+                devm_free_irq(dev, pci_irq_vector(pdev, i), vmd->irqs[i]);
 
 	pci_save_state(pdev);
 	return 0;
@@ -838,7 +839,7 @@ static int vmd_resume(struct device *dev)
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

