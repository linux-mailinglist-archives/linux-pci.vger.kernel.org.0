Return-Path: <linux-pci+bounces-11172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D762945865
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 09:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8F6B23777
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F8216131A;
	Fri,  2 Aug 2024 07:06:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D515DBB9;
	Fri,  2 Aug 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722582396; cv=none; b=C7TDVzTknjNuKkNKzmRPDl4qxiwL7lbvzoYl9BtOzvqJvzvyltnZpw8YShF2mg251ftYZMIAercHoJPgX5fssBkj+5UEAY0dGc+eIFCLzEquZvYAwQPZaX1pAqjg+1IlxO/l7bmIhbsaS+S2dLpLdDYtjVMElzH410aMEXopvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722582396; c=relaxed/simple;
	bh=1766+04ZgFm/F1vZX4/9ie+I5nhRwku8Nn9ttdzdfmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D7cbaXzP12oktYnr9nDf8lEaEl45BTndejzkqlYOUZc9cuRKEjutHuEjnP5jh684tqJpwkv444b4HvvZmgow1rEhctIG8aq0xR30ZZNDNa7Ckw8I8HZ8SXljP/v5cQ1SZlQ49brqazNrw3QbyLWAIq/WJ7Jys5bA1OKHL7Xmznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBEE41A1F1F;
	Fri,  2 Aug 2024 09:06:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6541C1A0AEC;
	Fri,  2 Aug 2024 09:06:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E0911181D0FC;
	Fri,  2 Aug 2024 15:06:22 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	l.stach@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v5 2/5] ata: ahci_imx: Clean up code by using i.MX8Q HSIO PHY driver
Date: Fri,  2 Aug 2024 14:46:50 +0800
Message-Id: <1722581213-15221-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Clean up code by using PHY interface provided by the PHY driver under
PHY subsystem(drivers/phy/freescale/phy-fsl-imx8qm-hsio.c).

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/ata/ahci_imx.c | 365 +++++++++--------------------------------
 1 file changed, 80 insertions(+), 285 deletions(-)

diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index cb768f66f0a70..75258ed42d2ee 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -19,6 +19,7 @@
 #include <linux/libata.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/phy/phy.h>
 #include <linux/thermal.h>
 #include "ahci.h"
 
