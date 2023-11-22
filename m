Return-Path: <linux-pci+bounces-95-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 338ED7F3DE0
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 07:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD95B21792
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC957156F9;
	Wed, 22 Nov 2023 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4CZahGA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47314156D9
	for <linux-pci@vger.kernel.org>; Wed, 22 Nov 2023 06:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B09EC433CA;
	Wed, 22 Nov 2023 06:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700633066;
	bh=XZWGqu5D0eJGZebAfOTH32NcAzHpXo0BguCCqzhtZtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h4CZahGAgNjFkGFYaFf8k9sW/TcYMNFnoe3EBebRMhIiQD1qAZtkaBN8zpjAzwodm
	 mGWRgzGc5zhGZpp0nhIIrVYrRSAr+qZtter+T/t9g3tzA7gzN7cXJpBbr+Bg4BeBL0
	 KAED/H7k4nV/HjkvbvubewjFB1rBysO8QbpfJWuD/KQunRQJC4uhvYXDJ7rhJniPtQ
	 137v2Xu6im+7HruVCAE/CE9uQ/HZ8sxMeIKujHpsIzj1KCRyEgXfpogeJIVHINhH5j
	 DzwZmSgNkIITH7tFOUlIZxfQ/OVMuI3LRSeJ7G3RCT4tClb5z3cVrV5avm5BBuvmmq
	 sa1JRbrKa97fA==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 10/16] PCI: keystone: Use INTX instead of legacy
Date: Wed, 22 Nov 2023 15:04:00 +0900
Message-ID: <20231122060406.14695-11-dlemoal@kernel.org>
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

In the Keystone controller driver, change all names using "legacy" to
use "intx" instead, to match the term used in the PCI specifications.
Given that the field legacy_intc_np of struct keystone_pcie is unused,
this field is removed instead of being renamed.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 77 +++++++++++------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 84f6a4acee07..9186da7a1620 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -115,8 +115,7 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			legacy_host_irqs[PCI_NUM_INTX];
-	struct			device_node *legacy_intc_np;
+	int			intx_host_irqs[PCI_NUM_INTX];
 
 	int			msi_host_irq;
 	int			num_lanes;
@@ -124,7 +123,7 @@ struct keystone_pcie {
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
-	struct irq_domain	*legacy_irq_domain;
+	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
 
 	/* Application register space */
@@ -252,8 +251,8 @@ static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-				      int offset)
+static void ks_pcie_handle_intx_irq(struct keystone_pcie *ks_pcie,
+				    int offset)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
@@ -263,7 +262,7 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 
 	if (BIT(0) & pending) {
 		dev_dbg(dev, ": irq: irq_offset %d", offset);
-		generic_handle_domain_irq(ks_pcie->legacy_irq_domain, offset);
+		generic_handle_domain_irq(ks_pcie->intx_irq_domain, offset);
 	}
 
 	/* EOI the INTx interrupt */
@@ -307,38 +306,37 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_pcie_ack_legacy_irq(struct irq_data *d)
+static void ks_pcie_ack_intx_irq(struct irq_data *d)
 {
 }
 
-static void ks_pcie_mask_legacy_irq(struct irq_data *d)
+static void ks_pcie_mask_intx_irq(struct irq_data *d)
 {
 }
 
-static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
+static void ks_pcie_unmask_intx_irq(struct irq_data *d)
 {
 }
 
-static struct irq_chip ks_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_pcie_ack_legacy_irq,
-	.irq_mask = ks_pcie_mask_legacy_irq,
-	.irq_unmask = ks_pcie_unmask_legacy_irq,
+static struct irq_chip ks_pcie_intx_irq_chip = {
+	.name = "Keystone-PCI-INTX-IRQ",
+	.irq_ack = ks_pcie_ack_intx_irq,
+	.irq_mask = ks_pcie_mask_intx_irq,
+	.irq_unmask = ks_pcie_unmask_intx_irq,
 };
 
