Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358E46326E6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiKUOvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiKUOvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:51:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16D5C847B;
        Mon, 21 Nov 2022 06:42:55 -0800 (PST)
Message-ID: <20221121140050.259338252@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LVm6nNGwtgSWM//zSE7+IPj0DIZ/wlOjErT0DctjfGc=;
        b=XMY0/aklG+0k/tRYaPhi5x90nI4mKx0Ql4nnjWc3HnN51vG9bxj8tKRyrjPGICq0Kx+JXj
        ejhE8rAsnVIcPxDJM4Lfp0m6UkRjAqh1QmZMH8JGzeUNb5i4NXbAEt+XZOVMQWZ6KecqV7
        bOg9RSyqozz2tJQps+SNw5KRe7GlGCmdA2U5o5YjUxfYDi/Lznho1QRke6RxbnJpa18jP0
        WvhDA/oTGuSbhd568PqYOwelQifrT7UgkT5p1qlZBJ8Y/oF9nV7/7NAJIVknw7Em2Ek9SH
        1yzAiO3Y5VjV2NCghkU4A5j85MNWCEpJkx94r4omrJOHlz6eRfhCmwRTB8MQUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=LVm6nNGwtgSWM//zSE7+IPj0DIZ/wlOjErT0DctjfGc=;
        b=4tDuoDhUQ8Gc4et3llk3JdGY/T8p2yInJQLbvxnH91jqoTvRhbM+Uyj9miSI0uImQC2Guu
        XuL2dT19oPmENYCQ==
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
Subject: [patch V2 31/40] irqchip/gic-v2m: Switch to device MSI
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:40:07 +0100 (CET)
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
 drivers/irqchip/Kconfig       |    1 
 drivers/irqchip/irq-gic-v2m.c |   82 ++++++++++++------------------------------
 2 files changed, 25 insertions(+), 58 deletions(-)

--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -25,6 +25,7 @@ config ARM_GIC_V2M
 	bool
 	depends on PCI
 	select ARM_GIC
+	select ARM_GIC_MSI_LIB
 	select PCI_MSI
 
 config GIC_NON_BANKED
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
 
+#include "irq-gic-msi-lib.h"
+
 /*
 * MSI_TYPER:
 *     [31:26] Reserved
@@ -72,31 +74,6 @@ struct v2m_data {
 	u32 flags;		/* v2m flags for specific implementation */
 };
 
-static void gicv2m_mask_msi_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void gicv2m_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip gicv2m_msi_irq_chip = {
-	.name			= "MSI",
-	.irq_mask		= gicv2m_mask_msi_irq,
-	.irq_unmask		= gicv2m_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-};
-
-static struct msi_domain_info gicv2m_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &gicv2m_msi_irq_chip,
-};
-
 static phys_addr_t gicv2m_get_msi_addr(struct v2m_data *v2m, int hwirq)
 {
 	if (v2m->flags & GICV2M_GRAVITON_ADDRESS_ONLY)
@@ -230,6 +207,7 @@ static void gicv2m_irq_domain_free(struc
 }
 
 static const struct irq_domain_ops gicv2m_domain_ops = {
+	.select			= gic_msi_lib_irq_domain_select,
 	.alloc			= gicv2m_irq_domain_alloc,
 	.free			= gicv2m_irq_domain_free,
 };
@@ -250,19 +228,6 @@ static bool is_msi_spi_valid(u32 base, u
 	return true;
 }
 
-static struct irq_chip gicv2m_pmsi_irq_chip = {
-	.name			= "pMSI",
-};
-
-static struct msi_domain_ops gicv2m_pmsi_ops = {
-};
-
-static struct msi_domain_info gicv2m_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
-	.ops	= &gicv2m_pmsi_ops,
-	.chip	= &gicv2m_pmsi_irq_chip,
-};
-
 static void __init gicv2m_teardown(void)
 {
 	struct v2m_data *v2m, *tmp;
@@ -278,17 +243,32 @@ static void __init gicv2m_teardown(void)
 	}
 }
 
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				    MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX      |	\
+				    MSI_FLAG_MULTI_PCI_MSI)
+
+static struct msi_parent_ops gicv2m_msi_parent_ops = {
+	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
+	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "GICv2m-",
+	.init_dev_msi_info	= gic_msi_lib_init_dev_msi_info,
+};
+
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	struct v2m_data *v2m;
 
 	v2m = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_tree(v2m->fwnode,
-					      &gicv2m_domain_ops, v2m);
+	inner_domain = irq_domain_create_tree(v2m->fwnode, &gicv2m_domain_ops, v2m);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
@@ -296,22 +276,8 @@ static __init int gicv2m_allocate_domain
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 	inner_domain->parent = parent;
-	pci_domain = pci_msi_create_irq_domain(v2m->fwnode,
-					       &gicv2m_msi_domain_info,
-					       inner_domain);
-	plat_domain = platform_msi_create_irq_domain(v2m->fwnode,
-						     &gicv2m_pmsi_domain_info,
-						     inner_domain);
-	if (!pci_domain || !plat_domain) {
-		pr_err("Failed to create MSI domains\n");
-		if (plat_domain)
-			irq_domain_remove(plat_domain);
-		if (pci_domain)
-			irq_domain_remove(pci_domain);
-		irq_domain_remove(inner_domain);
-		return -ENOMEM;
-	}
-
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->msi_parent_ops = &gicv2m_msi_parent_ops;
 	return 0;
 }
 
@@ -512,7 +478,7 @@ acpi_parse_madt_msi(union acpi_subtable_
 		pr_info("applying Amazon Graviton quirk\n");
 		res.end = res.start + SZ_8K - 1;
 		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
-		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
+		gicv2m_msi_parent_ops.supported_flags &= ~MSI_FLAG_MULTI_PCI_MSI;
 	}
 
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {

