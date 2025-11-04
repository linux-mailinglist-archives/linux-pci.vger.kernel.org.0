Return-Path: <linux-pci+bounces-40197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2BC30F60
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9133A9027
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552402F39DA;
	Tue,  4 Nov 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6G1dGU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D152F39A6;
	Tue,  4 Nov 2025 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258612; cv=none; b=uwmx+/aLBRrpwafjJcPnYUSBpuyU8E55m11ACv+YpxaoiFCxZXuG+TAopD8391pIeHSkyUsbhs1MMZUkscFt5IDeJet3lp6cnAKFHyj3rukXSfKALRdc9qmnATNnAjRVipCGAaaXbzxVMoURYXterRBmf6frj//jKFmqtdm/H24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258612; c=relaxed/simple;
	bh=sJMBrTMskpaQ6mNOVtkzHEIrzvGML3+K5h1B1Fb9Bgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeSojlGaK61nPbPNFk50gLqGNY31ptaSjgic79qOd1Q5NEOiyWmCH6E08RO+bnntuKraIh1c078ZCR1/iNzTgqtDnkR/sBshUiU1P0Qn4QCFx5fDJSxW4MIFGOT9dkeS14FOVTcCUIJaV6LtmnBs9SzzAq1DUzS/9Ek4C5pmUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6G1dGU8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258611; x=1793794611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sJMBrTMskpaQ6mNOVtkzHEIrzvGML3+K5h1B1Fb9Bgw=;
  b=B6G1dGU8MaHAVSg9K4RO0PPEfEMuvUhM1/gTkhQJfELt1usEFLPGSpyd
   SFXnElcPpajSQoI5AV81qO4RCLe0Qxb+M72mgA43rFhULPtaNn4LLqOWt
   kJC7mKb+jdizO+YqtNm4bhX5AUP98jB/gugDY5K4FADYHyTHrdajtoe6d
   TBegDgpBIiqdv5FeXasxsSXtrpGEDf/xoKNyyg5KnSAtu3nReyVrJu0wQ
   i7ld087etKvk4vzw2iHknMHr8HvLqXk1gMny7Ii94dS80UCS/QUxI3k5b
   gkUZA3T5ThjCizxRmvZXsVlC6cYqmn0oMePzCuJ7ca87ToJtFpmqbdAXy
   Q==;
X-CSE-ConnectionGUID: G9ZwG2QPQDG6AEOBcS81lA==
X-CSE-MsgGUID: HQv1cpXtSJGWGyHG7PvJQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187510"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187510"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:51 -0800
X-CSE-ConnectionGUID: 6jinrGD9RwakaROytdgv3A==
X-CSE-MsgGUID: JWdAI2zIS+mRixhIhWJJLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832428"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:47 -0800
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
Subject: [PATCH v2 3/7] ASoC: Intel: soc-acpi: add NVL match tables
Date: Tue,  4 Nov 2025 14:16:46 +0200
Message-ID: <20251104121650.21872-4-peter.ujfalusi@linux.intel.com>
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

For now the tables are basic for mockup devices

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
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
2.51.2


