Return-Path: <linux-pci+bounces-43006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48250CB988F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 19:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71B393020368
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860B52FF163;
	Fri, 12 Dec 2025 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjCrh2EW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B012FF656;
	Fri, 12 Dec 2025 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765563476; cv=none; b=cmj9doN1KzcvmbORBAm8ri+vySP3yCkTnphYuomvCGaxIlq2cagK5DVxcnpdG8fBcpVuVwlFAPzla2JhJ4V0mMlicVPdq7fkShbEe9cByyfxXyuaChl0i33oVDyZvzVTdxQ8GM6sw6lHV3yfDpSghGE/3o4M4nxtapSbOnGqEmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765563476; c=relaxed/simple;
	bh=TOFsD/pnvFybujerKESd5EmoAy4h3WqeGEyDM23DM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3Z4bn5c+1u9SHfO2g3TfGRZUjumsrudbixhq+M4dpUm5rJiBAh25RhsfQBE5rHb9Lz3k61aq6OdML2gWuhppss3wIfqFXBP4CKShJddE/QAK88rX1JYvDKl5Ed5a49hY+imlBZxv8AEursKqU/WQ4gqOsU+d9I/2B0F9D6E6EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjCrh2EW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765563473; x=1797099473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TOFsD/pnvFybujerKESd5EmoAy4h3WqeGEyDM23DM9A=;
  b=JjCrh2EWtJL5cPgFlbHlLPdKMIpDFQvdVNGpeQUGsChyT4uSNyKrAd1g
   q22vd5FXuihzH/LgaO3AL5BbW8MnlFm9p9v5mc8AWlSPC9b2Tb4X5w1oq
   dF9pNgeQtQncoLCRTz6+TOd+Gkug+v6Ycoh2vWCaOpF5glq2cEwlVezgE
   lNKzubfsKHwFSGGYuTQng0wuwz0yaXTcCRtor5z0og6TGnpRzdIjnfH9S
   q5EqSUH6Us7jUOIR47sqcXi5GPPwNkr2tVKz9hD7mE4IBssEOq++jnrT3
   lbc6LXKcW4o154WUm3XgiBJCUpY6HwB0YJsW6tov5GEtzdPw+2h6RiQtb
   Q==;
X-CSE-ConnectionGUID: 4J1+OLh1TQe8+D0t2EvqyQ==
X-CSE-MsgGUID: 6pUE9URWQ3ebDAbOjzFRSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11640"; a="67529586"
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="67529586"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 10:17:51 -0800
X-CSE-ConnectionGUID: ZUDLEdGGQW2GVEeo28YGFw==
X-CSE-MsgGUID: /U7CIvEZTMqWkmhEexhq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,144,1763452800"; 
   d="scan'208";a="201566780"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 12 Dec 2025 10:17:47 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B1DDD93; Fri, 12 Dec 2025 19:17:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/1] ASoC: Fix acronym for Intel Gemini Lake
Date: Fri, 12 Dec 2025 19:16:20 +0100
Message-ID: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the used GML is consistent with the pattern for other Intel * Lake
SoCs, the de facto use is GLK. Update the acronym and users accordingly.

Note, a handful of the drivers for Gemini Lake in the Linux kernel use
GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
The only ones in this patch used the inconsistent one.

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: added tag (Bjorn), left variable name as is (Cezary), added comment (Cezary)

 include/linux/pci_ids.h               | 3 ++-
 sound/hda/controllers/intel.c         | 2 +-
 sound/hda/core/intel-dsp-config.c     | 4 ++--
 sound/soc/intel/avs/board_selection.c | 2 +-
 sound/soc/intel/avs/core.c            | 2 +-
 sound/soc/sof/intel/pci-apl.c         | 2 +-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a9a089566b7c..84b830036fb4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2950,7 +2950,8 @@
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
-#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
+/* In a few of the Intel documents the GML acronym is used for Gemini Lake */
+#define PCI_DEVICE_ID_INTEL_HDA_GLK	0x3198
 #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
 #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 1e8e3d61291a..bb9a64d41580 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2555,7 +2555,7 @@ static const struct pci_device_id azx_ids[] = {
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-	{ PCI_DEVICE_DATA(INTEL, HDA_GML, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Haswell */
 	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_0, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_2, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index 0c25e87408de..ddb8db3e8e39 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -154,7 +154,7 @@ static const struct config_entry config_table[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
 	{
 		.flags = FLAG_SOF,
-		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
 		.dmi_table = (const struct dmi_system_id []) {
 			{
 				.ident = "Google Chromebooks",
@@ -167,7 +167,7 @@ static const struct config_entry config_table[] = {
 	},
 	{
 		.flags = FLAG_SOF,
-		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
+		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
 		.codec_hid =  &essx_83x6,
 	},
 #endif
diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 52e6266a7cb8..8a46285181fa 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -367,7 +367,7 @@ static const struct avs_acpi_boards i2s_boards[] = {
 	AVS_MACH_ENTRY(HDA_SKL_LP,	avs_skl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_KBL_LP,	avs_kbl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_APL,		avs_apl_i2s_machines),
-	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
+	AVS_MACH_ENTRY(HDA_GLK,		avs_gml_i2s_machines),
 	AVS_MACH_ENTRY(HDA_CNL_LP,	avs_cnl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_CNL_H,	avs_cnl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_CML_LP,	avs_cnl_i2s_machines),
diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
index 6e0e65584c7f..1a53856c2ffb 100644
--- a/sound/soc/intel/avs/core.c
+++ b/sound/soc/intel/avs/core.c
@@ -897,7 +897,7 @@ static const struct pci_device_id avs_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_H, &skl_desc) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S, &skl_desc) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &apl_desc) },
-	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &apl_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, &apl_desc) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP,	&cnl_desc) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H,	&cnl_desc) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP,	&cnl_desc) },
diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
index 0bf7ee753bc3..3241403efa60 100644
--- a/sound/soc/sof/intel/pci-apl.c
+++ b/sound/soc/sof/intel/pci-apl.c
@@ -86,7 +86,7 @@ static const struct sof_dev_desc glk_desc = {
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
-	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &glk_desc) },
+	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, &glk_desc) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
-- 
2.50.1


