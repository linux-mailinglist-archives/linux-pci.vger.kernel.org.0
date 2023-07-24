Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B314275E78F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 03:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjGXB2w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 21:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGXB2S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 21:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95181171E;
        Sun, 23 Jul 2023 18:25:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E26B60F1B;
        Mon, 24 Jul 2023 01:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17788C433C8;
        Mon, 24 Jul 2023 01:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161877;
        bh=sBhbt8uzCKA9A2iTjhFHhhqHH3IHMBsBCpiHJkgpwXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVVWoUt5TlchygaX136TCg1lOcFet/ZuFPyqTdx/tRCBNiSlbcvpQNsz1DR45lvvr
         X+tGS/YrKLmSuxzqIh8rO+rFMw/vhLS7GMjsuXs02u4X85mbx5F4OMRLIOZXcZ4GQD
         FZ02DoxwJozFUwSQnHrnqEOGXBYoWMuxmVMxaIXQ8FM576R9VvDsgLoBzeePPYS5go
         nwcVfBMJ17zYKg4CE/nS3FgMJtz3KVVPIPFQ+H7eCYuhuwN0eXWmAVEubCKa7T7XpS
         XLhLheK8twDhw1udSBJzZVtkkERpojCoqm6WQW7ICncNxLPSjJufZYhxpBrLYzKt6I
         J4ApAsH7Myo/Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        bhelgaas@google.com, perex@perex.cz, tiwai@suse.com,
        gregkh@linuxfoundation.org, kai.vehmanen@linux.intel.com,
        mkumard@nvidia.com, nmahale@nvidia.com, linux-pci@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 11/22] ALSA: hda: Add Loongson LS7A HD-Audio support
Date:   Sun, 23 Jul 2023 21:24:08 -0400
Message-Id: <20230724012419.2317649-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012419.2317649-1-sashal@kernel.org>
References: <20230724012419.2317649-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.186
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yanteng Si <siyanteng@loongson.cn>

[ Upstream commit 28bd137a3c8e105587ba8c55b68ef43b519b270f ]

Add the new PCI ID 0x0014 0x7a07 and the new PCI ID 0x0014 0x7a37
Loongson HDA controller.

Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Link: https://lore.kernel.org/r/993587483b9509796b29a416f257fcfb4b15c6ea.1686128807.git.siyanteng@loongson.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h    | 3 +++
 sound/hda/hdac_device.c    | 1 +
 sound/pci/hda/hda_intel.c  | 7 +++++++
 sound/pci/hda/patch_hdmi.c | 1 +
 4 files changed, 12 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4b34a5c125999..84cb7b32aa26f 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -153,6 +153,9 @@
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
+#define PCI_DEVICE_ID_LOONGSON_HDA      0x7a07
+#define PCI_DEVICE_ID_LOONGSON_HDMI     0x7a37
+
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index bfd8585776767..5315a3eb114ee 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -645,6 +645,7 @@ struct hda_vendor_id {
 };
 
 static const struct hda_vendor_id hda_vendor_ids[] = {
+	{ 0x0014, "Loongson" },
 	{ 0x1002, "ATI" },
 	{ 0x1013, "Cirrus Logic" },
 	{ 0x1057, "Motorola" },
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1f641712233ef..13226f4f2d119 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -274,6 +274,7 @@ enum {
 	AZX_DRIVER_CTHDA,
 	AZX_DRIVER_CMEDIA,
 	AZX_DRIVER_ZHAOXIN,
+	AZX_DRIVER_LOONGSON,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -397,6 +398,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
 	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
+	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -2838,6 +2840,11 @@ static const struct pci_device_id azx_ids[] = {
 	  .driver_data = AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_HDMI },
 	/* Zhaoxin */
 	{ PCI_DEVICE(0x1d17, 0x3288), .driver_data = AZX_DRIVER_ZHAOXIN },
+	/* Loongson HDAudio*/
+	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDA),
+	  .driver_data = AZX_DRIVER_LOONGSON },
+	{PCI_DEVICE(PCI_VENDOR_ID_LOONGSON, PCI_DEVICE_ID_LOONGSON_HDMI),
+	  .driver_data = AZX_DRIVER_LOONGSON },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, azx_ids);
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index c19afe4861949..5ff7e93024154 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4307,6 +4307,7 @@ static int patch_gf_hdmi(struct hda_codec *codec)
  * patch entries
  */
 static const struct hda_device_id snd_hda_id_hdmi[] = {
+HDA_CODEC_ENTRY(0x00147a47, "Loongson HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x1002793c, "RS600 HDMI",	patch_atihdmi),
 HDA_CODEC_ENTRY(0x10027919, "RS600 HDMI",	patch_atihdmi),
 HDA_CODEC_ENTRY(0x1002791a, "RS690/780 HDMI",	patch_atihdmi),
-- 
2.39.2

