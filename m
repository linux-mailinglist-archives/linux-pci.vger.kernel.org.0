Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4C3F3210
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 19:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhHTRNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 13:13:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232087AbhHTRNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 13:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 784C261157;
        Fri, 20 Aug 2021 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629479576;
        bh=jrPY3sKQJsttl32Hs6JRMCy/9rVeImgW84vPT4bXgnU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GU/lhxeqtR0e4UiLayd2eXa8yyEYEtdPOftwGlslO2nBHPbswsoAdp6rD+XGod4Gl
         U/s2etk/SuQjAw7FsT8zIYgxzzoApedxFG14TWw9XnFSs+dn4sHb0f0ITP+2l2NuLT
         eL+Msv0GTfoPro86N0rQec3DAH6PIpmTPr9V+jhgvwb2UoJCGf+HE8Sml9tN1Q0fwR
         /3tcAoozXwodD4ghh5z+a0ydyYj8Sv/Dc/a3D5QJ6+1MPCteEqowKVE2Mg3mFw4NmM
         lnR73RxsZK/HKZZm9+7adiBkio4z2LRwtL/StkiqvvLfP+zlO1gBq7+z/Ewh8DSCzN
         Idc/dNnEx1C6g==
Date:   Fri, 20 Aug 2021 12:12:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH] PCI: VMD: ACPI: Make ACPI companion lookup work for VMD
 bus
Message-ID: <20210820171255.GA3328488@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11834551.O9o76ZdvQC@kreacher>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Shanker, Amey]

On Fri, Aug 20, 2021 at 06:12:39PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some systems, in order to get to the deepest low-power state of
> the platform (which may be necessary to save significant enough
> amounts of energy while suspended to idle. for example), devices on
> the PCI bus exposed by the VMD driver need to be power-managed via
> ACPI.  However, the layout of the ACPI namespace below the VMD
> controller device object does not reflect the layout of the PCI bus
> under the VMD host bridge, so in order to identify the ACPI companion
> objects for the devices on that bus, it is necessary to use a special
> _ADR encoding on the ACPI side.  In other words, acpi_pci_find_companion()
> does not work for these devices, so it needs to be amended with a
> special lookup logic specific to the VMD bus.
> 
> Address this issue by allowing the VMD driver to temporarily install
> an ACPI companion lookup hook containing the code matching the devices
> on the VMD PCI bus with the corresponding objects in the ACPI
> namespace.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>
> ---
>  drivers/pci/controller/vmd.c |   48 ++++++++++++++++++++++++++
>  drivers/pci/host-bridge.c    |    1 
>  drivers/pci/pci-acpi.c       |   78 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h     |    3 +
>  4 files changed, 130 insertions(+)
> 
> Index: linux-pm/drivers/pci/controller/vmd.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/controller/vmd.c
> +++ linux-pm/drivers/pci/controller/vmd.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/srcu.h>
>  #include <linux/rculist.h>
> @@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
>  	.write		= vmd_pci_write,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_dev)
> +{
> +	struct pci_host_bridge *bridge;
> +	u32 busnr, addr;
> +
> +	if (pci_dev->bus->ops != &vmd_ops)
> +		return NULL;
> +
> +	bridge = pci_find_host_bridge(pci_dev->bus);
> +	busnr = pci_dev->bus->number - bridge->bus->number;
> +	addr = (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
> +
> +	dev_dbg(&pci_dev->dev, "Looking for ACPI companion (address 0x%x)\n",
> +		addr);
> +
> +	return acpi_find_child_device(ACPI_COMPANION(bridge->dev.parent), addr,
> +				      false);
> +}
> +
> +static bool hook_installed;
> +
> +static void vmd_acpi_begin(void)
> +{
> +	if (pci_acpi_set_companion_lookup_hook(vmd_acpi_find_companion))
> +		return;
> +
> +	hook_installed = true;
> +}
> +
> +static void vmd_acpi_end(void)
> +{
> +	if (!hook_installed)
> +		return;
> +
> +	pci_acpi_clear_companion_lookup_hook();
> +	hook_installed = false;
> +}
> +#else
> +static inline void vmd_acpi_begin(void) { }
> +static inline void vmd_acpi_end(void) { }
> +#endif /* CONFIG_ACPI */
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> @@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
> +	vmd_acpi_begin();
> +
>  	pci_scan_child_bus(vmd->bus);
>  	pci_assign_unassigned_bus_resources(vmd->bus);

This affects the same path as Shanker's patch to set the
ACPI_COMPANION earlier, in pci_setup_device() instead of in
acpi_bind_one() [1].

I think this should still work correctly since vmd_acpi_begin()
inserts the VMD-specific hook in acpi_pci_find_companion() before we
call pci_scan_child_bus() to enumerate devices below VMD.

So when Shanker's new pci_set_acpi_fwnode() calls
acpi_pci_find_companion(), it should get to vmd_acpi_find_companion()
even though it happens earlier than acpi_bind_one().

Just FYI so you can double check.

> @@ -760,6 +806,8 @@ static int vmd_enable_domain(struct vmd_
>  
>  	pci_bus_add_devices(vmd->bus);
>  
> +	vmd_acpi_end();
> +
>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>  			       "domain"), "Can't create symlink to domain\n");
>  	return 0;
> Index: linux-pm/drivers/pci/host-bridge.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/host-bridge.c
> +++ linux-pm/drivers/pci/host-bridge.c
> @@ -23,6 +23,7 @@ struct pci_host_bridge *pci_find_host_br
>  
>  	return to_pci_host_bridge(root_bus->bridge);
>  }
> +EXPORT_SYMBOL_GPL(pci_find_host_bridge);
>  
>  struct device *pci_get_host_bridge_device(struct pci_dev *dev)
>  {
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1159,6 +1159,72 @@ void acpi_pci_remove_bus(struct pci_bus
>  }
>  
>  /* ACPI bus type */
> +
> +
> +DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);

