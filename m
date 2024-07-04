Return-Path: <linux-pci+bounces-9788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE827927227
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F4BB2499E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA318FC7F;
	Thu,  4 Jul 2024 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4eYcTAJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EF31A4F1A;
	Thu,  4 Jul 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083236; cv=none; b=aL6KAglajz2LLUlJ8UMZaKkG2wx1lvwFbyWbV9civ+TtJXf/gnsHLK95CqGTI2/EQcLB0cSkEWXSLn5KppGz+WIls+qQVvkHepfLA2wJQSvgAju0Q1p9iMg3BNU1W8q3rFRfYMkh9nxh3qWEHRQopdmN1bC03bwp+Xbzo6I8p20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083236; c=relaxed/simple;
	bh=TFp9KTxFH8YkiPBoejjkkcdXXFeSeaXuTbZHmIoFrOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeJK4Aq34raJC+D5keWByQeCCwHA6KOFi6SqCdftqg6V7Oks+TeEb6IrOs3cfT2qSEqCZVrjZ5UTDeIut/SG1RpJ579Ei126lbUaVesMXMLARKIvE9olMjeeLMY9lAIHQGqx4ZJBUn0hlEu6uqx441pH0Iuv2w5FNk9fyp7BACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4eYcTAJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083235; x=1751619235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TFp9KTxFH8YkiPBoejjkkcdXXFeSeaXuTbZHmIoFrOs=;
  b=A4eYcTAJjp0PgK7szzlEZ3giTlF5O/wweFKBQ46PQXvM2XIiITNxs1Qw
   sV3cz8YwD96jGM6MctHzcfnML/fL0U3ZxOOAbOuiSszE++PlxxYbeFzlx
   K6Gq5pl9U25k1/1ZAivFTX2XTB7AlaqmtlbZzaB2iDk6pg/VoFi7hpgb0
   4SWAn4jvoLQjHiiRJ9UUOoz1yB/cot1mJAkWU6X6CAmz+NCXbQmEiG1xV
   RKJvERv2O6CnkuK3Jk7KMWgCjYQlMWR2bVxY7lXK/p2TgGXh7s86HvmfV
   0CKZDLvO+vWPgWkTeJSQQoQRwHI5R5UEuRN8Ebgp6M/mMord/vaZYaIky
   Q==;
X-CSE-ConnectionGUID: Q3i1ivV/TsmybCYjUAG4yA==
X-CSE-MsgGUID: Ero3PNLZSiaRgkmRv2ofaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17300600"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17300600"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:54 -0700
X-CSE-ConnectionGUID: OqDSlWtaTteD9puN6w6JaQ==
X-CSE-MsgGUID: PrG8aF5TSmi5SkTPrfHNTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51708555"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH v3 3/6] ASoC: SOF: Intel: add initial support for PTL
Date: Thu,  4 Jul 2024 10:53:27 +0200
Message-ID: <20240704085330.371332-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
References: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clone LNL for now.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig   | 17 ++++++++
 sound/soc/sof/intel/Makefile  |  2 +
 sound/soc/sof/intel/hda-dsp.c |  1 +
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/lnl.c     | 27 ++++++++++++
 sound/soc/sof/intel/pci-ptl.c | 77 +++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/shim.h    |  1 +
 7 files changed, 126 insertions(+)
 create mode 100644 sound/soc/sof/intel/pci-ptl.c

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 3396bd46b778..2c43558d96b9 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -281,6 +281,23 @@ config SND_SOC_SOF_LUNARLAKE
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_SOF_INTEL_PTL
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+	select SND_SOC_SOF_IPC4
+	select SND_SOC_SOF_INTEL_LNL
+
+config SND_SOC_SOF_PANTHERLAKE
+	tristate "SOF support for Pantherlake"
+	default SND_SOC_SOF_PCI
+	select SND_SOC_SOF_INTEL_PTL
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Pantherlake processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 
diff --git a/sound/soc/sof/intel/Makefile b/sound/soc/sof/intel/Makefile
index b56fa5530b8b..f40daa616803 100644
--- a/sound/soc/sof/intel/Makefile
+++ b/sound/soc/sof/intel/Makefile
@@ -34,6 +34,7 @@ snd-sof-pci-intel-icl-y := pci-icl.o icl.o
 snd-sof-pci-intel-tgl-y := pci-tgl.o tgl.o
 snd-sof-pci-intel-mtl-y := pci-mtl.o mtl.o
 snd-sof-pci-intel-lnl-y := pci-lnl.o lnl.o
