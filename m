Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F3E403536
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345425AbhIHHX3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 03:23:29 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47664 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhIHHX2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 03:23:28 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 065851A2E57;
        Wed,  8 Sep 2021 09:22:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FE8B1A2E30;
        Wed,  8 Sep 2021 09:22:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A71A183AC88;
        Wed,  8 Sep 2021 15:22:18 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 1/3] PCI: imx: encapsulate the clock enable into one standalone function
Date:   Wed,  8 Sep 2021 14:59:24 +0800
Message-Id: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No function changes, just encapsulate the i.MX PCIe clocks enable
operations into one standalone function

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++----------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..0264432e4c4a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -143,6 +143,8 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -498,33 +500,12 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		}
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
+	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
-		dev_err(dev, "unable to enable pcie_bus clock\n");
-		goto err_pcie_bus;
+		dev_err(dev, "unable to enable pcie clocks\n");
+		goto err_clks;
 	}
 
-	ret = clk_prepare_enable(imx6_pcie->pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clock\n");
-		goto err_pcie;
-	}
-
-	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie ref clock\n");
-		goto err_ref_clk;
-	}
-
-	/* allow the clocks to stabilize */
-	usleep_range(200, 500);
-
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
 		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
@@ -578,13 +559,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	return;
 
-err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-err_pcie_phy:
+err_clks:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
@@ -914,6 +889,51 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
+static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
+{
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie_phy clock\n");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie_bus clock\n");
+		goto err_pcie_bus;
+	}
+
+	ret = clk_prepare_enable(imx6_pcie->pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clock\n");
+		goto err_pcie;
+	}
+
+	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie ref clock\n");
+		goto err_ref_clk;
+	}
+
+	/* allow the clocks to stabilize */
+	usleep_range(200, 500);
+	return 0;
+
+err_ref_clk:
+	clk_disable_unprepare(imx6_pcie->pcie);
+err_pcie:
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+err_pcie_bus:
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+
+	return ret;
+
+}
+
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	clk_disable_unprepare(imx6_pcie->pcie);
-- 
2.25.1

