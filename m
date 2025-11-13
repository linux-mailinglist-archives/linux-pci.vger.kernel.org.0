Return-Path: <linux-pci+bounces-41071-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AB9C56575
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 09:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C3703B509F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 08:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D512DC352;
	Thu, 13 Nov 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="no1+SRZj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C022C21EC;
	Thu, 13 Nov 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023535; cv=none; b=Ro6ZifmTCJJCp4JQQ8QFlUGCLdx+Km0BztERYAxNL/+o8Syuu66QsoTkjNm0/3MmXTjJsMeP7VWidgNNM+vEWMKmHV0kAR2xPjeyKLfJXva9tlPXa8F5d4UhQ2Y5+H2+p2kTH5cd+JmuuBzrAP3x+GvHiFzSi0JzSkQkS6rXynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023535; c=relaxed/simple;
	bh=yZH1UkLt0oe2VEji1eEQrjQIwX753ewx3YaYtlAQDm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIUZYbWE5QL/xGYf8AsIni64LZ9HrK7Dn414WHPGUna2E/26VEwYRQjF0w8ruO3mX1193wVEommC6OmU5jKbPu1M1Hs4dCm3PcHclcp6v5CK68ukyzle+RaW3yFJ272egGOZ/lsoVLGMPrBg2gynJNs2oD1VH9nBZaMEfMHX9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=no1+SRZj; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 165206a8c06d11f0b33aeb1e7f16c2b6-20251113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hu479yPj8wbBYx+WzD14ywVL3ZHRcGR0GXGR0sSeAEc=;
	b=no1+SRZjdc/QUFWioe22TRkQGQhriQgNN9Jl5sYCj/hq5s4ssmuqhewIVi2UZPLTO5LNlZmgZgxupT6MfArZQDiZMOyylon755lX9/DwrcuePbOAlH7p5HyRDttdxVI7BlBajI5GAfjXlWIV+aLJ68PVDW5ap3U87mKcxoyVXZo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5d9dc6a4-b194-43e4-a3ff-a566a2fdc45f,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:983dda57-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836|888|898,TC:-5,Content:0|15|5
	0,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 165206a8c06d11f0b33aeb1e7f16c2b6-20251113
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <johnny-cc.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 548567511; Thu, 13 Nov 2025 16:45:20 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 13 Nov 2025 16:45:19 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Thu, 13 Nov 2025 16:45:19 +0800
From: Johnny Chang <Johnny-CC.Chang@mediatek.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Digits_Upstream_Group@mediatek.com>, Johnny-CC Chang
	<Johnny-CC.Chang@mediatek.com>
Subject: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Date: Thu, 13 Nov 2025 16:44:06 +0800
Message-ID: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>

Nvidia GB10 PCIe hosts will encounter problem occasionally
after SBR(secondary bus reset) is applied.
Enable NO_BUS_RESET quirk for Nvidia GB10 PCIe hosts.

Signed-off-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
---
 drivers/pci/quirks.c    | 11 +++++++++++
 include/linux/pci_ids.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index b94264cd3833..12a10fa84c8a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3746,6 +3746,17 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
 	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
 }
 
+/*
+ * Nvidia GB10 PCIe hosts will encounter problem occasionally
+ * after SBR (secondary bus reset) is applied.
+ * SBR needs to be prevented for these PCIe hosts.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GB10_GEN5_X4,
+			 quirk_no_bus_reset);
+
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GB10_GEN4_X1,
+			 quirk_no_bus_reset);
+
 /*
  * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
  * prevented for those affected devices.
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 92ffc4373f6d..661dc1594213 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1382,6 +1382,8 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
+#define PCI_DEVICE_ID_NVIDIA_GB10_GEN5_X4           0x22CE
+#define PCI_DEVICE_ID_NVIDIA_GB10_GEN4_X1           0x22D0
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_TT128		0x9128
-- 
2.45.2


