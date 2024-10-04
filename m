Return-Path: <linux-pci+bounces-13860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAA990E89
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C9C1F21ECA
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D737B227B89;
	Fri,  4 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRNZCgXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE98227B83;
	Fri,  4 Oct 2024 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066629; cv=none; b=g7NDA33xqRSfFL0caKFmpTZgw4I7lJ3H5NU6b5R0BM7ec7+QB6cc5892hyKCnpqKkSClSdQgbwO1mf8SbcCWQOaZQGAXiqhmkk40eHsXgEbDD9KPfl2sTg3cVadTMj1WVsJKb02yeibCTlGlsfArSckmhXETWfQckF7I6RTRLNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066629; c=relaxed/simple;
	bh=mixcR5FGrrytqyCzdBNkxVc8SgptWgPg5PifIn4k5ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZU5umCYOMb67b/UWDEyRJyLVvFJTygYgX8mx/KbihSRi8SU6vvYl0RTQTen6QCTjsHikXwT+oj2sAW9gtEbvIG2QRnukldxD4DyQk+3ABpsJm+DGpzP9BQuGsmjrZQGeJVh5XOMzmQUjNaasWIgrVpyx7MywNmAtD+2q55NgOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRNZCgXG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84905C4CECC;
	Fri,  4 Oct 2024 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066629;
	bh=mixcR5FGrrytqyCzdBNkxVc8SgptWgPg5PifIn4k5ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRNZCgXGQgSeLxK3pfPzSifAyGyYcOh7dH8hKkJQfHqp0YNdAOfNVmcN+rxmO5yQS
	 zHsLVDhK/l6SFF+2hIESNj+GkEPI+ZDOTRBcSIgd/OsHQlJDjHyOE4Warz7i2hr/pi
	 U8rn32u5C4xTmxfz59hy0yvXWoJ4fEPiaFonUitgyYSs4EUS6fRaRFVMAEJxyzNGpf
	 r2NBq7Ji9Fs4V/tBZ3aA5t0/7NxlFgnAVM72A0TN00vrt4Tv0aoaxcL96mFLXdTh0i
	 Yp2eSYu0wBCF2JZ6gVGfsPcF4JvJ0/EDB3nGoQcxuDVKxi1u6PupLBalisRqXk0MpM
	 /wZsjsRpqmxjg==
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
	akoskovich@pm.me,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 12/26] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri,  4 Oct 2024 14:29:38 -0400
Message-ID: <20241004183005.3675332-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183005.3675332-1-sashal@kernel.org>
References: <20241004183005.3675332-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.226
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
index 60a469bdc7e3e..6f782734bb6e6 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4092,6 +4092,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
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
index b2418bfda4a98..c4ad85bf9897f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2657,6 +2657,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a3c6a5eeba3a4..b92095bb28c32 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2777,7 +2777,7 @@ static const struct pci_device_id azx_ids[] = {
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