@@ -44,42 +45,6 @@ enum {
 	/* Clock Reset Register */
 	IMX_CLOCK_RESET				= 0x7f3f,
 	IMX_CLOCK_RESET_RESET			= 1 << 0,
-	/* IMX8QM HSIO AHCI definitions */
-	IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET	= 0x03,
-	IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET	= 0x09,
-	IMX8QM_SATA_PHY_IMPED_RATIO_85OHM	= 0x6c,
-	IMX8QM_LPCG_PHYX2_OFFSET		= 0x00000,
-	IMX8QM_CSR_PHYX2_OFFSET			= 0x90000,
-	IMX8QM_CSR_PHYX1_OFFSET			= 0xa0000,
-	IMX8QM_CSR_PHYX_STTS0_OFFSET		= 0x4,
-	IMX8QM_CSR_PCIEA_OFFSET			= 0xb0000,
-	IMX8QM_CSR_PCIEB_OFFSET			= 0xc0000,
-	IMX8QM_CSR_SATA_OFFSET			= 0xd0000,
-	IMX8QM_CSR_PCIE_CTRL2_OFFSET		= 0x8,
-	IMX8QM_CSR_MISC_OFFSET			= 0xe0000,
-
-	IMX8QM_LPCG_PHYX2_PCLK0_MASK		= (0x3 << 16),
-	IMX8QM_LPCG_PHYX2_PCLK1_MASK		= (0x3 << 20),
-	IMX8QM_PHY_APB_RSTN_0			= BIT(0),
-	IMX8QM_PHY_MODE_SATA			= BIT(19),
-	IMX8QM_PHY_MODE_MASK			= (0xf << 17),
-	IMX8QM_PHY_PIPE_RSTN_0			= BIT(24),
-	IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0		= BIT(25),
-	IMX8QM_PHY_PIPE_RSTN_1			= BIT(26),
-	IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1		= BIT(27),
-	IMX8QM_STTS0_LANE0_TX_PLL_LOCK		= BIT(4),
-	IMX8QM_MISC_IOB_RXENA			= BIT(0),
-	IMX8QM_MISC_IOB_TXENA			= BIT(1),
-	IMX8QM_MISC_PHYX1_EPCS_SEL		= BIT(12),
-	IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1	= BIT(24),
-	IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0	= BIT(25),
-	IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1	= BIT(28),
-	IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0	= BIT(29),
-	IMX8QM_SATA_CTRL_RESET_N		= BIT(12),
-	IMX8QM_SATA_CTRL_EPCS_PHYRESET_N	= BIT(7),
-	IMX8QM_CTRL_BUTTON_RST_N		= BIT(21),
-	IMX8QM_CTRL_POWER_UP_RST_N		= BIT(23),
-	IMX8QM_CTRL_LTSSM_ENABLE		= BIT(4),
 };
 
 enum ahci_imx_type {
@@ -95,14 +60,10 @@ struct imx_ahci_priv {
 	struct clk *sata_clk;
 	struct clk *sata_ref_clk;
 	struct clk *ahb_clk;
-	struct clk *epcs_tx_clk;
-	struct clk *epcs_rx_clk;
-	struct clk *phy_apbclk;
-	struct clk *phy_pclk0;
-	struct clk *phy_pclk1;
-	void __iomem *phy_base;
-	struct gpio_desc *clkreq_gpiod;
 	struct regmap *gpr;
+	struct phy *sata_phy;
+	struct phy *cali_phy0;
+	struct phy *cali_phy1;
 	bool no_device;
 	bool first_time;
 	u32 phy_params;
@@ -450,201 +411,73 @@ ATTRIBUTE_GROUPS(fsl_sata_ahci);
 
 static int imx8_sata_enable(struct ahci_host_priv *hpriv)
 {
-	u32 val, reg;
-	int i, ret;
+	u32 val;
+	int ret;
 	struct imx_ahci_priv *imxpriv = hpriv->plat_data;
 	struct device *dev = &imxpriv->ahci_pdev->dev;
 
-	/* configure the hsio for sata */
-	ret = clk_prepare_enable(imxpriv->phy_pclk0);
-	if (ret < 0) {
-		dev_err(dev, "can't enable phy_pclk0.\n");
+	/*
+	 * Since "REXT" pin is only present for first lane of i.MX8QM
+	 * PHY, its calibration results will be stored, passed through
+	 * to the second lane PHY, and shared with all three lane PHYs.
+	 *
+	 * Initialize the first two lane PHYs here, although only the
+	 * third lane PHY is used by SATA.
+	 */
+	ret = phy_init(imxpriv->cali_phy0);
+	if (ret) {
+		dev_err(dev, "cali PHY init failed\n");
 		return ret;
 	}
-	ret = clk_prepare_enable(imxpriv->phy_pclk1);
-	if (ret < 0) {
-		dev_err(dev, "can't enable phy_pclk1.\n");
-		goto disable_phy_pclk0;
+	ret = phy_power_on(imxpriv->cali_phy0);
+	if (ret) {
+		dev_err(dev, "cali PHY power on failed\n");
+		goto err_cali_phy0_exit;
 	}
-	ret = clk_prepare_enable(imxpriv->epcs_tx_clk);
-	if (ret < 0) {
-		dev_err(dev, "can't enable epcs_tx_clk.\n");
-		goto disable_phy_pclk1;
+	ret = phy_init(imxpriv->cali_phy1);
+	if (ret) {
+		dev_err(dev, "cali PHY1 init failed\n");
+		goto err_cali_phy0_off;
 	}
-	ret = clk_prepare_enable(imxpriv->epcs_rx_clk);
-	if (ret < 0) {
-		dev_err(dev, "can't enable epcs_rx_clk.\n");
-		goto disable_epcs_tx_clk;
+	ret = phy_power_on(imxpriv->cali_phy1);
+	if (ret) {
+		dev_err(dev, "cali PHY1 power on failed\n");
+		goto err_cali_phy1_exit;
 	}
-	ret = clk_prepare_enable(imxpriv->phy_apbclk);
-	if (ret < 0) {
-		dev_err(dev, "can't enable phy_apbclk.\n");
-		goto disable_epcs_rx_clk;
+	ret = phy_init(imxpriv->sata_phy);
+	if (ret) {
+		dev_err(dev, "sata PHY init failed\n");
+		goto err_cali_phy1_off;
 	}
-	/* Configure PHYx2 PIPE_RSTN */
-	regmap_read(imxpriv->gpr, IMX8QM_CSR_PCIEA_OFFSET +
-			IMX8QM_CSR_PCIE_CTRL2_OFFSET, &val);
-	if ((val & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
-		/* The link of the PCIEA of HSIO is down */
-		regmap_update_bits(imxpriv->gpr,
-				IMX8QM_CSR_PHYX2_OFFSET,
-				IMX8QM_PHY_PIPE_RSTN_0 |
-				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0,
-				IMX8QM_PHY_PIPE_RSTN_0 |
-				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_0);
+	ret = phy_set_mode(imxpriv->sata_phy, PHY_MODE_SATA);
+	if (ret) {
+		dev_err(dev, "unable to set SATA PHY mode\n");
+		goto err_sata_phy_exit;
 	}
-	regmap_read(imxpriv->gpr, IMX8QM_CSR_PCIEB_OFFSET +
-			IMX8QM_CSR_PCIE_CTRL2_OFFSET, &reg);
-	if ((reg & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
-		/* The link of the PCIEB of HSIO is down */
-		regmap_update_bits(imxpriv->gpr,
-				IMX8QM_CSR_PHYX2_OFFSET,
-				IMX8QM_PHY_PIPE_RSTN_1 |
-				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1,
-				IMX8QM_PHY_PIPE_RSTN_1 |
-				IMX8QM_PHY_PIPE_RSTN_OVERRIDE_1);
-	}
-	if (((reg | val) & IMX8QM_CTRL_LTSSM_ENABLE) == 0) {
-		/* The links of both PCIA and PCIEB of HSIO are down */
-		regmap_update_bits(imxpriv->gpr,
-				IMX8QM_LPCG_PHYX2_OFFSET,
-				IMX8QM_LPCG_PHYX2_PCLK0_MASK |
-				IMX8QM_LPCG_PHYX2_PCLK1_MASK,
-				0);
+	ret = phy_power_on(imxpriv->sata_phy);
+	if (ret) {
+		dev_err(dev, "sata PHY power up failed\n");
+		goto err_sata_phy_exit;
 	}
 
-	/* set PWR_RST and BT_RST of csr_pciea */
-	val = IMX8QM_CSR_PCIEA_OFFSET + IMX8QM_CSR_PCIE_CTRL2_OFFSET;
-	regmap_update_bits(imxpriv->gpr,
-			val,
-			IMX8QM_CTRL_BUTTON_RST_N,
-			IMX8QM_CTRL_BUTTON_RST_N);
-	regmap_update_bits(imxpriv->gpr,
-			val,
-			IMX8QM_CTRL_POWER_UP_RST_N,
-			IMX8QM_CTRL_POWER_UP_RST_N);
-
-	/* PHYX1_MODE to SATA */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_PHYX1_OFFSET,
-			IMX8QM_PHY_MODE_MASK,
-			IMX8QM_PHY_MODE_SATA);
+	/* The cali_phy# can be turned off after SATA PHY is initialized. */
+	phy_power_off(imxpriv->cali_phy1);
+	phy_exit(imxpriv->cali_phy1);
+	phy_power_off(imxpriv->cali_phy0);
+	phy_exit(imxpriv->cali_phy0);
 
-	/*
-	 * BIT0 RXENA 1, BIT1 TXENA 0
-	 * BIT12 PHY_X1_EPCS_SEL 1.
-	 */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_MISC_OFFSET,
-			IMX8QM_MISC_IOB_RXENA,
-			IMX8QM_MISC_IOB_RXENA);
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_MISC_OFFSET,
-			IMX8QM_MISC_IOB_TXENA,
-			0);
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_MISC_OFFSET,
-			IMX8QM_MISC_PHYX1_EPCS_SEL,
-			IMX8QM_MISC_PHYX1_EPCS_SEL);
-	/*
-	 * It is possible, for PCIe and SATA are sharing
-	 * the same clock source, HPLL or external oscillator.
-	 * When PCIe is in low power modes (L1.X or L2 etc),
-	 * the clock source can be turned off. In this case,
-	 * if this clock source is required to be toggling by
-	 * SATA, then SATA functions will be abnormal.
-	 * Set the override here to avoid it.
-	 */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_MISC_OFFSET,
-			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1 |
-			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0 |
-			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1 |
-			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0,
-			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_1 |
-			IMX8QM_MISC_CLKREQN_OUT_OVERRIDE_0 |
-			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_1 |
-			IMX8QM_MISC_CLKREQN_IN_OVERRIDE_0);
-
-	/* clear PHY RST, then set it */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_SATA_OFFSET,
-			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N,
-			0);
-
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_SATA_OFFSET,
-			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N,
-			IMX8QM_SATA_CTRL_EPCS_PHYRESET_N);
-
-	/* CTRL RST: SET -> delay 1 us -> CLEAR -> SET */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_SATA_OFFSET,
-			IMX8QM_SATA_CTRL_RESET_N,
-			IMX8QM_SATA_CTRL_RESET_N);
-	udelay(1);
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_SATA_OFFSET,
-			IMX8QM_SATA_CTRL_RESET_N,
-			0);
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_SATA_OFFSET,
-			IMX8QM_SATA_CTRL_RESET_N,
-			IMX8QM_SATA_CTRL_RESET_N);
-
-	/* APB reset */
-	regmap_update_bits(imxpriv->gpr,
-			IMX8QM_CSR_PHYX1_OFFSET,
-			IMX8QM_PHY_APB_RSTN_0,
-			IMX8QM_PHY_APB_RSTN_0);
-
-	for (i = 0; i < 100; i++) {
-		reg = IMX8QM_CSR_PHYX1_OFFSET +
-			IMX8QM_CSR_PHYX_STTS0_OFFSET;
-		regmap_read(imxpriv->gpr, reg, &val);
-		val &= IMX8QM_STTS0_LANE0_TX_PLL_LOCK;
-		if (val == IMX8QM_STTS0_LANE0_TX_PLL_LOCK)
-			break;
-		udelay(1);
-	}
-
-	if (val != IMX8QM_STTS0_LANE0_TX_PLL_LOCK) {
-		dev_err(dev, "TX PLL of the PHY is not locked\n");
-		ret = -ENODEV;
-	} else {
-		writeb(imxpriv->imped_ratio, imxpriv->phy_base +
-				IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET);
-		writeb(imxpriv->imped_ratio, imxpriv->phy_base +
-				IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET);
-		reg = readb(imxpriv->phy_base +
-				IMX8QM_SATA_PHY_RX_IMPED_RATIO_OFFSET);
-		if (unlikely(reg != imxpriv->imped_ratio))
-			dev_info(dev, "Can't set PHY RX impedance ratio.\n");
-		reg = readb(imxpriv->phy_base +
-				IMX8QM_SATA_PHY_TX_IMPED_RATIO_OFFSET);
-		if (unlikely(reg != imxpriv->imped_ratio))
-			dev_info(dev, "Can't set PHY TX impedance ratio.\n");
-		usleep_range(50, 100);
-
-		/*
-		 * To reduce the power consumption, gate off
-		 * the PHY clks
-		 */
-		clk_disable_unprepare(imxpriv->phy_apbclk);
-		clk_disable_unprepare(imxpriv->phy_pclk1);
-		clk_disable_unprepare(imxpriv->phy_pclk0);
-		return ret;
-	}
+	return 0;
 
-	clk_disable_unprepare(imxpriv->phy_apbclk);
-disable_epcs_rx_clk:
-	clk_disable_unprepare(imxpriv->epcs_rx_clk);
-disable_epcs_tx_clk:
-	clk_disable_unprepare(imxpriv->epcs_tx_clk);
-disable_phy_pclk1:
-	clk_disable_unprepare(imxpriv->phy_pclk1);
-disable_phy_pclk0:
-	clk_disable_unprepare(imxpriv->phy_pclk0);
+err_sata_phy_exit:
+	phy_exit(imxpriv->sata_phy);
+err_cali_phy1_off:
+	phy_power_off(imxpriv->cali_phy1);
+err_cali_phy1_exit:
+	phy_exit(imxpriv->cali_phy1);
+err_cali_phy0_off:
+	phy_power_off(imxpriv->cali_phy0);
+err_cali_phy0_exit:
+	phy_exit(imxpriv->cali_phy0);
 
 	return ret;
 }
@@ -698,6 +531,9 @@ static int imx_sata_enable(struct ahci_host_priv *hpriv)
 		}
 	} else if (imxpriv->type == AHCI_IMX8QM) {
 		ret = imx8_sata_enable(hpriv);
+		if (ret)
+			goto disable_clk;
+
 	}
 
 	usleep_range(1000, 2000);
