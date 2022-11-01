Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740DB614592
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 09:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiKAIUo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Nov 2022 04:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiKAIUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Nov 2022 04:20:43 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC918394;
        Tue,  1 Nov 2022 01:20:42 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B81A1A03D2;
        Tue,  1 Nov 2022 09:20:41 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F38281A03FE;
        Tue,  1 Nov 2022 09:20:40 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A0624180222A;
        Tue,  1 Nov 2022 16:20:39 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v1] PCI: imx6: Set MSI enable bit of RC in resume
Date:   Tue,  1 Nov 2022 15:59:55 +0800
Message-Id: <1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The MSI Enable bit controls delivery of MSI interrupts from components
below the Root Port. This bit might lost during the suspend, should be
re-configured during resume.

Encapsulate the MSI enable set into a standalone function, and invoke it
in both probe and resume.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2616585ca5f8..dba15546075f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1041,6 +1041,21 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
+static void pci_imx_set_msi_en(struct dw_pcie *pci)
+{
+	u8 offset;
+	u16 val;
+
+	if (pci_msi_enabled()) {
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+		dw_pcie_dbi_ro_wr_en(pci);
+		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+		val |= PCI_MSI_FLAGS_ENABLE;
+		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1073,6 +1088,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	if (imx6_pcie->link_is_up)
 		imx6_pcie_start_link(imx6_pcie->pci);
 
+	pci_imx_set_msi_en(imx6_pcie->pci);
 	return 0;
 }
 
@@ -1090,7 +1106,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
 	int ret;
-	u16 val;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1282,12 +1297,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	if (pci_msi_enabled()) {
-		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-		val |= PCI_MSI_FLAGS_ENABLE;
-		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
-	}
+	pci_imx_set_msi_en(pci);
 
 	return 0;
 }
-- 
2.25.1