+snd-sof-pci-intel-ptl-y := pci-ptl.o
 
 obj-$(CONFIG_SND_SOC_SOF_MERRIFIELD) += snd-sof-pci-intel-tng.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_SKL) += snd-sof-pci-intel-skl.o
@@ -43,3 +44,4 @@ obj-$(CONFIG_SND_SOC_SOF_INTEL_ICL) += snd-sof-pci-intel-icl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_TGL) += snd-sof-pci-intel-tgl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_MTL) += snd-sof-pci-intel-mtl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_LNL) += snd-sof-pci-intel-lnl.o
+obj-$(CONFIG_SND_SOC_SOF_INTEL_PTL) += snd-sof-pci-intel-ptl.o
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 1315f5bc3e31..4c88522d4048 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -69,6 +69,7 @@ static void hda_get_interfaces(struct snd_sof_dev *sdev, u32 *interface_mask)
 		interface_mask[SOF_DAI_HOST_ACCESS] = BIT(SOF_DAI_INTEL_HDA);
 		break;
 	case SOF_INTEL_ACE_2_0:
+	case SOF_INTEL_ACE_3_0:
 		interface_mask[SOF_DAI_DSP_ACCESS] =
 			BIT(SOF_DAI_INTEL_SSP) | BIT(SOF_DAI_INTEL_DMIC) |
 			BIT(SOF_DAI_INTEL_HDA) | BIT(SOF_DAI_INTEL_ALH);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 3c9e1d59e1ab..b74a472435b5 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -920,6 +920,7 @@ extern const struct sof_intel_dsp_desc adls_chip_info;
 extern const struct sof_intel_dsp_desc mtl_chip_info;
 extern const struct sof_intel_dsp_desc arl_s_chip_info;
 extern const struct sof_intel_dsp_desc lnl_chip_info;
+extern const struct sof_intel_dsp_desc ptl_chip_info;
 
 /* Probes support */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 4b5665f82170..3d5a1f8b17e5 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -22,6 +22,7 @@
 
 /* LunarLake ops */
 struct snd_sof_dsp_ops sof_lnl_ops;
+EXPORT_SYMBOL_NS(sof_lnl_ops, SND_SOC_SOF_INTEL_LNL);
 
 static const struct snd_sof_debugfs_map lnl_dsp_debugfs[] = {
 	{"hda", HDA_DSP_HDA_BAR, 0, 0x4000, SOF_DEBUGFS_ACCESS_ALWAYS},
@@ -181,6 +182,7 @@ int sof_lnl_ops_init(struct snd_sof_dev *sdev)
 
 	return 0;
 };
+EXPORT_SYMBOL_NS(sof_lnl_ops_init, SND_SOC_SOF_INTEL_LNL);
 
 /* Check if an SDW IRQ occurred */
 static bool lnl_dsp_check_sdw_irq(struct snd_sof_dev *sdev)
@@ -245,3 +247,28 @@ const struct sof_intel_dsp_desc lnl_chip_info = {
 	.disable_interrupts = lnl_dsp_disable_interrupts,
 	.hw_ip_version = SOF_INTEL_ACE_2_0,
 };
