Return-Path: <linux-pci+bounces-11353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3281948C64
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 11:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9FA1C211EE
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62E1BDA9A;
	Tue,  6 Aug 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b="T9bc55Z+"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C91C15FA96;
	Tue,  6 Aug 2024 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722937748; cv=pass; b=BmHbFyg5b/b4nAqWLYUOQEBYJdlXA+jy6VlndxSzeauFliWLV8P8MYsplzDHeRdwBZztGEuc+5cSSvHp89lb7u9J0cI2fW46s7OBq0YE9G8Nuw7qjSj1nqo/7TjAuetUW+FTG5GL8QUjwozaMa+5/quMo2dYdx37hhHnIRg5XUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722937748; c=relaxed/simple;
	bh=16curGnD6wqpGPwm59b8bPI+rVIMKQsEBPUnIZig4mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbbUaPM4KTplkO4LOJL4dkYzxSjf3gUyD/TqWNevJGqyihMaKHiBovmIxjAFYvjB1oXWag09t96nmpMnOEwe6eNDoABK5sRTmkJ05qFRw68UKE6SXk0s+/KphFzbeHKo9vdscuTMSoORLiPqcnclaAf8dCRNiO/0EYJcy3DQCfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=angelogioacchino.delregno@collabora.com header.b=T9bc55Z+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: angelogioacchino.delregno@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1722937724; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AaKNQcLEgGJiqDF3d7QgOA2JYLhcQEZgg5xaviTeVK/GLS5Y7w7iEZ3BM7KjfDhCC0iHfnIAwdc0PCVXDNY7KqC4mUqqOdj2H+ry02RR7ruHfz8U4+FK4DNNwwQKWrbOrt13UNBQxd1Z2/KjV3zF3nWQ001m8ykBnlPhkbyy05s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1722937724; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fjnwescS6RYWERrcmekhT5uZ+q6kP6WerdRasypvbyk=; 
	b=ImuAcsK/fp2O/fMX5QlAG0QYM1qVM6EQraq4BH3uJXb8NNoGzzggIcTcjXUTZ2Wi2TM8Qkr/q2smpW9bKqdoYL4fdxXv+0wdHdyRshSoiIV2cgql1wxeDel9alIzQHeY/I7bwFt6nZ/+z7ntOsbJyhoIIfgBpx9b8RoPyBgebGA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=angelogioacchino.delregno@collabora.com;
	dmarc=pass header.from=<angelogioacchino.delregno@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1722937724;
	s=zohomail; d=collabora.com;
	i=angelogioacchino.delregno@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fjnwescS6RYWERrcmekhT5uZ+q6kP6WerdRasypvbyk=;
	b=T9bc55Z+YdQ/cPd4SbKweMbmkQo6w4HjTzSrQGBF+F57IXOQ1prVYnJwa4PqDoB1
	maH2M6XHPKgZ/jQ1+XNZrUUd84JKhNqZ4Akl8rCmOSHzaMSSbfvMri3pY+FYakkRwfM
	cvh80wxXPBT79l6wB49yatp2ZEsy1+f4KOrwD/jg=
Received: by mx.zohomail.com with SMTPS id 1722937722255263.116205413227;
	Tue, 6 Aug 2024 02:48:42 -0700 (PDT)
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
	kernel@collabora.com
Subject: [PATCH 2/2] PCI: mediatek-gen3: Add support for restricting link width
Date: Tue,  6 Aug 2024 11:48:16 +0200
Message-ID: <20240806094816.92137-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806094816.92137-1-angelogioacchino.delregno@collabora.com>
References: <20240806094816.92137-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add support for restricting the port's link width by specifying
the num-lanes devicetree property in the PCIe node.

The setting is done in the GEN_SETTINGS register (in the driver
named as PCIE_SETTING_REG), where each set bit in [11:8] activates
a set of lanes (from bits 11 to 8 respectively, x16/x8/x4/x2).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 22 ++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 905dc635ead3..5eaa4d1376a7 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -29,6 +29,7 @@
 #define PCIE_BASE_CFG_SPEED_MASK	GENMASK(15, 8)
 
 #define PCIE_SETTING_REG		0x80
+#define PCIE_SETTING_LINK_WIDTH		GENMASK(11, 8)
 #define PCIE_SETTING_GEN_SUPPORT_MASK	GENMASK(14, 12)
 #define PCIE_PCI_IDS_1			0x9c
 #define PCI_CLASS(class)		(class << 8)
@@ -131,6 +132,7 @@ struct mtk_msi_set {
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
  * @max_link_speed: Maximum link speed (PCIe Gen) for this port
+ * @num_lanes: Number of PCIe lanes for this port
  * @irq: PCIe controller interrupt number
  * @saved_irq_state: IRQ enable state saved at suspend time
  * @irq_lock: lock protecting IRQ register access
@@ -151,6 +153,7 @@ struct mtk_gen3_pcie {
 	struct clk_bulk_data *clks;
 	int num_clks;
 	u8 max_link_speed;
+	u8 num_lanes;
 
 	int irq;
 	u32 saved_irq_state;
@@ -350,7 +353,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	int err;
 	u32 val;
 
-	/* Set as RC mode and set controller PCIe Gen speed restriction, if any */
+	/* Set as RC mode and set controller PCIe Gen speed/lanes restriction, if any */
 	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
 	val |= PCIE_RC_MODE;
 	if (pcie->max_link_speed) {
@@ -361,6 +364,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT_MASK,
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
@@ -804,6 +815,7 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *regs;
+	u32 num_lanes;
 	int ret;
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
@@ -850,6 +862,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
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
2.45.2


