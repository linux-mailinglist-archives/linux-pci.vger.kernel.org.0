Return-Path: <linux-pci+bounces-37198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D321BA952D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 15:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A183B0A2C
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 13:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC1E3074A4;
	Mon, 29 Sep 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wpsIVqXZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD363074AD;
	Mon, 29 Sep 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152307; cv=none; b=JtGG1NjNEWo+7m4rw1StxgOwnDh/EX7YrMVe8Ws/L/cNZPZNAc1DrIdyOgClZYA13nUE/QPBnYUTeIQraN9vOWkXaoVbtSYEmh7q64nzaOZ/nvEU76o1q8WWgrMVMCXZWf4FjhTho79GI/8Pv2uufwdJywYBgIC60KbDqFDNBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152307; c=relaxed/simple;
	bh=Y8R7eTAgpcmLv0bh6+fpiJKo902IaLWf/7N5REG9FG8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpuWkDkVaM1AE08j72CE2Nz2AwFcZEyy5xJUDaRQkcCmajueGLxMseLaouR2a9HycZeCryobQ8HNBR21SH0e+86wOFAtK2XYHdkuLVkW70uWDs5/+nRBfUyhspvUiyIxKIEQIlq1YvnO+xLFRvU5sd5zq5uKwOVTHUomdjUbDWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wpsIVqXZ; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58TDOjFD2222671;
	Mon, 29 Sep 2025 08:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1759152285;
	bh=prcWhDtDFwhm31ZYO0Nm8Fx4HElPWmjDazDTv82UBZs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=wpsIVqXZkwEZaX6CBQfVBxVDbIiV9kZ3akP6rXAeBkZZn/IzzE6YCuBs2LgZmltXc
	 1qudjEn9dpCDZ7Zdz46r15yI/og3kIh/nOsBgjrXcTMCJH0++APjyPvuqvGVK2Yl91
	 J0KIZs6ZZZdJDJKGXJlJr+MCa5QLSmD8WG59YtnI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58TDOjeq1938466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 29 Sep 2025 08:24:45 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 29
 Sep 2025 08:24:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Sep 2025 08:24:44 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58TDOhwb1549244;
	Mon, 29 Sep 2025 08:24:44 -0500
Date: Mon, 29 Sep 2025 18:54:43 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>,
        Jonathan Cameron
	<jonathan.cameron@huawei.com>,
        Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex
 Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
Message-ID: <20250929132443.6uueg5uazguvdklc@lcpd911>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
 <2238241.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2238241.irdbgypaU6@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 26, 2025 at 17:47:14 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally useful to be able to automatically drop a device's
