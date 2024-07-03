Return-Path: <linux-pci+bounces-9738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DD09265CA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 18:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689A71C20988
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 16:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31411181CE4;
	Wed,  3 Jul 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLbLlPWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0995D442C;
	Wed,  3 Jul 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023203; cv=none; b=bWgQOYLRXFSbI6rJqhWFZVaip0CjRc0bDefBzrdFM38Q2gbLY+8u6IzUCPNQbUlRPzZXw25CcQFbwxkwGV/dp1f9LSrwPQLilO/nE3CTsheBjJmAIewZWwaD9ek6g/ssLaSB+JZPvPFzLgbnfrlHUbmSBJyQ8cfEMeQ1NJWwx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023203; c=relaxed/simple;
	bh=ls/SqHqY4sxV0pnIchGY0YEezbSz8kVL0vfy29uohco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zkx5CMA0PULfH3XGLYSB3Nc9w3mcknnTEuavbt3SCWEu69T4MVl5HtUREk7cOx0n6drd6Seqd9LBOwKp/7D7imtAFL0lxo/xKdRTNgBONKxc6IeqtidlHD0AOrNY+f+wHMBg1ZfuZ/6sMybBOdWW+EVZsGumbQ3FFZqN8bYj990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLbLlPWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3407AC4AF0F;
	Wed,  3 Jul 2024 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720023202;
	bh=ls/SqHqY4sxV0pnIchGY0YEezbSz8kVL0vfy29uohco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLbLlPWkzZ/kZ7xAkLl6OzqxVRm9p4zb3AzFmwM6w6Sn9HDgA/Wwc9UB4aGnWb5sC
	 Ui6DJ7oQEEZ96A4QSih2CWIqf2La6+YsUncXPyvRfkIcUFLHcanpQ6WKx5AIB2RUZ/
	 i/4JXMrxaq+nWr4q5lsS9wmFL3yAQdIqrZMTrZ2aDu4Z3DGI+N8VJkTPl3pQX2GdFH
	 fIWlnyD4TOdznNav9un6vWafI7srYN5dZ2+ATKpfOpJH1f+z9lJFDyf5YYIu3Sm6Ye
	 HMGnQ6X1mWy8eTa2AzVbvpBwZvrFCiiJMPpjbLyWfvC7sFQ9261OYFXQR9SSaNqAZe
	 4qrXdCrV17OEQ==
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
Subject: [PATCH v4 3/4] PCI: mediatek-gen3: Rely on reset_bulk APIs for PHY reset lines
Date: Wed,  3 Jul 2024 18:12:43 +0200
Message-ID: <3ceb83bc0defbcf868521f8df4b9100e55ec2614.1720022580.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720022580.git.lorenzo@kernel.org>
References: <cover.1720022580.git.lorenzo@kernel.org>
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


