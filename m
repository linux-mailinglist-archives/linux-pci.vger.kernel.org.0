Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4D4753904
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjGNK43 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjGNK4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:56:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015E3A95;
        Fri, 14 Jul 2023 03:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332144; x=1720868144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XIA7ASQK5IHbZ1Q/cY0lNP0QM5cZokqzrrBTLyN22Is=;
  b=irihfDtIso1RLWu72FaOc1VsK2o4nmMc3k+OHUcPpwFlsSi0+6k6GwM3
   nNx335/lmHXsH2kaP1W28FUIpbnFJGBLSbGHCLnj+8N6uh3zaMlP97KqV
   L8RbW9hfrAeQ3jy0kX3PK7r+Qc01jjynhjftEMM+DM27F3ow8rJc6qqAL
   pQeyiZUTc2CJHmo6k+D+ydChko617SbMYJozjN7DEUakrbQmE28fo1ck4
   SUk7YHA9+5ab2hEOrHzRZ8JAmVZdTwyzw6F4r9i2Yj4JEn6cmrGtCr7hp
   MjqxCWMsltsm97CTc4tIPdNoy6fU9RF0XdMGt6leHZocTfVed3iVjHUXy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321248"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321248"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365620"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365620"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:55:39 -0700
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
Subject: [PATCH v2 13/15] ASoC: Intel: Skylake: Convert to PCI device IDs defines
Date:   Fri, 14 Jul 2023 20:56:13 +0200
Message-Id: <20230714185615.370597-14-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header and while at it change to using
PCI_DEVICE_DATA() macro, to simplify declarations. As Apollolake is
Broxton-P successor that made it to the market, be precise and use APL
shortcut.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

