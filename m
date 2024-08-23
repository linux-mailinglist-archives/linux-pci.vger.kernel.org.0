Return-Path: <linux-pci+bounces-12083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD1F95C9D3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C8A1F236A6
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 10:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574DF146A8A;
	Fri, 23 Aug 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="e3oL+Vyz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FA8165EFC;
	Fri, 23 Aug 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724407208; cv=none; b=qT5ULJG4MKohUIXWXt6qZQb/jMf7iqt3W5s8mniylTQrGBREu2RVQV4gOhxKiVTAKRB+VlTr9DMji2GUAQ1+r/cOybPsWxemg+04opm8gudu0wnjZJzE/Wozkt7Yn/E55dWfnY3hRwj7bi928wTF7C+IUg9fOXxWIE3xGyAMJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724407208; c=relaxed/simple;
	bh=wbYaNhiIBZjc4aKCMq6CVTE+GcgRoD5emtq3OxLCmAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xe5Iu7F2Q1UT7xFcSpINDqEQZjuI8kHU+tl4mlT9mgd7YZgdxUMvDpNG/7d9xolkCgfYODgmCZFB+SOUjq75mqbBcmO1/AcA6skrJjor3Erwm3UtuFoKyFz8FI6k7pFdpR1sn9Qu/MnGTsGla/zjr85P+/VG7koEhhEWjiF0ELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=e3oL+Vyz; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1724407071;
	bh=AL6MK78b657H9ekXMzTRXcs6I3vkkW+q1pws227ee18=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=e3oL+Vyz6I8dsZh9MA/N4khjFyAK8UN7dr4US+Xws7XcFaRGI+Hyu0q8BGzAa4GN6
	 WEfJjkWfxmyts9SpyroMvCJSEwiokareCEqGlcod9TAgHXnfltA+3B8/q40KSR+HEr
	 QTeRhdO8ndjTgyoS7PygctWjF0BJG5HHxqYahstg=
X-QQ-mid: bizesmtp78t1724407041trx4aw1b
X-QQ-Originating-IP: UR+HlJ5nXpwlwBldt1AXekq/SxhUNl+Yp7KGARLTxos=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 23 Aug 2024 17:57:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 7456191992919341797
From: WangYuli <wangyuli@uniontech.com>
To: bhelgaas@google.com,
	siyuli@glenfly.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rsalvaterra@gmail.com,
	suijingfeng@loongson.cn
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	jasontao@glenfly.com,
	reaperlioc@glenfly.com,
	guanwentao@uniontech.com,
	linux@horizon.com,
	pat-lkml@erley.org,
	alex.williamson@redhat.com,
	WangYuli <wangyuli@uniontech.com>
Subject: [PATCH v2] PCI: Add function 0 DMA alias quirk for Glenfly arise chip
Date: Fri, 23 Aug 2024 17:57:08 +0800
Message-ID: <CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Add DMA support for audio function of Glenfly arise chip,
which uses request id of function 0.

Link: https://lore.kernel.org/all/20240822185617.GA344785@bhelgaas/
Signed-off-by: SiyuLi <siyuli@glenfly.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 drivers/pci/quirks.c      | 6 ++++++
 include/linux/pci_ids.h   | 4 ++++
 sound/pci/hda/hda_intel.c | 2 +-
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dd75c7646bb7..7aad5311326d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4259,6 +4259,12 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
+/*
+ * Some Glenfly chips use function 0 as the PCIe requester ID for DMA too.
+ */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D40, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3D41, quirk_dma_func0_alias);
+
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index e388c8b1cbc2..536465196d09 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2661,6 +2661,10 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY	    0x6766
+#define PCI_DEVICE_ID_GLENFLY_ARISE10C0_AUDIO	 0x3D40
+#define PCI_DEVICE_ID_GLENFLY_ARISE1020_AUDIO	 0x3D41
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b33602e64d17..e8958a464647 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2671,7 +2671,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
 	/* GLENFLY */
-	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
+	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
-- 
2.43.4


