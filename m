Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1304372E0
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhJVHkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:40:19 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56260 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232216AbhJVHkN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Oct 2021 03:40:13 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 30DB31A136E;
        Fri, 22 Oct 2021 09:37:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC8B31A06DC;
        Fri, 22 Oct 2021 09:37:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D7D86183AC94;
        Fri, 22 Oct 2021 15:37:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 6/7] PCI: imx6: Fix the reference handling unbalance when link never came up
Date:   Fri, 22 Oct 2021 15:12:29 +0800
Message-Id: <1634886750-13861-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
References: <1634886750-13861-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When link never came up, driver probe would be failed with error -110.
To keep usage counter balance of the clocks, powers and so on.

Add a new host_exit() callback for i.MX PCIe driver to handle this case
in the error handling after host_init.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index b752a673e767..c723df053574 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -875,7 +875,6 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
-	imx6_pcie_reset_phy(imx6_pcie);
 	return ret;
 }
 
@@ -899,8 +898,20 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
+static void imx6_pcie_host_exit(struct pcie_port *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx6_pcie *imx6_pcie = to_imx6_pcie(pci);
+
+	imx6_pcie_reset_phy(imx6_pcie);
+	imx6_pcie_clk_disable(imx6_pcie);
+	if (imx6_pcie->vpcie && regulator_is_enabled(imx6_pcie->vpcie) > 0)
+		regulator_disable(imx6_pcie->vpcie);
+}
+
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
+	.host_exit = imx6_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1180,12 +1191,8 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return ret;
 
 	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0) {
-		if (imx6_pcie->vpcie
-		    && regulator_is_enabled(imx6_pcie->vpcie) > 0)
-			regulator_disable(imx6_pcie->vpcie);
+	if (ret < 0)
 		return ret;
-	}
 
 	if (pci_msi_enabled()) {
 		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-- 
2.25.1

