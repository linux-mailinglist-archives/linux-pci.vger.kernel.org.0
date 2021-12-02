Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74A1466A70
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 20:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376825AbhLBT3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 14:29:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:36394 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376857AbhLBT3c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Dec 2021 14:29:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236724569"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236724569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 11:25:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="512998017"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.123])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 11:25:56 -0800
Date:   Thu, 2 Dec 2021 11:21:39 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Dey, Megha" <megha.dey@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 09/10] PCI/MSI: Provide pci_msix_expand_vectors[_at]()
Message-ID: <20211202192139.GE364748@otc-nc-03>
References: <20211126233124.618283684@linutronix.de>
 <20211127000919.004572849@linutronix.de>
 <7ad200fa-dda3-4932-cd23-ad6e79288ea4@intel.com>
 <871r2v71mg.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871r2v71mg.ffs@tglx>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Thu, Dec 02, 2021 at 11:16:39AM +0100, Thomas Gleixner wrote:
> Megha,
> 
> On Wed, Dec 01 2021 at 17:08, Megha Dey wrote:
> > On 11/26/2021 5:25 PM, Thomas Gleixner wrote:
> >>   /**
> >> + * pci_msix_expand_vectors_at - Expand MSI-X interrupts for a device
> >> + *
> >> + * @dev:	PCI device to operate on
> >> + * @at:		Allocate at MSI-X index. If @at == PCI_MSI_EXPAND_AUTO
> >> + *		the function expands automatically after the last
> > Not sure why some of these changes related to PCI_MSIX_EXPAND_AUTO and 
> > num_descs did not make it to the 'msi' branch.
> > Is this intentional?
> 
> Yes, because I'm not happy about that magic.
> 
> >
> > For instance, say:
> > 1. Driver requests for 5 vectors:
> > pci_enable_msix_range(dev, NULL, 5, 5)
> > =>num_descs = 5
> 
> Driver should not use with pci_enable_msix_range() in the first
> place. But yes, it got 5 vectors now.

Bad start with a deprecated interface :-). 

> 
> > 2. Driver frees vectors at index 1,2:
> > range = {1, 2, 2};
> > pci_msi_teardown_msi_irqs(dev, range)
> 
> That function is not accessible by drivers for a reason.
> 
> > =>num_descs = 3; Current active vectors are at index: 0, 3, 4
> 
> > 3. Driver requests for 3 more vectors using the new API:
> > pci_msix_expand_vectors(dev, 3)
> > =>range.first = 3 => It will try to allocate index 3-5, but we already 
> > have 3,4 active?
> > Ideally, we would want index 1,2 and 5 to be allocated for this request 
> > right?
> >
> > Could you please let me know what I am missing?
> 
> You're missing the real world use case. The above is fiction.

I don't think there is a valid use case for freeing specific vectors. Its
true some are special, IDXD has vector#0 like that. But I expect drivers to
acquire these special vectors  once and never free them until driver 
tear down time.

But there is a need to free on demand, for a subdevice constructed for idxd
pass-through, when the guest is torn down, host would need to free them.
Only growing on demand seems to only catch one part of the dynamic part.

IDXD also allocates interrupt only when the WQ is enabled, and frees when its
disabled. 

> 
> If a driver would release 1 and 2 then it should explicitely reallocate
> 1 and 2 and not let the core decide to magically allocate something.
> 
> If the driver wants three more after freeing 1, 2 then the core could
> just allocate 5, 6, 7, and would still fulfil the callers request to
> allocate three more, right?

Since the core is already managing what's allocated and free, requiring
drivers to manage each allocated entries seem hard, while the core can
easily manage it. For IDXD cases, we don't really care which ones of the
IMS is being allocated and freed. It just wants one of the available IMS
entries. The assumption is since the driver would have acquired any special
ones upfront with the alloc_irqs().


> 
> And even if it just allocates one, then the caller still has to know the
> index upfront. Why? Because it needs to know it in order to get the
> Linux interrupt number via pci_irq_vector().

If we were to allocate one, the new API can simply return the index
directly to the caller, and they call pci_irq_vector() to get the IRQ
number.

> 
> > Correspondingly, pci_free_msix_irq_vector(pdev, irq) frees all the 
> > allocated resources associated with MSI-X interrupt with Linux IRQ 
> > number 'irq'.
> > I had issues when trying to dynamically allocate more than 1 interrupt 
> > because I didn't have a clean way to communicate to the driver what 
> > indexes were assigned in the current allocation.
> 
> If the driver is able to free a particular vector then it should exactly
> know what it it doing and which index it is freeing. If it needs that
> particular vector again, then it knows the index, right?
> 
> Let's look how MSI-X works in reality:
> 
> Each vector is associated to a particular function in the device. How
> that association works is device dependent.
> 
> Some devices have hardwired associations, some allow the driver to
> program the association in the device configuration and there is also a
> combination of both.
> 
> So if the driver would free the vector for a particular functionality,
> or not allocate it in the first place, then it exactly knows what it
> freed and what it needs to allocate when it needs that functionality
> (again).

It doesn't *have* to be that all vectors are special. Some of them are
special that they acquired all during driver load time. These are allocated
once and never freed. The rest are for say completion interrupts or such and 
such that go with work queues. These can dynamically be allocated and
freed.

The driver doesn't really care which index it wants or what the next index
should be. But it has to remember the allocated ones so it can pass down
for the free. Maybe the one we did a while back

https://lore.kernel.org/lkml/1561162778-12669-1-git-send-email-megha.dey@linux.intel.com/

This has a group handle, and kept adding things to it.

> 
> What you are trying to create is a solution in search of a problem. You
> cannot declare via a random allocation API how devices work. You neither
> can fix the VFIO issue in a sensible way.
> 
> VFIO starts with vector #0 allocated. The guest then unmasks vector #50.
> 
> With your magic interface VFIO has to allocate 49 vectors and then free
> 48 of them again or just keep 48 around for nothing which defeats the
> purpose of on demand allocation completely.

This use case is broken already, the VFIO case sort of assumes things are
growing in sequence. Today it doesn't have a hint on which entry is being
unmasked I suppose. So VFIO simply releases everything, adds N more than
currently allocated. 

If there is a real world need for allocating a
specific vector#50, maybe we should add a alloc_exact() type and core can
check if #50 is still available.

Maybe for MSIx we don't have a need to shrink based on current usage. IMS
requires both grow and shrink. But it might be odd to have 2 domains behave
quite differently.

Cheers,
Ashok