@@ -736,8 +572,10 @@ static void imx_sata_disable(struct ahci_host_priv *hpriv)
 		break;
 
 	case AHCI_IMX8QM:
-		clk_disable_unprepare(imxpriv->epcs_rx_clk);
-		clk_disable_unprepare(imxpriv->epcs_tx_clk);
+		if (imxpriv->sata_phy) {
+			phy_power_off(imxpriv->sata_phy);
+			phy_exit(imxpriv->sata_phy);
+		}
 		break;
 
 	default:
@@ -760,6 +598,9 @@ static void ahci_imx_error_handler(struct ata_port *ap)
 
 	ahci_error_handler(ap);
 
+	if (imxpriv->type == AHCI_IMX8QM)
+		return;
+
 	if (!(imxpriv->first_time) || ahci_imx_hotplug)
 		return;
 
@@ -986,65 +827,19 @@ static const struct scsi_host_template ahci_platform_sht = {
 
 static int imx8_sata_probe(struct device *dev, struct imx_ahci_priv *imxpriv)
 {
-	struct resource *phy_res;
-	struct platform_device *pdev = imxpriv->ahci_pdev;
-	struct device_node *np = dev->of_node;
-
-	if (of_property_read_u32(np, "fsl,phy-imp", &imxpriv->imped_ratio))
-		imxpriv->imped_ratio = IMX8QM_SATA_PHY_IMPED_RATIO_85OHM;
-	phy_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
-	if (phy_res) {
-		imxpriv->phy_base = devm_ioremap(dev, phy_res->start,
-					resource_size(phy_res));
-		if (!imxpriv->phy_base) {
-			dev_err(dev, "error with ioremap\n");
-			return -ENOMEM;
-		}
-	} else {
-		dev_err(dev, "missing *phy* reg region.\n");
-		return -ENOMEM;
-	}
-	imxpriv->gpr =
-		 syscon_regmap_lookup_by_phandle(np, "hsio");
-	if (IS_ERR(imxpriv->gpr)) {
-		dev_err(dev, "unable to find gpr registers\n");
-		return PTR_ERR(imxpriv->gpr);
-	}
-
-	imxpriv->epcs_tx_clk = devm_clk_get(dev, "epcs_tx");
-	if (IS_ERR(imxpriv->epcs_tx_clk)) {
-		dev_err(dev, "can't get epcs_tx_clk clock.\n");
-		return PTR_ERR(imxpriv->epcs_tx_clk);
-	}
-	imxpriv->epcs_rx_clk = devm_clk_get(dev, "epcs_rx");
-	if (IS_ERR(imxpriv->epcs_rx_clk)) {
-		dev_err(dev, "can't get epcs_rx_clk clock.\n");
-		return PTR_ERR(imxpriv->epcs_rx_clk);
-	}
-	imxpriv->phy_pclk0 = devm_clk_get(dev, "phy_pclk0");
-	if (IS_ERR(imxpriv->phy_pclk0)) {
-		dev_err(dev, "can't get phy_pclk0 clock.\n");
-		return PTR_ERR(imxpriv->phy_pclk0);
-	}
-	imxpriv->phy_pclk1 = devm_clk_get(dev, "phy_pclk1");
-	if (IS_ERR(imxpriv->phy_pclk1)) {
-		dev_err(dev, "can't get phy_pclk1 clock.\n");
-		return PTR_ERR(imxpriv->phy_pclk1);
-	}
-	imxpriv->phy_apbclk = devm_clk_get(dev, "phy_apbclk");
-	if (IS_ERR(imxpriv->phy_apbclk)) {
-		dev_err(dev, "can't get phy_apbclk clock.\n");
-		return PTR_ERR(imxpriv->phy_apbclk);
-	}
-
-	/* Fetch GPIO, then enable the external OSC */
-	imxpriv->clkreq_gpiod = devm_gpiod_get_optional(dev, "clkreq",
-				GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
-	if (IS_ERR(imxpriv->clkreq_gpiod))
-		return PTR_ERR(imxpriv->clkreq_gpiod);
-	if (imxpriv->clkreq_gpiod)
-		gpiod_set_consumer_name(imxpriv->clkreq_gpiod, "SATA CLKREQ");
-
+	imxpriv->sata_phy = devm_phy_get(dev, "sata-phy");
+	if (IS_ERR(imxpriv->sata_phy))
+		return dev_err_probe(dev, PTR_ERR(imxpriv->sata_phy),
+				     "Failed to get sata_phy\n");
+
+	imxpriv->cali_phy0 = devm_phy_get(dev, "cali-phy0");
+	if (IS_ERR(imxpriv->cali_phy0))
+		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy0),
+				     "Failed to get cali_phy0\n");
+	imxpriv->cali_phy1 = devm_phy_get(dev, "cali-phy1");
+	if (IS_ERR(imxpriv->cali_phy1))
+		return dev_err_probe(dev, PTR_ERR(imxpriv->cali_phy1),
+				     "Failed to get cali_phy1\n");
 	return 0;
 }
 
-- 
2.37.1


