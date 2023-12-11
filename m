Return-Path: <linux-pci+bounces-738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE1F80C3A6
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 09:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70541C20356
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 08:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0C3210E0;
	Mon, 11 Dec 2023 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JHJTPgOu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879BCF;
	Mon, 11 Dec 2023 00:53:15 -0800 (PST)
X-UUID: b469c76c980211eeba30773df0976c77-20231211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=S8Q7Mv3mUGNGzzvuC/1WOIYCEeIgNGLe2Uxin8KDTig=;
	b=JHJTPgOuYIt1ikFYTXlsJD4WRlmRJZZ5/+qQKKGqY8Meolo+fJ+J+dW0fkwmGMwFoRBMYEfibULHW5dECRMCT/swoCPUJL7HT8fZHDmT9E/x51eh5REZhVuogb4/pawnf6HPiVNOaA+IxaRvUvjw1Dlk2LHBPpQjj0U4yzUGST8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4ae37146-c255-4ae2-9f69-ec06d7ccaa37,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:1a700e61-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b469c76c980211eeba30773df0976c77-20231211
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 116807410; Mon, 11 Dec 2023 16:53:07 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Dec 2023 16:53:06 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Dec 2023 16:53:05 +0800
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
Subject: [PATCH v2 0/3] PCI: mediatek: Allocate MSI address with dmam_alloc_coherent()
Date: Mon, 11 Dec 2023 16:52:53 +0800
Message-ID: <20231211085256.31292-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

These series of patches change the allocation of MSI address on MediaTek
platform, which uses dmam_alloc_coherent() to allocate the MSI address.

Changes in v2:
1. Add a separate patch for pcie-mediatek-gen3.c to prevent break the
   probe flow when MSI init fails.
2. Change the location of allocate the MSI address to prevent break the
   probe flow.

Jianjun Wang (3):
  PCI: mediatek: Allocate MSI address with dmam_alloc_coherent()
  PCI: mediatek-gen3: Do not break probe flow when MSI init fails
  PCI: mediatek-gen3: Allocate MSI address with dmam_alloc_coherent()

 drivers/pci/controller/pcie-mediatek-gen3.c | 126 +++++++++++---------
 drivers/pci/controller/pcie-mediatek.c      |  24 ++--
 2 files changed, 83 insertions(+), 67 deletions(-)

-- 
2.18.0


