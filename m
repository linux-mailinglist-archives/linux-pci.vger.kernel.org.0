Return-Path: <linux-pci+bounces-21766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153EAA3AB90
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 23:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F73166282
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 22:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B83D1D6DAD;
	Tue, 18 Feb 2025 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrps7Z44"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE331D5ADD;
	Tue, 18 Feb 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739917213; cv=none; b=HhLmeBgg0jblWRJGqtmqyJa2e6xJjryTR16iOB8u0XiRDkkLFN1oQp5hPjopTpiKQ3HzvjU9vRMGQD6xrWflTK4vw2p6YPoHg+a9qL0yzbUZ4t73c4p/DmVQA8lEZY4jBLKLcG5KrXi/pyTS+5m3qf5IGms9rcAp2gDbEEgapFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739917213; c=relaxed/simple;
	bh=I0IiWl4AnootTxUzZoy1+8cUWjBHZs4frbwCdopXAg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QoFnd4+ntOnlpOFIJDt6ETw09+4Yk5wCkcRdjSeRFMGwWs062sOGtIC6gH85pg7rEXgUwHAI7vIq7/9D9JcibTNvpmHzOPn8JmcfnaLK59ghzToz+yjruEVjHZ1aIZdgwsSUtL3JwSUOlSoZRO0aXMFyoAIYAqMZ8Lg/iRLbZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrps7Z44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279B0C4CEE2;
	Tue, 18 Feb 2025 22:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739917213;
	bh=I0IiWl4AnootTxUzZoy1+8cUWjBHZs4frbwCdopXAg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Rrps7Z44DLlKlKnb0wY8EJKfdtd8Ey5K0Qqk8Ge0taW+FQve+1T9LZzmfk7v4ka2K
	 tsMa+sH8sjsEnjNF9HrryaytVI/lCPW0U3GsE17MBnOJD4jjN3C93dAAVwJ0POGFzB
	 59AJrJj8Bi+ceGQADfBOT2ylJZNWJkItUn0c4CyRCc7sZKIQbvToiumo5KTgRwb/8p
	 8ZARjP57ZlY4xgM4cyeArBDoiW924fvbn89JCYBXcksyAbjFiDz82w6JYE9tMDAAa/
	 hgzWOFs8/ZMEFBH9p4pCpvLLV1uOcuoisXe/FCJMlR79dp0EnCdsF9TU+2yaCayCix
	 js8svsniGh+TA==
Date: Tue, 18 Feb 2025 16:20:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Johan Hovold <johan@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 3/4] PM: sleep: Use DPM_FLAG_SMART_SUSPEND
 conditionally
Message-ID: <20250218222011.GA196831@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1914558.tdWV9SEqCh@rjwysocki.net>

On Tue, Feb 18, 2025 at 09:16:48PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A recent discussion has revealed that using DPM_FLAG_SMART_SUSPEND
> unconditionally is generally problematic because it may lead to
> situations in which the device's runtime PM information is internally
> inconsistent or does not reflect its real state [1].
> 
> For this reason, change the handling of DPM_FLAG_SMART_SUSPEND so that
> it is only taken into account if it is consistently set by the drivers
> of all devices having any PM callbacks throughout dependency graphs in
> accordance with the following rules:
> 
>  - The "smart suspend" feature is only enabled for devices whose drivers
>    ask for it (that is, set DPM_FLAG_SMART_SUSPEND) and for devices
>    without PM callbacks unless they have never had runtime PM enabled.
> 
>  - The "smart suspend" feature is not enabled for a device if it has not
>    been enabled for the device's parent unless the parent does not take
>    children into account or it has never had runtime PM enabled.
> 
>  - The "smart suspend" feature is not enabled for a device if it has not
>    been enabled for one of the device's suppliers taking runtime PM into
>    account unless that supplier has never had runtime PM enabled.
> 
> Namely, introduce a new device PM flag called smart_suspend that is only
> set if the above conditions are met and update all DPM_FLAG_SMART_SUSPEND
> users to check power.smart_suspend instead of directly checking the
> latter.
> 
> At the same time, drop the power.set_active flage introduced recently
> in commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status
> of parents and children") because it is now sufficient to check
> power.smart_suspend along with the dev_pm_skip_resume() return value
> to decide whether or not pm_runtime_set_active() needs to be called
> for the device.
> 
> Link: https://lore.kernel.org/linux-pm/CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com/  [1]
> Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propagation")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # drivers/pci

