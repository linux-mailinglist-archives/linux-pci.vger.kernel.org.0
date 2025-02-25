Return-Path: <linux-pci+bounces-22373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D2A448DA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46C618844FC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92A199FB0;
	Tue, 25 Feb 2025 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOarUqym"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87BF14F9C4;
	Tue, 25 Feb 2025 17:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505799; cv=none; b=B6HF0L077PkJmXge5iSE9YPFbGQVz5gqzm98iRPLa4MCJUu2klF5bbwqQlJY/5/5AVbyDkQxQJ+bFfOW6+NcpcqtbHNN6/S5vK0HVcwN2Gd3wQNd9ihaZcVdIV1PFaYDXpemWjp9WPkISvc6+kDaYG7oycAtO2MlwiVapZnyLBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505799; c=relaxed/simple;
	bh=yp8FvEbU2bkxdNPh8CTALxDMZZtdWdeBwJwKmOBjdRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc9C29Wa+dcMd1yDEA/DPTKPW3eY78CyUDZaXea62F97nRaUuub/XEuXUNixSAYXe95Xm7/fjoZZGAKleaeTmgnXIFx5vwN2kmYhzjEPsRu+MQrAKcn62eVHS9AgkGyM1ft5qkvgFZL5knThHj3YO7j9GxBL0CWFCWDSpqHkiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOarUqym; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740505798; x=1772041798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yp8FvEbU2bkxdNPh8CTALxDMZZtdWdeBwJwKmOBjdRo=;
  b=bOarUqymiFclnIw7X/WQ1woWaTdxB75m/ZKjpGdZWwJobKxoIvnQ+Xej
   +qJyVcs+c6NLlDpwmz/npJpekqBLUBghlp8wy/yY1+iJIOSMmnEs+Wp6n
   WYLL9o+VeUGIs4O3WW7bPlqB3mI9TWvkNfb9GAm1rkmzXJiPehI681HDz
   nWcWp58PiZtu1RmLWF/rx7nL1SWef2NdQbnjcmUFWulgrm47MIjL0JElD
   vymyGYNAHzx9u89swWMf7cJlWK0P9djjFJQJ9HWNzWcWTtULl/LhkeXB9
   8ZnBAF9ouwQqQwABxXxoI6rspAkypkEpqQcsZTqAr9lqUDFj9xNtCaIW5
   A==;
X-CSE-ConnectionGUID: A1gNqUnIRiufN0Wv1qZgNQ==
X-CSE-MsgGUID: 3dwDGoJyS3+ZmO9yjBDzSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58861521"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58861521"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 09:49:57 -0800
X-CSE-ConnectionGUID: pb8Zky/LTD68433e/PhUcw==
X-CSE-MsgGUID: mkFDnFFuR0mMzQxEpPTMGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121703245"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orviesa005.jf.intel.com with SMTP; 25 Feb 2025 09:49:52 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 25 Feb 2025 19:49:51 +0200
Date: Tue, 25 Feb 2025 19:49:51 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, kam.nasim@intel.com
Subject: Re: [RFC 5/6] drm/xe/pm: D3Cold target state
Message-ID: <Z74Cv8EneHF1frww@intel.com>
References: <20250224164849.3746751-1-anshuman.gupta@intel.com>
 <20250224164849.3746751-6-anshuman.gupta@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224164849.3746751-6-anshuman.gupta@intel.com>
X-Patchwork-Hint: comment

On Mon, Feb 24, 2025 at 10:18:48PM +0530, Anshuman Gupta wrote:
> Trade-off D3Cold target state based upon current vram usages.
> if vram usages is greater then vram_d3cold_threshold and GPU
> has display connected 

Why would anyone care about displays being connected or not?

> then target D3Cold state is D3Cold-VRSR
> otherwise target state is D3COLD-Off.
> 
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/gpu/drm/xe/display/xe_display.c | 22 ++++++++++++++++++++++
>  drivers/gpu/drm/xe/display/xe_display.h |  1 +
>  drivers/gpu/drm/xe/xe_pm.c              | 12 ++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
> index 02a413a07382..140a43d6b1b6 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.c
> +++ b/drivers/gpu/drm/xe/display/xe_display.c
> @@ -548,3 +548,25 @@ int xe_display_probe(struct xe_device *xe)
>  	unset_display_features(xe);
>  	return 0;
>  }
> +
> +bool xe_display_connected(struct xe_device *xe)
> +{
> +	struct drm_connector *list_connector;
> +	struct drm_connector_list_iter iter;
> +	bool ret = false;
> +
> +	mutex_lock(&xe->drm.mode_config.mutex);
> +	drm_connector_list_iter_begin(&xe->drm, &iter);
> +
> +	drm_for_each_connector_iter(list_connector, &iter) {
> +		if (list_connector->status == connector_status_connected) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +
> +	drm_connector_list_iter_end(&iter);
> +	mutex_unlock(&xe->drm.mode_config.mutex);
> +
> +	return ret;
> +}
> diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
> index 685dc74402fb..c6bc54323084 100644
> --- a/drivers/gpu/drm/xe/display/xe_display.h
> +++ b/drivers/gpu/drm/xe/display/xe_display.h
> @@ -40,6 +40,7 @@ void xe_display_pm_resume(struct xe_device *xe);
>  void xe_display_pm_runtime_suspend(struct xe_device *xe);
>  void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
>  void xe_display_pm_runtime_resume(struct xe_device *xe);
> +bool xe_display_connected(struct xe_device *xe);
>  
>  #else
>  
> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
> index 81e67b5693dc..6d28aedcb062 100644
> --- a/drivers/gpu/drm/xe/xe_pm.c
> +++ b/drivers/gpu/drm/xe/xe_pm.c
> @@ -198,6 +198,14 @@ static void xe_rpm_lockmap_release(const struct xe_device *xe)
>  			 &xe_pm_runtime_d3cold_map);
>  }
>  
> +static void xe_pm_suspend_prepare(struct xe_device *xe)
> +{
> +	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> +		xe_pm_d3cold_allowed_toggle(xe);
> +	else
> +		xe->d3cold.allowed = XE_D3COLD_OFF;
> +}
> +
>  /**
>   * xe_pm_suspend - Helper for System suspend, i.e. S0->S3 / S0->S2idle
>   * @xe: xe device instance
> @@ -213,6 +221,8 @@ int xe_pm_suspend(struct xe_device *xe)
>  	drm_dbg(&xe->drm, "Suspending device\n");
>  	trace_xe_pm_suspend(xe, __builtin_return_address(0));
>  
> +	xe_pm_suspend_prepare(xe);
> +
>  	err = xe_pxp_pm_suspend(xe->pxp);
>  	if (err)
>  		goto err;
> @@ -875,6 +885,8 @@ void xe_pm_d3cold_allowed_toggle(struct xe_device *xe)
>  
>  	if (total_vram_used_mb < xe->d3cold.vram_threshold)
>  		xe->d3cold.allowed = XE_D3COLD_OFF;
> +	else if (xe->d3cold.vrsr_capable && xe_display_connected(xe))
> +		xe->d3cold.allowed = XE_D3COLD_VRSR;
>  	else
>  		xe->d3cold.allowed = XE_D3HOT;
>  
> -- 
> 2.34.1

-- 
Ville Syrjälä
Intel

