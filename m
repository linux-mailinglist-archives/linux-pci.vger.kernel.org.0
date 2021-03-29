Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07C334C7B5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 10:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbhC2ISB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 04:18:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36172 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233242AbhC2IRV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 04:17:21 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8FBEF20503B;
        Mon, 29 Mar 2021 10:17:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7C35620504F;
        Mon, 29 Mar 2021 10:17:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EB56F402A8;
        Mon, 29 Mar 2021 10:17:03 +0200 (CEST)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 2/2] PCI: imx: clear vreg bypass when pcie vph voltage is 3v3
Date:   Mon, 29 Mar 2021 16:03:13 +0800
Message-Id: <1617004993-29728-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617004993-29728-1-git-send-email-hongxing.zhu@nxp.com>
References: <1617004993-29728-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both 1.8v and 3.3v power supplies can be used by i.MX8MQ PCIe PHY.
In default, the PCIE_VPH voltage is suggested to be 1.8v refer to data
sheet. When PCIE_VPH is supplied by 3.3v in the HW schematic design,
the VREG_BYPASS bits of GPR registers should be cleared from default
value 1b'1 to 1b'0. Thus, the internal 3v3 to 1v8 translator would be
turned on.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 853ea8e82952..94b43b4ecca1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -37,6 +37,7 @@
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN	BIT(10)
 #define IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE	BIT(11)
+#define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
@@ -80,6 +81,7 @@ struct imx6_pcie {
 	u32			tx_swing_full;
 	u32			tx_swing_low;
 	struct regulator	*vpcie;
+	struct regulator	*vph;
 	void __iomem		*phy_base;
 
 	/* power domain for pcie */
@@ -621,6 +623,17 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 				   imx6_pcie_grp_offset(imx6_pcie),
 				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
 				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+		/*
+		 * Regarding the datasheet, the PCIE_VPH is suggested
+		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
+		 * VREG_BYPASS should be cleared to zero.
+		 */
+		if (imx6_pcie->vph &&
+		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
+			regmap_update_bits(imx6_pcie->iomuxc_gpr,
+					   imx6_pcie_grp_offset(imx6_pcie),
+					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+					   0);
 		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1130,6 +1143,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		imx6_pcie->vpcie = NULL;
 	}
 
+	imx6_pcie->vph = devm_regulator_get_optional(&pdev->dev, "vph");
+	if (IS_ERR(imx6_pcie->vph)) {
+		if (PTR_ERR(imx6_pcie->vph) != -ENODEV)
+			return PTR_ERR(imx6_pcie->vph);
+		imx6_pcie->vph = NULL;
+	}
+
 	platform_set_drvdata(pdev, imx6_pcie);
 
 	ret = imx6_pcie_attach_pd(dev);
-- 
2.17.1

