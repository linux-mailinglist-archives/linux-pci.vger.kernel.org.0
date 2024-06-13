Return-Path: <linux-pci+bounces-8712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9C906432
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 08:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8481F246E9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 06:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2493513777A;
	Thu, 13 Jun 2024 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f+DKWUrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A2137762;
	Thu, 13 Jun 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260684; cv=none; b=aGPMsiw2Pw4H6SpRW/iEFwCICyA/Q9pviEiKiQ0/+ICtIeSmnm+jXNDTx0xJ46UU7t0nBI4bbKIZFOGhpuMMe+qLC7kQjG5t+syBFa8TO5WfTKHNw1Qjxmjcqpb7t5fYhejpgmOrb7Vtw4abwRA2cAulqlUWEGIe/cOWHlQ33P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260684; c=relaxed/simple;
	bh=tqqJI6wD144Ba0q2mBEunzNzlWBhDW4D6RtTx5VSFGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT5Bowbu69A0A6wxCO0HfY2SHxBpBg3laBsRsw53sWMJVoJkqtY4IGIDnmMbSy6cBi0rAUG7TednDkRhZLNAe6Q8PQo6/D/QjjzmVnrp13k8uIakd7vh2rvQAUuZuoQp3x6Fggr9iXgC9CtlqGA/yIrXIXoQJvFeCndlj+moH1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f+DKWUrk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260683; x=1749796683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tqqJI6wD144Ba0q2mBEunzNzlWBhDW4D6RtTx5VSFGA=;
  b=f+DKWUrkb4uJ2NXE6S87OJ43vWoZAu02LRFyB/RBQrCmJ/IB4RDKomKI
   Er2G6lU+weVtWTJWdqKp29tmuR+8yqnl38sW9js1Tz8a1SfENlnPKKqMo
   fPKQK6UmSZFwEzIjEshWeh+TsgN0bp33/Wky+rGhZtfeFZvCD35/hNEsA
   lc9w2pbDA7kyD04c2ASK2vkmhSVyTQVBHlwuf83WVYAXPWKO60lrvZsPB
   XfSjxFtMLkYq0yK61dWkyD3PeBB2XnVFLbC3X7xWfo1FexzYhpODyd2/L
   ZIHRyJjj8kx35xEZl/GE61XTPl7NvBgHLyjuVcGoRjrPZWldvToFBQpLb
   Q==;
X-CSE-ConnectionGUID: MEoosKplQPWzMcIF7xRJYA==
X-CSE-MsgGUID: SXjiXj2QQsuS1VIlKOAcHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25736650"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25736650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:38:03 -0700
X-CSE-ConnectionGUID: WAnfwx61SdGA8TGKOxcD9Q==
X-CSE-MsgGUID: 6V1WgmhRTpSRT6/vgEvFlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39960989"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:37:59 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 5/5] ASoC: Intel: soc-acpi-intel-ptl-match: Add rt722 support
Date: Thu, 13 Jun 2024 08:37:32 +0200
Message-ID: <20240613063732.241157-6-pierre-louis.bossart@linux.intel.com>
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

From: Bard Liao <yung-chuan.liao@linux.intel.com>

This patch adds match table for rt722 multiple
function codec on link 0.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-ptl-match.c   | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index ce4234fd3895..d01646f52d1f 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -22,6 +22,31 @@ static const struct snd_soc_acpi_endpoint single_endpoint = {
 	.group_id = 0,
 };
 
+/*
+ * RT722 is a multi-function codec, three endpoints are created for
+ * its headset, amp and dmic functions.
+ */
+static const struct snd_soc_acpi_endpoint rt722_endpoints[] = {
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
 static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	{
 		.adr = 0x000030025D071101ull,
@@ -31,6 +56,24 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
+	{
+		.adr = 0x000030025d072201ull,
+		.num_endpoints = ARRAY_SIZE(rt722_endpoints),
+		.endpoints = rt722_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr ptl_rt722_only[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt722_0_single_adr),
+		.adr_d = rt722_0_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr ptl_rvp[] = {
 	{
 		.mask = BIT(0),
@@ -67,6 +110,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt711.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = ptl_rt722_only,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt722-l0.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_sdw_machines);
-- 
2.43.0


