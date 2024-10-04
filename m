Return-Path: <linux-pci+bounces-13852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B6F990DAF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066BF1C219D1
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D2E1D8A09;
	Fri,  4 Oct 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPqR21Qx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFF210C3E;
	Fri,  4 Oct 2024 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066467; cv=none; b=iW949F8zTJBeQ1Hw5FcibjWj3zDLsfc6mDMUBr2NhcFbLRAPPc22qmfHp+2wWnndJB8MiAi7nDYWnzPktLqST27VjHYbOJY4GZ/Hc2K0GQrrEYwp1rHr/pCRCR/BnrV3rAHslq+lMX6EfTuUixWtirp8ZFlIxRF9nFl4a9mURc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066467; c=relaxed/simple;
	bh=4k1pkrZBSnGHWphe0BlwP04nF88bIx0iNz/Aesxi6cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjExWv1Ux9t7cZall/gAULpz4JL4tjKvSBkkEo3+SJfa7cRVkELB7R+tzRGBSHyNNhRd7U/9+zTZ2cCS6gz1bxYWk9cJR3OnH20peAqLNv2EZz+m2pePngkxgX39+DbBXVoysIt/Pb/24/I5sGRyh/zctHl1tmaWL9DRlfCfJRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPqR21Qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2DBC4CECC;
	Fri,  4 Oct 2024 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066467;
	bh=4k1pkrZBSnGHWphe0BlwP04nF88bIx0iNz/Aesxi6cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GPqR21Qx51Dp02u7eRWA/dvCmDzGkaXElhUJvXUjoWmnwC+AKpkZ6aHCyckiJIUxy
	 t2Ty0or2G/5Uxyo92M90bLHjE8B14ghvLvujXju9wLZYvcMn8WYzGBlevidlqC64ln
	 KiFype4kqkgPxwt0kO+reM11rVSRFqfxlFjafaDsAflR5XHua1gAgyFT8CblifWkrK
	 NNBOLeDhrvO0iW6zj/91oTac+1MfysfOlx1KP/U5b05WmAkr+62tkRaqsWUyxVYz/7
	 P20TGDLhGA9FNhJW3gGiyzgNyj80S/JD2s7Ie8ZnxMJitUdjzO7RSuu1FXsDhF1zrP
	 9kCDOf0bOvc1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: WangYuli <wangyuli@uniontech.com>,
	SiyuLi <siyuli@glenfly.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	peter.ujfalusi@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rsalvaterra@gmail.com,
	chaitanya.kumar.borah@intel.com,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/42] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri,  4 Oct 2024 14:26:26 -0400
Message-ID: <20241004182718.3673735-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: WangYuli <wangyuli@uniontech.com>

[ Upstream commit 9246b487ab3c3b5993aae7552b7a4c541cc14a49 ]

Add DMA support for audio function of Glenfly Arise chip, which uses
Requester ID of function 0.

Link: https://lore.kernel.org/r/CA2BBD087345B6D1+20240823095708.3237375-1-wangyuli@uniontech.com
Signed-off-by: SiyuLi <siyuli@glenfly.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
[bhelgaas: lower-case hex to match local code, drop unused Device IDs]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c      | 4 ++++
 include/linux/pci_ids.h   | 2 ++
 sound/pci/hda/hda_intel.c | 2 +-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 56dce858a6934..7ebce76778f71 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4144,6 +4144,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe832, quirk_dma_func0_alias);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
 
+/* Some Glenfly chips use function 0 as the PCIe Requester ID for DMA */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d40, quirk_dma_func0_alias);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_GLENFLY, 0x3d41, quirk_dma_func0_alias);
+
 static void quirk_dma_func1_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 1)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f680897794fa2..69b8c46a42ea7 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2638,6 +2638,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 695026c647e1e..a25e90a9be693 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2756,7 +2756,7 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
 	/* GLENFLY */
-	{ PCI_DEVICE(0x6766, PCI_ANY_ID),
+	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
 	  .class_mask = 0xffffff,
 	  .driver_data = AZX_DRIVER_GFHDMI | AZX_DCAPS_POSFIX_LPIB |
-- 
2.43.0


