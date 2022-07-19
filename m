Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F402B579717
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiGSKBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237443AbiGSKBi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 06:01:38 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB14371AF;
        Tue, 19 Jul 2022 03:01:27 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3285B1A0AD4;
        Tue, 19 Jul 2022 12:01:26 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AF3A11A0AC9;
        Tue, 19 Jul 2022 12:01:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 425FA181D0CA;
        Tue, 19 Jul 2022 18:01:24 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v1 10/10] PCI: imx6: Add iMX8MQ PCIe EP support
Date:   Tue, 19 Jul 2022 17:45:39 +0800
Message-Id: <1658223939-25478-11-git-send-email-hongxing.zhu@nxp.com>
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

Add the iMX8MQ PCIe EP support

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ba4ac258c13d..1df634370291 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MM_EP,
+	IMX8MQ_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -152,6 +153,7 @@ struct imx6_pcie {
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
 		imx6_pcie->drvdata->variant != IMX8MM &&
 		imx6_pcie->drvdata->variant != IMX8MM_EP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
@@ -166,13 +168,22 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 	else
 		mode = PCI_EXP_TYPE_ROOT_PORT;
 
-	if (imx6_pcie->drvdata->variant == IMX8MQ &&
-	    imx6_pcie->controller_id == 1) {
-		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE, mode);
-	} else {
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MQ:
+	case IMX8MQ_EP:
+		if (imx6_pcie->controller_id == 1) {
+			mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+			val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+					  mode);
+		} else {
+			mask = IMX6Q_GPR12_DEVICE_TYPE;
+			val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
+		}
+		break;
+	default:
 		mask = IMX6Q_GPR12_DEVICE_TYPE;
 		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
+		break;
 	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
@@ -314,6 +325,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		 */
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		/*
 		 * TODO: Currently this code assumes external
 		 * oscillator is being used
@@ -566,6 +578,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -611,6 +624,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -675,6 +689,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
@@ -716,6 +731,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
 	case IMX7D:
@@ -803,6 +819,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MM_EP:
 		reset_control_deassert(imx6_pcie->apps_reset);
@@ -823,6 +840,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MM_EP:
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -1264,6 +1282,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_inbound_axi clock missing or invalid\n");
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1441,6 +1460,10 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 	},
+	[IMX8MQ_EP] = {
+		.variant = IMX8MQ_EP,
+		.mode = DW_PCIE_EP_TYPE,
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1451,6 +1474,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
+	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{},
 };
 
-- 
2.25.1

