Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E003F77E7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 17:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhHYPA4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 11:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240940AbhHYPA4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Aug 2021 11:00:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2EB1610A3;
        Wed, 25 Aug 2021 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629903610;
        bh=z+SL1qSOKfX+EYIPWXgX+rkFU1mpn+MaH/WPx3ItD5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=haULs6m9Hib8iBcIMIUE2K5Enk4k2cn217YxRia98FwxS2Wo2LJoisW26N/TUSj3n
         VPEglMqx40cCesvZyhm3hUpCzsAmn8993v0cOxNnbZYfSI5GKz5/Ge/+33j8UUvUpY
         hq4U6sKlFhD2BdqyO6hHXnSAPfn+VKx4uR4NC799FhnkUz2srBZbQn0ruAU7umf5u5
         793EapZ32AKWzqOoHb+ZyCq1a+sbrTRbJFNNVcH9DI8XQRr1Im2q9t/HdOFCKEstQV
         Qu2EN5vhYFmohMslKkqxJLeIIRCw84d9y2crwB2lhi+jskqDsL60XwNCjrlEgwazkj
         mo394WMqwA+yw==
Date:   Wed, 25 Aug 2021 10:00:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Wang, Wendy" <wendy.wang@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Box <david.e.box@linux.intel.com>
Subject: Re: [PATCH v2] PCI: VMD: ACPI: Make ACPI companion lookup work for
 VMD bus
Message-ID: <20210825150008.GA3567157@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB32449145A9E3779A480F01D69FC69@DM6PR11MB3244.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 11:02:47AM +0000, Wang, Wendy wrote:
> Hi Rafael,
> 
> Tested this PATCH v2 against intel next v5.12 kernel on ADL-S NVME and SATA storages:
> 
> cat /sys/devices/pci0000\:00/0000\:00\:0e.0/firmware_node/path
> \_SB_.PC00.VMD0
> 
> 10000:e0:17.0 SATA controller: Intel Corporation Device 7ae2 (rev 11)
> 10000:e0:1d.0 System peripheral: Intel Corporation Device 09ab
> 10000:e0:1d.4 PCI bridge: Intel Corporation Device 7ab4 (rev 11)
> 10000:e1:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM9A1/PM9A3/980PRO
> 
> [ 6193.658074] ahci 10000:e0:17.0: PCI PM: Suspend power state: D3hot
> [ 6193.658156] nvme 10000:e1:00.0: PCI PM: Suspend power state: D3hot
> [ 6193.710883] pcieport 10000:e0:1d.4: PCI PM: Suspend power state: D3cold
> [ 6193.730318] vmd 0000:00:0e.0: PCI PM: Suspend power state: D3hot
> 
> cat /sys/kernel/debug/pmc_core/substate_residencies
> Substate   Residency
> S0i2.0     0
> S0i2.1     13862128
> 
> Thanks!

