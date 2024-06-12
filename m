Return-Path: <linux-pci+bounces-8630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB21904BDA
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 08:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25939B230F9
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2024 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2939D13B59F;
	Wed, 12 Jun 2024 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8OvalLS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98208167DBB
	for <linux-pci@vger.kernel.org>; Wed, 12 Jun 2024 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718174863; cv=none; b=Gr8xi+Ah5FLKnyR9CBZgxHQMotx6p1cho3nFqLT2MWUBtQvt31V3yoOMtNj4wa6eRpWNefVPhbWSBf5OG31SK7K1FwohlBrBz3bFcoMAM1CXxVzQIuWgyfSpKfpQNUvfdSnBxl7FE/IeND6Vq7blxafSv600pBxzWuDRasM9oOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718174863; c=relaxed/simple;
	bh=K3REjYBdhUytlfX6yr7AapN87zMzEFQ8tErxN8v8WQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WipQHZTzq/6aGI3TPcgacWg9nB2Wn1M6lrVLk2WrJq79w6Hb9OEoAWBI4SkqZ6gVllXnPBtfwpebl5p1ks7DK8hECBMyvgP3BnctWGURZxTDKCZxDrAp+sx/SiW4fayUWqYuVVSH/VmU+cA2+oMq3qATH47dx18w+MtTsi12xGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8OvalLS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718174862; x=1749710862;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3REjYBdhUytlfX6yr7AapN87zMzEFQ8tErxN8v8WQU=;
  b=Y8OvalLSQJ6jshCTHIKWP0Tqpaf8HSymU0IskaIoGGcm0BNQNTPJ0s5M
   BSn41trKL5ZLpTMyUCWrqQWvZsd8H+kCMGSC6fQd7WaTw0VBQMG4haCVH
   1ykC0oZo60XLXIW2SZjr47o1wLi5lGamZWlsjYkuR3EtjXqIM72wIX9Lx
   DMBAcMUWoFygMTZwD5FlNCKoKH7E1pVBnWKCq/dILfKT3wZN2fftF1NUt
   wdW+rPuN2GRd6YYCfma9d/qsYP1aNBb2MMJqzVdt/KWqksWEaGoU7ITQZ
   eyakR6cXVgaommlaJeH1f2PyZGgBJKkWXkLJZ9VNKtfS3DRTtgYQzh9Yy
   A==;
X-CSE-ConnectionGUID: AQLgU6WhRZuC5WMAapAftw==
X-CSE-MsgGUID: BsuN/n3MT/W825l5eRNUdw==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="15145900"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="15145900"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:42 -0700
X-CSE-ConnectionGUID: PFjMVl1zS6G5lgxo5Jy2Ww==
X-CSE-MsgGUID: xv6cDRKMRNSYOUqPFS/5WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39751245"
Received: from iklimasz-mobl1.ger.corp.intel.com (HELO pbossart-mobl6.intel.com) ([10.245.246.56])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 23:47:39 -0700
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
Subject: [PATCH 2/3] ALSA: hda: hda-intel: add PantherLake support
Date: Wed, 12 Jun 2024 08:47:08 +0200
Message-ID: <20240612064709.51141-3-pierre-louis.bossart@linux.intel.com>
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

One more PCI ID.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 3500108f6ba3..b33602e64d17 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2495,6 +2495,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_ARL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
 	/* Arrow Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_ARL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE) },
+	/* Panther Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_PTL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.43.0


