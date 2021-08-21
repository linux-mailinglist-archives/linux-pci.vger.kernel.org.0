Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E063F3CA8
	for <lists+linux-pci@lfdr.de>; Sun, 22 Aug 2021 00:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhHUWmL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 21 Aug 2021 18:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhHUWmK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 21 Aug 2021 18:42:10 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EBBC061575;
        Sat, 21 Aug 2021 15:41:30 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e21so12095598ejz.12;
        Sat, 21 Aug 2021 15:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NeXPl9zQpfJwronKzyMZwgLmEqdeiAzrkZ4NxDbeH5E=;
        b=TeQSmFPX9MG4zdGKOFpPtGPB3kIRqXtcFoQ/vKHlvxJa7cyFBCsa0/2yKUVPwHebfy
         UZXKCyv3qW8JVRzjwmu7VgaJ6dZhte5JGMSIWNF3tLeVUlDICRyabXJt+TXlTdZuHUSe
         v1MmNYG0qsb99bwgp79ht6of0LaosewcX86aqVjbpomVrufuqKC6CqHTUTsPfDAkKvAE
         2glO3YVxxUGYWNAbU3xhK+i3+BM+UJ8boUqX3nqXU/JzzfNhf0bNaqkdUISGEwcwngFX
         ewdQR+imKWMatWjddP1R7prYtoLLv7sRLdyA6QSwYuYo6iOsqvMrDoNKefSSq6/ZV0/f
         cPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NeXPl9zQpfJwronKzyMZwgLmEqdeiAzrkZ4NxDbeH5E=;
        b=SZkRmmnx47A+l7s0VDrSNXuL5QJQIO2toFWkXTh4RZiorzakSpkUPdMEzaKgo4vjuV
         7sM46LaVZQ6R3Kdb4GvFWzXW9zxaDJoQHxIev2ePQ0SZAG0jJ8s8opAChK0BKsTs0Raz
         DXVk5D0vVl7LxRUupAX6TXsSFuy1jjnZL1ly1FDuZubevPW5oV1hSR0R721c+RBEp9Ak
         YVHeBVqHiSgEb4TmCIiJUM12NI7edp64v4N9lJxLuYlyihpkVdpeCXpzXLSgHZCFqA1n
         4FdHZA0ba4usUtuhfH/4sVR1AJhxJ7hjteDcp2fKET57GrS6XvU24F3cBx0af+PX+HLn
         BEcQ==
X-Gm-Message-State: AOAM531Zi2Q+ZF+Hq0oORRvn7WcuJ6bJRW6D9LzLMqF7WTTUP629Lo0W
        fDwZH4yB2INGI4dy6dIV5RDXlxacfBIoLsuESlU=
X-Google-Smtp-Source: ABdhPJw+jTx+QVPXpdyusGR9sHGpNOxpsb3s7vHeUSHjBKcDKgdjbwoOhPz1XU2FfG7Y6pfQF8IXwKRKViGFZoyG9OA=
X-Received: by 2002:a17:906:11c7:: with SMTP id o7mr28494376eja.480.1629585689188;
 Sat, 21 Aug 2021 15:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210820223744.8439-2-21cnbao@gmail.com> <20210820233328.GA3368938@bjorn-Precision-5520>
 <877dgfqdsg.wl-maz@kernel.org> <CAGsJ_4wXqnudVO92qSKLdyJaMNuDE-d0srs=4rgJmOQKcG2P3g@mail.gmail.com>
In-Reply-To: <CAGsJ_4wXqnudVO92qSKLdyJaMNuDE-d0srs=4rgJmOQKcG2P3g@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 22 Aug 2021 10:41:17 +1200
Message-ID: <CAGsJ_4w35+mRE_qp117HhNOaHeUN1cO6GGPW36qtjaX6wUcQNA@mail.gmail.com>
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

