Return-Path: <linux-pci+bounces-19197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E68DFA003E2
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E35023A3B2A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CADC1B21B2;
	Fri,  3 Jan 2025 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qOIEPzQo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2C11B3929;
	Fri,  3 Jan 2025 06:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884057; cv=none; b=NTp6hc7uhewTFwOItGAYezRQmvsu4poyL9YUyAekcol/HTiYYKuLFtMnVvd+sbCMJd8NX3wRpPtnyxaVRv+SJ8+OX08iz8qIILsCfeagUbQ2GZFoH7lbGfuzQYU0e9xpRXTFDb+rLD417/VMU5zZdWLEGUjy7f8M/VvX40Q8TrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884057; c=relaxed/simple;
	bh=hiSOX3bPBqqRmiw/RBsChplWbNf83SuyXeUkUsEz420=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcNGXBLUwUuoEhhDkEINfOT4UGeDZVSDFIJ6a5vs92vTz2aiE21PvCuqPjqXs888bdOVnqUbZdw3H0E1ZiIVMYUIj705s7lbwi/GuiRdW2wTewhgh+5LNYNnMM8G9gfsn5ZLy5fl++e5H0mZRqXZBR0bhmXadQzzlKaEcO4Qi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=qOIEPzQo; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 14f06538c99811efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=7pw2Eg2CoZnwYLB8feuiTpkmmwpupbCUbpnCYeC/dUI=;
	b=qOIEPzQoODDc5mvJv1HcdOvn7lv93s/30iIyQ2Hl7BD0oJg4iOpSQeZp8hZmsWA+dbh6L6yJ65h2zBvjltfqaoYRq6ziaKP4kXJaifE2KH8qh6ufnDMtcLWL2rgNoLjN1YYQwpMt343Wx9Yu/alEQUa/psdftw+37uaC6/y2m3Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:0891963f-96f4-483d-ab1d-b0bb2d8a8695,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:60aa074,CLOUDID:47db4b37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:5,
	IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 14f06538c99811efbd192953cf12861f-20250103
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 303339245; Fri, 03 Jan 2025 14:00:49 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 14:00:48 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 14:00:47 +0800
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
Subject: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Date: Fri, 3 Jan 2025 14:00:14 +0800
Message-ID: <20250103060035.30688-5-jianjun.wang@mediatek.com>
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

There are some circumstances where the EP device will not respond to
non-posted access from the root port (e.g., MMIO read). In such cases,
the root port will reply with an AXI slave error, which will be treated
as a System Error (SError), causing a kernel panic and preventing us
from obtaining any useful information for further debugging.

We have added a new bit in the PCIE_AXI_IF_CTRL_REG register to prevent
PCIe AXI0 from replying with a slave error. Setting this bit on an older
platform that does not support this feature will have no effect.

By preventing AXI0 from replying with a slave error, we can keep the
kernel alive and debug using the information from AER.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 4bd3b39eebe2..48f83c2d91f7 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -87,6 +87,9 @@
 #define PCIE_LOW_POWER_CTRL_REG		0x194
 #define PCIE_FORCE_DIS_L0S		BIT(8)
 
+#define PCIE_AXI_IF_CTRL_REG		0x1a8
+#define PCIE_AXI0_SLV_RESP_MASK		BIT(12)
+
 #define PCIE_PIPE4_PIE8_REG		0x338
 #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
 #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
@@ -469,6 +472,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
 	val |= PCIE_FORCE_DIS_L0S;
 	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
 
+	/*
+	 * Prevent PCIe AXI0 from replying a slave error, as it will cause kernel panic
+	 * and prevent us from getting useful information.
+	 * Keep the kernel alive and debug using the information from AER.
+	 */
+	val = readl_relaxed(pcie->base + PCIE_AXI_IF_CTRL_REG);
+	val |= PCIE_AXI0_SLV_RESP_MASK;
+	writel_relaxed(val, pcie->base + PCIE_AXI_IF_CTRL_REG);
+
 	/* Disable DVFSRC voltage request */
 	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
 	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
-- 
2.46.0


