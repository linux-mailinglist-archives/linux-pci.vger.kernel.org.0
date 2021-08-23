Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15C53F537C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Aug 2021 00:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHWWrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 18:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbhHWWry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 18:47:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3FBC061575;
        Mon, 23 Aug 2021 15:47:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dm15so3572895edb.10;
        Mon, 23 Aug 2021 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYo1K3XjqtElxfVWVu9/AbcBaa+SeNj5BCofmM36uYI=;
        b=aL5R+GnDO0UuyhKqiEVQLgQ6GJEIdAFyfvO509MZHeqCA/2/LYJBmZhczmvNPlEZj8
         /CscKqNwKYMaLNJQi9BK50q+W9Tj9v0xyd2s0F1pLz/OF2K6/9NMeyUUmE9hx3w8jRsr
         YobnxLOzXe428qEqF/C9BiqJbX9z31M20SkevVyplouCcBSN4W/T8kJUKLvwazQhK4nK
         3XWCBmPUoW8y9Pljb2rrGw9x/Ohm1b0YA1YbcjKgLa8gv0IVzpqp+aiNlhNgWXlNsF9y
         QLkt9yYvAeBEwCNkj+vH1jpKJKy1iyHVUdyKUo0uXpfvhGwkW6s2HCN6qXV1NQFuk/nk
         884g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYo1K3XjqtElxfVWVu9/AbcBaa+SeNj5BCofmM36uYI=;
        b=lfuElHfPhQ4ezYwIEfkjVafyB3UsfYCkkZj/F3brd3GgF3KZBVvPP2JmwqPYdhPDJo
         qmxJwOQHd78o4SiJZOUiHCCBHL/029s4Kl+dxNmqdkXxgw/PLSXFDuV+5+yJvKAgdd9s
         oBl9WANN2409Nkj2LSnsoGrELpCK/fCOuiEtJ6aYVwLN7HKPx7HSwhwDjxAcNyGms6z6
         Kx0tbhLPULC4lLR1wdxR5JPPI4Gh3IcLoyANTcFfu4iI2Pdc3zgHTKkgNZq4S4OFGbC/
         +pepGk6MDNmexr1uQKUvwtRj3/sDxATgXMRAXsIByOGDecglmWxnMVshPPDgy9Toj9t8
         fPvQ==
X-Gm-Message-State: AOAM5311pgGmU9A4wFxP8YtzrIGuqmJUW70/HSqaNw13Z9m7eBAXvpDm
        2UY3wiNIJRI97k79jbJ47HYvtRABPlvyaNNEksc=
X-Google-Smtp-Source: ABdhPJwE3AgQPNP4KGKRo/h39HBcywMKbwEuEudKmGWSxjGbTqqXopmLluOgU1nrqRmkbLIxhDSpkXweJx5IhAJgGA8=
X-Received: by 2002:a05:6402:31f2:: with SMTP id dy18mr40190691edb.267.1629758830039;
 Mon, 23 Aug 2021 15:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210820223744.8439-2-21cnbao@gmail.com> <20210820233328.GA3368938@bjorn-Precision-5520>
 <877dgfqdsg.wl-maz@kernel.org> <CAGsJ_4wXqnudVO92qSKLdyJaMNuDE-d0srs=4rgJmOQKcG2P3g@mail.gmail.com>
 <87a6l8qwql.wl-maz@kernel.org> <CAGsJ_4yBa3EHz8-gR90SXZxju5E+Zh0NwOp8LErqhewgUOAfbg@mail.gmail.com>
 <877dgcqu29.wl-maz@kernel.org>
