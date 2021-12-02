Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F754466A6D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 20:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbhLBT3S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 14:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242544AbhLBT3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 14:29:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD25C06174A;
        Thu,  2 Dec 2021 11:25:51 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638473149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5JC94/bxRUGMf16ncXWFKhzZooMe43rIMR+1/Fi9So=;
        b=fG3XLXokk4EiVRqjPizrO8lFfP2w7WCxG+ier7EaBefbOCerITwRd8beUsfryvuMkoKRjW
        f7iKQ5kPUDj+BeKgi38hRD9pkTydvYxfkizhBLs+6SLLaoWh8KSLkwp5K6zIKHvVFxSUyy
        jADb9a0QeJgWOyvOkDrJri+GZUlWYyQ9a7aOI/RUJQeL9dhGcQ+hnu/ILU1F7RzXEE9pLa
        KXeniZ8NqB4FePHiZlWctf7PwUF26dotgzdFq0mw0rM73oTlMvCpJXELfZgqosE5HxtiGI
        wNu9byDh6NrBGMoA/WH3h284stt9u06seVx4TNJDEvF1PEVWiXhsAiu3TcEpGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638473149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v5JC94/bxRUGMf16ncXWFKhzZooMe43rIMR+1/Fi9So=;
        b=bNFRKuKGN5/g9I6J+fJ2JPEcaxBRoD0Sw7ZLl132bhPYExvXf7qq0o7S00jISEsEmH1iz4
        pxZQlizmeUDE1aBQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211202135502.GP4670@nvidia.com>
References: <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com>
Date:   Thu, 02 Dec 2021 20:25:48 +0100
Message-ID: <87wnkm6c77.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Thu, Dec 02 2021 at 09:55, Jason Gunthorpe wrote:
> On Thu, Dec 02, 2021 at 01:01:42AM +0100, Thomas Gleixner wrote:
>> On Wed, Dec 01 2021 at 21:21, Thomas Gleixner wrote:
>> > On Wed, Dec 01 2021 at 14:14, Jason Gunthorpe wrote:
>> > Which in turn is consistent all over the place and does not require any
>> > special case for anything. Neither for interrupts nor for anything else.
>> 
>> that said, feel free to tell me that I'm getting it all wrong.
>> 
>> The reason I'm harping on this is that we are creating ABIs on several
>> ends and we all know that getting that wrong is a major pain.
>
> I don't really like coupling the method to fetch IRQs with needing
> special struct devices. Struct devices have a sysfs presence and it is
> not always appropriate to create sysfs stuff just to allocate some
> IRQs.
>
> A queue is simply not a device, it doesn't make any sense. A queue is
> more like a socket().

Let's put the term 'device' for a bit please. 

> That said, we often have enough struct devices floating about to make
> this work. Between netdev/ib_device/aux device/mdev we can use them to
> do this.
>
> I think it is conceptual nonsense to attach an IMS IRQ domain to a
> netdev or a cdev, but it will solve this problem.

The IMS irqdomain is _NOT_ part of the netdev or cdev or whatever. I
explained that several times now.

We seem to have a serious problem of terminology and the understanding
of topology which is why we continue to talk past each other forever.

Let's take a big step back and clarify these things first.

An irq domain is an entity which has two parts:

   1) The resource management part
   
   2) An irqchip which knows how to access the actual hardware
      implementation for the various operations related to irq chips
      (mask, unmask, ack, eoi, ....)

irq domains are used for uniform resource spaces which have a uniform
hardware interrupt chip. Modern computer systems have several resource
levels which form a hierarchy of several irqdomain levels.

The root of that hierarchy is at the CPU level:

 |---------------|
 | CPU     | BUS |
 |         |-----|        
 |         | IRQ |
 |----------------

The CPU exposes the bus and a mechanism to raise interrupts in the CPU
from external components. Whether those interrupts are raised by wire or
by writing a message to a given address is an implementation detail.

So the root IRQ domain is the one which handles the CPU level interrupt
controller and manages the associated resources: The per CPU vector
space on x86, the global vector space on ARM64.

If there's an IOMMU in the system them the IOMMU is the next level
interrupt controller:

    1) It manages the translation table resources

    2) Provides an interrupt chip which knows how to access the
       table entries

Of course there can be several IOMMUs depending on the system topology,
but from an irq domain view they are at the same level.

On top of that we have on x86 the next level irq domains:

   IO/APIC, HPET and PCI/MSI

which again do resource management and provide an irqchip which
handles the underlying hardware implementation.

So the full hierarchy so far looks like this on X86

   VECTOR --|
            |-- IOMMU --|
                        |-- IO/APIC
                        |-- HPET
                        |-- PCI/MSI

So allocating an interrupt on the outer level which is exposed to
devices requires allocation through the hierarchy down to the root
domain (VECTOR). The reason why we have this hierarchy is that this
makes it trivial to support systems with and without IOMMU because on a
system w/o IOMMU the outer domains have the vector domain as their
parent. ARM(64) has even deeper hierarchies, but operates on the same
principle.

Let's look at the PCI/MSI domain more detailed:

  It's either one irqdomain per system or one irqdomain per IOMMU domain

  The PCI/MCI irqdomain does not really do resource allocations, it's
  all delegated down the hierarchy.

  It provides also an interrupt chip which knows to access the MSI[X]
  entries and can handle masking etc.

Now you might ask how the MSI descriptors come into play. The MSI
descriptors are allocated by the PCI/MSI interface functions in order to
enable the PCI/MSI irqdomain to actually allocate resources.

