Return-Path: <linux-pci+bounces-44129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB43CFB42E
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 23:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F90F30141CD
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 22:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3092DFA32;
	Tue,  6 Jan 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KOQcflmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2317E0FF;
	Tue,  6 Jan 2026 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767738437; cv=none; b=rKhNqEWSucYEdUfkW4vfdpPgO7H+wAznV/rhzKQL+ZJEC/HD2BkywXFToTQXzpxyTqcDwmwA6E8eYGmBYHdg3JI8/wS91od2p1gDZqraEeY/e/NovIvZJWA0b0rU7GQJIZVdv8ZZ/PW9tQKGyQ2Q5oMHWIdtMDjA0u9Sbq/Dz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767738437; c=relaxed/simple;
	bh=ZKxAHb4+0dtEx92XBAjCVGn08+JIdbzoRMV9WYZxKVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HrGyPIdWEwKlmbur2JZxLfxhQQ6NGd6APY7dY3J4R0vFFyehpK3ktYl8BIDve69lTeL/uNR9oNJ/uQYV26woC8Z4hocw0EWHuLoQgSRE+x1cQwRCSvBnc44zEXqXNgvpNyWGrOGbymT2IsSMVkpiuB3wNKa+xdLx9zpkhTTFEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KOQcflmS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE4C116C6;
	Tue,  6 Jan 2026 22:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767738437;
	bh=ZKxAHb4+0dtEx92XBAjCVGn08+JIdbzoRMV9WYZxKVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KOQcflmSJnJ0ucCaS2W1LWSa2vEkGj+Q6d1TIUl6uwi9Hq2ZxuiOjmO2mZdxwcyD9
	 6JkDZlTmPprXkVyb+zmb9GajYU9Xq9V+GnuK5p9WQCwWf0PesuIL4tkKw0JzjFZZZ2
	 KEyqfVSEH+umUfqipQrpJNUdUxQXsnjBv3K+nw4wOaV7Z4Udyc+oIq3N7o3BMhJ91F
	 BZu1G34YJlgxo/udbsmfa4WelmNJLsPKLHWLK1aXD76dt2I/qXbcxDmzvma8dxnMK2
	 b33Oa/JDgewyz3oPmIhXFn/qPWgbEna7Eg0wh3KKKyCWIiRpnRm8opNQjpsbullGQ3
	 8cP+BuvMdXuMw==
Date: Tue, 6 Jan 2026 16:27:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <20260106222715.GA381397@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid>

On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> Today, it's possible for a PCI device to be created and
> runtime-suspended before it is fully initialized. When that happens, the
> device will remain in D0, but the suspend process may save an
> intermediate version of that device's state -- for example, without
> appropriate BAR configuration. When the device later resumes, we'll
> restore invalid PCI state and the device may not function.
> 
> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> until we've fully initialized the device.
> 
> More details on how exactly this may occur:
> 
> 1. PCI device is created by pci_scan_slot() or similar
> 2. As part of pci_scan_slot(), pci_pm_init() enables runtime PM; the
>    device starts "active" and we initially prevent (pm_runtime_forbid())
>    suspend -- but see [*] footnote
> 3. Underlying 'struct device' is added to the system (device_add());
>    runtime PM can now be configured by user space
> 4. PCI device receives BAR configuration
>    (pci_assign_unassigned_bus_resources(), etc.)
> 5. PCI device is added to the system in pci_bus_add_device()
> 
> The device may potentially suspend between #3 and #4.
> 
> [*] By default, pm_runtime_forbid() prevents suspending a device; but by
> design [**], this can be overridden by user space policy via
> 
>   echo auto > /sys/bus/pci/devices/.../power/control
> 
> Thus, the above #3/#4 sequence is racy with user space (udev or
> similar).
> 
> Notably, many PCI devices are enumerated at subsys_initcall time and so
> will not race with user space. However, there are several scenarios
> where PCI devices are created later on, such as with hotplug or when
> drivers (pwrctrl or controller drivers) are built as modules.
> 
>   ---
> 
> [**] The relationship between pm_runtime_forbid(), pm_runtime_allow(),
> /sys/.../power/control, and the runtime PM usage counter can be subtle.
> It appears that the intention of pm_runtime_forbid() /
> pm_runtime_allow() is twofold:
> 
> 1. Allow the user to disable runtime_pm (force device to always be
>    powered on) through sysfs.
> 2. Allow the driver to start with runtime_pm disabled (device forced
>    on) and user space could later enable runtime_pm.
> 
> This conclusion comes from reading `Documentation/power/runtime_pm.rst`,
> specifically the section starting "The user space can effectively
> disallow".
> 
> This means that while pm_runtime_forbid() does technically increase the
> runtime PM usage counter, this usage counter is not a guarantee of
> functional correctness, because sysfs can decrease that count again.
> 
>   ---
> 
> Note that we also move pm_runtime_set_active(), but leave
> pm_runtime_forbid() in place earlier in the initialization sequence, to
> avoid confusing user space. From Documentation/power/runtime_pm.rst:
> 
>   "It should be noted, however, that if the user space has already
>   intentionally changed the value of /sys/devices/.../power/control to
>   "auto" to allow the driver to power manage the device at run time, the
>   driver may confuse it by using pm_runtime_forbid() this way."
> 
> Thus, we should ensure pm_runtime_forbid() is called before the device
> is available to user space.
> 
> Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

