Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3D341799
	for <lists+linux-pci@lfdr.de>; Fri, 19 Mar 2021 09:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhCSIh7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Mar 2021 04:37:59 -0400
Received: from inva021.nxp.com ([92.121.34.21]:41450 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234399AbhCSIhl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Mar 2021 04:37:41 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E301920530D;
        Fri, 19 Mar 2021 09:37:39 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4A98320271D;
        Fri, 19 Mar 2021 09:37:33 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EE295402D2;
        Fri, 19 Mar 2021 09:37:24 +0100 (CET)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH 3/3] PCI: imx: clear vreg bypass when pcie vph voltage is 3v3
Date:   Fri, 19 Mar 2021 16:24:07 +0800
Message-Id: <1616142247-13789-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616142247-13789-1-git-send-email-hongxing.zhu@nxp.com>
References: <1616142247-13789-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both 1.8v and 3.3v power supplies can be feeded to i.MX8MQ PCIe PHY.
In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
the VREG_BYPASS bits of GPR registers should be cleared from default
value 1b'1 to 1b'0.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 853ea8e82952..c35d5511b55b 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -37,6 +37,7 @@
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
+#define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
@@ -611,6 +612,10 @@ static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct device *dev = pci->dev;
+	struct device_node *node = dev->of_node;
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 		/*
@@ -621,6 +626,16 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 				   imx6_pcie_grp_offset(imx6_pcie),
 				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
 				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		/*
+		 * Regarding to the datasheet, the PCIE_VPH is suggested
+		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
+		 * VREG_BYPASS should be cleared to zero.
+		 */
+		if (of_property_read_bool(node, "pcie-vph-3v3"))
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+					   imx6_pcie_grp_offset(imx6_pcie),
+					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+					   0);
 		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-- 
2.17.1

