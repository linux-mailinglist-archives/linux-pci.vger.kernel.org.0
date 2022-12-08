Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF32646926
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 07:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiLHG2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 01:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLHG2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 01:28:14 -0500
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBF47300;
        Wed,  7 Dec 2022 22:28:13 -0800 (PST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5F332004CB;
        Thu,  8 Dec 2022 07:28:11 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B0A5A2005B7;
        Thu,  8 Dec 2022 07:28:11 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6380D180031D;
        Thu,  8 Dec 2022 14:28:10 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v2] PCI: imx6: Save and restore MSI control of RC in suspend and resume
Date:   Thu,  8 Dec 2022 14:05:34 +0800
Message-Id: <1670479534-22154-1-git-send-email-hongxing.zhu@nxp.com>
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
re-stored during resume.

Save the MSI control during suspend, and restore it in resume.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
Changes v1-->v2:
New create one save/restore function, used save the setting in suspend and
restore the configuration in resume.
v1 https://patchwork.kernel.org/project/linux-pci/patch/1667289595-12440-1-git-send-email-hongxing.zhu@nxp.com/

---
 drivers/pci/controller/dwc/pci-imx6.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1dde5c579edc..aa3096890c3b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -76,6 +76,7 @@ struct imx6_pcie {
 	struct clk		*pcie;
 	struct clk		*pcie_aux;
 	struct regmap		*iomuxc_gpr;
+	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
@@ -1042,6 +1043,26 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	usleep_range(1000, 10000);
 }
 
+static void imx6_pcie_msi_save_restore(struct imx6_pcie *imx6_pcie, bool save)
+{
+	u8 offset;
+	u16 val;
+	struct dw_pcie *pci = imx6_pcie->pci;
+
+	if (pci_msi_enabled()) {
+		offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
+		if (save) {
+			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+			imx6_pcie->msi_ctrl = val;
+		} else {
+			dw_pcie_dbi_ro_wr_en(pci);
+			val = imx6_pcie->msi_ctrl;
+			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+			dw_pcie_dbi_ro_wr_dis(pci);
+		}
+	}
+}
+
 static int imx6_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
@@ -1050,6 +1071,7 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
+	imx6_pcie_msi_save_restore(imx6_pcie, true);
 	imx6_pcie_pm_turnoff(imx6_pcie);
 	imx6_pcie_stop_link(imx6_pcie->pci);
 	imx6_pcie_host_exit(pp);
@@ -1069,6 +1091,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	ret = imx6_pcie_host_init(pp);
 	if (ret)
 		return ret;
+	imx6_pcie_msi_save_restore(imx6_pcie, false);
 	dw_pcie_setup_rc(pp);
 
 	if (imx6_pcie->link_is_up)
-- 
2.25.1

