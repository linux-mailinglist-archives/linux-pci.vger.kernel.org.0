Return-Path: <linux-pci+bounces-40199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7858C30F69
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 862784FA146
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729E82F546C;
	Tue,  4 Nov 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpu03yUn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BE02F531C;
	Tue,  4 Nov 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258619; cv=none; b=pK3RK1JTLDKfzU0ao1TpmHI0Jg5PekhT9xa1Tx6U1HECrhbO+xSrnr8uDC8iNaONCJl2psx5u3ssy0VlTVwbOc9i6ghEQxtSK1LL6lsJdKAn2O0VG678ZtmhRdnoJuaAPmMIbxgTfkne66jOzD+jg/e4ROPpvK3I25Pk3sqImnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258619; c=relaxed/simple;
	bh=3Wz2ociLlU7PdsoMeIRGOgMTYOo+GdiOibzm9Wr2J5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVll+8iOGyOUDfpiV9nDrZVTc6zxS7w79Xq6H9mcBWGfUF0Bc793cqCR5JavQDUWy6MpQ+pIMezAvwF5ngdISFFcXrQzwjGFvXZI7UOdw3dYkIVhACUWaLj3BeQ15IR86VtJgyTBi+Z+6/4M7slc1AlZRA4uERlpc5maPF2BfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpu03yUn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258618; x=1793794618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Wz2ociLlU7PdsoMeIRGOgMTYOo+GdiOibzm9Wr2J5M=;
  b=fpu03yUn6MC7+a/N7ZL01HTpkYmUJb/4st392E0JkXE+ink8Wo+SBkt5
   i7V8MjDKctOTW8lSvmGqNZsl+FaNAdY9qHZDRohngniaCiAd2Jq2LF0aP
   Gsc4zajJ8OObn34fhc8nnyE8z4begK2IP7oOUvQmWKgvY1iOTSYmk2PtX
   AD7+GbZsPUb86nNFaLA7umjxGlSjuwuBy3cUcf1L/GIdtbhBwdDPyzSHj
   yzry+0hgFbHmSvJX0AlGPcFk97cx7ouRnSMMfIj2zkWx+cXLOdu6tiPpV
   xEFZ1l+5tDB5RG5cw/pM3sY0sw3Gd1dzP38dfwZkXccUEUNRNGrikicIu
   A==;
X-CSE-ConnectionGUID: MYLZ5GtgRk2Y6xX6BmQ2RQ==
X-CSE-MsgGUID: MOJWLt2qT/+gNWD0qOgWzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187516"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187516"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:58 -0800
X-CSE-ConnectionGUID: E4NwLBe6Q76mJhwp5aejBA==
X-CSE-MsgGUID: Kxj2dmQjR7G2NO+j7/Z7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832433"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:54 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 5/7] ASoC: SOF: Intel: add initial support for NVL-S
Date: Tue,  4 Nov 2025 14:16:48 +0200
Message-ID: <20251104121650.21872-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
References: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Nova Lake S (NVL-S).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sof/intel/Kconfig   | 17 ++++++++
 sound/soc/sof/intel/Makefile  |  2 +
 sound/soc/sof/intel/hda-dsp.c |  1 +
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/nvl.c     | 55 +++++++++++++++++++++++
 sound/soc/sof/intel/nvl.h     | 14 ++++++
 sound/soc/sof/intel/pci-nvl.c | 82 +++++++++++++++++++++++++++++++++++
 sound/soc/sof/intel/shim.h    |  1 +
 8 files changed, 173 insertions(+)
 create mode 100644 sound/soc/sof/intel/nvl.c
 create mode 100644 sound/soc/sof/intel/nvl.h
 create mode 100644 sound/soc/sof/intel/pci-nvl.c

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 4fca4c9458c5..54cd3807f8c6 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -300,6 +300,23 @@ config SND_SOC_SOF_PANTHERLAKE
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_SOF_INTEL_NVL
+	tristate
+	select SND_SOC_SOF_HDA_COMMON
+	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+	select SND_SOC_SOF_IPC4
+	select SND_SOC_SOF_INTEL_PTL
+
+config SND_SOC_SOF_NOVALAKE
+	tristate "SOF support for Novalake"
+	default SND_SOC_SOF_PCI
+	select SND_SOC_SOF_INTEL_NVL
+	help
+	  This adds support for Sound Open Firmware for Intel(R) platforms
+	  using the Novalake processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
+
 config SND_SOC_SOF_HDA_COMMON
 	tristate
 
