Return-Path: <linux-pci+bounces-8631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8773904BDC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353C6B236F6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1159D167DB1;
	Wed, 12 Jun 2024 06:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9VkT5MM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C325167DA4
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174866; cv=none; b=cIkINrwwjaEZXp5njAemTMIpMEJ2kO0ZAatDmyjQE/Yfehm9AKYY0Me8EtzDOM5t3v2g73euEFhOidDssXnYsRpjgVgqg6TfD98lZb23hoVnzkfTE/YG8vjoF7N4droHWo8oVxACndD2wwOMm4wKKXsK6VwiaaverR6tmDuHV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174866; c=relaxed/simple;
	bh=IzSgx2C25j7P87Yss79wU23sCxQ9oZ4wST9PV3CCwTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAnX1783GbAwZMySopViJRxzp3iU4OAResWydpu5+jCKBx6qIfrVPBN+W8ZLgbBixBbCHmTMWtzXE87vVNiCTd4pB5EJ2M704vO0NCwJVd+SG8q8pn3r41A3CT5VW06yZQ6oc+vPr4/umn00HDeiN27bB7vUDFrcVJjsFx4P3nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9VkT5MM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718174865; x=1749710865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IzSgx2C25j7P87Yss79wU23sCxQ9oZ4wST9PV3CCwTw=;
  b=f9VkT5MMBomrlYiKbAbmT/510oUqJ2/1JqdfCPAfvn86BsxMp/bDjhzu
   8AEwH7JoqcIMxgGYnCoWauwoRLUSQMY91Y1AJ16g+2VrQUJ+XCRdJbOvd
   MdFGDtW+l4gXW5hnSk7FBof6hNE9GtGr+90uovxx/9Mudzkykb833ZFDr
   4vx6azO9TnIYViVMLsqk9iorQpiFYFMpD6xMH7/EtS5sXruUvjh+IbwSX
   GK1yRBE7a0Gb7sM1m3Ep4LFpWgv9PtBE6+4MfjIATBu89judHDxQfXl2D
   J2c6bVTuNnLrNvzaneTe5MvHw3I/uhGOqYbIoorUf40IsQrOn6qS1cw8v
   g==;
X-CSE-ConnectionGUID: uwebuCpkRySc2BJJWiHFLQ==
X-CSE-MsgGUID: I9QSXEZrQ+WYJNRfo6JPcg==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15145911"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15145911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:45 -0700
X-CSE-ConnectionGUID: x6KdkC32Qb+Bl0LoDPrViA==
X-CSE-MsgGUID: UxuUA5PyS6Oo3mafkVf2/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39751287"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:42 -0700
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
Subject: [PATCH 3/3] ALSA: hda: intel-dsp-config: Add PTL support
Date: Wed, 12 Jun 2024 08:47:09 +0200
Message-ID: <20240612064709.51141-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
References: <20240612064709.51141-1-pierre-louis.bossart@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Same recipes as LNL

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 537863447358..a7419d2e912e 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -543,6 +543,15 @@ static const struct config_entry config_table[] = {
 		.device = PCI_DEVICE_ID_INTEL_HDA_LNL_P,
 	},
 #endif
+
+	/* Panther Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_PANTHERLAKE)
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_PTL,
+	},
+#endif
+
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.43.0


