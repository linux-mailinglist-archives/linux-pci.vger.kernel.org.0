Return-Path: <linux-pci+bounces-37758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BDCBC9129
	for <lists+linux-pci@lfdr.de>; Thu, 09 Oct 2025 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6233E1881
	for <lists+linux-pci@lfdr.de>; Thu,  9 Oct 2025 12:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D422E2DDD;
	Thu,  9 Oct 2025 12:38:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7225A642;
	Thu,  9 Oct 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013492; cv=none; b=XfZNL3R09kSb5+Fw7qZYCd8IEyV63CqXIUi5GdiaVAXS2iIn193KDgwLvi1luG8uLgPJasyl0VRMsu47vwREqbwmTGHIevkud59rdgvphJajhXzpOP4tSgifU40KN6N1xd6e3B0QC9JCo/xId6JDhQHeyFXzGL9ph33+MfqVGY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013492; c=relaxed/simple;
	bh=U3mlvrL36oHscYhKg696JqsDv3SF4oqNyGhoPnwU60s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7xwp+MpHX5BxP28kjrTpX/2YjFu5TBggkk9izHQm0qyumfj36WmXOLP4t3vFd1cpnEDURqMrLpNynyQFP4+gPava9nYVK45eeF8Uao1NIhJN/7zqjd3686Qx42J2YD7V+91HbOdKe/bDcleRmfaOZE4+ZyW4sDrbOPCwVvXdJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cj8TJ6Vz8z6M4WL;
	Thu,  9 Oct 2025 20:34:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CB2014025A;
	Thu,  9 Oct 2025 20:38:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 9 Oct
 2025 13:38:04 +0100
Date: Thu, 9 Oct 2025 13:38:02 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Evangelos Petrongonas <epetron@amazon.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson
	<alex.williamson@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, David
 Matlack <dmatlack@google.com>, Vipin Sharma <vipinsh@google.com>, Chris Li
	<chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>, "Pratyush Yadav"
	<pratyush@kernel.org>, Stanislav Spassov <stanspas@amazon.de>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>
Subject: Re: [RFC PATCH 01/13] pci: pcsc: Add plumbing for the PCI
 Configuration Space Cache (PCSC)
Message-ID: <20251009133802.0000486f@huawei.com>
In-Reply-To: <ecfa9cca72b51e20505093e145246054e91fe9a4.1759312886.git.epetron@amazon.de>
References: <cover.1759312886.git.epetron@amazon.de>
	<ecfa9cca72b51e20505093e145246054e91fe9a4.1759312886.git.epetron@amazon.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 3 Oct 2025 09:00:37 +0000
Evangelos Petrongonas <epetron@amazon.de> wrote:

> Introduce the basic infrastructure for the PCI Configuration Space Cache
> (PCSC), a mechanism to cache PCI configuration space accesses to reduce
> latency and bus traffic.
> 
> The PCSC implements a transparent interception layer for PCI config
> space operations by dynamically injecting its own ops into the PCI bus
> hierarchy. The design preserves existing PCI ops while allowing PCSC to
> intercept and cache accesses:
> 
> The` struct pci_bus` is extended to hold the original `pci_ops`, while
> the cache ones are injected via `pcsc_inject_bus_ops()`. The cache ops
> are injected when new buses are added via registering it to a bus
> notifier and integrating it at:
>   * `pci_register_host_bridge()` - for root buses
>   * `pci_alloc_child_bus()` - for child buses
>   * `pci_bus_set_ops()` - when ops are dynamically changed
> 
> The implementation includes weak pcsc_hw_config_read/write functions
> that handle calling the original op, when access to the actual HW is
> required.
> 
> This approach ensures complete transparency - existing drivers and
> subsystems continue to use standard PCI config access functions while
> PCSC can intercept and cache accesses as needed. The weak functions also
> allow architecture-specific implementations to override the default
> behavior.
> 
> The `core` initcall level is chosen so the cache is initialised before
> the PCI driver, ensuring that all config space access go through the
> cache.
> 
> Kconfig options are added for both PCSC and PCIe PCSC support, with the
> latter extending the cache to handle 4KB PCIe configuration space.
> 
> In this initial patch, the cache simply passes through all accesses to
> the hardware via the original ops - actual caching functionality will be
> added in subsequent patches.
> 
> There is one caveat in this patch. The map_bus operations can
> potentially alter the cache, without invalidating / updating the cache.
> This is not an issue for the current upstream usages, as it is only
> being used in Root complexes and the
> `pci_generic_config_{read,write}{,32}`
> 
> Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>