+
+const struct sof_intel_dsp_desc ptl_chip_info = {
+	.cores_num = 5,
+	.init_core_mask = BIT(0),
+	.host_managed_cores_mask = BIT(0),
+	.ipc_req = MTL_DSP_REG_HFIPCXIDR,
+	.ipc_req_mask = MTL_DSP_REG_HFIPCXIDR_BUSY,
+	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
+	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
+	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
+	.rom_status_reg = LNL_DSP_REG_HFDSC,
+	.rom_init_timeout = 300,
+	.ssp_count = MTL_SSP_COUNT,
+	.d0i3_offset = MTL_HDA_VS_D0I3C,
+	.read_sdw_lcount =  hda_sdw_check_lcount_ext,
+	.enable_sdw_irq = lnl_enable_sdw_irq,
+	.check_sdw_irq = lnl_dsp_check_sdw_irq,
+	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
+	.check_ipc_irq = mtl_dsp_check_ipc_irq,
+	.cl_init = mtl_dsp_cl_init,
+	.power_down_dsp = mtl_power_down_dsp,
+	.disable_interrupts = lnl_dsp_disable_interrupts,
+	.hw_ip_version = SOF_INTEL_ACE_3_0,
+};
+EXPORT_SYMBOL_NS(ptl_chip_info, SND_SOC_SOF_INTEL_LNL);
diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
new file mode 100644
index 000000000000..69195b5e7b1a
--- /dev/null
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2024 Intel Corporation.
+//
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include <sound/sof.h>
+#include "../ops.h"
+#include "../sof-pci-dev.h"
+
+/* platform specific devices */
+#include "hda.h"
+#include "mtl.h"
+
+static const struct sof_dev_desc ptl_desc = {
+	.use_acpi_target_states	= true,
+	.machines               = snd_soc_acpi_intel_ptl_machines,
+	.alt_machines		= snd_soc_acpi_intel_ptl_sdw_machines,
+	.resindex_lpe_base      = 0,
+	.resindex_pcicfg_base   = -1,
+	.resindex_imr_base      = -1,
+	.irqindex_host_ipc      = -1,
+	.chip_info		= &ptl_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_4),
+	.ipc_default		= SOF_IPC_TYPE_4,
+	.dspless_mode_supported	= true,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4/ptl",
+	},
+	.default_lib_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-lib/ptl",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_4] = "sof-ptl.ri",
+	},
+	.nocodec_tplg_filename = "sof-ptl-nocodec.tplg",
+	.ops = &sof_lnl_ops,
+	.ops_init = sof_lnl_ops_init,
+};
+
+/* PCI IDs */
+static const struct pci_device_id sof_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, sof_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_intel_ptl_driver = {
+	.name = "sof-audio-pci-intel-ptl",
+	.id_table = sof_pci_ids,
+	.probe = hda_pci_intel_probe,
+	.remove = sof_pci_remove,
+	.shutdown = sof_pci_shutdown,
+	.driver = {
+		.pm = &sof_pci_pm,
+	},
+};
+module_pci_driver(snd_sof_pci_intel_ptl_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SOF support for PantherLake platforms");
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_HDA_GENERIC);
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_HDA_COMMON);
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_LNL);
+MODULE_IMPORT_NS(SND_SOC_SOF_INTEL_MTL);
+MODULE_IMPORT_NS(SND_SOC_SOF_HDA_MLINK);
+MODULE_IMPORT_NS(SND_SOC_SOF_PCI_DEV);
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index 9328d2bbfd03..8709b750a11e 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -22,6 +22,7 @@ enum sof_intel_hw_ip_version {
 	SOF_INTEL_CAVS_2_5,	/* TigerLake, AlderLake */
 	SOF_INTEL_ACE_1_0,	/* MeteorLake */
 	SOF_INTEL_ACE_2_0,	/* LunarLake */
+	SOF_INTEL_ACE_3_0,	/* PantherLake */
 };
 
 /*
-- 
2.43.0


