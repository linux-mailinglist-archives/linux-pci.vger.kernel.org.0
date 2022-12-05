Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E5B64238E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 08:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiLEH2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 02:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEH2M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 02:28:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ADD10050
        for <linux-pci@vger.kernel.org>; Sun,  4 Dec 2022 23:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670225288; x=1701761288;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dSzCWCkfrJQPb+qk52VkVNxEdOBdFwekiG5zgi0Qq7s=;
  b=lTXnVeH72XTybQg0ECbhYcc4NEpbt+Mx721QX/h4P0YCeYH2h8qX0L9j
   vKpOF/B9S2tBl6fMl/ZoRvlqluX8LD+pK3ZAKrss5FhpZNacrJkVKjJO5
   Zu8UAcDGw6EqVSCgVXt3wRyN8DqQ3DSJ35Nf/lBbe4e9wwjBi1SBTVEci
   8iKedok45ZUaHEKFgzq5hZ6UfxQTxOf4ik6/ozUkCBeAE8JSP/Fjr0GW1
   rdL39f9HSE3kjSbOi3vU1xGzwMJU3hQo2RaP+1LYu3dVgI0s6zM660UW0
   EJw3Q83VlDrA+8F69lWhu08ACeKx4ZgNEjvM9ahCNSXcteddt6kU9nPj/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="378442710"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="378442710"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 23:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="974583615"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="974583615"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Dec 2022 23:28:03 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A312CF4; Mon,  5 Dec 2022 09:28:30 +0200 (EET)
Date:   Mon, 5 Dec 2022 09:28:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <Y42dniafcY76DctG@black.fi.intel.com>
References: <20221130112221.66612-2-mika.westerberg@linux.intel.com>
 <20221202233424.GA1070935@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202233424.GA1070935@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Dec 02, 2022 at 05:34:24PM -0600, Bjorn Helgaas wrote:
> Hi Mika,
> 
> On Wed, Nov 30, 2022 at 01:22:20PM +0200, Mika Westerberg wrote:
> > A PCI bridge may reside on a bus with other devices as well. The
> > resource distribution code does not take this into account properly and
> > therefore it expands the bridge resource windows too much, not leaving
> > space for the other devices (or functions a multifunction device) and
> 
> functions *of* a 
> 
> > this leads to an issue that Jonathan reported. He runs QEMU with the
> > following topoology (QEMU parameters):
> 
> topology
> 
> >  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
> >  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
> >  -device e1000,bus=root_port13,addr=0.1 			\
> >  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
> >  -device e1000,bus=fun1
> 
> If you use spaces instead of tabs above, the "\" will stay lined up
> when git log indents.

Sure.

> > The first e1000 NIC here is another function in the switch upstream
> > port. This leads to following errors:
> > 
> >   pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
> >   pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
> >   pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
> >   e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> > 
> > Fix this by taking into account the possible multifunction devices when
> > uptream port resources are distributed.
> 
> "upstream", although I think I would word this so it's less
> PCIe-centric.  IIUC, we just want to account for all the BARs on the
> bus, whether they're in bridges, peers in a multi-function device, or
> other devices.

Okay.

> > Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> >  drivers/pci/setup-bus.c | 66 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 62 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index b4096598dbcb..d456175ddc4f 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1830,10 +1830,68 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	 * bridges below.
> >  	 */
> >  	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate)
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, io, mmio, mmio_pref);
> > +		bridge = NULL;
> > +
> > +		/* Find the single bridge on this bus first */
> > +		for_each_pci_bridge(dev, bus) {
> > +			bridge = dev;
> > +			break;
> > +		}
> 
> If we just remember "bridge" in the loop before this hunk, could we
> get rid of the loop here?  E.g.,
> 
>   bridge = NULL;
>   for_each_pci_bridge(dev, bus) {
>     bridge = dev;
>     if (dev->is_hotplug_bridge)
>       hotplug_bridges++;
>     else
>       normal_bridges++;
>   }

Yes, I think that would work too.

> > +
> > +		if (WARN_ON_ONCE(!bridge))
> > +			return;
> 
> Then I think this would be superfluous.
> 
> > +		if (!bridge->subordinate)
> > +			return;
> > +
> > +		/*
> > +		 * Reduce the space available for distribution by the
> > +		 * amount required by the other devices on the same bus
> > +		 * as this bridge.
> > +		 */
> > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > +			int i;
> > +
> > +			if (dev == bridge)
> > +				continue;
> 
> Why do we skip "bridge"?  Bridges are allowed to have two BARs
> themselves, and it seems like they should be included here.

Good point but then we would need to skip below the bridge window
resources to avoid accounting them.

> > +			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> > +				const struct resource *dev_res = &dev->resource[i];
> > +				resource_size_t dev_sz;
> > +				struct resource *b_res;
> > +
> > +				if (dev_res->flags & IORESOURCE_IO) {
> > +					b_res = &io;
> > +				} else if (dev_res->flags & IORESOURCE_MEM) {
> > +					if (dev_res->flags & IORESOURCE_PREFETCH)
> > +						b_res = &mmio_pref;
> > +					else
> > +						b_res = &mmio;
> > +				} else {
> > +					continue;
> > +				}
> > +
> > +				/* Size aligned to bridge window */
> > +				align = pci_resource_alignment(bridge, b_res);
> > +				dev_sz = ALIGN(resource_size(dev_res), align);
> > +				if (!dev_sz)
> > +					continue;
> > +
> > +				pci_dbg(dev, "resource %pR aligned to %#llx\n",
> > +					dev_res, (unsigned long long)dev_sz);
> > +
> > +				if (dev_sz > resource_size(b_res))
> > +					memset(b_res, 0, sizeof(*b_res));
> > +				else
> > +					b_res->end -= dev_sz;
> > +
> > +				pci_dbg(bridge, "updated available resources to %pR\n",
> > +					b_res);
> > +			}
> > +		}
> 
> This only happens for buses with a single bridge.  Shouldn't it happen
> regardless of how many bridges there are?

This branch specifically deals with the "upstream port" so it gives all
the spare resources to that upstream port. The whole resource
distribution is actually done to accommondate Thunderbolt/USB4
topologies which involve only PCIe devices so we always have PCIe
upstream port and downstream ports which some of them are able to
perform native PCIe hotplug. And for those ports we want to distribute
the available resources so that they can expand to further topologies.

I'm slightly concerned that forcing this to support the "generic" PCI
case makes this rather complicated. This is something that never appears
in the regular PCI based systems because we never distribute resources
for those in the first place (->is_hotplug_bridge needs to be set).

> This block feels like something that could be split out to a separate
> function.  It looks like it only needs "bus", "io", "mmio",
> "mmio_pref", and maybe "bridge".

Makes sense.

> I don't understand the "bridge" part; it looks like that's basically
> to use 4K alignment for I/O windows and 1M for memory windows?
> Using "bridge" seems like a clunky way to figure that out.

Okay, but if not using "bridge", how exactly you suggest to doing the
calculation?
