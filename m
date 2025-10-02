Return-Path: <linux-pci+bounces-37399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EBBB3467
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEDC54E15FF
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365AE2DC332;
	Thu,  2 Oct 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sb4a4jU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243BD2FFDF9;
	Thu,  2 Oct 2025 08:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394535; cv=none; b=BDv0JF3KD0mH6u2bjm3X94riOzqnC2Q19ZOkwzRPPC0aFgwmITMDS3haliDb+N/2mzIbyjzwgyfnWQyG8AoPj66/b2QIl9w6cYJyJ7TNG6/l/o6zE8hjdwq6oaXoNc02V3Y5nRsKTPycvL6Or6mZux1vUmBJsO4HfqLzJN5sFXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394535; c=relaxed/simple;
	bh=AzanBTqTzCJelb9EBVbHr5IKxq7TQvQd5rNG05hSYZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALIZfP8aAo2x1O7Kte41iueIGp0mr0i/zmN0DdeH9IkSZszsF3IrRFYSGjoFacfFSihSFktn5Ed7C3pc/zrq9IXIrGlZvH5+Cs/a+RcDK4hMMjqKyPgs1lHeZpSGS04daajOs8dWyKipGT/fQLrO/wn/XVQhB0RL8O0yMhRB6ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sb4a4jU/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394533; x=1790930533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AzanBTqTzCJelb9EBVbHr5IKxq7TQvQd5rNG05hSYZA=;
  b=Sb4a4jU/h2JBa9vLtoZk6qq5GyoXFBxQa3qfR3sizyiy10gwr+7LeD5a
   0ludWCXAMEli/3xXfUiGdWmN+kustyDGww1pcSeChbGWrMIWo1le0kZoK
   VN28g/gPMO78PCJCdBjz3w7DVq5s6RfB/UHoGayMLd93j4Tyh6BYfjwhj
   uonq7fpA9QPGZrq0RiNgOA7kKNbOzyATrSHbph2PAP0/j2lfRrclvrkeW
   8W3eJhbYCiNvuS6IXQYsf2fReoxt2ge8uFMfR7RXbgUt4t2s6ifB0q8Fq
   z5ZXnyBtOgt9A9VzaV7lSR1g6Pet3KRNZgXFKVOaJC/ISFOvjV/xfX87C
   A==;
X-CSE-ConnectionGUID: PMOQbwYZRpuFgTMzlW8zAg==
X-CSE-MsgGUID: wUsj277USqy/06L1W+8tJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099055"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:13 -0700
X-CSE-ConnectionGUID: 0bhOfj+YSjmBIg7JX+czfw==
X-CSE-MsgGUID: OkMZoOSuSzS3PAI0uQ/MXA==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:10 -0700
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
Subject: [PATCH 4/7] ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3 support
Date: Thu,  2 Oct 2025 11:42:49 +0300
Message-ID: <20251002084252.7305-5-peter.ujfalusi@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Add rt722 on SDW link 3 support

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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
2.51.0


