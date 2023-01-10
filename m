Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735C5663D57
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jan 2023 10:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjAJJy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Jan 2023 04:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbjAJJx7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Jan 2023 04:53:59 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDF21A077
        for <linux-pci@vger.kernel.org>; Tue, 10 Jan 2023 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673344437; x=1704880437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IVWw58YeiPz/PxUQf6gzsxzPniAia3HsPHZW2g0duj8=;
  b=ZhsMAxs/1mmRo/RjSUJTRvrobLdFc5Ks0dA7LPOt6F/YSbIdjWOj0UpB
   ar17rmnCqUmjHvGFLYbJB3btx6swcNSh1sQjQxpYZToiLXgh82X0tMC42
   LblfLM79YislDCpFUt4ft6ixw7tzP2ukYUyNhdH/hMAoJWPQ91peoaTD1
   KcVkBcZ7wQA+p4lctXw/24iz+PVH2zNHXZ8BLdd/f97kbfgyJizq5jLeR
   DnqkQxhDzWFV+41TsMVZYW78h/59D47+kxIm8M3/9tPf1qsKtl2r7/sUg
   84H3lDd6hD3RybOQJsMyD7VWvpTFDOWrBtPffmMyoFSw5aiIQDv6/GgG+
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385409728"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="385409728"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 01:53:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="902314491"
X-IronPort-AV: E=Sophos;i="5.96,314,1665471600"; 
   d="scan'208";a="902314491"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jan 2023 01:53:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 88949E1; Tue, 10 Jan 2023 11:54:28 +0200 (EET)
Date:   Tue, 10 Jan 2023 11:54:28 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Alexander Motin <mav@ixsystems.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <Y7011Eg89E1cnoSU@black.fi.intel.com>
References: <20230104091635.63331-1-mika.westerberg@linux.intel.com>
 <20230104091635.63331-2-mika.westerberg@linux.intel.com>
 <7bdef8bb-7a5e-2b5d-35ba-56cefb38d91f@ixsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7bdef8bb-7a5e-2b5d-35ba-56cefb38d91f@ixsystems.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Mon, Jan 09, 2023 at 02:33:35PM -0500, Alexander Motin wrote:
