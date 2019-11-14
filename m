Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31EB4FCB2D
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 17:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfKNQ4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 11:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfKNQ4k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 11:56:40 -0500
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA14206D3;
        Thu, 14 Nov 2019 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573750598;
        bh=3oWY04fxi1KO9G9WAcSUTTpcgTOi0Y8RWTVhAJDin5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mVMh+DwvftxCz1udb5Ei9W6SiIdOXk6udJ8xl0ltip+g3h9iC2VnIHD2nytKhIkQB
         Xd6w/5k9Sl+YuHErgLGUzukrhy6Om/6uD1jHhBCTMOvDgr2xvnfhLibMTtmtze6BEy
         ghtkhL2s00/MK94bkLI4gNGdo/rD5+qdNj/hwLtU=
Date:   Thu, 14 Nov 2019 10:56:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Message-ID: <20191114165637.GA210407@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS2P216MB075563AA6AD242AA666EDC6A80760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 13, 2019 at 03:25:28PM +0000, Nicholas Johnson wrote:
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
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied with reviewed-by from Mika and Logan to pci/resource for v5.5,
thanks!

> ---
>  drivers/pci/setup-bus.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 6b64bf909..f382f449b 100644
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
> +	struct resource *r, *r_assigned = NULL;
>  	int i;
> -	struct resource *r;
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
> @@ -866,8 +874,8 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
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
> @@ -875,6 +883,10 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
>  	if (!b_res)
>  		return;
>  
> +	/* If resource is already assigned, nothing more to do. */
> +	if (b_res->parent)
> +		return;
> +
>  	min_align = window_alignment(bus, IORESOURCE_IO);
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
>  		int i;
> @@ -978,7 +990,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	resource_size_t min_align, align, size, size0, size1;
>  	resource_size_t aligns[18]; /* Alignments from 1MB to 128GB */
>  	int order, max_order;
> -	struct resource *b_res = find_free_bus_resource(bus,
> +	struct resource *b_res = find_bus_resource_of_type(bus,
>  					mask | IORESOURCE_PREFETCH, type);
>  	resource_size_t children_add_size = 0;
>  	resource_size_t children_add_align = 0;
> @@ -987,6 +999,10 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  	if (!b_res)
>  		return -ENOSPC;
>  
> +	/* If resource is already assigned, nothing more to do. */
> +	if (b_res->parent)
> +		return 0;
> +
>  	memset(aligns, 0, sizeof(aligns));
>  	max_order = 0;
>  	size = 0;
> -- 
> 2.24.0
> 
