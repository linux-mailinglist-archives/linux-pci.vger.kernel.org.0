Return-Path: <linux-pci+bounces-19201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1DA003F8
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8763D1883E4A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FAB1C0DF3;
	Fri,  3 Jan 2025 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="V7g8Q3Cz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54591BFE06;
	Fri,  3 Jan 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884066; cv=none; b=FsrOaEiCebu3iAKq8ZssK3GygWO70k6hGHSh+bZEF6uKTYr2C21HCtz3PjhbKWTXcUCrJoWcZiVeyuTHEqpFAUiRYorLKsbe2FdHfU9eMEmZHrz8l+k79u+CLiVasC2BhNicEmsL+9jwzqAu37QpO+UCrXY/uILIu8zQk+pp+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884066; c=relaxed/simple;
	bh=xgJt1PiohxZt9+Q5bz64xIhhFYfucsVNB2GH3kcy7V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mj2zpDx2SMCF5gUb72tvENYgYInEnvNcRDbW+KEvY5zhr37kZpcr6kt+paNbPlHM5+ACzLTyWlI/Vm7B+thQa2dw6s/aDc0Buoy0hNw3xFzoEaIisEOioWE4IMtg6dy28CfM0xg1oE4lb0UST/Hn6m8PxMq6T4Sh3aBZikLW4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=V7g8Q3Cz; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 156b617ac99811ef99858b75a2457dd9-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5fd/q59gvByZH+NptJiVBXQPQ56n4yqQJajHMESFfjw=;
	b=V7g8Q3CznUgwxThh1EL3yMgF3UjCr0UUsKLHLoQ/0uhJPBG+lMUdfS+IHWPiyZmVzIy0j1yEg+PPkcM84+n3iYUkGy5K5igomns9dWaJbj0TF/A+2HhY/Xc1HegdApnU9IReoo+UnWwRzNEd/mH7fOAUVKxPapbW4NLXLH6zIRI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:ef43ca26-9975-4aba-a989-36d79d097b0b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:51db4b37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 156b617ac99811ef99858b75a2457dd9-20250103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 76984584; Fri, 03 Jan 2025 14:00:50 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 14:00:49 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 14:00:48 +0800
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
Subject: [PATCH 5/5] PCI: mediatek-gen3: Keep PCIe power and clocks if suspend-to-idle
Date: Fri, 3 Jan 2025 14:00:15 +0800
Message-ID: <20250103060035.30688-6-jianjun.wang@mediatek.com>
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

If the target system sleep state is suspend-to-idle, the bridge is
supposed to stay in D0, and the framework will not help to restore its
configuration space, so keep its power and clocks during suspend.

It's recommended to enable L1ss support, so the link can be changed to
L1.2 state during suspend.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 48f83c2d91f7..11da68910502 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1291,6 +1291,19 @@ static int mtk_pcie_suspend_noirq(struct device *dev)
 	int err;
 	u32 val;
 
+	/*
+	 * If the target system sleep state is suspend-to-idle, the bridge is supposed to stay in
+	 * D0, and the framework will not help to restore its configuration space, so keep it's
+	 * power and clocks during suspend.
+	 *
+	 * It's recommended to enable L1ss support, so the link can be changed to L1.2 state during
+	 * suspend.
+	 */
+	if (pm_suspend_default_s2idle()) {
+		dev_info(dev, "System enter s2idle state, keep PCIe power and clocks\n");
+		return 0;
+	}
+
 	/* Trigger link to L2 state */
 	err = mtk_pcie_turn_off_link(pcie);
 	if (err) {
@@ -1316,6 +1329,11 @@ static int mtk_pcie_resume_noirq(struct device *dev)
 	struct mtk_gen3_pcie *pcie = dev_get_drvdata(dev);
 	int err;
 
+	if (pm_suspend_default_s2idle()) {
+		dev_info(dev, "System enter s2idle state, no need to reinitialization\n");
+		return 0;
+	}
+
 	err = pcie->soc->power_up(pcie);
 	if (err)
 		return err;
-- 
2.46.0


