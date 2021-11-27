Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CE745FAF6
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351900AbhK0Bf3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:35:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbhK0Bc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:32:26 -0500
Message-ID: <20211126232735.907470678@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QnjnYkBXEFvI+Fsy8bp88tNAU5py3G4+a5jOgsnpoFM=;
        b=ftC3ekZT2dKI/ktHe1Z9pNoIdW1KMZ41Aa83gerEcfv/qvgK7QWZCSWqvFk27AbJsijkwC
        hPWXRSt+rk3bDjo7zprVzRT13EYxUV17c2H4M78nPMMHnY2DhaG8v/3w8ayGmhm8RAceq3
        M9VODUkZ9+p9R95jEoJH0nhBfyGe3s2MRIKh57o/nPbX3Bc2H/1tWKognpEB8pNITnX0mn
        Q+HMpHhVnLK3Dy+MLht6YOLXOYMiGmtE5PGCH5/BAGIx6BP76KMP+aEc7yXfe4GTwe6nBR
        n08faXX32pQkjBrbfxQ0pINRqq21pmiWv5gL60D8xZcaYH/6Mduf31TVV22maQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QnjnYkBXEFvI+Fsy8bp88tNAU5py3G4+a5jOgsnpoFM=;
        b=8Mzp4+/JuYnEWzDLb3G3zZbjO0HfKVi2sRxV7/7MbJ2OfdVEilvkyu1ole5Wt+PAy8aang
        D0WzAqpHo6pXhwDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 27/32] genirq/msi: Make interrupt allocation less convoluted
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:23:09 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is no real reason to do several loops over the MSI descriptors
instead of just doing one loop. In case of an error everything is undone
anyway so it does not matter whether it's a partial or a full rollback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 .clang-format       |    1 
 include/linux/msi.h |    7 --
 kernel/irq/msi.c    |  129 +++++++++++++++++++++++++++-------------------------
 3 files changed, 70 insertions(+), 67 deletions(-)

--- a/.clang-format
+++ b/.clang-format
@@ -216,7 +216,6 @@ ExperimentalAutoDetectBinPacking: false
   - 'for_each_migratetype_order'
   - 'for_each_msi_entry'
   - 'for_each_msi_entry_safe'
-  - 'for_each_msi_vector'
   - 'for_each_net'
   - 'for_each_net_continue_reverse'
   - 'for_each_netdev'
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -263,12 +263,7 @@ static inline struct msi_desc *msi_first
 	list_for_each_entry((desc), dev_to_msi_list((dev)), list)
 #define for_each_msi_entry_safe(desc, tmp, dev)	\
 	list_for_each_entry_safe((desc), (tmp), dev_to_msi_list((dev)), list)
-#define for_each_msi_vector(desc, __irq, dev)				\
-	for_each_msi_entry((desc), (dev))				\
-		if ((desc)->irq)					\
-			for (__irq = (desc)->irq;			\
-			     __irq < ((desc)->irq + (desc)->nvec_used);	\
-			     __irq++)
+
 #ifdef CONFIG_IRQ_MSI_IOMMU
 static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
 {
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -873,23 +873,74 @@ static int msi_handle_pci_fail(struct ir
 	return allocated ? allocated : -ENOSPC;
 }
 
+#define VIRQ_CAN_RESERVE	0x01
+#define VIRQ_ACTIVATE		0x02
+#define VIRQ_NOMASK_QUIRK	0x04
+
+static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflags)
+{
+	struct irq_data *irqd = irq_domain_get_irq_data(domain, virq);
+	int ret;
+
+	if (!vflags & VIRQ_CAN_RESERVE) {
+		irqd_clr_can_reserve(irqd);
+		if (vflags & VIRQ_NOMASK_QUIRK)
+			irqd_set_msi_nomask_quirk(irqd);
+	}
+
+	if (!(vflags & VIRQ_ACTIVATE))
+		return 0;
+
+	ret = irq_domain_activate_irq(irqd, vflags & VIRQ_CAN_RESERVE);
+	if (ret)
+		return ret;
+	/*
+	 * If the interrupt uses reservation mode, clear the activated bit
+	 * so request_irq() will assign the final vector.
+	 */
+	if (vflags & VIRQ_CAN_RESERVE)
+		irqd_clr_activated(irqd);
+	return 0;
+}
+
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
-	struct irq_data *irq_data;
-	struct msi_desc *desc;
 	msi_alloc_info_t arg = { };
