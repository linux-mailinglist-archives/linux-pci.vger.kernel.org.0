Return-Path: <linux-pci+bounces-38449-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A4EBE838A
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F64556703D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 11:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB732D7D6;
	Fri, 17 Oct 2025 11:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JLcSxxPj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3C632E6AC;
	Fri, 17 Oct 2025 11:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698855; cv=none; b=B0MLu6SX1Lo11kRZsUtXpeDBLQ9g+yhC2fEYTw3GXXtgVvDRFeIUiITw80OZ/CUpxSLWiEkKYEWnuPrrSMPMl75HW5Fd2Dbae/EwgIksKu0CSc7rUqKcYFhxnLJYciiQjXSH1AQloIklbFK7brgS32ceI9AK2SB1jG0ih6MFwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698855; c=relaxed/simple;
	bh=o6/3wj+zPydQjXEvGvRZU1T6KtATqJ9fzcvwSaMZLOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gzkq/UegNkzWcniJGq9LVLnTb0fDcG7JgT3HXvZzhCtePJyI2vPvypLBjrqJC0lL66ywnjgdU5zxnrBHQs78R4Fk15q+4TxTKmLDEaGp/vlwmh/jGMcmQQ4+qp94sF6GP4+JROjRAT0+UmGAdBM+Wfk3cc8gW49dIL2ETJ6KjF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JLcSxxPj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760698854; x=1792234854;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o6/3wj+zPydQjXEvGvRZU1T6KtATqJ9fzcvwSaMZLOw=;
  b=JLcSxxPjmSh+RVi2S3bzm5kN+jx4qYmv4hzdEugPRh/syTWsKLQ9rH/7
   cn5nUjog5DVfADiBRWi9f38wKutCh4Nl6MPi6z/DjiZiRLp3siHXAjmW5
   SzHfinQocGlPwOyjcMi94DfuD6dNowfTCg9+aJGLINgbIGfmfaXgf31VD
   0Ft7VGz+bL1LamFGja1Wt0wf0vxgjEwTVqOtev/zCeRMeAkcNtd7gDqgT
   iaJyvDPsJvxc1RHPmpUWAVOvTVAF9Q1Ot2OQwhvV5COwgkxzcKgpkIrSC
   +QFpbVbMARcclT6o2OKT2RUXw4L5CFTatG7RxvTRA8mfbTv3tlkARKSsq
   g==;
X-CSE-ConnectionGUID: HgCP3J1kTPiKc578iFtFfg==
X-CSE-MsgGUID: bzeuodYsTuKMt5XWo+gdRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="73191293"
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="73191293"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:00:54 -0700
X-CSE-ConnectionGUID: A+byNJajSvK/938Yum5i9w==
X-CSE-MsgGUID: 33MccBZcRs247sE+kAxAfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,236,1754982000"; 
   d="scan'208";a="182701405"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.245.244.103]) ([10.245.244.103])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 04:00:50 -0700
Message-ID: <749a5f42-f1eb-488b-826a-ca9b6981b048@intel.com>
Date: Fri, 17 Oct 2025 12:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/12] drm/xe/pm/s2idle: Don't evict user BOs for D3hot
 and D3cold-VRSR state
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com,
 ville.syrjala@linux.intel.com, uma.shankar@intel.com, karthik.poosa@intel.com
References: <20251015080710.1468409-1-badal.nilawar@intel.com>
 <20251015080710.1468409-12-badal.nilawar@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20251015080710.1468409-12-badal.nilawar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/10/2025 09:07, Badal Nilawar wrote:
> In D3hot and D3cold-VRSR, VRAM remains active, so it is not necessary
> to evict user BOs.
> 
> Cc: Matthew Auld <matthew.auld@intel.com>
> Co-developed-by: Sk Anirban <sk.anirban@intel.com>
> Signed-off-by: Sk Anirban <sk.anirban@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/gpu/drm/xe/xe_pm.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 84cd9e84f548..51ff9b90fbfd 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -169,7 +169,7 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
>   
>   static void xe_pm_suspend_prepare(struct xe_device *xe)
>   {
> -	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> +	if (pm_suspend_default_s2idle())
>   		xe_pm_d3cold_target_state_toggle(xe);
>   	else
>   		xe->d3cold.target_state = XE_D3COLD_OFF;
> @@ -191,8 +191,6 @@ int xe_pm_suspend(struct xe_device *xe)
>   	xe_pm_block_begin_signalling();
>   	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>   
> -	xe_pm_suspend_prepare(xe);
> -
>   	err = xe_pxp_pm_suspend(xe->pxp);
>   	if (err)
>   		goto err;
> @@ -543,8 +541,12 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>   	int err = 0;
>   
>   	switch (action) {
> -	case PM_HIBERNATION_PREPARE:
>   	case PM_SUSPEND_PREPARE:
> +		xe_pm_suspend_prepare(xe);
> +		if (xe->d3cold.target_state != XE_D3COLD_OFF)
> +			break;

I think this will break hibernation on igpu platforms with flat-CSS? We 
need evict_all() to move CCS from stolen memory back to normal RAM such 
that it is saved and then restored correctly on resume from hibernation. 
What is the value of target_state for a hibernation event? Does the 
evict_all() still get called later? AFAICT it is not called any more.


> +		fallthrough;
> +	case PM_HIBERNATION_PREPARE:
>   	{
>   		struct xe_validation_ctx ctx;
>   
> @@ -569,8 +571,11 @@ static int xe_pm_notifier_callback(struct notifier_block *nb,
>   		xe_pm_block_end_signalling();
>   		break;
>   	}
> -	case PM_POST_HIBERNATION:
>   	case PM_POST_SUSPEND:
> +		if (xe->d3cold.target_state != XE_D3COLD_OFF)
> +			break;
> +		fallthrough;
> +	case PM_POST_HIBERNATION:
>   		complete_all(&xe->pm_block);
>   		xe_pm_wake_rebind_workers(xe);
>   		xe_bo_notifier_unprepare_all_pinned(xe);


