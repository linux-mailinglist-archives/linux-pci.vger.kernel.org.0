Return-Path: <linux-pci+bounces-36748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96D1B9513D
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 10:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461B9443551
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 08:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13831D393;
	Tue, 23 Sep 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="umvARm4U"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BB02701CF;
	Tue, 23 Sep 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617638; cv=none; b=TpQMlDeyI7B8Ejms34Uw04oZhqeLnEjEaQXtsZdjJqzBY+oQz4C3To4En6VD0XMBrhmlGXYpRBzfJZjkLMVifZcf0LxdOiPmjlNqffP31NgRwzl9ycRxT29ngNTESBbVmi8ATIYHZdPaohn0mR8SmCOrk3AQZJHJmb0xufQNJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617638; c=relaxed/simple;
	bh=gM93bNnFGIO/wsx+VqzXpIt/RyJuamcNh4RdDqfFoHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXq68EBT3HobO1OPwy8+NDR7hst5XSgFzItGOtmlwiTMEr/eDpk5XiwD47uqXNFFmoLEX421s9naVGsPTG2d091cjJyCQXcX0QGmk1emRMddJ+MZDC6Boj6N1vrhyQZLh9bMkqYs+fHmnHj71K8XWdBV392z0zx8hqywyRQwkPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=umvARm4U; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58N8rPk4970823;
	Tue, 23 Sep 2025 03:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758617605;
	bh=X9S9ewL/z48Jb3cMd5ztxj0pmZs3DnywtEk6GLbOvDY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=umvARm4U/jDs0n0ZUvsyoiWp+8NIL2zXgrth6mIIMeRcjO6E8BccSj9WPMv45wSFy
	 7yeUt14WgL/OuunsWxSfi/WykRGyTV/TPfCnCRO/7BHDzuMFEB+aXov0Wgc1eDBMYy
	 fR/aMGmE+w3y1ug2s+QsaIJ4Vw1rnUJi+AbKO2xc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58N8rPGX2653061
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 23 Sep 2025 03:53:25 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 23
 Sep 2025 03:53:24 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 23 Sep 2025 03:53:24 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58N8rN8j3977318;
	Tue, 23 Sep 2025 03:53:24 -0500
Date: Tue, 23 Sep 2025 14:23:23 +0530
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        LKML
	<linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex
 Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] PM: runtime: Add auto-cleanup macros for "resume
 and get" operations
Message-ID: <20250923085323.sbetukdirhppecz5@lcpd911>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
 <2399578.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2399578.ElGaqSPkdT@rafael.j.wysocki>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Sep 22, 2025 at 17:30:43 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is generally useful to be able to automatically drop a device's
