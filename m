Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3CD348C1D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhCYJBi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:01:38 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38456 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhCYJBH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:01:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90m7r101364;
        Thu, 25 Mar 2021 04:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662848;
        bh=J6jtWePejjvW4gTutyNyRw+iTzgvC5vll3IXt/fGGng=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=V2l6Pt/1L97FOFc0rLE/PyK0L9uO6+6yTt85rAyiBL3kOFOydhAhdrzYfEETEU++T
         w7FovlhfHEbnDZns2BnkrSRRXsrtQQdNw3qIZu/QSdcmDrf/E9zV7CZnHKdSikdXwV
         QkKUgbHZi9gHxAmAPQfv2ex0QJveceIXD/wrD+TA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90mJN054163
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:48 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:48 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90RkB115556;
        Thu, 25 Mar 2021 04:00:44 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/6] PCI: keystone: Convert to using hierarchy domain for legacy interrupts
Date:   Thu, 25 Mar 2021 14:30:24 +0530
Message-ID: <20210325090026.8843-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

K2G provides separate IRQ lines for each of the four legacy interrupts.
Model this using hierarchy domain instead of linear domain with chained
IRQ handler.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 214 ++++++++++++----------
 1 file changed, 120 insertions(+), 94 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 4de8c8e5e3f2..dfa9a7fcf9b7 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -69,6 +69,7 @@
 
 #define IRQ_STATUS(n)			(0x184 + ((n) << 4))
 #define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
+#define IRQ_ENABLE_CLR(n)		(0x18c + ((n) << 4))
 #define INTx_EN				BIT(0)
 
 #define ERR_IRQ_STATUS			0x1c4
@@ -116,7 +117,6 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
 	int			msi_host_irq;
@@ -125,7 +125,6 @@ struct keystone_pcie {
 	struct phy		**phy;
 	struct device_link	**link;
 	struct			device_node *msi_intc_np;
-	struct irq_domain	*legacy_irq_domain;
 	struct device_node	*np;
 
 	/* Application register space */
@@ -253,26 +252,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-				      int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 pending;
-	int virq;
-
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
-
-	/* EOI the INTx interrupt */
-	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
-}
-
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -310,39 +289,120 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
-static void ks_pcie_ack_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_eoi(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, hwirq);
+	irq_chip_eoi_parent(data);
 }
 
-static void ks_pcie_mask_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_enable(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(hwirq), INTx_EN);
+	irq_chip_enable_parent(data);
 }
 
-static void ks_pcie_unmask_legacy_irq(struct irq_data *d)
+void ks_pcie_irq_disable(struct irq_data *data)
 {
+	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
+	irq_hw_number_t hwirq = data->hwirq;
+
+	ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_CLR(hwirq), INTx_EN);
+	irq_chip_disable_parent(data);
 }
 
 static struct irq_chip ks_pcie_legacy_irq_chip = {
-	.name = "Keystone-PCI-Legacy-IRQ",
-	.irq_ack = ks_pcie_ack_legacy_irq,
-	.irq_mask = ks_pcie_mask_legacy_irq,
-	.irq_unmask = ks_pcie_unmask_legacy_irq,
+	.name			= "Keystone-PCI-Legacy-IRQ",
+	.irq_enable		= ks_pcie_irq_enable,
+	.irq_disable		= ks_pcie_irq_disable,
+	.irq_eoi		= ks_pcie_irq_eoi,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int ks_pcie_init_legacy_irq_map(struct irq_domain *d,
-				       unsigned int irq,
-				       irq_hw_number_t hw_irq)
+static int ks_pcie_legacy_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+					   unsigned int nr_irqs, void *data)
 {
-	irq_set_chip_and_handler(irq, &ks_pcie_legacy_irq_chip,
-				 handle_level_irq);
-	irq_set_chip_data(irq, d->host_data);
+	struct keystone_pcie *ks_pcie = domain->host_data;
+	struct device_node *np = ks_pcie->legacy_intc_np;
+	struct irq_fwspec parent_fwspec, *fwspec = data;
+	struct of_phandle_args out_irq;
+	int ret;
+
+	if (nr_irqs != 1)
+		return -EINVAL;
+
+	/*
+	 * Get the correct interrupt from legacy-interrupt-controller node
+	 * corresponding to INTA/INTB/INTC/INTD (passed in fwspec->param[0])
+	 * after performing mapping specified in "interrupt-map".
+	 * interrupt-map = <0 0 0 1 &pcie_intc0 0>, INTA (4th cell in
+	 * interrupt-map) corresponds to 1st entry in "interrupts" (6th cell
+	 * in interrupt-map)
+	 */
+	ret = of_irq_parse_one(np, fwspec->param[0], &out_irq);
+	if (ret < 0) {
+		pr_err("Failed to parse interrupt node\n");
+		return ret;
+	}
+
+	of_phandle_args_to_fwspec(np, out_irq.args, out_irq.args_count, &parent_fwspec);
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &parent_fwspec);
+	if (ret < 0) {
+		pr_err("Failed to allocate parent irq %u: %d\n",
+		       parent_fwspec.param[0], ret);
+		return ret;
+	}
+
+	ret = irq_domain_set_hwirq_and_chip(domain, virq, fwspec->param[0],
+					    &ks_pcie_legacy_irq_chip, ks_pcie);
+	if (ret < 0) {
+		pr_err("Failed to set hwirq and chip\n");
+		goto err_set_hwirq_and_chip;
+	}
 
 	return 0;
