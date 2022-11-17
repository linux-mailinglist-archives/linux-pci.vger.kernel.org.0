Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A362D738
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 10:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiKQJkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 04:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKQJkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 04:40:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7D12094;
        Thu, 17 Nov 2022 01:40:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668678050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srRkLobqpuFfqNIkuJnuNikEDzS6LKYgCzBeR1oCNb4=;
        b=FLTx3jyH98jOxBWi2uMAEPiq+20/WdYRwXGGnVpvKdX6hmLRG9AKEdEK3n19G60maLuQ6g
        iLXF4gp4qZ/A5jUrsnW/NoQlI255eU6Za+HCne3dPADt3HTE890E05SKICqvlrnOZsjX3C
        jGYf3AO0XrDhtPsWVp2rzr2Tg/djd7sh5olwgGk15TihnOuES70VUn8biEapolUy7TrUx8
        wWgrfyMXIC+OdFzX/0mtv4FUtnsPevyy4+78I9v934LmugVm01z22nvHjYS8tbSB34jgyI
        whog82ft88dOxxn7GO523ReLDLpb0LgQ2ZCtUCApJQjXst2Fc+CeHEs36FUf2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668678050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srRkLobqpuFfqNIkuJnuNikEDzS6LKYgCzBeR1oCNb4=;
        b=M/Cakt3o7ng29W6kn6z8cLZbtT8EB4a/x1vceKV/qBtCf/TBCg9QJNGumEiQeIXau/DIpu
        ytKxgxy94sCshWDQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 21/33] genirq/msi: Provide msi_domain_alloc_irq_at()
In-Reply-To: <Y3U7oeW7jfEDv0Qu@nvidia.com>
References: <20221111133158.196269823@linutronix.de>
 <20221111135206.463650635@linutronix.de> <Y3U7oeW7jfEDv0Qu@nvidia.com>
Date:   Thu, 17 Nov 2022 10:40:50 +0100
Message-ID: <87r0y1nckd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16 2022 at 15:36, Jason Gunthorpe wrote:
> On Fri, Nov 11, 2022 at 02:58:44PM +0100, Thomas Gleixner wrote:
>> The function also takes an optional @cookie argument which is of type union
>> msi_dev_cookie. This cookie is not used by the core code and is stored in
>> the allocated msi_desc::data::cookie. The meaning of the cookie is
>> completely implementation defined. In case of IMS this might be a PASID or
>> a pointer to a device queue, but for the MSI core it's opaque and not used
>> in any way.
>
> To my mind it makes more sense to pass a 'void *' through from
> msi_domain_alloc_irq_at() to the prepare_desc() op with the idea that
> the driver calling msi_domain_alloc_irq_at() knows it is calling it
> against the domain that it allocated. The prepare_desc can then use
> the void * to properly initialize anything about the desc under the
> right lock.

You are looking at it from one particular use case. 

> Before calling this the driver should have setup whatever thing is
> going to originate the interrupt, eg allocated the HW object that
> sources the interrupt and part of what the void * would convey is the
> detailed information on how to program the HW object. eg IDXD is using
> an iobase and an offset along with the enforcing PASID, but something
> like mlx5 would probably want an object id, type, and SF ID.

Correct, and that's why the cookie is there. You can stash your pointer
into the cookie and an IDXD user stores the PASID. The IDXD user which
allocates an interrupt does not even know about iobase and offset. It
does neither care about what the IDXD irq domain implementation does
with that cookie.

Neither should your queue code care. The queue driver code puts a
pointer to struct mlx5_voodoo into the cookie when allocating the
interrupt and then the mlx5 irqdomain code which is a complete separate
entity gets this cookie handed into prepare_desc().

struct mlx5_voodoo contains all information for the irq domain code to
set up the necessary things in the queue. That must be obviously a
contract between the queue code and the irqdomain code but that's not
any different than MSI or MSI-X. The only difference is that in the IMS
case the contract is per device and not codified in a standard.

> This is again where I don't much like the use of an ID to refer to the
> domain.
>
> Having the driver allocate the device domain, retain a pointer to it,
> and use that domain pointer with all these new APIs seems much clearer
> than converting the pointer to an ID.

You're really obsessed about this irqdomain pointer, right?

You have to differentiate between the irq domain implementation and the
actual usage sites and not conflate them into one thing.

Let's look at the usage site:

      struct cookie cookie = { .ptr = mymagicqueue, }

      pci_ims_alloc_irq(pci_dev, &cookie);

versus:

      struct cookie cookie = { .ptr = mymagicqueue, }

      ims_alloc_irq(&pci_dev->dev, mydev->ims_domain, &cookie);

Even in the unlikely case that we have more than two domains, then still
the usage site has zero interest in the domain pointer:

      struct cookie cookie = { .ptr = mymagicqueue, }

      pci_ims_alloc_irq(pci_dev, myqueue->domid, &cookie);

where the code which instantiates myqueue sets up domid.

The usage site has absolutely no business to touch irqdomain pointer or
to even know that one exists. All it needs to know is how the cookie
contract works, obviously.

Now the functions you need in your irqdomain implementation to
e.g. prepare the MSI descriptor surely need to know about the irqdomain
pointer, but that gets handed in from the allocation code so the prepare
function knows which instance it is operating on.

So what does the irqdomain pointer buy you? Exactly nothing!

Look at the IDXD reference implementation.

     The IDXD probe code which initializes the physical device
     instantiates the irq domain along with the iobase for the
     storage array.

     The actual queue (or whatever IDXD names it) setup code just sticks
     PASID into the cookie and allocates an interrupt. It gets a virtual
     irq number and requests the interrupt.

Where is the need for a pointer? The queue code does not even know about
the iobase of the storage array. It's completely irrelevant there. All
it has to know is the cookie contract, not more.

Let's take you pointer obsession to the extreme:

      struct irq_desc *desc = pci_alloc_msix_interrupt(pci_dev);

      request_irq(desc, handler, pci_dev);

versus:

      int virq = pci_alloc_msix_interrupt(pci_dev);

      request_irq(virq, handler, pci_dev);

You could argue the same way that there is no need for a Linux interrupt
number and we could just use the interrupt descriptor pointer.

Sure, you can do that, but then you violate _all_ encapsulation rules in
one go for absolutely _ZERO_ value.

Want another example based on kmalloc()?

Almost 20 years ago I did a treewide mopup of drivers which decided that
they need to fiddle in the irq descriptor for the very wrong reasons.
I had to do that to be able to do a trivial change in the core code...

C is patently bad for encapsulation, but you can make it worse by
forcefully ignoring the design patterns which allow to completely hide
implementation details of a subsystem or infrastructure.

If you look at the last commit in the ARM part of this work:

  https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?h=devmsi-arm&id=96c97746cbb431a306e95c04d6b3c75751244716

then you can see the final move to remove the visibility of
the MSI management internals.

This makes it possible to completely overhaul the inner workings of the
MSI core without having to chase abuse all over the place.

Thanks,

        tglx





   







        
