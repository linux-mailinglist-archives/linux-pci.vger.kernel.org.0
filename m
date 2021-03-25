Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCEF348C14
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhCYJBJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:01:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38448 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhCYJBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:01:05 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P90ruQ101375;
        Thu, 25 Mar 2021 04:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616662853;
        bh=LsBbOgpn9yK/iqmtU3fLr5ApfDJFZK/ILo5OJkwkxvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i0PIQTKbQtCh19LDiaaPJqVpCAqOqcd5qB3gcu7YQk63Knu1JH0J8TXzDQDRnbSzd
         1oK+o7R06N5XfanmQI642ZQzQLszYYMjiHHMgBkLTlt/dnQROEAl8ax8/Ou4+wCsJx
         U0pG60S7xybNP7bui/ykkZYnlEke1Tu5SS+PXyGQ=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P90qKu018320
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:00:52 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:00:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:00:52 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P90RkC115556;
        Thu, 25 Mar 2021 04:00:49 -0500
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
Subject: [PATCH 5/6] PCI: keystone: Add PCI legacy interrupt support for AM654
Date:   Thu, 25 Mar 2021 14:30:25 +0530
Message-ID: <20210325090026.8843-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090026.8843-1-kishon@ti.com>
References: <20210325090026.8843-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI legacy interrupt support for AM654. AM654 has a single HW
interrupt line for all the four legacy interrupts INTA/INTB/INTC/INTD.
The HW interrupt line connected to GIC is a pulse interrupt whereas
the legacy interrupts by definition is level interrupt. In order to
provide level interrupt functionality to edge interrupt line, PCIe
in AM654 has provided IRQ_EOI register. When the SW writes to IRQ_EOI
register after handling the interrupt, the IP checks the state of
legacy interrupt and re-triggers pulse interrupt invoking the handler
again.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 87 +++++++++++++++++++++--
 1 file changed, 82 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index dfa9a7fcf9b7..84a25207d0d3 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -118,6 +118,7 @@ struct keystone_pcie {
 	/* PCI Device ID */
 	u32			device_id;
 	struct			device_node *legacy_intc_np;
+	struct irq_domain	*legacy_irq_domain;
 
 	int			msi_host_irq;
 	int			num_lanes;
@@ -289,6 +290,29 @@ static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 	return IRQ_HANDLED;
 }
 
+static void ks_pcie_am654_legacy_irq_handler(struct irq_desc *desc)
+{
+	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int virq, i;
+	u32 reg;
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(i));
+		if (!(reg & INTx_EN))
+			continue;
+
+		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, i);
+		generic_handle_irq(virq);
+		ks_pcie_app_writel(ks_pcie, IRQ_STATUS(i), INTx_EN);
+		ks_pcie_app_writel(ks_pcie, IRQ_EOI, i);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 void ks_pcie_irq_eoi(struct irq_data *data)
 {
 	struct keystone_pcie *ks_pcie = irq_data_get_irq_chip_data(data);
@@ -728,6 +752,54 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	return ret;
 }
 
+static int ks_pcie_am654_intx_map(struct irq_domain *domain, unsigned int irq,
+				  irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops ks_pcie_am654_irq_domain_ops = {
+	.map = ks_pcie_am654_intx_map,
+};
+
+static int ks_pcie_am654_config_legacy_irq(struct keystone_pcie *ks_pcie)
+{
+	struct device *dev = ks_pcie->pci->dev;
+	struct irq_domain *legacy_irq_domain;
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int ret = 0;
+	int irq;
+	int i;
+
+	intc_np = of_get_child_by_name(np, "interrupt-controller");
+	if (!intc_np) {
+		dev_warn(dev, "legacy interrupt-controller node is absent\n");
+		return -EINVAL;
+	}
+
+	irq = irq_of_parse_and_map(intc_np, 0);
+	if (!irq)
+		return -EINVAL;
+
+	irq_set_chained_handler_and_data(irq, ks_pcie_am654_legacy_irq_handler, ks_pcie);
+	legacy_irq_domain = irq_domain_add_linear(intc_np, PCI_NUM_INTX,
+						  &ks_pcie_am654_irq_domain_ops, ks_pcie);
+	if (!legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		return -EINVAL;
+	}
+	ks_pcie->legacy_irq_domain = legacy_irq_domain;
+
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
+
+	return ret;
+}
+
 static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 {
 	struct device *dev = ks_pcie->pci->dev;
@@ -835,12 +907,17 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	int ret;
 
 	pp->bridge->ops = &ks_pcie_ops;
-	if (!ks_pcie->is_am6)
-		pp->bridge->child_ops = &ks_child_pcie_ops;
 
-	ret = ks_pcie_config_legacy_irq(ks_pcie);
-	if (ret)
-		return ret;
+	if (!ks_pcie->is_am6) {
+		pp->bridge->child_ops = &ks_child_pcie_ops;
+		ret = ks_pcie_config_legacy_irq(ks_pcie);
+		if (ret)
+			return ret;
+	} else {
+		ret = ks_pcie_am654_config_legacy_irq(ks_pcie);
+		if (ret)
+			return ret;
+	}
 
 	ret = ks_pcie_config_msi_irq(ks_pcie);
 	if (ret)
-- 
2.17.1

