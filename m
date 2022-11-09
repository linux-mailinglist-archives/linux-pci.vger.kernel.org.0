Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58143622BC7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Nov 2022 13:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKIMk4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 07:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiKIMkz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 07:40:55 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2C205C1
        for <linux-pci@vger.kernel.org>; Wed,  9 Nov 2022 04:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667997654; x=1699533654;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G/1NU8xf8az8iWHTUXtWLHXYo2LBQjIzGMM5puUE7eQ=;
  b=WJWR0w3VSjp9u1GDVKvGoiYOm0vIpQDF09L19MnUWT7iS29CGkVYFxcl
   ebX+kn+z8meVGk4Cy6XERxOoIK6uVpZC4HESN7HPMkLwwi4qAdArq6ep8
   wAKWfQY9bj4mAEAbCMDBXnaKZGc2eFnu1iWl6P3KnSydoK1OPRUbusOdW
   e6Skf7N/+KKoXooAulpiV7AFTrwXop6afz/kST20BIaZAwNxx2yw8zsMi
   f6HfJZSxeEOKwFf3cD5/S2Pec3FsdN6DESwACO1Xw3dzusov8gPr0mGOo
   3HykFwouwuqiHjNoeN/y6irs+BxglLztZeEzOQhaCG4Qu2mfeIgkSizq8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="312764908"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="312764908"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 04:40:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="667977595"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; 
   d="scan'208";a="667977595"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 09 Nov 2022 04:40:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 50AC3155; Wed,  9 Nov 2022 14:41:15 +0200 (EET)
Date:   Wed, 9 Nov 2022 14:41:15 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: Take multifunction devices into account when
 distributing resources
Message-ID: <Y2uf62ifyeb5RciE@black.fi.intel.com>
References: <20221103103254.30497-1-mika.westerberg@linux.intel.com>
 <20221108211130.GA501583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108211130.GA501583@bhelgaas>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 03:11:30PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 03, 2022 at 12:32:53PM +0200, Mika Westerberg wrote:
> > It is possible to have PCIe switch upstream port a multifunction device.
> 
> I can't quite parse this.  I guess the point is that a Switch Upstream
> Port may be one of the functions of a multifunction device?

Yes.

> > The resource distribution code does not take this into account properly
> > and therefore it expands the upstream port resource windows too much,
> > not leaving space for the other functions (in the multifunction device)
> > and this leads to an issue that Jonathan reported. He runs QEMU with
> > the following topoology (QEMU parameters):
> > 
> >  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
> >  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
> >  -device e1000,bus=root_port13,addr=0.1 			\
> >  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
> >  -device e1000,bus=fun1
> > 
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
> Can you include the link to Jonathan's report?

Sure I will.

> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > ---
> > Hi,
> > 
> > This is the formal patch that resulted from the discussion here:
> > 
> > https://lore.kernel.org/linux-pci/20220905080232.36087-5-mika.westerberg@linux.intel.com/T/#m724289d0ee0c1ae07628744c283116e60efaeaf1
> > 
> > Only change from that version is that we loop through all resources of
> > the multifunction device.
> > 
> >  drivers/pci/setup-bus.c | 63 ++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 59 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index b4096598dbcb..c8787b187ee4 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1830,10 +1830,65 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	 * bridges below.
> >  	 */
> >  	if (hotplug_bridges + normal_bridges == 1) {
> > -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > -		if (dev->subordinate)
> > -			pci_bus_distribute_available_resources(dev->subordinate,
> > -				add_list, io, mmio, mmio_pref);
> > +		/* Upstream port must be the first */
> 
> Do you have any citation or reasoning for this handy?  We had this
> assumption before, and it seems true that an Upstream Port must be
> Function 0 because a variety of Link-related things have to be in
> Function 0, e.g., ARI ASPM Control, ARI Clock PM, Autonomous Width
> Disable, Flit Mode Disable, LTR Enable, OBFF Enable, etc.  But those
> are all pretty oblique.
> 
> I guess it's better to have the comment than not, but is the sort of
> assertion that makes one wonder why it is true.

Unfortunately I was not able to find such reference from the PCIe spec :(

> > +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > +		if (!bridge->subordinate)
> > +			return;
> > +
> > +		/*
> > +		 * It is possible to have switch upstream port as a part
> > +		 * of a multifunction device. For this reason reduce the
> > +		 * resources occupied by the other functions before
> > +		 * distributing the rest.
> 
> The space consumed by the peer functions of the Switch Upstream Port
> is determined by their BAR sizes, so I don't think we actually reduce
> that.
> 
> I *think* the point here is to reduce the space available for
> distribution by the amount required by the peers of the Switch
> Upstream Port, right?  I.e., "mmio" is the amount of space we have to
> distribute, and before splitting it across devices on the secondary
> bus, we need to save out the space required for peers on the primary
> bus.

Yes, I will update the comment accordingly.

> > +		 */
> > +		list_for_each_entry(dev, &bus->devices, bus_list) {
> > +			int i;
> > +
> > +			if (dev == bridge)
> > +				continue;
> > +
> > +			/*
> > +			 * It should be multifunction but if not stop
> > +			 * the distribution and bail out.
> > +			 */
> > +			if (!dev->multifunction)
> > +				return;
> 
> Why do we bother with this?  If there are multiple devices on the bus,
> don't we want to consider them all, regardless of whether
> dev->multifunction is set?  It seems like a gratuitous check.

Agreed, I will remove it.

> 
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
> > +
> > +				pci_dbg(dev, "%pR aligned to %llx\n", dev_res,
> 
> %#llx to avoid confusion and match other output.

OK.
