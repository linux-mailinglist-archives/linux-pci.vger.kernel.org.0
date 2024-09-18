Return-Path: <linux-pci+bounces-13277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30197B91C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 10:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2C05B222DD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 08:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291319306B;
	Wed, 18 Sep 2024 08:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HDeqSBgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B564192B8C;
	Wed, 18 Sep 2024 08:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647196; cv=none; b=L6i3imsuKK9m+8JJKucgTtjnbuJPvvs6GR3MG4RP1rZ/d0F7ZEmI9JK1NilF8lmVmU6WLnGooXckcy2U4bJ5G1JyH2nM1haZBE8ZDykKKSj5b9Y1hGm/b7O+rRxefZdc7Dagwui4Ae53iAHbyxCq/Hp2EiCe6A6i1rTL7H09RbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647196; c=relaxed/simple;
	bh=hanknEKqGzrT3mPnV0cueYnM3TV4BgNLJUCxOnB8qt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKmD152Z83wCCoqQ7Whw6/JqE2EOJ/aJK+xGyTNql1N3B/IQfomZw/EsW8IYibgO0ZnNaH7ZecsdqsK5jeCovkhpfx1211xP/btVxxYqlqRwjD223XnsCSJYuEn4QtjEZumpUlZK6pLvzVzinTfGk+QvQE0BiXRlu4fpKR0/Qmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HDeqSBgK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726647192;
	bh=hanknEKqGzrT3mPnV0cueYnM3TV4BgNLJUCxOnB8qt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDeqSBgKvgwjgbPSwk9fOl4FbkkWUEQKBYYPy3EKoteJf/92e5z/PRt8oV25VnNd+
	 R+l5yNBXq26kQH4sISngW6642stjUfbny02YuX0Z09zESXkPAzeZ5oSYcV3A3JjTFa
	 Awq5rPY/VVHxDNsCey6D9/6FpzKcd5mW72V+5V4ewDsYfP0ruL+PxoIWXx5jJ8DcFo
	 vlAShk5Rqki8yjNcKt1WRjk1AOzv2Yi2EFiw4TGqvM3N/W6Xb351DoRwmo14lieHkk
	 FYu2MWttb75O3de5d3R6nyLP65tRl50GaAaIQxi2NG/RpmeViedrLhhIv8qokBt1uA
	 awKZ9SyQwT7CA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E3E717E1003;
	Wed, 18 Sep 2024 10:13:12 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	fshao@chromium.org
Subject: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting link width
Date: Wed, 18 Sep 2024 10:13:07 +0200
Message-ID: <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for restricting the port's link width by specifying
the num-lanes devicetree property in the PCIe node.

The setting is done in the GEN_SETTINGS register (in the driver
named as PCIE_SETTING_REG), where each set bit in [11:8] activates
a set of lanes (from bits 11 to 8 respectively, x16/x8/x4/x2).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 8d4b045633da..8dd2e5135b01 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -32,6 +32,7 @@
 #define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
 
 #define PCIE_SETTING_REG		0x80
+#define PCIE_SETTING_LINK_WIDTH		GENMASK(11, 8)
 #define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
 #define PCIE_PCI_IDS_1			0x9c
 #define PCI_CLASS(class)		(class << 8)
@@ -168,6 +169,7 @@ struct mtk_msi_set {
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
  * @max_link_speed: Maximum link speed (PCIe Gen) for this port
+ * @num_lanes: Number of PCIe lanes for this port
  * @irq: PCIe controller interrupt number
  * @saved_irq_state: IRQ enable state saved at suspend time
  * @irq_lock: lock protecting IRQ register access
@@ -189,6 +191,7 @@ struct mtk_gen3_pcie {
 	struct clk_bulk_data *clks;
 	int num_clks;
 	u8 max_link_speed;
+	u8 num_lanes;
 
 	int irq;
 	u32 saved_irq_state;
@@ -401,6 +404,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
 					  GENMASK(pcie->max_link_speed - 2, 0));
 	}
+	if (pcie->num_lanes) {
+		val &= ~PCIE_SETTING_LINK_WIDTH;
+
+		/* Zero means one lane, each bit activates x2/x4/x8/x16 */
+		if (pcie->num_lanes > 1)
+			val |= FIELD_PREP(PCIE_SETTING_LINK_WIDTH,
+					  GENMASK(pcie->num_lanes >> 1, 0));
+	};
 	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
 
 	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
@@ -838,6 +849,7 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
+	u32 num_lanes;
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
 	if (!regs)
@@ -883,6 +895,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 		return pcie->num_clks;
 	}
 
+	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
+	if (ret == 0) {
+		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
+			dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
+		else
+			pcie->num_lanes = num_lanes;
+	}
+
 	return 0;
 }
 
-- 
2.46.0