Applied to pci/pm for v6.20, thanks!  I tried to simplify the commit
log so the issue isn't hidden by details.  Happy to restore things if
I trimmed too much:

    PCI/PM: Prevent runtime suspend until devices are fully initialized

    Previously, it was possible for a PCI device to be runtime-suspended before
    it was fully initialized. When that happened, the suspend process could
    save invalid device state, for example, before BAR assignment. Restoring
    the invalid state during resume may leave the device non-functional.

    Prevent runtime suspend for PCI devices until they are fully initialized by
    deferring pm_runtime_enable().

    More details on how exactly this may occur:

      1. PCI device is created by pci_scan_slot() or similar

      2. As part of pci_scan_slot(), pci_pm_init() puts the device in D0 and
         prevents runtime suspend prevented via pm_runtime_forbid()

      3. pci_device_add() adds the underlying 'struct device' via device_add(),
         which means user space can allow runtime suspend, e.g.,

           echo auto > /sys/bus/pci/devices/.../power/control

      4. PCI device receives BAR configuration
         (pci_assign_unassigned_bus_resources(), etc.)

      5. pci_bus_add_device() applies final fixups, saves device state, and
         tries to attach a driver

    The device may potentially be suspended between #3 and #5, so this is racy
    with user space (udev or similar).

    Many PCI devices are enumerated at subsys_initcall time and so will not
    race with user space, but devices created later by hotplug or modular
    pwrctrl or host controller drivers are susceptible to this race.

    More runtime PM details at the first Link: below.

    Signed-off-by: Brian Norris <briannorris@chromium.org>
    [bhelgaas: simplify commit log]
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
    Cc: stable@vger.kernel.org
    Link: https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
    Link: https://patch.msgid.link/20251023140901.v4.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid


> ---
> 
> Changes in v4:
>  * Move pm_runtime_set_active() too
> 
> Changes in v3:
>  * Add Link to initial discussion
>  * Add Rafael's Reviewed-by
>  * Add lengthier footnotes about forbid vs allow vs sysfs
> 
> Changes in v2:
>  * Update CC list
>  * Rework problem description
>  * Update solution: defer pm_runtime_enable(), instead of trying to
>    get()/put()
> 
>  drivers/pci/bus.c | 4 ++++
>  drivers/pci/pci.c | 2 --
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index f26aec6ff588..40ff954f416f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/proc_fs.h>
>  #include <linux/slab.h>
>  
> @@ -375,6 +376,9 @@ void pci_bus_add_device(struct pci_dev *dev)
>  		put_device(&pdev->dev);
>  	}
>  
> +	pm_runtime_set_active(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
> +
>  	if (!dn || of_device_is_available(dn))
>  		pci_dev_allow_binding(dev);
>  
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b14dd064006c..234bf3608569 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3225,8 +3225,6 @@ void pci_pm_init(struct pci_dev *dev)
>  poweron:
>  	pci_pm_power_up_and_verify_state(dev);
>  	pm_runtime_forbid(&dev->dev);
> -	pm_runtime_set_active(&dev->dev);
> -	pm_runtime_enable(&dev->dev);
>  }
>  
>  static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
> -- 
> 2.51.1.821.gb6fe4d2222-goog
> 

