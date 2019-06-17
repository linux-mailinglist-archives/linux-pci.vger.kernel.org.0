Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D10C47E32
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfFQJVX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 05:21:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:8303 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfFQJVX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 05:21:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jun 2019 02:21:23 -0700
X-ExtLoop1: 1
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 17 Jun 2019 02:21:20 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 17 Jun 2019 12:21:20 +0300
Date:   Mon, 17 Jun 2019 12:21:19 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 1/4] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20190617092119.GM2640@lahna.fi.intel.com>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
 <PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
 <20190615195636.GX13533@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190615195636.GX13533@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 15, 2019 at 02:56:36PM -0500, Bjorn Helgaas wrote:
> Mika, this patch changes code you added in 1a5767725cec ("PCI:
> Distribute available resources to hotplug-capable bridges").  Is there
> any chance you could help review this?

Sure, I'll take a look and comment separately.

> On Wed, May 22, 2019 at 02:30:44PM +0000, Nicholas Johnson wrote:
> > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > with different resource alignment requirements. Pass more details
> > arguments recursively to track the resource start and end addresses
> > relative to the initial hotplug bridge. This is especially useful for
> > Thunderbolt with native PCI enumeration, enabling external graphics
> > cards and other devices with bridge alignment higher than 0x100000
> > bytes.
> > 
> > Change extend_bridge_window to resize the actual resource, rather than
> > using add_list and dev_res->add_size. If an additional resource entry
> > exists for the given resource, zero out the add_size field to avoid it
> > interfering. Because add_size is considered optional when allocating,
> > using add_size could cause issues in some cases, because successful
> > resource distribution requires sizes to be guaranteed. Such cases
> > include hot-adding nested hotplug bridges in one enumeration, and
> > potentially others which are yet to be encountered.
> > 
> > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > ---
> >  drivers/pci/setup-bus.c | 169 ++++++++++++++++++++--------------------
> >  1 file changed, 84 insertions(+), 85 deletions(-)
> > 
> > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > index 0cdd5ff38..1b5b851ca 100644
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -1835,12 +1835,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> >  }
> >  
> >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > -					    struct list_head *add_list,
> > -					    resource_size_t available_io,
> > -					    resource_size_t available_mmio,
> > -					    resource_size_t available_mmio_pref)
> > +	struct list_head *add_list, struct resource io,
> > +	struct resource mmio, struct resource mmio_pref)
> 
> Follow the parameter indentation style of the rest of the file.
> 
> >  {
> > -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> >  	struct pci_dev *dev, *bridge = bus->self;
> > @@ -1850,29 +1848,36 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> >  
> >  	/*
> > -	 * Update additional resource list (add_list) to fill all the
> > -	 * extra resource space available for this port except the space
> > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > -	 * devices currently connected to the port and below.
> > +	 * The alignment of this bridge is yet to be considered, hence it must
> > +	 * be done now before extending its bridge window. A single bridge
> > +	 * might not be able to occupy the whole parent region if the alignment
> > +	 * differs - for example, an external GPU at the end of a Thunderbolt
> > +	 * daisy chain.
> 
> The example seems needlessly specific.  There isn't anything GPU- or
> Thunderbolt-specific about this, is there?
> 
> Bridge windows can be aligned to any multiple of 1MB.  But a device
> BAR must be aligned on its size, so any BAR larger than 1MB should be
> able to cause this, e.g.,
> 
>   [mem 0x100000-0x3fffff] (bridge A 3MB window)
>     [mem 0x200000-0x3fffff] (bridge B 2MB window)
>       [mem 0x200000-0x3fffff] (device 2MB BAR)
> 
> Bridge B *could* occupy the the entire 3MB parent region, but it
> doesn't need to.  But you say it "might not be *able* to", so maybe
> you're thinking of something different?
> 
> > -	extend_bridge_window(bridge, io_res, add_list, available_io);
> > -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> > -	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > -			     available_mmio_pref);
> > +	align = pci_resource_alignment(bridge, io_res);
> > +	if (!io_res->parent && align)
> > +		io.start = ALIGN(io.start, align);
> > +
> > +	align = pci_resource_alignment(bridge, mmio_res);
> > +	if (!mmio_res->parent && align)
> > +		mmio.start = ALIGN(mmio.start, align);
> > +
> > +	align = pci_resource_alignment(bridge, mmio_pref_res);
> > +	if (!mmio_pref_res->parent && align)
> > +		mmio_pref.start = ALIGN(mmio_pref.start, align);
> >  
> >  	/*
> > -	 * Calculate the total amount of extra resource space we can
> > -	 * pass to bridges below this one.  This is basically the
> > -	 * extra space reduced by the minimal required space for the
> > -	 * non-hotplug bridges.
> > +	 * Update the resources to fill as much remaining resource space in the
> > +	 * parent bridge as possible, while considering alignment.
> >  	 */
> > -	remaining_io = available_io;
> > -	remaining_mmio = available_mmio;
> > -	remaining_mmio_pref = available_mmio_pref;
> > +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> > +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> > +	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > +		resource_size(&mmio_pref));
> >  
> >  	/*
> >  	 * Calculate how many hotplug bridges and normal bridges there
> > -	 * are on this bus.  We will distribute the additional available
> > +	 * are on this bus. We will distribute the additional available
> 
> This whitespace change is pointless and distracting.
> 
> >  	 * resources between hotplug bridges.
> >  	 */
> >  	for_each_pci_bridge(dev, bus) {
> > @@ -1882,104 +1887,98 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> >  			normal_bridges++;
> >  	}
> >  
> > +	/*
> > +	 * There is only one bridge on the bus so it gets all possible
> > +	 * resources which it can then distribute to the possible
> > +	 * hotplug bridges below.
> > +	 */
> > +	if (hotplug_bridges + normal_bridges == 1) {
> > +		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > +		if (dev->subordinate)
> > +			pci_bus_distribute_available_resources(dev->subordinate,
> > +				add_list, io, mmio, mmio_pref);
> > +		return;
> > +	}
> 
> Moving this "single bridge" case up makes sense, and I think it could
> be done by a separate patch preceding this one.  Mika, I remember some
> discussion about this case, but I can't remember if there's some
> reason you didn't do this initially.

The single bridge case was already moved outside of the loop in
14fe5951b667 ("PCI: Move resource distribution for single bridge outside
loop"). But indeed there is no dependency to the code below so probably
just my oversight why it was not moved further up.