diff --git a/sound/soc/sof/intel/Makefile b/sound/soc/sof/intel/Makefile
index aab803a495b1..cc9783e933f8 100644
--- a/sound/soc/sof/intel/Makefile
+++ b/sound/soc/sof/intel/Makefile
@@ -39,6 +39,7 @@ snd-sof-pci-intel-tgl-y := pci-tgl.o tgl.o
 snd-sof-pci-intel-mtl-y := pci-mtl.o mtl.o
 snd-sof-pci-intel-lnl-y := pci-lnl.o lnl.o
 snd-sof-pci-intel-ptl-y := pci-ptl.o ptl.o
+snd-sof-pci-intel-nvl-y := pci-nvl.o nvl.o
 
 obj-$(CONFIG_SND_SOC_SOF_MERRIFIELD) += snd-sof-pci-intel-tng.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_SKL) += snd-sof-pci-intel-skl.o
@@ -49,3 +50,4 @@ obj-$(CONFIG_SND_SOC_SOF_INTEL_TGL) += snd-sof-pci-intel-tgl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_MTL) += snd-sof-pci-intel-mtl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_LNL) += snd-sof-pci-intel-lnl.o
 obj-$(CONFIG_SND_SOC_SOF_INTEL_PTL) += snd-sof-pci-intel-ptl.o
+obj-$(CONFIG_SND_SOC_SOF_INTEL_NVL) += snd-sof-pci-intel-nvl.o
diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 3ab6d5ce6329..e9f092f082a1 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -70,6 +70,7 @@ static void hda_get_interfaces(struct snd_sof_dev *sdev, u32 *interface_mask)
 		break;
 	case SOF_INTEL_ACE_2_0:
 	case SOF_INTEL_ACE_3_0:
+	case SOF_INTEL_ACE_4_0:
 		interface_mask[SOF_DAI_DSP_ACCESS] =
 			BIT(SOF_DAI_INTEL_SSP) | BIT(SOF_DAI_INTEL_DMIC) |
 			BIT(SOF_DAI_INTEL_HDA) | BIT(SOF_DAI_INTEL_ALH);
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 28daf0a3b984..562fe8be79c1 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -936,6 +936,7 @@ extern const struct sof_intel_dsp_desc arl_s_chip_info;
 extern const struct sof_intel_dsp_desc lnl_chip_info;
 extern const struct sof_intel_dsp_desc ptl_chip_info;
 extern const struct sof_intel_dsp_desc wcl_chip_info;
+extern const struct sof_intel_dsp_desc nvl_s_chip_info;
 
 /* Probes support */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
