Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0643459D48
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 08:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbhKWIC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 03:02:26 -0500
Received: from inva021.nxp.com ([92.121.34.21]:34584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234535AbhKWICX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 03:02:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 99D53200840;
        Tue, 23 Nov 2021 08:59:14 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 66F88200804;
        Tue, 23 Nov 2021 08:59:14 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E6AF9183AD05;
        Tue, 23 Nov 2021 15:59:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [RESEND v4 3/6] PCI: imx6: PCI: imx6: Move imx6_pcie_clk_disable() earlier
Date:   Tue, 23 Nov 2021 15:31:54 +0800
Message-Id: <1637652717-17313-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1637652717-17313-1-git-send-email-hongxing.zhu@nxp.com>
References: <1637652717-17313-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just move the imx6_pcie_clk_disable() to an earlier place without function
changes, since it wouldn't be only used in imx6_pcie_suspend_noirq() later.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 65a10b048a8b..11265c5e5782 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -514,6 +514,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return ret;
 }
 
+static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
+{
+	clk_disable_unprepare(imx6_pcie->pcie);
+	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_disable_unprepare(imx6_pcie->pcie_bus);
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX6SX:
+		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
+		break;
+	case IMX7D:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+		break;
+	case IMX8MQ:
+		clk_disable_unprepare(imx6_pcie->pcie_aux);
+		break;
+	default:
+		break;
+	}
+}
+
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 {
 	u32 val;
@@ -940,29 +963,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
-static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
-{
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
-		break;
-	case IMX8MQ:
-		clk_disable_unprepare(imx6_pcie->pcie_aux);
-		break;
-	default:
-		break;
-	}
-}
-
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-- 
2.25.1