Hi,

This is an interesting idea.   I'll probably give a bunch of trivial
feedback whilst I do a first read through.  I appreciate this is only
an RFC at this point though!


> ---
>  drivers/pci/Kconfig      |  10 ++
>  drivers/pci/Makefile     |   1 +
>  drivers/pci/access.c     |  81 ++++++++++++++-
>  drivers/pci/pcie/Kconfig |   9 ++
>  drivers/pci/pcsc.c       | 208 +++++++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c      |  24 ++++-
>  include/linux/pci.h      |   3 +
>  include/linux/pcsc.h     |  86 ++++++++++++++++
>  8 files changed, 419 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/pci/pcsc.c
>  create mode 100644 include/linux/pcsc.h
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 9a249c65aedc..c26162b58365 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -40,6 +40,16 @@ config PCI_DOMAINS_GENERIC
>  config PCI_SYSCALL
>  	bool
>  
> +config PCSC
> +	bool "PCI Configuration Space Cache"
> +	depends on PCI
> +	default n

Not needed as default if you don't have this line is n.

> +	help
> +	  This option enables support for the PCI Configuration Space Cache
> +	  (PCSC). PCSC is a transparent caching layer that
> +	  intercepts configuration space operations and maintains cached
> +	  copies of register values

Odd wrapping.  Rewrap to consistent 80 chars.