diff --git a/sound/soc/sof/intel/nvl.c b/sound/soc/sof/intel/nvl.c
new file mode 100644
index 000000000000..ff215151af2a
--- /dev/null
+++ b/sound/soc/sof/intel/nvl.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// Copyright(c) 2025 Intel Corporation
+
+/*
+ * Hardware interface for audio DSP on NovaLake.
+ */
+
+#include <sound/hda_register.h>
+#include <sound/hda-mlink.h>
+#include <sound/sof/ipc4/header.h>
+#include "../ipc4-priv.h"
+#include "../ops.h"
+#include "hda.h"
+#include "hda-ipc.h"
+#include "../sof-audio.h"
+#include "mtl.h"
+#include "lnl.h"
+#include "ptl.h"
+#include "nvl.h"
+
+int sof_nvl_set_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *dsp_ops)
+{
+	/* Use PTL ops for NVL */
+	return sof_ptl_set_ops(sdev, dsp_ops);
+};
+EXPORT_SYMBOL_NS(sof_nvl_set_ops, "SND_SOC_SOF_INTEL_NVL");
+
+const struct sof_intel_dsp_desc nvl_s_chip_info = {
+	.cores_num = 2,
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
+	.check_sdw_irq = lnl_dsp_check_sdw_irq,
+	.check_sdw_wakeen_irq = lnl_sdw_check_wakeen_irq,
+	.sdw_process_wakeen = hda_sdw_process_wakeen_common,
+	.check_ipc_irq = mtl_dsp_check_ipc_irq,
+	.cl_init = mtl_dsp_cl_init,
+	.power_down_dsp = mtl_power_down_dsp,
+	.disable_interrupts = lnl_dsp_disable_interrupts,
+	.hw_ip_version = SOF_INTEL_ACE_4_0,
+};
+
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_MTL");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_LNL");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_PTL");
diff --git a/sound/soc/sof/intel/nvl.h b/sound/soc/sof/intel/nvl.h
new file mode 100644
index 000000000000..0be3fdfbbd48
--- /dev/null
+++ b/sound/soc/sof/intel/nvl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef __SOF_INTEL_NVL_H
+#define __SOF_INTEL_NVL_H
+
+int sof_nvl_set_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *dsp_ops);
+
+#endif /* __SOF_INTEL_NVL_H */
diff --git a/sound/soc/sof/intel/pci-nvl.c b/sound/soc/sof/intel/pci-nvl.c
new file mode 100644
index 000000000000..c499c14b93d5
--- /dev/null
+++ b/sound/soc/sof/intel/pci-nvl.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+//
+// This file is provided under a dual BSD/GPLv2 license.  When using or
+// redistributing this file, you may do so under either license.
+//
+// Copyright(c) 2025 Intel Corporation.
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
+#include "nvl.h"
+
+/* PantherLake ops */
+static struct snd_sof_dsp_ops sof_nvl_ops;
+
+static int sof_nvl_ops_init(struct snd_sof_dev *sdev)
+{
+	return sof_nvl_set_ops(sdev, &sof_nvl_ops);
+}
+
+static const struct sof_dev_desc nvl_s_desc = {
+	.use_acpi_target_states	= true,
+	.machines               = snd_soc_acpi_intel_nvl_machines,
+	.alt_machines		= snd_soc_acpi_intel_nvl_sdw_machines,
+	.resindex_lpe_base      = 0,
+	.resindex_pcicfg_base   = -1,
+	.resindex_imr_base      = -1,
+	.irqindex_host_ipc      = -1,
+	.chip_info		= &nvl_s_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_4),
+	.ipc_default		= SOF_IPC_TYPE_4,
+	.dspless_mode_supported	= true,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4/nvl-s",
+	},
+	.default_lib_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-lib/nvl-s",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_4] = "sof-nvl-s.ri",
+	},
+	.nocodec_tplg_filename = "sof-nvl-nocodec.tplg",
+	.ops = &sof_nvl_ops,
+	.ops_init = sof_nvl_ops_init,
+};
+
+/* PCI IDs */
+static const struct pci_device_id sof_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, &nvl_s_desc) }, /* NVL-S */
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, sof_pci_ids);
+
+/* pci_driver definition */
+static struct pci_driver snd_sof_pci_intel_nvl_driver = {
+	.name = "sof-audio-pci-intel-nvl",
+	.id_table = sof_pci_ids,
+	.probe = hda_pci_intel_probe,
+	.remove = sof_pci_remove,
+	.shutdown = sof_pci_shutdown,
+	.driver = {
+		.pm = pm_ptr(&sof_pci_pm),
+	},
+};
+module_pci_driver(snd_sof_pci_intel_nvl_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SOF support for NovaLake platforms");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_HDA_GENERIC");
+MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_HDA_COMMON");
+MODULE_IMPORT_NS("SND_SOC_SOF_PCI_DEV");
diff --git a/sound/soc/sof/intel/shim.h b/sound/soc/sof/intel/shim.h
index dc6a93d05bfe..33d27cb5f1d7 100644
--- a/sound/soc/sof/intel/shim.h
+++ b/sound/soc/sof/intel/shim.h
@@ -23,6 +23,7 @@ enum sof_intel_hw_ip_version {
 	SOF_INTEL_ACE_1_0,	/* MeteorLake */
 	SOF_INTEL_ACE_2_0,	/* LunarLake */
 	SOF_INTEL_ACE_3_0,	/* PantherLake */
+	SOF_INTEL_ACE_4_0,	/* NovaLake */
 };
 
 /*
-- 
2.51.2


