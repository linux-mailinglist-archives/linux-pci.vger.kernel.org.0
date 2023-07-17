Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4277561DB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 13:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGQLqH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjGQLqD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 07:46:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1795C1732;
        Mon, 17 Jul 2023 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689594349; x=1721130349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xDZvjDAnmyr9idM4V2jRguD7382ptl0JEWF/BZWKdgo=;
  b=hK/VTVoE0ptLKkLuuDwCaSoIaRVckFEZwMcI+2Z/Rc2XzbjG9Yh7qKMc
   AhQPPTh//5/fD3kT7oXiPkmt1IrGY2z41uuPyMLCqRFsYBAqCU29IKS+y
   B9CwaaZXsMA4A9MNBU+8vOytfefste2/Pz5ptBWVxxl1d4j4lFUYvWEZD
   aj5BCRsszPWe6El30gMfnk+sQxROqJAB/9RzYVuN8Du1A8ryM715WZXhV
   83KSp6En4OvQoyJhwTRwWJGwMOsMJgcmGj1be1iWGsapz24/q4ToXR2qA
   vgaGpv/1XeV3mLqEo7xCLn+1GjoHNhgw9bRRG75VHeKjYXXZBhq1mmJ9/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363372838"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363372838"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969856511"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969856511"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:45:37 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 06/15] ALSA: hda: Use global PCI match macro
Date:   Mon, 17 Jul 2023 13:45:02 +0200
Message-Id: <20230717114511.484999-7-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
References: <20230717114511.484999-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using local macro to match PCI device, use global one. As
Apollolake is Broxton-P successor that made it to the market, be precise
and use APL shortcut.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 8f0cebb83302..5e59dcc35665 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -330,18 +330,6 @@ enum {
 #define needs_eld_notify_link(chip)	false
 #endif
 
-#define CONTROLLER_IN_GPU(pci) (((pci)->vendor == 0x8086) &&         \
-				       (((pci)->device == 0x0a0c) || \
-					((pci)->device == 0x0c0c) || \
-					((pci)->device == 0x0d0c) || \
-					((pci)->device == 0x160c) || \
-					((pci)->device == 0x490d) || \
-					((pci)->device == 0x4f90) || \
-					((pci)->device == 0x4f91) || \
-					((pci)->device == 0x4f92)))
-
-#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
-
 static const char * const driver_short_names[] = {
 	[AZX_DRIVER_ICH] = "HDA Intel",
 	[AZX_DRIVER_PCH] = "HDA Intel PCH",
@@ -573,7 +561,7 @@ static void hda_intel_init_chip(struct azx *chip, bool full_reset)
 	snd_hdac_set_codec_wakeup(bus, false);
 
 	/* reduce dma latency to avoid noise */
-	if (IS_BXT(pci))
+	if (HDA_CONTROLLER_IS_APL(pci))
 		bxt_reduce_dma_latency(chip);
 
 	if (bus->mlcap != NULL)
@@ -2175,7 +2163,7 @@ static int azx_probe(struct pci_dev *pci,
 #endif /* CONFIG_SND_HDA_PATCH_LOADER */
 
 #ifndef CONFIG_SND_HDA_I915
-	if (CONTROLLER_IN_GPU(pci))
+	if (HDA_CONTROLLER_IN_GPU(pci))
 		dev_err(card->dev, "Haswell/Broadwell HDMI/DP must build in CONFIG_SND_HDA_I915\n");
 #endif
 
@@ -2283,7 +2271,7 @@ static int azx_probe_continue(struct azx *chip)
 			 * for other chips, still continue probing as other
 			 * codecs can be on the same link.
 			 */
-			if (CONTROLLER_IN_GPU(pci)) {
+			if (HDA_CONTROLLER_IN_GPU(pci)) {
 				dev_err(chip->card->dev,
 					"HSW/BDW HD-audio HDMI/DP requires binding with gfx driver\n");
 				goto out_free;
@@ -2294,7 +2282,7 @@ static int azx_probe_continue(struct azx *chip)
 		}
 
 		/* HSW/BDW controllers need this power */
-		if (CONTROLLER_IN_GPU(pci))
+		if (HDA_CONTROLLER_IN_GPU(pci))
 			hda->need_i915_power = true;
 	}
 
-- 
2.34.1

