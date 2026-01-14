Return-Path: <linux-pci+bounces-44750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D84D1FE0E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED3D30517D3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF8D39E185;
	Wed, 14 Jan 2026 15:36:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6905939E187;
	Wed, 14 Jan 2026 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404966; cv=none; b=JWv63jccYvd/18M2fmMqCHW09/m0AI7BBZwfJuVX5RT2064dJj3xhlw0VZwiVsjCT6lW6MSt/vsHoGjVYv+ZU2mbT2g84vFloF7wZuDrJnfyVbtRidlH9pmfEh21HOCf4VgPECDOt9Q4lCKvX5FIGY6bUggOI5e2IphMTVuzklE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404966; c=relaxed/simple;
	bh=85un2L2MhcAGStvAaFK1dMdSDbaz//1AggbE6FJphgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5WyKVTNcKZw77g7ZGotG6Ntw9RiWM7693KkbobFslAfhlFrsIoukgsbw/m7jp83pJw7FX9oki/4bYE9EBjxhVFfSevbYZ4seW2HRflUGNPE/kZ6N0YNlqmX3aHyGaxaAuesUgH+tEBJ3r+758FzUdR5XYaeUBjh4aKHr/OE6Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: DbEe4lskTSmpHl7Zr21rbw==
X-CSE-MsgGUID: 8AjLejiWTAqOSHblLgGmbA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:35:56 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1D85A4022B3E;
	Thu, 15 Jan 2026 00:35:50 +0900 (JST)
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
Subject: [PATCH 03/16] clk: renesas: rzv2h-cpg: Add support for init_off clocks
Date: Wed, 14 Jan 2026 16:33:24 +0100
Message-ID: <20260114153337.46765-4-john.madieu.xa@bp.renesas.com>
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

Some peripherals may be left enabled by the bootloader but should be
explicitly disabled by the kernel to ensure a known initial state.
This is particularly important for PCIe which requires proper
initialization sequencing.

Add new macros DEF_MOD_INIT_OFF() to declare module clocks that should be
turned off during CPG probe if found in the opposite state.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c |  9 +++++++++
 drivers/clk/renesas/rzv2h-cpg.h | 18 ++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index 3f6299b9fec0..91bc54aec328 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1337,6 +1337,15 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *mod,
 		spin_unlock_irqrestore(&priv->rmw_lock, flags);
 	}
 
+	/*
+	 * Turn off clocks marked with init_off flag if they were left
+	 * enabled by the bootloader. This ensures a known initial state.
+	 */
+	if (mod->init_off && rzv2h_mod_clock_is_enabled(&clock->hw)) {
+		dev_dbg(dev, "Disabling clock %s (init_off)\n", mod->name);
+		rzv2h_mod_clock_endisable(&clock->hw, false);
+	}
+
 	return;
 
 fail:
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index dc957bdaf5e9..248e954c4075 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -250,6 +250,7 @@ enum clk_types {
  * @parent: id of parent clock
  * @critical: flag to indicate the clock is critical
  * @no_pm: flag to indicate PM is not supported
+ * @init_off: flag to indicate the clock should be turned off during probe
  * @on_index: control register index
  * @on_bit: ON bit
  * @mon_index: monitor register index
@@ -262,6 +263,7 @@ struct rzv2h_mod_clk {
 	u16 parent;
 	bool critical;
 	bool no_pm;
+	bool init_off;
 	u8 on_index;
 	u8 on_bit;
 	s8 mon_index;
@@ -269,14 +271,15 @@ struct rzv2h_mod_clk {
 	s8 ext_clk_mux_index;
 };
 
-#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _onindex, \
-		     _onbit, _monindex, _monbit, _ext_clk_mux_index) \
+#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _init_off, \
+		     _onindex, _onbit, _monindex, _monbit, _ext_clk_mux_index) \
 	{ \
 		.name = (_name), \
 		.mstop_data = (_mstop), \
 		.parent = (_parent), \
 		.critical = (_critical), \
 		.no_pm = (_no_pm), \
+		.init_off = (_init_off), \
 		.on_index = (_onindex), \
 		.on_bit = (_onbit), \
 		.mon_index = (_monindex), \
@@ -285,17 +288,20 @@ struct rzv2h_mod_clk {
 	}
 
 #define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _monindex, _monbit, -1)
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, false, _onindex, _onbit, _monindex, _monbit, -1)
 
 #define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, true, false, _onindex, _onbit, _monindex, _monbit, -1)
+	DEF_MOD_BASE(_name, _mstop, _parent, true, false, false, _onindex, _onbit, _monindex, _monbit, -1)
+
+#define DEF_MOD_INIT_OFF(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, true, _onindex, _onbit, _monindex, _monbit, -1)
 
 #define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop) \
-	DEF_MOD_BASE(_name, _mstop, _parent, false, true, _onindex, _onbit, _monindex, _monbit, -1)
+	DEF_MOD_BASE(_name, _mstop, _parent, false, true, false, _onindex, _onbit, _monindex, _monbit, -1)
 
 #define DEF_MOD_MUX_EXTERNAL(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mstop, \
 			     _ext_clk_mux_index) \
-	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _monindex, _monbit, \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, false, _onindex, _onbit, _monindex, _monbit, \
 		     _ext_clk_mux_index)
 
 /**
-- 
2.25.1


