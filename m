Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4BE46AB58
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356477AbhLFWYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 17:24:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356470AbhLFWYw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 17:24:52 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638829282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N49gEhli14ajV1XqLRb5F9ss4iZ1ZN+8bFDUJvAuM3M=;
        b=0J9687idATq3eSU8opoNI/aOkzjdbjjUpMWjHV3Qabs9RqhCNQPNJBr+5i+m3099/jmwq6
        g+ZAiliCpYaXekUHvIKQ2pI4cx3rTI+UFvB0BfqfMIO6f6uBoQUW7LsfXWTS6j+C6mS+3V
        VftXiEs/guGu3i3k6vp77PkuLjxC1mDHeeGcz4MKif8n/65DKd403BVDutNlFXLJZLL5IP
        0VoEExR2BtW7/b8MSBB2ynUXeBvvYayWrW2i+L7o18ENw2U9MeEcyaqsLWKHXD+P38wGGq
        mBPhQZklZdrOsB58eh0sUEXK2m7IfLSHId+27nhXNBKURzAaEPdripwxy+a3+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638829282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N49gEhli14ajV1XqLRb5F9ss4iZ1ZN+8bFDUJvAuM3M=;
        b=Wx4gi6Bj1U8lrQ5ISmceY0XquUUW6+HVPKcwkr02uxE46QEl5SfZX1pDjpJhD0CY+dlfk/
        g6Qu7fTSIpyIBKCw==
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
        iommu@lists.linux-foundation.org, Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211206210609.GN4670@nvidia.com>
References: <87o85y63m8.ffs@tglx> <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx> <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx> <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com> <87fsr54tw1.ffs@tglx>
 <20211206170035.GJ4670@nvidia.com> <875ys14gw0.ffs@tglx>
 <20211206210609.GN4670@nvidia.com>
Date:   Mon, 06 Dec 2021 23:21:21 +0100
Message-ID: <87zgpd2x3y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 06 2021 at 17:06, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 09:28:47PM +0100, Thomas Gleixner wrote:
>> I wish I could mask underneath for some stuff on x86. Though that would
>> not help with the worst problem vs. affinity settings. See the horrible
>> dance in:
>
> My thinking here is that this stuff in ARM is one of the different
> cases (ie not using MSI_FLAG_USE_DEF_CHIP_OPS), and I guess we can
> just handle it cleanly by having the core call both the irq_chip->mask
> and the msi_storage_ops->mask and we don't need ARM to be different,
> x86 just won't provide a mask at destination op.
>
>>     x86/kernel/apic/msi.c::msi_set_affinity()
>
> Okay, so it is complicated, but it is just calling
>    irq_data_get_irq_chip(irqd)->irq_write_msi_msg(irqd, msg);
>
> So, from a msi_storage_ops perspective, things are still clean.

Yes.

>> You forgot IO/APIC which is a MSI endpoint too, just more convoluted but
>> it's not using MSI domains so it's not in the way. I'm not going to
>> touch that with a ten foot pole. :)
>
> I left off IOAPIC because I view it as conceptually different. I used
> the phrasse "device that originated the interrupt" deliberately,
> IOAPIC is just a middle box that converts from a physical interrupt
> line to a message world, it belongs with the physical interrupt
> infrastructure.

I mentioned it because there is mbigen on arm64 which is the same thing,
translates hundreds of wire inputs into MSI. It's even worse than
IO/APIC. There is a horrible hack to make it "work" which Marc and I are
looking at whether we can kill it on the way.

> Possibly the IOAPIC considerations is what motivated some of this to
> look the way it does today, because it really was trying to hide MSI
> under normal PCI INTX physical pins with full compatability. We kind
> of kept doing that as MSI grew into its own thing.

Not really. It was more to avoid having a complete separate
infrastructure for irqdomain based MSI[X]. Lazyness and lack of time
added the rest of non-motivation :)

> I'm curious to see if you end up with irq_domains and irq_chips along
> with what I labeled as the msi_storage above, or if those turn out to
> be unnecesary for the driver to provide MSI programming.

I cant avoid irq chips because from the interrupt handling side of view
that's unavoidable unless we create a duplicate zoo there. What I have
in mind is to convert the msi ops provided by the device driver into a
real chip as that just falls in place without further changes.

The irqdomain will be real as well just to make things consistent and to
share as much code as possible.

> Also, if msi_storage_ops can be robust enough you'd be comfortable
> with it in a driver .c file and just a regex match in the MAINTAINERS
> file :)

That might work. Let's see when we are there.

>>    - Have a transition mechanism to convert one part at a time to keep
>>      the patch sizes reviewable and the whole mess bisectable.
>
> This seems difficult all on its own..

I've done that before. It just needs some thought.

Thanks,

        tglx
