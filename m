Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05746753AD3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 14:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjGNMZY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 08:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjGNMY7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 08:24:59 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFFC359F;
        Fri, 14 Jul 2023 05:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689337468; x=1720873468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gt1bM8Q/FD2VIOVF2wWpS3Dslq5MDz04LTOzsoLpYFY=;
  b=azMC253ohZwuKkg8WIcpPXOVObZcLEraHpHantczpQA1C++KMhIpN+ib
   C8+4NDTPJF5A3TpcH8Xout6h8nWiuxM6xWeDfaLwCy3lzLy1nsDsHHa0T
   saRQuSGD2Tl0riRqM0Bb0Ib5dg9SevJNPWZ3REY6vjHX+cc/l+g8icghg
   wq8b6FbD5UhWxNDa9eyNzBcQoYV1IdybnM5fO9vz1mNdVp49XMWYNQ+HO
   518LJFpzNJInNnzGS4NDAcC4cr5qJlvKZWRNYmyeZ7X47enSnEInskmUf
   fbmGEPFxmRKdvsDHFmrHZnmczY2C01JuT4QZVvSbqQHKcuMbXdpz+oO+q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429225894"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429225894"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 05:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="1053034989"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="1053034989"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2023 05:24:14 -0700
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
Subject: [PATCH v3 12/15] ASoC: Intel: avs: Convert to PCI device IDs defines
Date:   Fri, 14 Jul 2023 22:24:54 +0200
Message-Id: <20230714202457.423866-13-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header. Adjust AVS_MACH_ENTRY() macro,
so device ID can be provided in short form.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/avs/board_selection.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 60f8fb0bff95..b32e02940e30 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -263,14 +263,14 @@ struct avs_acpi_boards {
 };
 
 #define AVS_MACH_ENTRY(_id, _mach) \
-	{ .id = (_id), .machs = (_mach), }
+	{ .id = PCI_DEVICE_ID_INTEL_##_id, .machs = (_mach), }
 
 /* supported I2S boards per platform */
 static const struct avs_acpi_boards i2s_boards[] = {
-	AVS_MACH_ENTRY(0x9d70, avs_skl_i2s_machines), /* SKL */
-	AVS_MACH_ENTRY(0x9d71, avs_kbl_i2s_machines), /* KBL */
-	AVS_MACH_ENTRY(0x5a98, avs_apl_i2s_machines), /* APL */
-	AVS_MACH_ENTRY(0x3198, avs_gml_i2s_machines), /* GML */
+	AVS_MACH_ENTRY(HDA_SKL_LP, avs_skl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),
 	{},
 };
 
-- 
2.34.1

