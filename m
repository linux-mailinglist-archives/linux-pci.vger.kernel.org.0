Return-Path: <linux-pci+bounces-19198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF48A003E5
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 07:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48163A3A77
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 06:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10D016132F;
	Fri,  3 Jan 2025 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D15wWqdA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082D81B6D1B;
	Fri,  3 Jan 2025 06:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735884058; cv=none; b=JaGGexxrQ9wS2CdDKG/bafN9Dwvs5AkOStfLSx6r7OIZk6lY4peksH3uGGoHlJRo7CErKkPqFZtZiOUsyLicXaRA/6XxF7pRLer1BhuxTzY9OQBrZ8br/JGtq/HgbbiLwRr2iDQ2JkMo42/oImFqRoDXwgR11FH4TU3xiFN8+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735884058; c=relaxed/simple;
	bh=KnjqqoQAVzplqGWr5OHcO4IxvC/XZzuQ3aep5DCnKs0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L1Er/0KvjZ88+r+7iBrVFAYMA5pf7ngM/OO6k167124I6wJOfbrnmhOyYua1tUYYdo8O7kNUtXOfFGs4mcgNKbfNd8Oj+lMYJq/kkeNtEY7b/283rXWJVVbbOZXRUPAoX6B6xLxQIlDIkkyi+sdCpMcAGZnnMG9IFVLHsPDWETo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D15wWqdA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 12a1dd84c99811efbd192953cf12861f-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IRJmo01lCGWBN4vk/8ge3MPSFtd3Uvt3DpqX+KRB26Q=;
	b=D15wWqdAml3+TjDJ4wGFKQqnOnV2dii5mL321+wo5nZn+WRbmkeAo9bWWfe3xtNwpD892NQp/blcXmdPEUSSbQLAQjpPIDyhHOVEfiZ5rcOloEuNOqdf7hpWrpSIBADjNjHcAJni0jzop57PBCHJK1du6sCgOHujJh20PpBlwrs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:e4269394-4892-4c23-87de-c358be4ed0ef,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:f6da4b37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 12a1dd84c99811efbd192953cf12861f-20250103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 797789480; Fri, 03 Jan 2025 14:00:45 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 14:00:44 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 14:00:43 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"Rob Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"Conor Dooley" <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
	<jianjun.wang@mediatek.com>, <linux-pci@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: [PATCH 0/5] PCI: mediatek-gen3: Add MT8196 support
Date: Fri, 3 Jan 2025 14:00:10 +0800
Message-ID: <20250103060035.30688-1-jianjun.wang@mediatek.com>
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

The MT8196 is an ARM platform SoC that has the same PCIe IP as the MT8195.
It has 6 clocks like MT8195, but 2 of them are different, also it requires
additional settings in the pextpcfg registers, hence that introduce
pextpcfg in PCIe driver for these settings.

Jianjun Wang (5):
  dt-bindings: PCI: mediatek-gen3: Add MT8196 support
  PCI: mediatek-gen3: Add MT8196 support
  PCI: mediatek-gen3: Disable ASPM L0s
  PCI: mediatek-gen3: Don't reply AXI slave error
  PCI: mediatek-gen3: Keep PCIe power and clocks if suspend-to-idle

 .../bindings/pci/mediatek-pcie-gen3.yaml      |  29 ++++
 drivers/pci/controller/pcie-mediatek-gen3.c   | 129 ++++++++++++++++++
 2 files changed, 158 insertions(+)

-- 
2.46.0


