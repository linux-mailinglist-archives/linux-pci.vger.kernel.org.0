Return-Path: <linux-pci+bounces-27921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE0EABB6C1
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 10:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39441896CC9
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DE62690F9;
	Mon, 19 May 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6WeyJUV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F2426A081;
	Mon, 19 May 2025 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642081; cv=none; b=i7s/NLCftL3KEFvocip97M7J5W5v0FhvcXrf4/Db63TqdGYN4g3cctOzAKPHkVdja06ddQh9L+Pq8gJOQwem8KebgRVkdjUhRAMimQh1sk+qGfFA7/71ftt4Qm52IMd2HDXRxWhr8pukYIPrTKwbJtetAlcNZAIUhUGgedtFAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642081; c=relaxed/simple;
	bh=ZnzLVI2Bq/oZypXBE9n35DzTkQl+6GQEQMub3wccrQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTwOq8lV8UzcBDGfcG0IFkRUkH4MJP6rirLdmG1w0eIvcH6i0DMwOgkap519+XiQO1NydiCJSTF86u0KKu36BEbzg8/2rQHGkQvpH+mZRgGBQXvTn1dlO51yVIbxZwY7GkUNgmgnh0i6+5yNTtXVO8A+EwYk/Mze67PecBX7jVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6WeyJUV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747642079; x=1779178079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZnzLVI2Bq/oZypXBE9n35DzTkQl+6GQEQMub3wccrQ0=;
  b=c6WeyJUVjXnGVoltWz5cQDnGDd0t0lnmj6a3/EyLxtCNsq2fLZ4MUjn1
   EZ8uBeQ41waE36JgCTpV7UsmwPaI49o3RX3Gla7PNBI5LR8oZCA92S2L0
   SxGMx4HMj2r/5MzqrlaarFIzflAxPTH9nmvFa3D4PVp/zxNgk6ZyQf9GY
   g40j4G/qac3rAEKhHUm5tSH6TlMBLjcjSOUTjovC1dH391vLAGmhMECRB
   try2hkQSTh08g6+JVlc7dAw0dF7THLyLzqz7XWwGYCPhjj8B7R8hsQVPA
   a/X3SiWg0lWZga1Czn5Gnm5dl5xNg5BqcEi1pOlQJLpDIUqEj7q/Hw9R/
   Q==;
X-CSE-ConnectionGUID: rfOC4rG/Q6a8e+PMUOG8Iw==
X-CSE-MsgGUID: UqnfAOwvQj+In17boaL+Eg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="52163522"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="52163522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:54 -0700
X-CSE-ConnectionGUID: W/wryT69Rk6TAcrVJffZsQ==
X-CSE-MsgGUID: +0duS5U+TMmuoNrvTTSNKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="139205813"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.4])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 01:07:51 -0700
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
Subject: [PATCH v2 2/5] ALSA: hda: add HDMI codec ID for Intel WCL
Date: Mon, 19 May 2025 11:08:52 +0300
Message-ID: <20250519080855.16977-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
References: <20250519080855.16977-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Add HDMI codec ID for Intel Wildcat Lake platform.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 61c3fd0adc07..08308231b4ed 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4652,6 +4652,7 @@ HDA_CODEC_ENTRY(0x8086281e, "Battlemage HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281f, "Raptor Lake P HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862820, "Lunar Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862822, "Panther Lake HDMI",	patch_i915_adlp_hdmi),
+HDA_CODEC_ENTRY(0x80862823, "Wildcat Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.49.0


