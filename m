Return-Path: <linux-pci+bounces-27456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCA4AB0208
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 20:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7939B2158A
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6038C2882B7;
	Thu,  8 May 2025 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrCeuFzE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B1028750C;
	Thu,  8 May 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727306; cv=none; b=jspM8anVmjnYzOjh/S+1nsWRlkbUa7mq1OsJgOXcBZG7CnB4t7k8zrVyLKP29nckkj1vzXNhqabkLTOxzl6M9b2GpW2i6e7m08FHz5+8Vl74liJjL1WeuXYXzN+/LkTnNlS93olLo0rJLUxQMwDqI45VlOY1V61/xjjtIHyD5bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727306; c=relaxed/simple;
	bh=dqA8hSTGVd06aNWPnSDAlNED3CRCZUYqyNunvr4vtYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0Rq78sBKVli71DpOrHieyL0fIgBVYefh2lqbMsumPioSM5KYSrOqssuk/VuF3imv3DE5gWhnXZk4U4x6eaxEERUgoSEtlvCmz5djaP38iqMXozSkCmvxcH+6D9WQRo6D+oljsSHH0EuP1HMixCNQUI40OYq+Mp5ziHF8OUKNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrCeuFzE; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727305; x=1778263305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dqA8hSTGVd06aNWPnSDAlNED3CRCZUYqyNunvr4vtYA=;
  b=TrCeuFzEMw2cHcGV5vaXUw66xrE1eQTHzFzx1vKeohWgzS7MCVcSlkfI
   JGuOzCt+tsXKcLGdV/wbkgOCtEFTQFmN5TPMuRa9a3stafsaTKDpafZbN
   VvNDDHNBHBwF+hurOF5VRQ0quxcdhwemrpXrrFDAxu8D8gp7BdmnXfwTF
   AOZu9w8ufxqtZBbSty/bf2VMqpnOc1BXi4D7oRuQ4Txz0+jDVWnM2S4c9
   KR1LBX5j0r3J63l2ZgEtsEcdv9RJkOnnjlo42DwUJao2l2akLHXCRMoVy
   ZNnSHhiNRxG1BiwXCnwAuE2pjSPlohPDVQjIQC2+NX525KxEDVu92bvmG
   g==;
X-CSE-ConnectionGUID: bVdm7PHhROetZi3iiOaCVA==
X-CSE-MsgGUID: TLVwWk7ZQnm7l5mBh+vfuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59160551"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59160551"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:44 -0700
X-CSE-ConnectionGUID: y+SvGa5ERnKCO7pXIkMYQw==
X-CSE-MsgGUID: lfST1GnKQEKFRTlqlxFIzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136311409"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:40 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ASoC: SOF: Intel: add initial support for WCL
Date: Thu,  8 May 2025 21:02:38 +0300
Message-ID: <20250508180240.11282-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clone PTL and adjust the number of cores from 5 to 3.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/pci-ptl.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/sof/intel/ptl.c     | 23 +++++++++++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 108cad04879e..e14f82c0831f 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -935,6 +935,7 @@ extern const struct sof_intel_dsp_desc mtl_chip_info;
 extern const struct sof_intel_dsp_desc arl_s_chip_info;
 extern const struct sof_intel_dsp_desc lnl_chip_info;
 extern const struct sof_intel_dsp_desc ptl_chip_info;
+extern const struct sof_intel_dsp_desc wcl_chip_info;
 
 /* Probes support */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
diff --git a/sound/soc/sof/intel/pci-ptl.c b/sound/soc/sof/intel/pci-ptl.c
index 7d4c46f56931..68f6a9841633 100644
--- a/sound/soc/sof/intel/pci-ptl.c
+++ b/sound/soc/sof/intel/pci-ptl.c
@@ -55,10 +55,40 @@ static const struct sof_dev_desc ptl_desc = {
 	.ops_init = sof_ptl_ops_init,
 };
 
+static const struct sof_dev_desc wcl_desc = {
+	.use_acpi_target_states	= true,
+	.machines               = snd_soc_acpi_intel_ptl_machines,
+	.alt_machines		= snd_soc_acpi_intel_ptl_sdw_machines,
+	.resindex_lpe_base      = 0,
+	.resindex_pcicfg_base   = -1,
+	.resindex_imr_base      = -1,
+	.irqindex_host_ipc      = -1,
+	.chip_info		= &wcl_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_4),
+	.ipc_default		= SOF_IPC_TYPE_4,
+	.dspless_mode_supported	= true,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4/wcl",
+	},
+	.default_lib_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-lib/wcl",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_4] = "intel/sof-ipc4-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_4] = "sof-wcl.ri",
+	},
+	.nocodec_tplg_filename = "sof-ptl-nocodec.tplg",
+	.ops = &sof_ptl_ops,
+	.ops_init = sof_ptl_ops_init,
+};
+
 /* PCI IDs */
 static const struct pci_device_id sof_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, &ptl_desc) }, /* PTL */
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, &ptl_desc) }, /* PTL-H */
+	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, &wcl_desc) }, /* WCL */
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, sof_pci_ids);
diff --git a/sound/soc/sof/intel/ptl.c b/sound/soc/sof/intel/ptl.c
index aa0b772178bc..875d18193b05 100644
--- a/sound/soc/sof/intel/ptl.c
+++ b/sound/soc/sof/intel/ptl.c
@@ -126,6 +126,29 @@ const struct sof_intel_dsp_desc ptl_chip_info = {
 	.hw_ip_version = SOF_INTEL_ACE_3_0,
 };
 
+const struct sof_intel_dsp_desc wcl_chip_info = {
+	.cores_num = 3,
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
+	.check_ipc_irq = mtl_dsp_check_ipc_irq,
+	.cl_init = mtl_dsp_cl_init,
+	.power_down_dsp = mtl_power_down_dsp,
+	.disable_interrupts = lnl_dsp_disable_interrupts,
+	.hw_ip_version = SOF_INTEL_ACE_3_0,
+};
+
 MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_MTL");
 MODULE_IMPORT_NS("SND_SOC_SOF_INTEL_LNL");
 MODULE_IMPORT_NS("SND_SOC_SOF_HDA_MLINK");
-- 
2.49.0


