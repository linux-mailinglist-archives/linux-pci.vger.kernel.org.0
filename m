Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9239B02D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 04:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbhFDCHW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Jun 2021 22:07:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:40346 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhFDCHV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 22:07:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF9D21A145D;
        Fri,  4 Jun 2021 04:05:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com CF9D21A145D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1622772334;
        bh=/BToe/FFxBv0yDcLV2BovJaTgPClfSEPLPNvXr5XpSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atT81UcUxQoHg8qyG7NT7q43kzHpOQLwE8GHeweE5qc9CyDnqfMRvfbR6D4QnWxle
         e9pVhjQGHKqov+s29cYaFVVIQZetWOgvuQkzd8FAYBkFh6AkxGOfSl76VlBj0biB6V
         hHGBNdhf3kA5UIuQ1hONpq5kPtX3MSVWQ5+d0bdSKWl3JHyUNF34d5Qr7B8gwKnOsw
         /6Xdxxt5FWyYfLfHq1UVoqFnKf/z1MNdc2wnrlEoKguoZQfL0Jz2zvmzksKls1IJYL
         alDWYvd4Wx1KLwzfxDSVtNv/smEXNHnRGJ66sUbhC+EmDDvHwS0iAcQzkURjdZZsgN
         lkrZvEo2M4HcQ==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A52A1A2835;
        Fri,  4 Jun 2021 04:05:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 5A52A1A2835
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 776B54028B;
        Fri,  4 Jun 2021 10:05:22 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, kw@linux.com, bhelgaas@google.com,
        stefan@agner.ch, lorenzo.pieralisi@arm.com
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [RESEND, V5 2/2] PCI: imx6: Enable PHY internal regulator when supplied >3V
Date:   Fri,  4 Jun 2021 09:47:49 +0800
Message-Id: <1622771269-13844-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
References: <1622771269-13844-1-git-send-email-hongxing.zhu@nxp.com>
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

