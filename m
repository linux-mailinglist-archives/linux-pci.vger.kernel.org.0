Return-Path: <linux-pci+bounces-739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D9C80C3A7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EEFA280D56
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 08:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8562210E3;
	Mon, 11 Dec 2023 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="r/uI4m4y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864CB6;
	Mon, 11 Dec 2023 00:53:15 -0800 (PST)
X-UUID: b59a0048980211eeba30773df0976c77-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=omy/CemmEUqSfeI9bxjlTEDAt4GSH2fXIlmTOehEny0=;
	b=r/uI4m4y31cm/DQL/G7EaZcYapkapFR1NvY6fdVdL1hg1QxT7ISKVjH3Mwerye2NlobmkWYNxz0t5ZiWfGDMPDQjWl59FfiDXvhwAi9QdvT9Fz9iMUX88DWvmNsLQOZAGDLWcRmD8PllP4fcdpgZST1p69kWMmnuM9eoEqu2AIU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:905a9014-0ce8-4193-b0fd-d79632fd3fef,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:40700e61-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b59a0048980211eeba30773df0976c77-20231211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 870822705; Mon, 11 Dec 2023 16:53:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 16:53:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 16:53:07 +0800
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
Subject: [PATCH v2 2/3] PCI: mediatek-gen3: Do not break probe flow when MSI init fails
Date: Mon, 11 Dec 2023 16:52:55 +0800
Message-ID: <20231211085256.31292-3-jianjun.wang@mediatek.com>
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

Since INTx can still work, the driver probe flow should not be broken by
MSI initialization failures. Additionally, moving the MSI initialization
code into a single function enhances readability.

Fixes: 1bdafba538be ("PCI: mediatek-gen3: Add MSI support")
Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 68 ++++++++++-----------
 1 file changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index c1ae3d19ec9a..c6a6876d233a 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -649,59 +649,51 @@ static const struct irq_domain_ops intx_domain_ops = {
 	.map = mtk_pcie_intx_map,
 };
 
-static int mtk_pcie_init_irq_domains(struct mtk_gen3_pcie *pcie)
+static int mtk_pcie_init_msi(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *intc_node, *node = dev->of_node;
-	int ret;
-
-	raw_spin_lock_init(&pcie->irq_lock);
-
-	/* Setup INTx */
-	intc_node = of_get_child_by_name(node, "interrupt-controller");
-	if (!intc_node) {
-		dev_err(dev, "missing interrupt-controller node\n");
-		return -ENODEV;
-	}
-
-	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
-	if (!pcie->intx_domain) {
-		dev_err(dev, "failed to create INTx IRQ domain\n");
-		ret = -ENODEV;
-		goto out_put_node;
-	}
+	struct device_node *node = dev->of_node;
 
-	/* Setup MSI */
 	mutex_init(&pcie->lock);
 
 	pcie->msi_bottom_domain = irq_domain_add_linear(node, PCIE_MSI_IRQS_NUM,
 				  &mtk_msi_bottom_domain_ops, pcie);
 	if (!pcie->msi_bottom_domain) {
 		dev_err(dev, "failed to create MSI bottom domain\n");
-		ret = -ENODEV;
-		goto err_msi_bottom_domain;
+		return -ENODEV;
 	}
 
-	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode,
-						     &mtk_msi_domain_info,
+	pcie->msi_domain = pci_msi_create_irq_domain(dev->fwnode, &mtk_msi_domain_info,
 						     pcie->msi_bottom_domain);
 	if (!pcie->msi_domain) {
 		dev_err(dev, "failed to create MSI domain\n");
-		ret = -ENODEV;
-		goto err_msi_domain;
+		irq_domain_remove(pcie->msi_bottom_domain);
+		return -ENODEV;
 	}
 
-	of_node_put(intc_node);
 	return 0;
+}
 
-err_msi_domain:
-	irq_domain_remove(pcie->msi_bottom_domain);
-err_msi_bottom_domain:
-	irq_domain_remove(pcie->intx_domain);
-out_put_node:
+static int mtk_pcie_init_intx(struct mtk_gen3_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	struct device_node *intc_node, *node = dev->of_node;
+
+	intc_node = of_get_child_by_name(node, "interrupt-controller");
+	if (!intc_node) {
+		dev_err(dev, "missing interrupt-controller node\n");
+		return -ENODEV;
+	}
+
+	pcie->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, pcie);
 	of_node_put(intc_node);
-	return ret;
+	if (!pcie->intx_domain) {
+		dev_err(dev, "failed to create INTx IRQ domain\n");
+		return -ENODEV;
+	}
+
+	return 0;
 }
 
 static void mtk_pcie_irq_teardown(struct mtk_gen3_pcie *pcie)
@@ -774,10 +766,16 @@ static int mtk_pcie_setup_irq(struct mtk_gen3_pcie *pcie)
 	struct platform_device *pdev = to_platform_device(dev);
 	int err;
 
-	err = mtk_pcie_init_irq_domains(pcie);
+	raw_spin_lock_init(&pcie->irq_lock);
+
+	err = mtk_pcie_init_intx(pcie);
 	if (err)
 		return err;
 
+	err = mtk_pcie_init_msi(pcie);
+	if (err)
+		dev_warn(dev, "no MSI supported, only INTx available\n");
+
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq < 0)
 		return pcie->irq;
-- 
2.18.0


