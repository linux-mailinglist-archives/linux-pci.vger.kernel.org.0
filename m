Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF72E4372D6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJVHkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:40:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:45930 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbhJVHkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 03:40:09 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 03F9D20134A;
        Fri, 22 Oct 2021 09:37:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 94E762005EC;
        Fri, 22 Oct 2021 09:37:50 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2FCFC183AD05;
        Fri, 22 Oct 2021 15:37:49 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 1/7] PCI: imx6: Encapsulate the clock enable into one standalone function
Date:   Fri, 22 Oct 2021 15:12:24 +0800
Message-Id: <1634886750-13861-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

No function changes, just encapsulate the i.MX PCIe clocks enable
operations into one standalone function

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 79 ++++++++++++++++-----------
 1 file changed, 48 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 26f49f797b0f..1fa1dba6da81 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -470,38 +470,16 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
-static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
-{
-	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
-
-	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
-				     IOMUXC_GPR22, val,
-				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
-				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
-				     PHY_PLL_LOCK_WAIT_TIMEOUT))
-		dev_err(dev, "PCIe PLL lock timeout\n");
-}
-
-static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 	int ret;
 
-	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
-		ret = regulator_enable(imx6_pcie->vpcie);
-		if (ret) {
-			dev_err(dev, "failed to enable vpcie regulator: %d\n",
-				ret);
-			return;
-		}
-	}
-
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie_phy clock\n");
-		goto err_pcie_phy;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
@@ -524,6 +502,51 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
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
+}
+
+static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
+{
+	u32 val;
+	struct device *dev = imx6_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+				     IOMUXC_GPR22, val,
+				     val & IMX7D_GPR22_PCIE_PHY_PLL_LOCKED,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT))
+		dev_err(dev, "PCIe PLL lock timeout\n");
+}
+
+static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+{
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	int ret;
+
+	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
+		ret = regulator_enable(imx6_pcie->vpcie);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie regulator: %d\n",
+				ret);
+			return;
+		}
+	}
+
+	ret = imx6_pcie_clk_enable(imx6_pcie);
+	if (ret) {
+		dev_err(dev, "unable to enable pcie clocks\n");
+		goto err_clks;
+	}
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
@@ -578,13 +601,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
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
-- 
2.25.1

