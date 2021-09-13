Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F440846B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 08:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237301AbhIMGFi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 02:05:38 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56602 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237282AbhIMGFh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 02:05:37 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB6261A2089;
        Mon, 13 Sep 2021 08:04:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 93BDB1A28BD;
        Mon, 13 Sep 2021 08:04:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 952D5183AC88;
        Mon, 13 Sep 2021 14:04:19 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 2/5] PCI: imx6: Add the error propagation from host_init
Date:   Mon, 13 Sep 2021 13:41:07 +0800
Message-Id: <1631511670-30164-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631511670-30164-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631511670-30164-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since there is error return check of the host_init callback, add error
check to imx6_pcie_deassert_core_reset() function, and change the
function type accordingly.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 64260b91c474..d3479f646c4f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -527,24 +527,24 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
-static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
+static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
-	int ret;
+	int ret, err;
 
 	if (imx6_pcie->vpcie && !regulator_is_enabled(imx6_pcie->vpcie)) {
 		ret = regulator_enable(imx6_pcie->vpcie);
 		if (ret) {
 			dev_err(dev, "failed to enable vpcie regulator: %d\n",
 				ret);
-			return;
+			return ret;
 		}
 	}
 
-	ret = imx6_pcie_clk_enable(imx6_pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clocks\n");
+	err = imx6_pcie_clk_enable(imx6_pcie);
+	if (err) {
+		dev_err(dev, "unable to enable pcie clocks: %d\n", err);
 		goto err_clks;
 	}
 
@@ -599,7 +599,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 		break;
 	}
 
-	return;
+	return 0;
 
 err_clks:
 	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0) {
@@ -608,6 +608,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 			dev_err(dev, "failed to disable vpcie regulator: %d\n",
 				ret);
 	}
+	return err;
 }
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
@@ -858,11 +859,18 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 static int imx6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+	int ret;
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
-	imx6_pcie_deassert_core_reset(imx6_pcie);
+	ret = imx6_pcie_deassert_core_reset(imx6_pcie);
+	if (ret < 0) {
+		dev_err(dev, "pcie host init failed: %d.\n", ret);
+		return ret;
+	}
+
 	imx6_setup_phy_mpll(imx6_pcie);
 
 	return 0;
-- 
2.25.1

