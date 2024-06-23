Return-Path: <linux-pci+bounces-9146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9C913C25
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8E52857DB
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A733D185E7C;
	Sun, 23 Jun 2024 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ta83QcXq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TdTod5Hy"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DB1850B2;
	Sun, 23 Jun 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155935; cv=none; b=otuNRvWdudbp/pF8pO2Fpw1WU27RTxK6mbMdhYVNSLAOlt0L72ZupqTz/mgBWFW8aJjNAGr+D6fguXnPd/oguxJk5pHoYoQ/F5Eh+HL9aqUbJVNhf170EDEOEGt4beR1g7e1sR85EgDvoGfxbOfpY8hsJrYilafmF3d9EEoW+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155935; c=relaxed/simple;
	bh=mjw53NzK9cPeToCBx+urdQ+v21YwFyx3RL4n9ozGYuw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=bDiuqTKzd9Q5mFFkEdymhzGowC5A417t5mSAiY/XDxp6nmDXsGSlobhlUrTQ/tu/gjyJutVcwNxdB+obBiB8Lf/LEn5Dwdo62tDLoaUTRM8QjkSf1pqVLbkG908KZy6XQVAdoDrqwgl1P6ADry/f8cu0fjGBSK1LNgGZaAKOjMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ta83QcXq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TdTod5Hy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.455849114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xtBOAqjRz4h788CrhG/Wr49Fj0DnINhSJnKw3JKj4/g=;
	b=ta83QcXqK5Xra48c/89zGArS6Afpfh8mnfT8R+Bslq6e4wcV75yDyLjna0tpmtkTG+QJv9
	suluxwBkD8HwPDeuceJbPeJl09FNL95AfwGyb2iTE8VcKjKkpvE/yq4EcPePfptQE+vvNm
	trkVIXJ5PVG4EToSh0qCSwaUhUO1G6ewY0cqD/1EVUf6c3XDVTQBPp1zvyUPoDTQOTsUfz
	XAKno1nIciiRS3B3uuaVQ7xHUEFlD275ORWWYTKcjmvQKvZUNLbiahZA24lUXS6FkQ4Kcm
	msP4ezvOfr2+3e1+JhHYCRla1zOlFR8Hx7KQUpKVrD1MLralkOSu0Uo4FKtOqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xtBOAqjRz4h788CrhG/Wr49Fj0DnINhSJnKw3JKj4/g=;
	b=TdTod5HyyE+JjMKtBduGaHmHjqYY+t8+P1oZfLcVgxMUSqIaJVJu7/VjZdlw1aHBLh+aJX
	BWc3dYy+/ppViCDg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
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
Subject: [patch V4 12/21] irqchip/gic_v3_mbi: Switch over to parent domain
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:51 +0200 (CEST)

The MBI chip creates two MSI domains:
    - PCI/MSI
    - Platform device domain

Both have the MBI domain as parent and differ slightly in the interrupt
chip callbacks and the platform device domain supports level type
signaling.

Convert it over to the MSI parent domain mechanism by:

   - Providing the required templates
   
   - Implementing a custom init_dev_msi_info() callback which sets the chip
     callbacks and the level support flags depending on the domain bus token
     type of the per device domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3-1: New patch to replace the broken conversion - Marc
---
 drivers/irqchip/irq-gic-v3-mbi.c |  128 ++++++++++++++-------------------------
 1 file changed, 46 insertions(+), 82 deletions(-)

--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,6 +18,8 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
+#include "irq-msi-lib.h"
+
 struct mbi_range {
 	u32			spi_start;
 	u32			nr_spis;
@@ -138,6 +140,7 @@ static void mbi_irq_domain_free(struct i
 }
 
 static const struct irq_domain_ops mbi_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= mbi_irq_domain_alloc,
 	.free			= mbi_irq_domain_free,
 };
@@ -151,54 +154,6 @@ static void mbi_compose_msi_msg(struct i
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), msg);
 }
 
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
-{
-	*pci_domain = NULL;
-	return 0;
-}
-#endif
-
 static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	mbi_compose_msi_msg(data, msg);
@@ -210,28 +165,51 @@ static void mbi_compose_mbi_msg(struct i
 	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
 }
 
-/* Platform-MSI specific irqchip */
-static struct irq_chip mbi_pmsi_irq_chip = {
-	.name			= "pMSI",
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
-	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
-};
+static bool mbi_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
 
-static struct msi_domain_ops mbi_pmsi_ops = {
-};
+	switch (info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		info->chip->irq_compose_msi_msg = mbi_compose_msi_msg;
+		return true;
+
+	case DOMAIN_BUS_DEVICE_MSI:
+		info->chip->irq_compose_msi_msg = mbi_compose_mbi_msg;
+		info->chip->irq_set_type = irq_chip_set_type_parent;
+		info->chip->flags |= IRQCHIP_SUPPORTS_LEVEL_MSI;
+		info->flags |= MSI_FLAG_LEVEL_CAPABLE;
+		return true;
+
+	default:
+		WARN_ON_ONCE(1);
+		return false;
+	}
+}
+
+#define MBI_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
 
-static struct msi_domain_info mbi_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
-	.ops	= &mbi_pmsi_ops,
-	.chip	= &mbi_pmsi_irq_chip,
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
+	.init_dev_msi_info	= mbi_init_dev_msi_info,
 };
 
-static int mbi_allocate_domains(struct irq_domain *parent)
+static int mbi_allocate_domain(struct irq_domain *parent)
 {
-	struct irq_domain *nexus_domain, *pci_domain, *plat_domain;
-	int err;
+	struct irq_domain *nexus_domain;
 
 	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
 						   &mbi_domain_ops, NULL);
@@ -239,22 +217,8 @@ static int mbi_allocate_domains(struct i
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
 
@@ -317,7 +281,7 @@ int __init mbi_init(struct fwnode_handle
 
 	pr_info("Using MBI frame %pa\n", &mbi_phys_base);
 
-	ret = mbi_allocate_domains(parent);
+	ret = mbi_allocate_domain(parent);
 	if (ret)
 		goto err_free_mbi;
 


