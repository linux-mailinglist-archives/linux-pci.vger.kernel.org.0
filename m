Return-Path: <linux-pci+bounces-9078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EE291286D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 16:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB318B2B98A
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 14:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06A02940F;
	Fri, 21 Jun 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf1Lt1AV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA2631;
	Fri, 21 Jun 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718981365; cv=none; b=dGqZ8yEGDxK9soeF8qOvN20QiXDt+5VcbWyOGizgj0QaWro2UUyj3krerUKyDz0VOJVGe/Kme6nPAoRNdY5Q/5lIUy/f1msoKTtetBM4krThorNU8/4mA1k85EW3R7fobD34HUMrW5KFHnhiwt3mBnrdL+4/EQ78msCPX9KT57k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718981365; c=relaxed/simple;
	bh=3VLI8OQdCKrhE9tY0hosw/h2d6zYp15wqf38orILu+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ux34tBuySqoj1ewyoeb5E+akMHqgn5UOM6XVfFMA58AOT7UFQZzpxrWR2EDm5r8qG3QU1MCHMRVXgArMiVcbSoYSjQfjGp0prEp7nBh0TJ/CxH71aUtnbQOTTBRvmehdp8BrbxnFQ+9AFKN7PQJEm11OX3lmZsiVQU4pwa3NHwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf1Lt1AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B49C2BBFC;
	Fri, 21 Jun 2024 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718981365;
	bh=3VLI8OQdCKrhE9tY0hosw/h2d6zYp15wqf38orILu+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gf1Lt1AVeQliImIOvD9+SbH6NUZx3gtZLg0AQrcNKq/lpAHLJ4th+RX5B9U9+ChnY
	 4abQlcJcDGhNOINIxZEndckSCU001V4z33j2tqF9skMpTkrvC62AyDYIUErf6ioAt1
	 csJ7VA77Ptw5Y9yxAAoyqCP8SH6xzhGyNilDzxjKtApJanwkc0uNiD0LYdyT/AnyTO
	 LynQ4KbKpY8gvaoHz8pjxDXDkbw9JhylakSXZKvIl0KAHGl0oVKf2JdLzx8ZoS012C
	 AF+9WGM9xDjzREfE31d+/CezPMz98gRqvmQJFR4Sewh3t7PSjB/dOF7S62Lxh3eccl
	 GfP72lVnlwy1Q==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
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
Subject: [PATCH 3/4] PCI: mediatek-gen3: rely on reset_bulk APIs for phy reset lines
Date: Fri, 21 Jun 2024 16:48:49 +0200
Message-ID: <e8ab615a56759a4832833211257d83f56bf64303.1718980864.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718980864.git.lorenzo@kernel.org>
References: <cover.1718980864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reset_bulk APIs to manage phy reset lines. This is a preliminary
patch in order to add Airoha EN7581 pcie support.

Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 49 ++++++++++++++++-----
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 4859bd875bc4..9842617795a9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -100,14 +100,21 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+#define MAX_NUM_PHY_RSTS		1
+
 struct mtk_gen3_pcie;
 
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @power_up: pcie power_up callback
+ * @phy_resets: phy reset lines SoC data.
  */
 struct mtk_pcie_soc {
 	int (*power_up)(struct mtk_gen3_pcie *pcie);
+	struct {
+		const char *id[MAX_NUM_PHY_RSTS];
+		int num_rsts;
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
+	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RSTS];
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -790,8 +797,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	int i, ret, num_rsts = pcie->soc->phy_resets.num_rsts;
 	struct resource *regs;
-	int ret;
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
 	if (!regs)
@@ -804,12 +811,13 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 	pcie->reg_base = regs->start;
 
-	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
-	if (IS_ERR(pcie->phy_reset)) {
-		ret = PTR_ERR(pcie->phy_reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "failed to get PHY reset\n");
+	for (i = 0; i < num_rsts; i++)
+		pcie->phy_resets[i].id = pcie->soc->phy_resets.id[i];
 
+	ret = devm_reset_control_bulk_get_optional_shared(dev, num_rsts,
+							  pcie->phy_resets);
+	if (ret) {
+		dev_err(dev, "failed to get PHY bulk reset\n");
 		return ret;
 	}
 
@@ -846,7 +854,12 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 	int err;
 
 	/* PHY power on and enable pipe clock */
-	reset_control_deassert(pcie->phy_reset);
+	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
+					  pcie->phy_resets);
+	if (err) {
+		dev_err(dev, "failed to deassert PHYs\n");
+		return err;
+	}
 
 	err = phy_init(pcie->phy);
 	if (err) {
@@ -882,7 +895,8 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 err_phy_on:
 	phy_exit(pcie->phy);
 err_phy_init:
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
+				  pcie->phy_resets);
 
 	return err;
 }
@@ -897,7 +911,8 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
+				  pcie->phy_resets);
 }
 
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
@@ -912,7 +927,13 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	 * The controller may have been left out of reset by the bootloader
 	 * so make sure that we get a clean start by asserting resets here.
 	 */
-	reset_control_assert(pcie->phy_reset);
+	reset_control_bulk_deassert(pcie->soc->phy_resets.num_rsts,
+				    pcie->phy_resets);
+	usleep_range(5000, 10000);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_rsts,
+				  pcie->phy_resets);
+	msleep(100);
+
 	reset_control_assert(pcie->mac_reset);
 	usleep_range(10, 20);
 
@@ -1090,6 +1111,10 @@ static const struct dev_pm_ops mtk_pcie_pm_ops = {
 
 static const struct mtk_pcie_soc mtk_pcie_soc_mt8192 = {
 	.power_up = mtk_pcie_power_up,
+	.phy_resets = {
+		.id[0] = "phy",
+		.num_rsts = 1,
+	},
 };
 
 static const struct of_device_id mtk_pcie_of_match[] = {
-- 
2.45.2


