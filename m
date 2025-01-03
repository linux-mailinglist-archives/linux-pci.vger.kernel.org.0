Return-Path: <linux-pci+bounces-19200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F054A003F5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF6C1883E36
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791F1BEF99;
	Fri,  3 Jan 2025 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aNaXvgf/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A51B4247;
	Fri,  3 Jan 2025 06:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884064; cv=none; b=BUEoN5xMsLQNnYIKYiyflnEvVcyG42HyhKlyilb7rd2w1NEf+j8XvhZqGo6pzaeBlr+Diy1BoUtZD1qy1Px0ppubDmoij2goqQcjPV7a5nsXVTyAaKxPFU00672D9IeTAukHIdJ1K0Wbjr926TQd1Om0M1cjUPZ4/sODrWROSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884064; c=relaxed/simple;
	bh=KTl3I1MwwBe2FKaNrTomfOM+Oh6JulTIRqBnCyNmpv4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P+1XKmzZMFFG2xyzzeab+gh47HblZ8LD1w+rGsLvhjC1BP0v0dffL9J8qvtKQix+KwqeuMor0GVFhZHkrHwBECsYVWe4vGnFY3OVUIUwHa4gZzx9yZRkR+Ay60dDRLhMLXWahOoo9XB1pfcskAoQH8b6GsRMRgJpwQxZuWqsvww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=aNaXvgf/; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 13bf1178c99811ef99858b75a2457dd9-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TsN1T6L83srZgilF5kt3qouXhBxTQ7s/Q1aBq4w0S/I=;
	b=aNaXvgf/AvIsHxoZQ4CoUHne+8bvsWYH48481XdPlwjtFZeFWZQAqNPk7dT+I5sxmL9Nd6CB2A9H+xGEOkWjloYN4yHOV4eQQ0rDrSUMrJ6FvmsC8X7shZvOEJDgUCOea4+kVI/DVA7ZGbCIgu8whN63zTA0vWFrXzZRmAt6xHQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:e159cbcb-4861-49ab-8eab-f3e053a1d0db,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:00db4b37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 13bf1178c99811ef99858b75a2457dd9-20250103
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1379267781; Fri, 03 Jan 2025 14:00:47 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 14:00:46 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 14:00:45 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: [PATCH 2/5] PCI: mediatek-gen3: Add MT8196 support
Date: Fri, 3 Jan 2025 14:00:12 +0800
Message-ID: <20250103060035.30688-3-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250103060035.30688-1-jianjun.wang@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The MT8196 is an ARM platform SoC that has the same PCIe IP as the
MT8195.
However, it requires additional settings in the pextpcfg registers.
Introduce pextpcfg in PCIe driver for these settings.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 88 +++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index be52e3a123ab..ed3c0614486c 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
@@ -123,6 +124,17 @@
 #define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
 #define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
 
+#define PCIE_RESOURCE_CTRL_REG		0xd2c
+#define PCIE_SYS_CLK_RDY_TIME_MASK	GENMASK(7, 0)
+#define PCIE_SYS_CLK_RDY_TIME_TO_10US	0xa
+
+/* PEXTPCFG Registers */
+#define PEXTP_CLOCK_CON_REG		0x20
+#define PEXTP_P0P1_LOWPOWER_CK_SEL	BIT(0)
+#define PEXTP_REQ_CTRL_0_REG		0x7c
+#define PEXTP_26M_REQ_FORCE_ON		BIT(0)
+#define PEXTP_PCIE26M_BYPASS		BIT(4)
+
 #define MAX_NUM_PHY_RESETS		3
 
 /* Time in ms needed to complete PCIe reset on EN7581 SoC */
