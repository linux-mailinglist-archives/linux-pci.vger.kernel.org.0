Return-Path: <linux-pci+bounces-45252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB280D3C289
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DCFD64293F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E243C00A8;
	Tue, 20 Jan 2026 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hjPcnUxS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CCB3C00B0;
	Tue, 20 Jan 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897878; cv=none; b=cZHpAoyBY3slWPhIearsqGiTxXffN6QgE2EaqvTxLxEOxFuDT3657VPMGJGwNDW5pBpUiJaRYiC1EvV5gOFm5mHraoTDgifZlmz6ehSYh1loxB9THwk1dL/+u5JGc+zy2BORTtx2ulcjg7sl5QD7fGI2nKSH4oYqPcmKMVzfgPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897878; c=relaxed/simple;
	bh=4t4iG3UsIyecPbn5LNcw6IZMWnmx38vmO0ANOAg3Mt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgP+IqgUdplv9ygfrZfnz7QZT2W9cWvntTufZNflChKvXtDVTym4AYFp7DaPe2bWpFOV9vgq2OuwABlogJ2PXdx24sLKDrd6UOg1RzhAREO7Te7fei4RC2xwwR6G1pGMFmw9c7dpqZPo6Ii5DKTy/MNtdKzZe+eKQnxMbEEPcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hjPcnUxS; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897877; x=1800433877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4t4iG3UsIyecPbn5LNcw6IZMWnmx38vmO0ANOAg3Mt0=;
  b=hjPcnUxSEIe5B0kHP0c+IAc2fDNvwtaXrrYsEeqVm04TP/4DuIUtbUe7
   2QqsViTW+tz2ulzWbRGVKkwibZomO1zdwiQM3d0K5UZWuNMkdGFf+iDsH
   rnRZIz9rXMf+NfHlKyDezAvGOK8F7irhv/IXUDGJ3PoUV7LkOnLcfA/n2
   9uXnusVmPO1+mGr1jKcmiCwndfRPkiGkd+gxwv7FGDtVo+J+uB8hmtjcq
   8ow5ewUDP/zRvcvCzxLjTY9okkgC4w48YlUAMKxi4GQxnYhNIQ2jpCSjy
   JifdwHGNP2Af5dYlm+NmW3OkEwvZsgyjkTHL8DrMtT487UoyQyaa4ckmD
   w==;
X-CSE-ConnectionGUID: SiWuz9hqRa2csRHj5pTHRw==
X-CSE-MsgGUID: f7rvLv01RZemzD4fE8a8TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70071938"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70071938"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:17 -0800
X-CSE-ConnectionGUID: +uWgMT5tTH+phFbv0I56sg==
X-CSE-MsgGUID: Y/lKU88QRBCsi3/tPew+Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210530664"
Received: from krybak-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:13 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/4] ASoC: SOF: Intel: add support for Nova Lake NVL
Date: Tue, 20 Jan 2026 10:31:46 +0200
Message-ID: <20260120083148.12063-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Nova Lake (NVL).
The core count for NVL is different compared to NVL-S (4 vs 2)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/nvl.c     | 24 ++++++++++++++++++++++++
 sound/soc/sof/intel/pci-nvl.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 562fe8be79c1..3be39c229c9f 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -936,6 +936,7 @@ extern const struct sof_intel_dsp_desc arl_s_chip_info;
 extern const struct sof_intel_dsp_desc lnl_chip_info;
 extern const struct sof_intel_dsp_desc ptl_chip_info;
 extern const struct sof_intel_dsp_desc wcl_chip_info;
+extern const struct sof_intel_dsp_desc nvl_chip_info;
 extern const struct sof_intel_dsp_desc nvl_s_chip_info;
 
 /* Probes support */
diff --git a/sound/soc/sof/intel/nvl.c b/sound/soc/sof/intel/nvl.c
index ff215151af2a..0d763998558f 100644
--- a/sound/soc/sof/intel/nvl.c
+++ b/sound/soc/sof/intel/nvl.c
@@ -26,6 +26,30 @@ int sof_nvl_set_ops(struct snd_sof_dev *sdev, struct snd_sof_dsp_ops *dsp_ops)
 };
 EXPORT_SYMBOL_NS(sof_nvl_set_ops, "SND_SOC_SOF_INTEL_NVL");
 
+const struct sof_intel_dsp_desc nvl_chip_info = {
+	.cores_num = 4,
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
 const struct sof_intel_dsp_desc nvl_s_chip_info = {
 	.cores_num = 2,
 	.init_core_mask = BIT(0),
diff --git a/sound/soc/sof/intel/pci-nvl.c b/sound/soc/sof/intel/pci-nvl.c
index f75aa996a5bd..bb3c29ef5477 100644
--- a/sound/soc/sof/intel/pci-nvl.c
+++ b/sound/soc/sof/intel/pci-nvl.c
@@ -26,6 +26,36 @@ static int sof_nvl_ops_init(struct snd_sof_dev *sdev)
 	return sof_nvl_set_ops(sdev, &sof_nvl_ops);
 }
 
+static const struct sof_dev_desc nvl_desc = {
+	.use_acpi_target_states	= true,
+	.machines               = snd_soc_acpi_intel_nvl_machines,
+	.alt_machines		= snd_soc_acpi_intel_nvl_sdw_machines,
+	.resindex_lpe_base      = 0,
+	.resindex_pcicfg_base   = -1,
+	.resindex_imr_base      = -1,
+	.irqindex_host_ipc      = -1,
+	.chip_info		= &nvl_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_4),
+	.ipc_default		= SOF_IPC_TYPE_4,
+	.dspless_mode_supported	= true,
+	.on_demand_dsp_boot	= true,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4/nvl",
+	},
+	.default_lib_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-lib/nvl",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_4] = "sof-nvl.ri",
+	},
+	.nocodec_tplg_filename = "sof-nvl-nocodec.tplg",
+	.ops = &sof_nvl_ops,
+	.ops_init = sof_nvl_ops_init,
+};
+
 static const struct sof_dev_desc nvl_s_desc = {
 	.use_acpi_target_states	= true,
 	.machines               = snd_soc_acpi_intel_nvl_machines,
@@ -58,6 +88,7 @@ static const struct sof_dev_desc nvl_s_desc = {
 
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, &nvl_desc) }, /* NVL */
 	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, &nvl_s_desc) }, /* NVL-S */
 	{ 0, }
 };
-- 
2.52.0


