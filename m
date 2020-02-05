Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF8EC153576
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2020 17:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBEQm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Feb 2020 11:42:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgBEQm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Feb 2020 11:42:59 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74E2C218AC;
        Wed,  5 Feb 2020 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580920977;
        bh=Ij2N/v6BAs4xhD/0CaP23N/8PXjhCD7yww5yVmsXsFs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YE2F1raRg1RLYSd/WZJgtfGOsZgG9NU+3Wp7/DAGGtsY7Iag5As1pXrZl/1SyBO12
         xey67AQL9KyQqMVzeEINJy0cynOdrj3mBwV6yJUCU9aS1qNl24cl1TW0svmcjcrE3b
         AtEqnYhGgi5BZYk430LXZjxSR2SYdbgHKIdWARyY=
Date:   Wed, 5 Feb 2020 10:42:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 17/26] PCI: hotplug: Ignore the MEM BAR offsets from
 BIOS/bootloader
Message-ID: <20200205164255.GA205474@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d3dbb43dfc668b6e436fbcc78d63f14c88a056f.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 05, 2020 at 11:01:32AM +0000, Sergei Miroshnichenko wrote:
> On Fri, 2020-01-31 at 14:31 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2020 at 06:29:28PM +0300, Sergei Miroshnichenko
> > wrote:
> > > BAR allocation by BIOS/UEFI/bootloader/firmware may be
> > > non-optimal and it may even clash with the kernel's BAR
> > > assignment algorithm.
> > > 
> > > For example, sometimes BIOS doesn't reserve space for SR-IOV
> > > BARs, and this bridge window can neither extend (blocked by
> > > immovable BARs) nor move (the device itself is immovable).
> > > 
> > > With this patch the kernel will use its own methods of BAR
> > > allocating when possible, increasing the chances of successful
> > > boot and hotplug.
> > > 
> > > Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> > > ---
> > >  drivers/pci/probe.c | 16 ++++++++++++++--
> > >  1 file changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > > index bb584038d5b4..f8f643dac6d1 100644
> > > --- a/drivers/pci/probe.c
> > > +++ b/drivers/pci/probe.c
> > > @@ -306,6 +306,14 @@ int __pci_read_base(struct pci_dev *dev, enum
> > > pci_bar_type type,
> > >  			 pos, (unsigned long long)region.start);
> > >  	}
> > >  
> > > +	if (pci_can_move_bars && res->start && !(res->flags &
> > > IORESOURCE_IO)) {
> > > +		pci_warn(dev, "ignore the current offset of BAR %llx-
> > > %llx\n",
> > > +			 l64, l64 + sz64 - 1);
> > > +		res->start = 0;
> > > +		res->end = sz64 - 1;
> > > +		res->flags |= IORESOURCE_SIZEALIGN;
> > > +	}
> > > +
> > >  	goto out;
> > >  
> > >  
> > > @@ -528,8 +536,10 @@ void pci_read_bridge_bases(struct pci_bus
> > > *child)
> > >  		child->resource[i] = &dev-
> > > >resource[PCI_BRIDGE_RESOURCES+i];
> > >  
> > >  	pci_read_bridge_io(child);
> > > -	pci_read_bridge_mmio(child);
> > > -	pci_read_bridge_mmio_pref(child);
> > > +	if (!pci_can_move_bars) {
> > > +		pci_read_bridge_mmio(child);
> > > +		pci_read_bridge_mmio_pref(child);
> > > +	}
> > 
> > I mentioned this in another response, but I'll repeat it here to
> > comment on the code directly: I don't think we should have feature
> > tests like this "!pci_can_move_bars" scattered around, and I don't
> > want basic behaviors like reading bridge windows during enumeration
> > to
> > depend on it.
> > 
> > There's no obvious reason why we should ignore bridge windows if we
> > support movable BARs.
> 
> That patch solves a problem which is non-fatal during boot, but is
> breaking this whole patchset when trying a PCI rescan. On a specific
> machine we have a popular i350 network card:
> 
> $ lspci -tv
> -[0000:00]-...
>            +-01.1-[02]--+-00.0  Intel Corporation I350 Gigabit Network
> Connection
>            |            +-00.1  Intel Corporation I350 Gigabit Network
> Connection
>            |            +-00.2  Intel Corporation I350 Gigabit Network
> Connection
>            |            \-00.3  Intel Corporation I350 Gigabit Network
> Connection
> 
> On the "ROG STRIX Z370-F GAMING, BIOS 0612 03/01/2018" motherboard and
> vanilla kernel, not every BAR is allocated:
> 
> $ dmesg -t
>   ...
>   pci 0000:00:01.0: PCI bridge to [bus 01]
>   pci 0000:00:01.0:   bridge window [mem 0xf7700000-0xf78fffff]
>   pci 0000:02:00.0: BAR 7: assigned [mem 0xf7490000-0xf74affff]
>   pci 0000:02:00.0: BAR 10: assigned [mem 0xf74b0000-0xf74cffff]
>   pci 0000:02:00.1: BAR 7: assigned [mem 0xf74d0000-0xf74effff]
>   pci 0000:02:00.1: BAR 10: no space for [mem size 0x00020000]
>   pci 0000:02:00.1: BAR 10: failed to assign [mem size 0x00020000]
>   pci 0000:02:00.2: BAR 7: no space for [mem size 0x00020000]
>   pci 0000:02:00.2: BAR 7: failed to assign [mem size 0x00020000]
>   pci 0000:02:00.2: BAR 10: no space for [mem size 0x00020000]
>   pci 0000:02:00.2: BAR 10: failed to assign [mem size 0x00020000]
>   pci 0000:02:00.3: BAR 7: no space for [mem size 0x00020000]
>   pci 0000:02:00.3: BAR 7: failed to assign [mem size 0x00020000]
>   pci 0000:02:00.3: BAR 10: no space for [mem size 0x00020000]
>   pci 0000:02:00.3: BAR 10: failed to assign [mem size 0x00020000]
>   pci 0000:00:01.1: PCI bridge to [bus 02]
> 
> $ sudo cat /proc/iomem
>   ...
>   f7000000-f74fffff : PCI Bus 0000:02
>     f7000000-f70fffff : 0000:02:00.3
>       f7000000-f70fffff : igb
>     f7100000-f71fffff : 0000:02:00.2
>       f7100000-f71fffff : igb
>     f7200000-f72fffff : 0000:02:00.1
>       f7200000-f72fffff : igb
>     f7300000-f73fffff : 0000:02:00.0
>       f7300000-f73fffff : igb
>     f7400000-f747ffff : 0000:02:00.0
>     f7480000-f7483fff : 0000:02:00.3
>       f7480000-f7483fff : igb
>     f7484000-f7487fff : 0000:02:00.2
>       f7484000-f7487fff : igb
>     f7488000-f748bfff : 0000:02:00.1
>       f7488000-f748bfff : igb
>     f748c000-f748ffff : 0000:02:00.0
>       f748c000-f748ffff : igb
>     f7490000-f74affff : 0000:02:00.0
>     f74b0000-f74cffff : 0000:02:00.0
>     f74d0000-f74effff : 0000:02:00.1
> 
> But when allowing the kernel to allocate BARs properly, the map is
> full:
> 
>   c8200000-c87fffff : PCI Bus 0000:02
>     c8200000-c82fffff : 0000:02:00.0
>       c8200000-c82fffff : igb
>     c8300000-c83fffff : 0000:02:00.1
>       c8300000-c83fffff : igb
>     c8400000-c84fffff : 0000:02:00.2
>       c8400000-c84fffff : igb
>     c8500000-c85fffff : 0000:02:00.3
>       c8500000-c85fffff : igb
>     c8600000-c867ffff : 0000:02:00.0
>     c8680000-c8683fff : 0000:02:00.0
>       c8680000-c8683fff : igb
>     c8684000-c86a3fff : 0000:02:00.0
>     c86a4000-c86c3fff : 0000:02:00.0
>     c86c4000-c86c7fff : 0000:02:00.1
>       c86c4000-c86c7fff : igb
>     c86c8000-c86e7fff : 0000:02:00.1
>     c86e8000-c8707fff : 0000:02:00.1
>     c8708000-c870bfff : 0000:02:00.2
>       c8708000-c870bfff : igb
>     c870c000-c872bfff : 0000:02:00.2
>     c872c000-c874bfff : 0000:02:00.2
>     c874c000-c874ffff : 0000:02:00.3
>       c874c000-c874ffff : igb
>     c8750000-c876ffff : 0000:02:00.3
>     c8770000-c878ffff : 0000:02:00.3
> 
> In this particular case the "repaired" BARs are not vital and are not
> used by the igb driver, but in general such behavior of BIOS can lead
> to a non-working setup.
> 
> So ignoring pre-set BARs and bridge windows may be useful on its own,
> but it is also provides a working starting point required by this
> patchset, otherwise it will need to track such BARs impossible to
> assign, and don't try to assign them during a next PCI rescan.
> 
> The reason I've tied this feature to the "movable BARs" flag is that I
> know at least one exception demanding a workaround - VGA. So I wanted
> to provide a flag to disable it in case of other unforeseen
> consequences, and the only feature depends on this - is movable BARs.

