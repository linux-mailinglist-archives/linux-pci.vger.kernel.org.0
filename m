Return-Path: <linux-pci+bounces-17654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300709E3A51
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 321D0B2BD95
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B441F471F;
	Wed,  4 Dec 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUOAOGxD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E21F426E;
	Wed,  4 Dec 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316370; cv=none; b=N8GUin9Ro5oL9eX3F6aPC38MHeW1HPo7P+f2mjytl+EDA0W/oTAP1h4Qau8TED28d7qTAdcQpMznRnTyA6LCK/dN35vWBDLntdsoNjABHVLXJEq0Qb0auOjQ+9OY+uq48DnSD4i0Sdx0mO6jNlA2RSyf5C6V8sAShCJ8+GNLoOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316370; c=relaxed/simple;
	bh=WovDOhGvJI34dfRdwLOil5noAJ5CREZZX4oJMEsuV3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JZInUacGoIJlqiN+9ZnWVoaiPIVScJEn+gdE3B6GPOC+U5D4cPK5DJT9LPqOcl6g9vk7XnZ0rSlk4qW15eGodnMY+VD2A18HS5vTpZR+tcacr9tshIfxWVYs9Z3grWxrvafY9++ODnoY0EJ1uB2X4eOvK6L3O/aSi6ZqqP1Mi6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUOAOGxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D740C4CEE4;
	Wed,  4 Dec 2024 12:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316370;
	bh=WovDOhGvJI34dfRdwLOil5noAJ5CREZZX4oJMEsuV3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUOAOGxDdJCpu9CKizY2dme6+QjXgFdhMgbIAtu+zIYKisA9lS0WvyerxS1fXCxPY
	 t3j55q66bUY9eCYymATDsBvYYd+IqYHPtn1e7vQx3RJyDLiWiiZcmWyYHYRa/Yb0Ln
	 MP23MO1U0GrTvYw679XpCjcEmsS67z6gvNhik4vdE+Epv3wWWPgKxGcKHztdtZTY8F
	 N9Gp8NbO7A3+t5/Kz0j7J765cEhdqVSHzFEjI6t+yuOY4AYcZ2dLyldBbRb0UGDIw9
	 fuFJc9P29p0HnKXgUxtCjZp6djxgFRjuSXkSuWYGjCHcqcKpWMnMXvvqIlIh5EjUI1
	 7fYhjW87yzjFQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIolc-000RHy-5S;
	Wed, 04 Dec 2024 12:46:08 +0000
From: Marc Zyngier <maz@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 11/11] PCI: xgene: Convert to MSI parent infrastructure
Date: Wed,  4 Dec 2024 12:45:49 +0000
Message-Id: <20241204124549.607054-12-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204124549.607054-1-maz@kernel.org>
References: <20241204124549.607054-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In an effort to move arm64 away from the legacy MSI setup,
convert the xgene PCIe driver to the MSI-parent infrastructure
and let each device have its own MSI domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig         |  1 +
 drivers/pci/controller/pci-xgene-msi.c | 44 +++++++++-----------------
 2 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 98a62f4559dfd..205e0e365c6b1 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -304,6 +304,7 @@ config PCI_XGENE_MSI
 	bool "X-Gene v1 PCIe MSI feature"
 	depends on PCI_XGENE
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	default y
 	help
 	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index 88c0977bc41a4..d9e4d1e136f77 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/of_pci.h>
@@ -32,7 +33,6 @@ struct xgene_msi_group {
 struct xgene_msi {
 	struct device_node	*node;
 	struct irq_domain	*inner_domain;
-	struct irq_domain	*msi_domain;
 	u64			msi_addr;
 	void __iomem		*msi_regs;
 	unsigned long		*bitmap;
@@ -44,20 +44,6 @@ struct xgene_msi {
 /* Global data */
 static struct xgene_msi xgene_msi_ctrl;
 
-static struct irq_chip xgene_msi_top_irq_chip = {
-	.name		= "X-Gene1 MSI",
-	.irq_enable	= pci_msi_unmask_irq,
-	.irq_disable	= pci_msi_mask_irq,
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
-};
-
-static struct  msi_domain_info xgene_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX),
-	.chip	= &xgene_msi_top_irq_chip,
-};
-
 /*
  * X-Gene v1 has 16 groups of MSI termination registers MSInIRx, where
  * n is group number (0..F), x is index of registers in each group (0..7)
@@ -235,34 +221,34 @@ static void xgene_irq_domain_free(struct irq_domain *domain,
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
+static const struct irq_domain_ops xgene_msi_domain_ops = {
 	.alloc  = xgene_irq_domain_alloc,
 	.free   = xgene_irq_domain_free,
 };
 
+static const struct msi_parent_ops xgene_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS),
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int xgene_allocate_domains(struct xgene_msi *msi)
 {
-	msi->inner_domain = irq_domain_add_linear(NULL, NR_MSI_VEC,
-						  &msi_domain_ops, msi);
+	msi->inner_domain = msi_create_parent_irq_domain(of_node_to_fwnode(msi->node),
+							 &xgene_msi_parent_ops,
+							 &xgene_msi_domain_ops,
+							 0, NR_MSI_VEC, msi, NULL);
 	if (!msi->inner_domain)
 		return -ENOMEM;
 
-	msi->msi_domain = pci_msi_create_irq_domain(of_node_to_fwnode(msi->node),
-						    &xgene_msi_domain_info,
-						    msi->inner_domain);
-
-	if (!msi->msi_domain) {
-		irq_domain_remove(msi->inner_domain);
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static void xgene_free_domains(struct xgene_msi *msi)
 {
-	if (msi->msi_domain)
-		irq_domain_remove(msi->msi_domain);
 	if (msi->inner_domain)
 		irq_domain_remove(msi->inner_domain);
 }
-- 
2.39.2


