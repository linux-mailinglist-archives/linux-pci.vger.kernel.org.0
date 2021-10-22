Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08494372DC
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhJVHkM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:40:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56180 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232154AbhJVHkL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 03:40:11 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A2C8F1A137C;
        Fri, 22 Oct 2021 09:37:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68BBD1A06DC;
        Fri, 22 Oct 2021 09:37:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 01B14183AC94;
        Fri, 22 Oct 2021 15:37:51 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 4/7] PCI: imx6: move the clock disable function to a proper place
Date:   Fri, 22 Oct 2021 15:12:27 +0800
Message-Id: <1634886750-13861-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just move the imx6_pcie_clk_disable() to a proper place without function
changes, since it wouldn't be only used in imx6_pcie_suspend_noirq() later.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 46 +++++++++++++--------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 39a485bfc676..b752a673e767 100644
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
@@ -939,29 +962,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
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

