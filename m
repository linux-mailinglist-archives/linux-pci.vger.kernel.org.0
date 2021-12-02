Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DE466CB9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 23:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbhLBWei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 17:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhLBWeh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 17:34:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15EEC06174A;
        Thu,  2 Dec 2021 14:31:14 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638484272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPV/P40v2U0P8DhSWSQCuWDSGa4mGn96LwynWGTQrSo=;
        b=KSrBvnhgjDA7Ok2VXU38PHDhTsKqhMhbNCw4wyfCGQDprdzFEft34TwZ9FMYo7WGroyCqs
        CmlxKCaPIw0YfLKorO6Xpk7+EoGoa6ujvP4c9L0gbfJt9XXa5HNNJgwyvDXhAVcveyeAZQ
        7eEo9fQKAZEWVmKWep1+dBFW/5M27Q0rK+vWCFkl8lrwx3as5LCWj0iJavZpHhLuCTLISO
        aYBb8UL+OZu6qkfxuPS8wnF3wSoVZS6BLCuA2TUWLxh47MqQ9NNkBROw4w4Xs6lZ3Wz/dz
        wWpbouq6ZoICPA2l3gnEZDf+zIbfxm9In6qTdt10JyhvFUwFDbFp/VHuSf+snQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638484272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VPV/P40v2U0P8DhSWSQCuWDSGa4mGn96LwynWGTQrSo=;
        b=mNChMHozKXHd8nwdd11Tr1p2dwkGFGdUKOI5h1dZi6RBm0kzTEaCB/gNblrfrxvjshs8iH
        CK3u4vCGKHKbKaCQ==
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
In-Reply-To: <20211202200017.GS4670@nvidia.com>
References: <87o861banv.ffs@tglx> <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx> <20211201130023.GH4670@nvidia.com>
 <87y2548byw.ffs@tglx> <20211201181406.GM4670@nvidia.com>
 <87mtlk84ae.ffs@tglx> <87r1av7u3d.ffs@tglx>
 <20211202135502.GP4670@nvidia.com> <87wnkm6c77.ffs@tglx>
 <20211202200017.GS4670@nvidia.com>
Date:   Thu, 02 Dec 2021 23:31:11 +0100
Message-ID: <87o85y63m8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Thu, Dec 02 2021 at 16:00, Jason Gunthorpe wrote:
> On Thu, Dec 02, 2021 at 08:25:48PM +0100, Thomas Gleixner wrote:
>> We seem to have a serious problem of terminology and the understanding
>> of topology which is why we continue to talk past each other forever.
>
> I think I understand and agree with everything you said below.

Good!

> The point we diverge is where to put the vector storage:

Kinda. The vector, i.e. message storage is either:

  - MSI entry in the PCI config space
  - MSI-X table in the PCI config space
  - Device specific IMS storage

The software representation aka struct msi_desc is a different
story. That's what we are debating.

>> Of course we can store them in pci_dev.dev.msi.data.store. Either with a
>> dedicated xarray or by partitioning the xarray space. Both have their
>> pro and cons.
>
> This decision seems to drive the question of how many 'struct devices'
> do we need, and where do we get them..

Not really. There is nothing what enforces to make the MSI irqdomain
storage strictly hang off struct device. There has to be a connection to
a struct device in some way obviously to make IOMMU happy.

>> Such a logical function would be the entity to hand out for VFIO or
>> cdev.
>
> What is a logical function, concretely?

That's a name I came up with for a abstract representation of such a
queue container. I came up with that as a obvious consequence of my
previous reasoning about PF -> VF -> XF.

> Does it have struct device?

It does not necessarily have to .

> Can I instead suggest a name like 'message interrupt table' ?

Well yes, but that's not what I meant. See below.

> Ie a device has two linearly indexed message interrupt tables - the
> PCI SIG defined MSI/MSI-X one created by the PCI core and the IMS one
> created by the driver.
>
> Both start at 0 index and they have different irq_domains.
>
> Instead of asking the driver to create a domain we ask the driver to
> create a new 'message interrupt table'. The driver provides the
> irq_chip to program the messages and the pci_device. The core code
> manages the irq domain setup.
>
> Using what you say below:
>
>> If this is not split out, then every driver and wrapper has to come up
>> with it's own representation of this instead of being able to do:
>> 
>>      request_irq(msi_get_virq(lfunc, idx=0), handler0, ...);
>>      request_irq(msi_get_virq(lfunc, idx=1), handler1, ...);
>
> We could say:
>   msi_get_virq(device.pci_msi_table, index=0)
>
> Is the 0th PCI SIG MSI vector
>
> Something like:
>
>  ims_table = pci_create_msi_table(pci_dev, my_irq_chip,..)
>  msi_get_virq(ims_table, index=0)

