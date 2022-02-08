Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458B4AD018
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 05:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346690AbiBHEGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 23:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346387AbiBHEGE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 23:06:04 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C31C0401E8;
        Mon,  7 Feb 2022 20:06:03 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AFD2D2006D2;
        Tue,  8 Feb 2022 04:57:03 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77A1C2006C9;
        Tue,  8 Feb 2022 04:57:03 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DF737183AC8A;
        Tue,  8 Feb 2022 11:57:01 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com, festevam@gmail.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v6 7/8] PCI: imx6: Disable enabled clocks and regulators after link is down
Date:   Tue,  8 Feb 2022 11:25:34 +0800
Message-Id: <1644290735-3797-8-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
References: <1644290735-3797-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since i.MX PCIe doesn't support the hot-plug, and to save power
consumption as much as possible. Return error and disable the enabled
clocks and regulators when link is down,.

Add a new host_exit() callback for i.MX PCIe driver to disable the
enabled clocks, regulators and so on in the error handling after
host_init is finished.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 30 ++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e165ad00989c..7a7d9204c6bc 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -848,7 +848,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
-	dw_pcie_wait_for_link(pci);
+	ret = dw_pcie_wait_for_link(pci);
+	if (ret)
+		goto err_reset_phy;
 
 	if (pci->link_gen == 2) {
 		/* Allow Gen2 mode after the link is up. */
@@ -884,7 +886,9 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		}
 
 		/* Make sure link training is finished as well! */
-		dw_pcie_wait_for_link(pci);
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_reset_phy;
 	} else {
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
@@ -897,7 +901,6 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
-	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
 
@@ -921,8 +924,29 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void imx6_pcie_host_exit(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct device *dev = pci->dev;
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	imx6_pcie_reset_phy(imx6_pcie);
+	imx6_pcie_clk_disable(imx6_pcie);
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX8MM:
+		if (phy_power_off(imx6_pcie->phy))
+			dev_err(dev, "unable to power off phy\n");
+		break;
+	default:
+		break;
+	}
+	if (imx6_pcie->vpcie)
+		regulator_disable(imx6_pcie->vpcie);
+}
+
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_exit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-- 
2.25.1

