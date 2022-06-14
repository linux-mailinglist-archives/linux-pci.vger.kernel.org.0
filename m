Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E1854AA2C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 09:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353500AbiFNHNP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jun 2022 03:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353610AbiFNHND (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2022 03:13:03 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C7D1AF3D;
        Tue, 14 Jun 2022 00:13:01 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BA9B1A2782;
        Tue, 14 Jun 2022 09:13:00 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE0721A2793;
        Tue, 14 Jun 2022 09:12:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 70032181D0CA;
        Tue, 14 Jun 2022 15:12:58 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v11 8/8] PCI: imx6: Do not hide phy driver callbacks and refine the error handling
Date:   Tue, 14 Jun 2022 14:59:02 +0800
Message-Id: <1655189942-12678-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655189942-12678-1-git-send-email-hongxing.zhu@nxp.com>
References: <1655189942-12678-1-git-send-email-hongxing.zhu@nxp.com>
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

Refine the error handling in imx6_pcie_host_init() and
imx6_pcie_resume_noirq() functions accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6a55bc395a2c..aa0e81ed6a0e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -503,14 +503,6 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
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
@@ -595,10 +587,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 		break;
-	case IMX8MM:
-		if (phy_init(imx6_pcie->phy))
-			dev_err(dev, "waiting for phy ready timeout!\n");
-		break;
 	case IMX7D:
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
@@ -634,6 +622,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		usleep_range(200, 500);
 		break;
 	case IMX6Q:		/* Nothing to do */
+	case IMX8MM:
 		break;
 	}
 
@@ -918,15 +907,39 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 
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
 	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie host init failed: %d\n", ret);
-		return ret;
+		goto err_phy_off;
+	}
+	if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "waiting for phy ready timeout!\n");
+			goto err_phy_init;
+		}
 	}
 
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
+
+err_phy_init:
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
+	return ret;
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
@@ -1031,12 +1044,40 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
-	imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (imx6_pcie->phy) {
+		ret = phy_power_on(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy power up failed.\n");
+			return ret;
+		}
+	}
+
+	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (ret < 0) {
+		dev_err(dev, "pcie deassert core reset failed: %d.\n", ret);
+		goto err_phy_off;
+	} else if (imx6_pcie->phy) {
+		ret = phy_init(imx6_pcie->phy);
+		if (ret) {
+			dev_err(dev, "pcie phy init failed.\n");
+			goto err_phy_init;
+		}
+	}
+
 	dw_pcie_setup_rc(pp);
 	if (imx6_pcie->link_is_up)
 		imx6_pcie_start_link(imx6_pcie->pci);
 
 	return 0;
+
+err_phy_init:
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+err_phy_off:
+	if (imx6_pcie->phy)
+		phy_power_off(imx6_pcie->phy);
+	return ret;
 }
 #endif
 
-- 
2.25.1

