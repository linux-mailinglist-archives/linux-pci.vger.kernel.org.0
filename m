Return-Path: <linux-pci+bounces-9787-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C99927226
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264461C2405B
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF1B1A4F1D;
	Thu,  4 Jul 2024 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iL6p2oPL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2847C1A4F30;
	Thu,  4 Jul 2024 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083232; cv=none; b=ASQU3EbX/v7pFiofBt+LN9/Wlbw8/3/rdOeVj9qUhevQCbeWeT01x7d3H8ENfPFPMjY3KqRSZPzIUAQwO2HwTVkzaRHQl6mevmA9BLp9Z88PAimULDD5Vc9mf7EUQ0CjwsFWWMLe2fryvxgUfdNL+qS1wwhEbAtXDfeeB/ZNKAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083232; c=relaxed/simple;
	bh=crewVMHSfJKgeI4smrQVHU61rtSFJP+uy4uxd/EJzag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaxN4zox9YLUm1gaulMiiS6rkOL+UrvNH/4Tm63IufrtgpRDv+2up0Rcgo0CZSxb5km7zbBCeknvK/yK6uMzQPioW2uzXjctlnjRESbrSdYT7f4zjvhpebNZLaFlr3PoymTPhEq3D7xsUz5CaPkgKMuq6M0vQVtsa0v8ma5xUOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iL6p2oPL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083231; x=1751619231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=crewVMHSfJKgeI4smrQVHU61rtSFJP+uy4uxd/EJzag=;
  b=iL6p2oPL+IsA3+ojMtRHpDSH5efpDrHnRUIqHrxLlmgVHBeyV5h3J1Rd
   zFqrtgsm8kcpcuf/HzUY0J8QnjgASN3OTbxCRUmOdpx4EPAMRNmNskpoT
   Ngt4T7/TUvZNnLvYxD9+bHqO2LRQjoRVad7yb7on2X0KCub/bwbZrwJaE
   owD32k4/jvxabcCmwWX2Jlsmtb7wQ2w7iUpWIb+pf/9aQpn2joyCyPbXy
   +X+UlnEicuU22bjacIOiDQTKajsMzpf8O0lJv9eBoZ3CaxT+jXf7y9QmO
   aHR0kWz04d2bPN11lLATZIfoimjmp80PLvaIPIWqktxS5Xu7jVIcjK8j5
   w==;
X-CSE-ConnectionGUID: QBd1XYW8TjWLTsRM52/H1w==
X-CSE-MsgGUID: 2at1tDSASrmxcLx4yjJDLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17300592"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17300592"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:51 -0700
X-CSE-ConnectionGUID: jpnv+CFOSx6voTmE/0CXyA==
X-CSE-MsgGUID: mXr4xFI8ShyLO1fuHKR1yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51708523"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:53:47 -0700
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
Subject: [PATCH v3 2/6] ASoC: SOF: Intel: add PTL specific power control register
Date: Thu,  4 Jul 2024 10:53:26 +0200
Message-ID: <20240704085330.371332-3-pierre-louis.bossart@linux.intel.com>
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


