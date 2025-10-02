Return-Path: <linux-pci+bounces-37402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D13EBB3545
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F930543F03
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFDC313E2A;
	Thu,  2 Oct 2025 08:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="comOob9o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10372313547;
	Thu,  2 Oct 2025 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394544; cv=none; b=r8hczMQjHPVo84b7UE5o2HTUCRQ2iVsCuACJxJv1WQVaWN19CFiXoEf/IHdFUtYgkGAxkuH8iRieGvlI+/pYNRV7FMsHSkp4lNvsz/nPEQ8PgTUF6zVS3O2JkvnfP8TIflSgFTamDxvxLfTh8pm37t+mBP8IxH1Man3IlG+4TtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394544; c=relaxed/simple;
	bh=DQLsj3m2+FCvd0nPH88N/uliHGZbLM99gX1huBjG2kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNzu4B15OVBzWJ0AvWfxhHkCCtcg8gBx4b7LfzDVEMDRobt69D+VFr87qXYlrSTIsJO7ARGikSXEXCvUwW2yTs2oDIZVZPgJQ+3OKf3tNSQwRSemz7EAN9dV0eWmLmgVk3CW1aXoMkc2agrZErY7VjxmLof2P9NqS4m44urMR/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=comOob9o; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759394543; x=1790930543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DQLsj3m2+FCvd0nPH88N/uliHGZbLM99gX1huBjG2kk=;
  b=comOob9oyHRX0s5xYnqWxjhCPyJ1KlSq7eRKJacdyDIO9nWd5ohsIQgT
   7gnvU7Yfr5+yjoCJ7IqVsjJY58ICCI4iq46EXvSQhIbrbwcYk04PRTBSj
   KIMUBuzMWkOzNyL6lUoz6uuMjG+XPliC0oJ2LAztVRZP8J68JtCh84u4r
   ZZ7e9dFaWeMhs3umfqB96qWWGaI7q5GlIIHOm9ID9U/hDfA6w9wkokLMr
   VWiB9Af/bfyxsTo/8fO38Vl04xlEZITnaZizls10GCyIdViUI75qYOBLA
   1nHgp8X1TLg0G5gIMgV8V7we0EooX4oQotNrtKhjgcihOE6qBtW4wB8Oj
   w==;
X-CSE-ConnectionGUID: LCMRwPK5RjCGQQ3ox4hifQ==
X-CSE-MsgGUID: T1FQfuEhT3iLMFMErl5+fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11569"; a="79099081"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="79099081"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:22 -0700
X-CSE-ConnectionGUID: qmzR5MQ5QdKn1snW+NJuNQ==
X-CSE-MsgGUID: 0+EbY5nAQCe40Ro/dUJrgQ==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 01:42:20 -0700
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
Subject: [PATCH 7/7] ALSA: hda: controllers: intel: add support for Nova Lake S
Date: Thu,  2 Oct 2025 11:42:52 +0300
Message-ID: <20251002084252.7305-8-peter.ujfalusi@linux.intel.com>
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

Add NVL-S to the PCI-ID list.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/controllers/intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index 48c52a207024..94ed57e4c0b0 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2549,6 +2549,8 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, HDA_PTL_H, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
+	/* Nova Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
 	/* Gemini-Lake */
-- 
2.51.0


