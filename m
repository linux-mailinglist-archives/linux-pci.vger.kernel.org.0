Return-Path: <linux-pci+bounces-19196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A761FA003DF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52621883D14
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E941B87E3;
	Fri,  3 Jan 2025 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hn8B+zkR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4A61B218D;
	Fri,  3 Jan 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884056; cv=none; b=UkeTDuQAXHzSDf+5qAKx3R4/5e8K+LrtmJ00N0pT/xflAnkRRuvd2XFy9zZC4p6qBtWN4rpN3FQvrnZirEqKWD5mjKFYHzoxgUSkT1ESrHdSx02F/5SNVg9AMuVRxSy4AU4Us+vEkGJkrdvi7e2aSJ2Fnyssc8SoQ9zkHfbvbtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884056; c=relaxed/simple;
	bh=hPcDHM1ySkLWZHM5oO1err6mPV0+h4GGADoXSG+lrBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIZBiB1ngarEm+BUoYHDA0rrAA1n9Zb88feJTsC0ulpat5KMy9/te3FeaDzIPd54Rb0MPvCOBn1eNbOsqCPoHK3I4VuvRN5LpTFFpAhdp9XdjvlZW0Qi8WTpF4lFbpKi/Bba8Gz4T/Bm6GapUTzpC4moKQODfYEdRBf7N0sZy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hn8B+zkR; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 1453a8ecc99811efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8aGyyE4ZNasZE1YSK6osQK3Ake9zKnUpC4PIOmTm/Ls=;
	b=hn8B+zkRIrdZoXeDwk94xnM08wf7g+Ys0Gcxn15nTdmCQBZqOSuGJltDOQwyIGYp6cnSbA5ihCTWRHkeFDHwwfVAaJy58vjPAUIMuh05UlDsT287J1/KNkQDdmfyFNu9p4DHdTc359X2mUqPOWt2/5bPaQLsQMeeXlEd34jXdaU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b0098205-14e5-4194-b2ec-6e7d47413333,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:7c3a9825-8650-4337-bf57-045b64170f0c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 1453a8ecc99811efbd192953cf12861f-20250103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1980146610; Fri, 03 Jan 2025 14:00:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 14:00:47 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 14:00:46 +0800
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
Subject: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Date: Fri, 3 Jan 2025 14:00:13 +0800
Message-ID: <20250103060035.30688-4-jianjun.wang@mediatek.com>
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

Disable ASPM L0s support because it does not significantly save power
but impacts performance.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index ed3c0614486c..4bd3b39eebe2 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -84,6 +84,9 @@
 #define PCIE_MSI_SET_ENABLE_REG		0x190
 #define PCIE_MSI_SET_ENABLE		GENMASK(PCIE_MSI_SET_NUM - 1, 0)
 
+#define PCIE_LOW_POWER_CTRL_REG		0x194
+#define PCIE_FORCE_DIS_L0S		BIT(8)
+
 #define PCIE_PIPE4_PIE8_REG		0x338
 #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
 #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
@@ -458,6 +461,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val &= ~PCIE_INTX_ENABLE;
 	writel_relaxed(val, pcie->base + PCIE_INT_ENABLE_REG);
 
+	/*
+	 * Disable L0s support because it does not significantly save power
+	 * but impacts performance.
+	 */
+	val = readl_relaxed(pcie->base + PCIE_LOW_POWER_CTRL_REG);
+	val |= PCIE_FORCE_DIS_L0S;
+	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
+
 	/* Disable DVFSRC voltage request */
 	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
-- 
2.46.0


