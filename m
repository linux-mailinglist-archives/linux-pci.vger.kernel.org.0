Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77A57538EA
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbjGNKzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjGNKzQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:55:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83B030FB;
        Fri, 14 Jul 2023 03:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332114; x=1720868114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hci/Mtl3zpiY8Fuw4D9HO/gNNPRVeyw31CVrcYUbSrY=;
  b=B8NNBYJEk8Tf838d389DP15agAuHI43+TF0XYpoXENXMPLcB/lQJMgBT
   xexVnenAjBhMtMAIA3Ne/8DzxnzJfndOZWPPdJDu6b/Bn3PBUMPD+vbMe
   QkWtKIRFvhTSC2hNWTyQcFPikQIPpNs0CiJUDwusgxYhIIaq70gGN7TBV
   DgQaz8EGKn1jutwG1GN2mBVnI5v4ubqASfoqiFVFsq3fDgKbYAwdtEhiF
   FbF9p7+lNlt5ru6kmpcKd6//6F2fFEvaBOQU308hqzZqRoLoJOJbJgRSl
   0AiquHspOWILOm/DK+DLSNQ3MD0PiMHa07ms/3n/idyO/bIWDgb7p/m2F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321152"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365459"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365459"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:55:11 -0700
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
Subject: [PATCH v2 04/15] ALSA: Remove unused Broxton PCI ID
Date:   Fri, 14 Jul 2023 20:56:04 +0200
Message-Id: <20230714185615.370597-5-amadeuszx.slawinski@linux.intel.com>
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

Current code references 0x1a98 which is BXT-M (not -T as it is
commented) and it's an RVP, BXT-M B0 to be specific. From what we know
no BXT is available on market.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index ef831770ca7d..8f0cebb83302 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2564,9 +2564,6 @@ static const struct pci_device_id azx_ids[] = {
 	/* Broxton-P(Apollolake) */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-	/* Broxton-T */
-	{ PCI_DEVICE(0x8086, 0x1a98),
-	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
 	/* Gemini-Lake */
 	{ PCI_DEVICE(0x8086, 0x3198),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON },
-- 
2.34.1

