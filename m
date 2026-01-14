Return-Path: <linux-pci+bounces-44753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E7D1FDFD
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63D8330C6CA9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D639E165;
	Wed, 14 Jan 2026 15:36:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDAF39C653;
	Wed, 14 Jan 2026 15:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404977; cv=none; b=pNVBXjsQ8FPkv0HVLiTIBkYKZvQlZNuZR/FuFF2oOPYQnWFQgOtIKuHm/Aby2tOaIyZuq66rFBb0eh2LTJWVLXpByOLBkf5ogX84oLdkLz9J3aQKmq7UoM7Ykhi3O3DKguSuvSFSirvJJCRvCwvZuhwPIxcB0esOESakGG+nJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404977; c=relaxed/simple;
	bh=Kl01Sgg/pHuGUxL1EE8imyL+ivBm8QSGwEwWRSRcuvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwSgcGl5NwWThFlXvY4llT4Bitot0EubdTEkP6o+ygLkHr7wHWcBmJ3pLPFLlscTB9e0xUP/hZS92jOQjLQG8Xq32zlRYKG/6pN++fHPBO5uIDMquN68JRI2FtTwtaKVL08WvLgK4WjCVRFpX51VnyNo8bcMhgNOL7jXLG85PaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: eBdP1K+oTFCnkHL2ATk5GQ==
X-CSE-MsgGUID: +Ie96CY+Q8KjTN/X88hwQw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:15 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CD69C4022B3F;
	Thu, 15 Jan 2026 00:36:09 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: claudiu.beznea.uj@bp.renesas.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	geert+renesas@glider.be,
	krzk+dt@kernel.org
Cc: robh@kernel.org,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	john.madieu@gmail.com,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: [PATCH 06/16] PCI: rzg3s-host: Make SYSC register offsets SoC-specific
Date: Wed, 14 Jan 2026 16:33:27 +0100
Message-ID: <20260114153337.46765-7-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding RZ/G3E support, move the RST_RSM_B register
offset and mask into a SoC-specific data structure. Compared with RZ/G3S,
the RZ/G3E SYSC controls different functionalities for the PCIe controller.

Make SYSC operations conditional on the presence of register offset
information, allowing the driver to handle SoCs that don't use the
RST_RSM_B signal.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 93 +++++++++++++++++-------
 1 file changed, 67 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 205b60421be1..44728771afa3 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -159,10 +159,6 @@
 
 #define RZG3S_PCI_CFG_PCIEC			0x60
 
-/* System controller registers */
-#define RZG3S_SYS_PCIE_RST_RSM_B		0xd74
-#define RZG3S_SYS_PCIE_RST_RSM_B_MASK		BIT(0)
-
 /* Maximum number of windows */
 #define RZG3S_MAX_WINDOWS			8
 
@@ -174,6 +170,34 @@
 /* Timeouts experimentally determined */
 #define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
 
+/**
+ * struct rzg3s_sysc_function - System Controller register function descriptor
+ * @offset: Register offset from the System Controller base address
+ * @mask: Bit mask for the function within the register
+ */
+struct rzg3s_sysc_function {
+	u32 offset;
+	u32 mask;
+};
+
+/**
+ * struct rzg3s_sysc_info - RZ/G3S System Controller function info
+ * @rst_rsm_b: Reset RSM_B function descriptor
+ */
+struct rzg3s_sysc_info {
+	struct rzg3s_sysc_function rst_rsm_b;
+};
+
+/**
+ * struct rzg3s_sysc - RZ/G3S System Controller descriptor
+ * @regmap: System controller regmap
+ * @info: System controller info
+ */
+struct rzg3s_sysc {
+	struct regmap *regmap;
+	const struct rzg3s_sysc_info *info;
+};
+
 /**
  * struct rzg3s_pcie_msi - RZ/G3S PCIe MSI data structure
  * @domain: IRQ domain
@@ -203,6 +227,7 @@ struct rzg3s_pcie_host;
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
  *              configuration
+ * @sysc_info: SYSC functionalities
  * @num_power_resets: number of power resets
  * @num_cfg_resets: number of configuration resets
  */
@@ -210,6 +235,7 @@ struct rzg3s_pcie_soc_data {
 	int (*init_phy)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
+	struct rzg3s_sysc_info sysc_info;
 	u8 num_power_resets;
 	u8 num_cfg_resets;
 };
