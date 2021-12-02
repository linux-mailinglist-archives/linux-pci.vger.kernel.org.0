Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67C466AFC
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 21:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348918AbhLBUnj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 15:43:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348828AbhLBUnd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 15:43:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638477609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55ngEOg/vl85x4iqjs7xFGP7JVdJD8eA7lFIRRDhniM=;
        b=VaCFhl2F3RpnndXOk0eJfp+MZfNLGIhC7Xfr1C7roo+cjM22fAvOsAl/A7cAWmCtLymHjc
        50oJP/iIdrv76mJN7IlbdBUnQILQHEsI5wbW14XFFreH1tubQHAMoTLBITYBnHQesOWFtu
        QOb2vt/UiTD+Kk2KSOfI1hIews75sAmq3DNgcd0MCb37ECsh8KRN62cCHOUUrmBQdsSRJP
        9M6W/eqPQeqiyMYubKpNxx/+M8rc722I5/LdtlYs1M/goMGZpsYGC0HfA0BzjM/eGc9oOA
        u3GF1U4PdSzz7YKu6nhHhA/QLBdfDpWwfNEiSzYYNjAaSXXGwTx9gU2roATg2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638477609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55ngEOg/vl85x4iqjs7xFGP7JVdJD8eA7lFIRRDhniM=;
        b=giWY26evQ6Gj3SdmIKnHGHwKedfVnbxBq1EnNDwhpVHvOUA3RWS/r8MBniS7ea4c6DREvi
        z3y0Ip64M87e4xCw==
To:     "Raj, Ashok" <ashok.raj@intel.com>
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
In-Reply-To: <20211202192139.GE364748@otc-nc-03>
References: <20211126233124.618283684@linutronix.de>
 <20211127000919.004572849@linutronix.de>
 <7ad200fa-dda3-4932-cd23-ad6e79288ea4@intel.com> <871r2v71mg.ffs@tglx>
 <20211202192139.GE364748@otc-nc-03>
Date:   Thu, 02 Dec 2021 21:40:08 +0100
Message-ID: <87r1au68rb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

On Thu, Dec 02 2021 at 11:21, Ashok Raj wrote:
> On Thu, Dec 02, 2021 at 11:16:39AM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 01 2021 at 17:08, Megha Dey wrote:
>> You're missing the real world use case. The above is fiction.
>
> I don't think there is a valid use case for freeing specific vectors. Its
> true some are special, IDXD has vector#0 like that. But I expect drivers to
> acquire these special vectors  once and never free them until driver 
> tear down time.
>
> But there is a need to free on demand, for a subdevice constructed for idxd
> pass-through, when the guest is torn down, host would need to free them.
> Only growing on demand seems to only catch one part of the dynamic part.
>
> IDXD also allocates interrupt only when the WQ is enabled, and frees when its
> disabled.

You're talking about IMS not MSI-X here, right? IMS cannot be allocated
via the PCI/MSI interfaces as we established long ago.

And if you are talking about the 8 MSI-X interrupts for IDXD then I
really do not see the point of ever releasing it.

>> If a driver would release 1 and 2 then it should explicitely reallocate
>> 1 and 2 and not let the core decide to magically allocate something.
>> 
>> If the driver wants three more after freeing 1, 2 then the core could
>> just allocate 5, 6, 7, and would still fulfil the callers request to
>> allocate three more, right?
>
> Since the core is already managing what's allocated and free, requiring
> drivers to manage each allocated entries seem hard, while the core can
> easily manage it. For IDXD cases, we don't really care which ones of the
> IMS is being allocated and freed. It just wants one of the available IMS
> entries. The assumption is since the driver would have acquired any special
> ones upfront with the alloc_irqs().

For MSI-X the free vector use case does not exist today and even if it
would exist the driver has to know about the index.

If the index -> function accociation is hard wired, it needs to know it
obviously.

If it's not hardwired then it still needs to know the resulting index,
because it has to program that index into a device function register so
that the device knows which entry to use.

IMS is not any different. You need to know the index in order to
associate it to the queue, no? And you need the index in order to figure
out the Linux irq number.

But again, that's not a problem of this very API because this API is
about PCI/MSI and not about IMS.

>> And even if it just allocates one, then the caller still has to know the
>> index upfront. Why? Because it needs to know it in order to get the
>> Linux interrupt number via pci_irq_vector().
>
> If we were to allocate one, the new API can simply return the index
> directly to the caller, and they call pci_irq_vector() to get the IRQ
> number.

That can work, but then we need both variants:

     pci_msix_alloc_vector_at() and pci_msix_alloc_vector_any()

Why?

Because pci_msix_alloc_vector_any() cannot solve the VFIO on demand
allocation problem and it cannot be used to replace the sparse
allocations which are done via pci_enable_msix_exact() today.

If there is an MSI-X use case to allocate any vector then we can
implement that. If there is none, then we don't need it, right?

>> So if the driver would free the vector for a particular functionality,
>> or not allocate it in the first place, then it exactly knows what it
>> freed and what it needs to allocate when it needs that functionality
>> (again).
>
> It doesn't *have* to be that all vectors are special. Some of them are
> special that they acquired all during driver load time. These are allocated
> once and never freed. The rest are for say completion interrupts or such and 
> such that go with work queues. These can dynamically be allocated and
> freed.
>
> The driver doesn't really care which index it wants or what the next index
> should be. But it has to remember the allocated ones so it can pass down
> for the free. Maybe the one we did a while back
>
> https://lore.kernel.org/lkml/1561162778-12669-1-git-send-email-megha.dey@linux.intel.com/
>
> This has a group handle, and kept adding things to it.

Was it really necessary to bring those memories back?

If we want groups, then surely not with these kind of hacks. I still
need to see the usecase for the groups. The discussion back then just
provided handwaving about internal request which never materialized.

But talking about groups. That's very similar to the other discussion
vs. storing the IMS entries for these sliced devices, queues or
whatever. That's at least a use case.

>> What you are trying to create is a solution in search of a problem. You
>> cannot declare via a random allocation API how devices work. You neither
>> can fix the VFIO issue in a sensible way.
>> 
>> VFIO starts with vector #0 allocated. The guest then unmasks vector #50.
>> 
>> With your magic interface VFIO has to allocate 49 vectors and then free
>> 48 of them again or just keep 48 around for nothing which defeats the
>> purpose of on demand allocation completely.
>
> This use case is broken already, the VFIO case sort of assumes things are
> growing in sequence. Today it doesn't have a hint on which entry is being
> unmasked I suppose. So VFIO simply releases everything, adds N more than
> currently allocated.

VFIO exactly knows which entry is unmasked simply because the write into
the MSI-X table in the device config space is trapped so it knows
exactly which entry is unmasked, no? Guess how VFIO knows about $N more?

> Maybe for MSIx we don't have a need to shrink based on current usage. IMS
> requires both grow and shrink. But it might be odd to have 2 domains behave
> quite differently.

We are not implementing the full MSI[X] zoo for IMS either. So the
interfaces are different in the first place.

Making them artificially uniform is a horrible idea.

They are two different things, really. The only thing they have in common
is that at the end of the day the device sends a message over the bus
and they happen to share the underlying MSI code infrastructure.

Thanks,

        tglx
