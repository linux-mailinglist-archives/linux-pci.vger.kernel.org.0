Return-Path: <linux-pci+bounces-45254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76974D3C2BC
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 09:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58BA05C71E5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jan 2026 08:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6BE3D2FEA;
	Tue, 20 Jan 2026 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VuVlwmEO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A1F3D3013;
	Tue, 20 Jan 2026 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897885; cv=none; b=nI3ZOh0/Wj0029Az42bj35P68s7+KqscW9nV0Oe59Y503XHpO7k1UWgqCdPs1OkaZATtnj9aB1fmV4BcNQLSHNjTLmWQMTqg1H0dNGWkyukqcFZdE4J+B15mbKckZs9vgaDwt2eNkniOuyPCpOTikFbsnCGKEMKLOqhJJhPd0yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897885; c=relaxed/simple;
	bh=G5OUIZ0ehRmTQXs34jjTbgfwlTypW/YnwkTyZ2RKoOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/xm/fpfB7kwR1+ziUH4I+ZVgHAKhfAeGRJRyIum8u2KvAsmD755LF07Z2iYj/8y/Vv9aTS59eGcWohwAD49KHRT29+DTvRD9scDp60nQK2Ud00RCKaULMJqy2BvEGxyswFrYsqOHgTqv3hQ5oYLavXqdzr3+n5tx9j3GRLsgV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VuVlwmEO; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768897884; x=1800433884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5OUIZ0ehRmTQXs34jjTbgfwlTypW/YnwkTyZ2RKoOA=;
  b=VuVlwmEOkPmUUMc8NlEDs+1yyFiu6p3BAFZJWyAp1Q++oS0h7h1M3fdx
   M0kabLkE6cHde+igfff4PIs8bwuwKfpWwmO/9gf8/6KwLP4xJ12AiqP+X
   Ah4+GNin69i+IDa5gs4nMDZ2g376c2GQr7UmuckTMX7F1C9SiFKYoxwJU
   heBwqYhU/rm1K6DnhVIUiDtoLKC1jdQLe6DKn0RSTRBkBA9soPA27fhLx
   hTFh6PGgPZzvCjwLKehOLFFa2hvgU+C56ndp7FOIt3HnPguoeUuUgT+rL
   QniLrELxo921DRHy4Qig/6cmK5sUv/+KJZ2xAvs7dBDE34LEdm22ubtET
   A==;
X-CSE-ConnectionGUID: +b8ecKzMTrevS8Rc9soSbQ==
X-CSE-MsgGUID: MYYSkcxfTkKscwmob2643w==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="70071973"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="70071973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:24 -0800
X-CSE-ConnectionGUID: 8+6Ksd28Rby6EgvTRpC4Mg==
X-CSE-MsgGUID: a+7l28RvQKuFZM8GeVkxjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="210530683"
Received: from krybak-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 00:31:20 -0800
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
Subject: [PATCH 4/4] ALSA: hda: controllers: intel: add support for Nova Lake
Date: Tue, 20 Jan 2026 10:31:48 +0200
Message-ID: <20260120083148.12063-5-peter.ujfalusi@linux.intel.com>
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

Add NVL to the PCI-ID list.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/hda/controllers/intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
index bb9a64d41580..85324c7c796d 100644
--- a/sound/hda/controllers/intel.c
+++ b/sound/hda/controllers/intel.c
@@ -2551,6 +2551,7 @@ static const struct pci_device_id azx_ids[] = {
 	/* Wildcat Lake */
 	{ PCI_DEVICE_DATA(INTEL, HDA_WCL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Nova Lake */
+	{ PCI_DEVICE_DATA(INTEL, HDA_NVL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	{ PCI_DEVICE_DATA(INTEL, HDA_NVL_S, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_LNL) },
 	/* Apollolake (Broxton-P) */
 	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
-- 
2.52.0


