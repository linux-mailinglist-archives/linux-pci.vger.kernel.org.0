Return-Path: <linux-pci+bounces-45253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F023D3C25A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 653AA4C27AB
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4C3D2FF5;
	Tue, 20 Jan 2026 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VOI/afx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647B73D2FEA;
	Tue, 20 Jan 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897882; cv=none; b=iFLuh+wlrEmXiFo53yPdss0rN57yMFZEUZahBW0A0MpZrru94pvQpbrMUm0xqrAv1L0rS2LmQhL6FB8+D4D3LfIRVAJ9HuA8jwWEw1lQ8D+B8XtqmAMdcohmm8jHuRBlqfvuOLxVcXPtvs9yGJhG2BXbUGyBV0QD9zlPIvXGBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897882; c=relaxed/simple;
	bh=5M9kKTVAn/CQ3/3P6fd6Rlx8Obb2VfDHjJ9X+50eQKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5+8V90thKZ3ADC+m1PpvunJDxAzzWv6AxSUctJ0IcolsQPYO7LEc/sLygLNsTdDIDKYdbhint78CndrWraA/ANWwCl76tjRyc/ZhEn3w20t4HPoqXQrsOuSvLr13AxXMV2Qne+louyYbXdALLApeCDAreAf0bwuOWUPKvebwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VOI/afx4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897881; x=1800433881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5M9kKTVAn/CQ3/3P6fd6Rlx8Obb2VfDHjJ9X+50eQKk=;
  b=VOI/afx4y+AbY2ni0ZLKHglkeMNfLYPoFzDA2jhAG7yDH9MNcYd3bCuX
   jZQrJO4YzmyYnJbqVbL2HNBP41zo78bEhfg+6VrV1l4L0SAU3BiZ1+R6Q
   VkRhuxLHOyKLjyM3eaSIV6Xbb+l9hdp0pJzKNMp57reTczKtWncsgQP2M
   2F/O+YWFhR/qEtECECaNp6wQNCKITBQOMAa2k64v8bhccGG4ORuSxfpWU
   LbQD3TK5+tHVRTjuowLQH+7C1IE60MCxUenWeVFj9TT7drPLk37kFkTlh
   fw58xuFqzjfDAwqsCZbduJypvY6SjqwIM+v37t6FOS2IfTGJxJbxftLnf
   w==;
X-CSE-ConnectionGUID: +97eGTy0Q7iOWEO+SGkL6Q==
X-CSE-MsgGUID: WZlfQJybQlqcPWLT5YfyfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70071954"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70071954"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:20 -0800
X-CSE-ConnectionGUID: ZbW/1MlMT+aq2kyOQ6h2bQ==
X-CSE-MsgGUID: 65bVecLZR92q/qvdVxygHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210530673"
Received: from krybak-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:16 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	bhelgaas@google.com
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-kernel@vger.kernel.org,
	kw@linux.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 3/4] ALSA: hda: core: intel-dsp-config:: Add support for NVL
Date: Tue, 20 Jan 2026 10:31:47 +0200
Message-ID: <20260120083148.12063-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
References: <20260120083148.12063-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add entry for NVL variant of Novalake family.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/core/intel-dsp-config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
index ddb8db3e8e39..f0a44fd111f3 100644
--- a/sound/hda/core/intel-dsp-config.c
+++ b/sound/hda/core/intel-dsp-config.c
@@ -580,6 +580,10 @@ static const struct config_entry config_table[] = {
 
 	/* Nova Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_NOVALAKE)
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_NVL,
+	},
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_NVL_S,
-- 
2.52.0