@@ -233,7 +259,7 @@ struct rzg3s_pcie_port {
  * @dev: struct device
  * @power_resets: reset control signals that should be set after power up
  * @cfg_resets: reset control signals that should be set after configuration
- * @sysc: SYSC regmap
+ * @sysc: SYSC descriptor
  * @intx_domain: INTx IRQ domain
  * @data: SoC specific data
  * @msi: MSI data structure
@@ -248,7 +274,7 @@ struct rzg3s_pcie_host {
 	struct device *dev;
 	struct reset_control_bulk_data *power_resets;
 	struct reset_control_bulk_data *cfg_resets;
-	struct regmap *sysc;
+	struct rzg3s_sysc *sysc;
 	struct irq_domain *intx_domain;
 	const struct rzg3s_pcie_soc_data *data;
 	struct rzg3s_pcie_msi msi;
@@ -1516,6 +1542,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	struct device_node *sysc_np __free(device_node) =
 		of_parse_phandle(np, "renesas,sysc", 0);
 	struct rzg3s_pcie_host *host;
+	struct rzg3s_sysc *sysc;
 	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*host));
@@ -1527,6 +1554,13 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	host->data = device_get_match_data(dev);
 	platform_set_drvdata(pdev, host);
 
+	host->sysc = devm_kzalloc(dev, sizeof(*host->sysc), GFP_KERNEL);
+	if (!host->sysc)
+		return -ENOMEM;
+
+	sysc = host->sysc;
+	sysc->info = &host->data->sysc_info;
+
 	host->axi = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(host->axi))
 		return PTR_ERR(host->axi);
@@ -1540,15 +1574,16 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	host->sysc = syscon_node_to_regmap(sysc_np);
-	if (IS_ERR(host->sysc)) {
-		ret = PTR_ERR(host->sysc);
+	sysc->regmap = syscon_node_to_regmap(sysc_np);
+	if (IS_ERR(sysc->regmap)) {
+		ret = PTR_ERR(sysc->regmap);
 		goto port_refclk_put;
 	}
 
-	ret = regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
+	ret = regmap_update_bits(sysc->regmap,
+				 sysc->info->rst_rsm_b.offset,
+				 sysc->info->rst_rsm_b.mask,
+				 field_prep(sysc->info->rst_rsm_b.mask, 1));
 	if (ret)
 		goto port_refclk_put;
 
@@ -1601,9 +1636,9 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	 * SYSC RST_RSM_B signal need to be asserted before turning off the
 	 * power to the PHY.
 	 */
-	regmap_update_bits(host->sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
+			   sysc->info->rst_rsm_b.mask,
+			   field_prep(sysc->info->rst_rsm_b.mask, 0));
 port_refclk_put:
 	clk_put(host->port.refclk);
 
@@ -1615,7 +1650,7 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 	const struct rzg3s_pcie_soc_data *data = host->data;
 	struct rzg3s_pcie_port *port = &host->port;
-	struct regmap *sysc = host->sysc;
+	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
 	ret = pm_runtime_put_sync(dev);
@@ -1634,9 +1669,9 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		goto power_resets_restore;
 
-	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
+				 sysc->info->rst_rsm_b.mask,
+				 field_prep(sysc->info->rst_rsm_b.mask, 0));
 	if (ret)
 		goto cfg_resets_restore;
 
@@ -1659,12 +1694,12 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 {
 	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
 	const struct rzg3s_pcie_soc_data *data = host->data;
-	struct regmap *sysc = host->sysc;
+	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
-	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
+	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
+				 sysc->info->rst_rsm_b.mask,
+				 field_prep(sysc->info->rst_rsm_b.mask, 1));
 	if (ret)
 		return ret;
 
@@ -1693,9 +1728,9 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	reset_control_bulk_assert(data->num_power_resets,
 				  host->power_resets);
 assert_rst_rsm_b:
-	regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
-			   RZG3S_SYS_PCIE_RST_RSM_B_MASK,
-			   FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 0));
+	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
+			   sysc->info->rst_rsm_b.mask,
+			   field_prep(sysc->info->rst_rsm_b.mask, 0));
 	return ret;
 }
 
@@ -1718,6 +1753,12 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
 	.init_phy = rzg3s_soc_pcie_init_phy,
+	.sysc_info = {
+		.rst_rsm_b = {
+			.offset = 0xd74,
+			.mask = BIT(0),
+		},
+	},
 };
 
 static const struct of_device_id rzg3s_pcie_of_match[] = {
-- 
2.25.1


