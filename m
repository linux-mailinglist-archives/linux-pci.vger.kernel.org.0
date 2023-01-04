Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A465E0A1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 00:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjADWzk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Jan 2023 17:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjADWze (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2023 17:55:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F93C47301
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 14:55:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4730561870
        for <linux-pci@vger.kernel.org>; Wed,  4 Jan 2023 22:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F4EC433EF;
        Wed,  4 Jan 2023 22:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672872491;
        bh=m120t54MHyTI4cwCRgzjqWv9G/91OZQMy74pN9/FOE0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pj9mU6Y8BzCABuyv+tqaFD1xHluJjxu8Et9bjIkkug+9gjkufyu8X/XNgMPgMhvBi
         EiTbtv+FQ0mSDAcQuPszK8QMiioNZtVSzIafUudrr8lMgiH7XLRYrqbFSvluzezheg
         njJRUXpVB7sXEO4GKKE3uBRck1hgPShhd4Hbnnw8CAB38hlild1xT/VdK+pVNIstib
         jI41GiuFFId6GKa2kjNa+Fb5ELlqHgBFxKPEpkqpIlSML6AxaRDOiazRFWXXW0IbJr
         +F81plHqRCS2/MXxHOa2hPdVxAqQDFkwKY/lesgVNIig0DxAODoOI5qd9ckTaqrxm1
         t/wN+2Euz1Z7A==
Date:   Wed, 4 Jan 2023 16:48:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Alexander Motin <mav@ixsystems.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20230104224809.GA1094900@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104091635.63331-2-mika.westerberg@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 04, 2023 at 11:16:34AM +0200, Mika Westerberg wrote:
> A PCI bridge may reside on a bus with other devices as well. The
> resource distribution code does not take this into account properly and
> therefore it expands the bridge resource windows too much, not leaving
> space for the other devices (or functions of a multifunction device) and
> this leads to an issue that Jonathan reported. He runs QEMU with the
> following topology (QEMU parameters):
> 
>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2  \
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
>  -device e1000,bus=root_port13,addr=0.1                         \
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3    \
>  -device e1000,bus=fun1
> 
> The first e1000 NIC here is another function in the switch upstream
> port. This leads to following errors:
> 
>   pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
>   pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
>   pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
>   e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> Fix this by taking into account the device BARs on the bus, including
> the ones belonging to bridges themselves.

I think it accounts for bridge windows (and VF BARs from SR-IOV
Capabilities) as well as regular BARs, doesn't it?

> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Link: https://lore.kernel.org/linux-pci/6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reported-by: Alexander Motin <mav@ixsystems.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 205 +++++++++++++++++++++++++---------------
>  1 file changed, 129 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..cf6a7bdf2427 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1750,6 +1750,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  				 resource_size_t new_size)
>  {
>  	resource_size_t add_size, size = resource_size(res);
> +	resource_size_t min_size;
>  
>  	if (res->parent)
>  		return;
> @@ -1757,30 +1758,87 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  	if (!new_size)
>  		return;
>  
> +	/* Minimum granularity of a bridge bridge window */

bridge bridge (fixed in my copy)

> +	min_size = window_alignment(bridge->bus, res->flags);
> +
>  	if (new_size > size) {
>  		add_size = new_size - size;
> +		if (add_size < min_size)
> +			return;
>  		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
>  			&add_size);
>  	} else if (new_size < size) {
>  		add_size = size - new_size;
> +		if (add_size < min_size)
> +			return;
>  		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
>  			&add_size);
> +	} else {
> +		return;
>  	}
>  
>  	res->end = res->start + new_size - 1;
>  	remove_from_list(add_list, res);
>  }
>  
> +static void reduce_dev_resources(struct pci_dev *dev, struct resource *io,
> +				 struct resource *mmio,
> +				 struct resource *mmio_pref)

IIUC, this is removing the space consumed by "dev" from io, mmio,
mmio_pref.

