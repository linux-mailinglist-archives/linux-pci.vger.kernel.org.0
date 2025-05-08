Return-Path: <linux-pci+bounces-27453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A88BAB0204
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68BD4B2081A
	for <lists+linux-pci@lfdr.de>; Thu,  8 May 2025 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2530286D4A;
	Thu,  8 May 2025 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="abPf2kW7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DE41B0402;
	Thu,  8 May 2025 18:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727297; cv=none; b=ZMGflRJ6w7M7AEfEYPMiOF5PxN770kXKVPjaE0p0pAH2o4oyWpHqMemoR3oeHiTULJOi+IzgqOU6ikdp39Zd6ffl6PcDfD00UJhMFtkKTy6pRl5TW4dbzbCY+3d1vlIUyqkhZ/WVkHrmZ2elw5HBCKQ0AOQ0H9j3HigmIARd/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727297; c=relaxed/simple;
	bh=4IaTGp/RHG8XCHDD6+JKx9ZhothtznL7usQ8NAPsSbU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oEntWyZj7zFSTSz/2r7IQ5I7JdZ6pGOkwCsUZjBWIX75DRgYvp1WZwC5ClMyDx3B+SQaVKjBuT5+RU1ynzBA/cWa5sqTsa4W2B4kYxAJS6BkGediAyd3sWeWMK/FRK4xqu5RtC0ArPaAFhQMAeBdHXjZrbhkR7KRgGytGa2Su1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=abPf2kW7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746727296; x=1778263296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4IaTGp/RHG8XCHDD6+JKx9ZhothtznL7usQ8NAPsSbU=;
  b=abPf2kW7oezpzAFQTtwbRggMCgym7qSGt0ph2AxyjNejpUKq+dlbMJTU
   TepVhWuHOj4qoAHyzItyEpdOPC1JfZSSP3W9TDyK36CR9mOQjLjf2ZjCK
   2NVcTC5OTWpM5uIqnvVsXu5NuCze49e0yW2jGSziCjFeljP+ZqR+AuDZc
   tE+LHPmorC62RAsWBhXHUxYuRw0yY2L8wPSggP1sjsyoJlTbh1xL4cky3
   HQ45G3taeGEkdixBLYIQwlWgIcy7a+OChLbnwdAPTKBvZOxoo9KGLJcVX
   zBJud/FqoowP7Hjpw6z3sG6+BPCwZEdTge1oyNC8xQnHh4ZMGUpJTCSTU
   Q==;
X-CSE-ConnectionGUID: s7ZZV4g3Q7e6AQO+l0ix5g==
X-CSE-MsgGUID: dRphcWCSQOaMVLzuBDXoaA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59160525"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="59160525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:34 -0700
X-CSE-ConnectionGUID: 7+Cjs/HAQ2eIS50yjA2CWA==
X-CSE-MsgGUID: N5waLP+vQYWmDXPr2vTEqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136311278"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.123])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:01:30 -0700
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
Subject: [PATCH 0/5] ASoC/SOF/PCI/Intel: add Wildcat Lake support
Date: Thu,  8 May 2025 21:02:35 +0300
Message-ID: <20250508180240.11282-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

The audio IP in Wildcat Lake (WCL) is largely identical to the one in
Panther Lake, the main difference is the number of DSP cores, memory
and clocking.
It is based on the same ACE3 architecture.

In SOF the PTL topologies can be re-used for WCL to reduce duplication
of code and topology files. 

Regards,
Peter
---
Kai Vehmanen (1):
  ALSA: hda: add HDMI codec ID for Intel WCL

Peter Ujfalusi (4):
  PCI: pci_ids: add INTEL_HDA_WCL
  ASoC: SOF: Intel: add initial support for WCL
  ALSA: hda: intel-dsp-config: Add WCL support
  ALSA: hda: hda-intel: add Wildcat Lake support

 include/linux/pci_ids.h       |  1 +
 sound/hda/intel-dsp-config.c  |  6 +++++-
 sound/pci/hda/hda_intel.c     |  2 ++
 sound/pci/hda/patch_hdmi.c    |  1 +
 sound/soc/sof/intel/hda.h     |  1 +
 sound/soc/sof/intel/pci-ptl.c | 30 ++++++++++++++++++++++++++++++
 sound/soc/sof/intel/ptl.c     | 23 +++++++++++++++++++++++
 7 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.49.0


