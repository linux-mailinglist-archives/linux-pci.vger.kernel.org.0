Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D85A2CF765
	for <lists+linux-pci@lfdr.de>; Sat,  5 Dec 2020 00:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLDXWI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 18:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgLDXWI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Dec 2020 18:22:08 -0500
Date:   Fri, 4 Dec 2020 17:21:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607124087;
        bh=jcN9PbMgOLCkW/eP5nH6XSM0/5/dbV78dPtpbOxyH3w=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=QqgauAw1WS/afGO36xcC6AzO0lwg2sUSG5XaJj47SNxVwB45+PaMKQyXPTE1uxA2D
         2ADrk6Hd+aNpzENCvjKpuKfjWvTDaIcuyXqRKMZiZVn55JjPa6jIFG1rh2HP1R9aRs
         kjyT1dcfh6WUCZkjSBb7yvMA6hLuvk+YBxh8tFx9P4PwZ+d4ww5QtWSXClEQLmFb7c
         HVjZh/rfpG6uKfoYj8jn2+8Ah4HHR5iBBMP/j6vTUG+UsPcYK147BJBxb9g9LLJzSF
         RfkSYJkNRPiPLQd1fztTn/GP+y1oDuj4qOAApBEQbQaXopbp5PQpBfRpzu7Ry/8BtQ
         XC7S7TNYdcRUw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/2] PM: ACPI: PCI: Drop acpi_pm_set_bridge_wakeup()