+
+err_set_hwirq_and_chip:
+	irq_domain_free_irqs_parent(domain, virq, 1);
+
+	return ret;
+}
+
+static int ks_pcie_irq_domain_translate(struct irq_domain *domain,
+					struct irq_fwspec *fwspec,
+					unsigned long *hwirq,
+					unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+
+		if (fwspec->param[0] >= PCI_NUM_INTX)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static const struct irq_domain_ops ks_pcie_legacy_irq_domain_ops = {
-	.map = ks_pcie_init_legacy_irq_map,
-	.xlate = irq_domain_xlate_onetwocell,
+	.alloc		= ks_pcie_legacy_irq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+	.translate	= ks_pcie_irq_domain_translate,
 };
 
 /**
@@ -614,35 +674,6 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-/**
- * ks_pcie_legacy_irq_handler() - Handle legacy interrupt
- * @irq: IRQ line for legacy interrupts
- * @desc: Pointer to irq descriptor
- *
- * Traverse through pending legacy interrupts and invoke handler for each. Also
- * takes care of interrupt controller level mask/ack operation.
- */
-static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
-{
-	unsigned int irq = irq_desc_get_irq(desc);
-	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
-
-	/*
-	 * The chained irq handler installation would have replaced normal
-	 * interrupt driver handler so we need to take care of mask/unmask and
-	 * ack operation.
-	 */
-	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
-	chained_irq_exit(chip, desc);
-}
-
 static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
@@ -702,20 +733,33 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct irq_domain *legacy_irq_domain;
 	struct device_node *np = ks_pcie->np;
+	struct irq_domain *parent_domain;
+	struct device_node *parent_node;
 	struct device_node *intc_np;
-	int irq_count, irq, ret = 0, i;
+	int irq_count, ret = 0;
 
-	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
+	intc_np = of_get_child_by_name(np, "interrupt-controller");
 	if (!intc_np) {
-		/*
-		 * Since legacy interrupts are modeled as edge-interrupts in
-		 * AM6, keep it disabled for now.
-		 */
-		if (ks_pcie->is_am6)
-			return 0;
 		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
+	ks_pcie->legacy_intc_np = intc_np;
+
+	parent_node = of_irq_find_parent(intc_np);
+	if (!parent_node) {
+		dev_err(dev, "unable to obtain parent node\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	parent_domain = irq_find_host(parent_node);
+	if (!parent_domain) {
+		dev_err(dev, "unable to obtain parent domain\n");
+		ret = -ENXIO;
+		goto err;
+	}
+
+	of_node_put(parent_node);
 
 	irq_count = of_irq_count(intc_np);
 	if (!irq_count) {
@@ -724,31 +768,13 @@ static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 		goto err;
 	}
 
-	for (i = 0; i < irq_count; i++) {
-		irq = irq_of_parse_and_map(intc_np, i);
-		if (!irq) {
-			ret = -EINVAL;
-			goto err;
-		}
-		ks_pcie->legacy_host_irqs[i] = irq;
-
-		irq_set_chained_handler_and_data(irq,
-						 ks_pcie_legacy_irq_handler,
-						 ks_pcie);
-	}
-
-	legacy_irq_domain =
-		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
-				      &ks_pcie_legacy_irq_domain_ops, NULL);
+	legacy_irq_domain = irq_domain_add_hierarchy(parent_domain, 0, PCI_NUM_INTX, intc_np,
+						     &ks_pcie_legacy_irq_domain_ops, ks_pcie);
 	if (!legacy_irq_domain) {
 		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
 		ret = -EINVAL;
 		goto err;
 	}
-	ks_pcie->legacy_irq_domain = legacy_irq_domain;
-
-	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
 
 err:
 	of_node_put(intc_np);
-- 
2.17.1

