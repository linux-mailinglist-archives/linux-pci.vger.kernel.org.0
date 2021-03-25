Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DDE348C50
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCYJKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:10:46 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40468 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhCYJKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:10:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P99qXE104779;
        Thu, 25 Mar 2021 04:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616663392;
        bh=r0svPmuI2QaSe9vWLMxAjahbDeP9jzCVWUl33+1rTno=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DcBuGUGVu7429fazwJXWf4qnOHebMgdw3KEkLoKeVFAxP2ElpbbeCVH1r1iO8ZV3D
         nvZW6auNgYKP7O1RTgtSHeEK2/02F9Jbnh4jLA3uM7DTgWbF40bRxSic3zQuwom6qE
         iilXV7ilq+aNywhC0GLJnBQGgbvw8MSqWcudoPds=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P99qSO008018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:09:52 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:09:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:09:52 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P99b9x078373;
        Thu, 25 Mar 2021 04:09:48 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] PCI: j721e: Add PCI legacy interrupt support for J721E
Date:   Thu, 25 Mar 2021 14:39:34 +0530
Message-ID: <20210325090936.9306-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090936.9306-1-kishon@ti.com>
References: <20210325090936.9306-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI legacy interrupt support for J721E. J721E has a single HW
interrupt line for all the four legacy interrupts INTA/INTB/INTC/INTD.
The HW interrupt line connected to GIC is a pulse interrupt whereas
the legacy interrupts by definition is level interrupt. In order to
provide level interrupt functionality to edge interrupt line, PCIe
in J721E has provided IRQ_EOI register. When the SW writes to IRQ_EOI
register after handling the interrupt, the IP checks the state of
legacy interrupt and re-triggers pulse interrupt invoking the handler
again.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 91 ++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 0382bb15c6f9..17db86a51ca8 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -28,6 +28,13 @@
 #define STATUS_CLR_REG_SYS_2	0x708
 #define LINK_DOWN		BIT(1)
 
+#define EOI_REG			0x10
+
+#define ENABLE_REG_SYS_0	0x100
+#define STATUS_REG_SYS_0	0x500
+#define STATUS_CLR_REG_SYS_0	0x700
+#define INTx_EN(num)		(1 << (num))
+
 #define J721E_PCIE_USER_CMD_STATUS	0x4
 #define LINK_TRAINING_ENABLE		BIT(0)
 
@@ -57,6 +64,7 @@ struct j721e_pcie {
 	struct cdns_pcie	*cdns_pcie;
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
+	struct irq_domain	*legacy_irq_domain;
 };
 
 enum j721e_pcie_mode {
@@ -116,6 +124,85 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
+static void j721e_pcie_legacy_irq_handler(struct irq_desc *desc)
+{
+	int i;
+	u32 reg;
+	int virq;
+	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_0);
+		if (!(reg & INTx_EN(i)))
+			continue;
+
+	virq = irq_find_mapping(pcie->legacy_irq_domain, 3 - i);
+		generic_handle_irq(virq);
+		j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_0, INTx_EN(i));
+		j721e_pcie_intd_writel(pcie, EOI_REG, 3 - i);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static int j721e_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops j721e_pcie_intx_domain_ops = {
+	.map = j721e_pcie_intx_map,
+};
+
+static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct irq_domain *legacy_irq_domain;
+	struct device_node *node = dev->of_node;
+	struct device_node *intc_node;
+	int irq;
+	u32 reg;
+	int i;
+
+	intc_node = of_get_child_by_name(node, "interrupt-controller");
+	if (!intc_node) {
+		dev_WARN(dev, "legacy-interrupt-controller node is absent\n");
+		return -EINVAL;
+	}
+
+	irq = irq_of_parse_and_map(intc_node, 0);
+	if (!irq) {
+		dev_err(dev, "Failed to parse and map legacy irq\n");
+		return -EINVAL;
+	}
+	irq_set_chained_handler_and_data(irq, j721e_pcie_legacy_irq_handler,
+					 pcie);
+
+	legacy_irq_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
+						  &j721e_pcie_intx_domain_ops,
+						  NULL);
+	if (!legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		return -EINVAL;
+	}
+	pcie->legacy_irq_domain = legacy_irq_domain;
+
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
+		reg |= INTx_EN(i);
+		j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
+	}
+
+	return 0;
+}
+
 static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie)
 {
 	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
@@ -385,6 +472,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
+		ret = j721e_pcie_config_legacy_irq(pcie);
+		if (ret < 0)
+			goto err_get_sync;
+
 		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
 		if (!bridge) {
 			ret = -ENOMEM;
-- 
2.17.1

