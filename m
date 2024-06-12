Return-Path: <linux-pci+bounces-8636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C68C904C2E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125E21F230D9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8A1156222;
	Wed, 12 Jun 2024 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRzQjT7Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C933FE
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718175574; cv=none; b=Cxboh1pYBeifJG/HFRbIz8yYomIkvDOcQn9klIs5+oQFJmOm9ipmXaaeDjx05buY67mjXICEsZzga4Pm6wgq00JepIhHtbu0xO9pmBcTlXeLJx8RM0w+a5D4sfvzNoswVsFL8NPbbeDMmGA+ie+jzbiZ5Ql4rMlDSFFFMAsLOmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718175574; c=relaxed/simple;
	bh=JIOiMZEDwaqSLxMoTfruo+yYfdbcow0kQHxJBoAbvfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJPseo18rDLvcVkUQpKtpizT9HPFXm/YCaoUTpbiZMAXd04iFMa26Gzm87+WWn7TsPJzUIKuMMbKEOoC3ODW45PT3g6peP8AFzAnVzKKL2hV3Lywwu/3FaJ/C8/lHo96EZ72oqk/Br9sVPGBOKXVLuYccA981K9GH+CWkOq/ujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRzQjT7Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718175573; x=1749711573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIOiMZEDwaqSLxMoTfruo+yYfdbcow0kQHxJBoAbvfw=;
  b=KRzQjT7Yfb5Rz8KaWcxm6J/nM8f0IvGXDqs5dsIFrEsJp4Rm7F2sNKsk
   QbXqz5IahkDypjf0SPGZNjD6cHIQ/VHK96sQvsPA1togvOcicwgF38Uqx
   yiZ7AD+wKqRMJ93M8MaYrf9ybnrpzNzTt3ihrCCfvFASCjoc6GjKAmhq/
   tUxV7BaeGow+TbjnCd1lW5Mfnl6IK9MadnIniDMeZLynk3Wk7hFqqMugF
   2CP07LNDU3O97AZlpQBLi4y2BImuQAxmHs0+aVdj+dE2njuU2nGXLtli/
   Y/wgsXCuI2zpvkszXII3KTzd3awcMXEIjGA6DA71fgcwS6CqF1LcNDt0h
   w==;
X-CSE-ConnectionGUID: ZlG1L9duTReXe/nIN/dQ2w==
X-CSE-MsgGUID: 6JuHbxeWQ1CKu4kkAzsgiA==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15147439"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15147439"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:59:33 -0700
X-CSE-ConnectionGUID: oS8CGpk6SvOBozNq5yyDrQ==
X-CSE-MsgGUID: jUmtxlBfTT28fepGiQHBPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="70486890"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:59:31 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 3/5] ASoC: Intel: soc-acpi: add PTL match tables
Date: Wed, 12 Jun 2024 08:58:56 +0200
Message-ID: <20240612065858.53041-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
References: <20240612065858.53041-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now the tables are basic for mockup devices and headset codec support

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi-intel-match.h          |  2 +
 sound/soc/intel/common/Makefile               |  1 +
 .../intel/common/soc-acpi-intel-ptl-match.c   | 41 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 sound/soc/intel/common/soc-acpi-intel-ptl-match.c

diff --git a/include/sound/soc-acpi-intel-match.h b/include/sound/soc-acpi-intel-match.h
index 4843b57798f6..daed7123df9d 100644
--- a/include/sound/soc-acpi-intel-match.h
+++ b/include/sound/soc-acpi-intel-match.h
@@ -33,6 +33,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[];
 
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cnl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_cfl_sdw_machines[];
@@ -44,6 +45,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_intel_rpl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_intel_arl_sdw_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[];
 
 /*
  * generic table used for HDA codec-based platforms, possibly with
diff --git a/sound/soc/intel/common/Makefile b/sound/soc/intel/common/Makefile
index 40a74a19c508..91e146e2487d 100644
--- a/sound/soc/intel/common/Makefile
+++ b/sound/soc/intel/common/Makefile
@@ -12,6 +12,7 @@ snd-soc-acpi-intel-match-y := soc-acpi-intel-byt-match.o soc-acpi-intel-cht-matc
 	soc-acpi-intel-rpl-match.o soc-acpi-intel-mtl-match.o \
 	soc-acpi-intel-arl-match.o \
 	soc-acpi-intel-lnl-match.o \
+	soc-acpi-intel-ptl-match.o \
 	soc-acpi-intel-hda-match.o \
 	soc-acpi-intel-sdw-mockup-match.o
 
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
new file mode 100644
index 000000000000..dba45fa7a453
--- /dev/null
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * soc-acpi-intel-ptl-match.c - tables and support for PTL ACPI enumeration.
+ *
+ * Copyright (c) 2024, Intel Corporation.
+ *
+ */
+
+#include <sound/soc-acpi.h>
+#include <sound/soc-acpi-intel-match.h>
+#include "soc-acpi-intel-sdw-mockup-match.h"
+
+struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[] = {
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_machines);
+
+/* this table is used when there is no I2S codec present */
+struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
+	/* mockup tests need to be first */
+	{
+		.link_mask = GENMASK(3, 0),
+		.links = sdw_mockup_headset_2amps_mic,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt711-rt1308-rt715.tplg",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1) | BIT(3),
+		.links = sdw_mockup_headset_1amp_mic,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt711-rt1308-mono-rt715.tplg",
+	},
+	{
+		.link_mask = GENMASK(2, 0),
+		.links = sdw_mockup_mic_headset_1amp,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt715-rt711-rt1308-mono.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_sdw_machines);
-- 
2.43.0


