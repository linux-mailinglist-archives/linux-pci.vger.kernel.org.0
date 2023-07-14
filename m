Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A307538F1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjGNKzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbjGNKza (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:55:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0852E30FD;
        Fri, 14 Jul 2023 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332124; x=1720868124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s7A7UshZnQEGaR97JLBqMpbiEE9phIPybyuk0Y8+oQg=;
  b=SSD4+lJjJpEDe/NG7BNhqSZuxa1tDPRlmzkkRz1fdje4kKYF6iktEbNP
   Z8ySpY/s5C6sk5V11TB2GAJIUXw+lXuRazV7WcKBI0IHLGIE+NK0c/bnz
   XlaGYOmEivuFiDip/uJyn8V3s1TES6CK5XkHJhb2IZKRWLM7ZA6B4D2p6
   C0Nyb9MnLtTpoArasjn8pvKG7Ui3ihsTq1/0CPlsFsk4ERDVRRL8SSVWf
   Bv2iBbuuRxmB+40Zlls2QtlsPIHzm5paAbiaaUi7ZkZ/0WgQoUH+Ij2HA
   15ikItqJe55d3QRLYii9IFm5Mi0+VpTrh3kaPSda8xZmOHvr4bBvIJ22c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321180"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365495"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365495"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:55:20 -0700
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
Subject: [PATCH v2 07/15] ALSA: hda/i915:  Use global PCI match macro
Date:   Fri, 14 Jul 2023 20:56:07 +0200
Message-Id: <20230714185615.370597-8-amadeuszx.slawinski@linux.intel.com>
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

Instead of using local macro to match PCI device, use global one.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/linux/pci_ids.h | 1 -
 sound/hda/hdac_i915.c   | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index eb0b3ad64246..d4392f7c51a1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2718,7 +2718,6 @@
 #define PCI_DEVICE_ID_INTEL_82840_HB	0x1a21
 #define PCI_DEVICE_ID_INTEL_82845_HB	0x1a30
 #define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
-#define PCI_DEVICE_ID_INTEL_HDA_APL_T	0x1a98
 #define PCI_DEVICE_ID_INTEL_HDA_CPT	0x1c20
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MIN	0x1c41
 #define PCI_DEVICE_ID_INTEL_COUGARPOINT_LPC_MAX	0x1c5f
diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 161a9711cd63..2a451ff4fe6a 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -11,11 +11,6 @@
 #include <sound/hda_i915.h>
 #include <sound/hda_register.h>
 
-#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
-				((pci)->device == 0x0c0c) || \
-				((pci)->device == 0x0d0c) || \
-				((pci)->device == 0x160c))
-
 /**
  * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
  * @bus: HDA core bus
@@ -39,7 +34,7 @@ void snd_hdac_i915_set_bclk(struct hdac_bus *bus)
 
 	if (!acomp || !acomp->ops || !acomp->ops->get_cdclk_freq)
 		return; /* only for i915 binding */
-	if (!IS_HSW_CONTROLLER(pci))
+	if (!HDA_CONTROLLER_IS_HSW(pci))
 		return; /* only HSW/BDW */
 
 	cdclk_freq = acomp->ops->get_cdclk_freq(acomp->dev);
-- 
2.34.1

