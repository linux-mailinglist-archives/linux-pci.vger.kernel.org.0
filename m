Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38D57411BE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjF1Mu5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:50:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:59116 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbjF1Mum (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956642; x=1719492642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qw8SQWQmPr/qqJ342TGeRW3bHoN4vBc/1sq6ZWaCaDQ=;
  b=awxw0KYCqUqc1KDqJJuNX+BqRcuqZU6tkRfWsADd6ieQKfURM0yhjIqF
   FzqlT848Slkmf66fLOw7Lf2nYsA5XuTHKWY1kAgkvY3MhKdujNX6ik+1R
   AZrpRtFKk8hMpctWEcwwzszE+AnTw/9DjHNw5etSjD2pjxhRnfiAXW9c/
   vR5n4raPTHo3Is++xdWIwAMvwBhiCDYeKpZDbuwXw7MsVzyrPzV3MMkDI
   haF8lSBwkBfuExbli5QPfA1zyt2WErdaYmcVeBIR7VPZ7udbMvs35R2jU
   b83y3VaFC0nJdRha/3Q+VstfwTyjlLV2hElf0ew0JJzlpdmfH9UD5D8B5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361875581"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361875581"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="891035097"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="891035097"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 05:50:28 -0700
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
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [RFC PATCH 4/8] ALSA: hda/i915: Update PCI IDs
Date:   Wed, 28 Jun 2023 22:51:31 +0200
Message-Id: <20230628205135.517241-5-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
References: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use PCI device IDs from pci_ids.h header

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/hdac_i915.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index 161a9711cd63..e9342e74b739 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -11,10 +11,10 @@
 #include <sound/hda_i915.h>
 #include <sound/hda_register.h>
 
-#define IS_HSW_CONTROLLER(pci) (((pci)->device == 0x0a0c) || \
-				((pci)->device == 0x0c0c) || \
-				((pci)->device == 0x0d0c) || \
-				((pci)->device == 0x160c))
+#define IS_HSW_CONTROLLER(pci) (((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_0) || \
+				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_2) || \
+				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_HSW_3) || \
+				((pci)->device == PCI_DEVICE_ID_INTEL_HDA_BDW))
 
 /**
  * snd_hdac_i915_set_bclk - Reprogram BCLK for HSW/BDW
-- 
2.34.1