I don't know anything about static keys, but it looks like it
complicates the code a fair amount, and the doc [2] suggests it's for
performance-sensitive fast path code.

Is this a path that needs that much optimization?  Or is this static
key dance something that's *always* needed when we change a function
pointer at run-time?

> +static DEFINE_MUTEX(pci_acpi_companion_lookup_mtx);
> +static struct acpi_device *(*pci_acpi_find_companion_hook)(struct pci_dev *);
> +
> +/**
> + * pci_acpi_set_companion_lookup_hook - Set ACPI companion lookup callback.
> + * @func: ACPI companion lookup callback pointer or NULL.
> + *
> + * Set a special ACPI companion lookup callback for PCI devices whose companion
> + * objects in the ACPI namespace have _ADR with non-standard bus-device-function
> + * encodings.
> + *
> + * Return 0 on success or a negative error code on failure (in which case no
> + * changes are made).
> + *
> + * The caller is responsible for the appropriate ordering of the invocations of
> + * this function with respect to the enumeration of the PCI devices needing the
> + * callback installed by it.
> + */
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *))
> +{
> +	int ret;
> +
> +	if (!func)
> +		return -EINVAL;
> +
> +	mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +	if (pci_acpi_find_companion_hook) {
> +		ret = -EBUSY;
> +	} else {
> +		pci_acpi_find_companion_hook = func;
> +		static_branch_enable(&pci_acpi_companion_lookup_key);
> +		ret = 0;
> +	}
> +
> +	mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_set_companion_lookup_hook);
> +
> +/**
> + * pci_acpi_clear_companion_lookup_hook - Clear ACPI companion lookup callback.
> + *
> + * Clear the special ACPI companion lookup callback previously set by
> + * pci_acpi_set_companion_lookup_hook().  Block until the last running instance
> + * of the callback returns before clearing it.
> + *
> + * The caller is responsible for the appropriate ordering of the invocations of
> + * this function with respect to the enumeration of the PCI devices needing the
> + * callback cleared by it.
> + */
> +void pci_acpi_clear_companion_lookup_hook(void)
> +{
> +	mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +	pci_acpi_find_companion_hook = NULL;
> +	static_branch_disable(&pci_acpi_companion_lookup_key);
> +
> +	mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_clear_companion_lookup_hook);
> +
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev)
>  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev);
> @@ -1166,6 +1232,18 @@ static struct acpi_device *acpi_pci_find
>  	bool check_children;
>  	u64 addr;
>  
> +	if (static_branch_unlikely(&pci_acpi_companion_lookup_key)) {
> +		mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +		adev = pci_acpi_find_companion_hook ?
> +			pci_acpi_find_companion_hook(pci_dev) : NULL;
> +
> +		mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +
> +		if (adev)
> +			return adev;
> +	}
> +
>  	check_children = pci_is_bridge(pci_dev);
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> Index: linux-pm/include/linux/pci-acpi.h
> ===================================================================
> --- linux-pm.orig/include/linux/pci-acpi.h
> +++ linux-pm/include/linux/pci-acpi.h
> @@ -122,6 +122,9 @@ static inline void pci_acpi_add_edr_noti
>  static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>  #endif /* CONFIG_PCIE_EDR */
>  
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
> +void pci_acpi_clear_companion_lookup_hook(void);
> +
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }

[1] https://lore.kernel.org/r/20210817180937.3123-8-ameynarkhede03@gmail.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/staging/static-keys.rst?id=v5.13
