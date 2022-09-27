Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A365EBE45
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiI0JRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiI0JQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:16:59 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BD5CBADC;
        Tue, 27 Sep 2022 02:16:44 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2398C20EC83;
        Tue, 27 Sep 2022 11:16:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9814920EC90;
        Tue, 27 Sep 2022 11:16:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 09AFC1820F5B;
        Tue, 27 Sep 2022 17:16:39 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 12/14] PCI: imx6: Add i.MX8MQ PCIe EP support
Date:   Tue, 27 Sep 2022 16:57:14 +0800
Message-Id: <1664269036-16142-13-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
References: <1664269036-16142-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add i.MX8MQ PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 38 +++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1631b8c444dd..777ad946ec7f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX8MQ_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -153,6 +154,7 @@ struct imx6_pcie {
 static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 {
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
 		imx6_pcie->drvdata->variant != IMX8MM &&
 		imx6_pcie->drvdata->variant != IMX8MP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
@@ -167,13 +169,22 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
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
@@ -315,6 +326,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		 */
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		/*
 		 * TODO: Currently this code assumes external
 		 * oscillator is being used
@@ -566,6 +578,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX8MM:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
@@ -611,6 +624,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX8MM:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MP:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
@@ -676,6 +690,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
@@ -717,6 +732,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
 	case IMX7D:
@@ -804,6 +820,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MP:
 		reset_control_deassert(imx6_pcie->apps_reset);
@@ -824,6 +841,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 		break;
 	case IMX7D:
 	case IMX8MQ:
+	case IMX8MQ_EP:
 	case IMX8MM:
 	case IMX8MP:
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -1075,6 +1093,9 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	ep->ops = &pcie_ep_ops;
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MQ_EP:
+		pcie_dbi2_offset = SZ_1M;
+		break;
 	default:
 		pcie_dbi2_offset = SZ_4K;
 		break;
@@ -1260,6 +1281,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_inbound_axi clock missing or invalid\n");
 		break;
 	case IMX8MQ:
+	case IMX8MQ_EP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1444,6 +1466,11 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
+	[IMX8MQ_EP] = {
+		.variant = IMX8MQ_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.gpr = "fsl,imx8mq-iomuxc-gpr",
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1454,6 +1481,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{},
 };
 
-- 
2.25.1

