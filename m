Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB95E1639
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390802AbfJWJeY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 05:34:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:39490 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390165AbfJWJeY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:34:24 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 02:34:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,220,1569308400"; 
   d="scan'208";a="209886389"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 23 Oct 2019 02:34:19 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 23 Oct 2019 12:34:19 +0300
Date:   Wed, 23 Oct 2019 12:34:19 +0300
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v8 1/6] PCI: Consider alignment of hot-added bridges when
 distributing available resources
Message-ID: <20191023093419.GR2819@lahna.fi.intel.com>
References: <SL2P216MB01871E87E3A760E3AA87E27380C00@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191008113812.GF2819@lahna.fi.intel.com>
 <PSXP216MB0183D447FD3ADF6F82979439806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB0183D447FD3ADF6F82979439806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 09:08:42AM +0000, Nicholas Johnson wrote:
> On Tue, Oct 08, 2019 at 02:38:12PM +0300, mika.westerberg@linux.intel.com wrote:
> > Hi Nicholas,
> 
> Hi Mika,
> 
> I apologise for not responding quickly . I have switched off for a while 
> - taking my time to post the patches based on Linux 5.4. Hence, I was 
> not expecting any emails on this, and was not checking. Plus I was 
> starting to lose motivation.
> 
> I have been taking the time to change how I approach this. I am going to 
> post the patches to egpu.io forums to get a heap of people testing it 
> and hopefully saying nice things about it. Originally I thought it would 
> be quick to get the patches accepted so I was only going to announce 
> this after being accepted.
> 
> I also realised my patch series should not be a series. None of this is 
> specific to Thunderbolt and hence should not be a series. By separating 
> parts of this series, it may be easier to sign off and accept.
> 
> > 
> > On Fri, Jul 26, 2019 at 12:53:19PM +0000, Nicholas Johnson wrote:
> > > Rewrite pci_bus_distribute_available_resources to better handle bridges
> > > with different resource alignment requirements. Pass more details
> > > arguments recursively to track the resource start and end addresses
> > > relative to the initial hotplug bridge. This is especially useful for
> > > Thunderbolt with native PCI enumeration, enabling external graphics
> > > cards and other devices with bridge alignment higher than 1MB.
> > > 
> > > Change extend_bridge_window to resize the actual resource, rather than
> > > using add_list and dev_res->add_size. If an additional resource entry
> > > exists for the given resource, zero out the add_size field to avoid it
> > > interfering. Because add_size is considered optional when allocating,
> > > using add_size could cause issues in some cases, because successful
> > > resource distribution requires sizes to be guaranteed. Such cases
> > > include hot-adding nested hotplug bridges in one enumeration, and
> > > potentially others which are yet to be encountered.
> > > 
> > > Solves bug report: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> > 
> > Here better to use:
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=199581
> > 
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > 
> > This solves the issue I reported so,
> > 
> > Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> So this is adding "Tested-by" on top of "Reported-by" and not replacing 
> one with the other?

Yes.

> > 
> > There are a couple of comments below.
> > 
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > ---
> > >  drivers/pci/setup-bus.c | 148 +++++++++++++++++++---------------------
> > >  1 file changed, 71 insertions(+), 77 deletions(-)
> > > 
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 79b1fa651..6835fd64c 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1840,12 +1840,10 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> > >  }
> > >  
> > >  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > > -					    struct list_head *add_list,
> > > -					    resource_size_t available_io,
> > > -					    resource_size_t available_mmio,
> > > -					    resource_size_t available_mmio_pref)
> > > +	struct list_head *add_list, struct resource io,
> > > +	struct resource mmio, struct resource mmio_pref)
> > 
> > You pass a copy of each resource because you modify it inplace. I wonder
> > if it makes more sense to explicitly take a copy here with comments?
> 
> I have no qualms with modifying parameters, and sometimes quite like 
> doing it. I could do as you suggest but that means more lines of diff, 
> and Bjorn seems to be sending me a strong message that the less lines of 
> diff, the better.
> 
> I just noticed this: https://lkml.org/lkml/2019/10/4/337
> 
> Bjorn says I am touching critical and complicated code that he does not 
> understand. This could explain his aversion to more lines of diff.
> 
> If Bjorn will trust you to sign this off and take your assurance that it 
> is fine, then I can start taking your advice over his. I have been 
> favouring his advice because I figured he would have the final say as 
> the PCI subsystem maintainer.

