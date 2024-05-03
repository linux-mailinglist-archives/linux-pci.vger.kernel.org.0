Return-Path: <linux-pci+bounces-7055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF9A8BB500
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 22:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1DA328276C
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2024 20:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE7A23775;
	Fri,  3 May 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmbnCX0V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433E433FD;
	Fri,  3 May 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714769027; cv=none; b=MRJ2WE+oh7CvpmoryUPs28KnqATEflA4MtEfzlu8bPvulcAHuzQ1GeyMJg+DIyx6e66hXYk6BxDeJMl/igRymLmtj/4/RC6h37ppGfVDOFn3NBcaaA7iPVaHn7kB+PatKgM0GlTPTasIx4AAsEkaK8s7aUtocBWpFV3NEOMCzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714769027; c=relaxed/simple;
	bh=/WuftpaaJMklwSEiWkf5oyCdhSi6MZX2cRGuoFww9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DWCrsWIX1mbQdwMSnCfqlS5YbguZoES1kK0OI/BfD4F7Y7ZSQLAKPpdJSjYWyZxHlOl4CWodDvZFCPYlgaC5zxb69+6Rcseo5XjSBYVZsRrn2QT2ByCMtFzmLtqb+sW05gqXh/ay5ppgvdTyrx1kk+Z6E7UyO8G3X+d+fZTmrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmbnCX0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05EEC116B1;
	Fri,  3 May 2024 20:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714769026;
	bh=/WuftpaaJMklwSEiWkf5oyCdhSi6MZX2cRGuoFww9+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rmbnCX0VDMqdZnNF5mKJ091Jl7w8S0fL1yOfL84w5Dma+NOHsPES+v3d6Do6V5V+1
	 dHnvBTaZ/75DB1hN0KC0Gr/Ptc2ziQzC7G2imf1MittOTB+NIzTIAOk9Gkg20jeb+r
	 4GE8YmQayZoviI7k62CYPiS9WBTYXZTTv35uLNuHB1uxYAhqis3W5b3RbvfQhxRWnq
	 qEQJMPZ7tdpKZxIBaC4q5cj80WWvPJnzt2sGJN0yeiT1SFHKbeElcKl795lrhPpYbm
	 sRcH+2f2dYb2oehjMJiDUkXZoYmGngQNueKQJ8Kavs1GH9F93bc4dEcSol5wAttfWO
	 8o3AJuYJavYPA==
Date: Fri, 3 May 2024 15:43:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: Relax bridge window tail sizing rules
Message-ID: <20240503204344.GA1600219@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228165707.3447-8-ilpo.jarvinen@linux.intel.com>

On Thu, Dec 28, 2023 at 06:57:07PM +0200, Ilpo Järvinen wrote:
> During remove & rescan cycle, PCI subsystem will recalculate and adjust
> the bridge window sizing that was initially done by "BIOS". The size
> calculation is based on the required alignment of the largest resource
> among the downstream resources as per pbus_size_mem() (unimportant or
> zero parameters marked with "..."):
> 
> 	min_align = calculate_mem_align(aligns, max_order);
> 	size0 = calculate_memsize(size, ..., min_align);
> 
> and then in calculate_memsize():
> 	size = ALIGN(max(size, ...) + ..., align);
> 
> If the original bridge window sizing tried to conserve space, this will
> lead to massive increase of the required bridge window size when the
> downstream has a large disparity in BAR sizes. E.g., with 16MiB and
> 16GiB BARs this results in 32GiB bridge window size even if 16MiB BAR
> does not require gigabytes of space to fit.

Trying to understand exactly what "relaxed window tail sizing rules"
means.

Previous calculation "based on the required alignment of the largest
resource among downstream resources."  If a 16GiB BAR and a 16MiB BAR
leads to a 32GiB window, obviously we need a 16GiB-aligned area.  Are
you saying we also require the *size* to be 16GiB aligned?  So we add
16GiB + 16MiB to get the required size, then round it up to a 16GiB
multiple?

And "relaxed window tail" means what?  I guess we don't require as
much alignment of the size?

Obviously we need at least 1MiB alignment because that's how bridge
windows work.  If downstream resources could be packed, e.g., sort
them into descending size, align window to size of largest downstream
resource, assign smaller ones adjacent to preceding larger ones, it
should be a minimal size.

But I assume we have to do this individually for each bridge level,
including any BARs at that level along with bridge windows to the next
level downstream.

