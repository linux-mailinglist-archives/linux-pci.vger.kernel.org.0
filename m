Return-Path: <linux-pci+bounces-44756-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7164DD1FD05
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6CF3018373
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E507E39E183;
	Wed, 14 Jan 2026 15:36:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B69279327;
	Wed, 14 Jan 2026 15:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404995; cv=none; b=Lkrhs/M/z3NGdcNmQCcaR4RUjpAGXGNM02O8442ZBIQAcbZPCiHf/PAHCbVKWJKVtQC/upQiEBPk4ayaNumUPUgBcka18+X1jiDZ6YkDhu6hItz1f6ZSC95meYgrsKC7LsoyoJzGUe9wGUPXdWJSLKxDZa0ExVeSzeHCINZSZqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404995; c=relaxed/simple;
	bh=GMobP7Z5b8FErrZBMWIReenLE5Fa44Zt+dcAHrgOA+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQWnrX6pYrF7Vdj85Hy901ylqDyVFHXAFNssN+CsARzKeMQdIU7G6qoEZCsijTFb+EyB3zcuM6q/3eHfdNtCNjGrgTL9NEZVEzl6XH4tF0WHY7h0WE1jYlriKNtVIahIk3TxwgRmxpHHh4+4NqAecxylc4G+9wmhVu75oTG43bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: mW/33WO6SO6jEXeyRLP0ug==
X-CSE-MsgGUID: /5Q+khhATsGjgBZodFKg2A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:33 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 26F084022B3E;
	Thu, 15 Jan 2026 00:36:27 +0900 (JST)
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
Subject: [PATCH 09/16] PCI: rzg3s-host: Add SoC-specific configuration and initialization callbacks
Date: Wed, 14 Jan 2026 16:33:30 +0100
Message-ID: <20260114153337.46765-10-john.madieu.xa@bp.renesas.com>
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

Add optional cfg_pre_init, cfg_post_init, and cfg_deinit callbacks
to handle SoC-specific configuration methods. While RZ/G3S uses the Linux
reset framework with dedicated reset lines, other SoC variants like RZ/G3E
control configuration resets through PCIe AXI registers.

As Linux reset bulk API gracefully handles optional NULL reset lines
(num_cfg_resets = 0 for RZ/G3E), the driver continues to use the standard
reset framework when reset lines are available, while custom callbacks
are only invoked when provided.

This provides a balanced pattern where:
- RZ/G3S: Uses reset framework only, no callbacks needed
- RZ/G3E: Sets num_cfg_resets=0, provides cfg_pre_init/cfg_post_init/cfg_deinit
- In addition to that, RZ/G3E requires explicit cfg reset and clok turned off
  to put the PCIe IP in a known state.

Add cfg_pre_init, cfg_post_init, and cfg_deinit callbacks to support
custom configuration mechanism in preparation to RZ/G3E PCIe support.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 54 ++++++++++++++++++------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index a9773e5f25c7..bb071bacd0b2 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -224,6 +224,9 @@ struct rzg3s_pcie_host;
  * struct rzg3s_pcie_soc_data - SoC specific data
  * @init_phy: PHY initialization function
  * @set_inbound_windows: SoC-specific function to set up inbound windows
+ * @cfg_pre_init: Optional callback for SoC-specific pre-configuration
+ * @cfg_post_init: Optional callback for SoC-specific post-configuration
+ * @cfg_deinit: Optional callback for SoC-specific de-initialization
  * @power_resets: array with the resets that need to be de-asserted after
  *                power-on
  * @cfg_resets: array with the resets that need to be de-asserted after
@@ -237,6 +240,9 @@ struct rzg3s_pcie_soc_data {
 	int (*set_inbound_windows)(struct rzg3s_pcie_host *host,
 				   struct resource_entry *entry,
 				   int *index);
+	void (*cfg_pre_init)(struct rzg3s_pcie_host *host);
+	int (*cfg_post_init)(struct rzg3s_pcie_host *host);
+	void (*cfg_deinit)(struct rzg3s_pcie_host *host);
 	const char * const *power_resets;
 	const char * const *cfg_resets;
 	struct rzg3s_sysc_info sysc_info;
@@ -1119,6 +1125,12 @@ static void rzg3s_pcie_irq_init(struct rzg3s_pcie_host *host)
 	writel_relaxed(~0U, host->axi + RZG3S_PCI_MSGRCVIS);
 }
 
