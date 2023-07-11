Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB1274EFAA
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 14:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjGKM7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 08:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjGKM64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:58:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 360021984;
        Tue, 11 Jul 2023 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080321; x=1720616321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGFjR5MGo4r+bbi4GiYCSGXaYLrA3LirC77XgoYksaU=;
  b=gysNVegRmjz2A0z2CWm/9BWxodddMDcS5hqXqOrMxX/3vwwR2W07onSU
   hi4Yg/hg6gyLk/3SMGyftdOybKaYSejaQK031h2fXmqHyQE2YWM6cpLo1
   T0FemKAMSHZQJGOgOhTbirGPjPyy9pW3MmGif8eOgHEAAaOOBQcJ2JFt2
   3u5ZIg0ukcSBXI5S677tfXU5w9uu3W8jUPyzQKFNqVcxX00ZFdsThpmVG
   8AWO1F5Pd+neX1WZBUKUilWzYTytY0hDH0IhO1ek6wW06cFq9Ej1GEjwa
   0i8LNUlOMVvs4y+8qWIg8m+wWIebTcqFApm92QABsF/usDNUZUO0GF5so
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187471"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367187471"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666666"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834666666"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:24 -0700
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
Subject: [PATCH 07/13] ALSA: intel-dsp-config: Convert to PCI device IDs defines
Date:   Tue, 11 Jul 2023 14:57:20 +0200
Message-Id: <20230711125726.3509391-8-amadeuszx.slawinski@linux.intel.com>
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

Use PCI device IDs from pci_ids.h header. Also simplify comments for
Alder Lake and Raptor Lake platforms, as new IDs make it clear what
revision is in use.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 119 ++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 64 deletions(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 317bdf6dcbef..2a71fa5ffec1 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -50,14 +50,14 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x119a,
+		.device = PCI_DEVICE_ID_INTEL_ADSP_TNG,
 	},
 #endif
 /* Broxton-T */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x1a98,
+		.device = PCI_DEVICE_ID_INTEL_HDA_APL_T,
 	},
 #endif
 /*
@@ -68,7 +68,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x5a98,
+		.device = PCI_DEVICE_ID_INTEL_HDA_APL,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Up Squared",
@@ -82,14 +82,14 @@ static const struct config_entry config_table[] = {
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
@@ -110,7 +110,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	{
 		.flags = FLAG_SST,
-		.device = 0x9d70,
+		.device = PCI_DEVICE_ID_INTEL_HDA_SKL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -123,14 +123,14 @@ static const struct config_entry config_table[] = {
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
@@ -143,7 +143,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SST | FLAG_SST_ONLY_IF_DMIC,
-		.device = 0x9d71,
+		.device = PCI_DEVICE_ID_INTEL_HDA_KBL_LP,
 	},
 #endif
 
@@ -155,7 +155,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x3198,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -168,7 +168,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = 0x3198,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
 		.codec_hid =  &essx_83x6,
 	},
 #endif
@@ -188,7 +188,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_CANNONLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x9dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -207,12 +207,12 @@ static const struct config_entry config_table[] = {
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
 
@@ -220,7 +220,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COFFEELAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0xa348,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -233,7 +233,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
-		.device = 0xa348,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CNL_H,
 	},
 #endif
 
@@ -241,7 +241,7 @@ static const struct config_entry config_table[] = {
 /* Cometlake-LP */
 	{
 		.flags = FLAG_SOF,
-		.device = 0x02c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -267,17 +267,17 @@ static const struct config_entry config_table[] = {
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
@@ -296,12 +296,12 @@ static const struct config_entry config_table[] = {
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
 
@@ -309,7 +309,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x34c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_ICL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -322,12 +322,12 @@ static const struct config_entry config_table[] = {
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
 
@@ -335,7 +335,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_JASPERLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0x4dc8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_JSL_N,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -348,12 +348,12 @@ static const struct config_entry config_table[] = {
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
 
@@ -361,7 +361,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = 0xa0c8,
+		.device = PCI_DEVICE_ID_INTEL_HDA_TGL_LP,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -380,16 +380,16 @@ static const struct config_entry config_table[] = {
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
 
@@ -397,78 +397,69 @@ static const struct config_entry config_table[] = {
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
 
@@ -549,7 +540,7 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
 	const struct config_entry *cfg;
 
 	/* Intel vendor only */
-	if (pci->vendor != 0x8086)
+	if (pci->vendor != PCI_VENDOR_ID_INTEL)
 		return SND_INTEL_DSP_DRIVER_ANY;
 
 	/*
@@ -557,12 +548,12 @@ int snd_intel_dsp_driver_probe(struct pci_dev *pci)
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

