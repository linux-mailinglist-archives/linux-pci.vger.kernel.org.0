Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0143E8E67
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 12:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhHKKUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 06:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237045AbhHKKUW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 06:20:22 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57622C061765;
        Wed, 11 Aug 2021 03:19:52 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id x11so527577vke.1;
        Wed, 11 Aug 2021 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I5+sfKd8Qk5fi/K9nkfNRq3adRlaCZduPHrRMySxD8Q=;
        b=ldcW3CpuFUXP9UrjOK7qktadT10ivs8KVrrs7JsoTaX/NAdEGiTSkixKByyeW1Oc9j
         xXd+Xr9e2nGn+ttE8jICPmzUBbCcUrgRion53J9uFOkxnvzpTT7mH2YXtO2wsh8AezVV
         FxxybmRptOKS8f7lyLRnxE9lZclXnFWszANsq2aaBLGgjSitc9JaGYCRDuo2MW+iWfza
         ebLhrR4FyLBCWy6C/MN1BXRXxhNbdUPNTez56nv4754PQiwHnXWlCHRYPBbfNf3ggCJi
         Alw63VCEwV1sbaS8KSmKGrJ5ICbHc4SxR04hR2mkiYhIExf6rM9W3Z7X5JhFE1Yo5+J+
         VCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I5+sfKd8Qk5fi/K9nkfNRq3adRlaCZduPHrRMySxD8Q=;
        b=WmvDRdxXP8p/moKH5c4UzYUFVN2qqigrFXp/GMH1xsKcmTn7JLqeNW5BVSlmC6JZ48
         X9mOFLZmgQFgSR47B+5iJ93aKc9GEhmz1Xd5icj8vZeRPwqOLdfF9/J7vrgznJ/JhRlb
         uFd1tQ+Gt0dx18frI8Ov8GN+qWTBd/ITbFIR3Y91VhZ7cafNuI4T8uOwh7XYQyEEpVcg
         Z5wFMklvsuouDgcRvlXjIT9qgGHcxgLEB9z8WbRmRNfgzLSaOL/KF3wC7wrvQ/aq0p02
         sDyKiTW6TryzkGAIr0J3c+qvlt/Os4taJfbLJ9rPIw7yCK/rBj0iRrnWaVr0JaRvBpY3
         pn2g==
X-Gm-Message-State: AOAM530vvUccTORwJtwdipvNSuCIncdWLGgfv2uXsc7MTI60dX8mofs5
        Ug5YmmWX9Q8GnITK6U0LsepVPr3ZAHNDPXGyDos=
X-Google-Smtp-Source: ABdhPJxNKHPZi0srhB9nyrbfWxcjJPGixvokF8J7BnQ8SqYZNjtYkAc9Eq6ekrydVHBucD3e4YkM3pbdwPVl9xq89Wc=
X-Received: by 2002:a05:6122:925:: with SMTP id j37mr3630877vka.21.1628677190504;
 Wed, 11 Aug 2021 03:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210807072409.9018-3-sergio.paracuellos@gmail.com> <20210810223245.GA2311409@bjorn-Precision-5520>
In-Reply-To: <20210810223245.GA2311409@bjorn-Precision-5520>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Wed, 11 Aug 2021 12:19:39 +0200
Message-ID: <CAMhs-H9+A1k7=vTHV4TTMOw=8vudD7D5HTgPKGN_NG40=THTQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: of: avoid 'devm_pci_remap_iospace' if PCI_IOBASE
 is not defined
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Wed, Aug 11, 2021 at 12:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Aug 07, 2021 at 09:24:08AM +0200, Sergio Paracuellos wrote:
> > Defining PCI_IOBASE for MIPS ralink in expected addresses results in PCI IO
> > resources being assigned but the addresses generated for IO accesses are wrong
> > since the ioremap in the PCI core function 'pci_parse_request_of_pci_ranges'
> > tries to remap to a fixed virtual address (PC_IOBASE) which can't work for KSEG1
> > addresses. To get it working this way, we would need to put PCI_IOBASE somewhere
> > into KSEG2 which will result in creating TLB entries for IO addresses, which most
> > of the time isn't needed on MIPS because of access via KSEG1. To allow MIPS PCI
> > drivers to properly use the PCI generic core we need to increase IO_SPACE_LIMIT
> > since IO addresses are in addresses higher that 0xffff. We also need to avoid
> > the call 'devm_pci_remap_iospace' when 'pci_parse_request_of_pci_ranges' is
> > called to avoid the following problem:
>
> Rewrap to fit in ~75 columns.

I thought it was already around 75 columns :). For sure, I will
carefully check this for the next version.

>
> This is a generic change so the commit log needs to be generic as
> well.  The MIPS/KSEG1/KSEG2 information is not really useful here
> because most readers won't understand it (and I don't :)).

Yes, you are right, my bad here. MIPS specific address segment names
should be out of generic commit messages like this.

>
> devm_pci_remap_iospace() calls pci_remap_iospace(), which already
> contains #ifdef PCI_IOBASE.  When PCI_IOBASE is not defined (as on
> MIPS ralink), it emits the warning below and returns failure.
>
> This patch avoids that failure, but it still leaves
> devm_pci_remap_iospace() and pci_remap_iospace() broken on MIPS
> ralink.  It's true that on MIPS ralink, they are currently only called
> via pci_parse_request_of_pci_ranges(), but I think it would be better
> if we could fix pci_remap_iospace() to handle this case so all these
> interfaces work consistently.

Ok, agred. So... what should be the correct approach here? Change the
core 'pci_remap_iospace' WARN_ON to a maybe a normal 'pr_warn' message
and silently return 0 and delete function comment there saying that
architectures that don't define PCI_IOBASE should not call that
function? Or should we just redefine this weak 'pci_remap_iospace'
symbol for mips ralink?? I prefer to always do changes in normal core
functions but if this is going to be a mips ralink adjustment because
of architecture specific stuff maybe is better to go for the other
option... Thoughts?


>
> This patch doesn't do anything with IO_SPACE_LIMIT, so I don't know
> what that part of the commit log is telling me.

True, I was introducing the whole thing to have all pci io stuff
working but it is out of scope for this commit in particular. Thanks
for pointing out this also.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos
>
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0x3c/0x54
> > This architecture does not support memory mapped I/O
> > Modules linked in:
> > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> > Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 0000000b
> >         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 7d06ddec
> >         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 0000000a
> >         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 807d0000
> >         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 815e0008
> >         ...
> > Call Trace:
> > [<80008efc>] show_stack+0x8c/0x130
> > [<806e1674>] dump_stack+0x9c/0xc8
> > [<80024a3c>] __warn+0xc0/0xe8
> > [<80024ad0>] warn_slowpath_fmt+0x6c/0xbc
> > [<80410ca8>] pci_remap_iospace+0x3c/0x54
> > [<80410d20>] devm_pci_remap_iospace+0x58/0xa4
> > [<8042019c>] devm_of_pci_bridge_init+0x4dc/0x55c
> > [<80408de8>] devm_pci_alloc_host_bridge+0x78/0x88
> > [<80424e44>] mt7621_pci_probe+0x68/0x9a4
> > [<80464804>] platform_drv_probe+0x40/0x7c
> > [<804628bc>] really_probe+0x2fc/0x4e4
> > [<80463214>] device_driver_attach+0x4c/0x74
> > [<80463384>] __driver_attach+0x148/0x150
> > [<8046047c>] bus_for_each_dev+0x6c/0xb0
> > [<804614dc>] bus_add_driver+0x1b4/0x1fc
> > [<80463aa0>] driver_register+0xd0/0x110
> > [<80001714>] do_one_initcall+0x84/0x1c0
> > [<808e7fd0>] kernel_init_freeable+0x214/0x24c
> > [<806e4164>] kernel_init+0x14/0x118
> > [<80003358>] ret_from_kernel_thread+0x14/0x1c
> >
> > ---[ end trace 1c9d4412bd51b53c ]---
> > mt7621-pci 1e140000.pcie: error -19: failed to map resource [io  0x1e160000-0x1e16ffff]
> >
> > Hence don't call 'devm_pci_remap_iospace' if PCI_IOBASE is not defined to get
> > a working PCI core APIs for MIPS ralink platforms.
> >
> > Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> > ---
> >  drivers/pci/of.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > index a143b02b2dcd..657aef39bf63 100644
> > --- a/drivers/pci/of.c
> > +++ b/drivers/pci/of.c
> > @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
> >
> >               switch (resource_type(res)) {
> >               case IORESOURCE_IO:
> > +#ifdef PCI_IOBASE
> >                       err = devm_pci_remap_iospace(dev, res, iobase);
> >                       if (err) {
> >                               dev_warn(dev, "error %d: failed to map resource %pR\n",
> >                                        err, res);
> >                               resource_list_destroy_entry(win);
> >                       }
> > +#endif
> >                       break;
> >               case IORESOURCE_MEM:
> >                       res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> > --
> > 2.25.1
> >
