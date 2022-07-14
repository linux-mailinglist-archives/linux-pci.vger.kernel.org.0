Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776C05745F9
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jul 2022 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiGNHrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 03:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiGNHq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 03:46:58 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853E432EC4;
        Thu, 14 Jul 2022 00:46:57 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F950202189;
        Thu, 14 Jul 2022 09:46:56 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CCD85202182;
        Thu, 14 Jul 2022 09:46:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 303DD180327D;
        Thu, 14 Jul 2022 15:46:54 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        broonie@kernel.org, lorenzo.pieralisi@arm.com, festevam@gmail.com,
        francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v15 01/17] PCI: imx6: Move imx6_pcie_grp_offset(), imx6_pcie_configure_type() earlier
Date:   Thu, 14 Jul 2022 15:30:53 +0800
Message-Id: <1657783869-19194-2-git-send-email-hongxing.zhu@nxp.com>
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

From: Bjorn Helgaas <bhelgaas@google.com>

Move imx6_pcie_grp_offset() and imx6_pcie_configure_type() earlier in the
file since they depend on nothing and are used by several other functions
that will be moved earlier.  No functional change intended.

Link: https://lore.kernel.org/r/1656645935-1370-2-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 50 +++++++++++++--------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7a285fb0f619..8653ca8cbfb9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -146,6 +146,31 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
+{
+	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
+		imx6_pcie->drvdata->variant != IMX8MM);
+	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
+}
+
+static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
+{
+	unsigned int mask, val;
+
+	if (imx6_pcie->drvdata->variant == IMX8MQ &&
+	    imx6_pcie->controller_id == 1) {
+		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
+		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+				  PCI_EXP_TYPE_ROOT_PORT);
+	} else {
+		mask = IMX6Q_GPR12_DEVICE_TYPE;
+		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
+				  PCI_EXP_TYPE_ROOT_PORT);
+	}
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
+}
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -415,13 +440,6 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 					imx6_pcie->gpio_active_high);
 }
 
-static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
-{
-	WARN_ON(imx6_pcie->drvdata->variant != IMX8MQ &&
-		imx6_pcie->drvdata->variant != IMX8MM);
-	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
-}
-
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -617,24 +635,6 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	}
 }
 
-static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
-{
-	unsigned int mask, val;
-
-	if (imx6_pcie->drvdata->variant == IMX8MQ &&
-	    imx6_pcie->controller_id == 1) {
-		mask   = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-		val    = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-				    PCI_EXP_TYPE_ROOT_PORT);
-	} else {
-		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
-	}
-
-	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
-}
-
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
-- 
2.25.1

