Return-Path: <linux-pci+bounces-37401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF5FBB354B
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A9D1C2E4E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A56311C1F;
	Thu,  2 Oct 2025 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5+U2mRX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C9E2EA461;
	Thu,  2 Oct 2025 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394541; cv=none; b=hYLuDXLd0iAXviCosbn+MKV1dFUoTw6GerEAuTC8NAar0tTyR/lkbG+R+T8fhz61HcEwikXZQMsZSW4Mht1nZIzsjveiNifuECcAEpqnCTys6MJrVhBpkvSpgen/Xb6ktPndfI24loCGP+J3UUpS827XdG3E4HG21JKNaCED8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394541; c=relaxed/simple;
	bh=jXmyIuR/9eoTdHeCa7peJ7wUFzj+YZQv0uae+lMfdV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJuHw5ET+47Marva5ZAXWHeyOQTCUsN7JHqPy7vJM4wF7pOHdgv6TRmXbU2N+UX4n/jUWHxYx9vEf0oNJ0Fv4oTMovxqBAeAAOHTsoBRbT7ce5KOJb5mo3LvNtgpEBqgUc2VculuJXf1rStnxUW0WNEmPe6ELHx5/1rPzE2MksQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5+U2mRX; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394539; x=1790930539;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXmyIuR/9eoTdHeCa7peJ7wUFzj+YZQv0uae+lMfdV0=;
  b=C5+U2mRXdWwRjsSLUTLAKwrIM25ncey/OHbP6TjQrGuQ7RlTad92wNE9
   LFmXnomm40DRSIFT9h17/oMfpkVUkogh+PtLuOzYAharvrAZLyTvvlWT/
   WICnh5vD6LNwIpnpqhEdM3I3R3HH4zWwfRX5WAoxrWRVkrGi1vYlR7NQg
   G5PA9/OZStPwB9j07FtLJPkyUcQpmCdT6jWVsfOrWqTaIvJc5j3jvjWTQ
   NExN0pfYh15YgPFHw+KoeiUzZV6VOhQgMCp0MpMJzZGZu3pnry8g/OLwm
   AwvnpGfdrZQRBzn6CRG4wRnjSuxErGCp6fuV+1CpHEFWKNqtJfcsvNfCp
   A==;
X-CSE-ConnectionGUID: 2CRRfpsTSZGULB9E1oMfcw==
X-CSE-MsgGUID: nMFIVF9JRyiPE75VEIGhuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099069"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099069"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:19 -0700
X-CSE-ConnectionGUID: 3YJP1mNjTnarpcD0mtMGUQ==
X-CSE-MsgGUID: wkog0VLWTiSywHrKFkLqlA==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:16 -0700
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
Subject: [PATCH 6/7] ALSA: hda: core: intel-dsp-config: Add support for NVL-S
Date: Thu,  2 Oct 2025 11:42:51 +0300
Message-ID: <20251002084252.7305-7-peter.ujfalusi@linux.intel.com>
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

Same recipes as PTL for NVL-S from the Nova Lake family.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/core/intel-dsp-config.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index 2a9e35cddcf7..c401c0658421 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -578,6 +578,14 @@ static const struct config_entry config_table[] = {
 
 #endif
 
+	/* Nova Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_NOVALAKE)
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_NVL_S,
+	},
+#endif
+
 };
 
 static const struct config_entry *snd_intel_dsp_find_config
-- 
2.51.0


