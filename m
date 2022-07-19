Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B9B57971D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 12:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237477AbiGSKBq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237442AbiGSKBh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 06:01:37 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6B33E2D;
        Tue, 19 Jul 2022 03:01:26 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EFA78200C3B;
        Tue, 19 Jul 2022 12:01:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6F896200C38;
        Tue, 19 Jul 2022 12:01:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 00973180222C;
        Tue, 19 Jul 2022 18:01:22 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 09/10] PCI: imx6: Add iMX8MM PCIe EP mode
Date:   Tue, 19 Jul 2022 17:45:38 +0800
Message-Id: <1658223939-25478-10-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com>
References: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Based on i.MX8MM platforms, add the i.MX8MM PCIe EP mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 148 +++++++++++++++++++++++---
 1 file changed, 134 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 655240ce60e0..ba4ac258c13d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -51,6 +51,7 @@ enum imx6_pcie_variants {
 	IMX7D,
 	IMX8MQ,
 	IMX8MM,
+	IMX8MM_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -59,6 +60,7 @@ enum imx6_pcie_variants {
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
 };
@@ -150,23 +152,27 @@ struct imx6_pcie {
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MM);
+		imx6_pcie->drvdata->variant != IMX8MM &&
+		imx6_pcie->drvdata->variant != IMX8MM_EP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val;
+	unsigned int mask, val, mode;
+
+	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		mode = PCI_EXP_TYPE_ENDPOINT;
+	else
+		mode = PCI_EXP_TYPE_ROOT_PORT;
 
 	if (imx6_pcie->drvdata->variant == IMX8MQ &&
 	    imx6_pcie->controller_id == 1) {
 		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
+		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE, mode);
 	} else {
 		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
+		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
 	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
@@ -301,6 +307,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MM:
+	case IMX8MM_EP:
 		/*
 		 * The PHY initialization had been done in the PHY
 		 * driver, break here directly.
@@ -557,6 +564,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MQ:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
@@ -601,6 +609,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MQ:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
@@ -669,6 +678,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
+	case IMX8MM_EP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
@@ -744,6 +754,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX6Q:		/* Nothing to do */
 	case IMX8MM:
+	case IMX8MM_EP:
 		break;
 	}
 
@@ -793,6 +804,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	case IMX7D:
 	case IMX8MQ:
 	case IMX8MM:
+	case IMX8MM_EP:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -812,6 +824,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	case IMX7D:
 	case IMX8MQ:
 	case IMX8MM:
+	case IMX8MM_EP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -992,8 +1005,102 @@ static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx6_pcie_start_link,
+	.stop_link = imx6_pcie_stop_link,
 };
 
+static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	enum pci_barno bar;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features imx8m_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
+	.align = SZ_64K,
+};
+
+static const struct pci_epc_features*
+imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &imx8m_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = imx6_pcie_ep_init,
+	.raise_irq = imx6_pcie_ep_raise_irq,
+	.get_features = imx6_pcie_ep_get_features,
+};
+
+static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
+			   struct platform_device *pdev)
+{
+	int ret;
+	unsigned int pcie_dbi2_offset;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
+	struct device *dev = pci->dev;
+
+	imx6_pcie_host_init(pp);
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM_EP:
+		pcie_dbi2_offset = SZ_1M;
+		break;
+	default:
+		pcie_dbi2_offset = SZ_4K;
+		break;
+	}
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+	ep->page_size = SZ_64K;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+	/* Start LTSSM. */
+	imx6_pcie_ltssm_enable(dev);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM_SLEEP
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
@@ -1181,6 +1288,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1269,15 +1377,22 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
-		return ret;
+	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
+		ret = imx6_add_pcie_ep(imx6_pcie, pdev);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = dw_pcie_host_init(&pci->pp);
+		if (ret < 0)
+			return ret;
 
-	if (pci_msi_enabled()) {
-		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-		val |= PCI_MSI_FLAGS_ENABLE;
-		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+		if (pci_msi_enabled()) {
+			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+
+			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+			val |= PCI_MSI_FLAGS_ENABLE;
+			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+		}
 	}
 
 	return 0;
@@ -1322,6 +1437,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 	},
+	[IMX8MM_EP] = {
+		.variant = IMX8MM_EP,
+		.mode = DW_PCIE_EP_TYPE,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1331,6 +1450,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
+	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{},
 };
 
-- 
2.25.1

