Return-Path: <linux-pci+bounces-9355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E891A136
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1B0285D3A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3AD745ED;
	Thu, 27 Jun 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F45GtDt1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133F7446BF;
	Thu, 27 Jun 2024 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719475992; cv=none; b=qcRJhxJv40J2bTWXSbGt92KxUFC0/jQVYUZEAyoatn9fnq1D/J6OvqAkI4lyJbe6AvqWy4/x2y6JRcknLl1c/OUwqnO8bC6y3XzLQUATalhh71bQ1lo+C2iJvz4czXZt4KOFdYBJCRwCmv1TO71b+CyLrEfadUBiywhS/8PWaaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719475992; c=relaxed/simple;
	bh=bctJ5X8cViosGAXVyA5Plj7UDdWbweJa/szjoCURJkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjXhrL5pngyYNUsQmYKX2es0lx8blYNBu42wjVV0Tl6t1673LTyULJnUsBtvwmiNeOy/Vgw5vqeDCn0DtiYWj8+eG/E90WjwBznWi628Y6RzAZRwGezchUpEqWsWKRbwGWVfqa6y559bXMohckK0nzvOuV6dXwgNCINoWDa8K/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F45GtDt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F29BC2BD10;
	Thu, 27 Jun 2024 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719475991;
	bh=bctJ5X8cViosGAXVyA5Plj7UDdWbweJa/szjoCURJkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F45GtDt1c7heeSvsahoIETmRGmlMdWJktstJhuW3WBxpyvRsXCWiUmD3jhlGtA7fX
	 ph6PQ//jQ1AT5d2gYr4bxYHQ0FloVvCKPFxKkJ3nenknHUl3QllAleK41rGgvm7Aw6
	 NJJ08UnhDuapOm3u2Lx9+uMc0pxA+7mLYcst5AZ+TP1YNSFGAn1DZCreXmCTlMeRgG
	 aXRuCXr1WH2GvZe6OIAr+1naFL4HTpufXPWnUCCeKURR8VMew5Q8A1Ieq5Kl/Jc4rF
	 mNCsvr6sSgeKD6zIFAnBiYGCcNRsB58dDaF5J43L79B6Wah1917GCgFeDcuQEHb+vO
	 NO0RXO98xPWOw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	robh@kernel.org,
	bhelgaas@google.com,
	linux-mediatek@lists.infradead.org,
	lorenzo.bianconi83@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org,
	nbd@nbd.name,
	dd@embedd.com,
	upstream@airoha.com,
	angelogioacchino.delregno@collabora.com
Subject: [PATCH v2 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Date: Thu, 27 Jun 2024 10:12:14 +0200
Message-ID: <b2c794b21e15ec85a57de144006db9582ce0c949.1719475568.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719475568.git.lorenzo@kernel.org>
References: <cover.1719475568.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce support for Airoha EN7581 PCIe controller to mediatek-gen3
PCIe controller driver.

Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/Kconfig              |  2 +-
 drivers/pci/controller/pcie-mediatek-gen3.c | 96 ++++++++++++++++++++-
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e534c02ee34f..3bd6c9430010 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -196,7 +196,7 @@ config PCIE_MEDIATEK
 
 config PCIE_MEDIATEK_GEN3
 	tristate "MediaTek Gen3 PCIe controller"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
 	depends on PCI_MSI
 	help
 	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 438a5222d986..af567b4355fa 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
 #include <linux/irq.h>
@@ -15,6 +16,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of_device.h>
+#include <linux/of_pci.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -29,6 +32,7 @@
 #define PCI_CLASS(class)		(class << 8)
 #define PCIE_RC_MODE			BIT(0)
 
+#define PCIE_EQ_PRESET_01_REF		0x100
 #define PCIE_CFGNUM_REG			0x140
 #define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
 #define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
@@ -68,6 +72,7 @@
 #define PCIE_MSI_SET_ENABLE_REG		0x190
 #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
 
+#define PCIE_PIPE4_PIE8_REG		0x338
 #define PCIE_MSI_SET_BASE_REG		0xc00
 #define PCIE_MSI_SET_OFFSET		0x10
 #define PCIE_MSI_SET_STATUS_OFFSET	0x04
@@ -100,7 +105,17 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
-#define MAX_NUM_PHY_RESETS		1
+/* EN7581 */
+#define PCIE_PEXTP_DIG_GLB44_P0_REG	0x10044
+#define PCIE_PEXTP_DIG_LN_RX30_P0_REG	0x15030
+#define PCIE_PEXTP_DIG_LN_RX30_P1_REG	0x15130
+
+/* PCIe-PHY initialization delay in ms */
+#define PHY_INIT_TIME_MS		30
+/* PCIe reset line delay in ms */
+#define PCIE_RESET_TIME_MS		100
+
+#define MAX_NUM_PHY_RESETS		3
 
 struct mtk_gen3_pcie;
 
@@ -847,6 +862,74 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	return 0;
 }
 
+static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int err;
+
+	/* Wait for bulk assert completion in mtk_pcie_setup */
+	mdelay(PCIE_RESET_TIME_MS);
+
+	/* Setup Tx-Rx detect time */
+	writel_relaxed(0x23020133, pcie->base + PCIE_PEXTP_DIG_GLB44_P0_REG);
+	/* Setup Rx AEQ training time */
+	writel_relaxed(0x50500032, pcie->base + PCIE_PEXTP_DIG_LN_RX30_P0_REG);
+	writel_relaxed(0x50500032, pcie->base + PCIE_PEXTP_DIG_LN_RX30_P1_REG);
+
+	err = phy_init(pcie->phy);
+	if (err) {
+		dev_err(dev, "failed to initialize PHY\n");
+		return err;
+	}
+	mdelay(PHY_INIT_TIME_MS);
+
+	err = phy_power_on(pcie->phy);
+	if (err) {
+		dev_err(dev, "failed to power on PHY\n");
+		goto err_phy_on;
+	}
+
+	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+	if (err) {
+		dev_err(dev, "failed to deassert PHYs\n");
+		goto err_phy_deassert;
+	}
+	mdelay(PCIE_RESET_TIME_MS);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
+	if (err) {
+		dev_err(dev, "failed to prepare clock\n");
+		goto err_clk_prepare;
+	}
+
+	writel_relaxed(0x41474147, pcie->base + PCIE_EQ_PRESET_01_REF);
+	writel_relaxed(0x1018020f, pcie->base + PCIE_PIPE4_PIE8_REG);
+
+	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
+	if (err) {
+		dev_err(dev, "failed to prepare clock\n");
+		goto err_clk_enable;
+	}
+
+	return 0;
+
+err_clk_enable:
+	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
+err_clk_prepare:
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
+	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+err_phy_deassert:
+	phy_power_off(pcie->phy);
+err_phy_on:
+	phy_exit(pcie->phy);
+
+	return err;
+}
+
 static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
@@ -1113,8 +1196,19 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
 	},
 };
 
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
+	.power_up = mtk_pcie_en7581_power_up,
+	.phy_resets = {
+		.id[0] = "phy-lane0",
+		.id[1] = "phy-lane1",
+		.id[2] = "phy-lane2",
+		.num_resets = 3,
+	},
+};
+
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
+	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
-- 
2.45.2


