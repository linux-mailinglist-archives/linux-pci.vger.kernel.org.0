Return-Path: <linux-pci+bounces-40148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B0C2E3E3
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 23:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019A618932F3
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5643090DD;
	Mon,  3 Nov 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9oF19FO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D2E306482;
	Mon,  3 Nov 2025 22:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208378; cv=none; b=GKErDRY8KJsKrLY2Io6roGp88pE+GBPnEvmEBUGOQCvrB2ld34nmfQkVwrofZmI7uq3amV3Xdj2AIMUFyRycOnQubYNEsVcYEtmqI4mDa8LzFs7rKf9pzlr/UFGttjHQgBvKS8zT0scNI3aGwD2jZJ/K2sVKYL9MiWzsStfDtuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208378; c=relaxed/simple;
	bh=wpiPMuuFGzd1HX1RUyEGmhibbSv0Aqq202GkXTrqzrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LiYDuSUvEUiDgjQQw1VUcSpKwt4WGsXIYJlZyDM0KcNgMcKkyz+p1/AZcK25r3f0pDUkcNE0f3oJx44mbj1wzy4dp+e5u0Ha87NzxEOssLwslHf/oQO+Jj8sbDYYua3DQXIc2IVgRR1Nw1t/IogJ0WyCwHhmdkGyhmV8yS569HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9oF19FO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5E7C113D0;
	Mon,  3 Nov 2025 22:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762208377;
	bh=wpiPMuuFGzd1HX1RUyEGmhibbSv0Aqq202GkXTrqzrI=;
	h=From:To:Cc:Subject:Date:From;
	b=h9oF19FO4D0QWNnPur/W3em/sBAkXLMI+juCha0XOT2C+A1v4GMxlRWcEWnDBILBH
	 6Y3PfhVCuNvoW9T3dUia9/szzPKk1EcmN53F57slLladGVza87YmUtb9Q6ZOduLQ8J
	 5rSTKMTqvup/lNRsorxZcukzShamibR8QAzBvmTz/KSgpbOVUcK409aDfWa3kRFnHn
	 x/ilWilqTxmjNkj5UyVWDuPmoGvJPTMgzu/+Wv8OCVKHTodrmwsX6p5hb8YRo9eXBv
	 m2IJQzL9eH0qkLvzJWFHx/+fdKuj4gHXCIToL+4R0YtrWSyBhXtGbjy7qMCNljNmSv
	 GjmT+2tNENExw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Linnaea Lavia <linnaea-von-lavia@live.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	stable@vger.kernel.org
Subject: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
Date: Mon,  3 Nov 2025 16:19:26 -0600
Message-ID: <20251103221930.1831376-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Previously meson_pcie_link_up() only returned true if the link was in the
L0 state.  This was incorrect because hardware autonomously manages
transitions between L0, L0s, and L1 while both components on the link stay
in D0.  Those states should all be treated as "link is active".

Returning false when the device was in L0s or L1 broke config accesses
because dw_pcie_other_conf_map_bus() fails if the link is down, which
caused errors like this:

  meson-pcie fc000000.pcie: error: wait linkup timeout
  pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)

Remove the LTSSM state check, timeout, speed check, and error message from
meson_pcie_link_up(), the dw_pcie_ops.link_up() method, so it is a simple
boolean check of whether the link is active.  Timeouts and and error
messages are handled at a higher level, e.g., dw_pcie_wait_for_link().

Fixes: 9c0ef6d34fdb ("PCI: amlogic: Add the Amlogic Meson PCIe controller driver")
Reported-by: Linnaea Lavia <linnaea-von-lavia@live.com>
Closes: https://lore.kernel.org/r/DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/dwc/pci-meson.c | 36 +++-----------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396..13685d89227a 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -338,40 +338,10 @@ static struct pci_ops meson_pci_ops = {
 static bool meson_pcie_link_up(struct dw_pcie *pci)
 {
 	struct meson_pcie *mp = to_meson_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 speed_okay = 0;
-	u32 cnt = 0;
-	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
+	u32 state12;
 
-	do {
-		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
-		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
-		smlh_up = IS_SMLH_LINK_UP(state12);
-		rdlh_up = IS_RDLH_LINK_UP(state12);
-		ltssm_up = IS_LTSSM_UP(state12);
-
-		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
-			speed_okay = 1;
-
-		if (smlh_up)
-			dev_dbg(dev, "smlh_link_up is on\n");
-		if (rdlh_up)
-			dev_dbg(dev, "rdlh_link_up is on\n");
-		if (ltssm_up)
-			dev_dbg(dev, "ltssm_up is on\n");
-		if (speed_okay)
-			dev_dbg(dev, "speed_okay\n");
-
-		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
-			return true;
-
-		cnt++;
-
-		udelay(10);
-	} while (cnt < WAIT_LINKUP_TIMEOUT);
-
-	dev_err(dev, "error: wait linkup timeout\n");
-	return false;
+	state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
+	return IS_SMLH_LINK_UP(state12) && IS_RDLH_LINK_UP(state12);
 }
 
 static int meson_pcie_host_init(struct dw_pcie_rp *pp)
-- 
2.43.0


