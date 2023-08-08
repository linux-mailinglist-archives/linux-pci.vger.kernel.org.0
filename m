Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E943A773C29
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjHHQBB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHHP72 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 11:59:28 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A061A4;
        Tue,  8 Aug 2023 08:44:30 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3617D2011BC;
        Tue,  8 Aug 2023 08:09:02 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C35452011BA;
        Tue,  8 Aug 2023 08:09:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 279571800319;
        Tue,  8 Aug 2023 14:09:00 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     frank.li@nxp.com, l.stach@pengutronix.de, shawnguo@kernel.org,
        lpieralisi@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 7/9] PCI: imx6: Add i.MX6Q and i.MX6QP PCIe EP supports
Date:   Tue,  8 Aug 2023 13:34:16 +0800
Message-Id: <1691472858-9383-8-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
References: <1691472858-9383-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX6Q and i.MX6QP PCIe EP supports.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 27aaa2a6bf39..9a6531ddfef2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -46,8 +46,10 @@
 
 enum imx6_pcie_variants {
 	IMX6Q,
+	IMX6Q_EP,
 	IMX6SX,
 	IMX6QP,
+	IMX6QP_EP,
 	IMX7D,
 	IMX8MQ,
 	IMX8MM,
@@ -67,6 +69,7 @@ struct imx6_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const struct pci_epc_features *epc_features;
 };
 
 struct imx6_pcie {
@@ -567,7 +570,9 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
 	case IMX6QP:
+	case IMX6QP_EP:
 	case IMX6Q:
+	case IMX6Q_EP:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
@@ -619,7 +624,9 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
 	case IMX6QP:
+	case IMX6QP_EP:
 	case IMX6Q:
+	case IMX6Q_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -720,11 +727,13 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
 		break;
 	case IMX6QP:
+	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST,
 				   IMX6Q_GPR1_PCIE_SW_RST);
 		break;
 	case IMX6Q:
+	case IMX6Q_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -777,12 +786,14 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
 		break;
 	case IMX6QP:
+	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_SW_RST, 0);
 
 		usleep_range(200, 500);
 		break;
 	case IMX6Q:		/* Nothing to do */
+	case IMX6Q_EP:
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
@@ -827,8 +838,10 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6Q:
+	case IMX6Q_EP:
 	case IMX6SX:
 	case IMX6QP:
+	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2,
 				   IMX6Q_GPR12_PCIE_CTL_2);
@@ -851,8 +864,10 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6Q:
+	case IMX6Q_EP:
 	case IMX6SX:
 	case IMX6QP:
+	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
@@ -1077,6 +1092,27 @@ static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+/*
+ * i.MX6Q and i.MX6QP PCIe EP BAR definitions.
+ * +-----------------------------------------------------------------+
+ * | BAR0     | BAR1     | BAR2     | BAR3     | BAR4     | BAR5     |
+ * +----------|----------|----------|----------|----------|----------+
+ * | 64-bit   | Disabled | 32-bit   | 32-bit   | Disabled | Disabled |
+ * |          |          |          | Fixed    |          |          |
+ * |          |          |          | 256Bytes |          |          |
+ * | Prefetch |          | Prefetch | None-    |          |          |
+ * | Memory   |          | Memory   | Prefetch |          |          |
+ * |          |          |          | IO       |          |          |
+ * +-----------------------------------------------------------------+
+ */
+static const struct pci_epc_features imx6q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.reserved_bar = 1 << BAR_4 | 1 << BAR_5,
+	.align = SZ_64K,
+};
+
 static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
@@ -1088,6 +1124,12 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 static const struct pci_epc_features*
 imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	if (imx6_pcie->drvdata->epc_features)
+		return imx6_pcie->drvdata->epc_features;
+
 	return &imx8m_pcie_epc_features;
 }
 
@@ -1157,6 +1199,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 	case IMX6QP:
+	case IMX6QP_EP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
@@ -1478,6 +1521,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 	},
+	[IMX6Q_EP] = {
+		.variant = IMX6Q_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.epc_features = &imx6q_pcie_epc_features,
+	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
@@ -1493,6 +1543,13 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 	},
+	[IMX6QP_EP] = {
+		.variant = IMX6QP_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.flags = IMX6_PCIE_FLAG_IMX6_PHY,
+		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.epc_features = &imx6q_pcie_epc_features,
+	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
@@ -1531,8 +1588,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 
 static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx6q-pcie",  .data = &drvdata[IMX6Q],  },
+	{ .compatible = "fsl,imx6q-pcie-ep", .data = &drvdata[IMX6Q_EP], },
 	{ .compatible = "fsl,imx6sx-pcie", .data = &drvdata[IMX6SX], },
 	{ .compatible = "fsl,imx6qp-pcie", .data = &drvdata[IMX6QP], },
+	{ .compatible = "fsl,imx6qp-pcie-ep", .data = &drvdata[IMX6QP_EP], },
 	{ .compatible = "fsl,imx7d-pcie",  .data = &drvdata[IMX7D],  },
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
-- 
2.34.1

