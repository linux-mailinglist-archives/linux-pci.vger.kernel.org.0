Return-Path: <linux-pci+bounces-27661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF27CAB5B44
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 262031884AFE
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E7B2BFC7D;
	Tue, 13 May 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAAz9vqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D12BFC77;
	Tue, 13 May 2025 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157312; cv=none; b=njr+7SGi5hH7TjohLaPufjgAXTXFhYHTF/IWTBSZrjdBt7T1UsND4gu4lTJP4aGKiO2f3+bdhpTzmRXpH9EXBw1BaeNEcFdjxeQ/IHyxhgQXXhL8gjKn05jHK7f5y3g4+czeKFhs+GpLThAUizzRFDkM0taGL4vX9JbAZIgIsQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157312; c=relaxed/simple;
	bh=Q8w46xAjeQAyJ+1XbNSXNwc3/sOPI9k8U7Sk79sgA1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=coauZnCFgZ37R8QrH6v4lPHWSXe8gtLsIhDw6xXrRPuAy1LKD8AIDkD1V7djWK/IUouvqJ71ddFRpsglqS8yKu7/q///4Q03E8w0VG1bqaZMBQNFBhS4CxOA3ywAnDcjVxODpQGcSTntVzVoFmMvVp1bPMxam/FmnRbirIKyAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAAz9vqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E326EC4CEED;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157311;
	bh=Q8w46xAjeQAyJ+1XbNSXNwc3/sOPI9k8U7Sk79sgA1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAAz9vqLVar8Bi7GoIsPRMiEYZBh+E7Hk/h5SKnVk5PzGKRyWQJb47apk/l73bRfN
	 RfQ5YBlEP2Kv7lsCq9JGQFLO7nqCG6e/V2Q0oER5IBM+NOLEEGc0AgNWGHCS0qnSQW
	 F+CMCNY9GdIdArhRtyJ2robA+puuAIiH2LcMoMmIySf2g+NhtctES3UxoMFUI14iF6
	 A3LaEmDYQknWLilov8UruLysplHSDNeiQQO/ejNwlCh0JCCe3AqFxOh1M8qwcQHCFL
	 PO5HivaWw56DgYNJH9RZQsNewu0SllaXSzOR4QHRgDpUTG/a9Yq3i0quoJ96mAovRo
	 li3jctX4uMlNw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQb-00EbRz-UG;
	Tue, 13 May 2025 18:28:30 +0100
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
Subject: [PATCH v2 9/9] PCI: tegra: Convert to MSI parent infrastructure
Date: Tue, 13 May 2025 18:28:19 +0100
Message-Id: <20250513172819.2216709-10-maz@kernel.org>
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
convert the tegra PCIe driver to the MSI-parent infrastructure
and let each device have its own MSI domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/Kconfig     |  1 +
 drivers/pci/controller/pci-tegra.c | 60 +++++++++---------------------
 2 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 205e0e365c6b1..eb3cc28d43f82 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -228,6 +228,7 @@ config PCI_TEGRA
 	bool "NVIDIA Tegra PCIe controller"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
+	select IRQ_MSI_LIB
 	help
 	  Say Y here if you want support for the PCIe host controller found
 	  on NVIDIA Tegra SoCs.
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d2f88997283ae..def9384bd6ff0 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -22,6 +22,7 @@
 #include <linux/iopoll.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -1547,7 +1548,7 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 			unsigned int index = i * 32 + offset;
 			int ret;
 
-			ret = generic_handle_domain_irq(msi->domain->parent, index);
+			ret = generic_handle_domain_irq(msi->domain, index);
 			if (ret) {
 				/*
 				 * that's weird who triggered this?
@@ -1565,30 +1566,6 @@ static void tegra_pcie_msi_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void tegra_msi_top_irq_ack(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void tegra_msi_top_irq_mask(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void tegra_msi_top_irq_unmask(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip tegra_msi_top_chip = {
-	.name		= "Tegra PCIe MSI",
-	.irq_ack	= tegra_msi_top_irq_ack,
-	.irq_mask	= tegra_msi_top_irq_mask,
-	.irq_unmask	= tegra_msi_top_irq_unmask,
-};
-
 static void tegra_msi_irq_ack(struct irq_data *d)
 {
 	struct tegra_msi *msi = irq_data_get_irq_chip_data(d);
@@ -1690,30 +1667,32 @@ static const struct irq_domain_ops tegra_msi_domain_ops = {
 	.free = tegra_msi_domain_free,
 };
 
-static struct msi_domain_info tegra_msi_info = {
-	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX,
-	.chip	= &tegra_msi_top_chip,
+static const struct msi_parent_ops tegra_msi_parent_ops = {
+	.supported_flags	= (MSI_GENERIC_FLAGS_MASK	|
+				   MSI_FLAG_PCI_MSIX),
+	.required_flags		= (MSI_FLAG_USE_DEF_DOM_OPS	|
+				   MSI_FLAG_USE_DEF_CHIP_OPS	|
+				   MSI_FLAG_PCI_MSI_MASK_PARENT	|
+				   MSI_FLAG_NO_AFFINITY),
+	.chip_flags		= MSI_CHIP_FLAG_SET_ACK,
+	.bus_select_token	= DOMAIN_BUS_PCI_MSI,
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
 };
 
 static int tegra_allocate_domains(struct tegra_msi *msi)
 {
 	struct tegra_pcie *pcie = msi_to_pcie(msi);
 	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
-	struct irq_domain *parent;
 
-	parent = irq_domain_create_linear(fwnode, INT_PCI_MSI_NR,
-					  &tegra_msi_domain_ops, msi);
-	if (!parent) {
-		dev_err(pcie->dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
+	msi->domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= fwnode,
+			.ops		= &tegra_msi_domain_ops,
+			.size		= INT_PCI_MSI_NR,
+			.host_data	= msi,
+		}, &tegra_msi_parent_ops);
 
-	msi->domain = pci_msi_create_irq_domain(fwnode, &tegra_msi_info, parent);
 	if (!msi->domain) {
 		dev_err(pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(parent);
 		return -ENOMEM;
 	}
 
@@ -1722,10 +1701,7 @@ static int tegra_allocate_domains(struct tegra_msi *msi)
 
 static void tegra_free_domains(struct tegra_msi *msi)
 {
-	struct irq_domain *parent = msi->domain->parent;
-
 	irq_domain_remove(msi->domain);
-	irq_domain_remove(parent);
 }
 
 static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
-- 
2.39.2


