Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79E393D57
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 08:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbhE1Gsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 May 2021 02:48:42 -0400
Received: from inva020.nxp.com ([92.121.34.13]:48778 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230281AbhE1Gsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 28 May 2021 02:48:40 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D0A01A1EB1;
        Fri, 28 May 2021 08:47:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 2D0A01A1EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1622184425;
        bh=/BToe/FFxBv0yDcLV2BovJaTgPClfSEPLPNvXr5XpSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=acXL8vz6i7GF7bAITiD8k3FdG93sp7U1wkhpNbDn1NinZDcEgkp5ZU6yvZd9yhT5c
         0Cr0A+E3GfcEPCE/H1E/3tr/9VkOL15CakloqIPL2ntD0+0J0gN7zfHaD770y7+ZbY
         atco/QeGirOn2/TO/Fblj0Jr9AlnL1p+MrJX9efPBY9GCEgSxMH7GXQmvAHrET68OW
         nymadA1fjsrWkgLp6PHFq+hj9dpamT3+QOyacLRVvfiODE1NTzGfE6+Kg5uqEQFtwe
         6t69P4FR41YQG8wZ9FavVwkao5PiJbzM2BZraFZ9u4dRqIlfuMtFRyKTmGsl2PAFpl
         T/XzEtDUBBr6A==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1311B1A1EA3;
        Fri, 28 May 2021 08:47:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 1311B1A1EA3
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AF1B940319;
        Fri, 28 May 2021 14:46:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     linux-pci@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 2/2] PCI: imx6: Enable PHY internal regulator when supplied >3V
Date:   Fri, 28 May 2021 14:29:43 +0800
Message-Id: <1622183383-3287-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
References: <1622183383-3287-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The i.MX8MQ PCIe PHY needs 1.8V in default but can be supplied by
either a 1.8V or a 3.3V regulator.

The "vph-supply" DT property tells us which external regulator
supplies the PHY. If that regulator supplies anything over 3V,
enable the PHY's internal 3.3V-to-1.8V regulator.

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