> +{
> +	int i;
> +
> +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +		struct resource *res = &dev->resource[i];
> +		resource_size_t align, tmp, size;
> +
> +		size = resource_size(res);
> +		if (!size)
> +			continue;
> +
> +		align = pci_resource_alignment(dev, res);
> +
> +		if (resource_type(res) == IORESOURCE_IO) {
> +			align = align ? ALIGN(io->start, align) - io->start : 0;
> +			tmp = align + size;
> +			io->start = min(io->start + tmp, io->end + 1);

Do you think it would be worth a helper to do this repeated
calculation?  AFAICT they're all the same.

  static void remove_dev_res(struct resource *avail, struct pci_dev *dev, struct resource *res)
  {
    size = resource_size(res);
    if (!size)
      return;

    align = pci_resource_alignment(dev, res);
    align = align ? ALIGN(avail->start, align) - avail->start : 0;
    tmp = align + size;
    avail->start = min(avail->start + tmp, avail->end + 1);
  }

  if (resource_type(res) == IORESOURCE_IO)
    remove_dev_res(io, dev, res);
  else if (resource_type(res) == IORESOURCE_MEM) {
    if (res->flags & IORESOURCE_PREFETCH)
      remove_dev_res(mmio_pref, dev, res);
    else
      remove_dev_res(mmio, dev, res);
  }

I don't quite understand how it works.  What's the case where "align"
can be zero?  Will we remove VF BARs twice, once while processing the
PF (where pf->resource[PCI_IOV_RESOURCES] contains space for BAR 0 of
all the VFs), and again while processing the VFs?

> +		} else if (resource_type(res) == IORESOURCE_MEM) {
> +			if (res->flags & IORESOURCE_PREFETCH) {
> +				align = align ? ALIGN(mmio_pref->start, align) -
> +						mmio_pref->start : 0;
> +				tmp = align + size;
> +				mmio_pref->start = min(mmio_pref->start + tmp,
> +						       mmio_pref->end + 1);
> +			} else {
> +				align = align ? ALIGN(mmio->start, align) -
> +						mmio->start : 0;
> +				tmp = align + size;
> +				mmio->start = min(mmio->start + tmp,
> +						  mmio->end + 1);
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * io, mmio and mmio_pref contain the total amount of bridge window
> + * space available. This includes the minimal space needed to cover all
> + * the existing devices on the bus and the possible extra space that can
> + * be shared with the bridges.

So "mmio" is space available on "bus", i.e., this is a window that
bus->self forwards to "bus" and is available for devices on "bus"?

This space would be available for devices on "bus", i.e., for BARs of
those devices and windows of any bridges to devices below "bus"?

> + * The resource space consumed by bus->self (the bridge) is already
> + * reduced.

I don't quite get what this is telling me.  If "mmio" is space
forwarded to "bus" by bus->self, what does it mean for it to be
reduced?  If bus->self forwards it, the entire space should be
available on "bus".

> + */
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  					    struct list_head *add_list,
>  					    struct resource io,
>  					    struct resource mmio,
>  					    struct resource mmio_pref)
>  {
> +	resource_size_t io_align, mmio_align, mmio_pref_align;
> +	resource_size_t io_per_b, mmio_per_b, mmio_pref_per_b;
>  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
>  	struct resource *io_res, *mmio_res, *mmio_pref_res;
>  	struct pci_dev *dev, *bridge = bus->self;
> -	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
>  
>  	io_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
>  	mmio_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> @@ -1790,17 +1848,17 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * The alignment of this bridge is yet to be considered, hence it must
>  	 * be done now before extending its bridge window.
>  	 */
> -	align = pci_resource_alignment(bridge, io_res);
> -	if (!io_res->parent && align)
> -		io.start = min(ALIGN(io.start, align), io.end + 1);
> +	io_align = pci_resource_alignment(bridge, io_res);
> +	if (!io_res->parent && io_align)
> +		io.start = min(ALIGN(io.start, io_align), io.end + 1);
>  
> -	align = pci_resource_alignment(bridge, mmio_res);
> -	if (!mmio_res->parent && align)
> -		mmio.start = min(ALIGN(mmio.start, align), mmio.end + 1);
> +	mmio_align = pci_resource_alignment(bridge, mmio_res);
> +	if (!mmio_res->parent && mmio_align)
> +		mmio.start = min(ALIGN(mmio.start, mmio_align), mmio.end + 1);
>  
> -	align = pci_resource_alignment(bridge, mmio_pref_res);
> -	if (!mmio_pref_res->parent && align)
> -		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
> +	mmio_pref_align = pci_resource_alignment(bridge, mmio_pref_res);
> +	if (!mmio_pref_res->parent && mmio_pref_align)
> +		mmio_pref.start = min(ALIGN(mmio_pref.start, mmio_pref_align),
>  			mmio_pref.end + 1);

It looks like this hunk and the corresponding "Make sure the split
resource space is properly aligned" one below could conceivably fix a
separate problem all by themselves?  If so, could be split to a
separate patch?

>  	/*
> @@ -1824,94 +1882,89 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  			normal_bridges++;
>  	}
>  
> -	/*
> -	 * There is only one bridge on the bus so it gets all available
> -	 * resources which it can then distribute to the possible hotplug
> -	 * bridges below.
> -	 */
> -	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> -		return;
> -	}
> -
> -	if (hotplug_bridges == 0)
> +	if (!(hotplug_bridges + normal_bridges))
>  		return;
>  
>  	/*
>  	 * Calculate the total amount of extra resource space we can
> -	 * pass to bridges below this one.  This is basically the
> -	 * extra space reduced by the minimal required space for the
> -	 * non-hotplug bridges.
> +	 * pass to bridges below this one.

The "space we can pass to bridges below this one" is the existing
language, but I think it's a little too restrictive.  A bridge
forwards space to the secondary bus, where it's available for any
device, not just bridges.

Maybe:

  Calculate the amount of space we can forward from "bus" to any
  downstream buses, i.e., the space left over after assigning the BARs
  and windows on "bus".

> +	   This is basically the extra
> +	 * space reduced by the minimal required space for the bridge
> +	 * windows and device BARs on this bus.
>  	 */
> -	for_each_pci_bridge(dev, bus) {
> -		resource_size_t used_size;
> -		struct resource *res;
> -
> -		if (dev->is_hotplug_bridge)
> -			continue;
> -
> -		/*
> -		 * Reduce the available resource space by what the
> -		 * bridge and devices below it occupy.
> -		 */
> -		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(io.start, align) - io.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			io.start = min(io.start + used_size, io.end + 1);
> -
> -		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			mmio.start = min(mmio.start + used_size, mmio.end + 1);
> +	list_for_each_entry(dev, &bus->devices, bus_list)
> +		reduce_dev_resources(dev, &io, &mmio, &mmio_pref);
>  
> -		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> -		align = pci_resource_alignment(dev, res);
> -		align = align ? ALIGN(mmio_pref.start, align) -
> -			mmio_pref.start : 0;
> -		used_size = align + resource_size(res);
> -		if (!res->parent)
> -			mmio_pref.start = min(mmio_pref.start + used_size,
> -				mmio_pref.end + 1);
> +	/*
> +	 * If there is at least one hotplug bridge on this bus it gets
> +	 * all the extra resource space that was left after the
> +	 * reductions above.
> +	 *
> +	 * If there are no hotplug bridges the extra resource space is
> +	 * split between non-hotplug bridges. This is to allow possible
> +	 * hotplug bridges below them to get the extra space as well.

I guess "hotplug_bridges" only counts bridges directly on "bus",
right?  I.e., we don't look deeper in the hierarchy for downstream
hotplug bridges?

What happens in a topology like this:

  10:00.0 non-hotplug bridge to [bus 20-3f]
  10:01.0 non-hotplug bridge to [bus 40]
  20:00.0 hotplug bridge
  40:00.0 NIC

where we're distributing space on "bus" 10, hotplug_bridges == 0 and
normal_bridges == 2?  Do we give half the extra space to bus 20 and
the other half to bus 40, even though we could tell up front that bus
20 is the only place that can actually use any extra space?

> +	 */
> +	if (hotplug_bridges) {
> +		io_per_b = div64_ul(resource_size(&io), hotplug_bridges);
> +		mmio_per_b = div64_ul(resource_size(&mmio), hotplug_bridges);
> +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> +					   hotplug_bridges);
> +	} else {
> +		io_per_b = div64_ul(resource_size(&io), normal_bridges);
> +		mmio_per_b = div64_ul(resource_size(&mmio), normal_bridges);
> +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> +					   normal_bridges);
>  	}
>  
> -	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> -	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> -	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> -		hotplug_bridges);
> -
>  	/*
> -	 * Go over devices on this bus and distribute the remaining
> -	 * resource space between hotplug bridges.
> +	 * Make sure the split resource space is properly aligned for
> +	 * bridge windows (align it down to avoid going above what is
> +	 * available).
>  	 */
> +	if (io_align)
> +		io_per_b = ALIGN_DOWN(io_per_b, io_align);
> +	if (mmio_align)
> +		mmio_per_b = ALIGN_DOWN(mmio_per_b, mmio_align);
> +	if (mmio_pref_align)
> +		mmio_pref_per_b = ALIGN_DOWN(mmio_pref_per_b, mmio_align);
> +
>  	for_each_pci_bridge(dev, bus) {
> +		resource_size_t allocated_io, allocated_mmio, allocated_mmio_pref;
> +		const struct resource *res;
>  		struct pci_bus *b;
>  
>  		b = dev->subordinate;
> -		if (!b || !dev->is_hotplug_bridge)
> +		if (!b)
> +			continue;
> +		if (hotplug_bridges && !dev->is_hotplug_bridge)
>  			continue;
>  
> +		io.end = io.start + io_per_b - 1;
>  		/*
> -		 * Distribute available extra resources equally between
> -		 * hotplug-capable downstream ports taking alignment into
> -		 * account.
> +		 * The x_per_b holds the extra resource space that can
> +		 * be added for each bridge but there is the minimal
> +		 * already reserved as well so adjust x.start down
> +		 * accordingly to cover the whole space.
>  		 */
> -		io.end = io.start + io_per_hp - 1;
> -		mmio.end = mmio.start + mmio_per_hp - 1;
> -		mmio_pref.end = mmio_pref.start + mmio_pref_per_hp - 1;
> +		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> +		allocated_io = resource_size(res);
> +		io.start -= allocated_io;
> +
> +		mmio.end = mmio.start + mmio_per_b - 1;
> +		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> +		allocated_mmio = resource_size(res);
> +		mmio.start -= allocated_mmio;
> +
> +		mmio_pref.end = mmio_pref.start + mmio_pref_per_b - 1;
> +		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +		allocated_mmio_pref = resource_size(res);
> +		mmio_pref.start -= allocated_mmio_pref;
>  
>  		pci_bus_distribute_available_resources(b, add_list, io, mmio,
>  						       mmio_pref);
>  
> -		io.start += io_per_hp;
> -		mmio.start += mmio_per_hp;
> -		mmio_pref.start += mmio_pref_per_hp;
> +		io.start += allocated_io + io_per_b;
> +		mmio.start += allocated_mmio + mmio_per_b;
> +		mmio_pref.start += allocated_mmio_pref + mmio_pref_per_b;
>  	}
>  }
>  
> -- 
> 2.35.1
> 
