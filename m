Return-Path: <linux-pci+bounces-40198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D938C30F63
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B976B4ED1F0
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E1A2F49EB;
	Tue,  4 Nov 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z3O2cBYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191F2EDD51;
	Tue,  4 Nov 2025 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258615; cv=none; b=gpLJDkwxKjMNq0zeeMJUlqMohVapWXqt1agLN9ivwiyUGp3dkrskboyITSuYDS5pc8q3lK+ZmVnes27qd2+nKR8TKyWyhOJqRphbXK7VpOTO9aixLhqXpSx3B+t7XtrcEnAf6vEAlFqrhCvCRhCdSxsaqt0w49r8bcLD4btUtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258615; c=relaxed/simple;
	bh=e9qWG6pAJn3uekCuTDcwKR/421dWGRj65u5g4S26v/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtBzDqXKoxhn7GxRtIBgMJgG4WEcULP0ocG1MP0lekqi3g7mgAlMeCFkPN2myn6Zoc/bLydVvBTi2iperS3kh12GztYEWgVegp5r9QdVtwNpVjCKu0++/vgW2mCDD7TdvxRDluL4QIF+RqkixTjYt1ACegT1ECv2alpzSB6+f1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z3O2cBYw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258615; x=1793794615;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9qWG6pAJn3uekCuTDcwKR/421dWGRj65u5g4S26v/E=;
  b=Z3O2cBYw2iBwEXOR68vesOEy0J4q+hYrpHXU1t/ttu5ahM+4UfhU/M/t
   ipSwnOMbiP0UV/9dY3zcGnvLPCcJtyNbPE4QOA7QY3ehFz0w8f+Hxv2fN
   1Nb96hDAYPyROearUF201cIJyb4241YKs1YOERDss+9nPAi5yb4VJ40Bh
   A8DhWG1UTq1wOzYCVUCn35BaWbr57EEAnXRlJDp6StLM7V1OPWgMHMD2r
   yBYkrG1lB5XUEgpd+2YMlh3JrbxvtDPm+QVduwozTQ9ZoJ8bpcwj6cbIb
   Q5yn/t4f6hF6d1SRtsgCZpJgLuMnDzc695nwpfhUIs1pgLKJk8m12rBMG
   g==;
X-CSE-ConnectionGUID: 1OyhcHXBSPqsc4ZM/bxHCg==
X-CSE-MsgGUID: cpK2T+L9Qeylha1OlBWPxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187514"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187514"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:54 -0800
X-CSE-ConnectionGUID: JSxxLS1ST+6J1sty8RoUmA==
X-CSE-MsgGUID: RBY6NLhTQ9+tfxqd5q+fRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832431"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:50 -0800
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
Subject: [PATCH v2 4/7] ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3 support
Date: Tue,  4 Nov 2025 14:16:47 +0200
Message-ID: <20251104121650.21872-5-peter.ujfalusi@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Add rt722 on SDW link 3 support

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 .../intel/common/soc-acpi-intel-nvl-match.c   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-nvl-match.c b/sound/soc/intel/common/soc-acpi-intel-nvl-match.c
index b8695d47e55b..2768dd10aaa0 100644
--- a/sound/soc/intel/common/soc-acpi-intel-nvl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-nvl-match.c
@@ -15,6 +15,49 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_nvl_machines);
 
+/*
+ * Multi-function codecs with three endpoints created for
+ * headset, amp and dmic functions.
+ */
+static const struct snd_soc_acpi_endpoint rt_mf_endpoints[] = {
+	{
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
+static const struct snd_soc_acpi_adr_device rt722_3_single_adr[] = {
+	{
+		.adr = 0x000330025d072201ull,
+		.num_endpoints = ARRAY_SIZE(rt_mf_endpoints),
+		.endpoints = rt_mf_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr nvl_rt722_l3[] = {
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt722_3_single_adr),
+		.adr_d = rt722_3_single_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -36,6 +79,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_nvl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-nvl-rt715-rt711-rt1308-mono.tplg",
 	},
+	{
+		.link_mask = BIT(3),
+		.links = nvl_rt722_l3,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-nvl-rt722.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_nvl_sdw_machines);
-- 
2.51.2


