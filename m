Return-Path: <linux-pci+bounces-37400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D81D2BB3512
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882B3189D8CC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1FC30BF78;
	Thu,  2 Oct 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NH+B22BH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB9301702;
	Thu,  2 Oct 2025 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394538; cv=none; b=LmTlnopQweMf9CHNdfyR6MyWyLsG7onV4+bHFAGVe80NadhLDhsWr6hrgiSv5bB88g0xsv4d4Uc6Kax2d0QLYQRwllBmMLi3lxpJqpInTRyuSk3JZBmRWoUOFmrIoBkH/G7ttXbsic+iwoqpsDpjNSufp6xyxrH9NVb/sycrEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394538; c=relaxed/simple;
	bh=Fu4vQqqaut51G7br7y41g3wtyb3ukOJffOt1ZQ3xWH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQApZ1pIWhnq3rR5mZVLhj5eSdo6m300n+QGEgycqY8h2pLe1Z9a+lYo037w/+jqNb7mporTupZEnSvkDYDAU0N3O8DAQJBVOUCw8yN3qBUUhk69THxRTTcI9RdmOzRGcgumHWyr/9dTf1Qs3uoOY7LMkWGYtrCHvyVEadqIEjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NH+B22BH; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394536; x=1790930536;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fu4vQqqaut51G7br7y41g3wtyb3ukOJffOt1ZQ3xWH8=;
  b=NH+B22BHBw/Ce3iO/6BTZjMk+jEOJ8Uyjj1uKc2/rmVbUvVm4oOC5Mvq
   sikd9gSpNvM9XTjZc8IYXCKNy25KAPvxpf8IcFVMERg4lmwTKPOa/S2I/
   PMxBsT66HwI+e4a6RG/quyb9tkug5AgBuVJky6YFAuTxUD+UM3hEKm3yt
   zRXsA+uGu3W2T74E1Z9Xd/XNNQhCP4Z6Rn5/S7YSChMxHQuUV5MebsIaS
   X1ofKHu/Ew97AJtuTrZvvHgAGiD/oo8BGI3WJNYa7UHTWeWtEHS46aBuq
   RPUtl+h66gjFv18LL0SJ275O74dowDOdeHK24bxL5IltmMrc/SLqVCY3P
   g==;
X-CSE-ConnectionGUID: IMCxbAL+SZiiL9kDLHmYvA==
X-CSE-MsgGUID: S5wf/YdUTha9fnOr/i93bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099062"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099062"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:16 -0700
X-CSE-ConnectionGUID: uMknhQ1RQhGbYhVrurXduQ==
X-CSE-MsgGUID: sLUt9+10TuGfgJndKFvS/w==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:13 -0700
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
Subject: [PATCH 5/7] ASoC: SOF: Intel: add initial support for NVL-S
Date: Thu,  2 Oct 2025 11:42:50 +0300
Message-ID: <20251002084252.7305-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
References: <20251002084252.7305-1-peter.ujfalusi@linux.intel.com>
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
index 4f27f8c8debf..b14e7ca60e91 100644
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
index d4372f0bff7e..8b7ccb1596d5 100644
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
2.51.0


