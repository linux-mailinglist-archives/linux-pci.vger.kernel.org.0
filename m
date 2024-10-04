Return-Path: <linux-pci+bounces-13835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDE990B3F
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 20:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86381C21A53
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 18:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3054622168B;
	Fri,  4 Oct 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8NPC3gr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E421F43D;
	Fri,  4 Oct 2024 18:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065953; cv=none; b=ckpAD6OWJjAA7yjC5h61ys5+dozVcLToQ8gX/WOr+iJmuoq5HoC6+BEBJcNS3Jz+yHkVG6kmVFK5mESIe+mEnJFrvewO4KyLcixQXmB6INQxrs+8Uo7HE6UkXjbHeQueBrvaU8WgvytN7aDf2qOmIzd2SupfgqU81qBMAx/S5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065953; c=relaxed/simple;
	bh=VExMiYD7TNrlptRw+fpX3Jnj1phEK2IPtfjJxvhOSVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks6/EtzfkbaEsU2GyF4/hD7qZbUCbb53lcuG7REHx3fyzLC7cdx3krwXrO8SQC7o3z9B6CCp0xPu7L+jcyDfRtZnXi6iUYGThvEuylrRQZgDXtJkJJjaGqJ731EK5K1MrliEXozP0fVn47F+C5Ap4V0CgivLdKOwNv61ABs5bHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8NPC3gr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E321FC4CEC6;
	Fri,  4 Oct 2024 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065952;
	bh=VExMiYD7TNrlptRw+fpX3Jnj1phEK2IPtfjJxvhOSVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r8NPC3gr304yDh4Nppc4xnZJ9miG/aoOqS4CnBxSnGJ4NDUj85Jb6K2boEfgbDiPw
	 FcfiV9/sR60aSYw96WQJJolbrgJAYnYJndMOvtwjNdS9ueausfW6xcub6mJfNqhPC3
	 grVqyn4hd6E6VLhsQ0O2PuEBf7+r676aiHhjWX6BJ6Bm7hxgpKeZMYWcAZXLJSAvnN
	 xnNo1CjZObVLeZbxr2FPA/X6mWkJ/JOO6Xp4Zb3Ee8+MezVqRt1IDD8sIx0Bko+3HR
	 qjJ2pVQsu/jcYd3hHzvVd71wfveoXnED3yoiFavBzVgScl/Fsj7ztNdcqiWCCuRo7N
	 YldMjtp5PzvYQ==
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
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 24/76] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri,  4 Oct 2024 14:16:41 -0400
Message-ID: <20241004181828.3669209-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
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
index a2ce4e08edf5a..cc6c82c3bd3d0 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4246,6 +4246,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
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
index e388c8b1cbc27..2c94d4004dd50 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2661,6 +2661,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 97d33a48ff17c..c98b1821b0620 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2679,7 +2679,7 @@ static const struct pci_device_id azx_ids[] = {
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


