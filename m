Return-Path: <linux-pci+bounces-14527-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC899E1DD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 10:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96764B22FA3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 08:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503CA1E3DCF;
	Tue, 15 Oct 2024 08:57:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D341E3764;
	Tue, 15 Oct 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982657; cv=none; b=m6l4jQx32mx9LX3o3kdWhUyoK756gc8Chru1ZnGor6/arBXXzmj6UyuLugn2y72qVS2fMhpk3ic5TPV4QgTTDfwOI4FDKXaWagqKKa6h+IzBCpuZYT/QcnM9EVmD/Q5/3NpG+lsb1F3DMHdzDJSExhTwVaL7i8ViRonVQA+5TDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982657; c=relaxed/simple;
	bh=XLuHT2gWt6Lu1VsW07p2NQcte1JWa1MLEnf3FvVYnsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dIAPdiEGW/NaRsUSw1vfowiEbSJpoXGxPZpKvNHhdeTH2K/5gMFk5f7MIBknJmz3e/1txXYz2x41WYrlsDkS6/0eksUhTFvptJ8qkIzqhTrd56IjU4tAPn4/Pdzhl9XKYRODx6f8IiLxmRYYfpCanAe2aPFGQk1zTp12v+TZY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDD2D201678;
	Tue, 15 Oct 2024 10:57:33 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A4F12024AE;
	Tue, 15 Oct 2024 10:57:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 56858183DC06;
	Tue, 15 Oct 2024 16:57:31 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	robh+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	festevam@gmail.com,
	s.hauer@pengutronix.de
Cc: hongxing.zhu@nxp.com,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 7/9] PCI: imx6: Use dwc common suspend resume method
Date: Tue, 15 Oct 2024 16:33:31 +0800
Message-Id: <1728981213-8771-8-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
References: <1728981213-8771-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Frank Li <Frank.Li@nxp.com>

Call common dwc suspend/resume function. Use dwc common iATU method to send
out PME_TURN_OFF message. Old platform such as iMX6SX and iMX6QP, iATU
CTRL2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't send out MSG
without data by dummy MMIO write. Without PCIE_ATU_INHIBIT_PAYLOAD, MSGD
will be sent out instead of MSG. So keep old method to send PME_TURN_OFF
MSG.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 97 ++++++++++-----------------
 1 file changed, 36 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 161daad34a94..baa853d84b4d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -82,6 +83,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
+#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(9)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -106,19 +108,18 @@ struct imx_pcie_drvdata {
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
+	const struct dw_pcie_host_ops *ops;
 };
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
-	bool			link_is_up;
 	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
-	struct reset_control	*turnoff_reset;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -898,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	imx_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-	imx_pcie->link_is_up = false;
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
@@ -1023,9 +1022,33 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 	return cpu_addr - entry->offset;
 }
 
+/*
+ * Old dwc iATU ctrl2 bit 22 (PCIE_ATU_INHIBIT_PAYLOAD) are reserved. So can't
+ * send out MSG without data by dummy MMIO write. Without
+ * PCIE_ATU_INHIBIT_PAYLOAD, MSGD will be sent out. So have to keep old method
+ * to send PME_TURN_OFF MSG.
+ */
+static void imx_pcie_pm_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+
+	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
+}
+
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.pme_turn_off = imx_pcie_pm_turn_off,
+};
+
+static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
+	.init = imx_pcie_host_init,
+	.deinit = imx_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1146,43 +1169,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	return 0;
 }
 
-static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
-{
-	struct device *dev = imx_pcie->pci->dev;
-
-	/* Some variants have a turnoff reset in DT */
-	if (imx_pcie->turnoff_reset) {
-		reset_control_assert(imx_pcie->turnoff_reset);
-		reset_control_deassert(imx_pcie->turnoff_reset);
-		goto pm_turnoff_sleep;
-	}
-
-	/* Others poke directly at IOMUXC registers */
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
-		break;
-	default:
-		dev_err(dev, "PME_Turn_Off not implemented\n");
-		return;
-	}
-
-	/*
-	 * Components with an upstream port must respond to
-	 * PME_Turn_Off with PME_TO_Ack but we can't check.
-	 *
-	 * The standard recommends a 1-10ms timeout after which to
-	 * proceed anyway as if acks were received.
-	 */
-pm_turnoff_sleep:
-	usleep_range(1000, 10000);
-}
-
 static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 {
 	u8 offset;
@@ -1206,36 +1192,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
-	imx_pcie_pm_turnoff(imx_pcie);
-	imx_pcie_stop_link(imx_pcie->pci);
-	imx_pcie_host_exit(pp);
-
-	return 0;
+	return dw_pcie_suspend_noirq(imx_pcie->pci);
 }
 
 static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx_pcie_host_init(pp);
+	ret = dw_pcie_resume_noirq(imx_pcie->pci);
 	if (ret)
 		return ret;
 	imx_pcie_msi_save_restore(imx_pcie, false);
-	dw_pcie_setup_rc(pp);
-
-	if (imx_pcie->link_is_up)
-		imx_pcie_start_link(imx_pcie->pci);
 
 	return 0;
 }
@@ -1267,11 +1243,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx_pcie_host_ops;
 
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
+	if (imx_pcie->drvdata->ops)
+		pci->pp.ops = imx_pcie->drvdata->ops;
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1340,13 +1319,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Grab turnoff reset */
-	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-	if (IS_ERR(imx_pcie->turnoff_reset)) {
-		dev_err(dev, "Failed to get TURNOFF reset control\n");
-		return PTR_ERR(imx_pcie->turnoff_reset);
-	}
-
 	if (imx_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
 		imx_pcie->iomuxc_gpr =
@@ -1425,6 +1397,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 	} else {
+		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			return ret;
@@ -1488,6 +1461,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1505,6 +1479,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


