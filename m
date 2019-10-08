Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1532CF999
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730317AbfJHMQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Oct 2019 08:16:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:5029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbfJHMQ2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Oct 2019 08:16:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 05:16:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206625721"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 08 Oct 2019 05:16:24 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Oct 2019 15:16:24 +0300
Date:   Tue, 8 Oct 2019 15:16:23 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 5/6] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Message-ID: <20191008121623.GJ2819@lahna.fi.intel.com>
References: <SL2P216MB0187C45A8B38504D855A1DEA80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187C45A8B38504D855A1DEA80C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 26, 2019 at 12:54:44PM +0000, Nicholas Johnson wrote:
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

This does not apply anymore because of 003d3b2c5f83 ("PCI: Make
pci_hotplug_io_size, mem_size, and bus_size private") so I think you
need to rebase this on top of current mainline.

> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++++-
>  drivers/pci/pci.c                             | 17 ++++++++++---
>  drivers/pci/setup-bus.c                       | 25 +++++++++++--------
>  include/linux/pci.h                           |  3 ++-
>  4 files changed, 38 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 46b826fcb..9bc54cb99 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3467,8 +3467,15 @@
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
> index 29ed5ec1a..6b3857cad 100644
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
> @@ -6281,8 +6283,17 @@ static int __init pci_setup(char *str)
>  				pcie_ecrc_get_policy(str + 5);
>  			} else if (!strncmp(str, "hpiosize=", 9)) {
>  				pci_hotplug_io_size = memparse(str + 9, &str);
> +			} else if (!strncmp(str, "hpmmiosize=", 11)) {
> +				pci_hotplug_mmio_size =
> +					memparse(str + 11, &str);

I would keep this in single line disregarding the 80 char limit.

> +			} else if (!strncmp(str, "hpmmioprefsize=", 15)) {
> +				pci_hotplug_mmio_pref_size =
> +					memparse(str + 15, &str);

Ditto

>  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> -				pci_hotplug_mem_size = memparse(str + 10, &str);
> +				pci_hotplug_mmio_size =
> +					memparse(str + 10, &str);
Ditto.

> +				pci_hotplug_mmio_pref_size =
> +					memparse(str + 10, &str);

Ditto.

>  			} else if (!strncmp(str, "hpbussize=", 10)) {
>  				pci_hotplug_bus_size =
>  					simple_strtoul(str + 10, &str, 0);
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 7e1dc892a..345ecf16d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1178,7 +1178,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
>  	unsigned long mask, prefmask, type2 = 0, type3 = 0;
> -	resource_size_t additional_mem_size = 0, additional_io_size = 0;
> +	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
> +		additional_mmio_pref_size = 0;

Maybe align them like

	resource_size_t additional_io_size = 0, additional_mmio_size = 0,
			additional_mmio_pref_size = 0;

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
> @@ -1265,7 +1267,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
>  			if (ret == 0)
>  				mask = prefmask;
>  			else
> -				additional_mem_size += additional_mem_size;
> +				additional_mmio_size +=
> +					additional_mmio_pref_size;

Here also looks better if you put them single line.

>  
>  			type2 = type3 = IORESOURCE_MEM;
>  		}
> @@ -1285,8 +1288,8 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
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
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 9e700d9f9..1bde5763a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2031,7 +2031,8 @@ extern u8 pci_dfl_cache_line_size;
>  extern u8 pci_cache_line_size;
>  
>  extern unsigned long pci_hotplug_io_size;
> -extern unsigned long pci_hotplug_mem_size;
> +extern unsigned long pci_hotplug_mmio_size;
> +extern unsigned long pci_hotplug_mmio_pref_size;
>  extern unsigned long pci_hotplug_bus_size;
>  
>  /* Architecture-specific versions may override these (weak) */
> -- 
> 2.22.0
