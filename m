Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC72676F8
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 02:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgILAuQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 20:50:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgILAuP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Sep 2020 20:50:15 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7716720855;
        Sat, 12 Sep 2020 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599871814;
        bh=O2VZLOoQj340HhUYjwVZDYnfelZUt73XfsvHsnDBQYA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JkCUSDCAf3spe8hade0oEzPvbVy3Q91CQc6XGohCBlmUYnjRe1GwNE9EqOGj4OJib
         RRvm4fGd0B/kcghge3qF/pA60CQUfvQImAQj49QAlnFgYxqjpLR1S2FdKDWDqhbzPY
         6S1562t2k/kxxRhJdEhDHD5NM98gKf1Czpf67O8w=
Date:   Fri, 11 Sep 2020 19:50:13 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, sathyanarayanan.kuppuswamy@linux.intel.com,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk
 associated RCiEPs
Message-ID: <20200912005013.GA912147@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44BE3112-64C2-4A64-B9A6-6DD466DC594D@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 11, 2020 at 04:16:03PM -0700, Sean V Kelley wrote:
> On 4 Sep 2020, at 19:23, Bjorn Helgaas wrote:
> > On Fri, Sep 04, 2020 at 10:18:30PM +0000, Kelley, Sean V wrote:
> > > Hi Bjorn,
> > > 
> > > Quick question below...
> > > 
> > > On Wed, 2020-09-02 at 14:55 -0700, Sean V Kelley wrote:
> > > > Hi Bjorn,
> > > > 
> > > > On Wed, 2020-09-02 at 14:00 -0500, Bjorn Helgaas wrote:
> > > > > On Wed, Aug 12, 2020 at 09:46:53AM -0700, Sean V Kelley wrote:
> > > > > > From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > > > 
> > > > > > When an RCEC device signals error(s) to a CPU core, the CPU core
> > > > > > needs to walk all the RCiEPs associated with that RCEC to check
> > > > > > errors. So add the function pcie_walk_rcec() to walk all RCiEPs
> > > > > > associated with the RCEC device.
> > > > > > 
> > > > > > Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > > > > Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
> > > > > > Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> > > > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > >  drivers/pci/pci.h       |  4 +++
> > > > > >  drivers/pci/pcie/rcec.c | 76
> > > > > > +++++++++++++++++++++++++++++++++++++++++
> > > > > >  2 files changed, 80 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > > > index bd25e6047b54..8bd7528d6977 100644
> > > > > > --- a/drivers/pci/pci.h
> > > > > > +++ b/drivers/pci/pci.h
> > > > > > @@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct
> > > > > > pci_dev
> > > > > > *pdev) {}
> > > > > >  #ifdef CONFIG_PCIEPORTBUS
> > > > > >  void pci_rcec_init(struct pci_dev *dev);
> > > > > >  void pci_rcec_exit(struct pci_dev *dev);
> > > > > > +void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct
> > > > > > pci_dev
> > > > > > *, void *),
> > > > > > +		    void *userdata);
> > > > > >  #else
> > > > > >  static inline void pci_rcec_init(struct pci_dev *dev) {}
> > > > > >  static inline void pci_rcec_exit(struct pci_dev *dev) {}
> > > > > > +static inline void pcie_walk_rcec(struct pci_dev *rcec, int
> > > > > > (*cb)(struct pci_dev *, void *),
> > > > > > +				  void *userdata) {}
> > > > > >  #endif
> > > > > > 
> > > > > >  #ifdef CONFIG_PCI_ATS
> > > > > > diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
> > > > > > index 519ae086ff41..405f92fcdf7f 100644
> > > > > > --- a/drivers/pci/pcie/rcec.c
> > > > > > +++ b/drivers/pci/pcie/rcec.c
> > > > > > @@ -17,6 +17,82 @@
> > > > > > 
> > > > > >  #include "../pci.h"
> > > > > > 
> > > > > > +static int pcie_walk_rciep_devfn(struct pci_bus *bus, int
> > > > > > (*cb)(struct pci_dev *, void *),
> > > > > > +				 void *userdata, const unsigned long
> > > > > > bitmap)
> > > > > > +{
> > > > > > +	unsigned int devn, fn;
> > > > > > +	struct pci_dev *dev;
> > > > > > +	int retval;
> > > > > > +
> > > > > > +	for_each_set_bit(devn, &bitmap, 32) {
> > > > > > +		for (fn = 0; fn < 8; fn++) {
> > > > > > +			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
> > > > > 
> > > > > Wow, this is a lot of churning to call pci_get_slot() 256 times per
> > > > > bus for the "associated bus numbers" case where we pass a bitmap of
> > > > > 0xffffffff.  They didn't really make it easy for software when they
> > > > > added the next/last bus number thing.
> > > > > 
> > > > > Just thinking out loud here.  What if we could set dev->rcec during
> > > > > enumeration, and then use that to build pcie_walk_rcec()?
> > > > 
> > > > I think follow what you are doing.
> > > > 
> > > > As we enumerate an RCEC, use the time to discover RCiEPs and
> > > > associate
> > > > each RCiEP's dev->rcec. Although BIOS already set the bitmap for
> > > > this
> > > > specific RCEC, it's more efficient to simply discover the devices
> > > > through the bus walk and verify each one found against the bitmap.
> > > > 
> > > > Further, while we can be certain that an RCiEP found with a matching
> > > > device no. in a bitmap for an associated RCEC is correct, we cannot
> > > > be
> > > > certain that any RCiEP found on another bus range is correct unless
> > > > we
> > > > verify the bus is within that next/last bus range.
> > > > 
> > > > Finally, that's where find_rcec() callback for rcec_assoc_rciep()
> > > > does
> > > > double duty by also checking on the "on-a-separate-bus" case
> > > > captured
> > > > potentially by find_rcec() during an RCiEP's bus walk.
> > > > 
> > > > 
> > > > >   bool rcec_assoc_rciep(rcec, rciep)
> > > > >   {
> > > > >     if (rcec->bus == rciep->bus)
> > > > >       return (rcec->bitmap contains rciep->devfn);
> > > > > 
> > > > >     return (rcec->next/last contains rciep->bus);
> > > > >   }
> > > > > 
> > > > >   link_rcec(dev, data)
> > > > >   {
> > > > >     struct pci_dev *rcec = data;
> > > > > 
> > > > >     if ((dev is RCiEP) && rcec_assoc_rciep(rcec, dev))
> > > > >       dev->rcec = rcec;
> > > > >   }
> > > > > 
> > > > >   find_rcec(dev, data)
> > > > >   {
> > > > >     struct pci_dev *rciep = data;
> > > > > 
> > > > >     if ((dev is RCEC) && rcec_assoc_rciep(dev, rciep))
> > > > >       rciep->rcec = dev;
> > > > >   }
> > > > > 
> > > > >   pci_setup_device
> > > > >     ...
> > > 
> > > I just noticed your use of pci_setup_device(). Are you suggesting
> > > moving the call to pci_rcec_init() out of pci_init_capabilities() and
> > > move it into pci_setup_device()?  If so, would pci_rcec_exit() still
> > > remain in pci_release_capabilities()?
> > > 
> > > I'm just wondering if it could just remain in
> > > pci_init_capabilities().
> > 
> > Yeah, I didn't mean in pci_setup_device() specifically, just somewhere
> > in the callchain of pci_setup_device().  But you're right, it probably
> > would make more sense in pci_init_capabilities(), so I *should* have
> > said pci_scan_single_device() to be a little less specific.
> 
> I’ve done some experimenting with this approach, and I think there may be a
> problem of just walking the busses during enumeration
> pci_init_capabilities(). One problem is where one has an RCEC on a root bus:
> 6a(00.4) and an RCiEP on another root bus: 6b(00.0).  They will never find
> each other in this approach through a normal pci_bus_walk() call using their
> respective root_bus.
> 
> >  +-[0000:6b]-+-00.0
> >  |           +-00.1
> >  |           +-00.2
> >  |           \-00.3
> >  +-[0000:6a]-+-00.0
> >  |           +-00.1
> >  |           +-00.2
> >  |           \-00.4

Wow, is that even allowed?  

There's no bridge from 0000:6a to 0000:6b, so we will not scan 0000:6b
unless we find a host bridge with _CRS where 6b is the first bus
number below the bridge.  I think that means this would have to be
described in ACPI as two separate root bridges:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 6a])
  ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 6b])