> ---
> 
> v1 -> v2:
>    * Add helper function for reading power.smart_suspend() (Ulf), add the R-by.
>    * Rearrange conditionals in device_prepare_smart_suspend() so that the checks
>      involving locking are done last.
> 
> ---
>  drivers/acpi/device_pm.c  |    4 +-
>  drivers/base/power/main.c |   63 +++++++++++++++++++++++++++++++++++-----------
>  drivers/mfd/intel-lpss.c  |    2 -
>  drivers/pci/pci-driver.c  |    6 +---
>  include/linux/device.h    |    5 +++
>  include/linux/pm.h        |    2 -
>  6 files changed, 60 insertions(+), 22 deletions(-)
> 
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -1161,7 +1161,7 @@
>   */
>  int acpi_subsys_suspend(struct device *dev)
>  {
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> +	if (!dev_pm_smart_suspend(dev) ||
>  	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
>  		pm_runtime_resume(dev);
>  
> @@ -1320,7 +1320,7 @@
>   */
>  int acpi_subsys_poweroff(struct device *dev)
>  {
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> +	if (!dev_pm_smart_suspend(dev) ||
>  	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
>  		pm_runtime_resume(dev);
>  
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -656,15 +656,13 @@
>  	 * so change its status accordingly.
>  	 *
>  	 * Otherwise, the device is going to be resumed, so set its PM-runtime
> -	 * status to "active" unless its power.set_active flag is clear, in
> +	 * status to "active" unless its power.smart_suspend flag is clear, in
>  	 * which case it is not necessary to update its PM-runtime status.
>  	 */
> -	if (skip_resume) {
> +	if (skip_resume)
>  		pm_runtime_set_suspended(dev);
> -	} else if (dev->power.set_active) {
> +	else if (dev_pm_smart_suspend(dev))
>  		pm_runtime_set_active(dev);
> -		dev->power.set_active = false;
> -	}
>  
>  	if (dev->pm_domain) {
>  		info = "noirq power domain ";
> @@ -1282,14 +1280,8 @@
>  	      dev->power.may_skip_resume))
>  		dev->power.must_resume = true;
>  
> -	if (dev->power.must_resume) {
> -		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
> -			dev->power.set_active = true;
> -			if (dev->parent && !dev->parent->power.ignore_children)
> -				dev->parent->power.set_active = true;
> -		}
> +	if (dev->power.must_resume)
>  		dpm_superior_set_must_resume(dev);
> -	}
>  
>  Complete:
>  	complete_all(&dev->power.completion);
> @@ -1797,6 +1789,49 @@
>  	return error;
>  }
>  
> +static void device_prepare_smart_suspend(struct device *dev)
> +{
> +	struct device_link *link;
> +	int idx;
> +
> +	/*
> +	 * The "smart suspend" feature is enabled for devices whose drivers ask
> +	 * for it and for devices without PM callbacks unless runtime PM is
> +	 * disabled and enabling it is blocked for them.
> +	 *
> +	 * However, if "smart suspend" is not enabled for the device's parent
> +	 * or any of its suppliers that take runtime PM into account, it cannot
> +	 * be enabled for the device either.
> +	 */
> +	dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
> +		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
> +		!pm_runtime_blocked(dev);
> +
> +	if (!dev_pm_smart_suspend(dev))
> +		return;
> +
> +	if (dev->parent && !dev_pm_smart_suspend(dev->parent) &&
> +	    !dev->parent->power.ignore_children && !pm_runtime_blocked(dev->parent)) {
> +		dev->power.smart_suspend = false;
> +		return;
> +	}
> +
> +	idx = device_links_read_lock();
> +
> +	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
> +		if (!(link->flags | DL_FLAG_PM_RUNTIME))
> +			continue;
> +
> +		if (!dev_pm_smart_suspend(link->supplier) &&
> +		    !pm_runtime_blocked(link->supplier)) {
> +			dev->power.smart_suspend = false;
> +			break;
> +		}
> +	}
> +
> +	device_links_read_unlock(idx);
> +}
> +
>  /**
>   * device_prepare - Prepare a device for system power transition.
>   * @dev: Device to handle.
> @@ -1858,6 +1893,7 @@
>  		pm_runtime_put(dev);
>  		return ret;
>  	}
> +	device_prepare_smart_suspend(dev);
>  	/*
>  	 * A positive return value from ->prepare() means "this device appears
>  	 * to be runtime-suspended and its state is fine, so if it really is
> @@ -2033,6 +2069,5 @@
>  
>  bool dev_pm_skip_suspend(struct device *dev)
>  {
> -	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
> -		pm_runtime_status_suspended(dev);
> +	return dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev);
>  }
> --- a/drivers/mfd/intel-lpss.c
> +++ b/drivers/mfd/intel-lpss.c
> @@ -480,7 +480,7 @@
>  
>  static int resume_lpss_device(struct device *dev, void *data)
>  {
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
> +	if (!dev_pm_smart_suspend(dev))
>  		pm_runtime_resume(dev);
>  
>  	return 0;
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -812,8 +812,7 @@
>  	 * suspend callbacks can cope with runtime-suspended devices, it is
>  	 * better to resume the device from runtime suspend here.
>  	 */
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -	    pci_dev_need_resume(pci_dev)) {
> +	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
>  		pm_runtime_resume(dev);
>  		pci_dev->state_saved = false;
>  	} else {
> @@ -1151,8 +1150,7 @@
>  	}
>  
>  	/* The reason to do that is the same as in pci_pm_suspend(). */
> -	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
> -	    pci_dev_need_resume(pci_dev)) {
> +	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
>  		pm_runtime_resume(dev);
>  		pci_dev->state_saved = false;
>  	} else {
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1025,6 +1025,11 @@
>  	return !!(dev->power.driver_flags & flags);
>  }
>  
> +static inline bool dev_pm_smart_suspend(struct device *dev)
> +{
> +	return dev->power.smart_suspend;
> +}
> +
>  static inline void device_lock(struct device *dev)
>  {
>  	mutex_lock(&dev->mutex);
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -680,8 +680,8 @@
>  	bool			syscore:1;
>  	bool			no_pm_callbacks:1;	/* Owned by the PM core */
>  	bool			async_in_progress:1;	/* Owned by the PM core */
> +	bool			smart_suspend:1;	/* Owned by the PM core */
>  	bool			must_resume:1;		/* Owned by the PM core */
> -	bool			set_active:1;		/* Owned by the PM core */
>  	bool			may_skip_resume:1;	/* Set by subsystems */
>  #else
>  	bool			should_wakeup:1;
> 
> 
> 

