Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A73F69CC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 21:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhHXT0m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 15:26:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234096AbhHXT0l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 15:26:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0582A60ED6;
        Tue, 24 Aug 2021 19:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629833157;
        bh=HbEZS6OQhEM/2DYcwn87oZ+DrBDVAvOQQjpH05sCT08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZqDq+xjV2GnGMcXhyFxlbz+gxaLdttMj3boW7RC3lBeTCClieSP6WbvUaJ8DiDcab
         qijUTUFIyKbgK8exIr46fDH+MaAi5bBa4FW4ENDzfQCRO3Qeg9nAmncCxFgt3hk45P
         Q1f13WNguhkGUvN1huqTrGAAwmLwHsdUICAHvMGL3QUNpZj514LIY+w4iWZEIM6a+H
         hjIXNG8ptQb6jZJ2RBZEWwXSM2vuihHtlIR/nVv18kvdYwHPoZXN8iIAUeJBlzMLvq
         UfPMPSkgcqQ14L11LM3iQydEmGX5KbR95OHieWG2VAnMmIfRo0T42+A076RyTE6iP9
         oDKRPxT52mtJA==
Date:   Tue, 24 Aug 2021 14:25:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jonathan.Cameron@huawei.com,
        bilbao@vt.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        luzmaximilian@gmail.com, mchehab+huawei@kernel.org,
        schnelle@linux.ibm.com, Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/2] PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
