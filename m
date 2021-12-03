Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68B146776B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 13:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352196AbhLCMdD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 07:33:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54968 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbhLCMdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 07:33:02 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638534577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tH/VGVdJtYJdCNVnG83SXJ3AsmMc03qyODmOpVdcDS4=;
        b=xYaZvCwZtS2vFnzsBQ5VOMoblYtNt1vCBLPPUiI2MovBDFcrX+W1xQv0kH1WT+jl1WTouw
        mu3+/VDOxmaph/y5tWFFqXIgrnZo88AD7a1E4qKMJky69BH8z/vBeyK2bbh/I9zR8aT8ZS
        KxLlZM8lHFGzC4jk8O9OTVNdg44S5aWhCorI5DyXjQD4tVUfql5eazYnN1AStOT+Plv06O
        5vX/4ecr6lzNs6ghewDypetz2AKIrb7U4Wbxhd9bRJfSkzX8H5V0AtWXLjtIgCnq14GjqL
        x6InjLrMmNKU744M8beo+YWvGUln//9f6pQNS6s2CN79Fd9IRYiuJShql28/Sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638534577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tH/VGVdJtYJdCNVnG83SXJ3AsmMc03qyODmOpVdcDS4=;
        b=0z+2aAy/+cRUeKX5JZDeihNkPRrp7mPzxSVuDk8R5JoI9jEZyK7Wuw6Gjx+OnrL+FBFuo+
        0u6UWtOnP/kp4/Bg==
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
In-Reply-To: <20211203004545.GF364748@otc-nc-03>
References: <20211126233124.618283684@linutronix.de>
 <20211127000919.004572849@linutronix.de>
 <7ad200fa-dda3-4932-cd23-ad6e79288ea4@intel.com> <871r2v71mg.ffs@tglx>
 <20211202192139.GE364748@otc-nc-03> <87r1au68rb.ffs@tglx>
 <20211203004545.GF364748@otc-nc-03>
Date:   Fri, 03 Dec 2021 13:29:37 +0100
Message-ID: <87a6hh6fda.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ashok,

On Thu, Dec 02 2021 at 16:45, Ashok Raj wrote:
> On Thu, Dec 02, 2021 at 09:40:08PM +0100, Thomas Gleixner wrote:
> Not worried about MSI-x for IDXD :), I assumed the purpose of this exercise
> was about 2 things.
>
> - Fix the VFIO mask/unmask weirdness ending up disable, reenable with more
>   interrupts. 
>   - We are only fixing the case by not calling the disable_msi, but just
>     growing on demand.
>
> - Use this as a case to build IMS. but if we treat MSIx and IMS
>   differently, IMS would be bit different in how the dynamic parts
>   work.

Conceptually they are not different, really. You are mixing concepts
and implementation details.

> Although there is no real need for MSIx being dynamic except to avoid host
> vector exhausion, do you think we could still allocate specific entries.
> Since unmask is per-vector, is there benefit to doing just that vs
> allocating current+N?

This is either a rethoric question or a trick question, right?

>> VFIO exactly knows which entry is unmasked simply because the write into
>> the MSI-X table in the device config space is trapped so it knows
>> exactly which entry is unmasked, no? Guess how VFIO knows about $N more?
>
> bah.. i missed that little fact.
>
> When VFIO knows exactly which entry is being unmasked, is it enough to just
> allocate exact one, or do we need to all all N? I didn't see why we need to
> grown by N additional vectors instead of only allocating 1 for the entry
> being unmasked?

That's exactly the point. The current implementation does so, because
the PCI/MSI infrastructure does not provide a mechanism to allocate a
particular vector post init.
 
>> > Maybe for MSIx we don't have a need to shrink based on current usage. IMS
>> > requires both grow and shrink. But it might be odd to have 2 domains behave
>> > quite differently.
>> 
>> We are not implementing the full MSI[X] zoo for IMS either. So the
>> interfaces are different in the first place.
>
> The ones that actually differ between the MSIx and IMS are:
>
> - Discovery on where to find that unlike the PCIe standard mechanism.
>   (Although in initial implementation we have forced a common way to manage
>   this, but I think people already hinted this isn't going to work
>   for different vendors or even between gen1/gen2 devices.
> - Managing the location of the add/data write, mask/unmask etc.
> - Might have other attributes such as PASID etc for the IDXD case exposed
>   to guest/user space.

You are looking at this from the wrong direction, i.e. top down. Why?

Because if you look at it from bottom up, then you'll see the following:

  The base of all this is a function block which translates a write of
  message data to the message address into an interrupt raised in a
  CPU.

  The interrupt remap unit is just another translator which converts the
  write to the remap table into a write to the CPU function block, if
  the encoded protections are valid.

From a device perspective the message address and the message data are
completely opaque and all the device knows about them is that it has to
write message.data to message.address in order to raise an interrupt in
some CPU.

Of course the device needs to have some sort of storage where the OS can
save the composed message data and the message address so that the
device itself can access it when it wants to raise an interrupt.

IOW. The message storage is device specific.

For IO/APIC the message is saved in the per pin routing entry.

HPET has it's own routing entry

PCI/MSI provides standartised storage for the messages.

IMS allows the device to define where the message is stored. That's a
fundametally new concept, right?

No. It is not. All of the above are already IMS implementations. And
each implementation has their own quirks and oddities which is why
we end up with different irqdomains and irqchips.

If you look at other architectures there are various other flavours of
devices which have their own device specific message store, IOW they
all are device specific IMS flavours.

They all have two things in common:

  - They provide storage for messages
  - To raise an interruupt they write message.data to message.address

So IMS is conceptually nothing new. It's just a marketing brandname for
something which exists since the invention of message based interrupt
for obvious reasons.

What's different for all of the above variants is the way how it is
exposed to the devices. Wired interrupts which end up at the IO/APIC pin
obviously cannot expose the underlying message mechanism because the
device cannot make use of it. And a device cannot allocate a pin either
because it obviously cannot rewire the PCB.

For PCI/MSI we have an PCI/MSI sepcific interface which is aware of the
PCI/MSI way to store the messages and to deal with the quirks and
limitations of PCI/MSI.

For IMS we surely will model an interface which handles all IMS variants
in a uniform way too, but that interface will be different from PCI/MSI
because it does not need any of the PCI/MSI quirks at all.

That interface will more look like the underlying msi irqdomain
interface simply because pretending it is PCI specific is an artificial
exercise.

There is nothing PCI specific about it. The only connection which needs
to be made is through msi_desc::dev and perhaps some meta info so that
the IOMMU can figure out from which PCI device this message will
originate..

Adding a pci_foo() wrapper around it which reliefs the programmer from
writing &pdev->dev and filling in some meta info is just an obvious
conveniance add on.

See?

That interface is really the least of all problems.

We need to settle the other way more important qeustion how to
store/manage MSI descriptors and how to handle the per device IMS
irqdomain first.

You can handwave about the interface as long as you want. It won't
materialize before the underlying infrastructure is not sorted out.

Once that is done then the interface is mostly defined by that
infrastructure and writing it up is not going to be rocket science.

See?

Thanks,

        tglx
