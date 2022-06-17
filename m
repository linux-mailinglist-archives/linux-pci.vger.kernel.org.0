Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AF354F5DE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382092AbiFQKpq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382142AbiFQKpj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:45:39 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B06B677;
        Fri, 17 Jun 2022 03:45:31 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 585691A00BA;
        Fri, 17 Jun 2022 12:45:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 208D91A0052;
        Fri, 17 Jun 2022 12:45:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 807FD1802201;
        Fri, 17 Jun 2022 18:45:28 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v13 14/15] PCI: imx6: Do not hide phy driver callbacks and refine the error handling
Date:   Fri, 17 Jun 2022 18:31:13 +0800
Message-Id: <1655461874-16908-15-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655461874-16908-1-git-send-email-hongxing.zhu@nxp.com>
References: <1655461874-16908-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

- Move the phy_power_on() to host_init and resume functions from
  imx6_pcie_clk_enable().
- Move the phy_init() to host_init and resume functions from
  imx6_pcie_deassert_core_reset().

Refine the error handling in imx6_pcie_host_init() accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++----------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index abce427f5d3f..363bfc4742cf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -639,14 +639,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 		goto err_ref_clk;
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_on(imx6_pcie->phy))
-			dev_err(dev, "unable to power on PHY\n");
-		break;
-	default:
-		break;
-	}
 	/* allow the clocks to stabilize */
 	usleep_range(200, 500);
 	return 0;
@@ -723,10 +715,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
-	case IMX8MM:
-		if (phy_init(imx6_pcie->phy))
-			dev_err(dev, "waiting for phy ready timeout!\n");
-		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -762,6 +750,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		usleep_range(200, 500);
 		break;
 	case IMX6Q:		/* Nothing to do */
+	case IMX8MM:
 		break;
 	}
 
@@ -904,12 +893,20 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
+	if (imx6_pcie->phy) {
+		ret = phy_power_on(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy power up failed.\n");
+			return ret;
+		}
+	}
+
 	if (imx6_pcie->vpcie) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
 				ret);
-			return ret;
+			goto err_phy_off;
 		}
 	}
 
@@ -919,13 +916,25 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 		goto err_reg_disable;
 	}
 
+	if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "waiting for phy ready timeout!\n");
+			goto err_phy_init;
+		}
+	}
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
 
+err_phy_init:
+	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:
 	if (imx6_pcie->vpcie)
 		regulator_disable(imx6_pcie->vpcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
 	return ret;
 }
 
-- 
2.25.1

