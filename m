Return-Path: <linux-pci+bounces-44759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37796D1FE43
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA453098445
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1979139E6C2;
	Wed, 14 Jan 2026 15:36:55 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24F39E162;
	Wed, 14 Jan 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405015; cv=none; b=UReiGI+KujBIxisva25xUhLel6/WEsvsqpvW4qyduNpIOfhFZ+1QZ4FWzWv8Eyq1mctM5u2LDr8XnVNuucnpqNqjX39PYAOU9Z1ibDiA2cbX+1efmtWWuNIGK7ASy8A341bVhBRgFIJhcEWBMDTzd4TSFnPxul+L9+eB0pGyNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405015; c=relaxed/simple;
	bh=8cQJJvnMXYVvy7aMxgApvCKGphaaKO/87ll7T2/12VI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEAVJT+/TndSGtgS2Epor4R9KbyaHPWDbR9ANUPF/JV/yRI748IAPPkkPSKlqvQEsl28XvT4oIeCPjiTT+oq/LbahP5TtRCQpCcWiXtL9sGDj4LHQJfDfDAwDy7sZQjXXsRmWQIx9KO2u2SXMm+b5hDbvprQfBm+p5L4EnmwDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Xk+HL/2OTumuUfgOSJ+hcQ==
X-CSE-MsgGUID: clDLddJlSayctEfHGu8sfw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:52 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B3B04022B3E;
	Thu, 15 Jan 2026 00:36:46 +0900 (JST)
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
Subject: [PATCH 12/16] PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
Date: Wed, 14 Jan 2026 16:33:33 +0100
Message-ID: <20260114153337.46765-13-john.madieu.xa@bp.renesas.com>
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

Add support for the PCIe controller found in RZ/G3E SoCs to the existing
RZ/G3S PCIe host driver. The RZ/G3E PCIe controller is similar to the
RZ/G3S's, with the following key differences:

 - Supports PCIe Gen3 (8.0 GT/s) link speeds alongside Gen2 (5.0 GT/s)
 - Uses a different reset control mechanism via AXI registers instead
   of the Linux reset framework
 - Requires specific SYSC configuration for link state control and
   Root Complex mode selection

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 231 ++++++++++++++++++++---
 1 file changed, 209 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index b0a5c08d2527..b046360e92da 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -111,6 +111,16 @@
 #define RZG3S_PCI_PERM_CFG_HWINIT_EN		BIT(2)
 #define RZG3S_PCI_PERM_PIPE_PHY_REG_EN		BIT(1)
 
+/* RZ/G3E specific registers */
+#define RZG3E_PCI_RESET				0x310
+#define RZG3E_PCI_RESET_RST_OUT_B		BIT(6)
+#define RZG3E_PCI_RESET_RST_PS_B		BIT(5)
+#define RZG3E_PCI_RESET_RST_LOAD_B		BIT(4)
+#define RZG3E_PCI_RESET_RST_CFG_B		BIT(3)
+#define RZG3E_PCI_RESET_RST_RSM_B		BIT(2)
+#define RZG3E_PCI_RESET_RST_GP_B		BIT(1)
+#define RZG3E_PCI_RESET_RST_B			BIT(0)
+
 #define RZG3S_PCI_MSIRE(id)			(0x600 + (id) * 0x10)
 #define RZG3S_PCI_MSIRE_ENA			BIT(0)
 
@@ -183,9 +193,13 @@ struct rzg3s_sysc_function {
 /**
  * struct rzg3s_sysc_info - RZ/G3S System Controller function info
  * @rst_rsm_b: Reset RSM_B function descriptor
+ * @l1_allow: L1 power state management function descriptor
+ * @mode: Mode configuration function descriptor
  */
 struct rzg3s_sysc_info {
 	struct rzg3s_sysc_function rst_rsm_b;
+	struct rzg3s_sysc_function l1_allow;
+	struct rzg3s_sysc_function mode;
 };
 
 /**
@@ -1201,6 +1215,10 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 	if (ret)
 		return ret;
 
+	/* Mandatory for RZ/G3E, harmless for RZ/G3S */
+	reset_control_bulk_assert(data->num_power_resets,
+				  host->power_resets);
+
 	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
 							      data->num_cfg_resets,
 							      host->cfg_resets);