+	unsigned int vflags = 0;
+	struct msi_desc *desc;
 	int allocated = 0;
 	int i, ret, virq;
-	bool can_reserve;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
 		return ret;
 
-	for_each_msi_entry(desc, dev) {
+	/*
+	 * This flag is set by the PCI layer as we need to activate
+	 * the MSI entries before the PCI layer enables MSI in the
+	 * card. Otherwise the card latches a random msi message.
+	 */
+	if (info->flags & MSI_FLAG_ACTIVATE_EARLY)
+		vflags |= VIRQ_ACTIVATE;
+
+	/*
+	 * Interrupt can use a reserved vector and will not occupy
+	 * a real device vector until the interrupt is requested.
+	 */
+	if (msi_check_reservation_mode(domain, info, dev)) {
+		vflags |= VIRQ_CAN_RESERVE;
+		/*
+		 * MSI affinity setting requires a special quirk (X86) when
+		 * reservation mode is active.
+		 */
+		if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
+			vflags |= VIRQ_NOMASK_QUIRK;
+	}
+
+	msi_for_each_desc(desc, dev, MSI_DESC_NOTASSOCIATED) {
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
@@ -901,49 +952,12 @@ int __msi_domain_alloc_irqs(struct irq_d
 		for (i = 0; i < desc->nvec_used; i++) {
 			irq_set_msi_desc_off(virq, i, desc);
 			irq_debugfs_copy_devname(virq + i, dev);
+			ret = msi_init_virq(domain, virq + i, vflags);
+			if (ret)
+				return ret;
 		}
 		allocated++;
 	}
-
-	can_reserve = msi_check_reservation_mode(domain, info, dev);
-
-	/*
-	 * This flag is set by the PCI layer as we need to activate
-	 * the MSI entries before the PCI layer enables MSI in the
-	 * card. Otherwise the card latches a random msi message.
-	 */
-	if (!(info->flags & MSI_FLAG_ACTIVATE_EARLY))
-		goto skip_activate;
-
-	for_each_msi_vector(desc, i, dev) {
-		if (desc->irq == i) {
-			virq = desc->irq;
-			dev_dbg(dev, "irq [%d-%d] for MSI\n",
-				virq, virq + desc->nvec_used - 1);
-		}
-
-		irq_data = irq_domain_get_irq_data(domain, i);
-		if (!can_reserve) {
-			irqd_clr_can_reserve(irq_data);
-			if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
-				irqd_set_msi_nomask_quirk(irq_data);
-		}
-		ret = irq_domain_activate_irq(irq_data, can_reserve);
-		if (ret)
-			return ret;
-	}
-
-skip_activate:
-	/*
-	 * If these interrupts use reservation mode, clear the activated bit
-	 * so request_irq() will assign the final vector.
-	 */
-	if (can_reserve) {
-		for_each_msi_vector(desc, i, dev) {
-			irq_data = irq_domain_get_irq_data(domain, i);
-			irqd_clr_activated(irq_data);
-		}
-	}
 	return 0;
 }
 
@@ -1021,26 +1035,21 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
-	struct irq_data *irq_data;
+	struct irq_data *irqd;
 	struct msi_desc *desc;
 	int i;
 
-	for_each_msi_vector(desc, i, dev) {
-		irq_data = irq_domain_get_irq_data(domain, i);
-		if (irqd_is_activated(irq_data))
-			irq_domain_deactivate_irq(irq_data);
-	}
-
-	for_each_msi_entry(desc, dev) {
-		/*
-		 * We might have failed to allocate an MSI early
-		 * enough that there is no IRQ associated to this
-		 * entry. If that's the case, don't do anything.
-		 */
-		if (desc->irq) {
-			irq_domain_free_irqs(desc->irq, desc->nvec_used);
-			desc->irq = 0;
+	/* Only handle MSI entries which have an interrupt associated */
+	msi_for_each_desc(desc, dev, MSI_DESC_ASSOCIATED) {
+		/* Make sure all interrupts are deactivated */
+		for (i = 0; i < desc->nvec_used; i++) {
+			irqd = irq_domain_get_irq_data(domain, desc->irq + i);
+			if (irqd && irqd_is_activated(irqd))
+				irq_domain_deactivate_irq(irqd);
 		}
+
+		irq_domain_free_irqs(desc->irq, desc->nvec_used);
+		desc->irq = 0;
 	}
 }
 

