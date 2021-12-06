Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7CA46A6DF
	for <lists+linux-pci@lfdr.de>; Mon,  6 Dec 2021 21:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhLFUcU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Dec 2021 15:32:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhLFUcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Dec 2021 15:32:18 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638822528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjUH7Q3jnce45xFbv6Ml85eYeIz6Jg5Ro8bSCZZ8hQ4=;
        b=F9MENSnbcrAIrw2trie4XxO4Idnck4Ve+cZwHmT/EygS5n2DDkmikE9xBxeD9s0sWo2qJm
        CGGqi85xc6Ukh6t9Y3GlDXvuFUcSnA8mKiNQU1rr2T1H0NxvZrMVvY3hncH85obllkkj/1
        +j+r/5KQIXittbe96XBWAd+PayRnuGs3P3h9j2h2r4htxUOm3vEVMESrqa2X3L5Gg9DWOO
        BAAW7v4r201fq29CffjbHb+ju9BOWroU6g9qfPUpuUkeGzzH03uYn7ZW8bBe9Ba1YU9vQn
        bPRXdMo3NGlNIbJUfco/nQEuygA7sxEO8ZRXE34ZJz0RpD76vel5187uDQhaCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638822528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjUH7Q3jnce45xFbv6Ml85eYeIz6Jg5Ro8bSCZZ8hQ4=;
        b=x2ifkMTraUj6uc8UnfCExsx31cknQRBYPY0/0XCFCRLeYB2nXzEoseLKnZI380Rk6pO4Ex
        0jq/4vd3/sOt8CCQ==
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
In-Reply-To: <20211206170035.GJ4670@nvidia.com>
References: <87wnkm6c77.ffs@tglx> <20211202200017.GS4670@nvidia.com>
 <87o85y63m8.ffs@tglx> <20211203003749.GT4670@nvidia.com>
 <877dcl681d.ffs@tglx> <20211203164104.GX4670@nvidia.com>
 <87v9044fkb.ffs@tglx> <87o85v3znb.ffs@tglx>
 <20211206144344.GA4670@nvidia.com> <87fsr54tw1.ffs@tglx>
 <20211206170035.GJ4670@nvidia.com>
Date:   Mon, 06 Dec 2021 21:28:47 +0100
Message-ID: <875ys14gw0.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Jason,

On Mon, Dec 06 2021 at 13:00, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 04:47:58PM +0100, Thomas Gleixner wrote:
>> It will need some more than that, e.g. mask/unmask and as we discussed
>> quite some time ago something like the irq_buslock/unlock pair, so you
>> can handle updates to the state from thread context via a command queue
>> (IIRC).
>
> pci_msi_create_irq_domain() hooks into the platforms irq_chip as an
> alternative to hierarchical irq domains (?)

It's based on hierarchical irqdomains. It's the outermost domain and irq
chip. On X86:

  [VECTOR chip=apic]->[PCI chip=PCI]
or
  [VECTOR chip=apic]->[IOMMU chip=IR]->[PCI chip=PCI-IR]

The chips are different because of quirks. See below :)

>		chip->irq_write_msi_msg = pci_msi_domain_write_msg;
> In almost all cases 'ops' will come along with a 'state', so lets
> create one:
>
> struct msi_storage {  // Look, I avoided the word table!

I already made a note, that I need to smuggle a table in somewhere :)

> And others for the different cases. Look no ifs!
>
> OK?

That's already the plan in some form, but there's a long way towards
that. See below.

Also there will be a question of how many different callbacks we're
going to create just to avoid one conditional. At some point this might
become silly.

> Now, we have some duplication between the struct msi_storage_ops and
> the struct irq_chip. Let's see what that is about:
>
> arch/x86/kernel/apic/msi.c:     .irq_write_msi_msg      = dmar_msi_write_msg,
> arch/x86/kernel/hpet.c: .irq_write_msi_msg = hpet_msi_write_msg,
>
> Surprised! These are actually IMS. The HPET and DMAR devices both have
> device-specific message storage! So these could use
> msi_storage_ops. And WTF is IOMMU DMAR driver code doing in
> apic/msi.c ???

Historical reasons coming from the pre irqdomain aera. Also DMAR needs
direct access to the x86 low level composer which we didn't want to
expose. Plus DMAR is shared with ia64 to make it more interesting.

Yes, they can be converted. But that's the least of my worries. Those
are straight forward and not really relevant for the design.

