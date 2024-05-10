Return-Path: <linux-pci+bounces-7363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4C8C2620
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 15:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2705A1F21626
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 13:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8567128386;
	Fri, 10 May 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a13jeYJ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5E65027F
	for <linux-pci@vger.kernel.org>; Fri, 10 May 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349314; cv=none; b=Q8CgVvr0W3sExja9IleTcJ7ICjTh9vcfpTO8+AMdtWXeW46qw3Y7xQ6vRbp6gQXf2MvY+sAvR/5UeP8XB/Z+s6ZiaL8vjnvOthZetLloi835h11hvcOjFLpQ4IS/ld4f6By4WxCCHez3sCzDDGm1Rupk5GwF0jiOgmBuAg9Q9c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349314; c=relaxed/simple;
	bh=FnkjXC4i6xl2Mr5cMoLCB/KhnXlWHwdYFqJLTaZI2aw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hdjmY+6pZwb1iZjHmDS5bsI01B+vZYhftUMjGrKpAJ3/IfSatJqfjjS1IRiBVRGZbmom2iD9MTmN82VOi5nwiyJu7iRev7X2fYcpw9tcXwiKFR5IFn5nI24P5LpTwhIC3L0NEf7w+zgdhMBgvRzn4Ck8oLbprpwRIqdCzzBo2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a13jeYJ0; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715349313; x=1746885313;
  h=from:to:subject:in-reply-to:references:date:message-id:
   mime-version;
  bh=FnkjXC4i6xl2Mr5cMoLCB/KhnXlWHwdYFqJLTaZI2aw=;
  b=a13jeYJ04koPNm0ueEXeHsuYvIwRpAQvJjBIM9DvMZMPu78HRFF9ngZx
   TU1F+ERXyGGXW0J/8CmUuWSr0UHbE6dvAIOXudlyMt0TEeKJ7+qGGSHJb
   JgGX0+m90+P8LXz3pbaFsNBKSqiC5KqSM6yN+IQq19K6Se1zQI1VWFXcL
   W4RIb9SzMZ5sjSFxIHZKyU8+Il3mpdFMIEnSBDGJFN1/o8b6EpiZ5eTEZ
   JXg+WPYnD7ptTvnjH5VuCsnSJADQGjYhojQfxSZBfHkMXz528flLvB0zq
   9UtD8sJPYUNXEjwj87PBvTFtP93Ec0gPqeZhQ+3mcgU+01yx930rCm6cF
   w==;
X-CSE-ConnectionGUID: Gz8dYYp0QcuyrMdMuQDjTQ==
X-CSE-MsgGUID: g11b9r1rTXqWP5grPkLYAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="28813857"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="28813857"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:55:12 -0700
X-CSE-ConnectionGUID: 9M6OUe/gQMSvVZH3zR5YBA==
X-CSE-MsgGUID: uKb4RQYDRD21FGkJ097vkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29632278"
Received: from ettammin-desk.ger.corp.intel.com (HELO localhost) ([10.245.246.180])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 06:55:10 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/8] drm/i915/pciids: PCI ID macro cleanups
In-Reply-To: <cover.1715340032.git.jani.nikula@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1715340032.git.jani.nikula@intel.com>
Date: Fri, 10 May 2024 16:55:07 +0300
Message-ID: <87ikzlhiv8.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 10 May 2024, Jani Nikula <jani.nikula@intel.com> wrote:
> This is a spin-off from [1], including just the PCI ID macro cleanups,
> as well as adding a bunch more cleanups.
>
> BR,
> Jani.
>
> [1] https://lore.kernel.org/all/cover.1715086509.git.jani.nikula@intel.com/
>
>
> Jani Nikula (8):
>   drm/i915/pciids: add INTEL_PNV_IDS(), use acronym
>   drm/i915/pciids: add INTEL_ILK_IDS(), use acronym
>   drm/i915/pciids: add INTEL_SNB_IDS()
>   drm/i915/pciids: add INTEL_IVB_IDS()
>   drm/i915/pciids: don't include WHL/CML PCI IDs in CFL
>   drm/i915/pciids: remove 11 from INTEL_ICL_IDS()
>   drm/i915/pciids: remove 12 from INTEL_TGL_IDS()
>   drm/i915/pciids: don't include RPL-U PCI IDs in RPL-P
>
>  arch/x86/kernel/early-quirks.c                | 19 +++---

Bjorn, ack for merging this via drm-intel-next?

BR,
Jani.


>  .../drm/i915/display/intel_display_device.c   | 20 +++---
>  drivers/gpu/drm/i915/i915_pci.c               | 13 ++--
>  drivers/gpu/drm/i915/intel_device_info.c      |  3 +-
>  include/drm/i915_pciids.h                     | 67 ++++++++++++-------
>  5 files changed, 71 insertions(+), 51 deletions(-)

-- 
Jani Nikula, Intel

