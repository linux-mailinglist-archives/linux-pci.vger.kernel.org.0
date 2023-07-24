Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E94375E701
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 03:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjGXBYX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 21:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGXBXR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 21:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A499199C;
        Sun, 23 Jul 2023 18:22:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7A460EFE;
        Mon, 24 Jul 2023 01:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30655C433C7;
        Mon, 24 Jul 2023 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161749;
        bh=pKbT0YJEeagCXhI1F2Iwc6xJrSko5tOfjYeUhgCEFnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fsRl3jhTyl6z8SCHTocs6hCmguUArNF/LVYNpPTnGf1VHm9BqKz+tQSTzozQXS5GC
         rr+UvsExetjv22qMhcEgkZSK6FrM4Noj9JvRn3swIuv6TJ5Buvj2wFvYISnBLEvml3
         szRndi4gu9dikzPV8vYCVO91ErsZgLWw2GcgkIPfWEC2yE6LmtI3uQ7J+xpsA38+oo
         1zaLcIEjcztZupoTt31SzMT1T/9gICF4rJ8B9rkYsMsRAU/o5K9qbgNb58FdhE0b8i
         WefxYRcNZ+7MZl2Y09xZC9CrCBLvHHtQLGQbkHUunhXW0A+eBG25QdBE9IVEDut65J
         bI7lj9B+s1lfA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        bhelgaas@google.com, perex@perex.cz, tiwai@suse.com,
        gregkh@linuxfoundation.org, pierre-louis.bossart@linux.intel.com,
        rander.wang@intel.com, yung-chuan.liao@linux.intel.com,
        kai.vehmanen@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
        jasontao@glenfly.com, evan.quan@amd.com, mkumard@nvidia.com,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 20/41] ALSA: hda: Add Loongson LS7A HD-Audio support
Date:   Sun, 23 Jul 2023 21:20:53 -0400
Message-Id: <20230724012118.2316073-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index 95f33dadb2be2..c0c4ca8e28510 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -158,6 +158,9 @@
 
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
index 3226691ac923c..9c353dc7740c4 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -237,6 +237,7 @@ enum {
 	AZX_DRIVER_CTHDA,
 	AZX_DRIVER_CMEDIA,
 	AZX_DRIVER_ZHAOXIN,
+	AZX_DRIVER_LOONGSON,
 	AZX_DRIVER_GENERIC,
 	AZX_NUM_DRIVERS, /* keep this as last entry */
 };
@@ -360,6 +361,7 @@ static const char * const driver_short_names[] = {
 	[AZX_DRIVER_CTHDA] = "HDA Creative",
 	[AZX_DRIVER_CMEDIA] = "HDA C-Media",
 	[AZX_DRIVER_ZHAOXIN] = "HDA Zhaoxin",
+	[AZX_DRIVER_LOONGSON] = "HDA Loongson",
 	[AZX_DRIVER_GENERIC] = "HD-Audio Generic",
 };
 
@@ -2809,6 +2811,11 @@ static const struct pci_device_id azx_ids[] = {
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
index 7b5e09070ab9b..b9b138de57951 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4509,6 +4509,7 @@ static int patch_gf_hdmi(struct hda_codec *codec)
  * patch entries
  */
 static const struct hda_device_id snd_hda_id_hdmi[] = {
+HDA_CODEC_ENTRY(0x00147a47, "Loongson HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x1002793c, "RS600 HDMI",	patch_atihdmi),
 HDA_CODEC_ENTRY(0x10027919, "RS600 HDMI",	patch_atihdmi),
 HDA_CODEC_ENTRY(0x1002791a, "RS690/780 HDMI",	patch_atihdmi),
-- 
2.39.2