Message-ID: <20210824192555.GA3487590@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w35+mRE_qp117HhNOaHeUN1cO6GGPW36qtjaX6wUcQNA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 22, 2021 at 10:41:17AM +1200, Barry Song wrote:
> On Sun, Aug 22, 2021 at 10:14 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Aug 21, 2021 at 10:42 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Hi Bjorn,
> > >
> > > On Sat, 21 Aug 2021 00:33:28 +0100,
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > [+cc Thomas, Marc]
> > > >
> > > > On Sat, Aug 21, 2021 at 10:37:43AM +1200, Barry Song wrote:
> > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > >
> > > > > /sys/bus/pci/devices/.../irq sysfs ABI is very confusing at this
> > > > > moment especially for MSI-X cases.
> > > >
> > > > AFAICT this patch *only* affects MSI-X.  So are you saying the sysfs
> > > > ABI is fine for MSI but confusing for MSI-X?
> > > >
> > > > > While MSI sets IRQ to the first
> > > > > number in the vector, MSI-X does nothing for this though it saves
> > > > > default_irq in msix_setup_entries(). Weird the saved default_irq
> > > > > for MSI-X is never used in pci_msix_shutdown(), which is quite
> > > > > different with pci_msi_shutdown(). Thus, this patch moves to show
> > > > > the first IRQ number which is from the first msi_entry for MSI-X.
> > > > > Hopefully, this can make IRQ ABI more clear and more consistent.
> > > > >
> > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > > ---
> > > > >  drivers/pci/msi.c | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > > index 9232255..6bbf81b 100644
> > > > > --- a/drivers/pci/msi.c
> > > > > +++ b/drivers/pci/msi.c
> > > > > @@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > > >     int ret;
> > > > >     u16 control;
> > > > >     void __iomem *base;
> > > > > +   struct msi_desc *desc;
> > > > >
> > > > >     /* Ensure MSI-X is disabled while it is set up */
> > > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> > > > > @@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> > > > >
> > > > >     pcibios_free_irq(dev);
> > > > > +
> > > > > +   desc = first_pci_msi_entry(dev);
> > > > > +   dev->irq = desc->irq;
> > > >
> > > > This change is not primarily about sysfs.  This is about changing
> > > > "dev->irq" when MSI-X is enabled, and it's only incidental that sysfs
> > > > reflects that.
> > > >
> > > > So we need to know the effect of changing dev->irq.  Drivers may use
> > > > the value of dev->irq, and I'm *guessing* this change shouldn't break
> > > > them since we already do this for MSI, but I'd like some more expert
> > > > opinion than mine :)
> > > >
> > > > For MSI we have:
> > > >
> > > >   msi_capability_init
> > > >     msi_setup_entry
> > > >       entry = alloc_msi_entry(nvec)
> > > >       entry->msi_attrib.default_irq = dev->irq;     /* Save IOAPIC IRQ */
> > > >     dev->irq = entry->irq;
> > > >
> > > >   pci_msi_shutdown
> > > >     /* Restore dev->irq to its default pin-assertion IRQ */
> > > >     dev->irq = desc->msi_attrib.default_irq;
> > > >
> > > > and for MSI-X we have:
> > > >
> > > >   msix_capability_init
> > > >     msix_setup_entries
> > > >       for (i = 0; i < nvec; i++)
> > > >         entry = alloc_msi_entry(1)
> > > >       entry->msi_attrib.default_irq = dev->irq;
> > > >
> > > >   pci_msix_shutdown
> > > >     for_each_pci_msi_entry(entry, dev)
> > > >       __pci_msix_desc_mask_irq
> > > > +   dev->irq = entry->msi_attrib.default_irq;   # added by this patch
> > > >
> > > >
> > > > Things that seem strange to me:
> > > >
> > > >   - The msi_setup_entry() comment "Save IOAPIC IRQ" seems needlessly
> > > >     specific; maybe it should be "INTx IRQ".
> > > >
> > > >   - The pci_msi_shutdown() comment "Restore ... pin-assertion IRQ"
> > > >     should match the msi_setup_entry() one, e.g., maybe it should also
> > > >     be "INTx IRQ".  There are no INTx or IOAPIC pins in PCIe.
> > > >
> > > >   - The only use of .default_irq is to save and restore dev->irq, so
> > > >     it looks like a per-device thing, not a per-vector thing.
> > > >
> > > >     In msi_setup_entry() there's only one msi_entry, so there's only
> > > >     one saved .default_irq.
> > > >
> > > >     In msix_setup_entries(), we get nvecs msi_entry structs, and we
> > > >     get a saved .default_irq in each one?
> > >
> > > That's a key point.
> > >
> > > Old-school PCI/MSI is represented by a single interrupt, and you
> > > *could* somehow make it relatively easy for drivers that only
> > > understand INTx to migrate to MSI if you replaced whatever is held in
> > > dev->irq (which should only represent the INTx mapping) with the MSI
> > > interrupt number. Which I guess is what the MSI code is doing.
> > >
> > > This is the 21st century, and nobody should ever rely on such horror,
> > > but I'm sure we do have such drivers in the tree. Boo.
> > >
> > > However, this *cannot* hold true for Multi-MSI, nor MSI-X, because
> > > there is a plurality of interrupts. Even worse, for MSI-X, there is
> > > zero guarantee that the allocated interrupts will be in a contiguous
> > > space.
> > >
> > > Given that, what is dev->irq good for? "Absolutely Nothing! (say it
> > > again!)".
> > >
> >
> > The only thing is that dev->irq is an sysfs ABI to userspace. Due to
> > the inconsistency
> > between legacy PCI INTx, MSI, MSI-X, this ABI should have been
> > absolutely broken nowadays.
> > This is actually what the patchset was originally aiming at to fix.
> >
> > One more question from me is that does dev->irq actually hold any
> > valid hardware INTx
> > information while hardware is using MSI-X? At least in my hardware,
> > sysfs ABI for PCI is all "0".
> >
> > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat irq
> > 0
> >
> > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# ls -l msi_irqs/*
> > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/499
> > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/500
> > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/501
> > ...
> > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat msi_irqs/499
> > msix
> >
> > Not quite sure how it is going on different hardware platforms.
> >
> > > MSI-X is not something you can "accidentally" use. You have to
> > > actively embrace it. In all honesty, this patch tries to move in the
> > > wrong direction. If anything, we should kill this hack altogether and
> > > fix the (handful of?) drivers that rely on it. That'd actually be a
> > > good way to find whether they are still worth keeping in the tree. And
> > > if it breaks too many of them, then at least we'll know where we
> > > stand.
> > >
> > > I'd be tempted to leave the below patch simmer in -next for a few
> > > weeks and see if how many people shout:
> >
> > This looks like a more proper direction to go.
> > but here i am wondering how sysfs ABI document should follow the below change
> > doc is patch 2/2:
> > https://lore.kernel.org/lkml/20210820223744.8439-3-21cnbao@gmail.com/
> >
> > On the other hand, my feeling is that nobody should depend on sysfs
> > irq entry nowadays.
> > For example, userspace irqbalance is actually using /sys/devices/.../msi_irqs/
> > So probably we should set this ABI invisible when devices are using
> > MSI or MSI-X?
> 
> i mean something like the below,
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d63df7..1323841 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -26,6 +26,7 @@
>  #include <linux/slab.h>
>  #include <linux/vgaarb.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/msi.h>
>  #include <linux/of.h>
>  #include "pci.h"
> 
> @@ -1437,6 +1438,16 @@ static umode_t pci_dev_attrs_are_visible(struct
> kobject *kobj,
>                 if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
>                         return 0;
> 
> +#ifdef CONFIG_PCI_MSI
> +       /*
> +        * if devices are MSI and MSI-X, IRQ sysfs ABI is meaningless
> +        * and broken
> +        */
> +       if (a == &dev_attr_irq.attr)
> +               if (first_pci_msi_entry(pdev))
> +                       return 0;
> +#endif
> +
>         return a->mode;
>  }

I think this idea has been discarded anyway, but sysfs doesn't work
this way.  The .is_visible() function is evaluated once at
device_add()-time, i.e., during enumeration, so there's no way to
dynamically change the visibility as the driver enables/disables
MSI.

I *wish* sysfs had more flexibility like this, though.
