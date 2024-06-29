Return-Path: <linux-pci+bounces-9447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8B891CD78
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 15:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31D9B21871
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5601080C09;
	Sat, 29 Jun 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+7CE/N7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1071DA5F;
	Sat, 29 Jun 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719669170; cv=none; b=rtR7euh2Eox2cEtahIfMH+V7hGd1WRY1Q6Hccfo9cVYdDXrmsaOMV+79+ea1V38Kb0wco8P6eu98C1EKCNDvCOUJwtT6KY/BLfZv7UF0Euv0md82FIoltf2TD10wGC27oaoFoiQUflCaGmSHRET1UybP7ElVP8Mo/PBiVf5Gfy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719669170; c=relaxed/simple;
	bh=ls/SqHqY4sxV0pnIchGY0YEezbSz8kVL0vfy29uohco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWZop8XM7VT5cWXgU0lKuu4Vhiun4pHKNlqe1ZyQaPsxKKeEti58XwkU/SKjoiKlNnsfUtTwiYyWKeYKG9/6rSsiXm+rs+QhTLHOx0p+1PpfEpD+Kt8Yc72Nh0yL41mQ1ESSR5NT6AV8dbo9f9D10x1bEx5L4nVF5Jt0vov3XG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+7CE/N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1484C32789;
	Sat, 29 Jun 2024 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719669170;
	bh=ls/SqHqY4sxV0pnIchGY0YEezbSz8kVL0vfy29uohco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o+7CE/N7v8nczU6h3C7+Tc5lk58ViZFK7TWhcmAh3HKqH31J0Zmx4jXoXSNWcJ9ot
	 su5o8Qk93CNMMKctK3Zkiq2ax0t87Wq7CFVUdU7SOn5rYC3gXC5xCpLzVJhlST7Pom
	 BqTIgSy5KHKooY8uf7PN7Re8T5f2yYQADSSEEw42efI4FbbovkeOE4M+w7g+/D/SgY
	 74owezVkIsiHy7voXgh5AiEcwMZ7qiJCkDGVox/EHLZxWRsKMF12uOHyoEICu/4B/0
	 NSFN44KkGeaax4QzYg9yQEsxfgEPdsi0HOEjpQ+r6lcsRtSs8Nl0mI6u+adZ1yQGnQ
	 8+JaUOUgEK2Yw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v3 3/4] PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
Date: Sat, 29 Jun 2024 15:51:53 +0200
Message-ID: <0f97a1e2ee4c5771e459807c47ea5caa3a6c6a09.1719668763.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719668763.git.lorenzo@kernel.org>
References: <cover.1719668763.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reset_bulk APIs to manage PHY reset lines. This is a preliminary
patch in order to add Airoha EN7581 PCIe support.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 45 +++++++++++++++------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index db0210803731..438a5222d986 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -100,14 +100,21 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+#define MAX_NUM_PHY_RESETS		1
+
 struct mtk_gen3_pcie;
 
 /**
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
+ * @phy_resets: phy reset lines SoC data.
  */
 struct mtk_gen3_pcie_pdata {
 	int (*power_up)(struct mtk_gen3_pcie *pcie);
+	struct {
+		const char *id[MAX_NUM_PHY_RESETS];
+		int num_resets;
+	} phy_resets;
 };
 
 /**
@@ -128,7 +135,7 @@ struct mtk_msi_set {
  * @base: IO mapped register base
  * @reg_base: physical register base
  * @mac_reset: MAC reset control
- * @phy_reset: PHY reset control
+ * @phy_resets: PHY reset controllers
  * @phy: PHY controller block
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
@@ -148,7 +155,7 @@ struct mtk_gen3_pcie {
 	void __iomem *base;
 	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
-	struct reset_control *phy_reset;
+	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RESETS];
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -788,10 +795,10 @@ static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 
 static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
+	int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
-	int ret;
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
 	if (!regs)
@@ -804,12 +811,12 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 	pcie->reg_base = regs->start;
 
-	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
-	if (IS_ERR(pcie->phy_reset)) {
-		ret = PTR_ERR(pcie->phy_reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get PHY reset\n");
+	for (i = 0; i < num_resets; i++)
+		pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
 
+	ret = devm_reset_control_bulk_get_optional_shared(dev, num_resets, pcie->phy_resets);
+	if (ret) {
+		dev_err(dev, "failed to get PHY bulk reset\n");
 		return ret;
 	}
 
@@ -846,7 +853,11 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	int err;
 
 	/* PHY power on and enable pipe clock */
-	reset_control_deassert(pcie->phy_reset);
+	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+	if (err) {
+		dev_err(dev, "failed to deassert PHYs\n");
+		return err;
+	}
 
 	err = phy_init(pcie->phy);
 	if (err) {
@@ -882,7 +893,7 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 err_phy_on:
 	phy_exit(pcie->phy);
 err_phy_init:
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 
 	return err;
 }
@@ -897,7 +908,7 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 }
 
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
@@ -908,11 +919,17 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		return err;
 
+	/*
+	 * Deassert the line in order to avoid unbalance in deassert_count
+	 * counter since the bulk is shared.
+	 */
+	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 	/*
 	 * The controller may have been left out of reset by the bootloader
 	 * so make sure that we get a clean start by asserting resets here.
 	 */
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+
 	reset_control_assert(pcie->mac_reset);
 	usleep_range(10, 20);
 
@@ -1090,6 +1107,10 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 
 static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
 	.power_up = mtk_pcie_power_up,
+	.phy_resets = {
+		.id[0] = "phy",
+		.num_resets = 1,
+	},
 };
 
 static const struct of_device_id mtk_pcie_of_match[] = {
-- 
2.45.2


