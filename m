Return-Path: <linux-pci+bounces-38352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8BBE3725
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 14:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 610A8358076
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE8F32D7DC;
	Thu, 16 Oct 2025 12:39:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24432860D;
	Thu, 16 Oct 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618342; cv=none; b=TWY4Ly6WO4b4k8Xg0yBNzd0vPXEfOVzbOffedkRCXMKx3Pc0czWodWBHsIk/d9l3jpAnwuenwSaChvdr1ayx3Xrp0NjUJw8PAkHyv2NXQAm0arO7CjyDTbz3MM9N0MlNl6zFchHoyEEPqxx+mb6FqG7abmf86e1q6Sk9GZMDTCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618342; c=relaxed/simple;
	bh=wkWj8uPiFcnVkLdKk+neIeiF8L20PMjDW7F62OEEvAE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPp0DKVBkkri6fRCAi52TOL6805zEFGHAUB/Pnj/Krmmx1V/GlSH5QxS40rcJMj3b5hMiN0ItU+bqTAceQt8AcnLDoeLIsqsB5vYoEmBQ+RQ4wPXd9EzUWR+qT1TioM6FvNjNXRQvpeB0+YJ9AthBQd2MKVxhCzl1Fn3gAjnYZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cnSCh2sntz6L55l;
	Thu, 16 Oct 2025 20:37:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B2CA1402FE;
	Thu, 16 Oct 2025 20:38:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 16 Oct
 2025 13:38:56 +0100
Date: Thu, 16 Oct 2025 13:38:54 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, Mika Westerberg
	<mika.westerberg@linux.intel.com>, "Linux ACPI" <linux-acpi@vger.kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, David Lechner
	<dlechner@baylibre.com>, "Fabio M. De Francesco"
	<fabio.maria.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce
 PM_RUNTIME_ACQUIRE_OR_FAIL() macro
Message-ID: <20251016133854.00003669@huawei.com>
In-Reply-To: <3324926.5fSG56mABF@rafael.j.wysocki>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
	<3324926.5fSG56mABF@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 15 Oct 2025 16:02:02 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> There appears to be an emerging pattern in which guard
> pm_runtime_active_try is used for resuming the given device and
> incrementing its runtime PM usage counter if the resume has been
> successful, that is followed by an ACQUIRE_ERR() check on the guard
> variable and if that triggers, a specific error code is returned, for
> example:
> 
> 	ACQUIRE(pm_runtime_active_try, pm)(dev);
> 	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> 		return -ENXIO
> 
> Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing the
> above sequence of statements that can be used to avoid code duplication
> wherever that sequence would be used.
> 
> Use this macro right away in the PCI sysfs code where the above pattern
> is already present.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Admittedly, the new macro is slightly on the edge, but it really helps
> reduce code duplication, so here it goes.

Fully agree with the 'on the edge'. 

This looks somewhat like the some of the earlier attempts to come up with
a general solution before ACQUIRE().  Linus was fairly clear on his opinion of
a proposal that looked a bit similar to this
cond_guard(mutex_intr, return -EINTR, &mutex);

https://lore.kernel.org/all/CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com/

+CC a few people who might have better memories of where things went than I do.

The solution you have here has the benefit of clarity that all it can do is
return the error code.

Thanks,

Jonathan


> 
> Any feedback (good, bad, ugly) will be appreciated.
> 
> Thanks!
> 
> ---
>  drivers/pci/pci-sysfs.c    |    4 +---
>  include/linux/pm_runtime.h |    5 +++++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1517,9 +1517,7 @@ static ssize_t reset_method_store(struct
>  		return count;
>  	}
>  
> -	ACQUIRE(pm_runtime_active_try, pm)(dev);
> -	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
> -		return -ENXIO;
> +	PM_RUNTIME_ACQUIRE_OR_FAIL(dev, -ENXIO);
>  
>  	if (sysfs_streq(buf, "default")) {
>  		pci_init_reset_methods(pdev);
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -637,6 +637,11 @@ DEFINE_GUARD_COND(pm_runtime_active_auto
>  DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
>  		  pm_runtime_resume_and_get(_T))
>  
> +#define PM_RUNTIME_ACQUIRE_OR_FAIL(dev, error)		\
> +	ACQUIRE(pm_runtime_active_try, __pm)(dev);	\
> +	if (ACQUIRE_ERR(pm_runtime_active_try, &__pm))	\
> +		return error
> +
>  /**
>   * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
>   * @dev: Target device.
> 
> 
> 


