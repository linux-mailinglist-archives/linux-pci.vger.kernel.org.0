Return-Path: <linux-pci+bounces-17653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7689E3A44
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02F528546F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417DC1BBBC8;
	Wed,  4 Dec 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH0f2cxu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D2E1EB9E7;
	Wed,  4 Dec 2024 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316370; cv=none; b=tnB3w8EFTw6OprKV0eFb3iypnJOhgErRF04+5PtEKW+xPm6gpJJevA+jmpJF41d/WdM0j0IFEw7V/aoGwB3gWdSBDXO+/LTF/ricPxMOguL3VQ/EcHOVi/+D/7KBbfTx6wiKk8lXd6yIVDC6dEUVz077H1t5X95/N5GTC1CRk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316370; c=relaxed/simple;
	bh=NPW6c3VDoAyeTY2GD72s1RHlrmv8mP4Sc8+nycqjNi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cz8jp4ebztV058/KIKMspQ1X4q2sSPlFkhis5iQwlFLK5SsN4qZvC4fbypFItVVuwDDz4AAk5APDdZyskfKFJ4ZTt/vOCntV1ZtLRHSaLcLFSQeIa9IE3CVRlGMrQEUulJ8lgFLOD1SAUouw78s3m2JbS/BNil14WbWOMeqe+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oH0f2cxu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1725C4CED1;
	Wed,  4 Dec 2024 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316369;
	bh=NPW6c3VDoAyeTY2GD72s1RHlrmv8mP4Sc8+nycqjNi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oH0f2cxu4cUugaMlPmlrMOH4WJ9Txnq2Om4S/PUMZ7gqWsBpfd31BNo2+D5CQPQEy
	 dnTbWFfSmKjndLUMMfBStG1oIOjipJEk+6FHdC5prmrPjIyxsBIPJA6/PIXCx94QM9
	 CTQ1Nf63DOUSZyV1WuQWhgCQ06tgKDEueZ9Vqr9tUB7enSAtn1glTLM04gzGBRhJ8m
	 y9zngyF4C03gp/uBeYetGUxCSxHPeHtAghHNYT8S4byu3a/DrXzxCBHLOMpO2fNmN6
	 7CDZmMIX2CqYDE4H0PvXsy8tp1IRWatyHOUo9xT4OdTYKBG0OC4lkK8naVHBWy3Tnu
	 vkl/q66P9HunA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIolb-000RHy-Ns;
	Wed, 04 Dec 2024 12:46:07 +0000
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
Subject: [PATCH 10/11] PCI: apple: Convert to MSI parent infrastructure
Date: Wed,  4 Dec 2024 12:45:48 +0000
Message-Id: <20241204124549.607054-11-maz@kernel.org>
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
convert the apple PCIe driver to the MSI-parent infrastructure
and let each device have its own MSI domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig      |  1 +
 drivers/pci/controller/pcie-apple.c | 57 ++++++++---------------------
 2 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 9800b76810540..98a62f4559dfd 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -40,6 +40,7 @@ config PCIE_APPLE
 	depends on OF
 	depends on PCI_MSI
 	select PCI_HOST_COMMON
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want to enable PCIe controller support on Apple
 	  system-on-chips, like the Apple M1. This is required for the USB
diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index fefab2758a064..945070ac31cf8 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -134,7 +135,6 @@ struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
 	void __iomem            *base;
-	struct irq_domain	*domain;
 	unsigned long		*bitmap;
 	struct list_head	ports;
 	struct completion	event;
@@ -163,27 +163,6 @@ static void rmw_clear(u32 clr, void __iomem *addr)
 	writel_relaxed(readl_relaxed(addr) & ~clr, addr);
 }
 
-static void apple_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void apple_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip apple_msi_top_chip = {
-	.name			= "PCIe MSI",
-	.irq_mask		= apple_msi_top_irq_mask,
-	.irq_unmask		= apple_msi_top_irq_unmask,
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_set_affinity	= irq_chip_set_affinity_parent,
-	.irq_set_type		= irq_chip_set_type_parent,
-};
-
 static void apple_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	msg->address_hi = upper_32_bits(DOORBELL_ADDR);
@@ -227,8 +206,7 @@ static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &apple_msi_bottom_chip,
-					      domain->host_data);
+					      &apple_msi_bottom_chip, pcie);
 	}
 
 	return 0;
@@ -252,12 +230,6 @@ static const struct irq_domain_ops apple_msi_domain_ops = {
 	.free	= apple_msi_domain_free,
 };
 
-static struct msi_domain_info apple_msi_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	= &apple_msi_top_chip,
-};
-
 static void apple_port_irq_mask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
@@ -596,6 +568,17 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	return 0;
 }
 
+static const struct msi_parent_ops apple_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX		|
+				   MSI_FLAG_MULTI_PCI_MSI),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS	|
+				   MSI_FLAG_PCI_MSI_MASK_PARENT),
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int apple_msi_init(struct apple_pcie *pcie)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
@@ -626,21 +609,13 @@ static int apple_msi_init(struct apple_pcie *pcie)
 		return -ENXIO;
 	}
 
-	parent = irq_domain_create_hierarchy(parent, 0, pcie->nvecs, fwnode,
-					     &apple_msi_domain_ops, pcie);
+	parent = msi_create_parent_irq_domain(fwnode, &apple_msi_parent_ops,
+					      &apple_msi_domain_ops, 0,
+					      pcie->nvecs, pcie, parent);
 	if (!parent) {
 		dev_err(pcie->dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
-
-	pcie->domain = pci_msi_create_irq_domain(fwnode, &apple_msi_info,
-						 parent);
-	if (!pcie->domain) {
-		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
-		return -ENOMEM;
-	}
 
 	return 0;
 }
-- 
2.39.2


