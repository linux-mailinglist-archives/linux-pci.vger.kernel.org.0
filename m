Return-Path: <linux-pci+bounces-35032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D110BB39FAA
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B7F7C369E
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853E3315772;
	Thu, 28 Aug 2025 14:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gYk6nLn8"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A0314B6D;
	Thu, 28 Aug 2025 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389669; cv=none; b=h7CGXaUAKCsemnOiRqe09oNk/EQvzExwdk3q84TgbXgpw1RkU2wpVQ26Vb486CcoP0gmWZe/0Crx/tQ7Sqz3+S5Q6D8un1OuM2nkdDBJ7IbbTvjkKHX7+F/wEDga0li12NCCbNTHMmh2E67tGKIacANR+SJ3PkVTGyf15Iz0EWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389669; c=relaxed/simple;
	bh=0HdXn0oWPQJLvm3LmIBrLtXwSSURIQZmY51cwVRT7JI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IR3KQOYBf/2rf+K7LZh6dffPDSYWreiEO060hdmyzi/RVq6GPhYE4Q5I7Fhsy5ao/jTLBdeer5yGuYtv62ejLVXBsfW1jDeMi1mdRR4eXw+QydOwVpbOJFqhAcWAniMP5MS8zQL0Rmo1UhfeFm+3m9Vx5+Zuy5UJrGdUIrkTW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gYk6nLn8; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Fn
	imcfeSmrx4hkmRg5SDhYi4VffXu8gWahR80/T54CQ=; b=gYk6nLn8N4ziDubYIv
	ZjUGd6XANFq2U/BzQ0PcxYNu0xrHEvefQmAO6sPk1AYmFh4VKMth+NjXBKCejRT2
	MANYa8WiZbpXoUKJc/IMsYmDWLklqgxD7/2V67Bi5Th06JVr3i3V1U3JDgv3s6t8
	WPDHZEpuUqysGpCYvBn5o2ey0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S7;
	Thu, 28 Aug 2025 22:00:49 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 13/13] PCI: tegra194: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:51 +0800
Message-Id: <20250828135951.758100-14-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S7
X-Coremail-Antispam: 1Uf129KBjvJXoW3ur47Xw15Gr1xXrWUKryfWFg_yoWDCF4xpF
	1jy3sYyF1UJF1vvrZFya4kXF1YkrZI9r47WanxKrnava1kAry7XayvvasFqFn7GFWxtFW5
	Kw40yFy7CFy5XrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pinmR8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhu3o2iwWw2U9gAAsZ

Tegra194 PCIe driver contains extensive manual bit manipulation across
interrupt handling, ASPM configuration, and controller initialization.
The driver implements complex read-modify-write sequences with explicit
bit masking, leading to verbose and hard-to-maintain code.

Refactor interrupt handling, ASPM setup, capability configuration, and
controller initialization using dw_pcie_*_dword(). Replace
multi-step register modifications with single helper calls, eliminating
intermediate variables and reducing code size by ~75 lines. For CDMA
error handling, initialize the value variable to zero before setting
status bits.

This comprehensive refactoring significantly improves code readability
and maintainability. Standardizing on the helper ensures consistent
register access patterns across all driver components and reduces the
risk of bit manipulation errors in this complex controller driver.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 122 ++++++++-------------
 1 file changed, 47 insertions(+), 75 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 4f26086f25da..f89dde9071cd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -378,9 +378,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 			val |= APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
 			appl_writel(pcie, val, APPL_CAR_RESET_OVRD);
 
-			val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-			val |= PORT_LOGIC_SPEED_CHANGE;
-			dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+			dw_pcie_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+					  PORT_LOGIC_SPEED_CHANGE);
 		}
 	}
 
@@ -610,20 +609,14 @@ static struct pci_ops tegra_pci_ops = {
 #if defined(CONFIG_PCIEASPM)
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_clear_dword(&pcie->pci, pcie->cfg_link_cap_l1sub,
+			    PCI_L1SS_CAP_ASPM_L1_1);
 }
 
 static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
 {
-	u32 val;
-
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
-	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_clear_dword(&pcie->pci, pcie->cfg_link_cap_l1sub,
+			    PCI_L1SS_CAP_ASPM_L1_2);
 }
 
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
@@ -697,18 +690,18 @@ static void init_host_aspm(struct tegra_pcie_dw *pcie)
 			   PCIE_RAS_DES_EVENT_COUNTER_CONTROL, val);
 
 	/* Program T_cmrt and T_pwr_on values */
-	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
-	val &= ~(PCI_L1SS_CAP_CM_RESTORE_TIME | PCI_L1SS_CAP_P_PWR_ON_VALUE);
-	val |= (pcie->aspm_cmrt << 8);
+	val = (pcie->aspm_cmrt << 8);
 	val |= (pcie->aspm_pwr_on_t << 19);
