Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71E3E38FD
	for <lists+linux-pci@lfdr.de>; Sun,  8 Aug 2021 07:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbhHHFVL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Aug 2021 01:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHHFVK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Aug 2021 01:21:10 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C923C061760;
        Sat,  7 Aug 2021 22:20:51 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id h17so3271718vsu.0;
        Sat, 07 Aug 2021 22:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vamzk//toKdkNjCyAGnqe5q3gRuSTfvs1CUX5Gt5Yfs=;
        b=ZooxQ9Rp3rn7r3+lkjFs3W8kEOMXAwN89FWfSR5bsl3+TOGpu1/X+M4Hd2rEIOgy1i
         W4nMRYkhq+HDgaFss8zD/fWqk6ZUZT8ZFgn4NTqp3oshpAQfwRse8XZmbnz87bkA73Rj
         TdlG9ueRlYyciaW+AAyhKoFqV4yuZe4L1O45WfXX/tWQc+SaaXecemSotY8sZeNKndF+
         K4M2S4USlMyvGXWvSby8I71EyzgFz71+o1ZwZKZkgFnIJmalELAEkxk9BE4FqIJHiJVx
         /ZXqAb1ldH9VWvrnm6c8dyVcztguVUDOHKrjpiV7I8cFYHTxF6x4OdEK4d+NaszZQyfg
         UYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vamzk//toKdkNjCyAGnqe5q3gRuSTfvs1CUX5Gt5Yfs=;
        b=tcS2UCCtI5a7L6MkvPolh6vOhrR/l1RbRfgMmTEfA77meFZAMDsTXuUW9vWCOHYJUD
         SA5yECaOpN4Ha2ZbtmtV4OiCblWtIfC13IfkR5884aNvZHHV4P/gLo0HBt28o6XRz2LY
         HIklrdPA6vmkZJvGMeXoUQC3NvsyIkWzRyZqXG1eDLClggGC693346yiO+9ZXJtTqjGZ
         kxQlc0/YU7xtUgi6fRgsT4/AhsiprZQ+dP6sRMTAFrNL6BV8R/IKowS58oC6dYv8bPaZ
         CltoT3oxe3KeOl7N6FfmP4nI94s0Uqh0Af/Pks/gy4Utwb6Jgj1gLJngYrnsXpSFZaT5
         pXZQ==
X-Gm-Message-State: AOAM532lhRsPLBnujot29VlMbLUUBlhjsTmethxTGplIfq3VLtonwlVj
        vVMA32QUvmIM1rMuQZGEhXXHkTvE2k+IIOheJsk=
X-Google-Smtp-Source: ABdhPJzwpRmJgU5mR/oJ21UlVx3ITeMDRnrpJRZ8dwJKuKSsnYpIz/cDHcgpFISAzKt2LTVhuKvQTYi/p7hLJ54ACz8=
X-Received: by 2002:a67:70c4:: with SMTP id l187mr13719259vsc.30.1628400050076;
 Sat, 07 Aug 2021 22:20:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210807072409.9018-1-sergio.paracuellos@gmail.com>
 <20210807072409.9018-3-sergio.paracuellos@gmail.com> <7f0d48a6-d4ae-4e8d-aaa8-4b0bb4ad8e35@www.fastmail.com>
In-Reply-To: <7f0d48a6-d4ae-4e8d-aaa8-4b0bb4ad8e35@www.fastmail.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sun, 8 Aug 2021 07:20:38 +0200
Message-ID: <CAMhs-H-FcZmxZircJB6m2yi8Vmz8zy4gCBNYTWMsTS5=MstF9g@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: of: avoid 'devm_pci_remap_iospace' if PCI_IOBASE
 is not defined
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-staging@lists.linux.dev, NeilBrown <neil@brown.name>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jiaxun,

On Sun, Aug 8, 2021 at 3:41 AM Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82021=E5=B9=B48=E6=9C=887=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=E5=
=8D=883:24=EF=BC=8CSergio Paracuellos=E5=86=99=E9=81=93=EF=BC=9A
> > Defining PCI_IOBASE for MIPS ralink in expected addresses results in
> > PCI IO
> > resources being assigned but the addresses generated for IO accesses
> > are wrong
> > since the ioremap in the PCI core function
> > 'pci_parse_request_of_pci_ranges'
> > tries to remap to a fixed virtual address (PC_IOBASE) which can't work
> > for KSEG1
> > addresses. To get it working this way, we would need to put PCI_IOBASE
> > somewhere
> > into KSEG2 which will result in creating TLB entries for IO addresses,
> > which most
> > of the time isn't needed on MIPS because of access via KSEG1. To allow
>
> It was designed to allow multiple PCI bridge with sparse IO space pattern=
.
> So for ralink it's not going to happen?

Sorry, I don't understand your question. Can you please clarify it for me?

Thanks,
    Sergio Paracuellos
>
> Thanks.
> - Jiaxun
>
>
> > MIPS PCI
> > drivers to properly use the PCI generic core we need to increase
> > IO_SPACE_LIMIT
> > since IO addresses are in addresses higher that 0xffff. We also need to
> > avoid
> > the call 'devm_pci_remap_iospace' when
> > 'pci_parse_request_of_pci_ranges' is
> > called to avoid the following problem:
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 2 PID: 1 at ../drivers/pci/pci.c:4066 pci_remap_iospace+0=
x3c/0x54
> > This architecture does not support memory mapped I/O
> > Modules linked in:
> > CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.10.1+ #1228
> > Stack : 00000000 00000000 807fa974 00000000 827ffa80 80066b48 80710000 =
0000000b
> >         00000000 00000000 81c59aac 7d06ddec 80850000 00000001 81c59a40 =
7d06ddec
> >         00000000 00000000 807c909c 81c598f0 00000001 81c59904 00000000 =
0000000a
> >         203a6d6d 80708880 0000000f 70617773 80850000 00000000 00000000 =
807d0000
> >         807ffecc 1e160000 00000001 00000200 00000000 8054e920 00000008 =
815e0008
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
> > mt7621-pci 1e140000.pcie: error -19: failed to map resource [io
> > 0x1e160000-0x1e16ffff]
> >
> > Hence don't call 'devm_pci_remap_iospace' if PCI_IOBASE is not defined =
to get
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
> > @@ -564,12 +564,14 @@ static int pci_parse_request_of_pci_ranges(struct
> > device *dev,
> >
> >               switch (resource_type(res)) {
> >               case IORESOURCE_IO:
> > +#ifdef PCI_IOBASE
> >                       err =3D devm_pci_remap_iospace(dev, res, iobase);
> >                       if (err) {
> >                               dev_warn(dev, "error %d: failed to map re=
source %pR\n",
> >                                        err, res);
> >                               resource_list_destroy_entry(win);
> >                       }
> > +#endif
> >                       break;
> >               case IORESOURCE_MEM:
> >                       res_valid |=3D !(res->flags & IORESOURCE_PREFETCH=
);
> > --
> > 2.25.1
> >
> >
>
>
> --
> - Jiaxun
