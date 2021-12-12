Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D4C47175A
	for <lists+linux-pci@lfdr.de>; Sun, 12 Dec 2021 01:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhLLAML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 19:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhLLAMK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 19:12:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9CFC061714;
        Sat, 11 Dec 2021 16:12:10 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639267926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96U2PvNjfJ25atF3ICxYtTfUxrjzv0nAHv5JG16938Y=;
        b=qM/Otsa93p16nlR9DkrMfklAwRdZuI5Fi25hBcrv+RfRaQAnQIKilESEITJdIeherUES3k
        lEaluejCbQWR8vk3qXKRNe+fSzEjZb8Lq3xD/g/QVQbw2wlcenFnWnTJxDsf1kZJF6REQ3
        C9owWU1oMpezJc0cGBg1Af7a9tW6FDI64myjiMK6J61lmq2xMhrzFTs2v3ietjUS8abHyg
        b1qgZguIkR+9v0JztqlD3sdejolUuoSPxqFGPoppQxL1CEJqX9wL0HaAYwAC+nRoCb6Fm3
        8LoezdAb0uju/kjuKofSa3R/O5T6+9q+mHPCLQ/1CiFiZakwWBbAHFrsMAIZ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639267926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96U2PvNjfJ25atF3ICxYtTfUxrjzv0nAHv5JG16938Y=;
        b=pzckp4fggY2TyL8TqgqkB1LFIEa6p646bMIt0lGvtXjie64eXqNhFKTbnbkfUlzQ8hiJu1
        kIrEo8pOTLFsyWDQ==
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Jiang, Dave" <dave.jiang@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dey, Megha" <megha.dey@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
Date:   Sun, 12 Dec 2021 01:12:05 +0100
Message-ID: <87lf0qvfze.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kevin,

On Sat, Dec 11 2021 at 07:52, Kevin Tian wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>> > Then Qemu needs to find out the GSI number for the vIRTE handle.
>> > Again Qemu doesn't have such information since it doesn't know
>> > which MSI[-X] entry points to this handle due to no trap.
>> 
>> No this is already going wrong. qemu *cannot* know the MSI information
>> because there is no MSI information for IMS.
>
> I haven't thought of IMS at this step. The IR approach applies to
> all types of interrupt storages, thus I'm more interested in how it
> affect the storages which are already virtualized today (MSI[-X] 
> in my thought practice).

They are not any different. As I explained several times now IMS is
nothing new at all. It existed since the invention of Message Signaled
interrupts. Why?

The principle behind Message Signaled Interrupts is:

    Device writes DATA to ADDRESS which raises an interrupt in a CPU

Message Signaled Interrupts obviously need some place to store the
ADDRESS/DATA pair so that the device can use it for raising an
interrupt, i.e. an

   Interrupt Message Store, short IMS.

PCI/MSI was the first implementation of this and the storage was defined
to be at a specified and therefore uniform and device independent place.

PCI/MSI-X followed the same approch. While it solved quite some of the
shortcomings of PCI/MSI it still has a specificed and uniform and device
independent place to store the message (ADDRESS/DATA pair)

Now the PCI wizards figured out that PCI/MSI[-X] is not longer up to the
task for various reasons and came up with the revolutionary new concept
of IMS, aka Interrupt Message Store. where the device defines where the
message is stored.

IOW, this is coming back full circle to the original problem of where to
store the message, i.e. the ADDRESS/DATA pair so that the device can
raise an interrupt in a CPU, which requires - drum roll - an

   Interrupt Message Store, short IMS.

So you simply have to look at it from a pure MSI (not PCI/MSI) point
of view:

   MSI at the conceptual level requires storage for the ADDRESS/DATA
   pair at some place so that the device or the compute unit embedded in
   the device can write DATA to ADDRESS.

That's it. Not more, not less.

When you look at it from this perspective, then you'll realize that

     PCI/MSI and PCI/MSI-X are just implementations of IMS

Not more, not less. The fact that they have very strict rules about the
storage space and the fact that they are mutually exclusive does not
change that at all.

That's where a lot of the confusion comes from. If you go back to all
the IDXD/IMS discussions which happened over time then you'll figure out
that _all_ of us where coming from the same wrong assumption:

    IMS is new and it's just another exclusive variant of PCI/MSI and
    PCi/MSI-X.

It took _all_ of us quite some time to realize that we need to look at
it from the other way around.

There was surely some other conceptual confusion vs. subdevices, queues
and whatever involved which contributed to that. Water under the bridge.

Coming back to your initial question:

> I haven't thought of IMS at this step. The IR approach applies to
> all types of interrupt storages, thus I'm more interested in how it
> affect the storages which are already virtualized today (MSI[-X] 
> in my thought practice).

Stop focussing on implementation details. Focus on the general concept
instead. See above.

Thanks,

        tglx

