Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A632279CC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 09:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGUHs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 03:48:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48158 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgGUHs0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 03:48:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7784320154A;
        Tue, 21 Jul 2020 09:48:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 33B892003FA;
        Tue, 21 Jul 2020 09:48:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C720040305;
        Tue, 21 Jul 2020 15:29:38 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, shawnguo@kernel.org,
        festevam@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 2/2] PCI: imx: add another regulator for imx pcie
Date:   Tue, 21 Jul 2020 15:44:30 +0800
Message-Id: <1595317470-9394-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595317470-9394-1-git-send-email-hongxing.zhu@nxp.com>
References: <1595317470-9394-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One more regulator is required to turn on the external oscillator
populated on the iMX6QP SABRESD board.
Add another regulator to enable PCIe on iMX6QP SABRESD board.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8f08ae53f53e..9e1563601835 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,6 +81,7 @@ struct imx6_pcie {
 	u32			tx_swing_low;
 	int			link_gen;
 	struct regulator	*vpcie;
+	struct regulator	*vepdev;
 	void __iomem		*phy_base;
 
 	/* power domain for pcie */
@@ -507,6 +508,14 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 			return;
 		}
 	}
+	if (imx6_pcie->vepdev && !regulator_is_enabled(imx6_pcie->vepdev)) {
+		ret = regulator_enable(imx6_pcie->vepdev);
+		if (ret) {
+			dev_err(dev, "failed to enable vepdev regulator: %d\n",
+				ret);
+			goto err_pcie_vepdev;
+		}
+	}
 
 	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
 	if (ret) {
@@ -595,6 +604,13 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 err_pcie_bus:
 	clk_disable_unprepare(imx6_pcie->pcie_phy);
 err_pcie_phy:
+	if (imx6_pcie->vepdev && regulator_is_enabled(imx6_pcie->vepdev) > 0) {
+		ret = regulator_disable(imx6_pcie->vepdev);
+		if (ret)
+			dev_err(dev, "failed to disable vepdev regulator: %d\n",
+				ret);
+	}
+err_pcie_vepdev:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
 		ret = regulator_disable(imx6_pcie->vpcie);
 		if (ret)
@@ -1178,6 +1194,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return PTR_ERR(imx6_pcie->vpcie);
 		imx6_pcie->vpcie = NULL;
 	}
+	imx6_pcie->vepdev = devm_regulator_get_optional(&pdev->dev, "vepdev");
+	if (IS_ERR(imx6_pcie->vepdev)) {
+		if (PTR_ERR(imx6_pcie->vepdev) != -ENODEV)
+			return PTR_ERR(imx6_pcie->vepdev);
+		imx6_pcie->vepdev = NULL;
+	}
 
 	platform_set_drvdata(pdev, imx6_pcie);
 
-- 
2.17.1

