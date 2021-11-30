Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31FA463FED
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 22:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344034AbhK3V1J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 16:27:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35816 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344146AbhK3V0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 16:26:38 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638307397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=in98yBSPQ1jj4nb7z9Wj+iGoSHUoXZb4meQtKeaOU84=;
        b=MiSAy+MxwlGTJvI0Nft8vmU3vCwy9rjUEWmRpHVGmBcoQ/weQpSSiLlWum6ML5meeF7VAD
        kgI04GRG6PDCFL60YOnF59s95PcMMCLelLa9mjBAjZcqqNLMNrO7UVlkaC+ZbEoPjtbRnC
        fxuSprKFedzx3yWGEuYSaoA0RXObjPofxqK7RB+Zgik0jZeMM9YxKEyQLPuQE6Cdop/nOq
        WGFN3rqMhV0aXxt2FlxxLWhMCE9AqACQ2ToCqINxJ9y6ZlIzso5EZM5zAr6XKYG4AXpvGI
        hf6FlP6QWaQ4FXtiPPennkpeBs1NsFGKAFfHCSHsElsM2MdYpwh0VP92qkr4kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638307397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=in98yBSPQ1jj4nb7z9Wj+iGoSHUoXZb4meQtKeaOU84=;
        b=+u9BMLqbSJf6XkRa5fee8Qy2vcmPs8xE+VHAIoxmsrMDFWOB2P9PCnHtQIfJOKfO32TJtb
        mSz4vtSe4H9XObBA==
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
        Christian Borntraeger <borntraeger@de.ibm.com>, x86@kernel.org
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211130202800.GE4670@nvidia.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com>
Date:   Tue, 30 Nov 2021 22:23:16 +0100
Message-ID: <87o861banv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 30 2021 at 16:28, Jason Gunthorpe wrote:
> On Tue, Nov 30, 2021 at 08:48:03PM +0100, Thomas Gleixner wrote:
>> On Tue, Nov 30 2021 at 12:21, Logan Gunthorpe wrote:
>> > On 2021-11-29 5:29 p.m., Thomas Gleixner wrote:
>> >> I'm way too tired to come up with a proper solution for that, but that
>> >> PCI_IRQ_VIRTUAL has to die ASAP.
>> >
>> > I'm willing to volunteer a bit of my time to clean this up, but I'd need
>> > a bit more direction on what a proper solution would look like. The MSI
>> > domain code is far from well documented nor is it easy to understand.
>> 
>> Fair enough. I'm struggling with finding time to document that properly.
>> 
>> I've not yet made my mind up what the best way forward for this is, but
>> I have a few ideas which I want to explore deeper.
>
> I may have lost the plot in all of these patches, but I thought the
> direction was moving toward the msi_domain_alloc_irqs() approach IDXD
> demo'd here:
>
> https://lore.kernel.org/kvm/162164243591.261970.3439987543338120797.stgit@djiang5-desk3.ch.intel.com/

Yes, that's something I have in mind. Though this patch series would not
be really required to support IDXD, it's making stuff simpler.

The main point of this is to cure the VFIO issue of tearing down MSI-X
of passed through devices in order to expand the MSI-X vector space on
the host.

> I'd expect all the descriptor handling code in drivers/ntb/msi.c to
> get wrapped in an irq_chip instead of inserting a single-use callback
> to the pci core code's implementation:
>
> void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg)
> {
>         if (entry->write_msi_msg)
>                 entry->write_msi_msg(entry, entry->write_msi_msg_data);
>
> If this doesn't become an irq_chip what other way is there to properly
> program the addr/data pair as drivers/ntb/msi.c is doing?

That's not the question. This surely will be a separate irq chip and a
separate irqdomain.

The real problem is where to store the MSI descriptors because the PCI
device has its own real PCI/MSI-X interrupts which means it still shares
the storage space.

IDXD is different in that regard because IDXD creates subdevices which
have their own struct device and they just store the MSI descriptors in
the msi data of that device.

I'm currently tending to partition the index space in the xarray:

 0x00000000 - 0x0000ffff          PCI/MSI-X
 0x00010000 - 0x0001ffff          NTB

which is feasible now with the range modifications and way simpler to do
with xarray than with the linked list.

Thanks,

        tglx


