Return-Path: <linux-pci+bounces-27922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7400BABB6C2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8FC93B6322
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9B426A091;
	Mon, 19 May 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KYeXesSn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3885267B95;
	Mon, 19 May 2025 08:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642082; cv=none; b=IxupzzF11gE1SvfUyaHUqyYTXNc06LkA1BJs7QGDqDtDSHbziGeZwFUSgXwpnKOfb1kQAiSMV2luQfnLqH+NAhxm7Zlbgzb8qb3QCIYJDjU8nyPu+8vPfByyfnXorpLUTj8BlonuZ58iIJJ/GzO5jgUH6RFOXopX+KR1U/eFekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642082; c=relaxed/simple;
	bh=HX/RnaMgV4BdfMP1xX7X8yjvWyQQrSZTADOcE2z1VLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch6GU2rK634XkJf3AzYXVWiuNTCCafsha1L2izGopN5Sn7gaEf7z2uouaJWa//HFT9xtLembmNJxwCpOj0UPUPUXCC6JlpeaIN6wA39I2esXs0IWr43CSFwX1jzACWsXIr+deHxs9gjFsC+MHaaymmkXL6in3t/7N46uZB3nD64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KYeXesSn; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642080; x=1779178080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HX/RnaMgV4BdfMP1xX7X8yjvWyQQrSZTADOcE2z1VLU=;
  b=KYeXesSnuYsgtVaKaYzx8R4hfAXoyI+m2X3HbStVHLR+lEiCw285vguq
   8lGdc8zluUCGqGzVIbrAFep0xcLfmqSGx/Bqf0sXFse397Bb/fqllUvwD
   w4Zn56cg1XcwjAZp48nfHkDx72SYkLG56Wox3Vd656UpB0+hop9hDzJF9
   dbNeAo66Wrhdy3sGYW8yi6NzVr1VyEghU/Ehs4IULmkyfHBQvvneWTAum
   hH76j4coubIv0QqPsyLw0GObhWaQJuHXyGzijFWbtGcHVoXodauWdXl1n
   g5soKYJQEpyT3uTqc2Xt/tS+Jaa+XpungAwGIPSW36wCiqUIzmcJDCkGC
   w==;
X-CSE-ConnectionGUID: tiTWY6MdRx+rZbtLaoDVjg==
X-CSE-MsgGUID: 28bo5/m5Q7ygYFK9RWkssw==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163528"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163528"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:59 -0700
X-CSE-ConnectionGUID: Xp3Hq3ZbSpaXq8eVzqyGOA==
X-CSE-MsgGUID: 9QzHQZThTnavmDOoyypG1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205818"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:55 -0700
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
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 3/5] ASoC: SOF: Intel: add initial support for WCL
Date: Mon, 19 May 2025 11:08:53 +0300
Message-ID: <20250519080855.16977-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
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
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Acked-by: Mark Brown <broonie@kernel.org>
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


