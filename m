Return-Path: <linux-pci+bounces-8584-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCFB903C39
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 14:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8DB3284EC7
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E917C216;
	Tue, 11 Jun 2024 12:51:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7217C7C4;
	Tue, 11 Jun 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110273; cv=none; b=bPChHH4nOP2mFLig2HotTbMO5BCvYiP0JdMEFy9b/r/GTexhTeYzFHM9Eb01wYFWvDvx+UHkM06gQRpa8kzqdxc8A1uNgvIpNp8vOeFig5Q/gx9tQIqaBAymgJ9CFhZoFMHEc7ZXijS8wAsv14d5umJZLKUA5DVcFl2igGCUSHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110273; c=relaxed/simple;
	bh=9dQE+RwT6RETJYtFT11HXGJ4dyyH+aZ2d4ouHjFWDso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WcaBWqt3Kt1k+M3Gr4UprehrkSXxWRKImZB4BdK+toolsQ8G8BDY8pnRClE954EPQPShDMgXBCnxcHuiEa6Uu3a92SucIf66UVJ6IHOaKCbOaNQY5F9EJw3BiDuUnSRxxMtkQAs/7bYLTNzdN7ISNy7my2H2d46mbxIjQZ4Ndns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,230,1712588400"; 
   d="scan'208";a="211455263"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 11 Jun 2024 21:51:06 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 163F140104EA;
	Tue, 11 Jun 2024 21:51:06 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v9 3/5] PCI: rcar-gen4: Add .ltssm_control() for other SoC support
Date: Tue, 11 Jun 2024 21:50:55 +0900
Message-Id: <20240611125057.1232873-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sequence for controlling the LTSSM state machine is going to change
for SoCs like r8a779f0. Move the LTSSM code to a new callback
ltssm_control() and populate it for each SoCs.

This also warrants the addition of new compatibles for r8a779g0 and
r8a779h0. But since they are already part of the DT binding, it won't
make any difference.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 74 ++++++++++++++-------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index eb3ea4a5fd0a..dac78388975d 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -48,7 +48,9 @@
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
 #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
 
+struct rcar_gen4_pcie;
 struct rcar_gen4_pcie_drvdata {
+	int (*ltssm_control)(struct rcar_gen4_pcie *rcar, bool enable);
 	enum dw_pcie_device_mode mode;
 };
 
@@ -61,27 +63,6 @@ struct rcar_gen4_pcie {
 #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
 
 /* Common */
-static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
-					bool enable)
-{
-	u32 val;
-
-	val = readl(rcar->base + PCIERSTCTRL1);
-	if (enable) {
-		val |= APP_LTSSM_ENABLE;
-		val &= ~APP_HOLD_PHY_RST;
-	} else {
-		/*
-		 * Since the datasheet of R-Car doesn't mention how to assert
-		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
-		 * hang-up issue happened in the dw_edma_core_off() when
-		 * the controller didn't detect a PCI device.
-		 */
-		val &= ~APP_LTSSM_ENABLE;
-	}
-	writel(val, rcar->base + PCIERSTCTRL1);
-}
-
 static int rcar_gen4_pcie_link_up(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
@@ -127,9 +108,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
 static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
-	int i, changes;
+	int i, changes, ret;
 
-	rcar_gen4_pcie_ltssm_enable(rcar, true);
+	if (rcar->drvdata->ltssm_control) {
+		ret = rcar->drvdata->ltssm_control(rcar, true);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Require direct speed change with retrying here if the link_gen is
@@ -157,7 +142,8 @@ static void rcar_gen4_pcie_stop_link(struct dw_pcie *dw)
 {
 	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
 
-	rcar_gen4_pcie_ltssm_enable(rcar, false);
+	if (rcar->drvdata->ltssm_control)
+		rcar->drvdata->ltssm_control(rcar, false);
 }
 
 static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
@@ -520,6 +506,38 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
 	rcar_gen4_pcie_unprepare(rcar);
 }
 
+static int r8a779f0_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable)
+{
+	u32 val;
+
+	val = readl(rcar->base + PCIERSTCTRL1);
+	if (enable) {
+		val |= APP_LTSSM_ENABLE;
+		val &= ~APP_HOLD_PHY_RST;
+	} else {
+		/*
+		 * Since the datasheet of R-Car doesn't mention how to assert
+		 * the APP_HOLD_PHY_RST, don't assert it again. Otherwise,
+		 * hang-up issue happened in the dw_edma_core_off() when
+		 * the controller didn't detect a PCI device.
+		 */
+		val &= ~APP_LTSSM_ENABLE;
+	}
+	writel(val, rcar->base + PCIERSTCTRL1);
+
+	return 0;
+}
+
+static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie = {
+	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.mode = DW_PCIE_RC_TYPE,
+};
+
+static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie_ep = {
+	.ltssm_control = r8a779f0_pcie_ltssm_control,
+	.mode = DW_PCIE_EP_TYPE,
+};
+
 static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
 	.mode = DW_PCIE_RC_TYPE,
 };
@@ -529,6 +547,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
 };
 
 static const struct of_device_id rcar_gen4_pcie_of_match[] = {
+	{
+		.compatible = "renesas,r8a779f0-pcie",
+		.data = &drvdata_r8a779f0_pcie,
+	},
+	{
+		.compatible = "renesas,r8a779f0-pcie-ep",
+		.data = &drvdata_r8a779f0_pcie_ep,
+	},
 	{
 		.compatible = "renesas,rcar-gen4-pcie",
 		.data = &drvdata_rcar_gen4_pcie,
-- 
2.25.1