I *guess* maybe it's allowed by the PCIe spec to have an RCEC and
associated RCiEPs on separate root buses?  It seems awfully strange
and not in character for PCIe, but I guess I can't point to language
that prohibits it.

> While having a lot of slot calls per bus is unfortunate, unless I’m mistaken
> you would have to walk every peer root_bus with your RCiEP in this example
> until you hit on the right RCEC, unless of course you have a bitmap
> associated RCEC on dev->bus.

I really despise pci_find_bus(), pci_get_slot(), and related
functions, but maybe they can't be avoided.

I briefly hoped we could forget about connecting them at
enumeration-time and just build a list of RCECs in the host bridge.
Then when we handle an event for an RCiEP, we could search the list to
find the right RCEC (and potentially cache it then).  But I don't
think that would work either, because in the example above, they will
be under different host bridges.  I guess we could maybe have a global
(or maybe per-domain) list of RCECs.

> Conversely, if you are enumerating the above RCEC at 6a(00.4) and you
> attempt to link_rcec() through calls to pci_walk_bus(), the walk will still
> be limited to 6a and below; never encountering 6b(00.0).  So you would then
> need an additional walk for each of the associated bus ranges, excluding the
> same bus as the RCEC.
> 
> pci_init_capabilities()
> …
> pci_init_rcec() // Cached
> 
> if (RCEC)
>  Walk the dev->bus for bitmap associated RCiEP
>  Walk all associated bus ranges for RCiEP
> 
> else if (RCiEP)
>  Walk the dev->bus for bitmap associated RCEC
>  Walk all peer root_bus for RCEC, confirm if own dev->bus falls within
> discovered RCEC associated ranges
> 
> The other problem here is temporal. I’m wondering if we may be trying to
> find associated devices at the pci_init_capabilities() stage prior to them
> being fully enumerated, i.e., RCEC has not been cached but we are searching
> with a future associated RCiEP.  So one could encounter a race condition
> where one is checking on an RCiEP whose associated RCEC has not been
> enumerated yet.

