Return-Path: <linux-pci+bounces-37397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B2BB34DF
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597211884B5E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BC82FF16F;
	Thu,  2 Oct 2025 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NL57p+n3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC272FDC52;
	Thu,  2 Oct 2025 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394528; cv=none; b=s0J5ynkSItaZ8VPFzpRsnwQkzC5kRoEw2Mxb20MetzZsvWEPpTQEjPnfQ6v3bfGC3NtH6a+HJTwsYjtiXSzjOm/9vWplJ9LJ5LJQdIbC2t44Qky5AdYW52BraFrW86ZnePkNuVLLCACaW8/zsmN35ALlNx84D6xUdOFQX9griaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394528; c=relaxed/simple;
	bh=sVzum0ko2B87Y2N2M6xvSNt+FsLpEmFHUTv6QESLAgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R83OTY+23K9sryaO0u6MCHoNu1JAap8H6WJV2O80as3yIZe1tQOIMdiV/MfNOMATNEZdWn1Walb6bL9Da64ukvtKoW9NUFOlGI5t5y/mpEE82Jca/32/lNIqUiZHYCS1+EXGyw6o7zf4Xh4ntrxsiKY6HLMKWnzBKKQbS92Rd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NL57p+n3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394526; x=1790930526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sVzum0ko2B87Y2N2M6xvSNt+FsLpEmFHUTv6QESLAgI=;
  b=NL57p+n3FAexahyk6ezhZrk48yD+Ob+aLJHZYus6p4nn7iuDYg8LnGTM
   9gAy0qy2058pVRHSI/bk5Eozti55DkLZG4WwjDwCm6Gt3QeAPf+JH9ICq
   WsYbRlosrhVxN38sV82e5liwjHLp/vtGqtGQrLng3Xl/33/IshIyBPwqa
   HDPXu2uVotJTsyvAg2JmEXoSl9eg12KUQdYaPbS15QcMDr+gABS+h4DzM
   4mDnAY5FXAq7R4JNVOnUDtglGX12a8HAr3P0MRVl6azvWGoBQCNQrHXOf
   Wca5qZVl/6SPMWoD8LXnZs4nrbINR3+OH91j/xWef6Jje49b5AUmuuTBF
   Q==;
X-CSE-ConnectionGUID: pZU8eMoHTAajHRgeoSayrQ==
X-CSE-MsgGUID: JURSIFKfSRSdkYyK8tJK2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099035"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099035"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:06 -0700
X-CSE-ConnectionGUID: G0Y9DpbeQ0WviE+tWrgZLQ==
X-CSE-MsgGUID: q9RC8YHXQ5eR54d96Gkkfw==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:03 -0700
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
Subject: [PATCH 2/7] ALSA: hda/hdmi: intelhdmi: add HDMI codec ID for Intel NVL
Date: Thu,  2 Oct 2025 11:42:47 +0300
Message-ID: <20251002084252.7305-3-peter.ujfalusi@linux.intel.com>
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
2.51.0


