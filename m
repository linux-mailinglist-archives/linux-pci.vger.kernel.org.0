Return-Path: <linux-pci+bounces-27458-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E10AB020A
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 20:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05CD24C0A07
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415E7288C02;
	Thu,  8 May 2025 18:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfszt/cY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE24288518;
	Thu,  8 May 2025 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727312; cv=none; b=p7bH4gzFEKLVjsHdcytsuOIMH+VGY9oRW/jMG/ONmXdhj9154+OGNJfJvJiusR3refevbLt2IRMP4OiFUsZo9UQIpZJC8CaZIo2yaZbDk9j/NlN4yoUvqShT3+x2Stc88zIjchjwd4WXTxY+ELR+giga8knIx8mz+SsMSL+iMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727312; c=relaxed/simple;
	bh=ehFxWUrbT3YWqTFalCMXY0iphytkrmBdGariop9qgoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lqZVmrOVfarQyoawVDC33y/B1Lc0prQWn2FCzgQauQhgwLHsPAfFxZF9M9/6FQ5ebytQSFj1CKxuyj5q3KpRNRd9ZdPRTj/cdN+MJOlpDvkxdBxg8gZqlJzgEIIrAFIUxWs9bczJuSdMegmnC5OakaSWVHgVmeVClmFHuDgfI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfszt/cY; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727311; x=1778263311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehFxWUrbT3YWqTFalCMXY0iphytkrmBdGariop9qgoA=;
  b=Vfszt/cY4t8gPVigoeQqFbipTXpJTbShl5Wh60RH0mD2RwHZ9bAPSEVe
   dAeaw2iRtrg9akN5S4oFd918FLL5TnXG38pcEEDRmWsIYn2bniz89XGdR
   ERA+L/3XDjIFrG8pA0L+NeEPXWLbgwXUxDM6G14SLFkN8BGITpwDQ0qrV
   WtBXtJ8zI07i95f7niOvCptWtdDcWmK913350goHu9wBMi5j+kF/++pru
   2QgXeHft4AI3WfGgVeDlgCJISpysZiVaf90LLZPgzJUAqArVXr6ycBmfS
   UP+pcw/C0jgfIEQLuGXomlx8Nrt+aqzZrHjpJ4/59bXNVXZH3rhvtHeo3
   w==;
X-CSE-ConnectionGUID: KrEO0JuXRPGk59q/wJloxA==
X-CSE-MsgGUID: ffG2B69pTXG0eD57EMxKfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59160567"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59160567"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:50 -0700
X-CSE-ConnectionGUID: d67FeExCRz+rfcibuzaCwA==
X-CSE-MsgGUID: J0VUXLAGRuy9lz6uarfRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136311440"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:47 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	guennadi.liakhovetski@linux.intel.com,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ALSA: hda: hda-intel: add Wildcat Lake support
Date: Thu,  8 May 2025 21:02:40 +0300
Message-ID: <20250508180240.11282-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One more PCI ID.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d7651a75c629..e6df706f740d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2549,6 +2549,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Panther Lake-H */
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Wildcat Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.49.0


