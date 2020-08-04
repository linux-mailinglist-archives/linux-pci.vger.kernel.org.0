Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4837523B486
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHDFmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 01:42:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47602 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgHDFml (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 01:42:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDA862011A2;
        Tue,  4 Aug 2020 07:42:39 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 70C75201194;
        Tue,  4 Aug 2020 07:42:34 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A0D70402DE;
        Tue,  4 Aug 2020 07:42:27 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] PCI: imx6: Do not output error message when devm_clk_get() failed with -EPROBE_DEFER
Date:   Tue,  4 Aug 2020 13:38:01 +0800
Message-Id: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When devm_clk_get() returns -EPROBE_DEFER, i.MX6 PCI driver should
NOT print error message, just return -EPROBE_DEFER is enough.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4e5c379..ee75d35 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1076,20 +1076,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
 	if (IS_ERR(imx6_pcie->pcie_phy)) {
-		dev_err(dev, "pcie_phy clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_phy);
+		ret = PTR_ERR(imx6_pcie->pcie_phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "pcie_phy clock source missing or invalid\n");
+		return ret;
 	}
 
 	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
 	if (IS_ERR(imx6_pcie->pcie_bus)) {
-		dev_err(dev, "pcie_bus clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie_bus);
+		ret = PTR_ERR(imx6_pcie->pcie_bus);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "pcie_bus clock source missing or invalid\n");
+		return ret;
 	}
 
 	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
 	if (IS_ERR(imx6_pcie->pcie)) {
-		dev_err(dev, "pcie clock source missing or invalid\n");
-		return PTR_ERR(imx6_pcie->pcie);
+		ret = PTR_ERR(imx6_pcie->pcie);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "pcie clock source missing or invalid\n");
+		return ret;
 	}
 
 	switch (imx6_pcie->drvdata->variant) {
@@ -1097,15 +1103,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
 							   "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi)) {
-			dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
-			return PTR_ERR(imx6_pcie->pcie_inbound_axi);
+			ret = PTR_ERR(imx6_pcie->pcie_inbound_axi);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "pcie_inbound_axi clock missing or invalid\n");
+			return ret;
 		}
 		break;
 	case IMX8MQ:
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux)) {
-			dev_err(dev, "pcie_aux clock source missing or invalid\n");
-			return PTR_ERR(imx6_pcie->pcie_aux);
+			ret = PTR_ERR(imx6_pcie->pcie_aux);
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "pcie_aux clock source missing or invalid\n");
+			return ret;
 		}
 		/* fall through */
 	case IMX7D:
-- 
2.7.4