-static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
-				       unsigned int irq,
-				       irq_hw_number_t hw_irq)
+static int ks_pcie_init_intx_irq_map(struct irq_domain *d,
+				     unsigned int irq, irq_hw_number_t hw_irq)
 {
-	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
+	irq_set_chip_and_handler(irq, &ks_pcie_intx_irq_chip,
 				 handle_level_irq);
 	irq_set_chip_data(irq, d->host_data);
 
 	return 0;
 }
 
-static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
-	.map = ks_pcie_init_legacy_irq_map,
+static const struct irq_domain_ops ks_pcie_intx_irq_domain_ops = {
+	.map = ks_pcie_init_intx_irq_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
@@ -605,22 +603,22 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 }
 
 /**
- * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
+ * ks_pcie_intx_irq_handler() - Handle INTX interrupt
  * @desc: Pointer to irq descriptor
  *
- * Traverse through pending legacy interrupts and invoke handler for each. Also
+ * Traverse through pending INTX interrupts and invoke handler for each. Also
  * takes care of interrupt controller level mask/ack operation.
  */
-static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
+static void ks_pcie_intx_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
+	u32 irq_offset = irq - ks_pcie->intx_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
-	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
+	dev_dbg(dev, ": Handling INTX irq %d\n", irq);
 
 	/*
 	 * The chained irq handler installation would have replaced normal
@@ -628,7 +626,7 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+	ks_pcie_handle_intx_irq(ks_pcie, irq_offset);
 	chained_irq_exit(chip, desc);
 }
 
@@ -686,10 +684,10 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
-static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
+static int ks_pcie_config_intx_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
-	struct irq_domain *legacy_irq_domain;
+	struct irq_domain *intx_irq_domain;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
 	int irq_count, irq, ret = 0, i;
@@ -697,7 +695,7 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
 	if (!intc_np) {
 		/*
-		 * Since legacy interrupts are modeled as edge-interrupts in
+		 * Since INTX interrupts are modeled as edge-interrupts in
 		 * AM6, keep it disabled for now.
 		 */
 		if (ks_pcie->is_am6)
@@ -719,22 +717,21 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 			ret = -EINVAL;
 			goto err;
 		}
-		ks_pcie->legacy_host_irqs[i] = irq;
+		ks_pcie->intx_host_irqs[i] = irq;
 
 		irq_set_chained_handler_and_data(irq,
-						 ks_pcie_legacy_irq_handler,
+						 ks_pcie_intx_irq_handler,
 						 ks_pcie);
 	}
 
-	legacy_irq_domain =
-		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
-				      &ks_pcie_legacy_irq_domain_ops, NULL);
-	if (!legacy_irq_domain) {
-		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+	intx_irq_domain = irq_domain_add_linear(intc_np, PCI_NUM_INTX,
+					&ks_pcie_intx_irq_domain_ops, NULL);
+	if (!intx_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for INTX irqs\n");
 		ret = -EINVAL;
 		goto err;
 	}
-	ks_pcie->legacy_irq_domain = legacy_irq_domain;
+	ks_pcie->intx_irq_domain = intx_irq_domain;
 
 	for (i = 0; i < PCI_NUM_INTX; i++)
 		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
@@ -808,7 +805,7 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	if (!ks_pcie->is_am6)
 		pp->bridge->child_ops = &ks_child_pcie_ops;
 
-	ret = ks_pcie_config_legacy_irq(ks_pcie);
+	ret = ks_pcie_config_intx_irq(ks_pcie);
 	if (ret)
 		return ret;
 
@@ -881,7 +878,7 @@ static void ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, flags);
 }
 
-static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
+static void ks_pcie_am654_raise_intx_irq(struct keystone_pcie *ks_pcie)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	u8 int_pin;
@@ -907,7 +904,7 @@ static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 	switch (type) {
 	case PCI_IRQ_INTX:
-		ks_pcie_am654_raise_legacy_irq(ks_pcie);
+		ks_pcie_am654_raise_intx_irq(ks_pcie);
 		break;
 	case PCI_IRQ_MSI:
 		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
-- 
2.42.0


