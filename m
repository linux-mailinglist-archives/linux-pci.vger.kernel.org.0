Return-Path: <linux-pci+bounces-13848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C64990D19
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4930B1C229AB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1798204939;
	Fri,  4 Oct 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF+MlNNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5117204937;
	Fri,  4 Oct 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066342; cv=none; b=evKuPK36pFk5VxyhCGwrkaP0+aW+W5udK3EhsXx4Ulbn5tO27zwdJxTYjmd7QfLQupKYQmVdjF9Z516viY+3/FnJGjxvcqls7G6JT66pswrj7NFUgul/+cC3H49XREvhTVWe26VXNJZ5hVSxd/PzDrfiqGt8izgjR3eYeBdpnDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066342; c=relaxed/simple;
	bh=KTr8g6F3xmAjDPlAHLp5RGD+Oi7UeQnxz6CI4SoYMaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEauIFhpDCJevfrrzmUESeF3/Nxo4cDCiUmeA+CeMUqBAerNbCmbiu0MBLCubAnZC0EEijQ6TLi08icii/N2zd1buW8V1B8ZqkmT1tKOD23E1oLG3DQyVthUy42FGenWIM0yVtAuEfrid/WFiX+v9oF8UopEa1/aWopPb+YcM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF+MlNNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C084BC4CECE;
	Fri,  4 Oct 2024 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066342;
	bh=KTr8g6F3xmAjDPlAHLp5RGD+Oi7UeQnxz6CI4SoYMaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MF+MlNNIJZU71m8PdsqK7QBxS/a5FtFdAliYUm3ZE2Lt/NJaVT3haKA+T3ob9T7PO
	 8nZWOirvK44vF1Iu4tycr8cb2KKwcyZZAuboUPXWAcqZsRhJ25MoZvEPXXnhS7jPv3
	 cb+XTUGup3a2G919BOo46cw4oa5CmLt0rkZvxtqRPIQwHgy+XgGkyxmL8bAIJl/Lbn
	 Cfgw8+omi5eOueQlPr7kAylaQdKiLRhgUuXha8hvwfo6rd13dvldc2LNlHcRFgaaZo
	 8M3AenEiftJn3mh+qjh7Tvn47j0HfsdsBDSOPKZcuyHAQVkH4pEC3SiJT2cz27/0Tb
	 gVIIDlYgufVGA==
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
	kai.vehmanen@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	rsalvaterra@gmail.com,
	akoskovich@pm.me,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 21/58] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri,  4 Oct 2024 14:23:54 -0400
Message-ID: <20241004182503.3672477-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index ec4277d7835b2..5af53d9cc8b38 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4239,6 +4239,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
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
index abff4e3b6a58b..cebfd1bb9dfa1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2653,6 +2653,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_HDA_CML_LP	0x02c8
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d5c9f113e477a..0c64f20664628 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2690,7 +2690,7 @@ static const struct pci_device_id azx_ids[] = {
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