@@ -1266,6 +1284,7 @@ static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
 
 static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 {
+	const struct rzg3s_sysc_info *sysc_info = host->sysc->info;
 	u32 val;
 	int ret;
 
@@ -1282,6 +1301,16 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	if (ret)
 		return ret;
 
+	/* Enable ASPM L1 transition for SoCs that use it */
+	if (sysc_info->l1_allow.mask) {
+		ret = regmap_update_bits(host->sysc->regmap,
+					 sysc_info->l1_allow.offset,
+					 sysc_info->l1_allow.mask,
+					 field_prep(sysc_info->l1_allow.mask, 1));
+		if (ret)
+			return ret;
+	}
+
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
 
@@ -1625,12 +1654,27 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 		goto port_refclk_put;
 	}
 
-	ret = regmap_update_bits(sysc->regmap,
-				 sysc->info->rst_rsm_b.offset,
-				 sysc->info->rst_rsm_b.mask,
-				 field_prep(sysc->info->rst_rsm_b.mask, 1));
-	if (ret)
-		goto port_refclk_put;
+	/*
+	 * Put controller in RC (Root Complex) mode for SoCs that
+	 * support it. These can operate in either EP or RC mode.
+	 */
+	if (sysc->info->mode.mask) {
+		ret = regmap_write(sysc->regmap,
+				   sysc->info->mode.offset,
+				   sysc->info->mode.mask);
+		if (ret)
+			goto port_refclk_put;
+	}
+
+	/* De-assert SYSC RST_RSM_B only if used by the SoC */
+	if (sysc->info->rst_rsm_b.mask) {
+		ret = regmap_update_bits(sysc->regmap,
+					 sysc->info->rst_rsm_b.offset,
+					 sysc->info->rst_rsm_b.mask,
+					 field_prep(sysc->info->rst_rsm_b.mask, 1));
+		if (ret)
+			goto port_refclk_put;
+	}
 
 	ret = rzg3s_pcie_resets_prepare_and_get(host);
 	if (ret)
@@ -1684,9 +1728,11 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	 * SYSC RST_RSM_B signal need to be asserted before turning off the
 	 * power to the PHY.
 	 */
-	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
-			   sysc->info->rst_rsm_b.mask,
-			   field_prep(sysc->info->rst_rsm_b.mask, 0));
+	if (sysc->info->rst_rsm_b.mask)
+		regmap_update_bits(sysc->regmap,
+				   sysc->info->rst_rsm_b.offset,
+				   sysc->info->rst_rsm_b.mask,
+				   field_prep(sysc->info->rst_rsm_b.mask, 0));
 port_refclk_put:
 	clk_put(host->port.refclk);
 
@@ -1721,11 +1767,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		goto cfg_reinit;
 
-	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
-				 sysc->info->rst_rsm_b.mask,
-				 field_prep(sysc->info->rst_rsm_b.mask, 0));
-	if (ret)
-		goto power_resets_restore;
+	/* Assert SYSC RST_RSM_B if supported */
+	if (sysc->info->rst_rsm_b.mask) {
+		ret = regmap_update_bits(sysc->regmap,
+					 sysc->info->rst_rsm_b.offset,
+					 sysc->info->rst_rsm_b.mask,
+					 field_prep(sysc->info->rst_rsm_b.mask, 0));
+		if (ret)
+			goto power_resets_restore;
+	}
 
 	return 0;
 
@@ -1748,11 +1798,23 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	struct rzg3s_sysc *sysc = host->sysc;
 	int ret;
 
-	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
-				 sysc->info->rst_rsm_b.mask,
-				 field_prep(sysc->info->rst_rsm_b.mask, 1));
-	if (ret)
-		return ret;
+	/* De-assert SYSC RST_RSM_B if supported */
+	if (sysc->info->rst_rsm_b.mask) {
+		ret = regmap_update_bits(sysc->regmap,
+					 sysc->info->rst_rsm_b.offset,
+					 sysc->info->rst_rsm_b.mask,
+					 field_prep(sysc->info->rst_rsm_b.mask, 1));
+		if (ret)
+			return ret;
+	}
+
+	if (sysc->info->mode.mask) {
+		ret = regmap_write(sysc->regmap,
+				   sysc->info->mode.offset,
+				   sysc->info->mode.mask);
+		if (ret)
+			return ret;
+	}
 
 	ret = rzg3s_pcie_power_resets_deassert(host);
 	if (ret)
@@ -1779,12 +1841,133 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
 	reset_control_bulk_assert(data->num_power_resets,
 				  host->power_resets);
 assert_rst_rsm_b:
-	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
-			   sysc->info->rst_rsm_b.mask,
-			   field_prep(sysc->info->rst_rsm_b.mask, 0));
+	if (sysc->info->rst_rsm_b.mask)
+		regmap_update_bits(sysc->regmap,
+				   sysc->info->rst_rsm_b.offset,
+				   sysc->info->rst_rsm_b.mask,
+				   field_prep(sysc->info->rst_rsm_b.mask, 0));
 	return ret;
 }
 