> +
>  source "drivers/pci/pcie/Kconfig"
>  
>  config PCI_MSI
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..012561b97e32 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_PCI_DOE)		+= doe.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  obj-$(CONFIG_PCIE_TPH)		+= tph.o
> +obj-$(CONFIG_PCSC)			+= pcsc.o
>  
>  # Endpoint library must be initialized before its users
>  obj-$(CONFIG_PCI_ENDPOINT)	+= endpoint/
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index b123da16b63b..b89e9210d330 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/pci.h>
> +#include <linux/pcsc.h>
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/ioport.h>
> @@ -189,15 +190,93 @@ EXPORT_SYMBOL_GPL(pci_generic_config_write32);
>   * @ops:	new raw operations
>   *
>   * Return previous raw operations
> + *
> + * When PCSC is enabled, this function maintains transparency by:
> + * - Returning the original non-PCSC ops to the caller
> + * - Properly handling the case where PCSC ops are already injected
> + * - Re-injecting PCSC ops after setting new ops when appropriate
>   */
>  struct pci_ops *pci_bus_set_ops(struct pci_bus *bus, struct pci_ops *ops)
>  {
>  	struct pci_ops *old_ops;
>  	unsigned long flags;
> +#ifdef CONFIG_PCSC
> +	bool pcsc_was_injected = false;
> +	struct pci_ops *pcsc_ops_ptr = NULL;
> +#endif

With change suggested below the compiler will happily remove these
without needing the ifdef fun.

>  
>  	raw_spin_lock_irqsave(&pci_lock, flags);

I'd precede this set with a patch using guard() for this
as then you can avoid the goto complexity in your new code
and potentially just return directly in error cases which will
I think simpify flow a little more.


> -	old_ops = bus->ops;
> +
> +#ifdef CONFIG_PCSC

Is it possible to use
	if (IS_ENABLED(CONFIG_PCSC))
to expose the code to the compiler /static analysis etc but allow
the compiler to cleanly do dead code removal so we get same resulting
binary as here?

> +	/*
> +	 * Check if PCSC ops are currently injected. If so, we need to:
> +	 * 1. Return the original (non-PCSC) ops to maintain transparency
> +	 * 2. Update orig_ops to point to the new ops
> +	 * 3. Re-inject PCSC ops if the new ops are different from PCSC ops
> +	 */
> +	if (bus->orig_ops) {
> +		pcsc_was_injected = true;
> +		pcsc_ops_ptr = bus->ops;  /* Save current PCSC ops */
> +		old_ops = bus->orig_ops;   /* Return the real original ops */
> +
> +		/*
> +		 * If the caller is trying to restore the PCSC ops themselves,
> +		 * just keep the current setup and return the original ops
> +		 */
> +		if (ops == pcsc_ops_ptr)
> +			goto out_unlock;
> +
> +		/* Clear orig_ops temporarily to allow re-injection */
> +		bus->orig_ops = NULL;
> +	} else
> +#endif
> +	{
> +		old_ops = bus->ops;
> +	}
> +
>  	bus->ops = ops;
> +
> +#ifdef CONFIG_PCSC

Similar: if (IS_ENABLED())

> +	/*
> +	 * Re-inject PCSC ops if they were previously injected and the new ops
> +	 * are not the PCSC ops themselves. This maintains caching transparency.
> +	 */
> +	if (pcsc_was_injected && ops != pcsc_ops_ptr) {
> +		/*
> +		 * IMPORTANT: Dynamic ops changes after PCSC injection can lead to
> +		 * cache consistency issues if operations were performed that should
> +		 * have invalidated the cache. We re-inject PCSC ops here, but the
> +		 * caller is responsible for ensuring cache consistency if needed.
> +		 * This will be fixed in a future commit, when PCSC resets are
> +		 * introduced.
> +		 */
> +
> +		pr_warn("PCSC: Dynamic ops change detected on bus %04x:%02x, resetting cache\n",
> +			pci_domain_nr(bus), bus->number);
> +
> +		if (pcsc_inject_bus_ops(bus)) {
> +			pr_err("PCSC: Failed to re-inject ops after ops change on bus %04x:%02x\n",
> +				pci_domain_nr(bus), bus->number);
> +			/*
> +			 * If re-injection fails, we've lost caching but at least
> +			 * the caller's requested ops are in place. Log it
> +			 */
> +			pr_warn("PCSC: Cache disabled for bus %04x:%02x after ops change\n",
> +				pci_domain_nr(bus), bus->number);
> +		} else {
> +			pr_debug("PCSC: Successfully re-injected ops after ops change on bus %04x:%02x\n",
> +				pci_domain_nr(bus), bus->number);
> +		}
> +	} else if (!pcsc_was_injected) {
> +		/* First-time injection for this bus */
> +		if (pcsc_inject_bus_ops(bus)) {
> +			pr_err("PCSC: Failed to inject ops on bus %04x:%02x\n",
> +				pci_domain_nr(bus), bus->number);
> +		}
> +	}
> +
> +out_unlock:
> +#endif
>  	raw_spin_unlock_irqrestore(&pci_lock, flags);
>  	return old_ops;
>  }


> diff --git a/drivers/pci/pcsc.c b/drivers/pci/pcsc.c
> new file mode 100644
> index 000000000000..dec7c51b5cfd
> --- /dev/null
> +++ b/drivers/pci/pcsc.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2025 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + * Author: Evangelos Petrongonas <epetron@amazon.de>
> + *
> + * Implementation of the PCI Configuration Space Cache (PCSC)
> + * PCSC is a module which caches the PCI Configuration Space Accesses
> + * It implements a write-invalidate policy, meaning that writes are
> + * propagated to the device and invalidating the cache. The registers that
> + * we are caching are based on the values that are safe to cache and we
> + * are not expecting them to change without OS actions.
> + *
Trivial but this trailing blank line doesn't add much.
> + */

