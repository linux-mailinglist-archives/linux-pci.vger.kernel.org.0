Return-Path: <linux-pci+bounces-15944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0949BB3DE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 12:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44D61F21FD5
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA5D1B6CF6;
	Mon,  4 Nov 2024 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LKU81H1Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FA1B4F29;
	Mon,  4 Nov 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721016; cv=none; b=tyHnZYp9w//vXgSbYz+YyF0E/kzvmdYTj06f1SV5bI7DZh878as+TY10/5+uHHJpbDLag9wC1ksSk5Fel8WjLhC40OV2d/Gk60VwRjEZYegMzdKZ5opz4/V/fsgD0SZmUqgENf2Ggs+ZZHAuxqczhI29ZwCgkBEk83OKjBNc1Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721016; c=relaxed/simple;
	bh=1X/szFsCvAf8d6qofuOhK8n/IIEMtInetVFTV67Txr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PR/Kh/u1HWZGdZH6OjQWot+i4iX7+Zr+LIORl6Xe/EKS0PWAyRUxB63MMSL3e5KRNaAh/90lmoqS+YfMP20x/oVpoagSqJKV8fakMKOjHZRCNtTPUiGQIswRBPvtygqIsPBR4kI+GvhGyKEkyzhdtUfo5nvMnT89rzBTpi19ecw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LKU81H1Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730721011;
	bh=1X/szFsCvAf8d6qofuOhK8n/IIEMtInetVFTV67Txr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LKU81H1YEo+nDhImkQEDrVuJAqsxaUJ7GwEh9Tw94BSue6j5JULyxtO4ynAgHMlMF
	 hNXKoEsgI8ZMH7BYTS9jP7eahk4D/Fasml2rwu0mfgep6o6Xb2X3h6cFoJh61WgweL
	 oCizcrvhVzIzKHPzx6Yp0SS2yqSGy6xg5oU4qJa0aayBkUY20CslQiPC5NrAfVHG6k
	 dq8sP09NNWk0AeLgFSrHubO1Yz59lyoYQ85i6cDIY+ccsY6G25qpfxOYv7c1tWg0kx
	 rlmPanlK/6hPYfrL0z9qV0Vm5u/mxYiRUvRNDaq3pq8Ws740oSCxuOT5hgalbzmu0f
	 gBm4T5KrujlMg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 311BE17E3611;
	Mon,  4 Nov 2024 12:50:11 +0100 (CET)
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
	fshao@chromium.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting max-link-speed limit
Date: Mon,  4 Nov 2024 12:49:34 +0100
Message-ID: <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
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

Reviewed-by: Fei Shao <fshao@chromium.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 55 ++++++++++++++++++++-
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 969f62e9cf01..c27beef75079 100644
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
 
+#define PCIE_CONF_LINK2_CTL_STS		(PCIE_CFG_OFFSET_ADDR + 0xb0)
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
2.46.1


