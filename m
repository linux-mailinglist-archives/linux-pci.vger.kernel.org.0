Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7602857461C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiGNHsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237612AbiGNHrn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:47:43 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DAB3AB23;
        Thu, 14 Jul 2022 00:47:15 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78BA21A2049;
        Thu, 14 Jul 2022 09:47:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 12BDE1A2034;
        Thu, 14 Jul 2022 09:47:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6AD0F180327D;
        Thu, 14 Jul 2022 15:47:12 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 17/17] PCI: imx6: Reformat suspend callback to keep symmetric with resume
Date:   Thu, 14 Jul 2022 15:31:09 +0800
Message-Id: <1657783869-19194-18-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
References: <1657783869-19194-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Create imx6_pcie_stop_link() and imx6_pcie_host_exit() functions.
Encapsulate clocks, regulators disables and PHY uninitialization into
imx6_pcie_host_exit().

To keep suspend/resume symmetric as much as possible, invoke these two
new created functions in suspend callback.

To be symmetric with imx6_pcie_host_exit(), move imx6_pcie_clk_enable()
to imx6_pcie_host_init() from imx6_pcie_deassert_core_reset().

Link: https://lore.kernel.org/r/1656645935-1370-18-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 62 ++++++++++++++++-----------
 1 file changed, 37 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 21e9101f63f0..b7a7e3465f28 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -703,13 +703,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
-
-	ret = imx6_pcie_clk_enable(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		return ret;
-	}
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
@@ -904,6 +897,14 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	return 0;
 }
 
+static void imx6_pcie_stop_link(struct dw_pcie *pci)
+{
+	struct device *dev = pci->dev;
+
+	/* Turn off PCIe LTSSM */
+	imx6_pcie_ltssm_disable(dev);
+}
+
 static int imx6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -923,11 +924,17 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
 
+	ret = imx6_pcie_clk_enable(imx6_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
+		goto err_reg_disable;
+	}
+
 	if (imx6_pcie->phy) {
 		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "pcie phy power up failed\n");
-			goto err_reg_disable;
+			goto err_clk_disable;
 		}
 	}
 
@@ -941,24 +948,40 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 		ret = phy_init(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for phy ready timeout!\n");
-			goto err_clk_disable;
+			goto err_phy_off;
 		}
 	}
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
 
-err_clk_disable:
-	imx6_pcie_clk_disable(imx6_pcie);
 err_phy_off:
 	if (imx6_pcie->phy)
 		phy_power_off(imx6_pcie->phy);
+err_clk_disable:
+	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:
 	if (imx6_pcie->vpcie)
 		regulator_disable(imx6_pcie->vpcie);
 	return ret;
 }
 
+static void imx6_pcie_host_exit(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	if (imx6_pcie->phy) {
+		if (phy_power_off(imx6_pcie->phy))
+			dev_err(pci->dev, "unable to power off PHY\n");
+		phy_exit(imx6_pcie->phy);
+	}
+	imx6_pcie_clk_disable(imx6_pcie);
+
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+}
+
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -1008,25 +1031,14 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	struct pcie_port *pp = &imx6_pcie->pci->pp;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx6_pcie_pm_turnoff(imx6_pcie);
-	imx6_pcie_ltssm_disable(dev);
-	imx6_pcie_clk_disable(imx6_pcie);
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_off(imx6_pcie->phy))
-			dev_err(dev, "unable to power off PHY\n");
-		phy_exit(imx6_pcie->phy);
-		break;
-	default:
-		break;
-	}
-
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
+	imx6_pcie_stop_link(imx6_pcie->pci);
+	imx6_pcie_host_exit(pp);
 
 	return 0;
 }
-- 
2.25.1

