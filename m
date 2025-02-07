Return-Path: <linux-pci+bounces-20890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88025A2C3CD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 14:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C00E7A2E98
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA471F790B;
	Fri,  7 Feb 2025 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PaWzsaRq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447E1F76B9;
	Fri,  7 Feb 2025 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935430; cv=none; b=BZ3RWDyPvL0Qjc/7J3qZZu0Jw087eb2LfTR1GGLMWbLMHWCWlM1YWym1n5ODspTTBa4igMW4GdIaoJ6XY7oWcmeWVLfyjiKj96AU3+9RA18wjM/TDpQCg/KwtV764ZyPI8REiKO0A/+jXTPyoERFt05Y76AzgG1rVKu8o9N3BqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935430; c=relaxed/simple;
	bh=uDbDsKJL9Pt6rvNx4GiTyLq3KPtd5RqJFNdz0VfHn6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwnojsGvqpN15EpkoIipuTdDKWLrktSOBMjfsfd4jYvqOtlIqrBEk2CxRmjiXt5vmkIb5E0PSnyKIwzz3CocQg6S/tt67VTS2LOrs63qQqHcSiN+mr/SdaeMG4vixRRquo1aTawtpSedzmaYYD+7KtRI0CgS/Zou2Cr/sQLQmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PaWzsaRq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738935428; x=1770471428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uDbDsKJL9Pt6rvNx4GiTyLq3KPtd5RqJFNdz0VfHn6I=;
  b=PaWzsaRqHx/iFI0aX+uF999zHx3cgh0jxcdIhxKXLX3mHHJ/+OD7ks+3
   UmTgqaZ0RHU+gNOm4vXH4vTVV61QlB9G+OhyWpBYT/w8dPUlS8c8yxMSj
   zHFn9MZO19qyx+P1+Qd5X1iSW590/xJQUgKKPPNPuBT2+gxNRnqvhY9jZ
   B4ASl/naixBt1Ji+kGIvpNqtMx3FX/Jbje2m6EhtmvAnJS8l0xMrh4v1P
   7m2eOUJ1JS0ZO9pH88aDVPEdZboh71Iuc5hq6JwFJxW7/AsLcJ6+6ZvdI
   1nSs+Zh6zC8CJJ7qP8XCaM8fCM/yzy/oPVvuiw8eJY8KE1tFKAPvr+het
   g==;
X-CSE-ConnectionGUID: Tea3c/uPQSWA3jGrQMj//g==
X-CSE-MsgGUID: IL2tnUgyTCCjS4IFoqvG1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39268430"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; 
   d="scan'208";a="39268430"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:08 -0800
X-CSE-ConnectionGUID: kAwZZgdiRjW2mFIFTI3Xxg==
X-CSE-MsgGUID: Et10LmcyTTKib/aN/4vVFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="148739862"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.100])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 05:37:05 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ALSA: hda: intel-dsp-config: Add PTL-H support
Date: Fri,  7 Feb 2025 15:37:34 +0200
Message-ID: <20250207133736.4591-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
References: <20250207133736.4591-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Same recipes as PTL

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index f564ec7af194..ce3ae2cba660 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -539,6 +539,11 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_PTL,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_PTL_H,
+	},
+
 #endif
 
 };
-- 
2.48.1


