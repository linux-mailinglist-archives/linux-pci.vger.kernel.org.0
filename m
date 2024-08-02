Return-Path: <linux-pci+bounces-11189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FF6945DF5
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 14:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175E41F218F0
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621031E3CA1;
	Fri,  2 Aug 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+etwWII"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46D91E3CA8;
	Fri,  2 Aug 2024 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722602437; cv=none; b=cPnJ9G3isMpCLm7CxeLny+oCYodrpZDePKA+u+2ab+Tkqo4lGrtKF0kvEV8atsaPHx9g04daF0JqVDfInywyxul1dNJe4Ch2k7gnpnEVxzylmCHh3YZZELrHXhdVb/eVnH9aesqDsA8H2NUYrpOamVHBpQiykO4LgLt5aDK4wDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722602437; c=relaxed/simple;
	bh=tOZ91IT2s8wpY7yLumZ5kw412vfzz4MXb5MVorwZxpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlR3lz3+vbofmKbh11uRhmTYcGoo+DYGOhWrNliPADoVwbb34/etBpm6sNLVPvDIE8SfPNupEu/b2Cfs3I/mu/KCJ3xf6LblThe5Gaxi+ib9s/S7bQQ0idmgUzIH0pK64EsaW6r0INn9HZJnOnKssnKGKdOPNj+s403WenZAGpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+etwWII; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722602436; x=1754138436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOZ91IT2s8wpY7yLumZ5kw412vfzz4MXb5MVorwZxpY=;
  b=W+etwWII0BA4Sfv3iP7KYxdTxLG8F6GMsgM4QaXl79EESak76HRbUNd/
   bgNWaB3+ljp46EeGWAPBCwJzlq28T5WKtcLBacUETEOYmvFXEWvsUVkSx
   YLXILu2WdPpQvgpKkGzkChK98o7BKqXQ/Q0fM7mcmeKwlCbejXQnFDHza
   z8wRT/nX9DGGgv14VWvLQmAb84eIyZ/U0ORWV2B9do++wqgxD+U5PLAfJ
   gzJo2LkIsO/uXC2Cr7owsbzFvWVQZBdGd5IqrRGliq4s20+6w+D0iAnhy
   uQrbUX9STF5xTcQ0LuopmaUeFZzC/DGlMYOfd+Os2WsZbQ8f9+DcvwbSu
   Q==;
X-CSE-ConnectionGUID: W9aHadoaSHOnXLcmYz60Yg==
X-CSE-MsgGUID: pUSxM8bBRbCJzVByNWu12A==
X-IronPort-AV: E=McAfee;i="6700,10204,11152"; a="24488239"
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="24488239"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:35 -0700
X-CSE-ConnectionGUID: Zn29nhgER5CAHa9q/kr/XQ==
X-CSE-MsgGUID: P4ipXeDGSe2zzwsMTRhq9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="55024815"
Received: from ltuz-desk.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.89])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2024 05:40:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v4 4/5] ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca table
Date: Fri,  2 Aug 2024 14:40:10 +0200
Message-ID: <20240802124011.173820-5-pierre-louis.bossart@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Add rt711-sdca on sdw link0.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-ptl-match.c   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index dba45fa7a453..ce4234fd3895 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -15,6 +15,31 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_machines);
 
+static const struct snd_soc_acpi_endpoint single_endpoint = {
+	.num = 0,
+	.aggregated = 0,
+	.group_position = 0,
+	.group_id = 0,
+};
+
+static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
+	{
+		.adr = 0x000030025D071101ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt711"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr ptl_rvp[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_sdca_0_adr),
+		.adr_d = rt711_sdca_0_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -36,6 +61,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt715-rt711-rt1308-mono.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = ptl_rvp,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt711.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_sdw_machines);
-- 
2.43.0