I guess (given Rafael's response) that this is a positive test result,
i.e., you see the desired behavior with this patch?

Bjorn

> -----Original Message-----
> From: Rafael J. Wysocki <rjw@rjwysocki.net> 
> Sent: Tuesday, August 24, 2021 10:44 PM
> To: Linux PCI <linux-pci@vger.kernel.org>; Derrick, Jonathan <jonathan.derrick@intel.com>; Bjorn Helgaas <helgaas@kernel.org>
> Cc: Wang, Wendy <wendy.wang@intel.com>; Linux ACPI <linux-acpi@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Mika Westerberg <mika.westerberg@linux.intel.com>; David Box <david.e.box@linux.intel.com>
> Subject: [PATCH v2] PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus
> 
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some systems, in order to get to the deepest low-power state of the platform (which may be necessary to save significant enough amounts of energy while suspended to idle. for example), devices on the PCI bus exposed by the VMD driver need to be power-managed via ACPI.  However, the layout of the ACPI namespace below the VMD controller device object does not reflect the layout of the PCI bus under the VMD host bridge, so in order to identify the ACPI companion objects for the devices on that bus, it is necessary to use a special _ADR encoding on the ACPI side.  In other words, acpi_pci_find_companion() does not work for these devices, so it needs to be amended with a special lookup logic specific to the VMD bus.
> 
> Address this issue by allowing the VMD driver to temporarily install an ACPI companion lookup hook containing the code matching the devices on the VMD PCI bus with the corresponding objects in the ACPI namespace.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> -> v2:
>    * Use a read-write semaphore for hook manipulation protection and
>      get rid of the static key present in the previous version.
>    * Add a busnr check in vmd_acpi_find_companion().
> 
> Wendy, David, please test this one!
> 
> ---
>  drivers/pci/controller/vmd.c |   55 +++++++++++++++++++++++++++++++
>  drivers/pci/host-bridge.c    |    1 
>  drivers/pci/pci-acpi.c       |   74 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h     |    3 +
>  4 files changed, 133 insertions(+)
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
> @@ -447,6 +448,56 @@ static struct pci_ops vmd_ops = {
>  	.write		= vmd_pci_write,
>  };
>  
> +#ifdef CONFIG_ACPI
> +static struct acpi_device *vmd_acpi_find_companion(struct pci_dev 
> +*pci_dev) {
> +	struct pci_host_bridge *bridge;
> +	u32 busnr, addr;
> +
> +	if (pci_dev->bus->ops != &vmd_ops)
> +		return NULL;
> +
> +	bridge = pci_find_host_bridge(pci_dev->bus);
> +	busnr = pci_dev->bus->number - bridge->bus->number;
> +	/*
> +	 * The address computation below is only applicable to relative bus
> +	 * numbers below 32.
> +	 */
> +	if (busnr > 31)
> +		return NULL;
> +
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
> +static inline void vmd_acpi_begin(void) { } static inline void 
> +vmd_acpi_end(void) { } #endif /* CONFIG_ACPI */
> +
>  static void vmd_attach_resources(struct vmd_dev *vmd)  {
>  	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1]; @@ -747,6 +798,8 @@ static int vmd_enable_domain(struct vmd_
>  	if (vmd->irq_domain)
>  		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>  
> +	vmd_acpi_begin();
> +
>  	pci_scan_child_bus(vmd->bus);
>  	pci_assign_unassigned_bus_resources(vmd->bus);
>  
> @@ -760,6 +813,8 @@ static int vmd_enable_domain(struct vmd_
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
>  struct device *pci_get_host_bridge_device(struct pci_dev *dev)  {
> Index: linux-pm/drivers/pci/pci-acpi.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -17,6 +17,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
> +#include <linux/rwsem.h>
>  #include "pci.h"
>  
>  /*
> @@ -1159,6 +1160,69 @@ void acpi_pci_remove_bus(struct pci_bus  }
>  
>  /* ACPI bus type */
> +
> +
> +static DECLARE_RWSEM(pci_acpi_companion_lookup_sem);
> +static struct acpi_device *(*pci_acpi_find_companion_hook)(struct 
> +pci_dev *);
> +
> +/**
> + * pci_acpi_set_companion_lookup_hook - Set ACPI companion lookup callback.
> + * @func: ACPI companion lookup callback pointer or NULL.
> + *
> + * Set a special ACPI companion lookup callback for PCI devices whose 
> +companion
> + * objects in the ACPI namespace have _ADR with non-standard 
> +bus-device-function
> + * encodings.
> + *
> + * Return 0 on success or a negative error code on failure (in which 
> +case no
> + * changes are made).
> + *
> + * The caller is responsible for the appropriate ordering of the 
> +invocations of
> + * this function with respect to the enumeration of the PCI devices 
> +needing the
> + * callback installed by it.
> + */
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device 
> +*(*func)(struct pci_dev *)) {
> +	int ret;
> +
> +	if (!func)
> +		return -EINVAL;
> +
> +	down_write(&pci_acpi_companion_lookup_sem);
> +
> +	if (pci_acpi_find_companion_hook) {
> +		ret = -EBUSY;
> +	} else {
> +		pci_acpi_find_companion_hook = func;
> +		ret = 0;
> +	}
> +
> +	up_write(&pci_acpi_companion_lookup_sem);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_set_companion_lookup_hook);
> +
> +/**
> + * pci_acpi_clear_companion_lookup_hook - Clear ACPI companion lookup callback.
> + *
> + * Clear the special ACPI companion lookup callback previously set by
> + * pci_acpi_set_companion_lookup_hook().  Block until the last running 
> +instance
> + * of the callback returns before clearing it.
> + *
> + * The caller is responsible for the appropriate ordering of the 
> +invocations of
> + * this function with respect to the enumeration of the PCI devices 
> +needing the
> + * callback cleared by it.
> + */
> +void pci_acpi_clear_companion_lookup_hook(void)
> +{
> +	down_write(&pci_acpi_companion_lookup_sem);
> +
> +	pci_acpi_find_companion_hook = NULL;
> +
> +	up_write(&pci_acpi_companion_lookup_sem);
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_clear_companion_lookup_hook);
> +
>  static struct acpi_device *acpi_pci_find_companion(struct device *dev)  {
>  	struct pci_dev *pci_dev = to_pci_dev(dev); @@ -1166,6 +1230,16 @@ static struct acpi_device *acpi_pci_find
>  	bool check_children;
>  	u64 addr;
>  
> +	down_read(&pci_acpi_companion_lookup_sem);
> +
> +	adev = pci_acpi_find_companion_hook ?
> +		pci_acpi_find_companion_hook(pci_dev) : NULL;
> +
> +	up_read(&pci_acpi_companion_lookup_sem);
> +
> +	if (adev)
> +		return adev;
> +
>  	check_children = pci_is_bridge(pci_dev);
>  	/* Please ref to ACPI spec for the syntax of _ADR */
>  	addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> Index: linux-pm/include/linux/pci-acpi.h ===================================================================
> --- linux-pm.orig/include/linux/pci-acpi.h
> +++ linux-pm/include/linux/pci-acpi.h
> @@ -122,6 +122,9 @@ static inline void pci_acpi_add_edr_noti  static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }  #endif /* CONFIG_PCIE_EDR */
>  
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device 
> +*(*func)(struct pci_dev *)); void 
> +pci_acpi_clear_companion_lookup_hook(void);
> +
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> 
> 
> 
