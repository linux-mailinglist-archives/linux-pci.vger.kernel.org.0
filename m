Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE71D66B749
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jan 2023 07:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjAPGHN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Jan 2023 01:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjAPGGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jan 2023 01:06:18 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2277ABBB8;
        Sun, 15 Jan 2023 22:06:14 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C2D3F1A06BD;
        Mon, 16 Jan 2023 07:06:12 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 61E991A06C5;
        Mon, 16 Jan 2023 07:06:12 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EAE4D183AC07;
        Mon, 16 Jan 2023 14:06:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v5 14/14] PCI: imx6: Add i.MX8MP PCIe EP support
Date:   Mon, 16 Jan 2023 13:41:24 +0800
Message-Id: <1673847684-31893-15-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
References: <1673847684-31893-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the i.MX8MP PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index eab332eb4c36..55a0405b921d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -54,6 +54,7 @@ enum imx6_pcie_variants {
 	IMX8MP,
 	IMX8MQ_EP,
 	IMX8MM_EP,
+	IMX8MP_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -158,7 +159,8 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
 		imx6_pcie->drvdata->variant != IMX8MM &&
 		imx6_pcie->drvdata->variant != IMX8MM_EP &&
-		imx6_pcie->drvdata->variant != IMX8MP);
+		imx6_pcie->drvdata->variant != IMX8MP &&
+		imx6_pcie->drvdata->variant != IMX8MP_EP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
@@ -323,6 +325,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		/*
 		 * The PHY initialization had been done in the PHY
 		 * driver, break here directly.
@@ -584,6 +587,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
 		if (ret) {
 			dev_err(dev, "unable to enable pcie_aux clock\n");
@@ -631,6 +635,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		clk_disable_unprepare(imx6_pcie->pcie_aux);
 		break;
 	default:
@@ -701,6 +706,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	case IMX6SX:
@@ -779,6 +785,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		break;
 	}
 
@@ -831,6 +838,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -853,6 +861,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
 	}
@@ -1105,6 +1114,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ_EP:
 	case IMX8MM_EP:
+	case IMX8MP_EP:
 		pcie_dbi2_offset = SZ_1M;
 		break;
 	default:
@@ -1319,6 +1329,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	case IMX8MM:
 	case IMX8MM_EP:
 	case IMX8MP:
+	case IMX8MP_EP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1488,6 +1499,11 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
+	[IMX8MP_EP] = {
+		.variant = IMX8MP_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.gpr = "fsl,imx8mp-iomuxc-gpr",
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1500,6 +1516,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
+	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
 	{},
 };
 
-- 
2.25.1