They could be allocated as part of the irqdomain allocation mechanism
itself. That's what I do now for simple irq domains which only have a
linear MSI descriptor space where the only information in the descriptor
is the index and not all the PCI/MSI tidbits.

It's kinda blury, but that's moslty due to the fact that we still have
to support the legacy PCI/MSI implementations on architectures which do
not use hierarchical irq domains.

The MSI descriptors are stored in device->msi.data.store. That makes
sense because they are allocated on behalf of that device. But there is
no requirement to store them there. We could just store a cookie in the
device and have some central storage. It's an implementation detail,
which I kept that way so far.

But note, these MSI descriptors are not part of the PCI/MSI
irqdomain. They are just resources which the irqdomain hands out to the
device on allocation and collects on free.

From a topology view the location of the PCI/MSI domain is at the PCI
level which is correct because if you look at a PCIe card then it
consists of two parts:

    |----------------|----------------------------
    | PCIe interface |                           |
    |----------------| Physical function         |
    | Config space   |                           |
    |----------------|----------------------------
    |            Bus bridge                      |
    |---------------------------------------------

The PCIe interface is _not_ managed by the device driver. It's managed
by the PCI layer including the content of the MSI-X table.

The physical function or some interrupt translation unit reads these
entries to actually raise an interrupt down through

        PCIe -> IOMMU -> CPU

by writing the message data to the message address.

If you look at the above irqdomain hierarchy then you'll notice that the
irqdomain hierarchy is modeled exactly that way.

Now ideally with we should do the same modeling for IMS:

    CPU -> IOMMU -> IMS

and have that global or per IOMMU domain. But we can't do that because
IMS is not uniform in terms of the interrupt chip.

IDXD has this table in device memory and you want to store the message
in system memory and the next fancy card will do something else.

Megha tried to do that via this platform MSI indirection, but that's
just a nasty hack. The platform MSI domain is already questionable, but
bolting IMS support into it would make it a total trainwreck.

Aside of that this would not solve the allocation problem for devices
which have a IMS table in device memory because then every device driver
would have to have it's own table allocation mechanism.

Creating a IMS-IDXD irq domain per IOMMU domain would be a possible
solution, but then dealing with different incarnations of table
layouts will create a zoo of crap. Also it would not solve the problem
of IMS storage in system memory.

That's why I suggested to create a device specific IMS irq domain with a
device specific irqchip. The implementation can be purely per device or
a shared implementation in drivers/irqchip. Which is preferrable because
otherwise we won't ever get code reused even if the device memory table
or the system memory storage mechanism are the same.

So the device driver for the PCIe device has to do:

   probe()
   ...
     mydev->ims_domain = ims_$type_create_msi_domain(....)

Now allocations from that domain for usage by the device driver do:

     ret = msi_domain_alloc_irqs(mydev->ims_domain, ...);

Now that's where the problem starts:

  The allocation creates MSI descriptors and has to store them
  somewhere.

Of course we can store them in pci_dev.dev.msi.data.store. Either with a
dedicated xarray or by partitioning the xarray space. Both have their
pro and cons.

Ok?

But what I really struggle with is how this is further represented when
the queues are allocated for VFIO, cdev, whatever usage.

The point is that what you call a queue is not a single resource entity,
it's a container for which several resource types are required to become
functional:

   1) The device queue
   2) Interrupts
   3) ....

Of those resources only one, the device queue, is managed by the
device driver.

The fact that the irqdomain is instantiated by the device driver does
not make it any different. As explained above it's just an
implementation detail which makes it possible to handle the device
specific message storage requirement in a sane way. The actual interrupt
resources come still from the underlying irqdomains as for PCI/MSI.

Now I was looking for a generic representation of such a container and
my initial reaction was to bind it to a struct device, which also makes
it trivial to store these MSI descriptors in that struct device.

I can understand your resistance against that to some extent, but I
think we really have to come up with a proper abstract representation
for these.

Why?

Simply because I want to avoid yet another non-uniform representation of
these things which are making it hard to expose them in a topology view
and require non-uniform wrappers for the same type of information all
over the place.

We seriously have enough of this adhoc stuff already and there is no
need to open another can of worms.

After thinking more about this, I came up to name it: Logical function.

See, I was carefully avoiding the term 'device' and even more so did not
fall for the Software-Defined buzzword space. :)

Such a logical function would be the entity to hand out for VFIO or
cdev.

But it also can be exported e.g. via sysfs

    bus/pci/.../lfunc/0/

to expose information about these. From a practical POV exposing the
interrupts there too seems to be genuinly useful in order to do proper
affinity settings etc. Retrieving that information from /proc/interrupts
is a complete nightmare.

While you did not find anything in debian, I use the msi_irqs/ as an
easy way to find out which interrupts belong to which device.

I have no strong opinion about those entries as surely can figure it out
by other means, but from a consistency view it makes sense to me.

Using such a uniform representation for storing the associated MSI
descriptors makes sense to me not only from the irq layer but also for
practical purposes.

If this is not split out, then every driver and wrapper has to come up
with it's own representation of this instead of being able to do:

     request_irq(msi_get_virq(lfunc, idx=0), handler0, ...);
     request_irq(msi_get_virq(lfunc, idx=1), handler1, ...);

I went through a ton of usage sites while I was working on this and the
amount of crap which is done there differently is amazing.

Of course that needs some thoughts vs. the MSI domain interfaces, but as
we are modifying them anyway, it's a good opportunity to make introduce
a common representation for these things.

Thanks,

        tglx
