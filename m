Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C657D4BD635
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 07:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbiBUGo0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 01:44:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345521AbiBUGoT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 01:44:19 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C96F3BBC3;
        Sun, 20 Feb 2022 22:42:18 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0532E1A2158;
        Mon, 21 Feb 2022 07:42:17 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C25061A214E;
        Mon, 21 Feb 2022 07:42:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 52EBF183ABE7;
        Mon, 21 Feb 2022 14:42:15 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v4 2/2] PCI: imx6: Enable i.MX6QP PCIe power management support
Date:   Mon, 21 Feb 2022 14:33:57 +0800
Message-Id: <1645425237-4071-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
References: <1645425237-4071-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX6QP PCIe supports the reset logic, thus it can reset itself to the
initialized state when exit from L2 or L3 states.

Enable the i.MX6QP PCIe suspend/resume operations support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 784801f2f9e6..62262483470a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -995,6 +995,7 @@ static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 	/* Others poke directly at IOMUXC registers */
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
+	case IMX6QP:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
 				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
@@ -1307,7 +1308,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
-			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
+			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
+			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 	},
 	[IMX7D] = {
-- 
2.25.1

