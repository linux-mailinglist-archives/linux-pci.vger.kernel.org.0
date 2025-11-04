Return-Path: <linux-pci+bounces-40196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD01FC30F48
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF51189E758
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30DC2F360F;
	Tue,  4 Nov 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J7h3lYLH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB32F0C71;
	Tue,  4 Nov 2025 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258608; cv=none; b=SKSGio/oVlg3jgpuR9Iu1o8TmcJKfxBli3iC8LOVx02/9LZufuPJIBOK0y2DEbvyMyWaeI80Z7QkOGfqd1utvKgw+vDzJr5Qj8bFW9S1FkX6s+vEgghSaOhn41bWFES36BmOfcROHS8HN2FeDanw0OE7GWVAw2qqu448rexgjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258608; c=relaxed/simple;
	bh=885USG1lGmO6r5ERSfSR2tSW8l4ecIQQfBIfkmOSfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XYlgYaYBQLIwdH+CLBn8YbFO2VRK1FLjA1f4iJLUzXV8ZFauLjhXkFKthODcaJhHjTw9BIhHLhvHc2XDqVHwEOROFxcsq2gMGoyY8UDyMBb76EuKWzYJBHv5HVVvc+WFeTPd/qTIetexYFNgTCwvTFTFn8BpIGAgZGkfc2RTmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J7h3lYLH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762258608; x=1793794608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=885USG1lGmO6r5ERSfSR2tSW8l4ecIQQfBIfkmOSfvQ=;
  b=J7h3lYLHo6w52yIjfXC4uQIYILBRa0abOgXmqdGe0r6iASE/FQaTzUa7
   zxmhZpfASHzhVMIfaWJLiee5DKFH23bzpc/sVsEvPUXfaG4RgCpeokLwy
   +r2MGJjnYyxFhXlAVOMOHrvgVDi1JU9SNdMy2WbiKmfeYLDvcdlylv13D
   MHUPgetC5Yj8NoErYogN0rAY9ssJOCpGgXNz2UUlC0hqb3PMInnEDT+vj
   H2l+VXk2OYoYohoQpA0BJ5lNaQvhxtG2z8DXjQh4Mf8/F2NlDLOP+IQwn
   6VNznCUR8ColeRC9wfBmdwvaXxANb6qqKv+poyyPBeCVvBUoxQ4QfQPnO
   A==;
X-CSE-ConnectionGUID: kPmsA+SQR3yTHc4LVODMNQ==
X-CSE-MsgGUID: HKFOS8PJSUS9yb8KVCVDFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="68187508"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="68187508"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:47 -0800
X-CSE-ConnectionGUID: atT5mIekSR2RrcPkJTChMg==
X-CSE-MsgGUID: RjhNgVqGT3CcgUrhAUg4Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="186832423"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.200])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 04:16:43 -0800
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
Subject: [PATCH v2 2/7] ALSA: hda/hdmi: intelhdmi: add HDMI codec ID for Intel NVL
Date: Tue,  4 Nov 2025 14:16:45 +0200
Message-ID: <20251104121650.21872-3-peter.ujfalusi@linux.intel.com>
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

Add HDMI codec ID for Intel Nova Lake platform.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/codecs/hdmi/intelhdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/hdmi/intelhdmi.c b/sound/hda/codecs/hdmi/intelhdmi.c
index 23237d527430..9460c8db39a9 100644
--- a/sound/hda/codecs/hdmi/intelhdmi.c
+++ b/sound/hda/codecs/hdmi/intelhdmi.c
@@ -793,6 +793,7 @@ static const struct hda_device_id snd_hda_id_intelhdmi[] = {
 	HDA_CODEC_ID_MODEL(0x80862820, "Lunar Lake HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862822, "Panther Lake HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862823, "Wildcat Lake HDMI",	MODEL_ADLP),
+	HDA_CODEC_ID_MODEL(0x80862824, "Nova Lake HDMI",	MODEL_ADLP),
 	HDA_CODEC_ID_MODEL(0x80862882, "Valleyview2 HDMI",	MODEL_BYT),
 	HDA_CODEC_ID_MODEL(0x80862883, "Braswell HDMI",		MODEL_BYT),
 	{} /* terminator */
-- 
2.51.2


