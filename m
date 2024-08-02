Return-Path: <linux-pci+bounces-11188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7520945DF6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47355B23595
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 12:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079B1E3CAF;
	Fri,  2 Aug 2024 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fG56fEm1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C9D1E3CA8;
	Fri,  2 Aug 2024 12:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602434; cv=none; b=u1T3PwuATElwGMQb80qmP47kp+Ct2KAGqblYsgrZhw4e0OZKZWTfrgfojk1O5ZzzbURm+1o5qyw2wwrxJPj8zzQy3jzMpO8oqE83ZxvBHPsGuEQF9l45YzplM+QbK/k1s/VhtHVpAEVvuIfAkz64g6s71Wjzx0Vb4vDMaH4Y920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602434; c=relaxed/simple;
	bh=V0RhOpeMhP1cXKi3BeMAQTsn3sAxD6pw05bjIJm2yPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTG1EsORP178OmuA1JG7lYioyKawW+Lonj11gQHA9eU61G+UULDXtfaFj7knHdCU8MSgIJVQdfBLg9Q7mpmiOnmYy6WxBVGzhsiQqDkv1QZU0XKy+B+kSoWEUyMgnSHoHnbLlB3/Mxy2QuWuq6Xtqg49ntg1MTzBj/Bxnd/kQ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fG56fEm1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602432; x=1754138432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V0RhOpeMhP1cXKi3BeMAQTsn3sAxD6pw05bjIJm2yPg=;
  b=fG56fEm1yrTgmwUBCCnxdtvzQIccXn3FfzLnEpR+HanDg8NhCmVVaNz4
   SoqlDrL3/1Nsd2tiRu5LarTwWACcvyIzOs9sYAwX0GEP97rteInkj77vn
   KbucmYbFZNQUd7Fbz5WLbX9/0pxqcHBDJwCKUzwJeiuIRjvscppkYLYjG
   Td16EZzGx2N8soDzcsWXj5n0auHtF9GVy7jzKSX7enQN9yXU0EKlE6pGC
   dqnN4Xatku5mhollXtD1klmYiF5pbgsXAxmoa89aIBn+hfTYuiszf/K/e
   I9aSh2txzAS3L+UnjhbdefKYLswUXiQM34npdozAcs0hxi5+bSm+O6wgX
   Q==;
X-CSE-ConnectionGUID: FojoNyqGQKSwMQgVDvdaCA==
X-CSE-MsgGUID: u2vERJqPRMikH/ehbpcxwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24488216"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24488216"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:32 -0700
X-CSE-ConnectionGUID: 3Xo9kwqrTa2DmYTAVhpC0A==
X-CSE-MsgGUID: aVkiQ8/TR1SRqtXpbnsPYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55024785"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.89])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:29 -0700
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
Subject: [PATCH v4 3/5] ASoC: SOF: Intel: add initial support for PTL
Date: Fri,  2 Aug 2024 14:40:09 +0200
Message-ID: <20240802124011.173820-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802124011.173820-1-pierre-louis.bossart@linux.intel.com>
References: <20240802124011.173820-1-pierre-louis.bossart@linux.intel.com>
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
index 4198108a7f44..c7a54698fa63 100644
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


