Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA92753AC4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjGNMYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbjGNMYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:24:15 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46CA3A8E;
        Fri, 14 Jul 2023 05:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337442; x=1720873442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O2F310bFUrrtqJHibkMdzi90JDrvWOt0X9HXx8O2FCY=;
  b=Kk6KomRZYKGX6B0Ud968jSeEaIF+xC6Lfzuw106K6Qk8XqhPrNkLWG6J
   +AmOI+8QGeLNRdXsHD4wrpF88wxlB/+20e4deyTM3Qsvt+AlIkYZKEqZh
   4ZtRbFtP4tSZjVY/TkQN2humuVeh6PwGl8EGaQHBgErUhfXn81ypoJ8hT
   LUZWCNgZeDaKdPcQYugR2XC6YRpkowqok/TcPkDY6d9XyXkGdCz40CsJJ
   VwfNXF0SFzle5QkIqSQMfTOGQEw0HPIi0HpwC/zuYSpvVKPXMKhFz4ZWD
   cvvmpvJz3Ljd97NiE3543zanT38+tLBPfBxmKNvYDMcaHwxCjYbNqSwg+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225842"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429225842"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053034912"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053034912"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:23:59 -0700
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
Subject: [PATCH v3 07/15] ALSA: hda/i915:  Use global PCI match macro
Date:   Fri, 14 Jul 2023 22:24:49 +0200
Message-Id: <20230714202457.423866-8-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
References: <20230714202457.423866-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Instead of using local macro to match PCI device, use global one.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/hdac_i915.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

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