Which is pretty much a wrapper around two different irqdomains for the
device and either partitioned index space in the xarray or two xarrays.

Just badly named because the table itself is where the resulting message
is stored, which is composed with the help of the relevant MSI
descriptor. See above.

We really should not try to make up an artifical table representation
for something which does not necessarily have a table at all, i.e. the
devices you talk about which store the message in queue specific system
memory. Pretending that this is a table is just silly.

Also I disagree that this has to be tied to a PCI specific interface,
except for creating a PCI specific wrapper for it to not make a driver
developer have to write '&pdev->dev', which is the very least of our
problems.

IMS as a technical concept is absolutely not PCI specific at all and not
invented by PCI/SIG. It's a marketing brandname for something which
existed way before they thought about it: Message signaled interrupts.

Aside of that 'my_irq_chip' does not cut it at all because of the way
how the resulting messages are stored. IDXD has IOMEM storage and a
storage space limitation while your device uses system memory storage
and has other limitations, i.e. system memory and the number of queues
the device can provide.

An irqchip is a just set of functions to talk to hardware either
directly or via some indirect transport (I2C, SPI, MLX queue management
magic...). These functions require irqdomain and/or device specific
information to function.

Trying to create a universal pci_create_foo() wrapper around this is
going to be like the 13th Herkulean task.

Seriously, you cannot make something uniform which is by definition
non-uniform.

Let's not even try to pretend that it is possible.

> Is the 0th IMS vector
>
> Is it close to what you are thinking with lfunc?

Not really. I was really reasoning about an abstract representation for
a functional queue, which is more than just a queue allocated from the
PF or VF device.

I really meant a container like this:

struct logical_function {
        /* Pointer to the physical device */
        struct device		*phys_device;
        /* MSI descriptor storage */
	struct msi_data		msi;
        /* The queue number */
        unsigned int		queue_nr;
        /* Add more information which is common to these things */
};

Now the real queue, which is obviously not generic:

struct myqueue_function {
	struct logical_function lfunc;
        struct myqueue		queue;
};        

The idea is to have a common representation for these type of things
which allows:

 1) Have common code for exposing queues to VFIO, cdev, sysfs...

    You still need myqueue specific code, but the common stuff which is
    in struct logical_function can be generic and device independent.

 2) Having the MSI storage per logical function (queue) allows to have
    a queue relative 0 based MSI index space.

    The actual index in the physical table (think IMS) would be held in
    the msi descriptor itself.

`   Which then allows queue relative addressing without extra device/queue
    specific meta storage.

    i.e.

        msi_get_virq(&myqueue->lfunc.msi, idx = 0)

    v.s.

        idx = myqueue->msidx[0];
        msi_get_virq(pcidev->dev, idx);

        where the queue management code has to set up myqueue->msidx[]
        and stick the index of the underlying device storage into it.

 3) Setup and teardown would be simply per logical function for
    all of the related resources which are required.

    Interrrupt teardown would look like this:

      msi_domain_free_all_irqs(irqdomain, &lfunc->msi);

    vs.

      for (i = 0; i < myqueue->nrirqs; i++)
           msi_domain_free_irq(irqdomain, &pcidev->dev, myqueue->msidx[0]);


Now change struct logical_function to:

struct logical_function {
-       /* Pointer to the physical device */
-       struct device		*phys_device;

+       /* Pseudo device to allow using devres */
+       struct pseudo_device	pseudo_device;

	/* MSI descriptor storage */
	struct msi_data		msi;
        /* The queue number */
        unsigned int		queue_nr;
        /* Add more information which is common to these things */
};

where struct pseudo_device holds the phys_device pointer and then you
can utilize the devres infrastructure like you do for any other device
and do:

      pseudo_device_add(&myqueue->lfunc.pseudo_device);

at setup time and

      pseudo_device_remove(&myqueue->lfunc.pseudo_device);

on teardown and let all the resources including MSI interrupts be
released automatically.

Needs some infrastructure obviously, but to me that makes a lot of
sense.

And I named it pseudo_device on purpose as it is just a vehicle to make
existing infrastructure which is device specific usable for this kind of
thing.

I might be completely off track. Feel free to tell me so :)

Thanks,

        tglx
