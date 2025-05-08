Return-Path: <linux-pci+bounces-27455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C186AB0210
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 20:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E721BA1246
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3A286D46;
	Thu,  8 May 2025 18:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YIT3Lb5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD5E207DEE;
	Thu,  8 May 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727304; cv=none; b=rlhhaHEazAPOEm6fEzYTTHB1+H+uX4QgEXWTIzeVliObsnhIraweZtcqwiPyy5+XxvsbPlwoTyPP+iclGuCrEPD8vdSgoo9+7RACrFElKU5uHb4kVs3v9fH/uGgxHUb2+HBrZ1b18zOv5kLfUvPnlFg+/3Qzqhtptxhj0U8nvto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727304; c=relaxed/simple;
	bh=Wb7mf/2ExpbFtUzmce5jARJsB4i7ghf3pYh67La1ym8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGxST/C45w/K0mnfAudS7JJ9g7qhVzikbJ7/WvYwSUYiiezfsToekIUMyxyx2b5RRZ3pPWASTnNiMJje2teevL+jUbWB+dHk2Wdavp+65SQSEU9HaS7urLmymJXP1DaHqpgRCztnncFduP7y02qNOD6p50Iaz6scdm3R87ghBYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YIT3Lb5h; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727303; x=1778263303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wb7mf/2ExpbFtUzmce5jARJsB4i7ghf3pYh67La1ym8=;
  b=YIT3Lb5hH7BJbxOhXxsaRQlOYiK3cdXxKYoNekUuQuxZMwsFpsyNpMii
   AOfTaOd24TfP+8x+hxtETYtfeBOdKENFNIo7h2v2eUo3JQhxrB4lpAl/K
   sHwboqOxDHj6m6hbvnYTMPGj2tMZsmKZiYqQIVy0p+powyEUqlUJoC9Sb
   5eDWimPFwe6tY+YLH1eFlg/5K5qgu+Wed8mqqXDag2opBHTEMymM2XUig
   3a2iqC/87v09099ymNoJcdxtdLz/u7vRJOLMdVyLwP84nQQa64N+CssCX
   8z9myPZgtt0a5GmSyRsBv6JmAoug00RRT/VXN8/c+bPnWu5nPhq1qLJyu
   g==;
X-CSE-ConnectionGUID: 25DQBCNfSwCec+m1S97JOA==
X-CSE-MsgGUID: WohvuhhcQ36s0fd2YjhX3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59160543"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59160543"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:40 -0700
X-CSE-ConnectionGUID: HKAp4a+hTdapnTJMWGkmZA==
X-CSE-MsgGUID: q73QYxYUTpC5YHlYyLMyew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136311371"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:37 -0700
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ALSA: hda: add HDMI codec ID for Intel WCL
Date: Thu,  8 May 2025 21:02:37 +0300
Message-ID: <20250508180240.11282-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
References: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
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
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index a3a53e63a51a..f451b9a671c0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4651,6 +4651,7 @@ HDA_CODEC_ENTRY(0x8086281e, "Battlemage HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x8086281f, "Raptor Lake P HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862820, "Lunar Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862822, "Panther Lake HDMI",	patch_i915_adlp_hdmi),
+HDA_CODEC_ENTRY(0x80862823, "Wildcat Lake HDMI",	patch_i915_adlp_hdmi),
 HDA_CODEC_ENTRY(0x80862880, "CedarTrail HDMI",	patch_generic_hdmi),
 HDA_CODEC_ENTRY(0x80862882, "Valleyview2 HDMI",	patch_i915_byt_hdmi),
 HDA_CODEC_ENTRY(0x80862883, "Braswell HDMI",	patch_i915_byt_hdmi),
-- 
2.49.0


