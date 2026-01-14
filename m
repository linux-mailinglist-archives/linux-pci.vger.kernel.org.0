Return-Path: <linux-pci+bounces-44758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D7D1FDC2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9201309D0D1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F86F39E6C1;
	Wed, 14 Jan 2026 15:36:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DDE39C659;
	Wed, 14 Jan 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768405008; cv=none; b=iWhCUVs7XxX/RZuX6oPUsnZgiRNAJKwe17yVs2HO8FCVOrLX2F+/GT74V4Jgd7gloMTpsSq0s197QXW8PkjZGR8722h1zxN2bvJsss84cPGOHPMZJA27b3gljatjNUvdUmeMpBv58Hefadqjq+qL/HWAC6BelGAABXUFzBLOlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768405008; c=relaxed/simple;
	bh=MZAmNmdNkHHTPKjxlr+GYi6n/cBXCC+ccrJERg4b3dM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkAfQLF7YuAwXeY8zDBSqfLF0Y4ZxWfS9H/72GSRZeffEIuECP/rdu8BrW1X2Y87Js/pA3HikjwE4q8O8xL/r/7DLt+MDBa735GjhC9eBwnT5khiFpQMl0q9oCtQhnutUQcG1oq89LOhxxjUSX1x9RFP3LUN/KTShYwqFeTl5gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: KIs55CiGSy2Oep/9isQ6Ow==
X-CSE-MsgGUID: OVENkJhyT4e1MyJ3nNPV5Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jan 2026 00:36:46 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.92.178])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9B87B4022B3F;
	Thu, 15 Jan 2026 00:36:40 +0900 (JST)
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
Subject: [PATCH 11/16] PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
Date: Wed, 14 Jan 2026 16:33:32 +0100
Message-ID: <20260114153337.46765-12-john.madieu.xa@bp.renesas.com>
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

Extend the link speed configuration to support Gen3 (8.0 GT/s) in addition
to Gen2 (5.0 GT/s). This is required for RZ/G3E PCIe host support, which is
Gen3 capable.

Instead of relying on DT max-link-speed for configuration, read the hardware
capabilities from the PCI_EXP_LNKCAP register to determine the maximum
supported speed. The DT max-link-speed property is now only used as an
optional limit when explicitly specified, which aligns with PCIe subsystem
expectations.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 26 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 18fccc687c6b..b0a5c08d2527 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -981,8 +981,9 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 {
 	u32 remote_supported_link_speeds, max_supported_link_speeds;
 	u32 cs2, tmp, pcie_cap = RZG3S_PCI_CFG_PCIEC;
-	u32 cur_link_speed, link_speed;
+	u32 cur_link_speed, link_speed, hw_max_speed;
 	u8 ltssm_state_l0 = 0xc;
+	u32 lnkcap;
 	int ret;
 	u16 ls;
 
@@ -1002,7 +1003,22 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	ls = readw_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKSTA);
 	cs2 = readl_relaxed(host->axi + RZG3S_PCI_PCSTAT2);
 
-	switch (pcie_link_speed[host->max_link_speed]) {
+	/* Read hardware supported link speed from Link Capabilities Register */
+	lnkcap = readl_relaxed(host->pcie + pcie_cap + PCI_EXP_LNKCAP);
+	hw_max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, lnkcap);
+
+	/*
+	 * Use DT max-link-speed only as a limit. If specified and lower
+	 * than hardware capability, cap to that value.
+	 */
+	if (host->max_link_speed > 0 && host->max_link_speed < hw_max_speed)
+		hw_max_speed = host->max_link_speed;
+
+	switch (pcie_link_speed[hw_max_speed]) {
+	case PCIE_SPEED_8_0GT:
+		max_supported_link_speeds = GENMASK(PCI_EXP_LNKSTA_CLS_8_0GB - 1, 0);
+		link_speed = PCI_EXP_LNKCTL2_TLS_8_0GT;
+		break;
 	case PCIE_SPEED_5_0GT:
 		max_supported_link_speeds = GENMASK(PCI_EXP_LNKSTA_CLS_5_0GB - 1, 0);
 		link_speed = PCI_EXP_LNKCTL2_TLS_5_0GT;
@@ -1018,10 +1034,10 @@ static int rzg3s_pcie_set_max_link_speed(struct rzg3s_pcie_host *host)
 	remote_supported_link_speeds &= max_supported_link_speeds;
 
 	/*
-	 * Return if max link speed is already set or the connected device
+	 * Return if target link speed is already set or the connected device
 	 * doesn't support it.
 	 */
-	if (cur_link_speed == host->max_link_speed ||
+	if (cur_link_speed == hw_max_speed ||
 	    remote_supported_link_speeds != max_supported_link_speeds)
 		return 0;
 
@@ -1598,8 +1614,6 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	host->pcie = host->axi + RZG3S_PCI_CFG_BASE;
 
 	host->max_link_speed = of_pci_get_max_link_speed(np);
-	if (host->max_link_speed < 0)
-		host->max_link_speed = 2;
 
 	ret = rzg3s_pcie_host_parse_port(host);
 	if (ret)
-- 
2.25.1