Message-ID: <20201204232125.GA1981160@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2261308.G18gbxz5ee@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 24, 2020 at 08:44:00PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The idea behind acpi_pm_set_bridge_wakeup() was to allow bridges to
> be reference counted for wakeup enabling, because they may be enabled
> to signal wakeup on behalf of their subordinate devices and that
> may happen for multiple times in a row, whereas for the other devices
> it only makes sense to enable wakeup signaling once.
> 
> However, this becomes problematic if the bridge itself is suspended,
> because it is treated as a "regular" device in that case and the
> reference counting doesn't work.
> 
> For instance, suppose that there are two devices below a bridge and
> they both can signal wakeup.  Every time one of them is suspended,
> wakeup signaling is enabled for the bridge, so when they both have
> been suspended, the bridge's wakeup reference counter value is 2.
> 
> Say that the bridge is suspended subsequently and acpi_pci_wakeup()
> is called for it.  Because the bridge can signal wakeup, that
> function will invoke acpi_pm_set_device_wakeup() to configure it
> and __acpi_pm_set_device_wakeup() will be called with the last
> argument equal to 1.  This causes __acpi_device_wakeup_enable()
> invoked by it to omit the reference counting, because the reference
> counter of the target device (the bridge) is 2 at that time.
> 
> Now say that the bridge resumes and one of the device below it
> resumes too, so the bridge's reference counter becomes 0 and
> wakeup signaling is disabled for it, but there is still the other
> suspended device which may need the bridge to signal wakeup on its
> behalf and that is not going to work.
> 
> To address this scenario, use wakeup enable reference counting for
> all devices, not just for bridges, so drop the last argument from
> __acpi_device_wakeup_enable() and __acpi_pm_set_device_wakeup(),
> which causes acpi_pm_set_device_wakeup() and
> acpi_pm_set_bridge_wakeup() to become identical, so drop the latter
> and use the former instead of it everywhere.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/acpi/device_pm.c |   41 ++++++++++++-----------------------------
>  drivers/pci/pci-acpi.c   |    4 ++--
>  include/acpi/acpi_bus.h  |    5 -----
>  3 files changed, 14 insertions(+), 36 deletions(-)
> 
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -620,7 +620,6 @@ acpi_status acpi_remove_pm_notifier(stru
>  bool acpi_pm_device_can_wakeup(struct device *dev);
>  int acpi_pm_device_sleep_state(struct device *, int *, int);
>  int acpi_pm_set_device_wakeup(struct device *dev, bool enable);
> -int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable);
>  #else
>  static inline void acpi_pm_wakeup_event(struct device *dev)
>  {
> @@ -651,10 +650,6 @@ static inline int acpi_pm_set_device_wak
>  {
>  	return -ENODEV;
>  }
> -static inline int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
> -{
> -	return -ENODEV;
> -}
>  #endif
>  
>  #ifdef CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT
> Index: linux-pm/drivers/acpi/device_pm.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/device_pm.c
> +++ linux-pm/drivers/acpi/device_pm.c
> @@ -749,7 +749,7 @@ static void acpi_pm_notify_work_func(str
>  static DEFINE_MUTEX(acpi_wakeup_lock);
>  
>  static int __acpi_device_wakeup_enable(struct acpi_device *adev,
> -				       u32 target_state, int max_count)
> +				       u32 target_state)
>  {
>  	struct acpi_device_wakeup *wakeup = &adev->wakeup;
>  	acpi_status status;
> @@ -757,9 +757,10 @@ static int __acpi_device_wakeup_enable(s
>  
>  	mutex_lock(&acpi_wakeup_lock);
>  
> -	if (wakeup->enable_count >= max_count)
> +	if (wakeup->enable_count >= INT_MAX) {
> +		acpi_handle_info(adev->handle, "Wakeup enable count out of bounds!\n");
>  		goto out;
> -
> +	}
>  	if (wakeup->enable_count > 0)
>  		goto inc;
>  
> @@ -799,7 +800,7 @@ out:
>   */
>  static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
>  {
> -	return __acpi_device_wakeup_enable(adev, target_state, 1);
> +	return __acpi_device_wakeup_enable(adev, target_state);
>  }
>  
>  /**
> @@ -829,8 +830,12 @@ out:
>  	mutex_unlock(&acpi_wakeup_lock);
>  }
>  
> -static int __acpi_pm_set_device_wakeup(struct device *dev, bool enable,
> -				       int max_count)
> +/**
> + * acpi_pm_set_device_wakeup - Enable/disable remote wakeup for given device.
> + * @dev: Device to enable/disable to generate wakeup events.
> + * @enable: Whether to enable or disable the wakeup functionality.
> + */
> +int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
>  {
>  	struct acpi_device *adev;
>  	int error;
> @@ -850,37 +855,15 @@ static int __acpi_pm_set_device_wakeup(s
>  		return 0;
>  	}
>  
> -	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state(),
> -					    max_count);
> +	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state());
>  	if (!error)
>  		dev_dbg(dev, "Wakeup enabled by ACPI\n");
>  
>  	return error;
>  }
> -
> -/**
> - * acpi_pm_set_device_wakeup - Enable/disable remote wakeup for given device.
> - * @dev: Device to enable/disable to generate wakeup events.
> - * @enable: Whether to enable or disable the wakeup functionality.
> - */
> -int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
> -{
> -	return __acpi_pm_set_device_wakeup(dev, enable, 1);
> -}
>  EXPORT_SYMBOL_GPL(acpi_pm_set_device_wakeup);
>  
>  /**
> - * acpi_pm_set_bridge_wakeup - Enable/disable remote wakeup for given bridge.
> - * @dev: Bridge device to enable/disable to generate wakeup events.
> - * @enable: Whether to enable or disable the wakeup functionality.
> - */
> -int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
> -{
> -	return __acpi_pm_set_device_wakeup(dev, enable, INT_MAX);
> -}
> -EXPORT_SYMBOL_GPL(acpi_pm_set_bridge_wakeup);
> -
> -/**
>   * acpi_dev_pm_low_power - Put ACPI device into a low-power state.
>   * @dev: Device to put into a low-power state.
>   * @adev: ACPI device node corresponding to @dev.
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1060,7 +1060,7 @@ static int acpi_pci_propagate_wakeup(str
>  {
>  	while (bus->parent) {
>  		if (acpi_pm_device_can_wakeup(&bus->self->dev))
> -			return acpi_pm_set_bridge_wakeup(&bus->self->dev, enable);
> +			return acpi_pm_set_device_wakeup(&bus->self->dev, enable);
>  
>  		bus = bus->parent;
>  	}
> @@ -1068,7 +1068,7 @@ static int acpi_pci_propagate_wakeup(str
>  	/* We have reached the root bus. */
>  	if (bus->bridge) {
>  		if (acpi_pm_device_can_wakeup(bus->bridge))
> -			return acpi_pm_set_bridge_wakeup(bus->bridge, enable);
> +			return acpi_pm_set_device_wakeup(bus->bridge, enable);
>  	}
>  	return 0;
>  }
> 
> 
> 