+/* RZ/G3E SoC-specific implementations */
+static void rzg3e_pcie_config_pre_init(struct rzg3s_pcie_host *host)
+{
+	/*
+	 * De-assert LOAD_B and CFG_B during configuration phase.
+	 * These are part of the RZ/G3E reset register, not reset framework.
+	 * Other reset bits remain asserted until cfg_post_init.
+	 */
+	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
+			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B,
+			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B);
+}
+
+static void rzg3e_cfg_deinit(struct rzg3s_pcie_host *host)
+{
+	writel_relaxed(0, host->axi + RZG3E_PCI_RESET);
+}
+
+static int rzg3e_cfg_post_init(struct rzg3s_pcie_host *host)
+{
+	/* De-assert PS_B, GP_B, RST_B */
+	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
+			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
+			       RZG3E_PCI_RESET_RST_B,
+			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
+			       RZG3E_PCI_RESET_RST_B);
+
+	/* Hardware requires >= 500us delay before final reset deassert */
+	fsleep(500);
+
+	/* De-assert OUT_B and RSM_B to complete reset sequence */
+	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
+			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B,
+			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B);
+
+	return 0;
+}
+
+static int rzg3e_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
+					  struct resource_entry *entry,
+					  int *index)
+{
+	u64 pci_addr = entry->res->start - entry->offset;
+	u64 cpu_addr = entry->res->start;
+	u64 cpu_end = entry->res->end;
+	int id = *index;
+	u64 size;
+
+	/*
+	 * The RZ/G3E requires power-of-2 sizes (4K * 2^N) due to mask register
+	 * format. Split non-power-of-2 regions into multiple windows to avoid
+	 * over-mapping.
+	 */
+	while (cpu_addr <= cpu_end) {
+		u64 remaining_size = cpu_end - cpu_addr + 1;
+		u64 align_limit;
+
+		if (id >= RZG3S_MAX_WINDOWS)
+			return dev_err_probe(host->dev, -ENOSPC,
+					     "Failed to map inbound window for resource (%s)\n",
+					     entry->res->name);
+
+		/* Start with largest power-of-two that fits in remaining size */
+		size = 1ULL << __fls(remaining_size);
+
+		/*
+		 * Find alignment limit - the largest power-of-two that both
+		 * addresses are aligned to
+		 */
+		align_limit = min(cpu_addr ? (1ULL << __ffs(cpu_addr)) : ~0ULL,
+				  pci_addr ? (1ULL << __ffs(pci_addr)) : ~0ULL);
+
+		/* Window size cannot exceed alignment */
+		size = min(size, align_limit);
+
+		/*
+		 * According to the RZ/G3E HW manual Rev.1.15,
+		 * (Section 6.6.4.1.3.(74) AXI Window Mask (Lower) Register):
+		 * The area which can be set is 4K * 2^N bytes.
+		 */
+		size = max(size, SZ_4K);
+
+		/*
+		 * HW expects size - 1 for mask register.
+		 * For example: 4KB (0x1000) becomes mask 0xfff (12 bits set).
+		 */
+		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr,
+					      size - 1, id);
+
+		cpu_addr += size;
+		pci_addr += size;
+		id++;
+	}
+	*index = id;
+
+	return 0;
+}
+
+static const char * const rzg3e_soc_power_resets[] = { "aresetn" };
+
+static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {
+	.power_resets = rzg3e_soc_power_resets,
+	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
+	.cfg_post_init = rzg3e_cfg_post_init,
+	.cfg_deinit = rzg3e_cfg_deinit,
+	.cfg_pre_init = rzg3e_pcie_config_pre_init,
+	.set_inbound_windows = rzg3e_pcie_set_inbound_windows,
+	.sysc_info = {
+		.l1_allow = {
+			.offset = 0x1020,
+			.mask = BIT(0),
+		},
+		.mode = {
+			.offset = 0x1024,
+			.mask = BIT(0),
+		},
+	},
+};
+
 static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
 				  rzg3s_pcie_resume_noirq)
@@ -1819,6 +2002,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
 		.compatible = "renesas,r9a08g045-pcie",
 		.data = &rzg3s_soc_data,
 	},
+	{
+		.compatible = "renesas,r9a09g047-pcie",
+		.data = &rzg3e_soc_data,
+	},
 	{}
 };
 
-- 
2.25.1