Maybe I'm misunderstanding this problem, but I think my idea would
handle this: If we find the RCEC first, we cache its info and do
nothing else.  When we subsequently discover an RCiEP, we walk the
tree, find the RCEC, and connect them.

If we find an RCiEP first, we do nothing.  When we subsequently
discover an RCEC, we walk the tree, find any associated RCiEPs, and
connect them.

The discovery can happen in different orders based on the
bus/device/function numbers, but it's not really a race because
enumeration is single-threaded.  But if we're talking about two
separate host bridges (PNP0A03 devices), we *should* allow them to be
enumerated in parallel, even though we don't do that today.

I think this RCEC association design is really kind of problematic.

We don't really *need* the association until some RCiEP event (PME,
error, etc) occurs, so it's reasonable to defer making the RCEC
connection until then.  But it seems like things should be designed so
we're guaranteed to enumerate the RCEC before the RCiEPs.  Otherwise,
we don't really know when we can enable RCiEP events.  If we discover
an RCiEP first, enable error reporting, and an error occurs before we
find the RCEC, we're in a bit of a pickle.

> So let’s say one throws out RCiEP entirely and just relies upon RCEC to find
> the associations because one knows that an encountered RCEC (in
> pci_init_capabilities()) has already been cached. In that case you end up
> with the original implementation being done with this patch series…
> 
> if (RCEC)
>  Walk the dev->bus for bitmap associated RCiEP
>  Walk all associated bus ranges for RCiEP
> 
> Perhaps I’ve muddled some things here but it doesn’t look like the twain
> will meet unless I cover multiple peer root_bus and even then you may have
> an issue because the devices don’t yet fully exist from the perspective of
> the OS.
> 
> Thanks,
> 
> Sean
