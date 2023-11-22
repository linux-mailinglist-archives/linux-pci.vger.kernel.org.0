Return-Path: <linux-pci+bounces-101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF097F3DE4
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05179282B8F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AD154B0;
	Wed, 22 Nov 2023 06:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rc7xhfIT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C30154AD
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06BE0C433C9;
	Wed, 22 Nov 2023 06:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633076;
	bh=q6Yi8Pu0XtBAsr6TI6iBdB9zITdb5WzC/DbNodJb6Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rc7xhfIT2gFcTzfN+FPgI8T6KsbWal2AB+W+CmRi/XbVaQt9PXSfH3IPxxy9FgdGu
	 SZZIfi1IzYevUZ90RxWxu1zqpGeHV3O2OIl7NaykEI1YNU4jXB+6pm6cOfs9Mfu4vq
	 BdUp1yF4czdT1x+zRb+z63hN6RUI3sXkQojeZxes//Q9SAa8N0T+kxQ0fUHxZQo8kV
	 yAegqyuq+9Ms3oCo6LqeAbhOVngzhwA+w7rnVAsMrfGICnoNpk91DHb4hqbAO3qmvF
	 UWMg1zcHKDWWmuNjCYJ/EzMyN8RrMTg/EWHe3Kbp8Rd10Z+Hs2xDp7zSY7HjWtEabt
	 1ssK0spwN9AJQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 16/16] PCI: xilinx-nwl: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:04:06 +0900
Message-ID: <20231122060406.14695-17-dlemoal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122060406.14695-1-dlemoal@kernel.org>
References: <20231122060406.14695-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the xilinx-nwl controller driver, change all use of "legacy" and
"leg" to "intx", to match the term used in the PCI specifications.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 52 ++++++++++++------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index e307aceba5c9..0408f4d612b5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -166,7 +166,7 @@ struct nwl_pcie {
 	int irq_intx;
 	int irq_misc;
 	struct nwl_msi msi;
-	struct irq_domain *legacy_irq_domain;
+	struct irq_domain *intx_irq_domain;
 	struct clk *clk;
 	raw_spinlock_t leg_mask_lock;
 };
@@ -324,7 +324,7 @@ static void nwl_pcie_leg_handler(struct irq_desc *desc)
 	while ((status = nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 				MSGF_LEG_SR_MASKALL) != 0) {
 		for_each_set_bit(bit, &status, PCI_NUM_INTX)
-			generic_handle_domain_irq(pcie->legacy_irq_domain, bit);
+			generic_handle_domain_irq(pcie->intx_irq_domain, bit);
 	}
 
 	chained_irq_exit(chip, desc);
@@ -364,7 +364,7 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void nwl_mask_leg_irq(struct irq_data *data)
+static void nwl_mask_intx_irq(struct irq_data *data)
 {
 	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
@@ -378,7 +378,7 @@ static void nwl_mask_leg_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
 }
 
-static void nwl_unmask_leg_irq(struct irq_data *data)
+static void nwl_unmask_intx_irq(struct irq_data *data)
 {
 	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
@@ -392,26 +392,26 @@ static void nwl_unmask_leg_irq(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&pcie->leg_mask_lock, flags);
 }
 
-static struct irq_chip nwl_leg_irq_chip = {
+static struct irq_chip nwl_intx_irq_chip = {
 	.name = "nwl_pcie:legacy",
-	.irq_enable = nwl_unmask_leg_irq,
-	.irq_disable = nwl_mask_leg_irq,
-	.irq_mask = nwl_mask_leg_irq,
-	.irq_unmask = nwl_unmask_leg_irq,
+	.irq_enable = nwl_unmask_intx_irq,
+	.irq_disable = nwl_mask_intx_irq,
+	.irq_mask = nwl_mask_intx_irq,
+	.irq_unmask = nwl_unmask_intx_irq,
 };
 
-static int nwl_legacy_map(struct irq_domain *domain, unsigned int irq,
-			  irq_hw_number_t hwirq)
+static int nwl_intx_map(struct irq_domain *domain, unsigned int irq,
+			irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &nwl_leg_irq_chip, handle_level_irq);
+	irq_set_chip_and_handler(irq, &nwl_intx_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 	irq_set_status_flags(irq, IRQ_LEVEL);
 
 	return 0;
 }
 
-static const struct irq_domain_ops legacy_domain_ops = {
-	.map = nwl_legacy_map,
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = nwl_intx_map,
 	.xlate = pci_irqd_intx_xlate,
 };
 
@@ -525,20 +525,20 @@ static int nwl_pcie_init_irq_domain(struct nwl_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
-	struct device_node *legacy_intc_node;
+	struct device_node *intc_node;
 
-	legacy_intc_node = of_get_next_child(node, NULL);
-	if (!legacy_intc_node) {
+	intc_node = of_get_next_child(node, NULL);
+	if (!intc_node) {
 		dev_err(dev, "No legacy intc node found\n");
 		return -EINVAL;
 	}
 
-	pcie->legacy_irq_domain = irq_domain_add_linear(legacy_intc_node,
-							PCI_NUM_INTX,
-							&legacy_domain_ops,
-							pcie);
-	of_node_put(legacy_intc_node);
-	if (!pcie->legacy_irq_domain) {
+	pcie->intx_irq_domain = irq_domain_add_linear(intc_node,
+						      PCI_NUM_INTX,
+						      &intx_domain_ops,
+						      pcie);
+	of_node_put(intc_node);
+	if (!pcie->intx_irq_domain) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
@@ -710,14 +710,14 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	/* Enable all misc interrupts */
 	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
 
-	/* Disable all legacy interrupts */
+	/* Disable all INTX interrupts */
 	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
-	/* Clear pending legacy interrupts */
+	/* Clear pending INTX interrupts */
 	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
 			  MSGF_LEG_SR_MASKALL, MSGF_LEG_STATUS);
 
-	/* Enable all legacy interrupts */
+	/* Enable all INTX interrupts */
 	nwl_bridge_writel(pcie, MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
 	/* Enable the bridge config interrupt */
-- 
2.42.0