On Sun, Aug 22, 2021 at 10:14 AM Barry Song <21cnbao@gmail.com> wrote:
>
> On Sat, Aug 21, 2021 at 10:42 PM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi Bjorn,
> >
> > On Sat, 21 Aug 2021 00:33:28 +0100,
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > [+cc Thomas, Marc]
> > >
> > > On Sat, Aug 21, 2021 at 10:37:43AM +1200, Barry Song wrote:
> > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > >
> > > > /sys/bus/pci/devices/.../irq sysfs ABI is very confusing at this
> > > > moment especially for MSI-X cases.
> > >
> > > AFAICT this patch *only* affects MSI-X.  So are you saying the sysfs
> > > ABI is fine for MSI but confusing for MSI-X?
> > >
> > > > While MSI sets IRQ to the first
> > > > number in the vector, MSI-X does nothing for this though it saves
> > > > default_irq in msix_setup_entries(). Weird the saved default_irq
> > > > for MSI-X is never used in pci_msix_shutdown(), which is quite
> > > > different with pci_msi_shutdown(). Thus, this patch moves to show
> > > > the first IRQ number which is from the first msi_entry for MSI-X.
> > > > Hopefully, this can make IRQ ABI more clear and more consistent.
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > > > ---
> > > >  drivers/pci/msi.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > > > index 9232255..6bbf81b 100644
> > > > --- a/drivers/pci/msi.c
> > > > +++ b/drivers/pci/msi.c
> > > > @@ -771,6 +771,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > >     int ret;
> > > >     u16 control;
> > > >     void __iomem *base;
> > > > +   struct msi_desc *desc;
> > > >
> > > >     /* Ensure MSI-X is disabled while it is set up */
> > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_ENABLE, 0);
> > > > @@ -814,6 +815,10 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
> > > >     pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
> > > >
> > > >     pcibios_free_irq(dev);
> > > > +
> > > > +   desc = first_pci_msi_entry(dev);
> > > > +   dev->irq = desc->irq;
> > >
> > > This change is not primarily about sysfs.  This is about changing
> > > "dev->irq" when MSI-X is enabled, and it's only incidental that sysfs
> > > reflects that.
> > >
> > > So we need to know the effect of changing dev->irq.  Drivers may use
> > > the value of dev->irq, and I'm *guessing* this change shouldn't break
> > > them since we already do this for MSI, but I'd like some more expert
> > > opinion than mine :)
> > >
> > > For MSI we have:
> > >
> > >   msi_capability_init
> > >     msi_setup_entry
> > >       entry = alloc_msi_entry(nvec)
> > >       entry->msi_attrib.default_irq = dev->irq;     /* Save IOAPIC IRQ */
> > >     dev->irq = entry->irq;
> > >
> > >   pci_msi_shutdown
> > >     /* Restore dev->irq to its default pin-assertion IRQ */
> > >     dev->irq = desc->msi_attrib.default_irq;
> > >
> > > and for MSI-X we have:
> > >
> > >   msix_capability_init
> > >     msix_setup_entries
> > >       for (i = 0; i < nvec; i++)
> > >         entry = alloc_msi_entry(1)
> > >       entry->msi_attrib.default_irq = dev->irq;
> > >
> > >   pci_msix_shutdown
> > >     for_each_pci_msi_entry(entry, dev)
> > >       __pci_msix_desc_mask_irq
> > > +   dev->irq = entry->msi_attrib.default_irq;   # added by this patch
> > >
> > >
> > > Things that seem strange to me:
> > >
> > >   - The msi_setup_entry() comment "Save IOAPIC IRQ" seems needlessly
> > >     specific; maybe it should be "INTx IRQ".
> > >
> > >   - The pci_msi_shutdown() comment "Restore ... pin-assertion IRQ"
> > >     should match the msi_setup_entry() one, e.g., maybe it should also
> > >     be "INTx IRQ".  There are no INTx or IOAPIC pins in PCIe.
> > >
> > >   - The only use of .default_irq is to save and restore dev->irq, so
> > >     it looks like a per-device thing, not a per-vector thing.
> > >
> > >     In msi_setup_entry() there's only one msi_entry, so there's only
> > >     one saved .default_irq.
> > >
> > >     In msix_setup_entries(), we get nvecs msi_entry structs, and we
> > >     get a saved .default_irq in each one?
> >
> > That's a key point.
> >
> > Old-school PCI/MSI is represented by a single interrupt, and you
> > *could* somehow make it relatively easy for drivers that only
> > understand INTx to migrate to MSI if you replaced whatever is held in
> > dev->irq (which should only represent the INTx mapping) with the MSI
> > interrupt number. Which I guess is what the MSI code is doing.
> >
> > This is the 21st century, and nobody should ever rely on such horror,
> > but I'm sure we do have such drivers in the tree. Boo.
> >
> > However, this *cannot* hold true for Multi-MSI, nor MSI-X, because
> > there is a plurality of interrupts. Even worse, for MSI-X, there is
> > zero guarantee that the allocated interrupts will be in a contiguous
> > space.
> >
> > Given that, what is dev->irq good for? "Absolutely Nothing! (say it
> > again!)".
> >
>
> The only thing is that dev->irq is an sysfs ABI to userspace. Due to
> the inconsistency
> between legacy PCI INTx, MSI, MSI-X, this ABI should have been
> absolutely broken nowadays.
> This is actually what the patchset was originally aiming at to fix.
>
> One more question from me is that does dev->irq actually hold any
> valid hardware INTx
> information while hardware is using MSI-X? At least in my hardware,
> sysfs ABI for PCI is all "0".
>
> root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat irq
> 0
>
> root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# ls -l msi_irqs/*
> -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/499
> -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/500
> -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/501
> ...
> root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat msi_irqs/499
> msix
>
> Not quite sure how it is going on different hardware platforms.
>
> > MSI-X is not something you can "accidentally" use. You have to
> > actively embrace it. In all honesty, this patch tries to move in the
> > wrong direction. If anything, we should kill this hack altogether and
> > fix the (handful of?) drivers that rely on it. That'd actually be a
> > good way to find whether they are still worth keeping in the tree. And
> > if it breaks too many of them, then at least we'll know where we
> > stand.
> >
> > I'd be tempted to leave the below patch simmer in -next for a few
> > weeks and see if how many people shout:
>
> This looks like a more proper direction to go.
> but here i am wondering how sysfs ABI document should follow the below change
> doc is patch 2/2:
> https://lore.kernel.org/lkml/20210820223744.8439-3-21cnbao@gmail.com/
>
> On the other hand, my feeling is that nobody should depend on sysfs
> irq entry nowadays.
> For example, userspace irqbalance is actually using /sys/devices/.../msi_irqs/
> So probably we should set this ABI invisible when devices are using
> MSI or MSI-X?

