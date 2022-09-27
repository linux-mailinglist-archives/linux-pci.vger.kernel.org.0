Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D55EBE43
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiI0JRZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Sep 2022 05:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiI0JQ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Sep 2022 05:16:59 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6278CBAE2;
        Tue, 27 Sep 2022 02:16:45 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F27720EC96;
        Tue, 27 Sep 2022 11:16:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F5B420EC91;
        Tue, 27 Sep 2022 11:16:44 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0E4041820F5C;
        Tue, 27 Sep 2022 17:16:41 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v4 13/14] PCI: imx6: Add i.MX8MM PCIe EP support
Date:   Tue, 27 Sep 2022 16:57:15 +0800
Message-Id: <1664269036-16142-14-git-send-email-hongxing.zhu@nxp.com>
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

Add i.MX8MM PCIe EP support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 777ad946ec7f..907a36e18842 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -53,6 +53,7 @@ enum imx6_pcie_variants {
 	IMX8MM,
 	IMX8MP,
 	IMX8MQ_EP,
+	IMX8MM_EP,
 };
 
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
@@ -156,6 +157,7 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
 		imx6_pcie->drvdata->variant != IMX8MQ_EP &&
 		imx6_pcie->drvdata->variant != IMX8MM &&
+		imx6_pcie->drvdata->variant != IMX8MM_EP &&
 		imx6_pcie->drvdata->variant != IMX8MP);
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
@@ -319,6 +321,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		/*
 		 * The PHY initialization had been done in the PHY
@@ -577,6 +580,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX7D:
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MP:
@@ -623,6 +627,7 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MP:
@@ -694,6 +699,7 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		reset_control_assert(imx6_pcie->pciephy_reset);
 		fallthrough;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -771,6 +777,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	case IMX6Q:		/* Nothing to do */
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		break;
 	}
@@ -822,6 +829,7 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		reset_control_deassert(imx6_pcie->apps_reset);
 		break;
@@ -843,6 +851,7 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		reset_control_assert(imx6_pcie->apps_reset);
 		break;
@@ -1094,6 +1103,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ_EP:
+	case IMX8MM_EP:
 		pcie_dbi2_offset = SZ_1M;
 		break;
 	default:
@@ -1306,6 +1316,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		}
 		break;
 	case IMX8MM:
+	case IMX8MM_EP:
 	case IMX8MP:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
@@ -1471,6 +1482,11 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
+	[IMX8MM_EP] = {
+		.variant = IMX8MM_EP,
+		.mode = DW_PCIE_EP_TYPE,
+		.gpr = "fsl,imx8mm-iomuxc-gpr",
+	},
 };
 
 static const struct of_device_id imx6_pcie_of_match[] = {
@@ -1482,6 +1498,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
+	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{},
 };
 
-- 
2.25.1

