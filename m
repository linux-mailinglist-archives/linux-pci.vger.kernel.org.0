Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B469145F9E8
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbhK0B2z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:28:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346514AbhK0B0y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:26:54 -0500
Message-ID: <20211126230526.055361768@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WWQWE9G0qlaU80ha+cNMAdUuPV31PLPDySvVFyYiVGo=;
        b=xUwSsNqAnUhHh5aYgCIQlCl8zSLf1RILNIO8kcuCPB4FGCVH4DU5+9C+Io5q6BY59jYPhK
        em5vg+Hld/GrFdb7sMTGdiNEFqacTa+TQ7RXnPU63d0pOYQqkpz+RDTwjfsLo10cZqg9UL
        qYAiCAcydY+f3nWLkUOxwg1DJkRnapC8pF6JAL3/85Trx3LyzmgXJff7BxGARqEfwzGVYm
        uBa1iAGskoWow+4plos7k+QLDLun5IHFbAHPl70dNActZYPWTFr6efMCwf3JD8Ww/exMlc
        mKvF9zM0tia1MLH5+6fBva5bKgeMaBZ+Bv5+xwvyfK9RtoEeK3Bm/FLg/vln+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=WWQWE9G0qlaU80ha+cNMAdUuPV31PLPDySvVFyYiVGo=;
        b=1ZZIOOBFZZrFjkiwh98RxAGL7tpchaBa0H0RxcUy3ED96fy23NgIE9SfOys1JamsiaQ5TL
        1UkKMxv5UIAjvyBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 36/37] soc: ti: ti_sci_inta_msi: Get rid of ti_sci_inta_msi_get_virq()
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:21:04 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just use the core function msi_get_virq().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/dma/ti/k3-udma-private.c       |    6 ++----
 drivers/dma/ti/k3-udma.c               |   10 ++++------
 drivers/soc/ti/k3-ringacc.c            |    2 +-
 drivers/soc/ti/ti_sci_inta_msi.c       |   12 ------------
 include/linux/soc/ti/ti_sci_inta_msi.h |    1 -
 5 files changed, 7 insertions(+), 24 deletions(-)

--- a/drivers/dma/ti/k3-udma-private.c
+++ b/drivers/dma/ti/k3-udma-private.c
@@ -168,8 +168,7 @@ int xudma_pktdma_tflow_get_irq(struct ud
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_tflow_id +
-					oes->pktdma_tchan_flow);
+	return msi_get_virq(ud->dev, udma_tflow_id + oes->pktdma_tchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_tflow_get_irq);
 
@@ -177,7 +176,6 @@ int xudma_pktdma_rflow_get_irq(struct ud
 {
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
 
-	return ti_sci_inta_msi_get_virq(ud->dev, udma_rflow_id +
-					oes->pktdma_rchan_flow);
+	return msi_get_virq(ud->dev, udma_rflow_id + oes->pktdma_rchan_flow);
 }
 EXPORT_SYMBOL(xudma_pktdma_rflow_get_irq);
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2313,8 +2313,7 @@ static int udma_alloc_chan_resources(str
 
 	/* Event from UDMA (TR events) only needed for slave TR mode channels */
 	if (is_slave_direction(uc->config.dir) && !uc->config.pkt_mode) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get udma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2486,7 +2485,7 @@ static int bcdma_alloc_chan_resources(st
 		uc->psil_paired = true;
 	}
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
@@ -2503,8 +2502,7 @@ static int bcdma_alloc_chan_resources(st
 
 	/* Event from BCDMA (TR events) only needed for slave channels */
 	if (is_slave_direction(uc->config.dir)) {
-		uc->irq_num_udma = ti_sci_inta_msi_get_virq(ud->dev,
-							    irq_udma_idx);
+		uc->irq_num_udma = msi_get_virq(ud->dev, irq_udma_idx);
 		if (uc->irq_num_udma <= 0) {
 			dev_err(ud->dev, "Failed to get bcdma irq (index: %u)\n",
 				irq_udma_idx);
@@ -2672,7 +2670,7 @@ static int pktdma_alloc_chan_resources(s
 
 	uc->psil_paired = true;
 
-	uc->irq_num_ring = ti_sci_inta_msi_get_virq(ud->dev, irq_ring_idx);
+	uc->irq_num_ring = msi_get_virq(ud->dev, irq_ring_idx);
 	if (uc->irq_num_ring <= 0) {
 		dev_err(ud->dev, "Failed to get ring irq (index: %u)\n",
 			irq_ring_idx);
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -647,7 +647,7 @@ int k3_ringacc_get_ring_irq_num(struct k
 	if (!ring)
 		return -EINVAL;
 
-	irq_num = ti_sci_inta_msi_get_virq(ring->parent->dev, ring->ring_id);
+	irq_num = msi_get_virq(ring->parent->dev, ring->ring_id);
 	if (irq_num <= 0)
 		irq_num = -EINVAL;
 	return irq_num;
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -148,15 +148,3 @@ void ti_sci_inta_msi_domain_free_irqs(st
 	ti_sci_inta_msi_free_descs(dev);
 }
 EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_free_irqs);
-
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 dev_index)
-{
-	struct msi_desc *desc;
-
-	for_each_msi_entry(desc, dev)
-		if (desc->msi_index == dev_index)
-			return desc->irq;
-
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(ti_sci_inta_msi_get_virq);
--- a/include/linux/soc/ti/ti_sci_inta_msi.h
+++ b/include/linux/soc/ti/ti_sci_inta_msi.h
@@ -18,6 +18,5 @@ struct irq_domain
 				   struct irq_domain *parent);
 int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
 				      struct ti_sci_resource *res);
-unsigned int ti_sci_inta_msi_get_virq(struct device *dev, u32 index);
 void ti_sci_inta_msi_domain_free_irqs(struct device *dev);
 #endif /* __INCLUDE_LINUX_IRQCHIP_TI_SCI_INTA_H */

