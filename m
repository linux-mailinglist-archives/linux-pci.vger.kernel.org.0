Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A634C3CBB
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 04:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237225AbiBYDxh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 22:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237217AbiBYDxg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 22:53:36 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D66194151;
        Thu, 24 Feb 2022 19:53:04 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F1421A13CD;
        Fri, 25 Feb 2022 04:53:03 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E27371A0003;
        Fri, 25 Feb 2022 04:53:02 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 515DD183ACDE;
        Fri, 25 Feb 2022 11:53:01 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 8/8] PCI: imx6: Add compliance tests mode support
Date:   Fri, 25 Feb 2022 11:44:27 +0800
Message-Id: <1645760667-10510-9-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to the Chapter 3.2 System Board Signal Quality of PCI Express
Architecture PHY Test Specification Revision 2.0.

Signal quality tests (for example: jitter, differential eye opening and
so on) can be executed with devices in the polling.compliance state.

To let the device support polling.compliance state, the clocks and powers
shouldn't be turned off when the probe of device driver fails.

Based on CLB (Compliance Load Board) Test Fixture and so on test
equipments, the PHY link would be down during the compliance tests.
Refer to this scenario, add the i.MX PCIe compliance tests mode enable
support, and keep the clocks and powers on, and finish the driver probe
without error return.

Use the "pci_imx6.compliance=1" in kernel command line to enable the
compliance tests mode.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 ++++++++++++++++++---------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f8b15f0bc9ce..b976a4802db0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -146,6 +146,10 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static bool imx6_pcie_cmp_mode;
+module_param_named(compliance, imx6_pcie_cmp_mode, bool, 0644);
+MODULE_PARM_DESC(compliance, "i.MX PCIe compliance test mode (1=compliance test mode enabled)");
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -841,10 +845,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	tmp &= ~PCI_EXP_LNKCAP_SLS;
-	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	if (!imx6_pcie_cmp_mode) {
+		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		tmp &= ~PCI_EXP_LNKCAP_SLS;
+		tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	}
 
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
@@ -931,18 +937,20 @@ static void imx6_pcie_host_exit(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
 
-	imx6_pcie_reset_phy(imx6_pcie);
-	imx6_pcie_clk_disable(imx6_pcie);
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-		if (phy_power_off(imx6_pcie->phy))
-			dev_err(dev, "unable to power off phy\n");
-		break;
-	default:
-		break;
+	if (!imx6_pcie_cmp_mode) {
+		imx6_pcie_reset_phy(imx6_pcie);
+		imx6_pcie_clk_disable(imx6_pcie);
+		switch (imx6_pcie->drvdata->variant) {
+		case IMX8MM:
+			if (phy_power_off(imx6_pcie->phy))
+				dev_err(dev, "unable to power off phy\n");
+			break;
+		default:
+			break;
+		}
+		if (imx6_pcie->vpcie)
+			regulator_disable(imx6_pcie->vpcie);
 	}
-	if (imx6_pcie->vpcie)
-		regulator_disable(imx6_pcie->vpcie);
 }
 
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
@@ -1260,8 +1268,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
+	if (ret < 0) {
+		if (imx6_pcie_cmp_mode) {
+			dev_info(dev, "driver loaded with compliance test mode enabled\n");
+			ret = 0;
+		} else {
+			dev_err(dev, "unable to add PCIe port\n");
+		}
 		return ret;
+	}
 
 	if (pci_msi_enabled()) {
 		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-- 
2.25.1

