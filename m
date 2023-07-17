Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D37561F8
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 13:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjGQLsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 07:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjGQLsc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 07:48:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F012E10E6;
        Mon, 17 Jul 2023 04:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689594489; x=1721130489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TZPwoVYRbtfBazyK7ACadvpvg5xXEGIqeRs1l7tnCTs=;
  b=TDcCYt1Pz05Uhx5dNcGLlngMPzXWKxbBGZqfNGz2RCC47XKZ/xEc6WFz
   Mu+ZmqtTxjrK1tZz5Ik4UB+UsfsLX27jLhjLLazZLTSm8N7d3JuMWuoOT
   +RT5hqk1cwum+54eXdbkJNH7c4vMt6rJde3oP8roolj9kHtZ/IKqb8Y1N
   exom1+3kH6Qveweh3iXl+dsFv0UiYXaATAjhK7oltbarzZYbm1h39PkIU
   atjKuidtgMFcUlM9xsdTsHEWQRUehYA3cVjJMWuNuJt9aM35BTy3YQMT+
   ART1NzSsp7YZbpbR6xiIq051VXL51tNfpq3TP15D7DU0FBSwGiFC4uXdH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363372990"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363372990"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969856555"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969856555"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:46:01 -0700
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
Subject: [PATCH v4 13/15] ASoC: Intel: Skylake: Convert to PCI device IDs defines
Date:   Mon, 17 Jul 2023 13:45:09 +0200
Message-Id: <20230717114511.484999-14-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header and while at it change to using
PCI_DEVICE_DATA() macro, to simplify declarations. As Apollolake is
Broxton-P successor that made it to the market, be precise and use APL
shortcut.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/skylake/skl-messages.c | 16 ++++++------
 sound/soc/intel/skylake/skl.c          | 36 +++++++-------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index d31509298a0a..fc2eb04da172 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -169,7 +169,7 @@ static struct skl_dsp_loader_ops bxt_get_loader_ops(void)
 
 static const struct skl_dsp_ops dsp_ops[] = {
 	{
-		.id = 0x9d70,
+		.id = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
 		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
@@ -177,7 +177,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
-		.id = 0x9d71,
+		.id = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
 		.num_cores = 2,
 		.loader_ops = skl_get_loader_ops,
 		.init = skl_sst_dsp_init,
@@ -185,7 +185,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = skl_sst_dsp_cleanup
 	},
 	{
-		.id = 0x5a98,
+		.id = PCI_DEVICE_ID_INTEL_HDA_APL,
 		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
@@ -193,7 +193,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
-		.id = 0x3198,
+		.id = PCI_DEVICE_ID_INTEL_HDA_GML,
 		.num_cores = 2,
 		.loader_ops = bxt_get_loader_ops,
 		.init = bxt_sst_dsp_init,
@@ -201,7 +201,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = bxt_sst_dsp_cleanup
 	},
 	{
-		.id = 0x9dc8,
+		.id = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
@@ -209,7 +209,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
-		.id = 0xa348,
+		.id = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
@@ -217,7 +217,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
-		.id = 0x02c8,
+		.id = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
@@ -225,7 +225,7 @@ static const struct skl_dsp_ops dsp_ops[] = {
 		.cleanup = cnl_sst_dsp_cleanup
 	},
 	{
-		.id = 0x06c8,
+		.id = PCI_DEVICE_ID_INTEL_HDA_CML_H,
 		.num_cores = 4,
 		.loader_ops = bxt_get_loader_ops,
 		.init = cnl_sst_dsp_init,
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 998bd0232cf1..77408a981b97 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -608,8 +608,8 @@ struct skl_clk_parent_src *skl_get_parent_clk(u8 clk_id)
 static void init_skl_xtal_rate(int pci_id)
 {
 	switch (pci_id) {
-	case 0x9d70:
-	case 0x9d71:
+	case PCI_DEVICE_ID_INTEL_HDA_SKL_LP:
+	case PCI_DEVICE_ID_INTEL_HDA_KBL_LP:
 		skl_clk_src[0].rate = 24000000;
 		return;
 
@@ -1145,44 +1145,28 @@ static void skl_remove(struct pci_dev *pci)
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
-	/* Sunrise Point-LP */
-	{ PCI_DEVICE(0x8086, 0x9d70),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_SKL_LP, &snd_soc_acpi_intel_skl_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
-	/* BXT-P */
-	{ PCI_DEVICE(0x8086, 0x5a98),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &snd_soc_acpi_intel_bxt_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
-	/* KBL */
-	{ PCI_DEVICE(0x8086, 0x9D71),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_LP, &snd_soc_acpi_intel_kbl_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
-	/* GLK */
-	{ PCI_DEVICE(0x8086, 0x3198),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &snd_soc_acpi_intel_glk_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
-	/* CNL */
-	{ PCI_DEVICE(0x8086, 0x9dc8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP, &snd_soc_acpi_intel_cnl_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
-	/* CFL */
-	{ PCI_DEVICE(0x8086, 0xa348),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H, &snd_soc_acpi_intel_cnl_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_LP)
-	/* CML-LP */
-	{ PCI_DEVICE(0x8086, 0x02c8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP, &snd_soc_acpi_intel_cnl_machines) },
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_CML_H)
-	/* CML-H */
-	{ PCI_DEVICE(0x8086, 0x06c8),
-		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+	{ PCI_DEVICE_DATA(INTEL, HDA_CML_H, &snd_soc_acpi_intel_cnl_machines) },
 #endif
 	{ 0, }
 };
-- 
2.34.1

