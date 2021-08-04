Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D6D3E0203
	for <lists+linux-pci@lfdr.de>; Wed,  4 Aug 2021 15:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhHDN3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Aug 2021 09:29:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35812 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbhHDN3v (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Aug 2021 09:29:51 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 174DTT1f078820;
        Wed, 4 Aug 2021 08:29:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1628083769;
        bh=UNpzqR1BnPqUXbO09yo+DXjPcbQ13PXmdG4EOMi6q7M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=a5YrNv528Kzn7D3GbQk8xtsafrkfU76KtMdFNqEazbfZqy8pqu0zxNz5cd1EUT0gn
         QyXczIisuycHk32BOInrz6cOX1axTqge+IxxLVKLm3Kyzf7FxYfNK/k4xXHKBtX0u2
         SsZDhKxBkwNrCUnWLIW1rN7hKxSsxfCCSL2A0l2A=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 174DTTFu041062
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Aug 2021 08:29:29 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 4 Aug
 2021 08:29:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 4 Aug 2021 08:29:28 -0500
Received: from a0393678-ssd.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 174DTDpg029237;
        Wed, 4 Aug 2021 08:29:25 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Tom Joseph <tjoseph@cadence.com>, <linux-omap@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/3] PCI: j721e: Add PCI legacy interrupt support for J7200
Date:   Wed, 4 Aug 2021 18:59:12 +0530
Message-ID: <20210804132912.30685-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210804132912.30685-1-kishon@ti.com>
References: <20210804132912.30685-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
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
the handler again. (Note that the errata in J721E where EOI is not
implemented is fixed in J7200).

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 77 ++++++++++++++++++++--
 1 file changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index c2e7a78dc31f..be8464232be0 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -36,12 +36,24 @@
 #define STATUS_CLR_REG_SYS_0	0x700
 #define INTx_EN(num)		(1 << (num))
 
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
@@ -67,6 +79,7 @@ struct j721e_pcie {
 	void __iomem		*intd_cfg_base;
 	u32			linkdown_irq_regfield;
 	struct irq_domain	*legacy_irq_domain;
+	unsigned int		is_intc_v1:1;
 };
 
 enum j721e_pcie_mode {
@@ -76,6 +89,7 @@ enum j721e_pcie_mode {
 
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
+	unsigned int		is_intc_v1:1;
 	unsigned int		quirk_retrain_flag:1;
 	unsigned int		quirk_detect_quiet_flag:1;
 	u32			linkdown_irq_regfield;
@@ -129,6 +143,39 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
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
+	for (i = 0; i < PCI_NUM_INTX; i++) {
+		reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_1);
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
+struct irq_chip j721e_pcie_irq_chip = {
+	.name		= "J721E-PCIE-INTX",
+	.irq_eoi	= j721e_pcie_irq_eoi,
+};
+
 static void j721e_pcie_v1_legacy_irq_handler(struct irq_desc *desc)
 {
 	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
@@ -153,8 +200,14 @@ static void j721e_pcie_v1_legacy_irq_handler(struct irq_desc *desc)
 
 static int j721e_pcie_intx_map(struct irq_domain *domain, unsigned int irq, irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
-	irq_set_chip_data(irq, domain->host_data);
+	struct j721e_pcie *pcie = domain->host_data;
+
+	if (pcie->is_intc_v1)
+		irq_set_chip_and_handler(irq, &dummy_irq_chip, handle_simple_irq);
+	else
+		irq_set_chip_and_handler(irq, &j721e_pcie_irq_chip, handle_fasteoi_irq);
+
+	irq_set_chip_data(irq, pcie);
 
 	return 0;
 }
@@ -183,7 +236,11 @@ static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
 		dev_err(dev, "Failed to parse and map legacy irq\n");
 		return -EINVAL;
 	}
-	irq_set_chained_handler_and_data(irq, j721e_pcie_v1_legacy_irq_handler, pcie);
+
+	if (pcie->is_intc_v1)
+		irq_set_chained_handler_and_data(irq, j721e_pcie_v1_legacy_irq_handler, pcie);
+	else
+		irq_set_chained_handler_and_data(irq, j721e_pcie_legacy_irq_handler, pcie);
 
 	legacy_irq_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
 						  &j721e_pcie_intx_domain_ops, pcie);
@@ -194,9 +251,15 @@ static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
 	pcie->legacy_irq_domain = legacy_irq_domain;
 
 	for (i = 0; i < PCI_NUM_INTX; i++) {
-		reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
-		reg |= INTx_EN(i);
-		j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
+		if (pcie->is_intc_v1) {
+			reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
+			reg |= INTx_EN(i);
+			j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
+		} else {
+			reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_1);
+			reg |= SYS1_INTx_EN(i);
+			j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_1, reg);
+		}
 	}
 
 	return 0;
@@ -372,6 +435,7 @@ static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.quirk_retrain_flag = true,
 	.byte_access_allowed = false,
 	.linkdown_irq_regfield = LINK_DOWN,
+	.is_intc_v1 = true,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
@@ -514,6 +578,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
+		pcie->is_intc_v1 = data->is_intc_v1;
 		ret = j721e_pcie_config_legacy_irq(pcie);
 		if (ret < 0)
 			goto err_get_sync;
-- 
2.17.1