Does "relaxed window tail sizing" mean we don't allocate any more
space than is strictly required for the BARs currently present?

> When doing remove & rescan for a bus that contains such a PCI device, a
> larger bridge window is suddenly required on rescan but when there is a
> bridge window upstream that is already assigned based on the original
> size, it cannot be enlarged to the new requirement. This causes the
> allocation of the bridge window to fail (0x600000000 > 0x400ffffff):
> 
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:01:00.0: PCI bridge to [bus 02-04]
> pci 0000:01:00.0:   bridge window [mem 0x40400000-0x406fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> ...
> pci_bus 0000:03: busn_res: [bus 03] is released
> pci 0000:03:00.0: reg 0x10: [mem 0x6400000000-0x6400ffffff 64bit pref]
> pci 0000:03:00.0: reg 0x18: [mem 0x6000000000-0x63ffffffff 64bit pref]
> pci 0000:03:00.0: reg 0x30: [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: BAR 9: no space for [mem size 0x600000000 64bit pref]
> pci 0000:02:01.0: BAR 9: failed to assign [mem size 0x600000000 64bit pref]
> pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> pci 0000:03:00.0: BAR 2: no space for [mem size 0x400000000 64bit pref]
> pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x400000000 64bit pref]
> pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit pref]
> pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit pref]
> pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> 
> This is a major surprise for users who are suddenly left with a PCIe
> device that was working fine with the original bridge window sizing.
> 
> Even if the already assigned bridge window could be enlarged by
> reallocation in some cases (something the current code does not attempt
> to do), it is not possible in general case and the large amount of
> wasted space at the tail of the bridge window may lead to other
> resource exhaustion problems on Root Complex level (think of multiple
> PCIe cards with VFs and BAR size disparity in a single system).
> 
> PCI specifications only expect natural alignment for BARs (PCI Express
> Base Specification, rev. 6.1 sect. 7.5.1.2.1) and minimum of 1MiB
> alignment for the bridge window (PCI Express Base Specification,
> rev 6.1 sect. 7.5.1.3). The current bridge window tail alignment rule
> was introduced in the commit 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI
> allocation code (alpha, arm, parisc) [2/2]") that only states:
> "pbus_size_mem: core stuff; tested with randomly generated sets of
> resources". It does not explain the motivation for the extra tail space
> allocated that is not truly needed by the downstream resources. As
> such, it is far from clear if it ever has been required by any HW.
> 
> To prevent PCIe cards with BAR size disparity from becoming unusable
> after remove & rescan cycle, attempt to do a truly minimal allocation
> for memory resources if needed. First check if the normally calculated
> bridge window will not fit into an already assigned upstream resource.
> In such case, try with relaxed bridge window tail sizing rules instead
> where no extra tail space is requested beyond what the downstream
> resources require. Only enforce the alignment requirement of the bridge
> window itself (normally 1MiB).
> 
> With this patch, the resources are successfully allocated:
> 
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules

I guess the relaxed rules are required because this window doesn't fit
inside some upstream window?  Maybe include the upstream window in the
example here.  In the code, do we know the upstream window at this
point?  If so, maybe the message could include it?

But I'm missing something because it looks like we assigned the same
window (0x6000000000-0x6400ffffff) below.  What exactly is different?
It looks like the 02:01.0 windows below are the same as the ones where
it failed above.

> pci 0000:02:01.0: BAR 9: assigned [mem 0x6000000000-0x6400ffffff 64bit pref]
> pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
> pci 0000:03:00.0: BAR 2: assigned [mem 0x6000000000-0x63ffffffff 64bit pref]
> pci 0000:03:00.0: BAR 0: assigned [mem 0x6400000000-0x6400ffffff 64bit pref]
> pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
> pci 0000:02:01.0: PCI bridge to [bus 03]
> pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]

Nit, I think if these examples were collected from a newer kernel,
"reg 0x10" would be replaced with "BAR 0" so the messages would be
slightly easier to read.

