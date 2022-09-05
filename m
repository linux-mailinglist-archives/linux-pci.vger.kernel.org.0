Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC335AC8DD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 04:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235680AbiIEClD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Sep 2022 22:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIEClC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 4 Sep 2022 22:41:02 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F242A973;
        Sun,  4 Sep 2022 19:41:00 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FBDC1A1CE4;
        Mon,  5 Sep 2022 04:40:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CDF841A1CDF;
        Mon,  5 Sep 2022 04:40:58 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2D67D1820F5B;
        Mon,  5 Sep 2022 10:40:57 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     a.fatoum@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, vkoul@kernel.org,
        marcel.ziswiler@toradex.com, kishon@ti.com
Cc:     hongxing.zhu@nxp.com, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3] phy: freescale: imx8m-pcie: Fix the wrong order of phy_init() and phy_power_on()
Date:   Mon,  5 Sep 2022 10:23:03 +0800
Message-Id: <1662344583-18874-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to phy_core driver, phy_init() must be called before phy_power_on().
Fix the wrong order of phy_init() and phy_power_on() here.

Fixes: 1aa97b002258 ("phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c      | 6 +++---
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6e5debdbc55b..b5f0de455a7b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -935,7 +935,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	if (imx6_pcie->phy) {
-		ret = phy_power_on(imx6_pcie->phy);
+		ret = phy_init(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "pcie PHY power up failed\n");
 			goto err_clk_disable;
@@ -949,7 +949,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	if (imx6_pcie->phy) {
-		ret = phy_init(imx6_pcie->phy);
+		ret = phy_power_on(imx6_pcie->phy);
 		if (ret) {
 			dev_err(dev, "waiting for PHY ready timeout!\n");
 			goto err_phy_off;
@@ -961,7 +961,7 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 
 err_phy_off:
 	if (imx6_pcie->phy)
-		phy_power_off(imx6_pcie->phy);
+		phy_exit(imx6_pcie->phy);
 err_clk_disable:
 	imx6_pcie_clk_disable(imx6_pcie);
 err_reg_disable:
diff --git a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
index ad7d2edfc414..c93286483b42 100644
--- a/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
+++ b/drivers/phy/freescale/phy-fsl-imx8m-pcie.c
@@ -59,7 +59,7 @@ struct imx8_pcie_phy {
 	bool			clkreq_unused;
 };
 
-static int imx8_pcie_phy_init(struct phy *phy)
+static int imx8_pcie_phy_power_on(struct phy *phy)
 {
 	int ret;
 	u32 val, pad_mode;
@@ -137,14 +137,14 @@ static int imx8_pcie_phy_init(struct phy *phy)
 	return ret;
 }
 
-static int imx8_pcie_phy_power_on(struct phy *phy)
+static int imx8_pcie_phy_init(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
 
 	return clk_prepare_enable(imx8_phy->clk);
 }
 
-static int imx8_pcie_phy_power_off(struct phy *phy)
+static int imx8_pcie_phy_exit(struct phy *phy)
 {
 	struct imx8_pcie_phy *imx8_phy = phy_get_drvdata(phy);
 
@@ -155,8 +155,8 @@ static int imx8_pcie_phy_power_off(struct phy *phy)
 
 static const struct phy_ops imx8_pcie_phy_ops = {
 	.init		= imx8_pcie_phy_init,
+	.exit		= imx8_pcie_phy_exit,
 	.power_on	= imx8_pcie_phy_power_on,
-	.power_off	= imx8_pcie_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-- 
2.25.1

