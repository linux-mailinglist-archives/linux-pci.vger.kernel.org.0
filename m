Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9DBF8C04
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 10:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfKLJj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 04:39:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:18473 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbfKLJj6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 04:39:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 01:39:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,295,1569308400"; 
   d="scan'208";a="214042274"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 12 Nov 2019 01:39:54 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Nov 2019 11:39:53 +0200
Date:   Tue, 12 Nov 2019 11:39:53 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191112093953.GD2644@lahna.fi.intel.com>
References: <PS2P216MB07554FF63C34AFBCE04BD55D80780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB07554FF63C34AFBCE04BD55D80780@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 07, 2019 at 01:50:57PM +0000, Nicholas Johnson wrote:
> Currently, the kernel can sometimes assign the MMIO_PREF window
> additional size into the MMIO window, resulting in extra MMIO additional
> size, despite the MMIO_PREF additional size being assigned successfully
> into the MMIO_PREF window.
> 
> This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> fails. In the next pass, because MMIO_PREF is already assigned, the
> attempt to assign MMIO_PREF returns an error code instead of success
> (nothing more to do, already allocated). Hence, the size which is
> actually allocated, but thought to have failed, is placed in the MMIO
> window.
> 
> Example of problem (more context can be found in the bug report URL):
> 
> Mainline kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> 
> Patched kernel:
> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> 
> This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> with the same configuration, with a Ubuntu mainline kernel and a kernel
> patched with this patch.
> 
> The bug results in the MMIO_PREF being added to the MMIO window, which
> means doubling if MMIO_PREF size = MMIO size. With a large MMIO_PREF,
> the MMIO window will likely fail to be assigned altogether due to lack
> of 32-bit address space.
> 
> Change find_free_bus_resource() to do the following:
> - Return first unassigned resource of the correct type.
> - If none of the above, return first assigned resource of the correct type.
> - If none of the above, return NULL.
> 
> Returning an assigned resource of the correct type allows the caller to
> distinguish between already assigned and no resource of the correct type.
> 
> Rename find_free_bus_resource to find_bus_resource_of_type().
> 
> Add checks in pbus_size_io() and pbus_size_mem() to return success if
> resource returned from find_free_bus_resource() is already allocated.
> 
> This avoids pbus_size_io() and pbus_size_mem() returning error code to
> __pci_bus_size_bridges() when a resource has been successfully assigned
> in a previous pass. This fixes the existing behaviour where space for a
> resource could be reserved multiple times in different parent bridge
> windows.
> 
> Link: https://lore.kernel.org/lkml/20190531171216.20532-2-logang@deltatee.com/T/#u
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203243
> 
> Reported-by: Kit Chow <kchow@gigaio.com>
> Reported-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Minor nits below.

> ---
>  drivers/pci/setup-bus.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e7dbe2170..f97c36a1e 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -752,24 +752,32 @@ static void pci_bridge_check_ranges(struct pci_bus *bus)
>  }
>  
>  /*
> - * Helper function for sizing routines: find first available bus resource
> - * of a given type.  Note: we intentionally skip the bus resources which
> - * have already been assigned (that is, have non-NULL parent resource).
> + * Helper function for sizing routines.
> + * Assigned resources have non-NULL parent resource.
> + *
> + * Return first unassigned resource of the correct type.
> + * If none of the above, return first assigned resource of the correct type.
> + * If none of the above, return NULL.
> + *
> + * Returning an assigned resource of the correct type allows the caller to
> + * distinguish between already assigned and no resource of the correct type.
>   */
> -static struct resource *find_free_bus_resource(struct pci_bus *bus,
> -					       unsigned long type_mask,
> -					       unsigned long type)
> +static struct resource *find_bus_resource_of_type(struct pci_bus *bus,
> +						  unsigned long type_mask,
> +						  unsigned long type)
>  {
>  	int i;
> -	struct resource *r;
> +	struct resource *r, *r_assigned = NULL;

Maybe order them

	struct resource *r, *r_assigned = NULL;
 	int i;

>  
>  	pci_bus_for_each_resource(bus, r, i) {
>  		if (r == &ioport_resource || r == &iomem_resource)
>  			continue;
>  		if (r && (r->flags & type_mask) == type && !r->parent)
>  			return r;
> +		if (r && (r->flags & type_mask) == type && !r_assigned)
> +			r_assigned = r;
>  	}
> -	return NULL;
> +	return r_assigned;
>  }
>  
>  static resource_size_t calculate_iosize(resource_size_t size,
> @@ -866,14 +874,16 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  			 struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO,
> -							IORESOURCE_IO);
> +	struct resource *b_res = find_bus_resource_of_type(bus, IORESOURCE_IO,
> +								IORESOURCE_IO);
>  	resource_size_t size = 0, size0 = 0, size1 = 0;
>  	resource_size_t children_add_size = 0;
>  	resource_size_t min_align, align;
>  
>  	if (!b_res)
>  		return;

I think it may be good to comment here that skip the resources that are
assigned (->parent != NULL).

> +	if (b_res->parent)
> +		return;
>  
>  	min_align = window_alignment(bus, IORESOURCE_IO);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -978,7 +988,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	resource_size_t min_align, align, size, size0, size1;
>  	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
>  	int order, max_order;
> -	struct resource *b_res = find_free_bus_resource(bus,
> +	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
>  	resource_size_t children_add_align = 0;
> @@ -986,6 +996,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  
>  	if (!b_res)
>  		return -ENOSPC;

Ditto.

> +	if (b_res->parent)
> +		return 0;
>  
>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
> -- 
> 2.23.0
