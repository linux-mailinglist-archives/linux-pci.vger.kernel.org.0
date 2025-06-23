Return-Path: <linux-pci+bounces-30378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4915BAE3F26
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 14:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7F03AB42B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE95225B1CB;
	Mon, 23 Jun 2025 12:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f+NovE4r"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CE525A2CD;
	Mon, 23 Jun 2025 12:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680071; cv=none; b=BYUma/SnqPViuhPzhgAsKkV1xieQuYHGOO/anHKy96IPJC30JqQcbFieDSeAL9kJP/l3sYDy+69KxH9eNO3WCFnDrpEOWje+xYDSizMYDFSdZlytkE46ZiUO/udHKFf2GLDdduXXOTGpb5H4QUPBCcDWYN5oxkkfhx9v6eROpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680071; c=relaxed/simple;
	bh=hggLnCb5W6mqHyWLaRt+klzDu+LtdyTLXbh8FYBkU3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyeee7D0waVWz5nVFHNjhFxSaLBqX6chTwOYtNzpD4LXYSrFFCJhbZlKx/eFSfPFvVVIXbWd/BjY8Dfo1u35kSJ0QGvwKnq3jjolz8FBuI5LdItbBUVrcqfyCFvXdHTTs6nRLPOHaWyoU2Q19UFrqzs1KjmF1eH2ioBnGj6ZAN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f+NovE4r; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680068;
	bh=hggLnCb5W6mqHyWLaRt+klzDu+LtdyTLXbh8FYBkU3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+NovE4rNp5POOblkw5XkHQSywS6Lqih/nV+xeErNblFRaKE+u2YXKMPVxhdV+mxG
	 S4xiK7WI4ZIsJjeypaWTa2Kh4BLTJP05nM2RLEcLSuDrn7hFXvifHS0xDuH1l9DLsS
	 V8rken+bECTBlr6xUCJMF8X29j/L4GWOY4ZfsswXyosFweeUl41fZ0lXpbQUoXmphE
	 VEBZ6SMra0QscFpFuH+zp+v/gRgpRYV0XwQTzZz/YDt6GEa7fJSTq2fIgMWpDiFlut
	 erUL1aGxiRd4NcTxE7jI3zFn/2M8brM8mO17tZW9oAjofV22lICqngJQu29q0AxWe+
	 hf5+TKSxQTwXA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB74C17E1560;
	Mon, 23 Jun 2025 14:01:07 +0200 (CEST)
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
Subject: [PATCH v1 3/3] PCI: mediatek-gen3: Add support for MediaTek MT8196 SoC
Date: Mon, 23 Jun 2025 14:00:58 +0200
Message-ID: <20250623120058.109036-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
References: <20250623120058.109036-1-angelogioacchino.delregno@collabora.com>
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
index 00c9f2532870..43b99779274f 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1359,6 +1359,15 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
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
@@ -1373,6 +1382,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
+	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
-- 
2.49.0


