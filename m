Return-Path: <linux-pci+bounces-741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6888D80C3A8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 09:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145C61F2102D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 08:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42478210E9;
	Mon, 11 Dec 2023 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RNXKMyg3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A364EC4;
	Mon, 11 Dec 2023 00:53:16 -0800 (PST)
X-UUID: b649325c980211eea5db2bebc7c28f94-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=N8a2skbn3ldUXfGVBRWQ1u0Qf2+Xz3OWdG8kf2ohLgc=;
	b=RNXKMyg3ZOCfIqHfxthJKg++dBfxLIQNc8+iXnJs8p+p4Ooxpm+ALD6eYJ5R0ViYlc2Jp6GRN07Hp2LaDpO8FXqRbnLaDJhibwxByqhhbHphIZLoVKI3OHFtJjvS8cOPdg0TBphLWh7YRwMYP4bqoptAKjk7+0ZlgXvS/kAlKsU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d14b24b7-0931-4916-92c8-a68885c58a0a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:dd2887fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: b649325c980211eea5db2bebc7c28f94-20231211
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1958292593; Mon, 11 Dec 2023 16:53:11 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 16:53:07 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 16:53:06 +0800
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
Subject: [PATCH v2 1/3] PCI: mediatek: Allocate MSI address with dmam_alloc_coherent()
Date: Mon, 11 Dec 2023 16:52:54 +0800
Message-ID: <20231211085256.31292-2-jianjun.wang@mediatek.com>
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
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.452000-8.000000
X-TMASE-MatchedRID: YlUeb+P3LGlBHBd/Q+ztBwPZZctd3P4BIaVkFIrQFhtb6PBUqmq+UlYu
	mEk/UtlHxvP5MvmYpyBTc0C6OSQvz8pFJHzzp4rS58dk5sbwmyjGYnoF/CTeZVSOymiJfTYXlwW
	f7/4SyDtrg8FCypqvfGmevJVqJe6AHxPMjOKY7A8LbigRnpKlKZvjAepGmdoOjSE7r38ccucfAi
	JtYJYn7WCx0B/Tk9JmY616mIENddzqpQj72dAQYgHduAz87L4zdUVIHoasg2idNYuO1rAFqL0we
	Uq5YYes8jae4OD13tAV7Mc+rowcVKtX/F0pBwVJjSV5hDFby7ZnIxZyJs78kg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.452000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3399B1CCA37B4999E57B22197D5592ECC7DE562E04091DEA609953BF1EF284B22000:8
X-MTK: N

Use dmam_alloc_coherent() to allocate the MSI address, instead of using
virt_to_phys().

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 66a8f73296fc..2fb9e44369f8 100644
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
 
@@ -494,6 +494,14 @@ static struct msi_domain_info mtk_msi_domain_info = {
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
 	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	void *msi_vaddr;
+
+	msi_vaddr = dmam_alloc_coherent(port->pcie->dev, sizeof(dma_addr_t), &port->msg_addr,
+					GFP_KERNEL);
+	if (!msi_vaddr) {
+		dev_err(port->pcie->dev, "failed to alloc and map MSI address\n");
+		return -ENOMEM;
+	}
 
 	mutex_init(&port->lock);
 
@@ -501,6 +509,7 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 						      &msi_domain_ops, port);
 	if (!port->inner_domain) {
 		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
+		dmam_free_coherent(port->pcie->dev, sizeof(dma_addr_t), msi_vaddr, port->msg_addr);
 		return -ENOMEM;
 	}
 
@@ -508,6 +517,7 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 						     port->inner_domain);
 	if (!port->msi_domain) {
 		dev_err(port->pcie->dev, "failed to create MSI domain\n");
+		dmam_free_coherent(port->pcie->dev, sizeof(dma_addr_t), msi_vaddr, port->msg_addr);
 		irq_domain_remove(port->inner_domain);
 		return -ENOMEM;
 	}
@@ -518,10 +528,8 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 {
 	u32 val;
-	phys_addr_t msg_addr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
-	val = lower_32_bits(msg_addr);
+	val = lower_32_bits(port->msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
 	val = readl(port->base + PCIE_INT_MASK);
@@ -588,7 +596,7 @@ static int mtk_pcie_init_irq_domain(struct mtk_pcie_port *port,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		ret = mtk_pcie_allocate_msi_domains(port);
 		if (ret)
-			return ret;
+			dev_warn(dev, "no MSI supported, only INTx available\n");
 	}
 
 	return 0;
@@ -732,7 +740,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	val &= ~INTX_MASK;
 	writel(val, port->base + PCIE_INT_MASK);
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
+	if (IS_ENABLED(CONFIG_PCI_MSI) && port->msi_domain)
 		mtk_pcie_enable_msi(port);
 
 	/* Set AHB to PCIe translation windows */
-- 
2.18.0