i mean something like the below,

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7..1323841 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
 #include <linux/pm_runtime.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include "pci.h"

@@ -1437,6 +1438,16 @@ static umode_t pci_dev_attrs_are_visible(struct
kobject *kobj,
                if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)
                        return 0;

+#ifdef CONFIG_PCI_MSI
+       /*
+        * if devices are MSI and MSI-X, IRQ sysfs ABI is meaningless
+        * and broken
+        */
+       if (a == &dev_attr_irq.attr)
+               if (first_pci_msi_entry(pdev))
+                       return 0;
+#endif
+
        return a->mode;
 }

>
> >
> > diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> > index e5e75331b415..2be9a01cbe72 100644
> > --- a/drivers/pci/msi.c
> > +++ b/drivers/pci/msi.c
> > @@ -591,7 +591,6 @@ msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
> >         entry->msi_attrib.is_virtual    = 0;
> >         entry->msi_attrib.entry_nr      = 0;
> >         entry->msi_attrib.maskbit       = !!(control & PCI_MSI_FLAGS_MASKBIT);
> > -       entry->msi_attrib.default_irq   = dev->irq;     /* Save IOAPIC IRQ */
> >         entry->msi_attrib.multi_cap     = (control & PCI_MSI_FLAGS_QMASK) >> 1;
> >         entry->msi_attrib.multiple      = ilog2(__roundup_pow_of_two(nvec));
> >
> > @@ -682,7 +681,6 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
> >         dev->msi_enabled = 1;
> >
> >         pcibios_free_irq(dev);
> > -       dev->irq = entry->irq;
> >         return 0;
> >  }
> >
> > @@ -742,7 +740,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
> >                 entry->msi_attrib.is_virtual =
> >                         entry->msi_attrib.entry_nr >= vec_count;
> >
> > -               entry->msi_attrib.default_irq   = dev->irq;
> >                 entry->mask_base                = base;
> >
> >                 addr = pci_msix_desc_addr(entry);
> > @@ -964,8 +961,6 @@ static void pci_msi_shutdown(struct pci_dev *dev)
> >         mask = msi_mask(desc->msi_attrib.multi_cap);
> >         msi_mask_irq(desc, mask, 0);
> >
> > -       /* Restore dev->irq to its default pin-assertion IRQ */
> > -       dev->irq = desc->msi_attrib.default_irq;
> >         pcibios_alloc_irq(dev);
> >  }
> >
> > diff --git a/include/linux/msi.h b/include/linux/msi.h
> > index e8bdcb83172b..a631664c1c38 100644
> > --- a/include/linux/msi.h
> > +++ b/include/linux/msi.h
> > @@ -114,7 +114,6 @@ struct ti_sci_inta_msi_desc {
> >   * @maskbit:   [PCI MSI/X] Mask-Pending bit supported?
> >   * @is_64:     [PCI MSI/X] Address size: 0=32bit 1=64bit
> >   * @entry_nr:  [PCI MSI/X] Entry which is described by this descriptor
> > - * @default_irq:[PCI MSI/X] The default pre-assigned non-MSI irq
> >   * @mask_pos:  [PCI MSI]   Mask register position
> >   * @mask_base: [PCI MSI-X] Mask register base address
> >   * @platform:  [platform]  Platform device specific msi descriptor data
> > @@ -148,7 +147,6 @@ struct msi_desc {
> >                                 u8      is_64           : 1;
> >                                 u8      is_virtual      : 1;
> >                                 u16     entry_nr;
> > -                               unsigned default_irq;
> >                         } msi_attrib;
> >                         union {
> >                                 u8      mask_pos;
> >
> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
>

Thanks
barry
