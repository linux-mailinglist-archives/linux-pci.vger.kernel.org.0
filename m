Return-Path: <linux-pci+bounces-8709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CE490642D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8334B21D1F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 06:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E339137753;
	Thu, 13 Jun 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nRQmLQYu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235E12C7E3;
	Thu, 13 Jun 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260673; cv=none; b=bJEesJj/oeW+0dmzin8SwE6kbja196qvXUnz3SmEvonUsYlizzZprmMhENRK1+f8FyiXJSU5d76YebeA1ayP8uHsHE5CNG5ntdD9VbeHPQLqaAOovSZ5ddZtQowzcE0GjzVuFMWwoY3lqCjuNnKwxnSUK0eQNXqUm7/9QDj9dG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260673; c=relaxed/simple;
	bh=crewVMHSfJKgeI4smrQVHU61rtSFJP+uy4uxd/EJzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLt1MTkb0AOT/KA+PQkS0YDh+0PxUBTg3/Kyib38mdQw9IdK4PB9y4jsaACSF3je5Z7gDTg3Xhz1aHVzibnKkDFk/MV9/xM4jjine8HKfjzyXDd68az31ITMqFq+lgXhmWq0qgcwtZvKBGSLtBRjSm8x2N+SRbxSt5cOaNHn1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nRQmLQYu; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260672; x=1749796672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crewVMHSfJKgeI4smrQVHU61rtSFJP+uy4uxd/EJzag=;
  b=nRQmLQYu9jPmyb852EsbwxwDYWr6rXk+H93ghlQq+h7Fh533+1UhKjJE
   RyxVcjn9YBraFZOC4FTQ8fm5Z1V6aeQS1jftF+m9ft9AxgAb2TioI2aQD
   DjVDHGfBg+CB2VOR9HYVvYau2vxePiA7TPKBf/Y1WtgQQ+1yjFPTd+ZHk
   N6glf69fLhrCVCF99vBIGDvZiem5EwH0RYYOV7gUfdP8htnVWKI1qY27O
   knsp4Ewyok83vrQZua3nd4UwiH/sKPSoCmqfnDwrGcmgwSTpPgb63vEM0
   pGGq//2ebeaUzQ1CyDYUBCzuDl83gjLijFt89567oJFbUEAbdXjbUI4hu
   g==;
X-CSE-ConnectionGUID: XLyf34TkRY+/xEf181tm+Q==
X-CSE-MsgGUID: 1cliWiy4Tme8ubJE7MAItg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25736626"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25736626"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:37:52 -0700
X-CSE-ConnectionGUID: xNAkxfu6QjC+ZxPaNQOSaA==
X-CSE-MsgGUID: 7zl9+g3RRnyMoIPKRjwzsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39960932"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:37:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Fred Oh <fred.oh@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 2/5] ASoC: SOF: Intel: add PTL specific power control register
Date: Thu, 13 Jun 2024 08:37:29 +0200
Message-ID: <20240613063732.241157-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613063732.241157-1-pierre-louis.bossart@linux.intel.com>
References: <20240613063732.241157-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Fred Oh <fred.oh@linux.intel.com>

PTL has some differences from MTL/LNL. Need to use different register
to power up.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Fred Oh <fred.oh@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 16 ++++++++++++++--
 sound/soc/sof/intel/mtl.h |  2 ++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 1bf274509ee6..2b9d22ccf345 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -245,6 +245,18 @@ int mtl_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	u32 cpa;
 	u32 pgs;
 	int ret;
+	u32 dsppwrctl;
+	u32 dsppwrsts;
+	const struct sof_intel_dsp_desc *chip;
+
+	chip = get_chip_info(sdev->pdata);
+	if (chip->hw_ip_version > SOF_INTEL_ACE_2_0) {
+		dsppwrctl = PTL_HFPWRCTL2;
+		dsppwrsts = PTL_HFPWRSTS2;
+	} else {
+		dsppwrctl = MTL_HFPWRCTL;
+		dsppwrsts = MTL_HFPWRSTS;
+	}
 
 	/* Set the DSP subsystem power on */
 	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_HFDSSCS,
@@ -264,14 +276,14 @@ int mtl_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	}
 
 	/* Power up gated-DSP-0 domain in order to access the DSP shim register block. */
-	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, MTL_HFPWRCTL,
+	snd_sof_dsp_update_bits(sdev, HDA_DSP_BAR, dsppwrctl,
 				MTL_HFPWRCTL_WPDSPHPXPG, MTL_HFPWRCTL_WPDSPHPXPG);
 
 	usleep_range(1000, 1010);
 
 	/* poll with timeout to check if operation successful */
 	pgs = MTL_HFPWRSTS_DSPHPXPGS_MASK;
-	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, MTL_HFPWRSTS, dsphfpwrsts,
+	ret = snd_sof_dsp_read_poll_timeout(sdev, HDA_DSP_BAR, dsppwrsts, dsphfpwrsts,
 					    (dsphfpwrsts & pgs) == pgs,
 					    HDA_DSP_REG_POLL_INTERVAL_US,
 					    HDA_DSP_RESET_TIMEOUT_US);
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index 7acaa7e724f4..9ab4b21c960e 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -12,9 +12,11 @@
 #define MTL_HFDSSCS_CPA_MASK		BIT(24)
 #define MTL_HFSNDWIE			0x114C
 #define MTL_HFPWRCTL			0x1D18
+#define PTL_HFPWRCTL2			0x1D20
 #define MTL_HfPWRCTL_WPIOXPG(x)		BIT((x) + 8)
 #define MTL_HFPWRCTL_WPDSPHPXPG		BIT(0)
 #define MTL_HFPWRSTS			0x1D1C
+#define PTL_HFPWRSTS2			0x1D24
 #define MTL_HFPWRSTS_DSPHPXPGS_MASK	BIT(0)
 #define MTL_HFINTIPPTR			0x1108
 #define MTL_IRQ_INTEN_L_HOST_IPC_MASK	BIT(0)
-- 
2.43.0