> This patch draws inspiration from the initial investigations and work
> by Mika Westerberg.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216795
> Link: https://lore.kernel.org/linux-pci/20190812144144.2646-1-mika.westerberg@linux.intel.com/
> Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 74 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index e3e6ff8854a7..7a32283262c2 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -21,6 +21,7 @@
>  #include <linux/errno.h>
>  #include <linux/ioport.h>
>  #include <linux/cache.h>
> +#include <linux/limits.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include "pci.h"
> @@ -960,6 +961,62 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
>  	return min_align;
>  }
>  
> +/**
> + * pbus_upstream_assigned_limit - Check no upstream resource limits allocation
> + * @bus:	The bus
> + * @mask:	Mask the resource flag, then compare it with type
> + * @type:	The type of resource from bridge
> + * @size:	The size required from the bridge window
> + * @align:	Required alignment for the resource
> + *
> + * Checks that @size can fit inside the upstream bridge resources that are
> + * already assigned.
> + *
> + * Return: -ENOSPC if @size cannot fit into an already assigned resource
> + * upstream resource.

I guess this returns 0 on success, right?  But more comments below.

> + */
> +static int pbus_upstream_assigned_limit(struct pci_bus *bus, unsigned long mask,
> +					unsigned long type, resource_size_t size,
> +					resource_size_t align)
> +{
> +	struct resource_constraint constraint = {
> +		.max = RESOURCE_SIZE_MAX,
> +		.align = align,
> +	};
> +	struct pci_bus *downstream = bus;
> +	struct resource *r;
> +
> +	while ((bus = bus->parent)) {
> +		if (pci_is_root_bus(bus))
> +			break;
> +
> +		pci_bus_for_each_resource(bus, r) {
> +			if (!r || !r->parent || (r->flags & mask) != type)
> +				continue;
> +
> +			if (resource_size(r) >= size) {
> +				struct resource gap = {};
> +
> +				if (!find_empty_resource_slot(r, &gap, size, &constraint))

I would test "find_empty_resource_slot(...) == 0" since it doesn't
return a boolean.

IIUC, when find_empty_resource_slot() returns 0, it fills in
gap.start/end/flags.  Is there anything useful we can do with that
information, e.g., a dbg log message?

I think find_empty_resource_slot() doesn't actually *allocate* the
space, right?  So there would be a race between this and the
allocation in pci_claim_resource(), except that there's nobody else
allocating in this hierarchy because ...?

> +					return 0;
> +			}
> +
> +			if (bus->self) {
> +				pci_dbg(bus->self,
> +					"Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
> +					r, &bus->busn_res,
> +					(unsigned long long)size,
> +					pci_name(downstream->self),
> +					&downstream->busn_res);
> +			}
> +
> +			return -ENOSPC;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * pbus_size_mem() - Size the memory window of a given bus
>   *
> @@ -986,7 +1043,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  			 struct list_head *realloc_head)
>  {
>  	struct pci_dev *dev;
> -	resource_size_t min_align, align, size, size0, size1;
> +	resource_size_t min_align, win_align, align, size, size0, size1;
>  	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
>  	int order, max_order;
>  	struct resource *b_res = find_bus_resource_of_type(bus,
> @@ -1064,10 +1121,23 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
>  		}
>  	}
>  
> +	win_align = window_alignment(bus, b_res->flags);
>  	min_align = calculate_mem_align(aligns, max_order);
> -	min_align = max(min_align, window_alignment(bus, b_res->flags));
> +	min_align = max(min_align, win_align);
>  	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
>  	add_align = max(min_align, add_align);
> +
> +	if (bus->self && size0 &&
> +	    pbus_upstream_assigned_limit(bus, mask | IORESOURCE_PREFETCH, type,
> +					 size0, add_align)) {

The IORESOURCE_PREFETCH here -- does that just mean that "type" must
match exactly, including whether IORESOURCE_PREFETCH is set or not?

I guess pbus_upstream_assigned_limit() being true (-ENOSPC) basically
means there's no available space for "size0, add_align" in the
upstream window?

Since it's used as a predicate, I wonder if it could return true/false
and be named something like "pbus_upstream_space_available()" and test
it with "!pbus_upstream_space_available()" here?

> +		min_align = 1ULL << (max_order + 20);

We never had any comments about what "max_order" means.  I vaguely
remember it's basically in 1MB units because of these:

  resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */

  * aligns[0] is for 1MB (since bridge memory
  * windows are always at least 1MB aligned), so
  * keep "order" from being negative for smaller
  * resources.

> +		min_align = max(min_align, win_align);
> +		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
> +		add_align = win_align;
> +		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
> +			 b_res, &bus->busn_res);

Is there any hint we can give in the message about what "relaxed
alignment rules" means, or how we decided we needed them?

> +	}
> +
>  	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
>  		calculate_memsize(size, min_size, add_size, children_add_size,
>  				resource_size(b_res), add_align);
> -- 
> 2.30.2
> 

