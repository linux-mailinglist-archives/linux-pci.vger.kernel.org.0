Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BE34B813F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 08:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiBPHSA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 02:18:00 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBPHR7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 02:17:59 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD8C7D6E;
        Tue, 15 Feb 2022 23:17:46 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 810481A1A44;
        Wed, 16 Feb 2022 07:52:53 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 49A9C1A02CD;
        Wed, 16 Feb 2022 07:52:53 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 09EF0183AD0B;
        Wed, 16 Feb 2022 14:52:51 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v7 3/8] PCI: imx6: Move imx6_pcie_clk_disable() earlier
Date:   Wed, 16 Feb 2022 14:20:58 +0800
Message-Id: <1644992463-14467-4-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644992463-14467-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644992463-14467-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just move the imx6_pcie_clk_disable() to an earlier place without function
changes, since it wouldn't be only used in imx6_pcie_suspend_noirq() later.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++--------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3ca2eef39617..e157f0bec37e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -533,6 +533,29 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
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
@@ -965,30 +988,6 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
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
-	case IMX8MM:
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