If we need exceptions for broken or legacy devices, we should check
for those explicitly.

If we fail to assign some BARs at boot, I think it's reasonable to try
to reassign things before drivers claim the devices.  But support for
that should be in a reassignment path, not in the general enumeration
path.  And, since drivers aren't involved yet, it probably doesn't
even depend on pci_can_move_bars.

> The [07/26] "PCI: hotplug: Don't allow hot-added devices to steal
> resources" patch introduces an additional step in BAR assignment:
>  - try to assign every existing BAR + BARs of the hot-added device;
>  - it if fails, disable BARs for the hot-added device and retry without
>    them.
> 
> A possible way to work-around non-working BARs could be adding more
> steps:
>  - first try to assign every existing BAR + BARs not worked previously
>    + "hot-added" BARs;
>  - if it fails, retry without those BARs which weren't working before;
>  - if it still fails, retry without "hot-added" BARs.
> 
> Best regards,
> Serge
> 
> > >  	if (dev->transparent) {
> > >  		pci_bus_for_each_resource(child->parent, res, i) {
> > > @@ -2945,6 +2955,8 @@ int pci_host_probe(struct pci_host_bridge
> > > *bridge)
> > >  		pci_bus_claim_resources(bus);
> > >  	} else {
> > >  		pci_bus_size_bridges(bus);
> > > +		if (pci_can_move_bars)
> > > +			pci_bus_update_realloc_range(bus);
> > >  		pci_bus_assign_resources(bus);
> > >  
> > >  		list_for_each_entry(child, &bus->children, node)
> > > -- 
> > > 2.24.1
> > > 
