Return-Path: <linux-pci+bounces-31386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8523AF734C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57C94E032A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A792E6114;
	Thu,  3 Jul 2025 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="daSYpMWn"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116A2E49BE;
	Thu,  3 Jul 2025 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751544535; cv=none; b=py8NzPEfQEIupv2ijhJ8XCarsxkCD/VSXdI2xqMzbPkzAC9Abmnk2wvMYPrl0+P8JD+tz4z3UqNouFHIpBOswb1pLIJvHMZI6zGzhutz5SIWgKEVW2SnrTgl5KnBG8Ocgj/mXUpgxkkYGGDVaMLM6LAQ0EaJQwvdcsmdeS0hWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751544535; c=relaxed/simple;
	bh=s/94Tgqvq2RSTm7RvG1ScZa66QKOUKbVqBsJ8W4tfRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gm7khnS3Zy+jE5TfOsmehNZXKioH/ndJNNxbSP4TS4WbpqbDDob+7BLyT0EF4vaqWKh2PWCbJA4jgoRg6bvV77G8b0SFLWpeaJc4YxtMtDPyROFXvXutrn/+tXwZ95c/KinDGnmhUacJmNzVSA9AYrzXLMKN/dQQfb2UMqIb7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=daSYpMWn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751544532;
	bh=s/94Tgqvq2RSTm7RvG1ScZa66QKOUKbVqBsJ8W4tfRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=daSYpMWns0gDeAEQYdYJl/nprICGkyhZBZz+/euBYJaZcae1eUlebS6cqpwyihy4I
	 4fn6OhRkjY7KMJeNQJJyf/xP8Rl00GfI3EhC17Y42knWC8jLvXWBJROT6Xneozw1Cj
	 igU5pS/aOy6uXigTcgFW9ckU8seN7PVMEOpzIrb8JKRJjUzb5iKluTHPKNbeADYAeB
	 Ryu2GsSS/cF6GyD4yWPXaLdMDz9ETIk9JhSDYmiXFZ7W1FBJ/N3AO7Yw4xTqYO7r33
	 X6kNAwkSvwTV1tVEFz+gUYhY4N23SK5Hw6kopAHS5aLWKSIMtjm5AwpNMMw88ILDrx
	 5GgDfJujVDXxw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 866B117E059B;
	Thu,  3 Jul 2025 14:08:51 +0200 (CEST)
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
Subject: [PATCH v2 1/3] PCI: mediatek-gen3: Implement sys clock ready time setting
Date: Thu,  3 Jul 2025 14:08:45 +0200
Message-ID: <20250703120847.121826-2-angelogioacchino.delregno@collabora.com>
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

In preparation to add support for the PCI-Express Gen3 controller
found in newer MediaTek SoCs, such as the Dimensity 9400 MT6991
and the MT8196 Chromebook SoC, add the definition for the PCIE
Resource Control register and a new sys_clk_rdy_time_us variable
in platform data.

If sys_clk_rdy_time_us is found (> 0), set the new value in the
aforementioned register only after configuring the controller to
RC mode, as this may otherwise be reset.

Overriding the register defaults for SYS_CLK_RDY_TIME allows to
work around sys_clk_rdy signal glitching in MT6991 and MT8196.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 5464b4ae5c20..8035f7f812aa 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -101,6 +101,9 @@
 #define PCIE_MSI_SET_ADDR_HI_BASE	0xc80
 #define PCIE_MSI_SET_ADDR_HI_OFFSET	0x04
 
+#define PCIE_RESOURCE_CTRL_REG		0xd2c
+#define PCIE_RSRC_SYS_CLK_RDY_TIME_MASK	GENMASK(7, 0)
+
 #define PCIE_ICMD_PM_REG		0x198
 #define PCIE_TURN_OFF_LINK		BIT(4)
 
@@ -148,6 +151,7 @@ enum mtk_gen3_pcie_flags {
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
  * @phy_resets: phy reset lines SoC data.
+ * @sys_clk_rdy_time_us: System clock ready time override (microseconds)
  * @flags: pcie device flags.
  */
 struct mtk_gen3_pcie_pdata {
@@ -156,6 +160,7 @@ struct mtk_gen3_pcie_pdata {
 		const char *id[MAX_NUM_PHY_RESETS];
 		int num_resets;
 	} phy_resets;
+	u8 sys_clk_rdy_time_us;
 	u32 flags;
 };
 
@@ -436,6 +441,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
 	}
 
+	/* If parameter is present, adjust SYS_CLK_RDY_TIME to avoid glitching */
+	if (pcie->soc->sys_clk_rdy_time_us) {
+		val = readl_relaxed(pcie->base + PCIE_RESOURCE_CTRL_REG);
+		val &= ~PCIE_RSRC_SYS_CLK_RDY_TIME_MASK;
+		val |= FIELD_PREP(PCIE_RSRC_SYS_CLK_RDY_TIME_MASK,
+				  pcie->soc->sys_clk_rdy_time_us);
+		writel_relaxed(val, pcie->base + PCIE_RESOURCE_CTRL_REG);
+	}
+
 	/* Set class code */
 	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
 	val &= ~GENMASK(31, 8);
-- 
2.49.0


