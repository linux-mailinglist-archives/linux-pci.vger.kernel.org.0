Return-Path: <linux-pci+bounces-41540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB63C6BBDD
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 22:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBE74E19A2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 21:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F9307491;
	Tue, 18 Nov 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfALpphd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80F231A41;
	Tue, 18 Nov 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763502203; cv=none; b=hr+Gb+KVcleDqQ4SRt7stfi7yK1qxFzKBnySrO3EalN5TmPZ43Ratrh4JTGnchZ16lWdF7Fq/egVZ/cpCSpX2CupPyndIRjY+mnrCXBlxWujLJp+h1kheLA4Plng9X3Py7WpPiIYgDkfhcd1e4jgSNmSP6c2rL+nSF/F2XNU2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763502203; c=relaxed/simple;
	bh=9jI0JNZsWu/0Sbbp/cTHMbIfakTwsoRC2h7CTkJj1rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRCM6EqyM8/7w9H+ke3T1GuroDuGzmDCZyEZlXer749oFKzYuejgiJFeyAI0B9kyLZpozq1pPcUpmgoph23dqmNc2H6RIaOc/wKIE+bWGEaRhheuP/eAL0z5JgIkSJ/vBEOwXgnFjYM44RkjIGOOYdYMZFaupcPMyORRDBTNzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfALpphd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECD3C19425;
	Tue, 18 Nov 2025 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763502202;
	bh=9jI0JNZsWu/0Sbbp/cTHMbIfakTwsoRC2h7CTkJj1rQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfALpphdiRm5/rpPQldjdacr9/M5TLzGNd8xoMAUSe3gHTSl3A++3aQqTc2dYI4fx
	 2SWs87rXSbH+FoUHgTM/jZGchsvMQCyyhJGU38hJ+MNnHTQOUdpw2rsg5fiVQDcI+Z
	 OV7AsjFFjmNy59M5T2cNHpt9N6jUqfGAn4m/oLer1/C1fSvIhfaPmWjzARaYaTgf61
	 JupB+VPkhRQPorP/cSDXv6/MPSBWHIZSONYpnHb90Hn51s/UUz8wB33v04nb8PyXrd
	 hkDtebmqrmC0+9tq9rIR9lLBvERu0HmkS7qhTG9DedDfesb3HInca/3Yf5MfHG3PpK
	 iKG4bmqI8ZltQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>,
	linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/4] PCI: tegra194: Remove unnecessary L1SS disable code
Date: Tue, 18 Nov 2025 15:42:16 -0600
Message-ID: <20251118214312.2598220-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118214312.2598220-1-helgaas@kernel.org>
References: <20251118214312.2598220-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The DWC core clears the L1 Substates Supported bits unless the driver sets
the "dw_pcie.l1ss_support" flag.

The tegra194 init_host_aspm() sets "dw_pcie.l1ss_support" if the platform
has the "supports-clkreq" DT property.  If "supports-clkreq" is absent,
"dw_pcie.l1ss_support" is not set, and the DWC core will clear the L1
Substates Supported bits.

The tegra194 code to clear the L1 Substates Supported bits is unnecessary,
so remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 45 +++-------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 3934757baa30..0ddeef70726d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -260,7 +260,6 @@ struct tegra_pcie_dw {
 	u32 msi_ctrl_int;
 	u32 num_lanes;
 	u32 cid;
-	u32 cfg_link_cap_l1sub;
 	u32 ras_des_cap;
 	u32 pcie_cap_base;
 	u32 aspm_cmrt;
@@ -475,8 +474,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 		return IRQ_HANDLED;
 
 	/* If EP doesn't advertise L1SS, just return */
-	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
-	if (!(val & (PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)))
+	if (!pci->l1ss_support)
 		return IRQ_HANDLED;
 
 	/* Check if BME is set to '1' */
@@ -608,24 +606,6 @@ static struct pci_ops tegra_pci_ops = {
 };
 
 #if defined(CONFIG_PCIEASPM)
-static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
-static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
-}
-
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
 	u32 val;
@@ -682,10 +662,9 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 static void init_host_aspm(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie *pci = &pcie->pci;
-	u32 val;
+	u32 l1ss, val;
 
-	val = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
-	pcie->cfg_link_cap_l1sub = val + PCI_L1SS_CAP;
+	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
 
 	pcie->ras_des_cap = dw_pcie_find_ext_capability(&pcie->pci,
 							PCI_EXT_CAP_ID_VNDR);
@@ -697,11 +676,11 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
-	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
+	val = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
 	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
 	val |= (pcie->aspm_cmrt << 8);
 	val |= (pcie->aspm_pwr_on_t << 19);
-	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, val);
 
 	if (pcie->supports_clkreq)
 		pci->l1ss_support = true;
@@ -729,8 +708,6 @@ static void init_debugfs(struct tegra_pcie_dw *pcie)
 				    aspm_state_cnt);
 }
 #else
-static inline void disable_aspm_l12(struct tegra_pcie_dw *pcie) { return; }
-static inline void disable_aspm_l11(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_host_aspm(struct tegra_pcie_dw *pcie) { return; }
 static inline void init_debugfs(struct tegra_pcie_dw *pcie) { return; }
 #endif
@@ -934,12 +911,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
@@ -1874,12 +1845,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	init_host_aspm(pcie);
 
-	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
-	if (!pcie->supports_clkreq) {
-		disable_aspm_l11(pcie);
-		disable_aspm_l12(pcie);
-	}
-
 	if (!pcie->of_data->has_l1ss_exit_fix) {
 		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
 		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-- 
2.43.0