> runtime PM usage counter incremented by runtime PM operations that
> resume a device and bump up its usage counter [1].
> 
> To that end, add guard definition macros allowing pm_runtime_put()
> and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> those cases.
> 
> Simply put, a piece of code like below:
> 
> 	pm_runtime_get_sync(dev);
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be transformed with guard() like:
> 
> 	guard(pm_runtime_active)(dev);
> 	.....
> 	return 0;
> 
> (see the pm_runtime_put() call is gone).
> 
> However, it is better to do proper error handling in the majority of
> cases, so doing something like this instead of the above is recommended:
> 
> 	ACQUIRE(pm_runtime_active_try, pm)(dev);
> 	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> 		return -ENXIO;
> 	.....
> 	return 0;
> 
> In all of the cases in which runtime PM is known to be enabled for the
> given device or the device can be regarded as operational (and so it can
> be accessed) with runtime PM disabled, a piece of code like:
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be changed as follows:
> 
> 	ACQUIRE(pm_runtime_active_try, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_try, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> (again, see the pm_runtime_put() call is gone).
> 
> Still, if the device cannot be accessed unless runtime PM has been
> enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
> needs to be used, that is (in the context of the example above):
> 
> 	ACQUIRE(pm_runtime_active_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> When the original code calls pm_runtime_put_autosuspend(), use one
> of the "auto" guard variants, pm_runtime_active_auto/_try/_enabled,
> so for example, a piece of code like:
> 
> 	ret = pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	pm_runtime_put_autosuspend(dev);
> 	return 0;
> 
> will become:
> 
> 	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> Note that the cases in which the return value of pm_runtime_get_sync()
> is checked can also be handled with the help of the new class macros.
> For example, a piece of code like:
> 
> 	ret = pm_runtime_get_sync(dev);
> 	if (ret < 0) {
> 		pm_runtime_put(dev);
> 		return ret;
> 	}
> 	.....
> 	pm_runtime_put(dev);
> 	return 0;
> 
> can be rewritten as:
> 
> 	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
> 	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
> 	if (ret < 0)
> 		return ret;
> 	.....
> 	return 0;
> 
> or pm_runtime_get_active_try can be used if transparent handling of
> disabled runtime PM is desirable.
> 
> Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
> Link: https://lore.kernel.org/linux-pm/20250926150613.000073a4@huawei.com/
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v3 -> v4:
>    * Use guard definition macros instead of raw DEFINE_CLASS() (Jonathan)
>    * Change pm_runtime_get_active() helper definition to return an int instead
>      of a pointer
>    * Update changelog to match the new code

It does look like a lot has changed since I last gave my R-by so thanks
for not including it.

> 
> v2 -> v3:
>    * Two more class definitions for the case in which resume errors can be
>      neglected.
>    * Update of new code comments (for more clarity).
>    * Changelog update.
> 
> v1 -> v2:
>    * Rename the new classes and the new static inline helper.
>    * Add two classes for handling disabled runtime PM.
>    * Expand the changelog.
>    * Adjust the subject.
> 
> ---
>  drivers/base/power/runtime.c |    2 +
>  include/linux/pm_runtime.h   |   44 ++++++++++++++++++++++++++++++++++---------
>  2 files changed, 37 insertions(+), 9 deletions(-)
> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
>  		if (dev->power.runtime_status == RPM_ACTIVE &&
>  		    dev->power.last_status == RPM_ACTIVE)
>  			retval = 1;
> +		else if (rpmflags & RPM_TRANSPARENT)
> +			goto out;
>  		else
>  			retval = -EACCES;
>  	}
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -21,6 +21,7 @@
>  #define RPM_GET_PUT		0x04	/* Increment/decrement the
>  					    usage_count */
>  #define RPM_AUTO		0x08	/* Use autosuspend_delay */
> +#define RPM_TRANSPARENT	0x10	/* Succeed if runtime PM is disabled */
>  
>  /*
>   * Use this for defining a set of PM operations to be used in all situations
> @@ -511,6 +512,19 @@ static inline int pm_runtime_get_sync(st
>  	return __pm_runtime_resume(dev, RPM_GET_PUT);
>  }
>  
> +static inline int pm_runtime_get_active(struct device *dev, int rpmflags)
> +{
> +	int ret;
> +
> +	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pm_runtime_resume_and_get - Bump up usage counter of a device and resume it.
>   * @dev: Target device.
> @@ -521,15 +535,7 @@ static inline int pm_runtime_get_sync(st
>   */
>  static inline int pm_runtime_resume_and_get(struct device *dev)
>  {
> -	int ret;
> -
> -	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
> -	if (ret < 0) {
> -		pm_runtime_put_noidle(dev);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return pm_runtime_get_active(dev, 0);
>  }

I do like this reuse indeed.

>  
>  /**
> @@ -606,6 +612,26 @@ static inline int pm_runtime_put_autosus
>  	return __pm_runtime_put_autosuspend(dev);
>  }
>  
> +DEFINE_GUARD(pm_runtime_active, struct device *,
> +	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
> +DEFINE_GUARD(pm_runtime_active_auto, struct device *,
> +	     pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
> +/*
> + * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
> + *
> + * The difference between the "_try" and "_try_enabled" variants is that the
> + * former do not produce an error when runtime PM is disabled for the given
> + * device.
> + */
> +DEFINE_GUARD_COND(pm_runtime_active, _try,
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
> +		  pm_runtime_resume_and_get(_T))
> +DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
> +		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
> +DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
> +		  pm_runtime_resume_and_get(_T))

Overall looks better to me than the earlier revisions, thanks.
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

