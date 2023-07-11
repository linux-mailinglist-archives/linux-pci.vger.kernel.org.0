Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6674EF9B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 14:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGKM6w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 08:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGKM6t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:58:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98701E6C;
        Tue, 11 Jul 2023 05:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080303; x=1720616303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zk2sNO05UAbs2nuTw7unuMIHhKz7EsY9TKiKaOgRRPU=;
  b=WLFhVL98iVycMmc8vTrz98MEz2d184rGUpccF+8Z1nbTGC3P/IYgniDX
   Qduw5PtX/ZTqIlPdQw9T1MN7xXDdHumdjsaACULPMhL59m05EVq6hmZ03
   T9D5zRl6i3uM/+dywuxlL83gmY4KrRZpHcyNBW1h50BTBYBIXmG5m3fba
   ghRmyt2khPn0phZv/+vDU+g7TccSBGDMrjklBzpmmkv5G4J00V2QAXqmz
   +e2tEOlIUU8NcOc6nELAOtfYP2IF1XEJS6eRhMXhE2BuGk3En1iJMmflW
   z7j5AXs5EgCN1WyrhJ6mE8pai0b+eGxYkSzJtcO8tS6F8u/3HT+pd+9M5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187444"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367187444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:57:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666632"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834666632"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:21 -0700
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
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 06/13] ASoC: Intel: Skylake: Use global PCI match macro
Date:   Tue, 11 Jul 2023 14:57:19 +0200
Message-Id: <20230711125726.3509391-7-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using local macro to match PCI device, use global one.

Acked-by: Mark Brown <broonie@kernel.org>
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

