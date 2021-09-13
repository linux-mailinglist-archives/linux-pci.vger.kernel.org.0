Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6464D408471
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237417AbhIMGFp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 02:05:45 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56752 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237248AbhIMGFk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 02:05:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E92751A28B5;
        Mon, 13 Sep 2021 08:04:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86CE71A28AD;
        Mon, 13 Sep 2021 08:04:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 331D5183AD29;
        Mon, 13 Sep 2021 14:04:22 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 5/5] PCI: imx6: Add the compliance tests mode support
Date:   Mon, 13 Sep 2021 13:41:10 +0800
Message-Id: <1631511670-30164-6-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631511670-30164-1-git-send-email-hongxing.zhu@nxp.com>
References: <1631511670-30164-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Refer to the system board signal Quality of PCIe archiecture PHY test
specification. Signal quality tests(for example: jitters,  differential
eye opening and so on ) can be executed with devices in the
polling.compliance state.

To let the device support polling.compliance stat, the clocks and powers
shouldn't be turned off when the probe of device driver is failed.

Based on CLB(Compliance Load Board) Test Fixture and so on test
equipments, the PHY link would be down during the compliance tests.
Refer to this scenario, add the i.MX PCIe compliance tests mode enable
support, and keep the clocks and powers on, and finish the driver probe
without error return.

Use the "pci_imx6.compliance=1" in kernel command line to enable the
compliance tests mode.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 32 ++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index ab292d9cd528..39b6fe93f5e5 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -143,6 +143,10 @@ struct imx6_pcie {
 #define PHY_RX_OVRD_IN_LO_RX_DATA_EN		BIT(5)
 #define PHY_RX_OVRD_IN_LO_RX_PLL_EN		BIT(3)
 
+static bool imx6_pcie_cmp_mode;
+module_param_named(compliance, imx6_pcie_cmp_mode, bool, 0644);
+MODULE_PARM_DESC(compliance, "i.MX PCIe compliance test mode (1=compliance test mode enabled)");
+
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
@@ -812,10 +816,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
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
@@ -876,9 +882,12 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
 	imx6_pcie_reset_phy(imx6_pcie);
-	imx6_pcie_clk_disable(imx6_pcie);
-	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
-		regulator_disable(imx6_pcie->vpcie);
+	if (!imx6_pcie_cmp_mode) {
+		imx6_pcie_clk_disable(imx6_pcie);
+		if (imx6_pcie->vpcie
+		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
+			regulator_disable(imx6_pcie->vpcie);
+	}
 	return ret;
 }
 
@@ -1183,8 +1192,15 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
+	if (ret < 0) {
+		if (imx6_pcie_cmp_mode) {
+			dev_info(dev, "Driver loaded with compliance test mode enabled.\n");
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