Yes, if Bjorn says something you should listen to him and not me ;-)

I'm just trying to help him to review this because I think this is
important stuff.

This indeed touches the resource allocation code which is rather old and
not too well understood but then again it should not prevent us to
extend and make it better to support more configurations.

> > > -	resource_size_t remaining_io, remaining_mmio, remaining_mmio_pref;
> > > +	resource_size_t io_per_hp, mmio_per_hp, mmio_pref_per_hp, align;
> > >  	unsigned int normal_bridges = 0, hotplug_bridges = 0;
> > >  	struct resource *io_res, *mmio_res, *mmio_pref_res;
> > >  	struct pci_dev *dev, *bridge = bus->self;
> > > @@ -1855,15 +1853,29 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > >  	mmio_pref_res = &bridge->resource[PCI_BRIDGE_RESOURCES + 2];
> > >  
> > >  	/*
> > > -	 * Update additional resource list (add_list) to fill all the
> > > -	 * extra resource space available for this port except the space
> > > -	 * calculated in __pci_bus_size_bridges() which covers all the
> > > -	 * devices currently connected to the port and below.
> > > +	 * The alignment of this bridge is yet to be considered, hence it must
> > > +	 * be done now before extending its bridge window.
> > >  	 */
> > > -	extend_bridge_window(bridge, io_res, add_list, available_io);
> > > -	extend_bridge_window(bridge, mmio_res, add_list, available_mmio);
> > > +	align = pci_resource_alignment(bridge, io_res);
> > > +	if (!io_res->parent && align)
> > > +		io.start = ALIGN(io.start, align);
> > > +
> > > +	align = pci_resource_alignment(bridge, mmio_res);
> > > +	if (!mmio_res->parent && align)
> > > +		mmio.start = ALIGN(mmio.start, align);
> > > +
> > > +	align = pci_resource_alignment(bridge, mmio_pref_res);
> > > +	if (!mmio_pref_res->parent && align)
> > > +		mmio_pref.start = ALIGN(mmio_pref.start, align);
> > > +
> > > +	/*
> > > +	 * Update the resources to fill as much remaining resource space in the
> > > +	 * parent bridge as possible, while considering alignment.
> > > +	 */
> > > +	extend_bridge_window(bridge, io_res, add_list, resource_size(&io));
> > > +	extend_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
> > >  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > > -			     available_mmio_pref);
> > > +		resource_size(&mmio_pref));
> > 
> > I think this should be aligned like:
> > 
> >  	extend_bridge_window(bridge, mmio_pref_res, add_list,
> > 			     resource_size(&mmio_pref));
> Me too, I do not know how that one slipped past me.
> 
> > 
> > 
> > >  
> > >  	/*
> > >  	 * Calculate how many hotplug bridges and normal bridges there
> > > @@ -1884,108 +1896,90 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> > >  	 */
> > >  	if (hotplug_bridges + normal_bridges == 1) {
> > >  		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> > > -		if (dev->subordinate) {
> > > +		if (dev->subordinate)
> > >  			pci_bus_distribute_available_resources(dev->subordinate,
> > > -				add_list, available_io, available_mmio,
> > > -				available_mmio_pref);
> > > -		}
> > > +				add_list, io, mmio, mmio_pref);
> > >  		return;
> > >  	}
> > >  
> > > -	if (hotplug_bridges == 0)
> > > -		return;
> > > -
> > >  	/*
> > > -	 * Calculate the total amount of extra resource space we can
> > > -	 * pass to bridges below this one.  This is basically the
> > > -	 * extra space reduced by the minimal required space for the
> > > -	 * non-hotplug bridges.
> > > +	 * Reduce the available resource space by what the
> > > +	 * bridge and devices below it occupy.
> > 
> > This can be widen:
> I avoided changing comments because Bjorn said it creates distracting 
> noise. But I am considering changing tactics because what I have been 
> doing has not been working.

If Bjorn says so then you can just ignore my comment :)
