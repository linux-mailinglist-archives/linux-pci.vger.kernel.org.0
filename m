Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 569ACE9C3F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2019 14:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfJ3N1l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Oct 2019 09:27:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:38086 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbfJ3N1l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Oct 2019 09:27:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 06:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; 
   d="scan'208";a="211322476"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 30 Oct 2019 06:27:37 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 30 Oct 2019 15:27:37 +0200
Date:   Wed, 30 Oct 2019 15:27:37 +0200
From:   "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v9 4/4] PCI: Allow extend_bridge_window() to shrink
 resource if necessary
Message-ID: <20191030132737.GF2593@lahna.fi.intel.com>
References: <SL2P216MB018739B339B453DE872DB71E80610@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191030120705.GC2593@lahna.fi.intel.com>
 <SL2P216MB018746C15E0262862D428C1480600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB018746C15E0262862D428C1480600@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 30, 2019 at 01:22:44PM +0000, Nicholas Johnson wrote:
> On Wed, Oct 30, 2019 at 02:07:05PM +0200, mika.westerberg@linux.intel.com wrote:
> > On Tue, Oct 29, 2019 at 03:29:21PM +0000, Nicholas Johnson wrote:
> > > Remove checks for resource size in extend_bridge_window(). This is
> > > necessary to allow the pci_bus_distribute_available_resources() to
> > > function when the kernel parameter pci=hpmemsize=nn[KMG] is used to
> > > allocate resources. Because the kernel parameter sets the size of all
> > > hotplug bridges to be the same, there are problems when nested hotplug
> > > bridges are encountered. Fitting a downstream hotplug bridge with size X
> > > and normal bridges with non-zero size Y into parent hotplug bridge with
> > > size X is impossible, and hence the downstream hotplug bridge needs to
> > > shrink to fit into its parent.
> > > 
> > > Add check for if bridge is extended or shrunken and adjust pci_dbg to
> > > reflect this.
> > > 
> > > Reset the resource if its new size is zero (if we have run out of a
> > > bridge window resource) to prevent the PCI resource assignment code from
> > > attempting to assign a zero-sized resource.
> > > 
> > > Rename extend_bridge_window() to adjust_bridge_window() to reflect the
> > > fact that the window can now shrink.
> > > 
> > > Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > ---
> > >  drivers/pci/setup-bus.c | 23 +++++++++++++++--------
> > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index fe8b2c715..f8cd54584 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -1814,7 +1814,7 @@ void __init pci_assign_unassigned_resources(void)
> > >  	}
> > >  }
> > >  
> > > -static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> > > +static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
> > >  				 struct list_head *add_list,
> > >  				 resource_size_t new_size)
> > >  {
> > > @@ -1823,13 +1823,20 @@ static void extend_bridge_window(struct pci_dev *bridge, struct resource *res,
> > >  	if (res->parent)
> > >  		return;
> > >  
> > > -	if (resource_size(res) >= new_size)
> > > -		return;
> > > +	if (new_size > resource_size(res)) {
> > > +		add_size = new_size - resource_size(res);
> > > +		pci_dbg(bridge, "bridge window %pR extended by %pa\n", res,
> > > +			&add_size);
> > > +	} else if (new_size < resource_size(res)) {
> > > +		add_size = resource_size(res) - new_size;
> > > +		pci_dbg(bridge, "bridge window %pR shrunken by %pa\n", res,
> > > +			&add_size);
> > > +	}
> > 
> > Do we need to care about new_size == resource_size(res)?
> Sorry, I skipped over this before re-posting. If we are not changing the 
> size, does it need to be logged in pci_dbg? I could change it to ">=", 
> meaning if the size does not change then it will be "extended" by 0 in 
> pci_dbg.
> 
> Let me know if you wish for this to happen. But I am easy either way.

No need.

> If you are fine with how it is, PATCH v10 should have addressed 
> everything so far.

Yes, v10 looks fine by me.
