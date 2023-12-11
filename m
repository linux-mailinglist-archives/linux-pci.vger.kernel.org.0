Return-Path: <linux-pci+bounces-740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A6880C3AC
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 09:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2893CB208B2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DDC1CA9A;
	Mon, 11 Dec 2023 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PzMBg6dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF6FD2;
	Mon, 11 Dec 2023 00:53:18 -0800 (PST)
X-UUID: b62cd27e980211eeba30773df0976c77-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w4455XGsMArNWjLmEQ0U4U439b6LEEfP+V6Q0xda3RE=;
	b=PzMBg6dcZZ/fK0DUbHucQsaJxBilRuIde1WA7s/0rCH3UWAae/sYPJQ50lgt/ODNGCeN+dfRrF5jEvjrc6t/pGftsN/Wr5uELX2bVhZz/wDxSJEN0MmwHZluRLSreBU38FDLSGM6nimGDr76MLKcjmIYm+cFUa9CU8tFRiqbD1E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:78f004b4-9474-462f-8f89-5712c51aca6d,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:d82887fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: b62cd27e980211eeba30773df0976c77-20231211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1715524657; Mon, 11 Dec 2023 16:53:10 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 16:53:09 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 16:53:08 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Marc Zyngier <maz@kernel.org>
CC: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
	<chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
	<jian.yang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH v2 3/3] PCI: mediatek-gen3: Allocate MSI address with dmam_alloc_coherent()
Date: Mon, 11 Dec 2023 16:52:56 +0800
Message-ID: <20231211085256.31292-4-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211085256.31292-1-jianjun.wang@mediatek.com>
References: <20231211085256.31292-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Use dmam_alloc_coherent() to allocate the MSI address, instead of using
static physical address.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 72 ++++++++++++---------
 1 file changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index c6a6876d233a..7cfd7ef9ad95 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -120,7 +120,6 @@ struct mtk_msi_set {
  * struct mtk_gen3_pcie - PCIe port information
  * @dev: pointer to PCIe device
  * @base: IO mapped register base
- * @reg_base: physical register base
  * @mac_reset: MAC reset control
  * @phy_reset: PHY reset control
  * @phy: PHY controller block
@@ -139,7 +138,6 @@ struct mtk_msi_set {
 struct mtk_gen3_pcie {
 	struct device *dev;
 	void __iomem *base;
-	phys_addr_t reg_base;
 	struct reset_control *mac_reset;
 	struct reset_control *phy_reset;
 	struct phy *phy;
@@ -309,24 +307,8 @@ static int mtk_pcie_set_trans_table(struct mtk_gen3_pcie *pcie,
 
 static void mtk_pcie_enable_msi(struct mtk_gen3_pcie *pcie)
 {
-	int i;
 	u32 val;
 
-	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
-		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
-
-		msi_set->base = pcie->base + PCIE_MSI_SET_BASE_REG +
-				i * PCIE_MSI_SET_OFFSET;
-		msi_set->msg_addr = pcie->reg_base + PCIE_MSI_SET_BASE_REG +
-				    i * PCIE_MSI_SET_OFFSET;
-
-		/* Configure the MSI capture address */
-		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
-		writel_relaxed(upper_32_bits(msi_set->msg_addr),
-			       pcie->base + PCIE_MSI_SET_ADDR_HI_BASE +
-			       i * PCIE_MSI_SET_ADDR_HI_OFFSET);
-	}
-
 	val = readl_relaxed(pcie->base + PCIE_MSI_SET_ENABLE_REG);
 	val |= PCIE_MSI_SET_ENABLE;
 	writel_relaxed(val, pcie->base + PCIE_MSI_SET_ENABLE_REG);
@@ -653,6 +635,29 @@ static int mtk_pcie_init_msi(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
+	struct mtk_msi_set *msi_set;
+	void *msg_vaddr[PCIE_MSI_SET_NUM];
+	int i, j, ret = -ENODEV;
+
+	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
+		msi_set = &pcie->msi_sets[i];
+
+		msi_set->base = pcie->base + PCIE_MSI_SET_BASE_REG +
+				i * PCIE_MSI_SET_OFFSET;
+
+		msg_vaddr[i] = dmam_alloc_coherent(dev, sizeof(dma_addr_t),
+							 &msi_set->msg_addr, GFP_KERNEL);
+		if (!msg_vaddr[i]) {
+			dev_err(dev, "failed to alloc and map MSI address for set %d\n", i);
+			ret = -ENOMEM;
+			goto err_alloc_addr;
+		}
+
+		/* Configure the MSI capture address */
+		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
+		writel_relaxed(upper_32_bits(msi_set->msg_addr), pcie->base +
+			       PCIE_MSI_SET_ADDR_HI_BASE + i * PCIE_MSI_SET_ADDR_HI_OFFSET);
+	}
 
 	mutex_init(&pcie->lock);
 
@@ -660,18 +665,24 @@ static int mtk_pcie_init_msi(struct mtk_gen3_pcie *pcie)
 				  &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
-		return -ENODEV;
+		goto err_alloc_addr;
 	}
 
 	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode, &mtk_msi_domain_info,
 						     pcie->msi_bottom_domain);
-	if (!pcie->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(pcie->msi_bottom_domain);
-		return -ENODEV;
+	if (pcie->msi_domain)
+		return 0;
+
+	dev_err(dev, "failed to create MSI domain\n");
+	irq_domain_remove(pcie->msi_bottom_domain);
+
+err_alloc_addr:
+	for (j = 0; j < i; j++) {
+		msi_set = &pcie->msi_sets[j];
+		dmam_free_coherent(dev, sizeof(dma_addr_t), msg_vaddr[j], msi_set->msg_addr);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int mtk_pcie_init_intx(struct mtk_gen3_pcie *pcie)
@@ -789,20 +800,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	struct resource *regs;
 	int ret;
 
-	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
-	if (!regs)
-		return -EINVAL;
-	pcie->base = devm_ioremap_resource(dev, regs);
+	pcie->base = devm_platform_ioremap_resource_byname(pdev, "pcie-mac");
 	if (IS_ERR(pcie->base)) {
 		dev_err(dev, "failed to map register base\n");
 		return PTR_ERR(pcie->base);
 	}
 
-	pcie->reg_base = regs->start;
-
 	pcie->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
 	if (IS_ERR(pcie->phy_reset)) {
 		ret = PTR_ERR(pcie->phy_reset);
@@ -1013,6 +1018,11 @@ static void mtk_pcie_irq_restore(struct mtk_gen3_pcie *pcie)
 	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
 		struct mtk_msi_set *msi_set = &pcie->msi_sets[i];
 
+		/* Configure the MSI capture address */
+		writel_relaxed(lower_32_bits(msi_set->msg_addr), msi_set->base);
+		writel_relaxed(upper_32_bits(msi_set->msg_addr), pcie->base +
+			       PCIE_MSI_SET_ADDR_HI_BASE + i * PCIE_MSI_SET_ADDR_HI_OFFSET);
+
 		writel_relaxed(msi_set->saved_irq_state,
 			       msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
 	}
-- 
2.18.0


