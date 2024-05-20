Return-Path: <linux-pci+bounces-7651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB708C9989
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 09:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80F161C21277
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361831C6A1;
	Mon, 20 May 2024 07:48:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3451BF3B;
	Mon, 20 May 2024 07:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716191298; cv=none; b=pLpE1qEHYlyaMMoyp1tpzyxOULsdzkGR7lzDcTiLyMVBzmLm+yphq+PFPV8ADoVoTPegz3JFzLLgRa16PLVSzIivyHRQTjldyL0n5RViqTw29FdSi3I3Hwwifm+zbkn9GGgXP9yx6L8MaEbhW6BUiuJnjaHnpJIzz/Qt9v71CUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716191298; c=relaxed/simple;
	bh=RPwVR371vwqcPzKCeTxQpdlgzL4JcrpcXwhmXQjZd7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lkd9x+WCdOyLXlDPV7xcNFTRLiZcHMgfu/Pabf9TsLAGa5OPfhZhhVEZQeDhwJofi1G85reUiwx+yRH88N5xToxRdPgdGjYETKdBL9vSOLDR0o0zQw3LvEnn5x8d1GX0Wi2k+TkQZh5r0aFDdG8so60juQK7AAav7Z+qzj/pj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-IronPort-AV: E=Sophos;i="6.08,174,1712588400"; 
   d="scan'208";a="209031615"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 May 2024 16:43:04 +0900
Received: from localhost.localdomain (unknown [10.166.13.99])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BBE8D4005658;
	Mon, 20 May 2024 16:43:04 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org
Cc: marek.vasut+renesas@gmail.com,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v8 3/5] PCI: rcar-gen4: Add .ltssm_control() for other SoC support
Date: Mon, 20 May 2024 16:42:58 +0900
Message-Id: <20240520074300.125969-4-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
References: <20240520074300.125969-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sequence for controlling the LTSSM state machine is going to change
for SoCs like r8a779f0. So let's move the LTSSM code to a new callback
ltssm_control() and populate it for each SoCs.

This also warrants the addition of new compatibles for r8a779g0 and
r8a779h0. But since they are already part of the DT binding, it won't
make any difference.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c | 74 ++++++++++++++-------
 1 file changed, 50 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index b11e09505b0b..bcbf0a52890d 100644
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
@@ -506,6 +492,38 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
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
@@ -515,6 +533,14 @@ static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
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


