Return-Path: <linux-pci+bounces-13856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBFB990F6E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 21:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45493B2BAC5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2024 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D4221E95B;
	Fri,  4 Oct 2024 18:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfCu+dvF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D348B21E956;
	Fri,  4 Oct 2024 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066561; cv=none; b=i3JbIqDyjvxNa4LjhV5QsDnM3sV8gB5lEOGkTEr+zMCgNzCYrmsTcZxI6+250RWaW+QB5alf0Gi58/lsRAZML5lG8LDxlCk/eXt5uqIYYGI4L7gIRc+wrGjhZv3H91ZafMeJiTLKrCKEf61T8mnH2WV11yRjUbYQZqQiHCxZILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066561; c=relaxed/simple;
	bh=SPU3eq4TmVNQHC2R9k3ZwP+Wi2EFY+ehnuhy5z5Zzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZ1Dbmj9DOJYpjG7oybiDWK7eJU08xL2tgdFPRKkKczC60SWoIrg5kBZOVprm0OZCqGEPyYlLQbIBCIEy3Rm7INnUb20zHxCXpWxv62EQz3fuJwanuvtWlK9EK01fjXZnonZ6fhtwXSgkHY45D+RKzKuiX3AuM8cgfT1QGYh1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfCu+dvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F90C4CEC6;
	Fri,  4 Oct 2024 18:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066561;
	bh=SPU3eq4TmVNQHC2R9k3ZwP+Wi2EFY+ehnuhy5z5Zzrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfCu+dvFyo7hEflrX8eqPIlHAnLI2jTwuusBqzzll/kxSp+FJqZGfr/Txg9g1Ir4J
	 Nnyms6hwXXM75CnS3LYPNC+x5qHSgka43YmQJpu43u6gYCp9TYTTyW8KguzIAMMsmC
	 fp4aklL8NBi76uD0X6E9BgE+7MreZCgfhy/6vlM5RsVO8IuVFNyzeDlsWuX73yVJKg
	 c3qIZE44CmpmaxdWdCOUrPdUNPmvwvkOrqIbI1XadDrMYebvyWIVaQYldsxbBrrSl2
	 +QfZc2XeWp7p9QSav7BX8jJoYN8jUjuE4N2e3yfURyJJWPj+RS7cK1aoyWjZyPHF6T
	 S2FaPNL7k2+Cw==
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
	kai.vehmanen@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	rsalvaterra@gmail.com,
	chaitanya.kumar.borah@intel.com,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/31] PCI: Add function 0 DMA alias quirk for Glenfly Arise chip
Date: Fri,  4 Oct 2024 14:28:22 -0400
Message-ID: <20241004182854.3674661-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index 4d4267105cd2b..2d648967aa85f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4118,6 +4118,10 @@ static void quirk_dma_func0_alias(struct pci_dev *dev)
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
index 66e95df2e6867..d1997eda6b1ad 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2635,6 +2635,8 @@
 #define PCI_DEVICE_ID_DCI_PCCOM8	0x0002
 #define PCI_DEVICE_ID_DCI_PCCOM2	0x0004
 
+#define PCI_VENDOR_ID_GLENFLY		0x6766
+
 #define PCI_VENDOR_ID_INTEL		0x8086
 #define PCI_DEVICE_ID_INTEL_EESSC	0x0008
 #define PCI_DEVICE_ID_INTEL_PXHD_0	0x0320
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index dd4d802c9e71c..6913d113bb4ea 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2715,7 +2715,7 @@ static const struct pci_device_id azx_ids[] = {
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


