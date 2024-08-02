Return-Path: <linux-pci+bounces-11187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BC2945DF4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 14:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8ECAEB2341F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483641E3CD2;
	Fri,  2 Aug 2024 12:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bJrx7IAR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5E1E3CC7;
	Fri,  2 Aug 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602431; cv=none; b=SCAtrlSeXJt6UD4kpa4o8+yn+f2n5mxaQ2y6YW2L90IcRAdTwfaUP8S21I72dW84/BSqCB1roFH0AFXoUz5J36ZW2lGfsv8+q5TD6JDKRgup6NoTYeS2ihR7oe9I3Iw6UZvg4sy4yFVAhyv9JpgH3Rf4Mrwgc6hasJUrwZuCWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602431; c=relaxed/simple;
	bh=BA+rQmWVZoNfcwVjU2aaR/O56oHGO4Ts62YtTgNThgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oso0IhRVkfsl3NclTKesrT+S3+I5KrIaVfn9S0+ICNJ0ZxZ4ol7ZYux5mvzoR6MX3BG32883+vW3/4XSmugALC2VtFxz90LRVTFCvKdSNS4tDt0ZWINz0+qjhXs3OJuR1UZTcaplB5DDDlP56oeAYsPAlcZob6O6ulZszsnSWbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bJrx7IAR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602429; x=1754138429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BA+rQmWVZoNfcwVjU2aaR/O56oHGO4Ts62YtTgNThgw=;
  b=bJrx7IAR5anFJxgaakS/EGiaLfD77CMFj94wzHG7OUrkkEzSn/J3mehc
   CxKZKLDnDHL6N5+tu5wweqQ4Mh3FNfzEX5QQ5FWguJU/JIBPdyXPx/hKW
   bdllcybNcHkM7Rg5IfRufZGVb3tudsZ8GtWlNvcm8CyFffC877V5NIqv2
   4uaBbB9MOEqXSvfgCViRo/Rb6N1YoQ7CMF/GiLRxadps3SxjN0bo3/xm5
   MGt/oq9JVlRUr4up3fMRsQJU7PVuQsOsHpGmi3nA5BJpVFQJrQm+85dQ2
   VLxHK+NG/zzZyTBtjEgXHnQwazBpI8oA0POzkADzZbh2rg1Br88Z4u27G
   A==;
X-CSE-ConnectionGUID: bMy/ph19Tt28LKM3jnILHQ==
X-CSE-MsgGUID: 0sOy+lyUSSSjTJrHpykyOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24488198"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24488198"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:29 -0700
X-CSE-ConnectionGUID: KbuZj4uFRfmqHtlZLcADWQ==
X-CSE-MsgGUID: wIP/GcPsR6m5HSpX+o+NQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55024750"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.89])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:26 -0700
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
Subject: [PATCH v4 2/5] ASoC: SOF: Intel: add PTL specific power control register
Date: Fri,  2 Aug 2024 14:40:08 +0200
Message-ID: <20240802124011.173820-3-pierre-louis.bossart@linux.intel.com>
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
index 24dcd8a3098d..e767de085f04 100644
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


