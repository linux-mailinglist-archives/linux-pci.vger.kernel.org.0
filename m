Return-Path: <linux-pci+bounces-13276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C594197B91B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 10:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE831C208AF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Sep 2024 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C853A192D89;
	Wed, 18 Sep 2024 08:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LafAGWjE"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A8A192B89;
	Wed, 18 Sep 2024 08:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647195; cv=none; b=jdsIBp6I6t9K3AQ8PMpbF3mbnf7HLayDCBu+pV73JEAev+Rmwl89AGp/O82ec2fqhDl2+OyWVcMwOp8uM9BWezBb14jfwpHBU4MG780h+b792wN280uZe5vUt082zpzSeiy7If8g+1EJ7dZLeUvoDxPex6asfIp2AS/NaIUSr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647195; c=relaxed/simple;
	bh=a6JnRj6aYmU/JYblHyMQeQN1RmP5rC/orL4p735e1o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6CEQMO5Il0bM9srvsbmLb59K9tSVAlAsxWlnOtg555wcnFgnkDZxn1sYNbjfFH3VvLzk/GfqNEZAdUeb36+fK1k6vEeHMbWaxJu3nZ2Ts3l088IbRQd72glm9/v1jtdYRuUxeVGUpKxsAdqdu7ftwsyy4/pwDtkW3WjD/wg4BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LafAGWjE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726647191;
	bh=a6JnRj6aYmU/JYblHyMQeQN1RmP5rC/orL4p735e1o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LafAGWjEKJ45sWlvT0r8Jey4XhyTcnrvIaDpMbofOtgCvpN4wNp78vR2Pegi8Y9Sv
	 sJuTgpb8MI7PRgNKrXbVr0nUCs2LMkIZq6aAiuRoBLYSN+F0tC6fOv2Ir3MZKqxMN3
	 gIv/DWxQXaBDjHdrwrs5OJ+iX60LhwwX71QzKPMRSYjJq6pXHiTx2dZHLHTKiT4X1v
	 LnVGKLNJykG/k8ry37nCNHmWZSOU4IYQaD8m2f/TcWp+v0PhGMk0u4KkCQOl3RQXHM
	 jwXRXd5aRL7nmFgywZ0Q3dsACwPqybY4a2TseD6kb4yFyyseDYnrlv0dchYdiSopw2
	 n6NO6p0GTpsnQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 47C9217E0FE7;
	Wed, 18 Sep 2024 10:13:11 +0200 (CEST)
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
Subject: [PATCH v3 1/2] PCI: mediatek-gen3: Add support for setting max-link-speed limit
Date: Wed, 18 Sep 2024 10:13:06 +0200
Message-ID: <20240918081307.51264-2-angelogioacchino.delregno@collabora.com>
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

Add support for respecting the max-link-speed devicetree property,
forcing a maximum speed (Gen) for a PCI-Express port.

Since the MediaTek PCIe Gen3 controllers also expose the maximum
supported link speed in the PCIE_BASE_CFG register, if property
max-link-speed is specified in devicetree, validate it against the
controller capabilities and proceed setting the limitations only
if the wanted Gen is lower than the maximum one that is supported
by the controller itself (otherwise it makes no sense!).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 66ce4b5d309b..8d4b045633da 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -28,7 +28,11 @@
 
 #include "../pci.h"
 
+#define PCIE_BASE_CFG_REG		0x14
+#define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
+
 #define PCIE_SETTING_REG		0x80
+#define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
 #define PCIE_PCI_IDS_1			0x9c
 #define PCI_CLASS(class)		(class << 8)
 #define PCIE_RC_MODE			BIT(0)
@@ -125,6 +129,9 @@
 
 struct mtk_gen3_pcie;
 
+#define PCIE_CONF_LINK2_CTL_STS		0x10b0
+#define PCIE_CONF_LINK2_LCR2_LINK_SPEED	GENMASK(3, 0)
+
 /**
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
@@ -160,6 +167,7 @@ struct mtk_msi_set {
  * @phy: PHY controller block
  * @clks: PCIe clocks
  * @num_clks: PCIe clocks count for this port
+ * @max_link_speed: Maximum link speed (PCIe Gen) for this port
  * @irq: PCIe controller interrupt number
  * @saved_irq_state: IRQ enable state saved at suspend time
  * @irq_lock: lock protecting IRQ register access
@@ -180,6 +188,7 @@ struct mtk_gen3_pcie {
 	struct phy *phy;
 	struct clk_bulk_data *clks;
 	int num_clks;
+	u8 max_link_speed;
 
 	int irq;
 	u32 saved_irq_state;
@@ -381,11 +390,27 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	int err;
 	u32 val;
 
-	/* Set as RC mode */
+	/* Set as RC mode and set controller PCIe Gen speed restriction, if any */
 	val = readl_relaxed(pcie->base + PCIE_SETTING_REG);
 	val |= PCIE_RC_MODE;
+	if (pcie->max_link_speed) {
+		val &= ~PCIE_SETTING_GEN_SUPPORT;
+
+		/* Can enable link speed support only from Gen2 onwards */
+		if (pcie->max_link_speed >= 2)
+			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
+					  GENMASK(pcie->max_link_speed - 2, 0));
+	}
 	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
 
+	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
+	if (pcie->max_link_speed) {
+		val = readl_relaxed(pcie->base + PCIE_CONF_LINK2_CTL_STS);
+		val &= ~PCIE_CONF_LINK2_LCR2_LINK_SPEED;
+		val |= FIELD_PREP(PCIE_CONF_LINK2_LCR2_LINK_SPEED, pcie->max_link_speed);
+		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
+	}
+
 	/* Set class code */
 	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
 	val &= ~GENMASK(31, 8);
@@ -1004,9 +1029,21 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
 }
 
+static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *pcie)
+{
+	u32 val;
+	int ret;
+
+	val = readl_relaxed(pcie->base + PCIE_BASE_CFG_REG);
+	val = FIELD_GET(PCIE_BASE_CFG_SPEED, val);
+	ret = fls(val);
+
+	return ret > 0 ? ret : -EINVAL;
+}
+
 static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 {
-	int err;
+	int err, max_speed;
 
 	err = mtk_pcie_parse_port(pcie);
 	if (err)
@@ -1031,6 +1068,20 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
 	if (err)
 		return err;
 
+	err = of_pci_get_max_link_speed(pcie->dev->of_node);
+	if (err > 0) {
+		/* Get the maximum speed supported by the controller */
+		max_speed = mtk_pcie_get_controller_max_link_speed(pcie);
+
+		/* Set max_link_speed only if the controller supports it */
+		if (max_speed >= 0 && max_speed <= err) {
+			pcie->max_link_speed = err;
+			dev_dbg(pcie->dev,
+				"Max controller link speed Gen%d, override to Gen%u",
+				max_speed, pcie->max_link_speed);
+		}
+	}
+
 	/* Try link up */
 	err = mtk_pcie_startup_port(pcie);
 	if (err)
-- 
2.46.0


