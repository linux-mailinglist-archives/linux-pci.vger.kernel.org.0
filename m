Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A315574617
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiGNHsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiGNHrj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:47:39 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4BF3A4A6;
        Thu, 14 Jul 2022 00:47:14 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BE41202179;
        Thu, 14 Jul 2022 09:47:13 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6AB820218B;
        Thu, 14 Jul 2022 09:47:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A6141820F59;
        Thu, 14 Jul 2022 15:47:11 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 16/17] PCI: imx6: Move the imx6_pcie_ltssm_disable() earlier
Date:   Thu, 14 Jul 2022 15:31:08 +0800
Message-Id: <1657783869-19194-17-git-send-email-hongxing.zhu@nxp.com>
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

Move the imx6_pcie_ltssm_disable() earlier and place it just behind the
imx6_pcie_ltssm_enable(), since it might not be only used by suspend
callback directly.

To be symmetric with imx6_pcie_ltssm_enable(), add the IMX6Q and IMX8MQ
switch cases in imx6_pcie_ltssm_disable().

Link: https://lore.kernel.org/r/1656645935-1370-17-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 38 +++++++++++++--------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6d7ae141ec58..21e9101f63f0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -805,6 +805,25 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 	}
 }
 
+static void imx6_pcie_ltssm_disable(struct device *dev)
+{
+	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX6Q:
+	case IMX6SX:
+	case IMX6QP:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX6Q_GPR12_PCIE_CTL_2, 0);
+		break;
+	case IMX7D:
+	case IMX8MQ:
+	case IMX8MM:
+		reset_control_assert(imx6_pcie->apps_reset);
+		break;
+	}
+}
+
 static int imx6_pcie_start_link(struct dw_pcie *pci)
 {
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
@@ -949,25 +968,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 };
 
 #ifdef CONFIG_PM_SLEEP
-static void imx6_pcie_ltssm_disable(struct device *dev)
-{
-	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0);
-		break;
-	case IMX7D:
-	case IMX8MM:
-		reset_control_assert(imx6_pcie->apps_reset);
-		break;
-	default:
-		dev_err(dev, "ltssm_disable not supported\n");
-	}
-}
-
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
-- 
2.25.1

