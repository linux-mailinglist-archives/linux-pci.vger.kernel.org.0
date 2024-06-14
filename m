Return-Path: <linux-pci+bounces-8815-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5348B9089E1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BB441C26E2F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA119B59B;
	Fri, 14 Jun 2024 10:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nZ9g5XN1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzNkhZ/3"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFA194AD6;
	Fri, 14 Jun 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360750; cv=none; b=nfMzjAGI45iKcJTNIWa7sGND7kPgT0qTzOPvqqYj8lwfO8XwnUgXaZ5DTDN4n2I4mDqmOXvp8IIo/fuVUVJVAFk3mpLT9Csy7CEQ7XsOH5UTSR+7s7TiqGPb9v6rDwZbBYdh8i6aEk3DUpEGHtSV8XXFuIkZqsWAtSIBvJ1mqLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360750; c=relaxed/simple;
	bh=CxBMktp/wraRKEVbSUJZguuI1Sno4Yp/NBQpxxWIwXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8AqTvTFSFgvn79snyjXCVS3eCCcAmdKCCFA661K56FF90Ti+CsA5CPK6uWjBeeYZ5zSUJBLWyaL+fHcLOauZnJYbfNr0o8N1Ujai22SftpaKzcTYgcYJUtuTqVdBWMBe/yCes4nbBWyokVUoob8EJbXEZXxLXEORC+qTxiWffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nZ9g5XN1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzNkhZ/3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80S7tvro3d+QwdmyvrQJCD5xbnx57tslD8QNvOvwnnU=;
	b=nZ9g5XN1iJi9SUtDnwkPv9G0qCtq6tZ68nLMiiN72V0Xe8dZKRlINlRIQzlQrap8pNh66Y
	BhfF5tgJFQYBM9Zz0eZS1eASyZm+FZYvsg4uVTR8PaVAanddYII0OYosBYLMM+c8epbCMs
	T4sfCoRtBeb5Gjiu4v/V0JEuQBIwxEGawZgBn3/9YxfnJRfoqZumhfZC0svDQtgrOkCurc
	dgI35ZXWNrVVXUahednPns3Ub02/Viy+xbUJADG3+fw+IYVJ/YXQR4TnKkNsUTAghy4XpR
	1zi8bLf19fVcuMbK2Nn9B2l7or6dp+CrfyNHN6UgFN+huV54exp8QA16V/iAHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=80S7tvro3d+QwdmyvrQJCD5xbnx57tslD8QNvOvwnnU=;
	b=xzNkhZ/3R51OT0QmV+PKecIcyJXjU+yudqtps9DZpDFfP+TXMCwXLXIUg8rjJ5ec8kbYrE
	MQkjo9hoG9popiBw==
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
Subject: [PATCH v3 16/24] irqchip/gic-v2m: Switch to device MSI
Date: Fri, 14 Jun 2024 12:23:55 +0200
Message-Id: <20240614102403.13610-17-shivamurthy.shastri@linutronix.de>
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
 drivers/irqchip/Kconfig       |  1 +
 drivers/irqchip/irq-gic-v2m.c | 80 +++++++++++------------------------
 2 files changed, 25 insertions(+), 56 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index b51863fa9b38..2104b8727b1a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -26,6 +26,7 @@ config ARM_GIC_V2M
 	bool
 	depends on PCI
 	select ARM_GIC
+	select IRQ_MSI_LIB
 	select PCI_MSI
 
 config GIC_NON_BANKED
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f2ff4387870d..428132aa26cc 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,6 +26,8 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
 
+#include "irq-msi-lib.h"
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
@@ -230,6 +207,7 @@ static void gicv2m_irq_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops gicv2m_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= gicv2m_irq_domain_alloc,
 	.free			= gicv2m_irq_domain_free,
 };
@@ -250,19 +228,6 @@ static bool is_msi_spi_valid(u32 base, u32 num)
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
@@ -278,9 +243,26 @@ static void __init gicv2m_teardown(void)
 	}
 }
 
+#define GICV2M_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				    MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define GICV2M_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				    MSI_FLAG_PCI_MSIX      |	\
+				    MSI_FLAG_MULTI_PCI_MSI |	\
+				    MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static struct msi_parent_ops gicv2m_msi_parent_ops = {
+	.supported_flags	= GICV2M_MSI_FLAGS_SUPPORTED,
+	.required_flags		= GICV2M_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI | MATCH_PLATFORM_MSI,
+	.prefix			= "GICv2m-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 {
-	struct irq_domain *inner_domain, *pci_domain, *plat_domain;
+	struct irq_domain *inner_domain;
 	struct v2m_data *v2m;
 
 	v2m = list_first_entry_or_null(&v2m_nodes, struct v2m_data, entry);
@@ -295,22 +277,8 @@ static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 	}
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
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
 
@@ -511,7 +479,7 @@ acpi_parse_madt_msi(union acpi_subtable_headers *header,
 		pr_info("applying Amazon Graviton quirk\n");
 		res.end = res.start + SZ_8K - 1;
 		flags |= GICV2M_GRAVITON_ADDRESS_ONLY;
-		gicv2m_msi_domain_info.flags &= ~MSI_FLAG_MULTI_PCI_MSI;
+		gicv2m_msi_parent_ops.supported_flags &= ~MSI_FLAG_MULTI_PCI_MSI;
 	}
 
 	if (m->flags & ACPI_MADT_OVERRIDE_SPI_VALUES) {
-- 
2.34.1


