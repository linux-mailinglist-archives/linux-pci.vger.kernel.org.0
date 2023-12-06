Return-Path: <linux-pci+bounces-542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CE88069D4
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 09:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DE71C20EC1
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 08:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A714018;
	Wed,  6 Dec 2023 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qWzlufY8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B30E112;
	Wed,  6 Dec 2023 00:38:19 -0800 (PST)
X-UUID: cc1af848941211ee8051498923ad61e6-20231206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RtukihSfDsWlz+b8X+aaWJa3MkvBLzgY/4xO0VNr2hY=;
	b=qWzlufY8kvg1kVYOG96CFKSJG+GAycUB9q5pviRHYJaRUwl8YG68nARKHrGL4nO+rgWwtht+xdUtwDAnmcKCaxCTraARS4quh404OULQoC2WRRkcmH8elvS3QW2CmG9LaRWpAJubekjU2ZJnWkwr/oHLLWdOvxlUOnR3IIqlU+4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:1f0aa776-5ebf-4e3e-a1c0-de5e02b7c6ca,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:abefa75,CLOUDID:20c1e060-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cc1af848941211ee8051498923ad61e6-20231206
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1172057785; Wed, 06 Dec 2023 16:38:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Dec 2023 16:38:12 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Dec 2023 16:38:12 +0800
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
Subject: [PATCH 0/2] PCI: mediatek: Allocate MSI address with dmam_alloc_coherent
Date: Wed, 6 Dec 2023 16:37:51 +0800
Message-ID: <20231206083753.18186-1-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.153600-8.000000
X-TMASE-MatchedRID: KeLGzKm/w9IZ9FA+BlOSKko8jH4wkX2jmyiLZetSf8nyb6HMFK1qe8Is
	1+7Tk9qQC24oEZ6SpSmb4wHqRpnaDhbg7mB9W0YxUtkz1RZEmFObGvZ1q7nSjoYFec5vZXDlsvg
	Mup5zcDgOSlgQWWtzSEErIJrd/3YkTNjBF1ofWtl2Rmg6QP0HuPI2nuDg9d7QFezHPq6MHFSrV/
	xdKQcFSY0leYQxW8u2ZyMWcibO/JI=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.153600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 0F913E4C0655B20E59F40CE50463C250EC4BF0EB88C6DB39F99715DF054DCCC62000:8
X-MTK: N

These series of patches change the allocation of MSI address on MediaTek
platform, which uses 'dmam_alloc_coherent' to allocate the MSI address.

Jianjun Wang (2):
  PCI: mediatek: Allocate MSI address with dmam_alloc_coherent
  PCI: mediatek-gen3: Allocate MSI address with dmam_alloc_coherent

 drivers/pci/controller/pcie-mediatek-gen3.c | 30 +++++++++++----------
 drivers/pci/controller/pcie-mediatek.c      | 29 +++++++++++++-------
 2 files changed, 36 insertions(+), 23 deletions(-)

-- 
2.18.0


