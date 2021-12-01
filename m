Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623D46541C
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 18:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbhLARjC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 12:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhLARjA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 12:39:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D199C061574;
        Wed,  1 Dec 2021 09:35:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638380135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wl46BdwZ1KGmv50G3jfsI0iPOejQIWMQSjLutgaOqHk=;
        b=Pt+06zaIN+XpTYcehYRys4HS6+cE2m00/PDyN9TVIqeywPk9TTKPncOzAFiuKRSxOoNPqI
        AIVc5kWzV7DZUepaLnecpQSpeilOo7HLcvABG0FHIM99zFsj6YzMuKoxBIMB2mIDHDvWPF
        WXoI8orNajSMfj/abMIouU/kReMZpmDjvA+dmGmp8L9lqueEILj0Y0HXBPxUo5O8RSP88C
        yr/AToa8X9keo82ZrPu4y700gVV5afLfh3oCl/0OThPa+UJI1XHydF4PfhiY5m57ipzz6W
        L1I8Kt9UNYWk+vEoTJzmxbnGYdcT0Zq7nFWc9XJ2N4OWIbexFvFzd88vDoSGrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638380135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wl46BdwZ1KGmv50G3jfsI0iPOejQIWMQSjLutgaOqHk=;
        b=MnhqyMiRcxE0SVcEGB/228XRCWh7TIQj1mDZaA2bSHkC/rEWlG373NhsYy4dvo0s23asR9
        YhsM2tmL5EKUQkBw==
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
In-Reply-To: <20211201130023.GH4670@nvidia.com>
References: <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com>
 <874k7ueldt.ffs@tglx> <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com>
 <87ilwacwp8.ffs@tglx> <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com>
 <87v909bf2k.ffs@tglx> <20211130202800.GE4670@nvidia.com>
 <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
Date:   Wed, 01 Dec 2021 18:35:35 +0100
Message-ID: <87y2548byw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 01 2021 at 09:00, Jason Gunthorpe wrote:
> On Wed, Dec 01, 2021 at 11:16:47AM +0100, Thomas Gleixner wrote:
>> Looking at the device slices as subdevices with their own struct device
>> makes a lot of sense from the conceptual level.
>
> Except IMS is not just for subdevices, it should be usable for any
> driver in any case as a general interrupt mechiansm, as you alluded to
> below about ethernet queues. ntb seems to be the current example of
> this need..

But NTB is operating through an abstraction layer and is not a direct
PCIe device driver.

> IDXD is not so much making device "slices", but virtualizing and
> sharing a PCI device. The IDXD hardware is multi-queue like the NIC I
> described and the VFIO driver is simply allocating queues from a PCI
> device for specific usages and assigning them interrupts.

Right.

But what is the representation for that resulting device? Some VFIO
specific homebrewn muck or something which is based on struct device?

Right now with VF passthrough, I can see the interrupts which are
associated to the device.

How is that going to be with something which is just made up? Does that
expose it's own msi properties then somewhere hidden in the VFIO layer?

See below.

> There is already a char dev interface that equally allocates queues
> from the same IDXD device, why shouldn't it be able to access IMS
> interrupt pools too?

Why wouldn't it be able to do so?

> IMHO a well designed IDXD driver should put all the PCI MMIO, queue
> mangement, interrupts, etc in the PCI driver layer, and the VFIO
> driver layer should only deal with the MMIO trapping and VFIO
> interfacing.
>
> From this view it is conceptually wrong to have the VFIO driver
> directly talking to MMIO registers in the PCI device or owning the
> irq_chip.

The VFIO driver does not own the irq chip ever. The irq chip is of
course part of the underlying infrastructure. I never asked for that.

PCIe driver
     Owns the PCI/MSI[x] interrupts for the control block

     Has a control mechanism which handles queues or whatever the
     device is partitioned into, that's what I called slice.

     The irqdomain is part of that control mechanism and the irqchip
     implementation belongs to that as well. It has to because the
     message store is device specific.

     Whether the doamin and chip implementation is in a separate
     drivers/irqchip/foo.c file for sharing or directly built into the
     PCIe driver itself does not matter.

     When it allocates a slice for whatever usage then it also
     allocates the IMS interrupts (though the VFIO people want to
     have only one and do the allocations later on demand).

     That allocation cannot be part of the PCI/MSIx interrupt
     domain as we already agreed on.

We have several problems to solve. Let me look at it from both point of
views:

    1) Storage

       A) Having "subdevices" solves the storage problem nicely and
          makes everything just fall in place. Even for a purely
          physical multiqueue device one can argue that each queue is a
          "subdevice" of the physical device. The fact that we lump them
          all together today is not an argument against that.

       B) Requires extra storage in the PCIe device and extra storage
          per subdevice, queue to keep track of the interrupts which
          are associated to it.

    2) Exposure of VFIO interrupts via sysfs

       A) Just works

       B) Requires extra mechanisms to expose it

    3) On demand expansion of the vectors for VFIO

       A) Just works because the device has an irqdomain assigned.

       B) Requires extra indirections to do that

    4) IOMMU msi_desc::dev

       A) I think that's reasonably simple to address by having the
          relationship to the underlying PCIe device stored in struct
          device, which is not really adding any complexity to the IOMMU
          code.

          Quite the contrary it could be used to make the DMA aliasing a
          problem of device setup time and not a lookup per interrupt
          allocation in the IOMMU code.

       B) No change required.

    4) PASID

       While an Intel IDXD specific issue, it want's to be solved
       without any nasty hacks.

       A) Having a "subdevice" allows to associate the PASID with the
          underlying struct device which makes IOMMU integration trivial

       B) Needs some other custom hackery to get that solved

So both variants come with their ups and downs.

IMO A) is the right thing to do when looking at all the involved moving
pieces.

> It would be very odd for the PCI driver to allocate interrupts from
> some random external struct device when it is creating queues on the
> PCI device.

No. That's not what I want.

>> and then have a store index for each allocation domain. With the
>> proposed encapsulation of the xarray handling that's definitely
>> feasible. Whether that buys much is a different question. Let me think
>> about it some more.
>
> Any possibility that the 'IMS' xarray could be outside the struct
> device?

We could, but we really want to keep things tied to devices which is the
right thing to do.

Thanks,

        tglx
