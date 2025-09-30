Return-Path: <linux-pci+bounces-37267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F45ABADE79
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1E351946280
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5773093B2;
	Tue, 30 Sep 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tCEBw3+t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD19306B3B;
	Tue, 30 Sep 2025 15:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246254; cv=none; b=dkjG8tEmIfvGtzTaz2V4iPXmqcYRd8tGaX/t1JZtdRR1vlTG2rQYegx2/xHpKOKxxMJ0JnXP3+kTq8UPs1tHqLBDiy+WmyMS9cLrrUj0ozd/Fp0WkcbP72JzqrNrECy/mW2o5mN33ShD/kAbJRwhaJ3OZU+MgLsMkf15bV87z+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246254; c=relaxed/simple;
	bh=CGbVcM8ju3qjrdPZ21/z8N4JCGXx5YjM1sfmbIWyasc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKGwTp4yzTi4egmt+KwfplDCrkALeLuMR6F7Ej0ROFPE9EqI1Q1ppK+uSjnOZKTMWHqSwUytGXUSP44aSCCZ1WrShRM4W/PWv2jWcBGe7SETVcuL8749RxdcCGu82Hl062QeSqRIvl1zOFFf5bsj+xw5SShAOojqYOvekTd8wwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tCEBw3+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0F3C4CEF0;
	Tue, 30 Sep 2025 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759246254;
	bh=CGbVcM8ju3qjrdPZ21/z8N4JCGXx5YjM1sfmbIWyasc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tCEBw3+tEmkND18XuyxJBrg8EfrD16eJ5MBDBh3mT33TbMoQO2H/8G+6/NGOahQB/
	 rJkhpuSirxsVCI6efAWc6KUPxSlz6PLx5xFy55s8kJ4K15ubg10CeOE+6YzJVaMVKd
	 pl9X1kJxTWLdKjNcFL3EE/JvDHbhaSPsbLqutZ5I=
Date: Tue, 30 Sep 2025 17:26:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>,
	Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
Message-ID: <2025093023-frantic-sediment-9849@gregkh>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-luo-pci-v2-2-c494053c3c08@kernel.org>

On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
>  #define pr_fmt(fmt) "PCI liveupdate: " fmt
> +#define dev_fmt(fmt) "PCI liveupdate: " fmt

Please no.  Use the default dev_ formatting so that people can correct
track the devices spitting out messages here.

> +#include <linux/types.h>
>  #include <linux/liveupdate.h>
> +#include "pci.h"
>  
>  #define PCI_SUBSYSTEM_NAME "pci"

I still don't know why this is needed, why?

>  
> +static void stack_push_buses(struct list_head *stack, struct list_head *buses)
> +{
> +	struct pci_bus *bus;
> +
> +	list_for_each_entry(bus, buses, node)
> +		list_move_tail(&bus->dev.lu.lu_next, stack);
> +}
> +
> +static void liveupdate_add_dev(struct device *dev, struct list_head *head)
> +{
> +	dev_info(dev, "collect liveupdate device: flags %x\n", dev->lu.flags);

Debugging code can go away please.

> +	list_move_tail(&dev->lu.lu_next, head);
> +}
> +
> +static int collect_bus_devices_reverse(struct pci_bus *bus, struct list_head *head)
> +{
> +	struct pci_dev *pdev;
> +	int count = 0;
> +
> +	list_for_each_entry_reverse(pdev, &bus->devices, bus_list) {

Why are you allowed to walk the pci bus list here?  Shouldn't there be
some type of core function to do that?

And why in reverse?

> +		if (pdev->dev.lu.flags & LU_BUSMASTER &&  pdev->dev.parent)
> +			pdev->dev.parent->lu.flags |= LU_BUSMASTER_BRIDGE;
> +		if (pdev->dev.lu.flags) {
> +			liveupdate_add_dev(&pdev->dev, head);
> +			count++;

No locking?

> +		}
> +	}
> +	return count;

What prevents this value from changing right after you return it?

> +}
> +
> +static int build_liveupdate_devices(struct list_head *head)
> +{
> +	LIST_HEAD(bus_stack);
> +	int count = 0;
> +
> +	stack_push_buses(&bus_stack, &pci_root_buses);
> +
> +	while (!list_empty(&bus_stack)) {
> +		struct device *busdev;
> +		struct pci_bus *bus;
> +
> +		busdev = list_last_entry(&bus_stack, struct device, lu.lu_next);
> +		bus = to_pci_bus(busdev);
> +		if (!busdev->lu.visited && !list_empty(&bus->children)) {
> +			stack_push_buses(&bus_stack, &bus->children);
> +			busdev->lu.visited = 1;
> +			continue;
> +		}
> +
> +		count += collect_bus_devices_reverse(bus, head);
> +		busdev->lu.visited = 0;
> +		list_del_init(&busdev->lu.lu_next);
> +	}
> +	return count;

A comment here about what you are trying to do with walking the list of
devices.  Somehow.  Are you sure that's right?  It feels backwards, and
the lack of any locking makes me very nervous.  How is this integrating
into the normal driver model lists?

> +}
> +
> +static void cleanup_liveupdate_devices(struct list_head *head)
> +{
> +	struct device *d, *n;
> +
> +	list_for_each_entry_safe(d, n, head, lu.lu_next) {
> +		d->lu.flags &= ~LU_DEPENDED;
> +		list_del_init(&d->lu.lu_next);
> +	}
> +}

