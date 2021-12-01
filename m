Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7D464B71
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 11:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348547AbhLAKUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 05:20:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhLAKUO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 05:20:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638353809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbiMD6K2khcbAApwZxiyDtRNkrqwDaQ0eoVHy6k+DAE=;
        b=DQUYrHcJWTXltulp1feZwgRWzO09qEXPzvxuFWK/F/3vV+hE7s8CvVv6RqfJklXeAyAD0H
        hXnqwh3YlJY3/KlsOG6lNhqsiSkRSaQo109zXU8Ncji5c2Mnmi+NDUCeV5vck2olRwXun2
        HlwLphiG6uDz/ms4mXztbEY8g8Uq4diKY7gqfozy+jiG3TEWSq0lOlzMCzXfp/v3aU0NW2
        tqKUStD1xTEwlY3c0rCYvZSspZ7m4XoWnyinjMBzlicvdmaWcHxr9zGGVseTAHlpQUJ/xS
        nZaskQBDuO+Vx1r7kgboo6bwhFWWXtWR6Qt9J9qr/PFiXQk6HzJiXwtK5YvgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638353809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wbiMD6K2khcbAApwZxiyDtRNkrqwDaQ0eoVHy6k+DAE=;
        b=UinCQtLZesRyTqT4YgZIT5MQ5x/D3n9gdny+zdaLwIM15OXm6LTqjUB6YeI2mys6irMEFC
        QZPVYEsXsxomKLCA==
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
In-Reply-To: <20211201001748.GF4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com>
Date:   Wed, 01 Dec 2021 11:16:47 +0100
Message-ID: <87mtlkaauo.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

CC+ IOMMU folks

On Tue, Nov 30 2021 at 20:17, Jason Gunthorpe wrote:
> On Tue, Nov 30, 2021 at 10:23:16PM +0100, Thomas Gleixner wrote:
>> The real problem is where to store the MSI descriptors because the PCI
>> device has its own real PCI/MSI-X interrupts which means it still shares
>> the storage space.
>
> Er.. I never realized that just looking at the patches :|
>
> That is relevant to all real "IMS" users. IDXD escaped this because
> it, IMHO, wrongly used the mdev with the IRQ layer. The mdev is purely
> a messy artifact of VFIO, it should not be required to make the IRQ
> layers work.

> I don't think it makes sense that the msi_desc would point to a mdev,
> the iommu layer consumes the msi_desc_to_dev(), it really should point
> to the physical device that originates the message with a proper
> iommu ops/data/etc.

Looking at the device slices as subdevices with their own struct device
makes a lot of sense from the conceptual level. That makes is pretty
much obvious to manage the MSIs of those devices at this level like we
do for any other device.

Whether mdev is the right encapsulation for these subdevices is an
orthogonal problem.

I surely agree that msi_desc::dev is an interesting question, but we
already have this disconnect of msi_desc::dev and DMA today due to DMA
aliasing. I haven't looked at that in detail yet, but of course the
alias handling is substantially different accross the various IOMMU
implementations.

Though I fear there is also a use case for MSI-X and IMS tied to the
same device. That network card you are talking about might end up using
MSI-X for a control block and then IMS for the actual network queues
when it is used as physical function device as a whole, but that's
conceptually a different case.

>> I'm currently tending to partition the index space in the xarray:
>> 
>>  0x00000000 - 0x0000ffff          PCI/MSI-X
>>  0x00010000 - 0x0001ffff          NTB
>
> It is OK, with some xarray work it can be range allocating & reserving
> so that the msi_domain_alloc_irqs() flows can carve out chunks of the
> number space..
>
> Another view is the msi_domain_alloc_irqs() flows should have their
> own xarrays..

Yes, I was thinking about that as well. The trivial way would be:

    struct xarray     store[MSI_MAX_STORES];

and then have a store index for each allocation domain. With the
proposed encapsulation of the xarray handling that's definitely
feasible. Whether that buys much is a different question. Let me think
about it some more.

>> which is feasible now with the range modifications and way simpler to do
>> with xarray than with the linked list.
>
> Indeed!

I'm glad you like the approach.

Thanks,

        tglx


