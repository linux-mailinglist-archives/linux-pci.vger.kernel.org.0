Return-Path: <linux-pci+bounces-9790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE84B92722C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D231F21EF8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 08:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF51AAE1E;
	Thu,  4 Jul 2024 08:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rsh0CDXL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEAA1A4F1D;
	Thu,  4 Jul 2024 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083247; cv=none; b=OwDVJNvggyJuZgsiCkPyLp83CQhScVPphasvACKEGpelLsJ3AaFL8anKSnhBTDFNp/PHlHTaht4F6UR/b1APw1Jho8SmH3kXY77C7nikEyQv+k7UOLqwq+bHz8bxpDKPLl+ujTWAMN1m3+/6gXSkMyuTeoHE0NlMwaBpLuiqAwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083247; c=relaxed/simple;
	bh=bfvc5FLaFeKYhbLLxS6MoY6PRX1DIf6hUoi6GjD3luQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DefGU27CLekxB6WHKEQHy8tBU/j0NBdAsbh52BrUgG2zsdzkl6OWZaqAvIU0TVyGS0FdwroIpj8nFwlwZEZnt8uv5ayiApsllPJY0N+ZPENX+dMcL19k/cA42C0/O+eGKhOpo6MnTbuT2lqKGlFt32CY27i1IoNPI3SJLunykWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rsh0CDXL; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083246; x=1751619246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bfvc5FLaFeKYhbLLxS6MoY6PRX1DIf6hUoi6GjD3luQ=;
  b=Rsh0CDXLhVKYGa8bZT+FswkLSQ8QPXdaG2+Ft2MX6TBVdZJmqdocbg5E
   gNg6XVxCibEZNpbAL0tJ2C4GhsM+cLT5VEyIdwCJ9TZrqJ3xMAbQ6JVzK
   /EXxlYMgMre6huAiPABw291DGMEfvgMnPko6UN6Ii3EqztJesRzNsmyvI
   Z02KXu4TtZL9EHlqXAPN4auC25es6htQoRU3LPrbtyApFm5IWRVH5dCBw
   Gj4nF+yv8nglS0EkHEugwMyomIcQ0H1qwLUnFVmGkT/dtPK7rGsKSon9h
   Z+IuRQW3cZ8MSbiONyNtOBWAC/EnUznIZyn0nUX3+j4KlT4t5Mn4sKFaG
   A==;
X-CSE-ConnectionGUID: hlREBmXqQjeCenH+a+efrQ==
X-CSE-MsgGUID: UaYV37lMRjeUur9Ha4eSiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17300638"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17300638"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:54:05 -0700
X-CSE-ConnectionGUID: 3mW3Ax9FR7CK9fSQbNPv/g==
X-CSE-MsgGUID: pQGtUe3PTnqCpJ8HA0ipnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="51708624"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 01:54:02 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 6/6] ASoC: Intel: soc-acpi-intel-ptl-match: add rt722 l3 adr
Date: Thu,  4 Jul 2024 10:53:30 +0200
Message-ID: <20240704085330.371332-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
References: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Add rt722 support on SoundWire link 3.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-ptl-match.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index d01646f52d1f..8a0c3aa8efaa 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -65,6 +65,15 @@ static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt722_3_single_adr[] = {
+	{
+		.adr = 0x000330025d072201ull,
+		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
+		.endpoints = rt722_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
 static const struct snd_soc_acpi_link_adr ptl_rt722_only[] = {
 	{
 		.mask = BIT(0),
@@ -74,6 +83,15 @@ static const struct snd_soc_acpi_link_adr ptl_rt722_only[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr ptl_rt722_l3[] = {
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt722_3_single_adr),
+		.adr_d = rt722_3_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr ptl_rvp[] = {
 	{
 		.mask = BIT(0),
@@ -116,6 +134,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt722-l0.tplg",
 	},
+	{
+		.link_mask = BIT(3),
+		.links = ptl_rt722_l3,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt722-l3.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_sdw_machines);
-- 
2.43.0