> runtime PM usage counter incremented by runtime PM operations that
> resume a device and bump up its usage counter [1].
> 
> To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
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
> can be transformed with CLASS(pm_runtime_get_sync) like:
> 
> 	guard(pm_runtime_get_sync)(dev);
> 	.....
> 	return 0;
> 
> (see pm_runtime_put() call is gone).
> 
> However, it is better to do proper error handling in the majority of
> cases, so doing something like this instead of the above is recommended:
> 
> 	CLASS(pm_runtime_get_active, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
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
> can be simplified with CLASS() like:
> 
> 	CLASS(pm_runtime_get_active, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
> 
> (again, see pm_runtime_put() call is gone).
> 
> Still, if the device cannot be accessed unless runtime PM has been
> enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
> needs to be used, that is (in the context of the example above):
> 
> 	CLASS(pm_runtime_get_active_enabled, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
> 
> When the original code calls pm_runtime_put_autosuspend(), use one
> of the "auto" class variants, CLASS(pm_runtime_get_active_auto) or
> CLASS(pm_runtime_get_active_enabled_auto), so for example, a piece
> of code like:
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
> 	CLASS(pm_runtime_get_active_enabled_auto, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
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
> 	CLASS(pm_runtime_get_active_enabled, pm)(dev);
> 	if (IS_ERR(pm))
> 		return PTR_ERR(pm);
> 	.....
> 	return 0;
> 
> or CLASS(pm_runtime_get_active) can be used if transparent handling of
> disabled runtime PM is desirable.
> 

Firstly, please can we add all this documentation in runtime_pm [1]
Otherwise there's just far less developers aware of the new APIs getting
introduced other than people directly involved. Not everyone is going to
come down here to look at git log for API docs (even though we proud
ourselves in having git log as our main source of Documentation in
kernel ;) )

[1] https://docs.kernel.org/power/runtime_pm.html

> Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
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
>  include/linux/pm_runtime.h   |   82 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

> 
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
>  		if (dev->power.runtime_status == RPM_ACTIVE &&
>  		    dev->power.last_status == RPM_ACTIVE)
>  			retval = 1;
> +		else if (rpmflags & RPM_TRANSPARENT)
> +			goto out;

"TRANSPARENT" doesn't tell you exactly what happens. It should be something like
RPM_IGNORE_DISABLED or RPM_ALLOW_DISABLED IMO.

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
> @@ -533,6 +534,32 @@ static inline int pm_runtime_resume_and_
>  }
>  
>  /**
> + * pm_runtime_get_active_dev - Resume a device and bump up its usage counter.

I am getting no clue as to why this is different than regular
pm_runtime_get_sync then? Can we describe this API better?

> + * @dev: Target device.
> + * @rpmflags: Additional runtime PM flags to combine with RPM_GET_PUT.
> + *
> + * Resume @dev synchronously and if that is successful, increment its runtime
> + * PM usage counter.
> + *
> + * Return:
> + * * 0 if the runtime PM usage counter of @dev has been incremented.
> + * * Negative error code otherwise.
> + */
> +static inline struct device *pm_runtime_get_active_dev(struct device *dev,
> +						       int rpmflags)
> +{
> +	int ret;
> +
> +	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return dev;
> +}
> +
> +/**
>   * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
>   * @dev: Target device.
>   *
> @@ -606,6 +633,61 @@ static inline int pm_runtime_put_autosus
>  	return __pm_runtime_put_autosuspend(dev);
>  }
>  
> +/*
> + * The way to use the classes defined below is to define a class variable and
> + * use it going forward for representing the target device until it goes out of
> + * the scope.  For example:
> + *
> + * CLASS(pm_runtime_get_active, active_dev)(dev);
> + * if (IS_ERR(active_dev))
> + *         return PTR_ERR(active_dev);
> + *
> + * ... do something with active_dev (which is guaranteed to never suspend) ...
> + *
> + * If an error occurs, the runtime PM usage counter of dev will not be
> + * incremented, so using these classes without error handling is not
> + * recommended.
> + */
> +DEFINE_CLASS(pm_runtime_get_active, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
> +	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_active_auto, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
> +	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
> +
> +/*
> + * The following two classes are analogous to the two classes defined above,
> + * respectively, but they produce an error pointer if runtime PM has been
> + * disabled for the given device.
> + *
> + * They should be used only when runtime PM may be disabled for the given device
> + * and if that happens, the device is not regarded as operational and so it
> + * cannot be accessed.  The classes defined above should be used instead in all
> + * of the other cases.
> + */
> +DEFINE_CLASS(pm_runtime_get_active_enabled, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
> +	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_active_enabled_auto, struct device *,
> +	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
> +	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
> +
> +/*
> + * The following classes may be used instead of the above if resume failures can
> + * be neglected.  However, such cases are not expected to be prevalent, so using
> + * one of these classes should always be regarded as an exception and explained
> + * in an adjacent code comment.
> + */
> +DEFINE_CLASS(pm_runtime_get_sync, struct device *,
> +	     if (_T) pm_runtime_put(_T),
> +	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> +
> +DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
> +	     if (_T) pm_runtime_put_autosuspend(_T),
> +	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> +

However overall I like the idea of introducing these auto cleanups,
probably will help drivers get into fewer troubles with RPM :)

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

