Return-Path: <linux-pci+bounces-19384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA72A0374C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 06:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C86D3A1154
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 05:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7F141987;
	Tue,  7 Jan 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HSIbbIbL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D29E188A0D;
	Tue,  7 Jan 2025 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736227282; cv=none; b=Ah20VSTHr8R9MFD6rN83nfhHxtkAhp1p2zGTTvI8vDr/KN5VheWPa4jhYh7LcTnqXKZIS9hObQKG3aX+7AdRP3CQ7R1adFQYqGG90L8ziNjVbLVVimhJjhdDB4FO8hQRH3EC80oduad06KOE0HOItLsYzqdG/iab7LNdTvWTzsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736227282; c=relaxed/simple;
	bh=fXgUWoIbIysK6RhCvhvcoGaPIUwiOdOz1mN5YLq+0Ho=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p25YcOiGjrO2kUE/IVs+dnFIdWi/OaVgJGNfGnTSkfJ6iJh/7Y10/Ee0FbLWqrsMeaYSf1f9TlnOVcRGTIV7ZYc40FO9F7jycitYAc/XyGvwUyAO98xLs3e5DJRI4GhN+hIvDA7mfwEaZMTzDzHKHxaflEVVb7gXLyOsP3eizmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HSIbbIbL; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 35b4d502ccb711ef99858b75a2457dd9-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=KZz8IJT3Behlj/SYm2zXDzCba/a/DTK3QmgKi1MNypk=;
	b=HSIbbIbLCKTZHvv2kVivfN9fGbBoJhNl3DtTJ6uuU6Ui+HX2PtMfrfOMHFYjos51HdF59R3h02h/qHJmb5MfZ81dmeGdsjR9ZhXmUTV/934v7+mE4ccLQzPEfKDrFiKnz8CDDngYlMrnW8N/GxpOVnO7uwiQfYJ1EnGFzGwFjn4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:91fd3362-5971-44ae-a5bf-95170a65ae34,IP:0,U
	RL:0,TC:0,Content:-25,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-50
X-CID-META: VersionHash:60aa074,CLOUDID:eca9c349-1563-4a46-85ba-7ddee3d98b2a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:1,IP:nil
	,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 35b4d502ccb711ef99858b75a2457dd9-20250107
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2042080541; Tue, 07 Jan 2025 13:21:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 13:21:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 13:21:10 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] PCI: mediatek: Remove the usage of virt_to_phys
Date: Tue, 7 Jan 2025 13:20:58 +0800
Message-ID: <20250107052108.8643-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Remove the usage of virt_to_phys, as it will cause sparse warnings when
building on some platforms.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 3bcfc4e58ba2..dc1e5fd6c7aa 100644
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
+	phys_addr_t msg_addr;
 	struct irq_domain *irq_domain;
 	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
@@ -393,12 +395,10 @@ static struct pci_ops mtk_pcie_ops_v2 = {
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
 
@@ -510,10 +510,8 @@ static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
 {
 	u32 val;
-	phys_addr_t msg_addr;
 
-	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
-	val = lower_32_bits(msg_addr);
+	val = lower_32_bits(port->msg_addr);
 	writel(val, port->base + PCIE_IMSI_ADDR);
 
 	val = readl(port->base + PCIE_INT_MASK);
@@ -913,6 +911,7 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	struct mtk_pcie_port *port;
 	struct device *dev = pcie->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *regs;
 	char name[10];
 	int err;
 
@@ -921,12 +920,18 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 		return -ENOMEM;
 
 	snprintf(name, sizeof(name), "port%d", slot);
-	port->base = devm_platform_ioremap_resource_byname(pdev, name);
+	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
+	if (!regs)
+		return -EINVAL;
+
+	port->base = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(port->base)) {
 		dev_err(dev, "failed to map port%d base\n", slot);
 		return PTR_ERR(port->base);
 	}
 
+	port->msg_addr = regs->start + PCIE_MSI_VECTOR;
+
 	snprintf(name, sizeof(name), "sys_ck%d", slot);
 	port->sys_ck = devm_clk_get(dev, name);
 	if (IS_ERR(port->sys_ck)) {
-- 
2.46.0


