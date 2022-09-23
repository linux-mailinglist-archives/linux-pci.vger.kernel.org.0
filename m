Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43275E741B
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 08:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiIWG0i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 02:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiIWG0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 02:26:16 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374612873D;
        Thu, 22 Sep 2022 23:26:09 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DEA901B67D6;
        Fri, 23 Sep 2022 08:26:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 562081B67D2;
        Fri, 23 Sep 2022 08:26:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4EE17181D0CB;
        Fri, 23 Sep 2022 14:26:05 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 13/14] PCI: imx6: Add iMX8MQ PCIe EP support
Date:   Fri, 23 Sep 2022 14:06:59 +0800
Message-Id: <1663913220-9523-14-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
References: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
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
 drivers/pci/controller/dwc/pci-imx6.c | 36 +++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1044b0726405..931243e36252 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -53,6 +53,7 @@ enum imx6_pcie_variants {
 	IMX8MM,
 	IMX8MP,
 	IMX8MM_EP,
+	IMX8MQ_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -154,6 +155,7 @@ struct imx6_pcie {
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
 		imx6_pcie->drvdata->variant != IMX8MM &&
 		imx6_pcie->drvdata->variant != IMX8MM_EP &&
 		imx6_pcie->drvdata->variant != IMX8MP);
@@ -169,13 +171,22 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
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
@@ -318,6 +329,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		 */
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		/*
 		 * TODO: Currently this code assumes external
 		 * oscillator is being used
@@ -570,6 +582,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
@@ -616,6 +629,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MP:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
@@ -681,6 +695,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
@@ -723,6 +738,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
 	case IMX7D:
@@ -811,6 +827,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
@@ -832,6 +849,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
@@ -1085,6 +1103,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MM_EP:
+	case IMX8MQ_EP:
 		pcie_dbi2_offset = SZ_1M;
 		break;
 	default:
@@ -1272,6 +1291,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_inbound_axi clock missing or invalid\n");
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1462,6 +1482,11 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
+	[IMX8MQ_EP] = {
+		.variant = IMX8MQ_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.gpr = "fsl,imx8mq-iomuxc-gpr",
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1473,6 +1498,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
+	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{},
 };
 
-- 
2.25.1

