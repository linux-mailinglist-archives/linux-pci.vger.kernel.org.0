Return-Path: <linux-pci+bounces-543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 678128069D1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 09:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D105B1F2156F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A31944D;
	Wed,  6 Dec 2023 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u3hpMb9B"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CC4C3;
	Wed,  6 Dec 2023 00:38:20 -0800 (PST)
X-UUID: cc2e2580941211ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=73koCofZDqmsIg3RWsQNbfp+mHALtOtkTxc6gTpLsjU=;
	b=u3hpMb9B6QxC5UjskNllsQoUz1eEy4Ss+/uIrXwarZ3h26wQNZl/YJWJg0KlCW41Fb0HsDI4LgPNc6rN/ZwLTWDwRDy9vd6f5A0EUSW4kVNyHlV+3x6zFFGDeet+oZLR9FhOmn9+NoBa9Q5QgG7fTYxgfSfysl7cGBjtANhCHak=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:13300279-8eb4-4b86-a36f-a92b106e692e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:abefa75,CLOUDID:22c1e060-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: cc2e2580941211ee8051498923ad61e6-20231206
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 796027206; Wed, 06 Dec 2023 16:38:15 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 16:38:13 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 16:38:13 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <jieyy.yang@mediatek.com>,
	<chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
	<jian.yang@mediatek.com>, <jianguo.zhang@mediatek.com>
Subject: [PATCH 1/2] PCI: mediatek: Allocate MSI address with dmam_alloc_coherent
Date: Wed, 6 Dec 2023 16:37:52 +0800
Message-ID: <20231206083753.18186-2-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206083753.18186-1-jianjun.wang@mediatek.com>
References: <20231206083753.18186-1-jianjun.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Use 'dmam_alloc_coherent' to allocate the MSI address, instead of using
'virt_to_phys'.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 29 ++++++++++++++++++--------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 66a8f73296fc..b080f7ca6da0 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -178,6 +178,7 @@ struct mtk_pcie_soc {
  * @phy: pointer to PHY control block
  * @slot: port slot
  * @irq: GIC irq
+ * @msg_addr: MSI message address
  * @irq_domain: legacy INTx IRQ domain
  * @inner_domain: inner IRQ domain
  * @msi_domain: MSI IRQ domain
@@ -198,6 +199,7 @@ struct mtk_pcie_port {
 	struct phy *phy;
 	u32 slot;
 	int irq;
+	dma_addr_t msg_addr;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
@@ -394,12 +396,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
 static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr;
 
 	/* MT2712/MT7622 only support 32-bit MSI addresses */
-	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
 	msg->address_hi = 0;
-	msg->address_lo = lower_32_bits(addr);
+	msg->address_lo = lower_32_bits(port->msg_addr);
 
 	msg->data = data->hwirq;
 
@@ -515,18 +515,26 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 	return 0;
 }
 
-static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
+static int mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 {
 	u32 val;
-	phys_addr_t msg_addr;
+	void *msi_vaddr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
-	val = lower_32_bits(msg_addr);
+	msi_vaddr = dmam_alloc_coherent(port->pcie->dev, sizeof(dma_addr_t), &port->msg_addr,
+					GFP_KERNEL);
+	if (!msi_vaddr) {
+		dev_err(port->pcie->dev, "failed to alloc and map MSI data\n");
+		return -ENOMEM;
+	}
+
+	val = lower_32_bits(port->msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
 	val = readl(port->base + PCIE_INT_MASK);
 	val &= ~MSI_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
+
+	return 0;
 }
 
 static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
@@ -732,8 +740,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	val &= ~INTX_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		mtk_pcie_enable_msi(port);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = mtk_pcie_enable_msi(port);
+		if (err)
+			return err;
+	}
 
 	/* Set AHB to PCIe translation windows */
 	val = lower_32_bits(mem->start) |
-- 
2.18.0


