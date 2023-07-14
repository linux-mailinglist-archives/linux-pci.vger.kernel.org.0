Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB117538F0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjGNKzf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjGNKza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:55:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928B35B1;
        Fri, 14 Jul 2023 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332126; x=1720868126;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PBebvDAwGl69rhzohAaS7jNgIdCEGCL7ad9NEzcoAGA=;
  b=MLl67x2/qF2X/Hj59SLZAD1EeYJSgQGbHeDirpwCUOKoD/5nsaTmIUwP
   ruSk2pQGD4gXTseLxB2IZnYGOwysqJcWmrZaS2zysm7phobfwLyrQmAwz
   V+Q6kFHEbIVfp2yPh4Wz/fElgkFI1jlYCug8YeB6VBP2seMbWWVxdT9Gy
   2MNGGSMk3qBUXXc83HHu3eiPdVXvB6f4Zvuiz0ftm2XMXBk7uDKr7S0Ux
   koaTkqkhLMrL+DPlEdAzLjlnghGp4UI0Kh+pLKvGhhzDHyrtwDLc9YvgX
   QScoHRFb93+9vRBThAf0+zW2/rj1NdVca1Rit+DrJoGQd7IGLBQtHGDUW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321188"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321188"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365503"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365503"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:55:23 -0700
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
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 08/15] ASoC: Intel: Skylake: Use global PCI match macro
Date:   Fri, 14 Jul 2023 20:56:08 +0200
Message-Id: <20230714185615.370597-9-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using local macro to match PCI device, use global one. As
Apollolake is Broxton-P successor that made it to the market, be precise
and use APL shortcut. IS_CFL() macro is dropped as it is unused.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hda_codec.h         | 3 ---
 sound/soc/intel/skylake/skl-pcm.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index bbb7805e85d8..5497dc9c396a 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -18,9 +18,6 @@
 #include <sound/hda_verbs.h>
 #include <sound/hda_regmap.h>
 
-#define IS_BXT(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0x5a98)
-#define IS_CFL(pci) ((pci)->vendor == 0x8086 && (pci)->device == 0xa348)
-
 /*
  * Structures
  */
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index a4209d88b0c6..ac3dc8c63c26 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -13,6 +13,7 @@
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/delay.h>
+#include <sound/hdaudio.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
 #include "skl.h"
@@ -152,7 +153,7 @@ int skl_pcm_host_dma_prepare(struct device *dev, struct skl_pipe_params *params)
 	 * The recommended SDxFMT programming sequence for BXT
 	 * platforms is to couple the stream before writing the format
 	 */
-	if (IS_BXT(skl->pci)) {
+	if (HDA_CONTROLLER_IS_APL(skl->pci)) {
 		snd_hdac_ext_stream_decouple(bus, stream, false);
 		err = snd_hdac_stream_setup(hdac_stream(stream));
 		snd_hdac_ext_stream_decouple(bus, stream, true);
-- 
2.34.1

