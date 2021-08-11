Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15F63E91B0
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 14:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhHKMjd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 08:39:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55362 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhHKMjb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 08:39:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 17BCd0BS018060;
        Wed, 11 Aug 2021 07:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628685540;
        bh=oik4GnEIkEmZ9D1i+/AJF0jdOo3E9UKHSjJq6+bgAgM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZJPobtay5fhr+ZYnYFm9KZkOOuQmpMCZfgUJq8Y7h27IS1DdSFBsTc37u93btEr+Z
         4Y/j8JIvAYtx5EqbUaqMlBB+Pb5YMNE6xCP33+c1zzaa7cTGdJfwkmq3iJvkAnlCpk
         xWW3Wsl/KSsesEks9LUXhqpMWFwpAllvWraF0SG8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 17BCd0gQ018463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Aug 2021 07:39:00 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 11
 Aug 2021 07:38:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 11 Aug 2021 07:38:59 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 17BCckL1053470;
        Wed, 11 Aug 2021 07:38:56 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>, <kishon@ti.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/2] PCI: j721e: Add PCI legacy interrupt support for J7200
Date:   Wed, 11 Aug 2021 18:08:46 +0530
Message-ID: <20210811123846.31921-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210811123846.31921-1-kishon@ti.com>
References: <20210811123846.31921-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI legacy interrupt support for J7200. J7200 has a single HW
interrupt line for all the four legacy interrupts INTA/INTB/INTC/INTD.
The HW interrupt line connected to GIC is a pulse interrupt whereas
the legacy interrupts by definition is level interrupt. In order to
provide level interrupt functionality to edge interrupt line, PCIe
in J7200 has provided USER_EOI_REG register. When the SW writes to
USER_EOI_REG register after handling the interrupt, the IP checks the
state of legacy interrupt and re-triggers pulse interrupt invoking
the handler again.

Due to Errata ID #i2094 ([1]), EOI feature is not enabled in J721E
and only a single pulse interrupt will be generated for every
ASSERT_INTx/DEASSERT_INTx. Hence legacy interrupt is not enabled in
J721E.

[1] -> J721E DRA829/TDA4VM Processors Silicon Revision 1.1/1.0 SPRZ455A –
       DECEMBER 2020 – REVISED AUGUST 2021
       (https://www.ti.com/lit/er/sprz455a/sprz455a.pdf)

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 119 +++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ffb176d288cd..4e786d6b89e0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -29,12 +29,24 @@
 #define LINK_DOWN		BIT(1)
 #define J7200_LINK_DOWN		BIT(10)
 
+#define ENABLE_REG_SYS_1	0x104
+#define STATUS_REG_SYS_1	0x504
+#define SYS1_INTx_EN(num)	(1 << (22 + (num)))
+
 #define J721E_PCIE_USER_CMD_STATUS	0x4
 #define LINK_TRAINING_ENABLE		BIT(0)
 
 #define J721E_PCIE_USER_LINKSTATUS	0x14
 #define LINK_STATUS			GENMASK(1, 0)
 
+#define USER_EOI_REG		0xC8
+enum eoi_reg {
+	EOI_DOWNSTREAM_INTERRUPT,
+	EOI_FLR_INTERRUPT,
+	EOI_LEGACY_INTERRUPT,
+	EOI_POWER_STATE_INTERRUPT,
+};
+
 enum link_status {
 	NO_RECEIVERS_DETECTED,
 	LINK_TRAINING_IN_PROGRESS,
@@ -59,6 +71,7 @@ struct j721e_pcie {
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
+	struct irq_domain	*legacy_irq_domain;
 };
 
 enum j721e_pcie_mode {
@@ -121,6 +134,108 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
+static void j721e_pcie_legacy_irq_handler(struct irq_desc *desc)
+{
+	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int i, virq;
+	u32 reg;
+
+	chained_irq_enter(chip, desc);
+
+	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_1);
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		if (!(reg & SYS1_INTx_EN(i)))
+			continue;
+
+		virq = irq_find_mapping(pcie->legacy_irq_domain, i);
+		generic_handle_irq(virq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void j721e_pcie_irq_eoi(struct irq_data *data)
+{
+	struct j721e_pcie *pcie = irq_data_get_irq_chip_data(data);
+
+	j721e_pcie_user_writel(pcie, USER_EOI_REG, EOI_LEGACY_INTERRUPT);
+}
+
+static void j721e_pcie_irq_enable(struct irq_data *data)
+{
+	struct j721e_pcie *pcie = irq_data_get_irq_chip_data(data);
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_1);
+	reg |= SYS1_INTx_EN(irqd_to_hwirq(data));
+	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_1, reg);
+}
+
+static void j721e_pcie_irq_disable(struct irq_data *data)
+{
+	struct j721e_pcie *pcie = irq_data_get_irq_chip_data(data);
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_1);
+	reg &= ~SYS1_INTx_EN(irqd_to_hwirq(data));
+	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_1, reg);
+}
+
+struct irq_chip j721e_pcie_irq_chip = {
+	.name		= "J721E-PCIE-INTX",
+	.irq_eoi	= j721e_pcie_irq_eoi,
+	.irq_enable	= j721e_pcie_irq_enable,
+	.irq_disable	= j721e_pcie_irq_disable,
+};
+
+static int j721e_pcie_intx_map(struct irq_domain *domain, unsigned int irq, irq_hw_number_t hwirq)
+{
+	struct j721e_pcie *pcie = domain->host_data;
+
+	irq_set_chip_and_handler(irq, &j721e_pcie_irq_chip, handle_fasteoi_irq);
+	irq_set_chip_data(irq, pcie);
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
+	struct irq_domain *legacy_irq_domain;
+	struct device *dev = pcie->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *intc_node;
+	int irq;
+
+	intc_node = of_get_child_by_name(node, "interrupt-controller");
+	if (!intc_node) {
+		dev_dbg(dev, "interrupt-controller node is absent. Legacy INTR not supported\n");
+		return 0;
+	}
+
+	irq = irq_of_parse_and_map(intc_node, 0);
+	if (!irq) {
+		dev_err(dev, "Failed to parse and map legacy irq\n");
+		return -EINVAL;
+	}
+
+	irq_set_chained_handler_and_data(irq, j721e_pcie_legacy_irq_handler, pcie);
+
+	legacy_irq_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
+						  &j721e_pcie_intx_domain_ops, pcie);
+	if (!legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		return -EINVAL;
+	}
+	pcie->legacy_irq_domain = legacy_irq_domain;
+
+	return 0;
+}
+
 static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie)
 {
 	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
@@ -433,6 +548,10 @@ static int j721e_pcie_probe(struct platform_device *pdev)
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

