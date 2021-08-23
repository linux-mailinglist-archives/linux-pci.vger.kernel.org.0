Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C24D3F4951
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 13:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbhHWLEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 07:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbhHWLED (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Aug 2021 07:04:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C50C061757;
        Mon, 23 Aug 2021 04:03:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w5so36149205ejq.2;
        Mon, 23 Aug 2021 04:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asdxMwFwjcHBHfBIYaM1rOShhKCYBJkGzPMgQPKI2bg=;
        b=pJ8xs3Qx7Ld5eQthGtxRvdF8DLPXId27jGSYnBtimFF4Z5bltk55+mk7mYDCF38REp
         Utf37DOh9T/EcAXt6Vqw94UBATMjRNtE9Zb7fD7SsBQz/7Wyk7Qj0xqG8+M0BE7+RQ+r
         vhXC4gtm0vXoG9VAjNZ2dC+Vpg+ZR81sdTpFNfIJuEJsbhNdmmjjOcjAMZg3mnMf5vVw
         k6wKGkL9dcj5Heuu1jkBgt0aiD+XYCEWBnk1W8k8AN2fD4iljKmJhxO4hC4Zm2o9TLc/
         jpn6guzTbkgJBAtak7JzBJBFfG6IuefhdXTLXELmNTa2ul2mrj+JrNAA7CRhNT22kyVh
         SvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asdxMwFwjcHBHfBIYaM1rOShhKCYBJkGzPMgQPKI2bg=;
        b=gLLVyrW9HF05BIkJMiH+Lgl9BtbI8NlcMu9ZvtkIgALWTxMTPPU+Fqe+wUeO3URrMP
         500X/Ujg59+KDio6zLThjm7+sWkkcmbQLD53W/l7nGAMe6hPR4z3H9vdVJesOzpRZsuL
         6Y62KFyAh5ZBXc8+4rF4uCgGdsPL7i97dHZxLNZaCINV9PWc4cYVjxt6jNHi/izjhuYO
         1I8yEEVSioobCJWaiYcg6Zdm41+yAL1qAfbeVjkdfU4/Qri/7whm/DgpX5WODIG2sNX7
         gR1LEArKCkr+y4GSzgxNCWtm0aYXxLFZzGt5zuchx96oLNvCxorCbYC7PcaUtNxECA01
         cDJQ==
X-Gm-Message-State: AOAM532BmLya3wlDS6gVGgMVVvgVEsDii3YH9soXHpyymiM1L37CXk6H
        vepHEPhP80s7Io8TVP8fhHi9eFR3gaIJuVgoL7Q=
X-Google-Smtp-Source: ABdhPJzOIO2jwR98Ak3NJhGf4Z/BhYbBNwvuwA6CXLt+GNiE6hYMFqlt1hsYph8opKfD9oRKQNxmFia5D5cmuOlvdb0=
X-Received: by 2002:a17:906:b14d:: with SMTP id bt13mr3275151ejb.39.1629716599555;
 Mon, 23 Aug 2021 04:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210820223744.8439-2-21cnbao@gmail.com> <20210820233328.GA3368938@bjorn-Precision-5520>
 <877dgfqdsg.wl-maz@kernel.org> <CAGsJ_4wXqnudVO92qSKLdyJaMNuDE-d0srs=4rgJmOQKcG2P3g@mail.gmail.com>
 <87a6l8qwql.wl-maz@kernel.org>
In-Reply-To: <87a6l8qwql.wl-maz@kernel.org>
From:   Barry Song <21cnbao@gmail.com>
Date:   Mon, 23 Aug 2021 23:03:08 +1200
Message-ID: <CAGsJ_4yBa3EHz8-gR90SXZxju5E+Zh0NwOp8LErqhewgUOAfbg@mail.gmail.com>
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

On Mon, Aug 23, 2021 at 10:30 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 21 Aug 2021 23:14:35 +0100,
> Barry Song <21cnbao@gmail.com> wrote:
> >
> > On Sat, Aug 21, 2021 at 10:42 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Hi Bjorn,
> > >
> > > On Sat, 21 Aug 2021 00:33:28 +0100,
> > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
>
> [...]
>
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
> > the inconsistency between legacy PCI INTx, MSI, MSI-X, this ABI
> > should have been absolutely broken nowadays.  This is actually what
> > the patchset was originally aiming at to fix.
>
> I do not think we should expose more of a broken abstraction to
> userspace. We will have to carry on exposing the first MSI in this
> field forever, but it doesn't mean we should have to do it for MSI-X.
>
> > One more question from me is that does dev->irq actually hold any
> > valid hardware INTx information while hardware is using MSI-X? At
> > least in my hardware, sysfs ABI for PCI is all "0".
>
> That's probably because nothing actually configured the interrupt, or
> that there is no INTx implementation. I have that on systems with
> pretty dodgy (or incomplete) firmware.
>
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
>
> My D05 does that as well, and it doesn't expose any INTx support.
>
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
>
> Too late. It is there, and we need to preserve it. I just don't think
> feeding it more erroneous information is the right thing to do.
>
> My patch was only dealing with the kernel side of things, not the
> userspace ABI. That ABI should be carried on unchanged.

it seems this isn't true. your patch is also changing userspace ABI as
long as you change pci_dev->irq
which will be shown in sysfs irq entry.

if we don't want to change the behaviour of any existing ABI, it seems
the only thing we can do here
to document it well in ABI doc. i actually doubt anyone has really
understood what the irq entry
is really showing.

>
>
> > For example, userspace irqbalance is actually using
> > /sys/devices/.../msi_irqs/ So probably we should set this ABI
> > invisible when devices are using MSI or MSI-X?
>
> Can it actually be made optional? I don't believe we can.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks
barry
