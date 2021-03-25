Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EEA348C53
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCYJKr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:10:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51592 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhCYJKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:10:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12P99vQt038694;
        Thu, 25 Mar 2021 04:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616663397;
        bh=i1QO3cXscawukFnZk+rxAD8rp1QcwTFCVuPFVnjTRc4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=tktTKyuJDQ+ghoWIIoRgDxDPGOVTMJ/GpbrTVmY/WKpe+Nm3b9Ux43f0omZljVUXj
         K2v5TjTgBV/Mpkclby0f/u3RhiAkFTzDx+t3s7Z6qtbFL6sJ2jKs51QLv9RkQuntf6
         cRnEguvcAEp5+iI+TUnlcEJ0hBohFdS5qzVRIJD4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12P99vtW022911
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Mar 2021 04:09:57 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 25
 Mar 2021 04:09:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 25 Mar 2021 04:09:56 -0500
Received: from a0393678-ssd.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12P99bA0078373;
        Thu, 25 Mar 2021 04:09:52 -0500
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
Subject: [PATCH 3/4] PCI: j721e: Add PCIe support for j7200
Date:   Thu, 25 Mar 2021 14:39:35 +0530
Message-ID: <20210325090936.9306-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210325090936.9306-1-kishon@ti.com>
References: <20210325090936.9306-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

J7200 has the same PCIe IP as in J721E with minor changes in the
wrapper. Add PCIe support for j7200 accounting for the wrapper
changes in pci-j721e.c
Changes from J721E:
 *) Allows byte access of bridge configuration space registers
 *) Changes in legacy interrupt register map

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 111 ++++++++++++++++++---
 1 file changed, 99 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 17db86a51ca8..f175f116abf6 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -27,6 +27,7 @@
 #define STATUS_REG_SYS_2	0x508
 #define STATUS_CLR_REG_SYS_2	0x708
 #define LINK_DOWN		BIT(1)
+#define J7200_LINK_DOWN		BIT(10)
 
 #define EOI_REG			0x10
 
@@ -35,6 +36,10 @@
 #define STATUS_CLR_REG_SYS_0	0x700
 #define INTx_EN(num)		(1 << (num))
 
+#define ENABLE_REG_SYS_1	0x104
+#define STATUS_REG_SYS_1	0x504
+#define SYS1_INTx_EN(num)	(1 << (22 + (num)))
+
 #define J721E_PCIE_USER_CMD_STATUS	0x4
 #define LINK_TRAINING_ENABLE		BIT(0)
 
@@ -48,6 +53,14 @@ enum link_status {
 	LINK_UP_DL_COMPLETED,
 };
 
+#define USER_EOI_REG		0xC8
+enum eoi_reg {
+	EOI_DOWNSTREAM_INTERRUPT,
+	EOI_FLR_INTERRUPT,
+	EOI_LEGACY_INTERRUPT,
+	EOI_POWER_STATE_INTERRUPT,
+};
+
 #define J721E_MODE_RC			BIT(7)
 #define LANE_COUNT_MASK			BIT(8)
 #define LANE_COUNT(n)			((n) << 8)
@@ -65,6 +78,8 @@ struct j721e_pcie {
 	void __iomem		*user_cfg_base;
 	void __iomem		*intd_cfg_base;
 	struct irq_domain	*legacy_irq_domain;
+	bool			is_intc_v1;
+	u32			link_irq_reg_field;
 };
 
 enum j721e_pcie_mode {
@@ -75,6 +90,9 @@ enum j721e_pcie_mode {
 struct j721e_pcie_data {
 	enum j721e_pcie_mode	mode;
 	bool quirk_retrain_flag;
+	bool			is_intc_v1;
+	bool			byte_access_allowed;
+	const struct cdns_pcie_ops *ops;
 };
 
 static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
@@ -106,12 +124,12 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 	u32 reg;
 
 	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
-	if (!(reg & LINK_DOWN))
+	if (!(reg & pcie->link_irq_reg_field))
 		return IRQ_NONE;
 
 	dev_err(dev, "LINK DOWN!\n");
 
-	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
+	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, pcie->link_irq_reg_field);
 	return IRQ_HANDLED;
 }
 
@@ -119,12 +137,40 @@ static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 {
 	u32 reg;
 
+	pcie->link_irq_reg_field = J7200_LINK_DOWN;
+	if (pcie->is_intc_v1)
+		pcie->link_irq_reg_field = LINK_DOWN;
+
 	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
-	reg |= LINK_DOWN;
+	reg |= pcie->link_irq_reg_field;
 	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
 }
 
 static void j721e_pcie_legacy_irq_handler(struct irq_desc *desc)