> +/* Weak references to allow architecture-specific overrides */
> +int __weak pcsc_hw_config_read(struct pci_bus *bus, unsigned int devfn,
> +			       int where, int size, u32 *val)
> +{
> +	/*
> +	 * This function is only called from pcsc_cached_config_read,

pcsc_cached_config_read() 

> +	 * which means PCSC ops have already been injected and orig_ops
> +	 * should be valid.
> +	 */
> +	if (bus->orig_ops && bus->orig_ops->read)
> +		return bus->orig_ops->read(bus, devfn, where, size, val);
> +
> +	*val = 0xffffffff;
I'd use GENMASK(31, 0);
as no one likes counting fs. 

> +	return PCIBIOS_FUNC_NOT_SUPPORTED;
> +}
> +EXPORT_SYMBOL_GPL(pcsc_hw_config_read);
> +
> +int __weak pcsc_hw_config_write(struct pci_bus *bus, unsigned int devfn,
> +				int where, int size, u32 val)
> +{
> +	/*
> +	 * This function is only called from pcsc_cached_config_write,
()  same for other references to functions in comments.

> +	 * which means PCSC ops have already been injected and orig_ops
> +	 * should be valid.
> +	 */
> +	if (bus->orig_ops && bus->orig_ops->write)
> +		return bus->orig_ops->write(bus, devfn, where, size, val);
> +
> +	return PCIBIOS_FUNC_NOT_SUPPORTED;
> +}
> +EXPORT_SYMBOL_GPL(pcsc_hw_config_write);

> +static int __init pcsc_init(void)
> +{
> +	bus_register_notifier(&pci_bus_type, &pcsc_bus_nb);
> +
> +	pcsc_initialised = true;
> +	pr_info("initialised\n");

Bit noisy but I guess there is no other way to tell this is running.

> +
> +	return 0;
> +}
> +
> +core_initcall(pcsc_init);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 37f5bd476f39..33a186e4bf1e 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -8,6 +8,7 @@
>  #include <linux/delay.h>
>  #include <linux/init.h>
>  #include <linux/pci.h>
> +#include <linux/pcsc.h>
>  #include <linux/msi.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
> @@ -1039,6 +1040,11 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	}
>  #endif
>  
> +#ifdef CONFIG_PCSC
if (IS_ENABLED())
	and a stub probably to get rid of the ifdef mess.


> +	if (pcsc_inject_bus_ops(bus))
> +		pci_err(bus, "PCSC: Failed to inject ops\n");
> +#endif
> +
>  	b = pci_find_bus(pci_domain_nr(bus), bridge->busnr);
>  	if (b) {
>  		/* Ignore it if we already got here via a different bridge */
> @@ -1236,10 +1242,24 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
>  	child->bus_flags = parent->bus_flags;
>  
>  	host = pci_find_host_bridge(parent);
> -	if (host->child_ops)
> +	if (host->child_ops) {
>  		child->ops = host->child_ops;
> -	else
> +#ifdef CONFIG_PCSC
> +		child->orig_ops = host->child_ops;
I'd see if anyone really minds the unused orig_ops vs
the complexity of lots of local code.  Otherwise wrap
setting and reading it up in access functions and stub
them out on !IS_ENABLED(CONFIG_PCSC)

> +#endif
> +	} else {
>  		child->ops = parent->ops;
> +#ifdef CONFIG_PCSC
> +		child->orig_ops = parent->orig_ops;
> +#endif
> +	}
> +
> +#ifdef CONFIG_PCSC
Similar to above.
> +	if (child->ops) {
> +		if (pcsc_inject_bus_ops(child))
> +			pci_err(child, "PCSC: Failed to inject ops\n");
> +	}
> +#endif
>  

> diff --git a/include/linux/pcsc.h b/include/linux/pcsc.h
> new file mode 100644
> index 000000000000..45816eb2b2c8
> --- /dev/null
> +++ b/include/linux/pcsc.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2025 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + * Author: Evangelos Petrongonas <epetron@amazon.de>
> + *
Trivial but drop this line as it adds nothing to readability and makes me scroll
a tiny little  bit more ;)
> + */

> +/**
> + * pcsc_inject_bus_ops Inject the pcsc ops into bus pci_ops
> + * @bus: the bus in which to inject the ops
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +int pcsc_inject_bus_ops(struct pci_bus *bus);

It's a bit awkward given the weak functions, but mostly PCI seems to
put documentation alongside implementation rather then in the header.

> +#endif /* _LINUX_PCSC_H */