What does "cleanup" mean?

> +
>  static int pci_liveupdate_prepare(void *arg, u64 *data)
>  {
> +	LIST_HEAD(requested_devices);
> +
>  	pr_info("prepare data[%llx]\n", *data);

Addresses written to the kernel log?

> +
> +	pci_lock_rescan_remove();
> +	down_write(&pci_bus_sem);
> +
> +	build_liveupdate_devices(&requested_devices);

Ah, you lock here.  Document the heck out of this and put the proper
build macros in there so we know what is going on.

> +	cleanup_liveupdate_devices(&requested_devices);
> +
> +	up_write(&pci_bus_sem);

Why is it a write?  You aren't modifying the list, are you?

> +	pci_unlock_rescan_remove();
>  	return 0;
>  }
>  
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index e8318fd5f6ed537a1b236a3a0f054161d5710abd..0e9ef387182856771d857181d88f376632b46f0d 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -304,6 +304,7 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
>  	device = &pcie->device;
>  	device->bus = &pcie_port_bus_type;
>  	device->release = release_pcie_device;	/* callback to free pcie dev */
> +	dev_liveupdate_init(device);

Why here?

>  	dev_set_name(device, "%s:pcie%03x",
>  		     pci_name(pdev),
>  		     get_descriptor_id(pci_pcie_type(pdev), service));
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c67fc1655e0057b3b96b4098e6630..dddd7ebc03d1a6e6ee456e0bf02ab9833a819509 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -614,6 +614,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
>  	INIT_LIST_HEAD(&b->devices);
>  	INIT_LIST_HEAD(&b->slots);
>  	INIT_LIST_HEAD(&b->resources);
> +	dev_liveupdate_init(&b->dev);

Same, why here?  Shouldn't the driver core be doing this all for you
automatically?  Are you going to make each bus do this manually?

>  	b->max_bus_speed = PCI_SPEED_UNKNOWN;
>  	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
>  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> @@ -1985,6 +1986,7 @@ int pci_setup_device(struct pci_dev *dev)
>  	dev->sysdata = dev->bus->sysdata;
>  	dev->dev.parent = dev->bus->bridge;
>  	dev->dev.bus = &pci_bus_type;
> +	dev_liveupdate_init(&dev->dev);