+{
+	struct j721e_pcie *pcie = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	int virq;
+	u32 reg;
+	int i;
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
+		j721e_pcie_user_writel(pcie, USER_EOI_REG,
+				       EOI_LEGACY_INTERRUPT);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void j721e_pcie_v1_legacy_irq_handler(struct irq_desc *desc)
 {
 	int i;
 	u32 reg;
@@ -182,8 +228,14 @@ static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
 		dev_err(dev, "Failed to parse and map legacy irq\n");
 		return -EINVAL;
 	}
-	irq_set_chained_handler_and_data(irq, j721e_pcie_legacy_irq_handler,
-					 pcie);
+
+	if (pcie->is_intc_v1) {
+		irq_set_chained_handler_and_data(irq, j721e_pcie_v1_legacy_irq_handler,
+						 pcie);
+	} else {
+		irq_set_chained_handler_and_data(irq, j721e_pcie_legacy_irq_handler,
+						 pcie);
+	}
 
 	legacy_irq_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
 						  &j721e_pcie_intx_domain_ops,
@@ -194,10 +246,18 @@ static int j721e_pcie_config_legacy_irq(struct j721e_pcie *pcie)
 	}
 	pcie->legacy_irq_domain = legacy_irq_domain;
 
-	for (i = 0; i < PCI_NUM_INTX; i++) {
-		reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
-		reg |= INTx_EN(i);
-		j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
+	if (pcie->is_intc_v1) {
+		for (i = 0; i < PCI_NUM_INTX; i++) {
+			reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_0);
+			reg |= INTx_EN(i);
+			j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_0, reg);
+		}
+	} else {
+		for (i = 0; i < PCI_NUM_INTX; i++) {
+			reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_1);
+			reg |= SYS1_INTx_EN(i);
+			j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_1, reg);
+		}
 	}
 
 	return 0;
@@ -244,6 +304,12 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.link_up = j721e_pcie_link_up,
 };
 
+static const struct cdns_pcie_ops j7200_pcie_ops = {
+	.start_link = j721e_pcie_start_link,
+	.stop_link = j721e_pcie_stop_link,
+	.link_up = j721e_pcie_link_up,
+};
+
 static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 			       unsigned int offset)
 {
@@ -371,10 +437,21 @@ static struct pci_ops cdns_ti_pcie_host_ops = {
 static const struct j721e_pcie_data j721e_pcie_rc_data = {
 	.mode = PCI_MODE_RC,
 	.quirk_retrain_flag = true,
+	.is_intc_v1 = true,
+	.byte_access_allowed = false,
+	.ops = &j721e_pcie_ops,
 };
 
 static const struct j721e_pcie_data j721e_pcie_ep_data = {
 	.mode = PCI_MODE_EP,
+	.ops = &j721e_pcie_ops,
+};
+
+static const struct j721e_pcie_data j7200_pcie_rc_data = {
+	.mode = PCI_MODE_RC,
+	.is_intc_v1 = false,
+	.byte_access_allowed = true,
+	.ops = &j7200_pcie_ops,
 };
 
 static const struct of_device_id of_j721e_pcie_match[] = {
@@ -386,6 +463,10 @@ static const struct of_device_id of_j721e_pcie_match[] = {
 		.compatible = "ti,j721e-pcie-ep",
 		.data = &j721e_pcie_ep_data,
 	},
+	{
+		.compatible = "ti,j7200-pcie-host",
+		.data = &j7200_pcie_rc_data,
+	},
 	{},
 };
 
@@ -393,9 +474,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	const struct cdns_pcie_ops *ops;
 	struct pci_host_bridge *bridge;
 	struct j721e_pcie_data *data;
 	struct cdns_pcie *cdns_pcie;
+	bool byte_access_allowed;
 	struct j721e_pcie *pcie;
 	struct cdns_pcie_rc *rc;
 	struct cdns_pcie_ep *ep;
@@ -412,6 +495,8 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	mode = (u32)data->mode;
+	byte_access_allowed = data->byte_access_allowed;
+	ops = data->ops;
 
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
@@ -419,6 +504,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	pcie->dev = dev;
 	pcie->mode = mode;
+	pcie->is_intc_v1 = data->is_intc_v1;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
 	if (IS_ERR(base))
@@ -482,13 +568,14 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		bridge->ops = &cdns_ti_pcie_host_ops;
+		if (!byte_access_allowed)
+			bridge->ops = &cdns_ti_pcie_host_ops;
 		rc = pci_host_bridge_priv(bridge);
 		rc->quirk_retrain_flag = data->quirk_retrain_flag;
 
 		cdns_pcie = &rc->pcie;
 		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
+		cdns_pcie->ops = ops;
 		pcie->cdns_pcie = cdns_pcie;
 
 		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
@@ -552,7 +639,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 		cdns_pcie = &ep->pcie;
 		cdns_pcie->dev = dev;
-		cdns_pcie->ops = &j721e_pcie_ops;
+		cdns_pcie->ops = ops;
 		pcie->cdns_pcie = cdns_pcie;
 
 		ret = cdns_pcie_init_phy(dev, cdns_pcie);
-- 
2.17.1