> On 04.01.2023 04:16, Mika Westerberg wrote:
> > A PCI bridge may reside on a bus with other devices as well. The
> > resource distribution code does not take this into account properly and
> > therefore it expands the bridge resource windows too much, not leaving
> > space for the other devices (or functions of a multifunction device) and
> > this leads to an issue that Jonathan reported. He runs QEMU with the
> > following topology (QEMU parameters):
> > 
> >   -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2  \
> >   -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on \
> >   -device e1000,bus=root_port13,addr=0.1                         \
> >   -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3    \
> >   -device e1000,bus=fun1
> > 
> > The first e1000 NIC here is another function in the switch upstream
> > port. This leads to following errors:
> > 
> >    pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
> >    pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
> >    pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
> >    e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> > 
> > Fix this by taking into account the device BARs on the bus, including
> > the ones belonging to bridges themselves.
> > 
> > Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> > Link: https://lore.kernel.org/linux-pci/6053736d-1923-41e7-def9-7585ce1772d9@ixsystems.com/
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reported-by: Alexander Motin <mav@ixsystems.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >   drivers/pci/setup-bus.c | 205 +++++++++++++++++++++++++---------------
> >   1 file changed, 129 insertions(+), 76 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index b4096598dbcb..cf6a7bdf2427 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1750,6 +1750,7 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >   				 resource_size_t new_size)
> >   {
> >   	resource_size_t add_size, size = resource_size(res);
> > +	resource_size_t min_size;
> >   	if (res->parent)
> >   		return;
> > @@ -1757,30 +1758,87 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> >   	if (!new_size)
> >   		return;
> > +	/* Minimum granularity of a bridge bridge window */
> > +	min_size = window_alignment(bridge->bus, res->flags);
> > +
> >   	if (new_size > size) {
> >   		add_size = new_size - size;
> > +		if (add_size < min_size)
> > +			return;
> >   		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> >   			&add_size);
> >   	} else if (new_size < size) {
> >   		add_size = size - new_size;
> > +		if (add_size < min_size)
> > +			return;
> 
> May be I don't understand something, but in what situation it may happen,
> and won't it be a problem if you silently do nothing here, while the calling
> code will use the passed new_size as-is?

Good point.

I saw this happening when I run QEMU but now that I started to look at
it again the reason seems to be that there is a 32-bit prefetchable
option ROM BAR for the e1000 NIC and that gets reduced incorrectly by
the reduce_dev_resources() which causes the "imbalance".

> >   		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> >   			&add_size);
> > +	} else {
> > +		return;
> >   	}
> >   	res->end = res->start + new_size - 1;
> >   	remove_from_list(add_list, res);
> >   }
> > +static void reduce_dev_resources(struct pci_dev *dev, struct resource *io,
> > +				 struct resource *mmio,
> > +				 struct resource *mmio_pref)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +		struct resource *res = &dev->resource[i];
> > +		resource_size_t align, tmp, size;
> > +
> > +		size = resource_size(res);
> > +		if (!size)
> > +			continue;
> > +
> > +		align = pci_resource_alignment(dev, res);
> > +
> > +		if (resource_type(res) == IORESOURCE_IO) {
> > +			align = align ? ALIGN(io->start, align) - io->start : 0;
> > +			tmp = align + size;
> > +			io->start = min(io->start + tmp, io->end + 1);
> > +		} else if (resource_type(res) == IORESOURCE_MEM) {
> > +			if (res->flags & IORESOURCE_PREFETCH) {
> > +				align = align ? ALIGN(mmio_pref->start, align) -
> > +						mmio_pref->start : 0;
> > +				tmp = align + size;
> > +				mmio_pref->start = min(mmio_pref->start + tmp,
> > +						       mmio_pref->end + 1);
> > +			} else {
> > +				align = align ? ALIGN(mmio->start, align) -
> > +						mmio->start : 0;
> > +				tmp = align + size;
> > +				mmio->start = min(mmio->start + tmp,
> > +						  mmio->end + 1);
> > +			}
> > +		}
> > +	}
> > +}
> > +
> > +/*
> > + * io, mmio and mmio_pref contain the total amount of bridge window
> > + * space available. This includes the minimal space needed to cover all
> > + * the existing devices on the bus and the possible extra space that can
> > + * be shared with the bridges.
> > + *
> > + * The resource space consumed by bus->self (the bridge) is already
> > + * reduced.
> > + */
> >   static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >   					    struct list_head *add_list,
> >   					    struct resource io,
> >   					    struct resource mmio,
> >   					    struct resource mmio_pref)
> >   {
> > +	resource_size_t io_align, mmio_align, mmio_pref_align;
> > +	resource_size_t io_per_b, mmio_per_b, mmio_pref_per_b;
> >   	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> >   	struct resource *io_res, *mmio_res, *mmio_pref_res;
> >   	struct pci_dev *dev, *bridge = bus->self;
> > -	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> >   	io_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
> >   	mmio_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> > @@ -1790,17 +1848,17 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >   	 * The alignment of this bridge is yet to be considered, hence it must
> >   	 * be done now before extending its bridge window.
> >   	 */
> > -	align = pci_resource_alignment(bridge, io_res);
> > -	if (!io_res->parent && align)
> > -		io.start = min(ALIGN(io.start, align), io.end + 1);
> > +	io_align = pci_resource_alignment(bridge, io_res);
> > +	if (!io_res->parent && io_align)
> > +		io.start = min(ALIGN(io.start, io_align), io.end + 1);
> > -	align = pci_resource_alignment(bridge, mmio_res);
> > -	if (!mmio_res->parent && align)
> > -		mmio.start = min(ALIGN(mmio.start, align), mmio.end + 1);
> > +	mmio_align = pci_resource_alignment(bridge, mmio_res);
> > +	if (!mmio_res->parent && mmio_align)
> > +		mmio.start = min(ALIGN(mmio.start, mmio_align), mmio.end + 1);
> > -	align = pci_resource_alignment(bridge, mmio_pref_res);
> > -	if (!mmio_pref_res->parent && align)
> > -		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
> > +	mmio_pref_align = pci_resource_alignment(bridge, mmio_pref_res);
> > +	if (!mmio_pref_res->parent && mmio_pref_align)
> > +		mmio_pref.start = min(ALIGN(mmio_pref.start, mmio_pref_align),
> >   			mmio_pref.end + 1);
> >   	/*
> > @@ -1824,94 +1882,89 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >   			normal_bridges++;
> >   	}
> > -	/*
> > -	 * There is only one bridge on the bus so it gets all available
> > -	 * resources which it can then distribute to the possible hotplug
> > -	 * bridges below.
> > -	 */
> > -	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate)
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, io, mmio, mmio_pref);
> > -		return;
> > -	}
> > -
> > -	if (hotplug_bridges == 0)
> > +	if (!(hotplug_bridges + normal_bridges))
> >   		return;
> >   	/*
> >   	 * Calculate the total amount of extra resource space we can
> > -	 * pass to bridges below this one.  This is basically the
> > -	 * extra space reduced by the minimal required space for the
> > -	 * non-hotplug bridges.
> > +	 * pass to bridges below this one. This is basically the extra
> > +	 * space reduced by the minimal required space for the bridge
> > +	 * windows and device BARs on this bus.
> >   	 */
> > -	for_each_pci_bridge(dev, bus) {
> > -		resource_size_t used_size;
> > -		struct resource *res;
> > -
> > -		if (dev->is_hotplug_bridge)
> > -			continue;
> > -
> > -		/*
> > -		 * Reduce the available resource space by what the
> > -		 * bridge and devices below it occupy.
> > -		 */
> > -		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> > -		align = pci_resource_alignment(dev, res);
> > -		align = align ? ALIGN(io.start, align) - io.start : 0;
> > -		used_size = align + resource_size(res);
> > -		if (!res->parent)
> > -			io.start = min(io.start + used_size, io.end + 1);
> > -
> > -		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> > -		align = pci_resource_alignment(dev, res);
> > -		align = align ? ALIGN(mmio.start, align) - mmio.start : 0;
> > -		used_size = align + resource_size(res);
> > -		if (!res->parent)
> > -			mmio.start = min(mmio.start + used_size, mmio.end + 1);
> > +	list_for_each_entry(dev, &bus->devices, bus_list)
> > +		reduce_dev_resources(dev, &io, &mmio, &mmio_pref);
> > -		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> > -		align = pci_resource_alignment(dev, res);
> > -		align = align ? ALIGN(mmio_pref.start, align) -
> > -			mmio_pref.start : 0;
> > -		used_size = align + resource_size(res);
> > -		if (!res->parent)
> > -			mmio_pref.start = min(mmio_pref.start + used_size,
> > -				mmio_pref.end + 1);
> > +	/*
> > +	 * If there is at least one hotplug bridge on this bus it gets
> > +	 * all the extra resource space that was left after the
> > +	 * reductions above.
> > +	 *
> > +	 * If there are no hotplug bridges the extra resource space is
> > +	 * split between non-hotplug bridges. This is to allow possible
> > +	 * hotplug bridges below them to get the extra space as well.
> > +	 */
> > +	if (hotplug_bridges) {
> > +		io_per_b = div64_ul(resource_size(&io), hotplug_bridges);
> > +		mmio_per_b = div64_ul(resource_size(&mmio), hotplug_bridges);
> > +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> > +					   hotplug_bridges);
> > +	} else {
> > +		io_per_b = div64_ul(resource_size(&io), normal_bridges);
> > +		mmio_per_b = div64_ul(resource_size(&mmio), normal_bridges);
> > +		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
> > +					   normal_bridges);
> >   	}
> > -	io_per_hp = div64_ul(resource_size(&io), hotplug_bridges);
> > -	mmio_per_hp = div64_ul(resource_size(&mmio), hotplug_bridges);
> > -	mmio_pref_per_hp = div64_ul(resource_size(&mmio_pref),
> > -		hotplug_bridges);
> > -
> >   	/*
> > -	 * Go over devices on this bus and distribute the remaining
> > -	 * resource space between hotplug bridges.
> > +	 * Make sure the split resource space is properly aligned for
> > +	 * bridge windows (align it down to avoid going above what is
> > +	 * available).
> >   	 */
> > +	if (io_align)
> > +		io_per_b = ALIGN_DOWN(io_per_b, io_align);
> > +	if (mmio_align)
> > +		mmio_per_b = ALIGN_DOWN(mmio_per_b, mmio_align);
> > +	if (mmio_pref_align)
> > +		mmio_pref_per_b = ALIGN_DOWN(mmio_pref_per_b, mmio_align);
> 
> If I understand it right, you are applying alignment requirements of the
> parent bridge to the windows of its children.  I don't have examples of any
> bridge with different alignment, but shouldn't we better get and use proper
> alignment inside the loop below?

Yes, I agree.
