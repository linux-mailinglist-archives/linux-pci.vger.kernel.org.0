Return-Path: <linux-pci+bounces-44751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78547D1FE16
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70132304DB68
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5C39E6C5;
	Wed, 14 Jan 2026 15:36:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501DF31960D;
	Wed, 14 Jan 2026 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768404967; cv=none; b=fOPHYIxhJFBr4BE/PAwNXwp4L3HLYugvkwOSNuAg4vbhHc6xELlw1LdPipEJESyt0Mhv53dlNOfHB1+0lQGXyvP6BZmMt1egzVZW5eXG/NkLKt2avu4xzD07svnby3LLmypD6a30VzrboBM36SMLmTgoyQevO7c5M1VzjE6Uvmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768404967; c=relaxed/simple;
	bh=TVXmx4vEBg0HnQlppXuEEtGlJhNIqrS1vaU/1GQecKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQzT0AqHyRB/xNU8Ye8Trh9jBkROcQAut1EOFk2Alf3/z/AIcQOW90+f/T4lLLKc5Ir7r8Md3VH/x70B5tTYJOmlitaSyvmJ/l2lKvoLPVvz5VBTsieeXk+VPqHW6c2nRZTE9C3fIHl8/eqOQQCWipZFxqYspW2mjeADZYnio6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: mnLM+Vr/RcKuqdiY7yATJQ==
X-CSE-MsgGUID: NfBymEeFSXuEYgbtPIme1Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:02 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6E5814022B3E;
	Thu, 15 Jan 2026 00:35:57 +0900 (JST)
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
Subject: [PATCH 04/16] clk: renesas: r9a09g047: Add PCIe clocks and reset
Date: Wed, 14 Jan 2026 16:33:25 +0100
Message-ID: <20260114153337.46765-5-john.madieu.xa@bp.renesas.com>
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

Add necessary clocks and reset entries for the PCIe controller

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a09g047-cpg.c
index 1e9896742a06..01a7a5fcfe9e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -438,6 +438,10 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] __initconst = {
 						BUS_MSTOP(3, BIT(4))),
 	DEF_MOD("tsu_1_pclk",			CLK_QEXTAL, 16, 10, 8, 10,
 						BUS_MSTOP(2, BIT(15))),
+	DEF_MOD_INIT_OFF("pcie_aclk",		CLK_PLLDTY_ACPU_DIV2, 12, 4, 6, 4,
+						BUS_MSTOP(1, BIT(15))),
+	DEF_MOD_INIT_OFF("pcie_clk_pmu",	CLK_PLLDTY_ACPU_DIV2, 12, 5, 6, 5,
+						BUS_MSTOP(1, BIT(15))),
 };
 
 static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
@@ -503,6 +507,7 @@ static const struct rzv2h_reset r9a09g047_resets[] __initconst = {
 	DEF_RST(10, 15, 5, 0),		/* USB2_0_PRESETN */
 	DEF_RST(11, 0, 5, 1),		/* GBETH_0_ARESETN_I */
 	DEF_RST(11, 1, 5, 2),		/* GBETH_1_ARESETN_I */
+	DEF_RST(11, 2, 5, 3),		/* PCIE_ARESETN */
 	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
 	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
 	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
-- 
2.25.1


