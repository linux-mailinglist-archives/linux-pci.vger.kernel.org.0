Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8A8574612
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiGNHrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237456AbiGNHrK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:47:10 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEC3A499;
        Thu, 14 Jul 2022 00:47:09 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B8CE202189;
        Thu, 14 Jul 2022 09:47:07 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B21B2021A6;
        Thu, 14 Jul 2022 09:47:07 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 936BB180222A;
        Thu, 14 Jul 2022 15:47:05 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 11/17] PCI: imx6: Move regulator enable out of imx6_pcie_deassert_core_reset()
Date:   Thu, 14 Jul 2022 15:31:03 +0800
Message-Id: <1657783869-19194-12-git-send-email-hongxing.zhu@nxp.com>
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

Move regulator enable out of imx6_pcie_deassert_core_reset(), since the
regulator_enable() has nothing to do with imx6_pcie_deassert_core_reset().

Link: https://lore.kernel.org/r/1656645935-1370-12-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 36 ++++++++++++---------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 95815e4255d3..d263574e5c85 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -712,19 +712,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	if (imx6_pcie->vpcie) {
-		ret = regulator_enable(imx6_pcie->vpcie);
-		if (ret) {
-			dev_err(dev, "failed to enable vpcie regulator: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_clks;
+		return ret;
 	}
 
 	switch (imx6_pcie->drvdata->variant) {
@@ -783,15 +774,6 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 
 	return 0;
-
-err_clks:
-	if (imx6_pcie->vpcie) {
-		ret = regulator_disable(imx6_pcie->vpcie);
-		if (ret)
-			dev_err(dev, "failed to disable vpcie regulator: %d\n",
-				ret);
-	}
-	return ret;
 }
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
@@ -914,17 +896,31 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
 	int ret;
 
+	if (imx6_pcie->vpcie) {
+		ret = regulator_enable(imx6_pcie->vpcie);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie regulator: %d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
 	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
-		return ret;
+		goto err_reg_disable;
 	}
 
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
+
+err_reg_disable:
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+	return ret;
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
-- 
2.25.1

