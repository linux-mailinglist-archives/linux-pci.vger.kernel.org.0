Return-Path: <linux-pci+bounces-37398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 681FBBB34ED
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A2E189155E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3B2FF66F;
	Thu,  2 Oct 2025 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8Emn33b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22472FF67E;
	Thu,  2 Oct 2025 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394531; cv=none; b=BR9ABPlJ5v10I7Swjh7riDg/eJvaN8gYZHW3KKZntKUI32yFUS1Kaucd9Gufze6R8iXUne558wgtqaGbx9n2s7UdZ1Byz5jze7SozeVID/phZ4IdU/Q/gcuYr2x9QkI7Vrc2Cjo0rKGCDzsmsXYmSAEDbbS3Z4fcUXN9shUxPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394531; c=relaxed/simple;
	bh=2Sorg/RiQEhEKTQPTIDJCUqdvs3u6A4VTmejR++34Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMVcBgeJ/5/2wBYIkwGGYSlAsgUM+57mg3/9R96+nt75b5tcoTCVm2KD0fGh1L2VvzjnMJgm+JrCmEet2FNw/X07licyTOA+sNc0hkC2g4we31HidA3PDw25KWHSsd2ngcl3Wr69hb5ZuixD1IhNF/S/Byr0O7NSFCJko9JPDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k8Emn33b; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394530; x=1790930530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Sorg/RiQEhEKTQPTIDJCUqdvs3u6A4VTmejR++34Ho=;
  b=k8Emn33bknhT8hg3QsEGTvxh4bmBtPQ7iHXUig12dlGhavm8hZoDecCl
   idcEDgMd5M2ejejTdcQ9ipafiVvPUPqPtMEf/bmy7+HeOOxU7M1IlyDMg
   I5HNeFKdPCTjmaWAhbeLmMLuYimj943umFMLwcD7N2S9A7lY78/fe2/Rd
   uppZAkmQ7AcBPbWhOpbVrCNbS/XEZZoNHOi0JFrAuTv3Svs0FtdblgF4L
   6DiPR7H5D5yHRDkH/DekWpBtmfzDY8TNN//bELf3PAFUSRSk8FqE7rD6V
   0YsaTkySWIZd+cVQ661kNBZ93TfhKtq7CHYQ34HTs0im3+Jb52bG5OTRL
   A==;
X-CSE-ConnectionGUID: taCI2I9GSfCGCUci/YkAJQ==
X-CSE-MsgGUID: /jRmr2VjRXWbqMyN60pqUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099044"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099044"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:09 -0700
X-CSE-ConnectionGUID: m45C43IqQEul5HkZEZdhGg==
X-CSE-MsgGUID: e3j3R7p3RCuOhk83m5QYaQ==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:06 -0700
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
Subject: [PATCH 3/7] ASoC: Intel: soc-acpi: add NVL match tables
Date: Thu,  2 Oct 2025 11:42:48 +0300
Message-ID: <20251002084252.7305-4-peter.ujfalusi@linux.intel.com>
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

For now the tables are basic for mockup devices

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/soc/intel/common/Makefile               |  1 +
 .../intel/common/soc-acpi-intel-nvl-match.c   | 41 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-nvl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index daed7123df9d..382029724e85 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -34,6 +34,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_machines[];
 
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cfl_sdw_machines[];
@@ -46,6 +47,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_sdw_machines[];
 
 /*
  * generic table used for HDA codec-based platforms, possibly with
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 7822bcae6c69..dbfd9e2ac015 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -11,6 +11,7 @@ snd-soc-acpi-intel-match-y := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-matc
 	soc-acpi-intel-arl-match.o \
 	soc-acpi-intel-lnl-match.o \
 	soc-acpi-intel-ptl-match.o \
+	soc-acpi-intel-nvl-match.o \
 	soc-acpi-intel-hda-match.o \
 	soc-acpi-intel-sdw-mockup-match.o sof-function-topology-lib.o
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-nvl-match.c b/sound/soc/intel/common/soc-acpi-intel-nvl-match.c
new file mode 100644
index 000000000000..b8695d47e55b
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-nvl-match.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * soc-acpi-intel-nvl-match.c - tables and support for NVL ACPI enumeration.
+ *
+ * Copyright (c) 2025, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "soc-acpi-intel-sdw-mockup-match.h"
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_machines[] = {
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_nvl_machines);
+
+/* this table is used when there is no I2S codec present */
+struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_sdw_machines[] = {
+	/* mockup tests need to be first */
+	{
+		.link_mask = GENMASK(3, 0),
+		.links = sdw_mockup_headset_2amps_mic,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-nvl-rt711-rt1308-rt715.tplg",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1) | BIT(3),
+		.links = sdw_mockup_headset_1amp_mic,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-nvl-rt711-rt1308-mono-rt715.tplg",
+	},
+	{
+		.link_mask = GENMASK(2, 0),
+		.links = sdw_mockup_mic_headset_1amp,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-nvl-rt715-rt711-rt1308-mono.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_nvl_sdw_machines);
-- 
2.51.0


