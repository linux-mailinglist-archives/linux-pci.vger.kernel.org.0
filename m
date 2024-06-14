Return-Path: <linux-pci+bounces-8814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 289E89089E2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6800728FCC8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB791194AD8;
	Fri, 14 Jun 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LMHK+efT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iti74EDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C71946CC;
	Fri, 14 Jun 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360748; cv=none; b=ilJb7oY9WVnS19k1ElkTdzVnkAJrQv5JTHcYD1qJ3PJ4hSjOmQ9croaruV7LBW3qjEHudhkIGi8FKVZLHXY0F84ttxd3QDZpk6bNW3otivF4I+cL/hmfGqrBVX75QDuVt5hLLkb33auQFu0yDeQXvuDMRym59KvVz9dDvy2i5dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360748; c=relaxed/simple;
	bh=1cTfACq0ElpLGuB54rvU1+TM97B4xQ9mq7NqWyYTbTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RAVvN19kZ94SVb4t2BJSK3uUuNsJHfmEJhdh02G2aDp+dCSkCWRc6NuBIgqz8wfLOsh9hdGly9aYY6fntAmjloJGxf3YahLm4wuUTh0woPp03p2FV9v8gx3F6cxXxMuQK5++HKhTD6UflF7KKwPhuqRFUjhrexejY+goGpnQzF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LMHK+efT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iti74EDo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruApRDwyE/XyhuHw4ObCqk6nkpUiEnJy2HPfoSkyyE=;
	b=LMHK+efTBHcUjK792bQcYg4ppjUYxz6dXXLKKgMwPa5/cdjD8nuLdLhZV0JXy3N1uUQ5B8
	UUtZE0IgA55tSI7+kmqmjyHuyxRX5Vs+Hr0sDrbWvW2DRAI1Kqt97PkKEJuniuDspjUTHi
	KeHCe0mItqp8+UeYwLTX+4XnckNcavZ3gulEv+0eXOT05ZScsttxySI+eXnY0MeH3Lggqc
	ySaEIOOcglwb94K4FEpsgy6BYx5CbdCRq+BEAojPCYyhdifAIdGDRYcgHC/5ZJE0c+2Aza
	SomPnOzxhILmnOYecNG2FVlpMMVWEMlu/4VGBx0q0x0ZHljH88pocyHm7RTLYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ruApRDwyE/XyhuHw4ObCqk6nkpUiEnJy2HPfoSkyyE=;
	b=iti74EDoqRLhWOMUcrG4JG503EYXtLXBqeeLJByqikzEJvE1oQEXaQUgQK8Sa5NQ9w9GQq
	S/lX9gLbNgYEerCQ==
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: [PATCH v3 15/24] genirq/gic-v3-mbi: Switch to MSI parent
Date: Fri, 14 Jun 2024 12:23:54 +0200
Message-Id: <20240614102403.13610-16-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

All platform MSI users and the PCI/MSI code handle per device MSI domains
when the irqdomain associated to the device provides MSI parent
functionality.

Remove the "global" PCI/MSI and platform domain related code and provide
the MSI parent functionality by filling in msi_parent_ops.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
v3: enabled MSI_FLAG_PCI_MSI_MASK_PARENT in msi_parent_ops::supported_flags 
---
 drivers/irqchip/irq-gic-v3-mbi.c | 127 +++++++++----------------------
 1 file changed, 35 insertions(+), 92 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 19298cc6c2ee..26b95027934e 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
+#include "irq-msi-lib.h"
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
@@ -138,85 +149,31 @@ static void mbi_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops mbi_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
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
-
-static void mbi_unmask_msi_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip mbi_msi_irq_chip = {
-	.name			= "MSI",
-	.irq_mask		= mbi_mask_msi_irq,
-	.irq_unmask		= mbi_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_compose_msi_msg	= mbi_compose_msi_msg,
-};
-
-static struct msi_domain_info mbi_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &mbi_msi_irq_chip,
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define MBI_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static const struct msi_parent_ops gic_v3_mbi_msi_parent_ops = {
+	.supported_flags	= MBI_MSI_FLAGS_SUPPORTED,
+	.required_flags		= MBI_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "MBI-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
-static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
-				   struct irq_domain **pci_domain)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
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
-{
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
 
 	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
 						   &mbi_domain_ops, NULL);
@@ -224,22 +181,8 @@ static int mbi_allocate_domains(struct irq_domain *parent)
 		return -ENOMEM;
 
 	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
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
 
@@ -302,7 +245,7 @@ int __init mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent)
 
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
 
-	ret = mbi_allocate_domains(parent);
+	ret = mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
 
-- 
2.34.1