Looks like you are :(

Do it in one place please.

>  	dev->hdr_type = hdr_type & 0x7f;
>  	dev->multifunction = !!(hdr_type & 0x80);
>  	dev->error_state = pci_channel_io_normal;
> @@ -3184,7 +3186,7 @@ struct pci_bus *pci_create_root_bus(struct device *parent, int bus,
>  		return NULL;
>  
>  	bridge->dev.parent = parent;
> -
> +	dev_liveupdate_init(&bridge->dev);

Again, one place.

>  	list_splice_init(resources, &bridge->windows);
>  	bridge->sysdata = sysdata;
>  	bridge->busnr = bus;
> diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..72297cba08a999e89f7bc0997dabdbe14e0aa12c
> --- /dev/null
> +++ b/include/linux/dev_liveupdate.h
> @@ -0,0 +1,44 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (c) 2025, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + * Chris Li <chrisl@kernel.org>
> + */
> +#ifndef _LINUX_DEV_LIVEUPDATE_H
> +#define _LINUX_DEV_LIVEUPDATE_H
> +
> +#include <linux/liveupdate.h>
> +
> +#ifdef CONFIG_LIVEUPDATE
> +
> +enum liveupdate_flag {
> +	LU_BUSMASTER = 1 << 0,
> +	LU_BUSMASTER_BRIDGE = 2 << 0,

BIT() please.

> +};
> +
> +#define	LU_REQUESTED	(LU_BUSMASTER)
> +#define	LU_DEPENDED	(LU_BUSMASTER_BRIDGE)

Why 2 names for the same thing?

> +
> +/**
> + * struct dev_liveupdate - Device state for live update operations
> + * @lu_next:	List head for linking the device into live update
> + *		related lists (e.g., a list of devices participating
> + *		in a live update sequence).
> + * @flags:	Indicate what liveupdate feature does the device
> + *		participtate.
> + * @visited:	Only used by the bus devices when travese the PCI buses
> + *		to build the liveupdate devices list. Set if the child
> + *		buses have been pushed into the pending stack.
> + *
> + * This structure holds the state information required for performing
> + * live update operations on a device. It is embedded within a struct device.
> + */
> +struct dev_liveupdate {
> +	struct list_head lu_next;

Another list?

> +	enum liveupdate_flag flags;
> +	bool visited:1;

You shouldn't need this, you "know" you only touch one device at a time
when walking a bus, don't try to manually keep track of it on your own.

And again, why is the pci core doing this, the driver core should be
doing all of this, PLEASE do not bury driver-model-core-changes down in
a "PCI" patch.  That will make the driver core maintainers very grumpy
when they run across stuff like this (as it did here...)

> +};
> +
> +#endif /* CONFIG_LIVEUPDATE */
> +#endif /* _LINUX_DEV_LIVEUPDATE_H */
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4940db137fffff4ceacf819b32433a0f4898b125..e0b35c723239f1254a3b6152f433e0412cd3fb34 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -21,6 +21,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/compiler.h>
>  #include <linux/types.h>
> +#include <linux/dev_liveupdate.h>

Look, driver core changes.  Please do this all in stuff that is NOT for
just PCI.


>  #include <linux/mutex.h>
>  #include <linux/pm.h>
>  #include <linux/atomic.h>
> @@ -508,6 +509,7 @@ struct device_physical_location {
>   * @pm_domain:	Provide callbacks that are executed during system suspend,
>   * 		hibernation, system resume and during runtime PM transitions
>   * 		along with subsystem-level and driver-level callbacks.
> + * @lu:		Live update state.

You have more letters, please use them.  "lu" is too short.

>   * @em_pd:	device's energy model performance domain
>   * @pins:	For device pin management.
>   *		See Documentation/driver-api/pin-control.rst for details.
> @@ -603,6 +605,10 @@ struct device {
>  	struct dev_pm_info	power;
>  	struct dev_pm_domain	*pm_domain;
>  
> +#ifdef CONFIG_LIVEUPDATE
> +	struct dev_liveupdate	lu;
> +#endif

Why not a pointer?

> +
>  #ifdef CONFIG_ENERGY_MODEL
>  	struct em_perf_domain	*em_pd;
>  #endif
> @@ -1168,4 +1174,13 @@ void device_link_wait_removal(void);
>  #define MODULE_ALIAS_CHARDEV_MAJOR(major) \
>  	MODULE_ALIAS("char-major-" __stringify(major) "-*")
>  
> +#ifdef CONFIG_LIVEUPDATE
> +static inline void dev_liveupdate_init(struct device *dev)
> +{
> +	INIT_LIST_HEAD(&dev->lu.lu_next);

Why does this have to be in device.h?  The driver core should do this
for you (as I say above).

thanks,

greg k-h