@@ -136,10 +148,14 @@ struct mtk_gen3_pcie;
 /**
  * struct mtk_gen3_pcie_pdata - differentiate between host generations
  * @power_up: pcie power_up callback
+ * @pre_init: initialize settings before link up
+ * @cleanup: cleanup when PCIe power down
  * @phy_resets: phy reset lines SoC data.
  */
 struct mtk_gen3_pcie_pdata {
 	int (*power_up)(struct mtk_gen3_pcie *pcie);
+	int (*pre_init)(struct mtk_gen3_pcie *pcie);
+	void (*cleanup)(struct mtk_gen3_pcie *pcie);
 	struct {
 		const char *id[MAX_NUM_PHY_RESETS];
 		int num_resets;
@@ -162,6 +178,7 @@ struct mtk_msi_set {
  * struct mtk_gen3_pcie - PCIe port information
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
+ * @pextpcfg: pextpcfg_ao IO mapped register base
  * @reg_base: physical register base
  * @mac_reset: MAC reset control
  * @phy_resets: PHY reset controllers
@@ -184,6 +201,7 @@ struct mtk_msi_set {
 struct mtk_gen3_pcie {
 	struct device *dev;
 	void __iomem *base;
+	void __iomem *pextpcfg;
 	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
 	struct reset_control_bulk_data phy_resets[MAX_NUM_PHY_RESETS];
@@ -422,6 +440,13 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 		writel_relaxed(val, pcie->base + PCIE_CONF_LINK2_CTL_STS);
 	}
 
+	/*
+	 * The values of some registers are different in RC and EP mode. Therefore,
+	 * call soc->pre_init after the mode change in case it depends on these registers.
+	 */
+	if (pcie->soc && pcie->soc->pre_init)
+		pcie->soc->pre_init(pcie);
+
 	/* Set class code */
 	val = readl_relaxed(pcie->base + PCIE_PCI_IDS_1);
 	val &= ~GENMASK(31, 8);
@@ -848,6 +873,7 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 	int i, ret, num_resets = pcie->soc->phy_resets.num_resets;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *node;
 	struct resource *regs;
 	u32 num_lanes;
 
@@ -903,6 +929,18 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 			pcie->num_lanes = num_lanes;
        }
 
+	node = of_parse_phandle(dev->of_node, "pextpcfg", 0);
+	if (node) {
+		pcie->pextpcfg = of_iomap(node, 0);
+		of_node_put(node);
+		if (IS_ERR(pcie->pextpcfg)) {
+			dev_err(dev, "failed to get pextpcfg\n");
+			ret = PTR_ERR(pcie->pextpcfg);
+			pcie->pextpcfg = NULL;
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
@@ -1047,6 +1085,12 @@ static void mtk_pcie_power_down(struct mtk_gen3_pcie *pcie)
 	phy_power_off(pcie->phy);
 	phy_exit(pcie->phy);
 	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
+
+	if (pcie->soc && pcie->soc->cleanup)
+		pcie->soc->cleanup(pcie);
+
+	if (pcie->pextpcfg)
+		iounmap(pcie->pextpcfg);
 }
 
 static int mtk_pcie_get_controller_max_link_speed(struct mtk_gen3_pcie *pcie)
@@ -1277,6 +1321,49 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8192 = {
 	},
 };
 
+static int mtk_pcie_mt8196_pre_init(struct mtk_gen3_pcie *pcie)
+{
+	u32 val;
+
+	/* Adjust SYS_CLK_RDY_TIME ot 10us to avoid glitch */
+	val = readl_relaxed(pcie->base + PCIE_RESOURCE_CTRL_REG);
+	val &= ~PCIE_SYS_CLK_RDY_TIME_MASK;
+	val |= PCIE_SYS_CLK_RDY_TIME_TO_10US;
+	writel_relaxed(val, pcie->base + PCIE_RESOURCE_CTRL_REG);
+
+	/* Switch to normal clock */
+	val = readl_relaxed(pcie->pextpcfg + PEXTP_CLOCK_CON_REG);
+	val &= ~PEXTP_P0P1_LOWPOWER_CK_SEL;
+	writel_relaxed(val, pcie->pextpcfg + PEXTP_CLOCK_CON_REG);
+
+	/* Force pcie_26m_req and bypass pcie_26m_ack signal */
+	val = readl_relaxed(pcie->pextpcfg + PEXTP_REQ_CTRL_0_REG);
+	val |= (PEXTP_26M_REQ_FORCE_ON | PEXTP_PCIE26M_BYPASS);
+	writel_relaxed(val, pcie->pextpcfg + PEXTP_REQ_CTRL_0_REG);
+
+	return 0;
+}
+
+static void mtk_pcie_mt8196_cleanup(struct mtk_gen3_pcie *pcie)
+{
+	u32 val;
+
+	/* Release pcie_26m_req and pcie_26m_ack signal */
+	val = readl_relaxed(pcie->pextpcfg + PEXTP_REQ_CTRL_0_REG);
+	val &= ~(PEXTP_26M_REQ_FORCE_ON | PEXTP_PCIE26M_BYPASS);
+	writel_relaxed(val, pcie->pextpcfg + PEXTP_REQ_CTRL_0_REG);
+}
+
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_mt8196 = {
+	.power_up = mtk_pcie_power_up,
+	.pre_init = mtk_pcie_mt8196_pre_init,
+	.cleanup = mtk_pcie_mt8196_cleanup,
+	.phy_resets = {
+		.id[0] = "phy",
+		.num_resets = 1,
+	},
+};
+
 static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 	.power_up = mtk_pcie_en7581_power_up,
 	.phy_resets = {
@@ -1290,6 +1377,7 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
+	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
-- 
2.46.0


