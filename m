Return-Path: <linux-pci+bounces-27923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8480ABB6C5
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D29B3B6D2E
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0808F26A0E3;
	Mon, 19 May 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EvS4i2gq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588B526A08F;
	Mon, 19 May 2025 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642083; cv=none; b=L+X7M0XD3FcE9JzDhbz8cRF5JwVpPlzXGHTglHYii7xf8EYkNEihndNRpOnp2+sXbCpB5Y1R5kCQRNo7YMJDbxsrRthRJ5WgaeNCi1got5LmOEmkMM8LM0hfXoKw5HO+rSTiicehubIoG07SgZ9yBueXXa96hAY1hMaz4UZP264=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642083; c=relaxed/simple;
	bh=el1AWAd7oyOXT68gF9qGa7WpOtLYPSqA1FawoVdiPmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+XnEKWaj45PSdl2i6feb+6Q0n8xrtyMRbIIucUxAvLiRLsrlNeZccGLhgiUqm+WvT4wRs4hlNL0s+obB5we73u3UNGGYZHJOuC6wBTIcXOGoEHyDpihDkguu8C2hQYxALtEtrgQEoKQMsS7ag5YA/xS6yxt2hV4O+8TPZk5nXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EvS4i2gq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642082; x=1779178082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=el1AWAd7oyOXT68gF9qGa7WpOtLYPSqA1FawoVdiPmM=;
  b=EvS4i2gqhAhI8AMvoAYHZ4D3q0YZxCmkhHklKxyPPxrBKrjKxXRAQOBz
   wTskgl0KVIrWCfvncRj7QHUi3ltAUltKlKG584fk3E48F2vPDVO83IA4N
   S64SpHlBoLIV0TWmZKWC3Y1f0vrbdvAAN7Bp/uA30dgmxnjgxoQ5HcM17
   9yOUmmrzupydS+/EqBjL9rHkkWEP3dl/rrZbqrvBrjmQmlDJCOuwGV5fm
   t5r5ng2tKuZA+Ys9IjHk5HRBj1RjyC1VkeliC7u4yrEHkTOCuaSfVL6Ia
   mB9lYwEr6+XdkfF2RdE3ZBW/4zKaDZM73Lb9SrnkpoihowxjkJLbWyxV3
   g==;
X-CSE-ConnectionGUID: CM1ng9GvR/y4uHsT0AO+hg==
X-CSE-MsgGUID: +cavyc2/Rhe+Zl5Hj1+4ZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163564"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163564"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:08:02 -0700
X-CSE-ConnectionGUID: t/OmUpzwTQq8QUva9qsvJg==
X-CSE-MsgGUID: yfbqcK61RGeyUp63HeNwqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205829"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:58 -0700
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
	linux-kernel@vger.kernel.org,
	kw@linux.com
Subject: [PATCH v2 4/5] ALSA: hda: intel-dsp-config: Add WCL support
Date: Mon, 19 May 2025 11:08:54 +0300
Message-ID: <20250519080855.16977-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WCL uses the same receipt as PTL and PTL-H

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
---
 sound/hda/intel-dsp-config.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 01594f858129..3cb1e7fc3b3b 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -541,7 +541,7 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
-	/* Panther Lake */
+	/* Panther Lake, Wildcat Lake */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_PANTHERLAKE)
 	{
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
@@ -551,6 +551,10 @@ static const struct config_entry config_table[] = {
 		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
 		.device = PCI_DEVICE_ID_INTEL_HDA_PTL_H,
 	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = PCI_DEVICE_ID_INTEL_HDA_WCL,
+	},
 
 #endif
 
-- 
2.49.0


