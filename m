Return-Path: <linux-pci+bounces-31388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4C4AF7357
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08BE11C81CF7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226502E718C;
	Thu,  3 Jul 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fyhQzmtg"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BF2E6130;
	Thu,  3 Jul 2025 12:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544538; cv=none; b=f8lTYCs9HUie2o8wJUbgicD+RcLfxGWU2tb0fc082bN2LZ/PuJtMDORI77T7nFpIyLpVXcDDD6u8MmOutRMh8CKk3fRVO0aOmQI1811EhUqjD52w2ZY4LYNmrcxPev1y2gPKGKWHdRIYZW8wp2zEmZAEUXgGbFTCv6Z0EmTXr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544538; c=relaxed/simple;
	bh=tzB00E/eA47pTyzdZtsolZ62VuMIChKHgXq99sgnpPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unymPxuyH8ewEwo00cj2DX7x3Q4wAUKzBmv1+t2sYrGKy771UUPKFmPuTHBt41I32nV260JWwVc2AsCsCgp6rhd16y2ti6eSWU0tmmWtEcAdlwYtvLWl88C6XJGVFjg1y7uaykS9JrdR0TRmj696qop9A2VY7xB+tinP3K0bIeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fyhQzmtg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751544534;
	bh=tzB00E/eA47pTyzdZtsolZ62VuMIChKHgXq99sgnpPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyhQzmtgnvMwxyCzSIm0Saiwdy4JoV85pA174oRhj1BMIN1sVouL7PTh8RvrzIs1G
	 YbRtE80P2NE2YpBxlqvzJutsI6KwI2ptN0Ys8Ahf99IbBuZNhd1fWDkWjyRhnggCig
	 M+sC4kqYD9sKaArkAXRbeYmsYYS0qYysaxwdmQM7aznnyyCK+8n33mvL98k3lcx1vI
	 EQ9h6ScbpWVBhB8j72MceUR7xcA0R6xxVi4HepEVdttZ8jV9AQb7bCIiSC/yFN/DsF
	 f8Qx5qHSdwM6iP5rae/BnQTdh/teCFZiZ6X8MecVwez73N/xrt33hBmqKhe89QaDwR
	 nIEgRNTJMXkEQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F1EF17E0EBD;
	Thu,  3 Jul 2025 14:08:53 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jianjun.wang@mediatek.com
Cc: ryder.lee@mediatek.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v2 3/3] PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC
Date: Thu,  3 Jul 2025 14:08:47 +0200
Message-ID: <20250703120847.121826-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
References: <20250703120847.121826-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for the PCI-Express Gen3 controller found in the
MT8196 (and MT6991) SoC by adding a compatible string and platform
specific data.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 8035f7f812aa..f8adf88d19b0 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1358,6 +1358,15 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
 	},
 };
 
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8196 = {
+	.power_up = mtk_pcie_power_up,
+	.phy_resets = {
+		.id[0] = "phy",
+		.num_resets = 1,
+	},
+	.sys_clk_rdy_time_us = 10,
+};
+
 static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 	.power_up = mtk_pcie_en7581_power_up,
 	.phy_resets = {
@@ -1372,6 +1381,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
+	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
-- 
2.49.0


