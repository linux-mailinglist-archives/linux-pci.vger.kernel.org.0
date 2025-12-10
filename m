Return-Path: <linux-pci+bounces-42887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB45CB2DC1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 051A8303C832
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666F9318157;
	Wed, 10 Dec 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJYZ9xZI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3243130276A;
	Wed, 10 Dec 2025 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765367756; cv=none; b=WmpCNfGEqxriWSpTZ8dBubxS0Re1p/ZxIInWjPf2hx2PE+2l1ZyFrHHidNNK80Mshz2YLfzAYCkueB6yd5Ap+rmHStUv2/kx5vzlt2EvVSjD6m42+h8bfeSPM9MlFe3Iya2yw7nhNoJlhjCFRBA88muvuHpDwwhvw316WbTZDBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765367756; c=relaxed/simple;
	bh=pegXHXohlIomiOeYaX9g6OeFf9beExXwUJfndBG+DAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9M/OGWSFafNRW/EKbBF1wN+eIDD3Wsf0te0uh8BriicPl64jaeQQZKNmmgqYJjKkueqDLNcHcJcGwlU6HiQ+2m24vXmd2HTrEia8Hf4/vVQT9ClFTero5Yg/59NHiWf/94y8GaCmz8Im1IFeegQlR228NOUnWlsqfchpfAPnvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJYZ9xZI; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765367754; x=1796903754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pegXHXohlIomiOeYaX9g6OeFf9beExXwUJfndBG+DAU=;
  b=cJYZ9xZISXuTbujrfLPMEVMS+Fy7qDwqn4YoWyz+HNH0KI7h5jfAH/CO
   ZV0qF5J/Mdv6Ya5/9JGUry8b5zr8I/XuVGW1cuR0soHyjdGQSGItXDKwm
   S8rpVoEr8SXG5aqioXJGXKOk4p2fVzqoJiHFbyWtWXERaEAPoVuvYGF2V
   vqQxzO1FcD82cKphMMdVLcKYSBq9Z1Y035pFhis3SP80wfwbv6fAJgONd
   UTczeYqvTiSv7WjMAv+cfyftSgp3QPgEiTnr8BSbuRprnfX21AN2juG80
   pDsIWlXS+HJsr+RXOAWRvmdeY8MhaWIQkJDy8iB3zqzVGwSiqmfxx5Rcf
   A==;
X-CSE-ConnectionGUID: XL/RQnG3SpqIBWsTMhKxZg==
X-CSE-MsgGUID: 6uAQpWROQ/yhRsOcQTM7bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67273280"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67273280"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 03:55:53 -0800
X-CSE-ConnectionGUID: IUe7le5MTdq30C3xjyHy8g==
X-CSE-MsgGUID: spBFDOQDR8u7m2pl8rcbmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,263,1758610800"; 
   d="scan'208";a="201419875"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa004.fm.intel.com with ESMTP; 10 Dec 2025 03:55:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7AF3793; Wed, 10 Dec 2025 12:55:48 +0100 (CET)
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
Subject: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
Date: Wed, 10 Dec 2025 12:55:44 +0100
Message-ID: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>
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

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pci_ids.h               | 2 +-
 sound/hda/controllers/intel.c         | 2 +-
 sound/hda/core/intel-dsp-config.c     | 4 ++--
 sound/soc/intel/avs/board_selection.c | 4 ++--
 sound/soc/intel/avs/core.c            | 2 +-
 sound/soc/sof/intel/pci-apl.c         | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a9a089566b7c..22b8cfc11add 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2950,7 +2950,7 @@
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
 #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
-#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
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
index c401c0658421..948fd468d2fe 100644
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
index 52e6266a7cb8..46723618d458 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -227,7 +227,7 @@ static struct snd_soc_acpi_mach avs_apl_i2s_machines[] = {
 	{},
 };
 
-static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
+static struct snd_soc_acpi_mach avs_glk_i2s_machines[] = {
 	{
 		.id = "INT343A",
 		.drv_name = "avs_rt298",
@@ -367,7 +367,7 @@ static const struct avs_acpi_boards i2s_boards[] = {
 	AVS_MACH_ENTRY(HDA_SKL_LP,	avs_skl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_KBL_LP,	avs_kbl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_APL,		avs_apl_i2s_machines),
-	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
+	AVS_MACH_ENTRY(HDA_GLK,		avs_glk_i2s_machines),
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


