Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE10C7561EF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jul 2023 13:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGQLsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGQLsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 07:48:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D6E199C;
        Mon, 17 Jul 2023 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689594474; x=1721130474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JTtAB0peuppZi/1UxV7auNjZWyvpgH1NkZuyk5N2g2s=;
  b=XSy5ZRdVro/JH5o4azKYBPhnDFmVCVF266W+HUC8xWjCoupo2LIQ8fDc
   0THFoo763t0JT+rupJVemmRHu0Yl0HUvqJI0Gur6KP4pQ02WqQEbEqEMf
   Ouy2FtsShcnkYiHxmfLgzis/LRLtyFioFkIzDprgOYfyVXj/Wh/eleNNH
   wUcnvnWNbqi6dknEsiH9MM191+ttLkKe1CmaR1nk25ByAVMFg801kp5h3
   BbC9QDRgzWasJ6ZJH+FLJIoFNCczZlmDS7MhI0RFHuc0Z0+hk+hVq1Zxy
   ojdtTmCA7Cv3ni5HENVenraKaA/QLYVb3SmupciKe1bH3QpK4aiRWVtLy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="363372918"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="363372918"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 04:45:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="969856524"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="969856524"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2023 04:45:48 -0700
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
Subject: [PATCH v4 09/15] ALSA: intel-dsp-config: Convert to PCI device IDs defines
Date:   Mon, 17 Jul 2023 13:45:05 +0200
Message-Id: <20230717114511.484999-10-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header. Also simplify comments for
Alder Lake and Raptor Lake platforms, as new IDs make it clear what
revision is in use.

Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # for Intel Tangier ID
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 117 ++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 63 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 5cee995f7a42..48bd1fb06f26 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -50,7 +50,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x119a,
+		.device = PCI_DEVICE_ID_INTEL_SST_TNG,
 	},
 #endif
 /*
@@ -61,7 +61,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x5a98,
+		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Up Squared",
@@ -75,14 +75,14 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x5a98,
+		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
 		.codec_hid =  &essx_83x6,
 	},
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
 	{
 		.flags = FLAG_SST,
-		.device = 0x5a98,
+		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -103,7 +103,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	{
 		.flags = FLAG_SST,
-		.device = 0x9d70,
+		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -116,14 +116,14 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SST | FLAG_SST_ONLY_IF_DMIC,
-		.device = 0x9d70,
+		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
 	},
 #endif
 /* Kabylake-LP */
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
 	{
 		.flags = FLAG_SST,
-		.device = 0x9d71,
+		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -136,7 +136,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SST | FLAG_SST_ONLY_IF_DMIC,
-		.device = 0x9d71,
+		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
 	},
 #endif
 
@@ -148,7 +148,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x3198,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -161,7 +161,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x3198,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
 		.codec_hid =  &essx_83x6,
 	},
 #endif
@@ -181,7 +181,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_CANNONLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x9dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -200,12 +200,12 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x09dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x9dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
 	},
 #endif
 
@@ -213,7 +213,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COFFEELAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0xa348,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -226,7 +226,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0xa348,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
 	},
 #endif
 
@@ -234,7 +234,7 @@ static const struct config_entry config_table[] = {
 /* Cometlake-LP */
 	{
 		.flags = FLAG_SOF,
-		.device = 0x02c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -260,17 +260,17 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x02c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x02c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
 	},
 /* Cometlake-H */
 	{
 		.flags = FLAG_SOF,
-		.device = 0x06c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_H,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.matches = {
@@ -289,12 +289,12 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x06c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_H,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x06c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_H,
 	},
 #endif
 
@@ -302,7 +302,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x34c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ICL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -315,12 +315,12 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x34c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ICL_LP,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x34c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ICL_LP,
 	},
 #endif
 
@@ -328,7 +328,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x4dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_JSL_N,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -341,12 +341,12 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x4dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_JSL_N,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
-		.device = 0x4dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_JSL_N,
 	},
 #endif
 
@@ -354,7 +354,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0xa0c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_TGL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -373,16 +373,16 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0xa0c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_TGL_LP,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0xa0c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_TGL_LP,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x43c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_TGL_H,
 	},
 #endif
 
@@ -390,78 +390,69 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ELKHARTLAKE)
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
-		.device = 0x4b55,
+		.device = PCI_DEVICE_ID_INTEL_HDA_EHL_0,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC,
-		.device = 0x4b58,
+		.device = PCI_DEVICE_ID_INTEL_HDA_EHL_3,
 	},
 #endif
 
-/* Alder Lake */
+/* Alder Lake / Raptor Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ALDERLAKE)
-	/* Alderlake-S */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x7ad0,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_S,
 	},
-	/* RaptorLake-S */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x7a50,
+		.device = PCI_DEVICE_ID_INTEL_HDA_RPL_S,
 	},
-	/* Alderlake-P */
 	{
 		.flags = FLAG_SOF,
-		.device = 0x51c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_P,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_P,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51cd,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_PX,
 	},
-	/* Alderlake-PS */
 	{
 		.flags = FLAG_SOF,
-		.device = 0x51c9,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_PS,
 		.codec_hid =  &essx_83x6,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51c9,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_PS,
 	},
-	/* Alderlake-M */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51cc,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_M,
 	},
-	/* Alderlake-N */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x54c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ADL_N,
 	},
-	/* RaptorLake-P */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51ca,
+		.device = PCI_DEVICE_ID_INTEL_HDA_RPL_P_0,
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51cb,
+		.device = PCI_DEVICE_ID_INTEL_HDA_RPL_P_1,
 	},
-	/* RaptorLake-M */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51ce,
+		.device = PCI_DEVICE_ID_INTEL_HDA_RPL_M,
 	},
-	/* RaptorLake-PX */
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0x51cf,
+		.device = PCI_DEVICE_ID_INTEL_HDA_RPL_PX,
 	},
 #endif
 
@@ -542,7 +533,7 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 	const struct config_entry *cfg;
 
 	/* Intel vendor only */
-	if (pci->vendor != 0x8086)
+	if (pci->vendor != PCI_VENDOR_ID_INTEL)
 		return SND_INTEL_DSP_DRIVER_ANY;
 
 	/*
@@ -550,12 +541,12 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 	 * for HDMI/DP support, ignore kernel parameter
 	 */
 	switch (pci->device) {
-	case 0x160c: /* Broadwell */
-	case 0x0a0c: /* Haswell */
-	case 0x0c0c:
-	case 0x0d0c:
-	case 0x0f04: /* Baytrail */
-	case 0x2284: /* Braswell */
+	case PCI_DEVICE_ID_INTEL_HDA_BDW:
+	case PCI_DEVICE_ID_INTEL_HDA_HSW_0:
+	case PCI_DEVICE_ID_INTEL_HDA_HSW_2:
+	case PCI_DEVICE_ID_INTEL_HDA_HSW_3:
+	case PCI_DEVICE_ID_INTEL_HDA_BYT:
+	case PCI_DEVICE_ID_INTEL_HDA_BSW:
 		return SND_INTEL_DSP_DRIVER_ANY;
 	}
 
-- 
2.34.1

