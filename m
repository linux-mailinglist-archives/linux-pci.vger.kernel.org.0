Return-Path: <linux-pci+bounces-27659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA32AB5B41
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40230467AB1
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32EC2BF98D;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k7KjNaUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2C2BF980;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157311; cv=none; b=jZeiO4xcIZYgJFeTScTxTQBaWsPCR/2E1wyyBk2nrZOtj6Dc/KajdSFfEwYNaex85Fh/GqCDFcQ1xfBOfzMihh3SHZRFLXjPXGNqcCRuaA5mzYUp3yqZqzS0l3f32/B2t/DHo6g2YUjzMZ/M7u2x8t7Zrykh9rhh0XmZaQK150E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157311; c=relaxed/simple;
	bh=gmbXoFaITb4zPThfd6bxcc1micuU2rdahzJdEqv2nno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNJSM8G9Nr+BRR0N/m47wk6dp8oknAQ00Etq091sbmgON1QP7cFjPtIAnEWeDtOn3GoYrmJkMFA4OigxNhrhBK8gSE6cuF3Pp+p9AfLH0yQ0UJBz9fp92JTspHX8JjOPKsUNGe485QBAcr07tpmy9GgRfnPR8Rpnmr6nIWCcZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k7KjNaUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46325C4CEF2;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157311;
	bh=gmbXoFaITb4zPThfd6bxcc1micuU2rdahzJdEqv2nno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k7KjNaUpV8mqRS2Sqf10f9sz62ek6Q9bF4vxalN+DyghCKrrl70xK2jWvB2BpW1N8
	 CV57PM2MyqV0WxSRWpJjXn1lkKyoVf9mdmALnWghGPoDmUMvNeKXGX1yVvItGyJ5Hq
	 rFT9DRuT9gxSY8QH+xu8yBih7YuVedUDPFVBo0XEi3IdbY1rp1prRW4vWh8loaDyJC
	 xq4EK3bXihcKExnAqyiPtUCfrqUiuIfLZOrTmiQ0wB5YsMVzrC0RxYm+CzZ1NSRauM
	 AAVnbOZWkLIkFmBVlrvnC92QEDYBWEl/jcoUFdClDbyETS3AHKyTGbo5OMnvGgNHUI
	 C4N4lORsnX7KA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQb-00EbRz-Et;
	Tue, 13 May 2025 18:28:29 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 7/9] PCI: apple: Convert to MSI parent infrastructure
Date: Tue, 13 May 2025 18:28:17 +0100
Message-Id: <20250513172819.2216709-8-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

In an effort to move arm64 away from the legacy MSI setup,
convert the apple PCIe driver to the MSI-parent infrastructure
and let each device have its own MSI domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig      |  1 +
 drivers/pci/controller/pcie-apple.c | 62 ++++++++++-------------------
 2 files changed, 22 insertions(+), 41 deletions(-)

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
index 18e11b9a7f464..6c88b4dd34151 100644
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
@@ -133,7 +134,6 @@ struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
 	void __iomem            *base;
-	struct irq_domain	*domain;
 	unsigned long		*bitmap;
 	struct list_head	ports;
 	struct completion	event;
@@ -162,27 +162,6 @@ static void rmw_clear(u32 clr, void __iomem *addr)
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
@@ -226,8 +205,7 @@ static int apple_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-					      &apple_msi_bottom_chip,
-					      domain->host_data);
+					      &apple_msi_bottom_chip, pcie);
 	}
 
 	return 0;
@@ -251,12 +229,6 @@ static const struct irq_domain_ops apple_msi_domain_ops = {
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
@@ -595,6 +567,18 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	return 0;
 }
 
+static const struct msi_parent_ops apple_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX		|
+				   MSI_FLAG_MULTI_PCI_MSI),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS	|
+				   MSI_FLAG_PCI_MSI_MASK_PARENT),
+	.chip_flags		= MSI_CHIP_FLAG_SET_EOI,
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int apple_msi_init(struct apple_pcie *pcie)
 {
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
@@ -625,21 +609,17 @@ static int apple_msi_init(struct apple_pcie *pcie)
 		return -ENXIO;
 	}
 
-	parent = irq_domain_create_hierarchy(parent, 0, pcie->nvecs, fwnode,
-					     &apple_msi_domain_ops, pcie);
+	parent = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= fwnode,
+			.ops		= &apple_msi_domain_ops,
+			.size		= pcie->nvecs,
+			.host_data	= pcie,
+			.parent		= parent,
+		}, &apple_msi_parent_ops);
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


