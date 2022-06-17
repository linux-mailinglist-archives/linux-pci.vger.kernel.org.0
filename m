Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D2754F5D6
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jun 2022 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382080AbiFQKpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jun 2022 06:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382118AbiFQKpi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Jun 2022 06:45:38 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E26B7C6;
        Fri, 17 Jun 2022 03:45:27 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC00120001C;
        Fri, 17 Jun 2022 12:45:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 955A3200007;
        Fri, 17 Jun 2022 12:45:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 03258180222A;
        Fri, 17 Jun 2022 18:45:23 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v13 10/15] PCI: imx6: Turn off regulator when system is in suspend mode
Date:   Fri, 17 Jun 2022 18:31:09 +0800
Message-Id: <1655461874-16908-11-git-send-email-hongxing.zhu@nxp.com>
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

The driver should undo any enables it did itself. The regulator disable
shouldn't be basing decisions on regulator_is_enabled().

Move the regulator_disable to the suspend function, turn off regulator when
the system is in suspend mode.

To keep the balance of the regulator usage counter, disable the regulator
in shutdown.

Link: https://lore.kernel.org/r/1655189942-12678-6-git-send-email-hongxing.z
hu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2b42c37f1617..f72eb609769b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -670,8 +670,6 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
-
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 	case IMX8MQ:
@@ -702,14 +700,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
-		int ret = regulator_disable(imx6_pcie->vpcie);
-
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
-
 	/* Some boards don't have PCIe reset GPIO. */
 	if (gpio_is_valid(imx6_pcie->reset_gpio))
 		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
@@ -722,7 +712,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
@@ -795,7 +785,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_clks:
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
+	if (imx6_pcie->vpcie) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
@@ -1022,6 +1012,9 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 		break;
 	}
 
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+
 	return 0;
 }
 
@@ -1268,6 +1261,8 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 
 	/* bring down link, so bootloader gets clean state in case of reboot */
 	imx6_pcie_assert_core_reset(imx6_pcie);
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
 }
 
 static const struct imx6_pcie_drvdata drvdata[] = {
-- 
2.25.1

