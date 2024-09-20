Return-Path: <linux-pci+bounces-13316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AC97D2B9
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B8A2870F2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 08:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3B770E8;
	Fri, 20 Sep 2024 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY10/WQx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C8B54277
	for <linux-pci@vger.kernel.org>; Fri, 20 Sep 2024 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820818; cv=none; b=AZTbmEZ2gop5fWuGAGcyqD7EaJgCnk026WQ0oKcr7LAf8T/7mVe+q9grCorEnMmvWvq1sJi9vVg6i89WDRvM2JJZbns/ucqTQE9EW7P7W1kjfgXueI/oPbhWnHShwOJTXtG+zZL7SvR9fq7J3u9DI7H0s/nbxSdlmFNB8EbVJ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820818; c=relaxed/simple;
	bh=H2LIdhRhxjrQJxmI8WnB/ccDyKadwdonPwj1FgH9vyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=aAOAkV+Gp62okG1LOPTI28tvI50oWcfFNtRzCdF4znTE9t4Zfn/aDplCkWDiCxC4KnKTgsxbtSkRMLelWykpdAq29vHLMXNfwEtY15x8Ui1WU+56W7rzZUkUnhdh0G1GRM0LWcAHv2nW/8IwKS19YGx9ThkxB8+mD+jm7DS16V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY10/WQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137D5C4CEC3;
	Fri, 20 Sep 2024 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820818;
	bh=H2LIdhRhxjrQJxmI8WnB/ccDyKadwdonPwj1FgH9vyY=;
	h=From:Date:Subject:To:Cc:From;
	b=ZY10/WQxYCoIIGfMOa4HuotBRNkoyiE89E0ugP8t83zxHzwswrodZOLx9Awxoitjn
	 16dX9XDKE8rmUZw/GRe+4LBtmxcb23m9XNTeB9W033fQiFTa/XBr8f/78RT5H7D/NM
	 ZXxF3zmcD7Wnu2S5bTz25EupL1KRwgsXudcM04pUwmIakT3e9nhoVk/xnbW3vSVylD
	 FRx1rxABxJYtzqirpT6Aj5o/0R6V3+uxjLQnyIif3fbCeKNqz75FdVMENf7IP0us3n
	 aQkBFPa+i6RqMWoWsBPZ922+ELtu+Hy9RY8LcWLGWCNrbB5LDJCqNUNd+VeuJDKpug
	 kn6kRznFtH8DQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 20 Sep 2024 10:26:28 +0200
Subject: [PATCH] PCI: mediatek-gen3: Avoid PCIe resetting for Airoha EN7581
 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-pcie-en7581-rst-fix-v1-1-1043fb63ffc9@kernel.org>
X-B4-Tracking: v=1; b=H4sIALMx7WYC/x2MQQqAIBAAvxJ7bsG1Musr0SFsq71YaEQg/j3pO
 AMzCSIH4QhjlSDwI1FOX4DqCtyx+J1R1sKglW7VoBVeThjZ950lDPHGTV60ZMh01lHjWijlFbj
 o/zrNOX+xlYJgZQAAAA==
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, Hui Ma <hui.ma@airoha.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.1

The PCIe controller available on the EN7581 SoC does not support reset
via the following lines:
- PCIE_MAC_RSTB
- PCIE_PHY_RSTB
- PCIE_BRG_RSTB
- PCIE_PE_RSTB

Introduce the reset callback in order to avoid resetting the PCIe port
for Airoha EN7581 SoC.

Tested-by: Hui Ma <hui.ma@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 44 ++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 5c19abac74e8..9cea67e92d98 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -128,10 +128,12 @@ struct mtk_gen3_pcie;
 /**
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
+ * @reset: pcie reset callback
  * @phy_resets: phy reset lines SoC data.
  */
 struct mtk_gen3_pcie_pdata {
 	int (*power_up)(struct mtk_gen3_pcie *pcie);
+	void (*reset)(struct mtk_gen3_pcie *pcie);
 	struct {
 		const char *id[MAX_NUM_PHY_RESETS];
 		int num_resets;
@@ -373,6 +375,28 @@ static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 }
 
+static void mtk_pcie_reset(struct mtk_gen3_pcie *pcie)
+{
+	u32 val;
+
+	/* Assert all reset signals */
+	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
+	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+
+	/*
+	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
+	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
+	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+	 * for the power and clock to become stable.
+	 */
+	msleep(100);
+
+	/* De-assert reset signals */
+	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
+	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+}
+
 static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 {
 	struct resource_entry *entry;
@@ -402,22 +426,9 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
 	writel_relaxed(val, pcie->base + PCIE_MISC_CTRL_REG);
 
-	/* Assert all reset signals */
-	val = readl_relaxed(pcie->base + PCIE_RST_CTRL_REG);
-	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
-	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
-
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal)
-	 * and 2.2.1 (Initial Power-Up (G3 to S0)).
-	 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
-	 * for the power and clock to become stable.
-	 */
-	msleep(100);
-
-	/* De-assert reset signals */
-	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB);
-	writel_relaxed(val, pcie->base + PCIE_RST_CTRL_REG);
+	/* Reset the PCIe port if requested by the hw */
+	if (pcie->soc->reset)
+		pcie->soc->reset(pcie);
 
 	/* Check if the link is up or not */
 	err = readl_poll_timeout(pcie->base + PCIE_LINK_STATUS_REG, val,
@@ -1207,6 +1218,7 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 
 static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
 	.power_up = mtk_pcie_power_up,
+	.reset = mtk_pcie_reset,
 	.phy_resets = {
 		.id[0] = "phy",
 		.num_resets = 1,

---
base-commit: f2024903cb387971abdbc6398a430e735a9b394c
change-id: 20240920-pcie-en7581-rst-fix-8161658c13c4

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