-	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_clear_and_set_dword(pci, pcie->cfg_link_cap_l1sub,
+				    PCI_L1SS_CAP_CM_RESTORE_TIME |
+				    PCI_L1SS_CAP_P_PWR_ON_VALUE,
+				    val);
 
 	/* Program L0s and L1 entrance latencies */
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
-	val &= ~PORT_AFR_L0S_ENTRANCE_LAT_MASK;
-	val |= (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
+	val = (pcie->aspm_l0s_enter_lat << PORT_AFR_L0S_ENTRANCE_LAT_SHIFT);
 	val |= PORT_AFR_ENTER_ASPM;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_AFR,
+				    PORT_AFR_L0S_ENTRANCE_LAT_MASK, val);
 }
 
 static void init_debugfs(struct tegra_pcie_dw *pcie)
@@ -860,9 +853,8 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 		dw_pcie_writeb_dbi(pci, offset + i, val);
 	}
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	dw_pcie_clear_dword(pci, GEN3_RELATED_OFF,
+			    GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
 	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
@@ -870,10 +862,9 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	val |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
+				    GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+				    0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
 
 	val = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
 	val &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC;
@@ -882,17 +873,14 @@ static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 	val &= ~GEN3_EQ_CONTROL_OFF_FB_MODE;
 	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, val);
 
-	val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	val &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
+	dw_pcie_clear_dword(pci, GEN3_RELATED_OFF,
+			    GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK);
 }
 
 static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
-	u32 val;
-	u16 val_16;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -900,32 +888,25 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
-	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
-	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
-	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
+	dw_pcie_clear_dword(pci, PCI_IO_BASE, IO_BASE_IO_DECODE |
+			    IO_BASE_IO_DECODE_BIT8);
 
-	val = dw_pcie_readl_dbi(pci, PCI_PREF_MEMORY_BASE);
-	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE;
-	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE;
-	dw_pcie_writel_dbi(pci, PCI_PREF_MEMORY_BASE, val);
+	dw_pcie_set_dword(pci, PCI_PREF_MEMORY_BASE,
+			  CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE |
+			  CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE);
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
 	/* Enable as 0xFFFF0001 response for RRS */
-	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
-	val &= ~(AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT);
-	val |= (AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
-		AMBA_ERROR_RESPONSE_RRS_SHIFT);
-	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
+	dw_pcie_clear_and_set_dword(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT,
+				    AMBA_ERROR_RESPONSE_RRS_MASK << AMBA_ERROR_RESPONSE_RRS_SHIFT,
+				    AMBA_ERROR_RESPONSE_RRS_OKAY_FFFF0001 <<
+				    AMBA_ERROR_RESPONSE_RRS_SHIFT);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
-	if (pcie->enable_srns) {
-		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
-					   PCI_EXP_LNKSTA);
-		val_16 &= ~PCI_EXP_LNKSTA_SLC;
-		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
-				   val_16);
-	}
+	if (pcie->enable_srns)
+		dw_pcie_clear_dword(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
+				    PCI_EXP_LNKSTA_SLC);
 
 	config_gen3_gen4_eq_presets(pcie);
 
@@ -937,17 +918,13 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 		disable_aspm_l12(pcie);
 	}
 
-	if (!pcie->of_data->has_l1ss_exit_fix) {
-		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
-	}
+	if (!pcie->of_data->has_l1ss_exit_fix)
+		dw_pcie_clear_dword(pci, GEN3_RELATED_OFF,
+				    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL);
 
-	if (pcie->update_fc_fixup) {
-		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
-	}
+	if (pcie->update_fc_fixup)
+		dw_pcie_set_dword(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
+				  0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT);
 
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
@@ -1018,9 +995,8 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 		reset_control_deassert(pcie->core_rst);
 
 		offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_DLF);
-		val = dw_pcie_readl_dbi(pci, offset + PCI_DLF_CAP);
-		val &= ~PCI_DLF_EXCHANGE_ENABLE;
-		dw_pcie_writel_dbi(pci, offset + PCI_DLF_CAP, val);
+		dw_pcie_clear_dword(pci, offset + PCI_DLF_CAP,
+				    PCI_DLF_EXCHANGE_ENABLE);
 
 		tegra_pcie_dw_host_init(pp);
 		dw_pcie_setup_rc(pp);
@@ -1847,11 +1823,9 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	reset_control_deassert(pcie->core_rst);
 
-	if (pcie->update_fc_fixup) {
-		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
-		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
-		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
-	}
+	if (pcie->update_fc_fixup)
+		dw_pcie_set_dword(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF,
+				  0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT);
 
 	config_gen3_gen4_eq_presets(pcie);
 
@@ -1863,11 +1837,9 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		disable_aspm_l12(pcie);
 	}
 
-	if (!pcie->of_data->has_l1ss_exit_fix) {
-		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
-	}
+	if (!pcie->of_data->has_l1ss_exit_fix)
+		dw_pcie_clear_dword(pci, GEN3_RELATED_OFF,
+				    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL);
 
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
-- 
2.49.0


