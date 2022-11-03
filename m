Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13CF6176BD
	for <lists+linux-pci@lfdr.de>; Thu,  3 Nov 2022 07:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKCG3W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Nov 2022 02:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKCG3V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Nov 2022 02:29:21 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AF4BE12;
        Wed,  2 Nov 2022 23:29:20 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FB8A201444;
        Thu,  3 Nov 2022 07:29:19 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 091C4201440;
        Thu,  3 Nov 2022 07:29:19 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id ADCA51802201;
        Thu,  3 Nov 2022 14:29:17 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v1] PCI: imx6: Keep the GPIO regulator always on
Date:   Thu,  3 Nov 2022 14:08:18 +0800
Message-Id: <1667455698-14578-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since vpcie regulator is one GPIO regulator, used to control the
VPCIe_3V3 and power up remote PCIe EP device.

Some WIFI modules load their firmware once in probe, and can't be
powered off during suspend. Otherwise, these WIFI modules wouldn't be
functional anymore after resume back.

So, keep this regulator always on in the probe.

Fixes: a4bb720eeb1e ("PCI: imx6: Turn off regulator when system is in suspend mode")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2616585ca5f8..94a89bbf381d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -926,22 +926,13 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
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
 	imx6_pcie_assert_core_reset(imx6_pcie);
 	imx6_pcie_init_phy(imx6_pcie);
 
 	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
 		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
-		goto err_reg_disable;
+		return ret;
 	}
 
 	if (imx6_pcie->phy) {
@@ -974,9 +965,6 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 		phy_exit(imx6_pcie->phy);
 err_clk_disable:
 	imx6_pcie_clk_disable(imx6_pcie);
-err_reg_disable:
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
 	return ret;
 }
 
@@ -991,9 +979,6 @@ static void imx6_pcie_host_exit(struct dw_pcie_rp *pp)
 		phy_exit(imx6_pcie->phy);
 	}
 	imx6_pcie_clk_disable(imx6_pcie);
-
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
@@ -1263,6 +1248,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		if (PTR_ERR(imx6_pcie->vpcie) != -ENODEV)
 			return PTR_ERR(imx6_pcie->vpcie);
 		imx6_pcie->vpcie = NULL;
+	} else {
+		ret = regulator_enable(imx6_pcie->vpcie);
+		if (ret) {
+			dev_err(dev, "failed to enable vpcie regulator: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
-- 
2.25.1

