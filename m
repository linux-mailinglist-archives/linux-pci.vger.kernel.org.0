Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B286326DC
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiKUOvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiKUOu3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:50:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4349AE52;
        Mon, 21 Nov 2022 06:42:38 -0800 (PST)
Message-ID: <20221121140050.197229661@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G8YuXi8Rg+vVdoNzuTDwjeofGOju3zeDQbEjL5nZHEE=;
        b=YOQKK2nnOQ1IXPk9vH/EagvBlX6G4xVHr8a6G+uky088c975d+5Hndkbp3K6I2MGh4Ee8b
        0uKnQjJ1smsvhKfyxTDlLRXTwZ3TnX+wkwM+ORJuD/yAwRdqu2krdi6HIf5rbsWT5RpicW
        ksb0oojIrgGmL1d8toGHW2jgevHFFPzGBnbCUolDZDrgxk13tixqJwZwORrJ1RECz0XRwk
        +CbRdACwFYv3ff5yXBONXQSqsBrEWl/nM/e2jzg5oBVczrRNKm6ffwZH1s5dkPuhny7vmm
        SGoffbJIgjO9ksJiBftVQFLyhMZKxLD8PF6yZRTERgxt5bNwzx7XMyTH4WRWKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=G8YuXi8Rg+vVdoNzuTDwjeofGOju3zeDQbEjL5nZHEE=;
        b=1lmfc7siUnz/pvs8AAkAZagUcCbTHY8LDY3w77W70/CxajfzItxvOszV2S0J4L8f6hyx28
        7gqM6d8r3MA7+zDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 30/40] genirq/gic-v3-mbi: Switch to MSI parent
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:06 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" PCI/MSI and platform domain related code and provide
the MSI parent functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-mbi.c |  122 ++++++++++-----------------------------
 1 file changed, 32 insertions(+), 90 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
+#include "irq-gic-msi-lib.h"
+
 struct mbi_range {
 	u32			spi_start;
 	u32			nr_spis;
@@ -29,6 +31,15 @@ static phys_addr_t		mbi_phys_base;
 static struct mbi_range		*mbi_ranges;
 static unsigned int		mbi_range_nr;
 
+static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	msg[0].address_hi = upper_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
+	msg[0].data = data->hwirq;
+
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
+}
+
 static struct irq_chip mbi_irq_chip = {
 	.name			= "MBI",
 	.irq_mask		= irq_chip_mask_parent,
@@ -36,11 +47,11 @@ static struct irq_chip mbi_irq_chip = {
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_type		= irq_chip_set_type_parent,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_compose_msi_msg	= mbi_compose_msi_msg,
 };
 
-static int mbi_irq_gic_domain_alloc(struct irq_domain *domain,
-				       unsigned int virq,
-				       irq_hw_number_t hwirq)
+static int mbi_irq_gic_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				    irq_hw_number_t hwirq)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -138,85 +149,30 @@ static void mbi_irq_domain_free(struct i
 }
 
 static const struct irq_domain_ops mbi_domain_ops = {
+	.select			= gic_msi_lib_irq_domain_select,
 	.alloc			= mbi_irq_domain_alloc,
 	.free			= mbi_irq_domain_free,
 };
 
-static void mbi_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	msg[0].address_hi = upper_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
-	msg[0].address_lo = lower_32_bits(mbi_phys_base + GICD_SETSPI_NSR);
-	msg[0].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
-}
-
-#ifdef CONFIG_PCI_MSI
-/* PCI-specific irqchip */
-static void mbi_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static void mbi_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
+#define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI)
 
-static struct irq_chip mbi_msi_irq_chip = {
-	.name			= "MSI",
-	.irq_mask		= mbi_mask_msi_irq,
-	.irq_unmask		= mbi_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_compose_msi_msg	= mbi_compose_msi_msg,
+static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
+	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "MBI-",
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
 };
 
-static struct msi_domain_info mbi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &mbi_msi_irq_chip,
-};
-
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
-{
-	*pci_domain = pci_msi_create_irq_domain(nexus_domain->parent->fwnode,
-						&mbi_msi_domain_info,
-						nexus_domain);
-	if (!*pci_domain)
-		return -ENOMEM;
-
-	return 0;
-}
-#else
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	*pci_domain = NULL;
-	return 0;
-}
-#endif
-
-/* Platform-MSI specific irqchip */
-static struct irq_chip mbi_pmsi_irq_chip = {
-	.name			= "pMSI",
-};
-
-static struct msi_domain_ops mbi_pmsi_ops = {
-};
-
-static struct msi_domain_info mbi_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &mbi_pmsi_ops,
-	.chip	= &mbi_pmsi_irq_chip,
-};
-
-static int mbi_allocate_domains(struct irq_domain *parent)
-{
-	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
-	int err;
+	struct irq_domain *nexus_domain;
 
 	nexus_domain = irq_domain_create_tree(parent->fwnode,
 					      &mbi_domain_ops, NULL);
@@ -225,22 +181,8 @@ static int mbi_allocate_domains(struct i
 
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
 	nexus_domain->parent = parent;
-
-	err = mbi_allocate_pci_domain(nexus_domain, &pci_domain);
-
-	plat_domain = platform_msi_create_irq_domain(parent->fwnode,
-						     &mbi_pmsi_domain_info,
-						     nexus_domain);
-
-	if (err || !plat_domain) {
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(nexus_domain);
-		return -ENOMEM;
-	}
-
+	nexus_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	nexus_domain->msi_parent_ops = &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
 
@@ -303,7 +245,7 @@ int __init mbi_init(struct fwnode_handle
 
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
 
-	ret = mbi_allocate_domains(parent);
+	ret = mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
 

