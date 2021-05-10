Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C011D379194
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243540AbhEJO4M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241701AbhEJOz0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E5C046854
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:17 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gi-0000Fk-4j; Mon, 10 May 2021 16:15:12 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 5/7] PCI: imx6: Configure PHY refclock according to DT property
Date:   Mon, 10 May 2021 16:15:07 +0200
Message-Id: <20210510141509.929120-5-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210510141509.929120-1-l.stach@pengutronix.de>
References: <20210510141509.929120-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::39
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This configures the PHY reference clock input according to the newly
introduced fsl,refclk-pad-mode DT property. The default in absence
of this property is to use the refclk pad on i.MX8MQ and the internal
reference clock on all other SoCs, keeping compatibility with existing
devicetrees, but allowing boards to configure this when they differ
from the default.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5e13758222e8..f184077f6d17 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -79,6 +79,7 @@ struct imx6_pcie {
 	u32			tx_deemph_gen2_6db;
 	u32			tx_swing_full;
 	u32			tx_swing_low;
+	u32			refclk_pad_mode;
 	struct regulator	*vpcie;
 	void __iomem		*phy_base;
 
@@ -613,18 +614,17 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
-		/*
-		 * TODO: Currently this code assumes external
-		 * oscillator is being used
-		 */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr,
 				   imx6_pcie_grp_offset(imx6_pcie),
 				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+				   imx6_pcie->refclk_pad_mode == 1 ?
+				   IMX8MQ_GPR_PCIE_REF_USE_PAD : 0);
 		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+				   imx6_pcie->refclk_pad_mode == 1 ?
+				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL : 0);
 		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1049,6 +1049,12 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_inbound_axi clock missing or invalid\n");
 		break;
 	case IMX8MQ:
+		/*
+		 * i.MX8MQ is special, as the default refclk pad mode is set to
+		 * input in order to keep compatibility with old devicetrees.
+		 */
+		imx6_pcie->refclk_pad_mode = 1;
+
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
@@ -1114,6 +1120,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 				 &imx6_pcie->tx_swing_low))
 		imx6_pcie->tx_swing_low = 127;
 
+	/* get PHY refclk pad mode */
+	of_property_read_u32(node, "fsl,refclk-pad-mode",
+			     &imx6_pcie->refclk_pad_mode);
+
 	/* Limit link speed */
 	pci->link_gen = 1;
 	ret = of_property_read_u32(node, "fsl,max-link-speed", &pci->link_gen);
-- 
2.29.2

