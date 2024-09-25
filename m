Return-Path: <linux-pci+bounces-13494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C1E985323
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 08:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C25128243B
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2024 06:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4E15854F;
	Wed, 25 Sep 2024 06:47:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2E155C98;
	Wed, 25 Sep 2024 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727246834; cv=none; b=WxW0fX9eR5UGABF6zgoK2A71AoaLYmlWFM7dEoeG5yZS+/37XapulZJ5EktZCvoG9ZPiN3ocPd7tXcd2CkGfIolhifr5fYLtdaaa+zKFqBDISXbbTRzLwJkXC7vnYoUN2kQPig2hLrZwhSOyB4aEv2utROCzYuz9Dsn5xXBXLXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727246834; c=relaxed/simple;
	bh=7ZpNiD7tY5SBAwXzJX0hhcSxJEYI1B75yTGDjOyP1Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gK6f3lYA5lwFJwLiHRtPUgxd6RcXOb23UYib+SGrx7xQSE0nG2hMtRyduWOg8Z51f+nuHuNTbq/vNDsEG6AHbDI9hOZcUlJki81EFHEajiM2KbE/fno2x9fcbZdRb9fT0tUsvIUpzvIMA8emD67L1SvC6jvqcOjmgfRbDG9idAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AE8C7200CA9;
	Wed, 25 Sep 2024 08:47:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 72AF22003B4;
	Wed, 25 Sep 2024 08:47:10 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 58D8B183AD46;
	Wed, 25 Sep 2024 14:47:08 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 6/9] PCI: imx6: Make *_enable_ref_clk() function symmetric
Date: Wed, 25 Sep 2024 14:24:34 +0800
Message-Id: <1727245477-15961-7-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
References: <1727245477-15961-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Ensure the *_enable_ref_clk() function is symmetric by addressing missing
disable parts on some platforms. Also, remove the duplicate
imx7d_pcie_init_phy() function as it is the same as
imx7d_pcie_enable_ref_clk().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 33 +++++++++++----------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index f306f2e9dcce..5ec43d9f9784 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -388,13 +388,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-
-	return 0;
-}
-
 static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -593,13 +586,13 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable)
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 	return 0;
 }
 
+
 static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	if (enable) {
@@ -625,19 +618,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
-	if (enable) {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-	}
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
 	return 0;
 }
 
 static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (!enable)
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 	return 0;
 }
 
@@ -1522,7 +1516,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
 	},
-- 
2.37.1


