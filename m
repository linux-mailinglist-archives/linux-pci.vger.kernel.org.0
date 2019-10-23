Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAD8E1E19
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 16:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389558AbfJWO1S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 10:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbfJWO1S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 10:27:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5726C21872;
        Wed, 23 Oct 2019 14:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571840836;
        bh=D230z3qUz64Kf7uR9xKOBMmSGsbjH9R5QiOnkFAdwxM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gzc2pEgtp8+DLNg0G5X7RoF2IgDQAzk7riINQxaQWJU/benhJAa+pqjx0qwSdNaar
         mSPJtu25oYl+3jQ/0ZU9VKNG7/BRCpkflgk0AUQdA0uyyMBUpTs0DJycQZaPMGZke9
         7sr4tmtGgu4tSpX9IB0R6oZuKU13RWJVAAQcoLx4=
Date:   Wed, 23 Oct 2019 09:27:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v2 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Message-ID: <20191023142715.GA162472@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187E4D0055791957B7E2660806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:12:29PM +0000, Nicholas Johnson wrote:
> Add kernel parameter pci=hpmmiosize=nn[KMG] to set MMIO bridge window
> size for hotplug bridges.
> 
> Add kernel parameter pci=hpmmioprefsize=nn[KMG] to set MMIO_PREF bridge
> window size for hotplug bridges.
> 
> Leave pci=hpmemsize=nn[KMG] unchanged, to prevent disruptions to
> existing users. This sets both MMIO and MMIO_PREF to the same size.
> 
> The two new parameters conform to the style of pci=hpiosize=nn[KMG].
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Applied to pci/resource for v5.5, thanks!

> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++-
>  drivers/pci/pci.c                             | 13 +++++++---
>  drivers/pci/pci.h                             |  3 ++-
>  drivers/pci/setup-bus.c                       | 24 ++++++++++---------
>  4 files changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index a84a83f88..cfe8c2b67 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3492,8 +3492,15 @@
>  		hpiosize=nn[KMG]	The fixed amount of bus space which is
>  				reserved for hotplug bridge's IO window.
>  				Default size is 256 bytes.
> +		hpmmiosize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for hotplug bridge's MMIO window.
> +				Default size is 2 megabytes.
> +		hpmmioprefsize=nn[KMG]	The fixed amount of bus space which is
> +				reserved for hotplug bridge's MMIO_PREF window.
> +				Default size is 2 megabytes.
>  		hpmemsize=nn[KMG]	The fixed amount of bus space which is
> -				reserved for hotplug bridge's memory window.
> +				reserved for hotplug bridge's MMIO and
> +				MMIO_PREF window.
>  				Default size is 2 megabytes.
>  		hpbussize=nn	The minimum amount of additional bus numbers
>  				reserved for buses below a hotplug bridge.
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a..e0406c663 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -85,10 +85,12 @@ unsigned long pci_cardbus_io_size = DEFAULT_CARDBUS_IO_SIZE;
>  unsigned long pci_cardbus_mem_size = DEFAULT_CARDBUS_MEM_SIZE;
>  
>  #define DEFAULT_HOTPLUG_IO_SIZE		(256)
> -#define DEFAULT_HOTPLUG_MEM_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_SIZE	(2*1024*1024)
> +#define DEFAULT_HOTPLUG_MMIO_PREF_SIZE	(2*1024*1024)
>  /* pci=hpmemsize=nnM,hpiosize=nn can override this */
>  unsigned long pci_hotplug_io_size  = DEFAULT_HOTPLUG_IO_SIZE;
> -unsigned long pci_hotplug_mem_size = DEFAULT_HOTPLUG_MEM_SIZE;
> +unsigned long pci_hotplug_mmio_size = DEFAULT_HOTPLUG_MMIO_SIZE;
> +unsigned long pci_hotplug_mmio_pref_size = DEFAULT_HOTPLUG_MMIO_PREF_SIZE;
>  
>  #define DEFAULT_HOTPLUG_BUS_SIZE	1
>  unsigned long pci_hotplug_bus_size = DEFAULT_HOTPLUG_BUS_SIZE;
> @@ -6286,8 +6288,13 @@ static int __init pci_setup(char *str)
>  				pcie_ecrc_get_policy(str + 5);
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
>  				pci_hotplug_io_size = memparse(str + 9, &str);
> +			} else if (!strncmp(str, "hpmmiosize=", 11)) {
> +				pci_hotplug_mmio_size = memparse(str + 11, &str);
> +			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
> +				pci_hotplug_mmio_pref_size = memparse(str + 15, &str);
>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> -				pci_hotplug_mem_size = memparse(str + 10, &str);
> +				pci_hotplug_mmio_size = memparse(str + 10, &str);
> +				pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size;
>  			} else if (!strncmp(str, "hpbussize=", 10)) {
>  				pci_hotplug_bus_size =
>  					simple_strtoul(str + 10, &str, 0);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 3f6947ee3..9faa55a15 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -218,7 +218,8 @@ extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
>  
>  extern unsigned long pci_hotplug_io_size;
> -extern unsigned long pci_hotplug_mem_size;
> +extern unsigned long pci_hotplug_mmio_size;
> +extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
>  /**
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e7dbe2170..93fd2070a 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1178,7 +1178,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
>  	unsigned long mask, prefmask, type2 = 0, type3 = 0;
> -	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> +			additional_mmio_pref_size = 0;
>  	struct resource *b_res;
>  	int ret;
>  
> @@ -1212,7 +1213,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		pci_bridge_check_ranges(bus);
>  		if (bus->self->is_hotplug_bridge) {
>  			additional_io_size  = pci_hotplug_io_size;
> -			additional_mem_size = pci_hotplug_mem_size;
> +			additional_mmio_size = pci_hotplug_mmio_size;
> +			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
>  		}
>  		/* Fall through */
>  	default:
> @@ -1230,9 +1232,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (b_res[2].flags & IORESOURCE_MEM_64) {
>  			prefmask |= IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
> -				  prefmask, prefmask,
> -				  realloc_head ? 0 : additional_mem_size,
> -				  additional_mem_size, realloc_head);
> +				prefmask, prefmask,
> +				realloc_head ? 0 : additional_mmio_pref_size,
> +				additional_mmio_pref_size, realloc_head);
>  
>  			/*
>  			 * If successful, all non-prefetchable resources
> @@ -1254,9 +1256,9 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		if (!type2) {
>  			prefmask &= ~IORESOURCE_MEM_64;
>  			ret = pbus_size_mem(bus, prefmask, prefmask,
> -					 prefmask, prefmask,
> -					 realloc_head ? 0 : additional_mem_size,
> -					 additional_mem_size, realloc_head);
> +				prefmask, prefmask,
> +				realloc_head ? 0 : additional_mmio_pref_size,
> +				additional_mmio_pref_size, realloc_head);
>  
>  			/*
>  			 * If successful, only non-prefetchable resources
> @@ -1265,7 +1267,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			if (ret == 0)
>  				mask = prefmask;
>  			else
> -				additional_mem_size += additional_mem_size;
> +				additional_mmio_size += additional_mmio_pref_size;
>  
>  			type2 = type3 = IORESOURCE_MEM;
>  		}
> @@ -1285,8 +1287,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  		 * prefetchable resource in a 64-bit prefetchable window.
>  		 */
>  		pbus_size_mem(bus, mask, IORESOURCE_MEM, type2, type3,
> -				realloc_head ? 0 : additional_mem_size,
> -				additional_mem_size, realloc_head);
> +			realloc_head ? 0 : additional_mmio_size,
> +			additional_mmio_size, realloc_head);
>  		break;
>  	}
>  }
> -- 
> 2.23.0
> 
