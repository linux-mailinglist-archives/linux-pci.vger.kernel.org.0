Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CD6379192
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 16:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhEJO4K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbhEJOzZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 10:55:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42483C046852
        for <linux-pci@vger.kernel.org>; Mon, 10 May 2021 07:15:16 -0700 (PDT)
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1lg6gh-0000Fk-50; Mon, 10 May 2021 16:15:11 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH 3/7] PCI: imx6: Rework PHY search and mapping
Date:   Mon, 10 May 2021 16:15:05 +0200
Message-Id: <20210510141509.929120-3-l.stach@pengutronix.de>
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

We don't need to have a phandle of the PHY, as we know the compatible
of the node we are looking for. This will make it easier to put add
more PHY handling for new generations later on, where the
"fsl,imx7d-pcie-phy" phandle would be a misnomer.

Also we can use a helper function to get the resource for us,
simplifying out driver code a bit.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie.txt  |  5 ++---
 drivers/pci/controller/dwc/pci-imx6.c           | 17 +++++------------
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
index de4b2baf91e8..308540df99ef 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.txt
@@ -54,7 +54,6 @@ Additional required properties for imx7d-pcie and imx8mq-pcie:
 	       - "pciephy"
 	       - "apps"
 	       - "turnoff"
-- fsl,imx7d-pcie-phy: A phandle to an fsl,imx7d-pcie-phy node.
 
 Additional required properties for imx8mq-pcie:
 - clock-names: Must include the following additional entries:
@@ -88,8 +87,8 @@ Example:
 
 * Freescale i.MX7d PCIe PHY
 
-This is the PHY associated with the IMX7d PCIe controller.  It's used by the
-PCI-e controller via the fsl,imx7d-pcie-phy phandle.
+This is the PHY associated with the IMX7d PCIe controller.  It's looked up by
+the PCI-e controller via the fsl,imx7d-pcie-phy compatible.
 
 Required properties:
 - compatible:
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 922c14361cd3..5e13758222e8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -555,7 +555,7 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
 			       imx6_pcie->phy_base + PCIE_PHY_CMN_REG26);
 		} else {
-			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
+			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy node?\n");
 		}
 
 		imx7d_pcie_wait_for_phy_pll_lock(imx6_pcie);
@@ -970,7 +970,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
-	struct device_node *np;
+	struct device_node *np = NULL;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
@@ -991,17 +991,10 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	imx6_pcie->pci = pci;
 	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
-	/* Find the PHY if one is defined, only imx7d uses it */
-	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
+	/* Find the PHY if one is present in DT, only imx7d uses it */
+	np = of_find_compatible_node(NULL, NULL, "fsl,imx7d-pcie-phy");
 	if (np) {
-		struct resource res;
-
-		ret = of_address_to_resource(np, 0, &res);
-		if (ret) {
-			dev_err(dev, "Unable to map PCIe PHY\n");
-			return ret;
-		}
-		imx6_pcie->phy_base = devm_ioremap_resource(dev, &res);
+		imx6_pcie->phy_base = devm_of_iomap(dev, np, 0, NULL);
 		if (IS_ERR(imx6_pcie->phy_base)) {
 			dev_err(dev, "Unable to map PCIe PHY\n");
 			return PTR_ERR(imx6_pcie->phy_base);
-- 
2.29.2

