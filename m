Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA173F73B6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 12:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239857AbhHYKw4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Aug 2021 06:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhHYKwz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Aug 2021 06:52:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3575AC061757;
        Wed, 25 Aug 2021 03:52:10 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so50666271ejz.1;
        Wed, 25 Aug 2021 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQyBKQGa/APr0EuMME7QLvFE7qildNz9bDcqbhQnrAM=;
        b=Vcp8cDlrNvdd7HoQRTutQQyaKknqMknjAJ5gmAfAGitQigk1WDfw6ACWC8AtHWqInh
         RNLMnF1F5FmZAvsxYE9/wsfu1jgJaUa41k83BXH8cV3DG85xofTYDCxfolvK09L4UIFe
         HdoeQqybcX8RD/zlPnOtvgaEw196xunYPtbQhT4XYbbpzccXUpCCaoycLO7yMqgTbKSN
         Ozt3/d8B0UmnRy2lRIPckbdOSgHLiP6CrlFzcWQIPFCiiIrGn6uIHV+6Rds7qyKzCUaa
         dkou/+/4BgB387bqffaiJDZvNRyqS+UeK9XfD9WfhXZk6yOOi8ukaJ6tlNmlD3X//byl
         22+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQyBKQGa/APr0EuMME7QLvFE7qildNz9bDcqbhQnrAM=;
        b=fsIqMu0juj69OHFPcnOKihjmmOIFIGd1470NkU32LVfRTvPnCGTWDbNXpiB9T/6J7b
         CVG9f16u9vgi046cwbVwIGyREi5swLTAVizc3Gp8LjsiDNlMMh732bvwMEvFsM6R4xIb
         gsijyuNBNNPW0fOKXShc4vFeqRCTuW696Hc9bbZWdQvr2Rziv7iX36YYvCLfKRRMHqER
         oBIrlXwRXhtQxArzBiCNPgAceF7yRhglzKwnULXkMaYMv/5avFXFt5on/I65Un6izdf1
         75/KzedyFCWtshmUVsWrhMnm+CFxYhrpsNpw6YkIFeAo+11o6awas79n7lKoFn1YkjnH
         wxzg==
X-Gm-Message-State: AOAM532gkrfbNfxjOe8IuEd7rHklDBQMiyGma+rdMJvtEhCFIswutNUt
        yN+X155nNRt+3B4CXZSDYAHzqxA5QTMLo/RnHYU=
X-Google-Smtp-Source: ABdhPJxdoyZ3Rg70ZcbJdp6/1zbF37IOXjbVAe7INY32+WiVgCEM1UM3BUb6xFhvE1CRxfNnzWa77EVpltO+3Qn9KhY=
X-Received: by 2002:a17:906:994f:: with SMTP id zm15mr5835958ejb.480.1629888728752;
 Wed, 25 Aug 2021 03:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210820223744.8439-2-21cnbao@gmail.com> <20210820233328.GA3368938@bjorn-Precision-5520>
 <877dgfqdsg.wl-maz@kernel.org> <CAGsJ_4ykAB4PMtno8Tv4QHH5Mruu5-CjVgbGx1N4gfcg0hYgqg@mail.gmail.com>
 <CAGsJ_4wRdm5ZhchTL4kG+f9-wahJBHUZm0-T3XexbL+Vkshw7w@mail.gmail.com> <87h7fdq0sq.wl-maz@kernel.org>
In-Reply-To: <87h7fdq0sq.wl-maz@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Wed, 25 Aug 2021 10:51:56 +1200
Message-ID: <CAGsJ_4wT9dTBE8rjyoTEhoLpP0mdCqcbcYQiF8JWx+D_73nFcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/MSI: Fix the confusing IRQ sysfs ABI for MSI-X
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Jonathan.Cameron@huawei.com,
        bilbao@vt.edu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        leon@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Linuxarm <linuxarm@huawei.com>,
        luzmaximilian@gmail.com, mchehab+huawei@kernel.org,
        schnelle@linux.ibm.com, Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 25, 2021 at 10:24 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 24 Aug 2021 22:29:59 +0100,
> Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Wed, Aug 25, 2021 at 8:51 AM Barry Song <21cnbao@gmail.com> wrote:
> > >
> > > On Sat, Aug 21, 2021 at 10:42 PM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > Hi Bjorn,
> > > >
> > > > On Sat, 21 Aug 2021 00:33:28 +0100,
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > >
> > > > > [+cc Thomas, Marc]
> > > > >
> > > > > On Sat, Aug 21, 2021 at 10:37:43AM +1200, Barry Song wrote:
> > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > >
> > > > > > /sys/bus/pci/devices/.../irq sysfs ABI is very confusing at this
> > > > > > moment especially for MSI-X cases.
> > > > >
> > > > > AFAICT this patch *only* affects MSI-X.  So are you saying the sysfs
> > > > > ABI is fine for MSI but confusing for MSI-X?
> > > > >
> > > > > > While MSI sets IRQ to the first
> > > > > > number in the vector, MSI-X does nothing for this though it saves
> > > > > > default_irq in msix_setup_entries(). Weird the saved default_irq
> > > > > > for MSI-X is never used in pci_msix_shutdown(), which is quite
> > > > > > different with pci_msi_shutdown(). Thus, this patch moves to show
> > > > > > the first IRQ number which is from the first msi_entry for MSI-X.
> > > > > > Hopefully, this can make IRQ ABI more clear and more consistent.
> > > > > >
> > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > ---
> > > > > >  drivers/pci/msi.c | 6 ++++++
> > > > > >  1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > > > index 9232255..6bbf81b 100644
> > > > > > --- a/drivers/pci/msi.c
> > > > > > +++ b/drivers/pci/msi.c
> > > > > > @@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > > > >     int ret;
> > > > > >     u16 control;
> > > > > >     void __iomem *base;
> > > > > > +   struct msi_desc *desc;
> > > > > >
> > > > > >     /* Ensure MSI-X is disabled while it is set up */
> > > > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> > > > > > @@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> > > > > >
> > > > > >     pcibios_free_irq(dev);
> > > > > > +
> > > > > > +   desc = first_pci_msi_entry(dev);
> > > > > > +   dev->irq = desc->irq;
> > > > >
> > > > > This change is not primarily about sysfs.  This is about changing
> > > > > "dev->irq" when MSI-X is enabled, and it's only incidental that sysfs
> > > > > reflects that.
> > > > >
> > > > > So we need to know the effect of changing dev->irq.  Drivers may use
> > > > > the value of dev->irq, and I'm *guessing* this change shouldn't break
> > > > > them since we already do this for MSI, but I'd like some more expert
> > > > > opinion than mine :)
> > > > >
> > > > > For MSI we have:
> > > > >
> > > > >   msi_capability_init
> > > > >     msi_setup_entry
> > > > >       entry = alloc_msi_entry(nvec)
> > > > >       entry->msi_attrib.default_irq = dev->irq;     /* Save IOAPIC IRQ */
> > > > >     dev->irq = entry->irq;
> > > > >
> > > > >   pci_msi_shutdown
> > > > >     /* Restore dev->irq to its default pin-assertion IRQ */
> > > > >     dev->irq = desc->msi_attrib.default_irq;
> > > > >
> > > > > and for MSI-X we have:
> > > > >
> > > > >   msix_capability_init
> > > > >     msix_setup_entries
> > > > >       for (i = 0; i < nvec; i++)
> > > > >         entry = alloc_msi_entry(1)
> > > > >       entry->msi_attrib.default_irq = dev->irq;
> > > > >
> > > > >   pci_msix_shutdown
> > > > >     for_each_pci_msi_entry(entry, dev)
> > > > >       __pci_msix_desc_mask_irq
> > > > > +   dev->irq = entry->msi_attrib.default_irq;   # added by this patch
> > > > >
> > > > >
> > > > > Things that seem strange to me:
> > > > >
> > > > >   - The msi_setup_entry() comment "Save IOAPIC IRQ" seems needlessly
> > > > >     specific; maybe it should be "INTx IRQ".
> > > > >
> > > > >   - The pci_msi_shutdown() comment "Restore ... pin-assertion IRQ"
> > > > >     should match the msi_setup_entry() one, e.g., maybe it should also
> > > > >     be "INTx IRQ".  There are no INTx or IOAPIC pins in PCIe.
> > > > >
> > > > >   - The only use of .default_irq is to save and restore dev->irq, so
> > > > >     it looks like a per-device thing, not a per-vector thing.
> > > > >
> > > > >     In msi_setup_entry() there's only one msi_entry, so there's only
> > > > >     one saved .default_irq.
> > > > >
> > > > >     In msix_setup_entries(), we get nvecs msi_entry structs, and we
> > > > >     get a saved .default_irq in each one?
> > > >
> > > > That's a key point.
> > > >
> > > > Old-school PCI/MSI is represented by a single interrupt, and you
> > > > *could* somehow make it relatively easy for drivers that only
> > > > understand INTx to migrate to MSI if you replaced whatever is held in
> > > > dev->irq (which should only represent the INTx mapping) with the MSI
> > > > interrupt number. Which I guess is what the MSI code is doing.
> > > >
> > > > This is the 21st century, and nobody should ever rely on such horror,
> > > > but I'm sure we do have such drivers in the tree. Boo.
> > > >
> > > > However, this *cannot* hold true for Multi-MSI, nor MSI-X, because
> > > > there is a plurality of interrupts. Even worse, for MSI-X, there is
> > > > zero guarantee that the allocated interrupts will be in a contiguous
> > > > space.
> > > >
> > > > Given that, what is dev->irq good for? "Absolutely Nothing! (say it
> > > > again!)".
> > > >
> > > > MSI-X is not something you can "accidentally" use. You have to
> > > > actively embrace it. In all honesty, this patch tries to move in the
> > > > wrong direction. If anything, we should kill this hack altogether and
> > > > fix the (handful of?) drivers that rely on it. That'd actually be a
> > > > good way to find whether they are still worth keeping in the tree. And
> > > > if it breaks too many of them, then at least we'll know where we
> > > > stand.
> > > >
> > > > I'd be tempted to leave the below patch simmer in -next for a few
> > > > weeks and see if how many people shout:
> > > >
> > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > index e5e75331b415..2be9a01cbe72 100644
> > > > --- a/drivers/pci/msi.c
> > > > +++ b/drivers/pci/msi.c
> > > > @@ -591,7 +591,6 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
> > > >         entry->msi_attrib.is_virtual    = 0;
> > > >         entry->msi_attrib.entry_nr      = 0;
> > > >         entry->msi_attrib.maskbit       = !!(control & PCI_MSI_FLAGS_MASKBIT);
> > > > -       entry->msi_attrib.default_irq   = dev->irq;     /* Save IOAPIC IRQ */
> > > >         entry->msi_attrib.multi_cap     = (control & PCI_MSI_FLAGS_QMASK) >> 1;
> > > >         entry->msi_attrib.multiple      = ilog2(__roundup_pow_of_two(nvec));
> > > >
> > > > @@ -682,7 +681,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
> > > >         dev->msi_enabled = 1;
> > > >
> > > >         pcibios_free_irq(dev);
> > > > -       dev->irq = entry->irq;
> > > >         return 0;
> > > >  }
> > > >
> > > > @@ -742,7 +740,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
> > > >                 entry->msi_attrib.is_virtual =
> > > >                         entry->msi_attrib.entry_nr >= vec_count;
> > > >
> > > > -               entry->msi_attrib.default_irq   = dev->irq;
> > > >                 entry->mask_base                = base;
> > > >
> > > >                 addr = pci_msix_desc_addr(entry);
> > > > @@ -964,8 +961,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
> > > >         mask = msi_mask(desc->msi_attrib.multi_cap);
> > > >         msi_mask_irq(desc, mask, 0);
> > > >
> > > > -       /* Restore dev->irq to its default pin-assertion IRQ */
> > > > -       dev->irq = desc->msi_attrib.default_irq;
> > > >         pcibios_alloc_irq(dev);
> > > >  }
> > > >
> > > > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > > > index e8bdcb83172b..a631664c1c38 100644
> > > > --- a/include/linux/msi.h
> > > > +++ b/include/linux/msi.h
> > > > @@ -114,7 +114,6 @@ struct ti_sci_inta_msi_desc {
> > > >   * @maskbit:   [PCI MSI/X] Mask-Pending bit supported?
> > > >   * @is_64:     [PCI MSI/X] Address size: 0=32bit 1=64bit
> > > >   * @entry_nr:  [PCI MSI/X] Entry which is described by this descriptor
> > > > - * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
> > > >   * @mask_pos:  [PCI MSI]   Mask register position
> > > >   * @mask_base: [PCI MSI-X] Mask register base address
> > > >   * @platform:  [platform]  Platform device specific msi descriptor data
> > > > @@ -148,7 +147,6 @@ struct msi_desc {
> > > >                                 u8      is_64           : 1;
> > > >                                 u8      is_virtual      : 1;
> > > >                                 u16     entry_nr;
> > > > -                               unsigned default_irq;
> > > >                         } msi_attrib;
> > > >                         union {
> > > >                                 u8      mask_pos;
> > > >
> > >
> > > We will also need the below change as  pci_irq_vector() depends on
> > > dev->irq for the MSI case.
> > >
> > > int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
> > > {
> > >         if (dev->msix_enabled) {
> > >                 struct msi_desc *entry;
> > >                 int i = 0;
> > >
> > >                 for_each_pci_msi_entry(entry, dev) {
> > >                         if (i == nr)
> > >                                 return entry->irq;
> > >                         i++;
> > >                 }
> > >                 WARN_ON_ONCE(1);
> > >                 return -EINVAL;
> > >         }
> > >
> > >         if (dev->msi_enabled) {
> > >                 struct msi_desc *entry = first_pci_msi_entry(dev);
> > >
> > >                 if (WARN_ON_ONCE(nr >= entry->nvec_used))
> > >                         return -EINVAL;
> > >
> > > +                return entry->irq + nr;
> > >         } else {
> > >                 if (WARN_ON_ONCE(nr > 0))
> > >                         return -EINVAL;
> > >         }
> > >
> > >
> > > -        return dev->irq + nr;
> > > +       return dev->irq;
> > > }
> > > EXPORT_SYMBOL(pci_irq_vector);
> > >
> >
> > And here:
> >
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -401,7 +401,7 @@ static void __pci_restore_msi_state(struct pci_dev *dev)
> >         if (!dev->msi_enabled)
> >                 return;
> >
> > -       entry = irq_get_msi_desc(dev->irq);
> > +       entry = first_pci_msi_entry(dev);
> >
> >         pci_intx_for_msi(dev, 0);
> >         pci_msi_set_enable(dev, 0);
> >
> > since drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c is the only
> > one calling pci_restore_msi_state(), will probably require one test
> > from the driver maintainers.
>
> All good catches. This needs tons of testing, and I fully expect
> regressions (at least drivers falling back to INTx when they were
> planning to use MSIs).
>
> I'll try to roll a proper patch once 5.14 is out.

Thanks! Anyway, I've integrated all good suggestions from the
discussion into v3:
https://lore.kernel.org/lkml/20210825102636.52757-1-21cnbao@gmail.com/
So that we can have a new base to start after 5.14 is out.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks
barry
