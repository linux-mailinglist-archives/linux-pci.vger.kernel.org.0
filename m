Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB7403539
	for <lists+linux-pci@lfdr.de>; Wed,  8 Sep 2021 09:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347872AbhIHHXb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Sep 2021 03:23:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47828 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235185AbhIHHX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Sep 2021 03:23:29 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 53DFF1A2E4A;
        Wed,  8 Sep 2021 09:22:21 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE7EC1A4595;
        Wed,  8 Sep 2021 09:22:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id EFB8C183AD45;
        Wed,  8 Sep 2021 15:22:19 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 3/3] PCI: imx: add compliance tests mode to enable measure signal quality
Date:   Wed,  8 Sep 2021 14:59:26 +0800
Message-Id: <1631084366-24785-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631084366-24785-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to the system board signal Quality of PCIe archiecture PHY test
specification. Signal quality tests can be executed with devices in the
polling.compliance state.

To let the device support polling.compliance stat, the clocks and
powers shouldn't be turned off during the compliance tests although
the PHY link might be down.
Add the i.MX PCIe compliance tests mode enable option to keep the and
powers on, and finish the driver probe without error return.

Use the "pcie_cmp_enabled=yes" in kernel command line to enable the
compliance tests mode.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 41 +++++++++++++++++++++------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 129928e42f84..3aef0e86f1c2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -143,6 +143,7 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static int imx6_pcie_cmp_enabled;
 static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie);
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie);
 
@@ -748,10 +749,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	 * started in Gen2 mode, there is a possibility the devices on the
 	 * bus will not be detected at all.  This happens with PCIe switches.
 	 */
-	tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
-	tmp &= ~PCI_EXP_LNKCAP_SLS;
-	tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
-	dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	if (!imx6_pcie_cmp_enabled) {
+		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
+		tmp &= ~PCI_EXP_LNKCAP_SLS;
+		tmp |= PCI_EXP_LNKCAP_SLS_2_5GB;
+		dw_pcie_writel_dbi(pci, offset + PCI_EXP_LNKCAP, tmp);
+	}
 
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
@@ -812,9 +815,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
-	imx6_pcie_clk_disable(imx6_pcie);
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
-		regulator_disable(imx6_pcie->vpcie);
+	if (!imx6_pcie_cmp_enabled) {
+		imx6_pcie_clk_disable(imx6_pcie);
+		if (imx6_pcie->vpcie
+		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
+			regulator_disable(imx6_pcie->vpcie);
+	}
 	return ret;
 }
 
@@ -1010,6 +1016,17 @@ static const struct dev_pm_ops imx6_pcie_pm_ops = {
 				      imx6_pcie_resume_noirq)
 };
 
+static int __init imx6_pcie_compliance_test_enable(char *str)
+{
+	if (!strcmp(str, "yes")) {
+		pr_info("Enable the i.MX PCIe TX/CLK compliance tests mode.\n");
+		imx6_pcie_cmp_enabled = 1;
+	}
+	return 1;
+}
+
+__setup("pcie_cmp_enabled=", imx6_pcie_compliance_test_enable);
+
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1187,8 +1204,16 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
+	if (ret < 0) {
+		if (imx6_pcie_cmp_enabled) {
+			/* The PCIE clocks and powers wouldn't be turned off */
+			dev_info(dev, "To do the compliance tests.\n");
+			ret = 0;
+		} else {
+			dev_err(dev, "Unable to add pcie port.\n");
+		}
 		return ret;
+	}
 
 	if (pci_msi_enabled()) {
 		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-- 
2.25.1