In-Reply-To: <877dgcqu29.wl-maz@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Tue, 24 Aug 2021 10:46:59 +1200
Message-ID: <CAGsJ_4zceLLBk1K_9Bmiju54CvGYySoEN4Kgy4yATst_E9c68A@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 11:28 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 23 Aug 2021 12:03:08 +0100,
> Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Mon, Aug 23, 2021 at 10:30 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Sat, 21 Aug 2021 23:14:35 +0100,
> > > Barry Song <21cnbao@gmail.com> wrote:
> > > >
> > > > On Sat, Aug 21, 2021 at 10:42 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > Hi Bjorn,
> > > > >
> > > > > On Sat, 21 Aug 2021 00:33:28 +0100,
> > > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > >
> > >
> > > [...]
> > >
> > > > > >     In msix_setup_entries(), we get nvecs msi_entry structs, and we
> > > > > >     get a saved .default_irq in each one?
> > > > >
> > > > > That's a key point.
> > > > >
> > > > > Old-school PCI/MSI is represented by a single interrupt, and you
> > > > > *could* somehow make it relatively easy for drivers that only
> > > > > understand INTx to migrate to MSI if you replaced whatever is held in
> > > > > dev->irq (which should only represent the INTx mapping) with the MSI
> > > > > interrupt number. Which I guess is what the MSI code is doing.
> > > > >
> > > > > This is the 21st century, and nobody should ever rely on such horror,
> > > > > but I'm sure we do have such drivers in the tree. Boo.
> > > > >
> > > > > However, this *cannot* hold true for Multi-MSI, nor MSI-X, because
> > > > > there is a plurality of interrupts. Even worse, for MSI-X, there is
> > > > > zero guarantee that the allocated interrupts will be in a contiguous
> > > > > space.
> > > > >
> > > > > Given that, what is dev->irq good for? "Absolutely Nothing! (say it
> > > > > again!)".
> > > > >
> > > >
> > > > The only thing is that dev->irq is an sysfs ABI to userspace. Due to
> > > > the inconsistency between legacy PCI INTx, MSI, MSI-X, this ABI
> > > > should have been absolutely broken nowadays.  This is actually what
> > > > the patchset was originally aiming at to fix.
> > >
> > > I do not think we should expose more of a broken abstraction to
> > > userspace. We will have to carry on exposing the first MSI in this
> > > field forever, but it doesn't mean we should have to do it for MSI-X.
> > >
> > > > One more question from me is that does dev->irq actually hold any
> > > > valid hardware INTx information while hardware is using MSI-X? At
> > > > least in my hardware, sysfs ABI for PCI is all "0".
> > >
> > > That's probably because nothing actually configured the interrupt, or
> > > that there is no INTx implementation. I have that on systems with
> > > pretty dodgy (or incomplete) firmware.
> > >
> > > > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat irq
> > > > 0
> > > >
> > > > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# ls -l msi_irqs/*
> > > > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/499
> > > > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/500
> > > > -r--r--r-- 1 root root 4096 Aug 21 22:04 msi_irqs/501
> > > > ...
> > > > root@ubuntu:/sys/devices/pci0000:7c/0000:7c:00.0/0000:7d:00.3# cat msi_irqs/499
> > > > msix
> > > >
> > > > Not quite sure how it is going on different hardware platforms.
> > >
> > > My D05 does that as well, and it doesn't expose any INTx support.
> > >
> > > >
> > > > > MSI-X is not something you can "accidentally" use. You have to
> > > > > actively embrace it. In all honesty, this patch tries to move in the
> > > > > wrong direction. If anything, we should kill this hack altogether and
> > > > > fix the (handful of?) drivers that rely on it. That'd actually be a
> > > > > good way to find whether they are still worth keeping in the tree. And
> > > > > if it breaks too many of them, then at least we'll know where we
> > > > > stand.
> > > > >
> > > > > I'd be tempted to leave the below patch simmer in -next for a few
> > > > > weeks and see if how many people shout:
> > > >
> > > > This looks like a more proper direction to go.
> > > > but here i am wondering how sysfs ABI document should follow the below change
> > > > doc is patch 2/2:
> > > > https://lore.kernel.org/lkml/20210820223744.8439-3-21cnbao@gmail.com/
> > > >
> > > > On the other hand, my feeling is that nobody should depend on sysfs
> > > > irq entry nowadays.
> > >
> > > Too late. It is there, and we need to preserve it. I just don't think
> > > feeding it more erroneous information is the right thing to do.
> > >
> > > My patch was only dealing with the kernel side of things, not the
> > > userspace ABI. That ABI should be carried on unchanged.
> >
> > it seems this isn't true. your patch is also changing userspace ABI
> > as long as you change pci_dev->irq which will be shown in sysfs irq
> > entry.
>
> I guess I wasn't clear enough above. Let me rephrase this:
>
> My patch was only dealing with the kernel side of things, not the
> userspace ABI. That ABI should be carried on unchanged, which requires
> additional changes in the sysfs code.

Thanks for clarification. It seems you mean something like below, am I right?

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d63df7..0fa7a16 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/vgaarb.h>
 #include <linux/pm_runtime.h>
+#include <linux/msi.h>
 #include <linux/of.h>
 #include "pci.h"

@@ -49,7 +50,23 @@ static DEVICE_ATTR_RO(field)
 pci_config_attr(subsystem_device, "0x%04x\n");
 pci_config_attr(revision, "0x%02x\n");
 pci_config_attr(class, "0x%06x\n");
-pci_config_attr(irq, "%u\n");
+
+static ssize_t irq_show(struct device *dev,
+                                        struct device_attribute *attr,
+                                        char *buf)
+{
+       struct pci_dev *pdev = to_pci_dev(dev);
+#ifdef CONFIG_PCI_MSI
+       struct msi_desc *desc = first_pci_msi_entry(pdev);
+
+       /* for MSI, return the 1st IRQ in IRQ vector */
+       if (desc && !desc->msi_attrib.is_msix)
+               return sysfs_emit(buf, "%u\n", desc->irq);
+#endif
+
+       return sysfs_emit(buf, "%u\n", pdev->irq);
+}
+static DEVICE_ATTR_RO(irq);

 static ssize_t broken_parity_status_show(struct device *dev,
                                         struct device_attribute *attr,


>
> > if we don't want to change the behaviour of any existing ABI, it
> > seems the only thing we can do here to document it well in ABI
> > doc. i actually doubt anyone has really understood what the irq
> > entry is really showing.
>
> Given that we can't prove that it is actually the case, I believe this
> is the only option.

we have to document the ABI like below though it seems quite annoying.

1. for devices which don't support MSI and MSI-X, show legacy INTx
2. for devices which support MSI
    a. if CONFIG_PCI_MSI is not enabled,  show legacy INTx
    b. if CONFIG_PCI_MSI is enabled and devices are using MSI at this
moment, show 1st IRQ in the vector
    c. if CONFIG_PCI_MSI is enabled, but we shutdown its MSI before
the users call sysfs entry,
        so at this moment, devices are not using MSI,  show legacy INTx
3. for devices which support MSI-X, no matter if it is using MSI-X,
    show legacy INTx
4. In Addition, INTx might be broken due to incomplete firmware or
hardware design for MSI and MSI-X cases

To be honest, it sounds like a disaster :-) but if this is what we
have to do, I'd like to try it in v3.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks
Barry
