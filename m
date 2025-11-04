Return-Path: <linux-pci+bounces-40200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F12C30F72
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F2273B0D4E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FC2F5A02;
	Tue,  4 Nov 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mFqTSa0I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80BE2F069D;
	Tue,  4 Nov 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258622; cv=none; b=EtleEZiavnVmWAEz2+E96+a/0+7wzkJ4YF1iq6b8Tm98DcvUUgXw631sq4nD8ryYnif8kgf+TUVsPQcDQDC3DrS9+ZygEVAC6KLSV6rBU9d1cP8TiV5qyLEfVu0aviZo8hrzVe+c7x78j9SAqUI56aOoVXJJy+OqQytSiZ4zdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258622; c=relaxed/simple;
	bh=qWDuEwog8fVYRXWfLFOuxlRDVk0i28brnfFqrDOGOz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksY597grsQE/pGXEKQtBYLZy8ytTdJF2M280aIpDyaVd21l5KPXzPEm/cF/70FyW3Bno/MZ5rFfMaWJTERo+212gFdBtzt31eiVzBicwchL7uwph53nsV58cc2asy37f5wU4dr2CsKbH8zkkChRbundYJvSqkyjMAc76H97uJ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mFqTSa0I; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258621; x=1793794621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qWDuEwog8fVYRXWfLFOuxlRDVk0i28brnfFqrDOGOz0=;
  b=mFqTSa0IHBgDv/wr0Jm4tdmHwZogz2mPToRktyvkRqcvZfttpdiQ+8d6
   T7VzqDgstw5RxSvREYtxFR3Xeu518wFPdN3qpxQikcMoH0pqCgd+J9VZB
   53SXZeMXlFIWy/oDa/cfhLIbT49OBbcZ9QHeuuAc1B0T0MklBWMnaVrk2
   RRqXctMSHPWrDts0OxkjqNPgBPrIkV7k6lAyf2h3jc6QSJB3yA9uLsthn
   sb2QYgrBUa3ZxUYoxoY3QenKBbN7b6NCj+iGD3rqu1E40GlGaLE5DK+hf
   0k9RyApsvZoumkIsRkqDi6dJ8tRPosTh6PxkczmJfQY+vJQmcUkMrRU5o
   g==;
X-CSE-ConnectionGUID: +WSi0S1ETU+4t16HyMGAew==
X-CSE-MsgGUID: 8crF9LypSUaBAhwX+eRpIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187519"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187519"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:17:01 -0800
X-CSE-ConnectionGUID: O1Yr9shGRo2JuQ0xuSI4qw==
X-CSE-MsgGUID: Q0lnH5D2RdqK/OwGBRGYXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832444"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:57 -0800
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
Subject: [PATCH v2 6/7] ALSA: hda: core: intel-dsp-config: Add support for NVL-S
Date: Tue,  4 Nov 2025 14:16:49 +0200
Message-ID: <20251104121650.21872-7-peter.ujfalusi@linux.intel.com>
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
2.51.2