> arch/powerpc/platforms/pseries/msi.c:   .irq_write_msi_msg      = pseries_msi_write_msg,
>
> AFAICT this is really like virtualization? The hypervisor is
> controlling the real MSI table and what the OS sees is faked out
> somewhat.
>
> This is more of quirk in the PCI MSI implementation (do not touch the
> storage) and a block on non-PCI uses of MSI similar to what x86 needs?

There is an underlying hypervisor of some sorts and that stuff needs to
deal with it. I leave that to the powerpc wizards to sort out.

> drivers/irqchip/irq-gic-v2m.c:  .irq_write_msi_msg      = pci_msi_domain_write_msg,
> drivers/irqchip/irq-gic-v3-its-pci-msi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,
> drivers/irqchip/irq-gic-v3-mbi.c:       .irq_write_msi_msg      = pci_msi_domain_write_msg,
>
> ARM seems to be replacing the 'mask at source' with 'mask at
> destination' - I wonder why?

Because the majority of PCI/MSI endpoint implementations do not provide
masking...

We're telling hardware people for 15+ years that this is a horrible
idea, but it's as effective as talking to a wall. Sure the spec grants
them to make my life miserable...

> Should this really be hierarchical where we mask *both* the MSI
> originating device (storage_ops->mask) and at the CPU IRQ controller?
> (gicv2m_mask_msi_irq ?) if it can?

I wish I could mask underneath for some stuff on x86. Though that would
not help with the worst problem vs. affinity settings. See the horrible
dance in:

    x86/kernel/apic/msi.c::msi_set_affinity()

So this will end up with a shim as the base domain for !IOMMU systems:

		 			       |--[HPET]
  [VECTOR chip=apic]-|--[x86-msi chip=x86-msi]-|--[PCI/MSI]
		     |--[DMAR]		       |--[PCI/MSI-X]

That nonsense can't move into the apic domain set_affinity() callback as
this is not required when interrupt remapping is enabled.

With IOMMU this looks then:

		 		        |--[HPET]
  [VECTOR chip=apic]-|--[IOMMU chip=IR]-|--[PCI/MSI]
		     |--[DMAR]	        |--[PCI/MSI-X]
		 		        |--[PCI/IMS]

> drivers/base/platform-msi.c:            chip->irq_write_msi_msg = platform_msi_write_msg;
>
> Oh! this is doing what I kind of just suggested, just non-generically
> and hacked into platform bus drivers the same as PCI does:

Correct. It's a hack and it's on the list of things which need to
vanish. I was already discussing that with Marc on the side for quite a
while.

> PCI, HPET, DMAR move to msi_storage_ops instead of using irq_chip

With different parent domains. DMAR hangs always directly off the vector
domain. HPET has its own IOMMU zone.

You forgot IO/APIC which is a MSI endpoint too, just more convoluted but
it's not using MSI domains so it's not in the way. I'm not going to
touch that with a ten foot pole. :)

There's also VMD, HyperV and the XEN crime which is a horrible shim to
make device->msi_domain consistent on x86. For fixing XEN properly I'm
not masochistic enough.

> For API compat every pci struct device will have to instantiate a
> msi_storage someplace, but that seems easy enough.

That's easy to hide in the existing driver interfaces for PCI/MSI and
PCI/MSI-X.

> Seems like a nice uniform solution?

That's where I'm heading.

I have a full inventory of the various horrors involved, so I have a
pretty good picture what kind of oddities are involved, where a shim
domain is required and which underlying platforms require the MSI irq
chip to do:

    irq_chip_mask()
       msi_ops->mask()
       parent->chip->mask()

and so forth. I need to figure out how the parent irq chip / irqdomain
transports that requirement.

But that part is not where the real work is. I'll get there eventually
once I sorted the underlying parts:

   - Building up the infrastructure in kernel/irq/

   - Decomposing pci/msi/* further

   - Make use of the infrastructure for an alternate pci/msi
     implemention.
   
   - Have a transition mechanism to convert one part at a time to keep
     the patch sizes reviewable and the whole mess bisectable.

Doing all this while keeping the full universe of legacy/arch, current
PCI/MSI domains alive makes that interesting. I broke the world in the
past, so I'm not afraid of doing it again. Though I try to avoid it to
the extent possible. :)

I have a pretty good picture in my head and notes already, which needs
to be dumped into code. But let me post part 1-3 V2 first, so that pile
gets out of the way. Not having to juggle 90 patches makes life easier.

Thanks,

        tglx