+static int rzg3s_cfg_post_init(struct rzg3s_pcie_host *host)
+{
+	return reset_control_bulk_deassert(host->data->num_cfg_resets,
+					   host->cfg_resets);
+}
+
 static int rzg3s_pcie_power_resets_deassert(struct rzg3s_pcie_host *host)
 {
 	const struct rzg3s_pcie_soc_data *data = host->data;
@@ -1233,6 +1245,10 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	u32 val;
 	int ret;
 
+	/* SoC-specific pre-configuration */
+	if (host->data->cfg_pre_init)
+		host->data->cfg_pre_init(host);
+
 	/* Initialize the PCIe related registers */
 	ret = rzg3s_pcie_config_init(host);
 	if (ret)
@@ -1245,8 +1261,8 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 	/* Initialize the interrupts */
 	rzg3s_pcie_irq_init(host);
 
-	ret = reset_control_bulk_deassert(host->data->num_cfg_resets,
-					  host->cfg_resets);
+	/* SoC-specific post-configuration */
+	ret = host->data->cfg_post_init(host);
 	if (ret)
 		goto disable_port_refclk;
 
@@ -1257,14 +1273,17 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
 				 PCIE_LINK_WAIT_SLEEP_MS * MILLI *
 				 PCIE_LINK_WAIT_MAX_RETRIES);
 	if (ret)
-		goto cfg_resets_deassert;
+		goto cfg_deinit;
 
 	val = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 	dev_info(host->dev, "PCIe link status [0x%x]\n", val);
 
 	return 0;
 
-cfg_resets_deassert:
+cfg_deinit:
+	if (host->data->cfg_deinit)
+		host->data->cfg_deinit(host);
+
 	reset_control_bulk_assert(host->data->num_cfg_resets,
 				  host->cfg_resets);
 disable_port_refclk:
@@ -1609,6 +1628,9 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto rpm_disable;
 
+	if (host->data->cfg_deinit)
+		host->data->cfg_deinit(host);
+
 	raw_spin_lock_init(&host->hw_lock);
 
 	ret = rzg3s_pcie_host_setup(host, rzg3s_pcie_init_irqdomain,
@@ -1663,32 +1685,35 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
 
 	clk_disable_unprepare(port->refclk);
 
-	ret = reset_control_bulk_assert(data->num_power_resets,
-					host->power_resets);
-	if (ret)
-		goto refclk_restore;
+	/* SoC-specific de-initialization */
+	if (data->cfg_deinit)
+		data->cfg_deinit(host);
 
 	ret = reset_control_bulk_assert(data->num_cfg_resets,
 					host->cfg_resets);
 	if (ret)
-		goto power_resets_restore;
+		goto cfg_reinit;
+
+	ret = reset_control_bulk_assert(data->num_power_resets,
+					host->power_resets);
+	if (ret)
+		goto cfg_reinit;
 
 	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
 				 sysc->info->rst_rsm_b.mask,
 				 field_prep(sysc->info->rst_rsm_b.mask, 0));
 	if (ret)
-		goto cfg_resets_restore;
+		goto power_resets_restore;
 
 	return 0;
 
 	/* Restore the previous state if any error happens */
-cfg_resets_restore:
-	reset_control_bulk_deassert(data->num_cfg_resets,
-				    host->cfg_resets);
 power_resets_restore:
 	reset_control_bulk_deassert(data->num_power_resets,
 				    host->power_resets);
-refclk_restore:
+cfg_reinit:
+	data->cfg_post_init(host);
+
 	clk_prepare_enable(port->refclk);
 	pm_runtime_resume_and_get(dev);
 	return ret;
@@ -1756,6 +1781,7 @@ static const struct rzg3s_pcie_soc_data rzg3s_soc_data = {
 	.num_power_resets = ARRAY_SIZE(rzg3s_soc_power_resets),
 	.cfg_resets = rzg3s_soc_cfg_resets,
 	.num_cfg_resets = ARRAY_SIZE(rzg3s_soc_cfg_resets),
+	.cfg_post_init = rzg3s_cfg_post_init,
 	.init_phy = rzg3s_soc_pcie_init_phy,
 	.set_inbound_windows = rzg3s_pcie_set_inbound_windows,
 	.sysc_info = {
-- 
2.25.1


