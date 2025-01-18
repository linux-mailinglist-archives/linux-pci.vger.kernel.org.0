Return-Path: <linux-pci+bounces-20099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7970AA15ED9
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 22:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A28727A2090
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2025 21:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B53119DF49;
	Sat, 18 Jan 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1E4EznQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51088126C13;
	Sat, 18 Jan 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737234453; cv=none; b=UeJmi6m/2i+1ZeyjYve41ATrc2J5TMnyNwPFZJzmdErta5iiRDLQDryhCfk+XLUNF5i7ny9hDdoWEq8S2rAWoVlgvxXE+3PU3NsBKboECV4diZEPr40+13E3fTbSh1JbLXnC9qDEdNFn+tRQnvouDYn+lEqrxkBVPFcgbXXZ4YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737234453; c=relaxed/simple;
	bh=wfuARqeDfE+vnCf8oueFJgLcQwDwNzKIC+ezgLq+m9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CEDrC2B2t6olqJqtLcC068G2r5t0IKuQnAmAm9zGImc01eVDSzUnfiV/X38Q1fjVa8RzffzaNQixmEwcWBEMslv8PRl/4G/oz7jUa1avTZm9+xiSsFiSb4hDWyGk3TfmPl9pLw7f+BjTTb47apI8n+uQc9wNE4a4g99LpPAcbpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1E4EznQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6DDC4CED1;
	Sat, 18 Jan 2025 21:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737234452;
	bh=wfuARqeDfE+vnCf8oueFJgLcQwDwNzKIC+ezgLq+m9M=;
	h=From:To:Cc:Subject:Date:From;
	b=e1E4EznQtsTJnJNrFAsQgiKUof9pyx3OXwfle/iWaduPJBa6gHZjOQ4sLKDcfgLl8
	 QSF4CLOYSjwDj6jYYUewKene5H5hN4W4wRhQIbqNFDxeze4inds7ic7nAl8lHC+Xlb
	 lyOqbTKHzf1+vV9/ACsEniMugZoto2W8t/5Dged+mU6+iVr/9gwsh7vRNTiOcKpAEo
	 QNtaMJhuTR5HrVafNSpmZElL9d22H2Mjavga6ZhT3O8OcThqIbEOxZOhOiM5aOr2eh
	 mRYUFET+XpwhR7FpcL1HR3+1kUFIcbK0UizFOOsjU2aDHm9llB2OBd/vTLOxKf7BEp
	 G6Xv+0EPR2AMw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PCI: imx6: Clean up comments and whitespace
Date: Sat, 18 Jan 2025 15:07:27 -0600
Message-Id: <20250118210727.795559-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

For readability, fix typos and comments that needlessly exceed 80 columns.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 41 ++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 06d22f23c6b3..d70e6c427976 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -236,11 +236,11 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
 
 	id = imx_pcie->controller_id;
 
-	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
+	/* If mode_mask is 0, generic PHY driver is used to set the mode */
 	if (!drvdata->mode_mask[0])
 		return;
 
-	/* If mode_mask[id] is zero, means each controller have its individual gpr */
+	/* If mode_mask[id] is 0, each controller has its individual GPR */
 	if (!drvdata->mode_mask[id])
 		id = 0;
 
@@ -377,14 +377,15 @@ static int pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u16 data)
 
 static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
-	/* TODO: Currently this code assumes external oscillator is being used */
+	/* TODO: This code assumes external oscillator is being used */
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			   imx_pcie_grp_offset(imx_pcie),
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
 			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
 	/*
-	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
-	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
+	 * Per the datasheet, the PCIE_VPH is suggested to be 1.8V.  If the
+	 * PCIE_VPH is supplied by 3.3V, the VREG_BYPASS should be cleared
+	 * to zero.
 	 */
 	if (imx_pcie->vph && regulator_get_voltage(imx_pcie->vph) > 3000000)
 		regmap_update_bits(imx_pcie->iomuxc_gpr,
@@ -571,7 +572,7 @@ static int imx_pcie_attach_pd(struct device *dev)
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
 	if (!link) {
-		dev_err(dev, "Failed to add device_link to pcie pd.\n");
+		dev_err(dev, "Failed to add device_link to pcie pd\n");
 		return -EINVAL;
 	}
 
@@ -584,7 +585,7 @@ static int imx_pcie_attach_pd(struct device *dev)
 			DL_FLAG_PM_RUNTIME |
 			DL_FLAG_RPM_ACTIVE);
 	if (!link) {
-		dev_err(dev, "Failed to add device_link to pcie_phy pd.\n");
+		dev_err(dev, "Failed to add device_link to pcie_phy pd\n");
 		return -EINVAL;
 	}
 
@@ -605,10 +606,10 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 		/* power up core phy and enable ref clock */
 		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
 		/*
-		 * the async reset input need ref clock to sync internally,
+		 * The async reset input need ref clock to sync internally,
 		 * when the ref clock comes after reset, internal synced
 		 * reset time is too short, cannot meet the requirement.
-		 * add one ~10us delay here.
+		 * Add a ~10us delay here.
 		 */
 		usleep_range(10, 100);
 		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
@@ -880,6 +881,7 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 
 		if (imx_pcie->drvdata->flags &
 		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
+
 			/*
 			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
 			 * from i.MX6 family when no link speed transition
@@ -888,7 +890,6 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 			 * which will cause the following code to report false
 			 * failure.
 			 */
-
 			ret = imx_pcie_wait_for_speed_change(imx_pcie);
 			if (ret) {
 				dev_err(dev, "Failed to bring link up!\n");
@@ -1091,15 +1092,16 @@ static const struct pci_epc_features imx8q_pcie_epc_features = {
 };
 
 /*
- * BAR#	| Default BAR enable	| Default BAR Type	| Default BAR Size	| BAR Sizing Scheme
- * ================================================================================================
- * BAR0	| Enable		| 64-bit		| 1 MB			| Programmable Size
- * BAR1	| Disable		| 32-bit		| 64 KB			| Fixed Size
- *        BAR1 should be disabled if BAR0 is 64bit.
- * BAR2	| Enable		| 32-bit		| 1 MB			| Programmable Size
- * BAR3	| Enable		| 32-bit		| 64 KB			| Programmable Size
- * BAR4	| Enable		| 32-bit		| 1M			| Programmable Size
- * BAR5	| Enable		| 32-bit		| 64 KB			| Programmable Size
+ *     	| Default  | Default | Default | BAR Sizing
+ * BAR#	| Enable?  | Type    | Size    | Scheme
+ * =======================================================
+ * BAR0	| Enable   | 64-bit  |  1 MB   | Programmable Size
+ * BAR1	| Disable  | 32-bit  | 64 KB   | Fixed Size
+ *       (BAR1 should be disabled if BAR0 is 64-bit)
+ * BAR2	| Enable   | 32-bit  |  1 MB   | Programmable Size
+ * BAR3	| Enable   | 32-bit  | 64 KB   | Programmable Size
+ * BAR4	| Enable   | 32-bit  |  1 MB   | Programmable Size
+ * BAR5	| Enable   | 32-bit  | 64 KB   | Programmable Size
  */
 static const struct pci_epc_features imx95_pcie_epc_features = {
 	.msi_capable = true,
@@ -1260,6 +1262,7 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		ret = imx_pcie_deassert_core_reset(imx_pcie);
 		if (ret)
 			return ret;
+
 		/*
 		 * Using PCIE_TEST_PD seems to disable MSI and powers down the
 		 * root complex. This is why we have to setup the rc again and
-- 
2.34.1


