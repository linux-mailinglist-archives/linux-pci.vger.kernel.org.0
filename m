Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC923EDD7D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 21:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhHPTBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 15:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhHPTBv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Aug 2021 15:01:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB16360F39
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 19:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629140479;
        bh=fELjCVaqBimtld+aBQWf5IDFjErooAnKz0sP9yUiUoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PGk1ZfMjxtL2c7d+4+YZ1KNYe2K+qVsxmZBLIohzDtlN1KQPZYuxzyEgY15dE4caj
         8XcO/cvuttvE01ISBZsLNixFrnuKexZgc4VxUsc8/KAWB3r/42ql75k82qTX5w6U5k
         v/KQjLf2tz7Zo3RsrtRLxxvjLSG4XI1EsLKpSr4NU1LY7sgoUU6HKzdMKw9o5+srQB
         DVfePQhGpfuitx+D6xqiklmSK3RFTZBYSxdAbQmOJcGjHEK/uH7EokAvclmfVna8qf
         y4l96kOq5EdbrD3jgT56ntnwdY45OYWo7mivJ2AZVZ5QEBkzL6c6V/1T1ER+0R8yw+
         rNJsM+WpZku5A==
Received: by mail-ej1-f44.google.com with SMTP id d11so33647779eja.8
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 12:01:19 -0700 (PDT)
X-Gm-Message-State: AOAM530vKRI4XSFpUc3Uj1jPGzWtoHWPLxuYgB6qbINgLvPTYyD7b8LJ
        +VSjHngiCziYVn0rGbr+54S9z0G5QR1PlP/CUA==
X-Google-Smtp-Source: ABdhPJw+vG4f/8fBGvP07tjJac8/Smb+C5YLriCvjYb2K6u4Dsncboy5pzrpdFBoiDjCrbtSQB0cVthF/0Jgme/G238=
X-Received: by 2002:a17:906:791:: with SMTP id l17mr17210445ejc.360.1629140478400;
 Mon, 16 Aug 2021 12:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210813160257.3570515-1-robh@kernel.org> <20210813191938.6a8a4ee4@coco.lan>
 <CAL_JsqL+aPRh9CJ0iKbzGCyE3wDR6QMEKAEC8p=1ZVRDSb6JDA@mail.gmail.com>
 <20210816104252.045a7b75@coco.lan> <20210816153624.74910775@coco.lan>
In-Reply-To: <20210816153624.74910775@coco.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 16 Aug 2021 14:01:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJqu=EaNeLWvvd5uQiY9RQYLCh+Gq+eEFJQQhJmwJwS3Q@mail.gmail.com>
Message-ID: <CAL_JsqJqu=EaNeLWvvd5uQiY9RQYLCh+Gq+eEFJQQhJmwJwS3Q@mail.gmail.com>
Subject: Re: [PATCH] PCI: of: Fix MSI domain lookup with child bus nodes
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 16, 2021 at 8:36 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 16 Aug 2021 10:42:52 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>
> > Em Sat, 14 Aug 2021 12:32:56 -0500
> > Rob Herring <robh@kernel.org> escreveu:
> >
> > > On Fri, Aug 13, 2021 at 12:19 PM Mauro Carvalho Chehab
> > > <mchehab+huawei@kernel.org> wrote:
> > > >
> > > > Em Fri, 13 Aug 2021 11:02:57 -0500
> > > > Rob Herring <robh@kernel.org> escreveu:
> > > >
> > > > > When a DT contains PCI child bus nodes, lookup of the MSI domain on PCI
> > > > > buses fails resulting in the following warnings:
> > > > >
> > > > > WARNING: CPU: 4 PID: 7 at include/linux/msi.h:256 __pci_enable_msi_range+0x398/0x59c
> > > > >
> > > > > The issue is that pci_host_bridge_of_msi_domain() will check the DT node of
> > > > > the passed in bus even if it's not the host bridge's bus. Based on the
> > > > > name of the function, that's clearly not what we want. Fix this by
> > > > > walking the bus parents to the root bus.
> > > > >
> > > > > Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > > Cc: Marc Zyngier <maz@kernel.org>
> > > > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > > Compile tested only. Mauro, Can you see if this fixes your issue.
> > > > >
> > > > >  drivers/pci/of.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > > > index a143b02b2dcd..ea70aede054c 100644
> > > > > --- a/drivers/pci/of.c
> > > > > +++ b/drivers/pci/of.c
> > > > > @@ -84,6 +84,10 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
> > > > >       if (!bus->dev.of_node)
> > > > >               return NULL;
> > > > >
> > > > > +     /* Find the host bridge bus */
> > > > > +     while (!pci_is_root_bus(bus))
> > > > > +             bus = bus->parent;
> > > > > +
> > > > >       /* Start looking for a phandle to an MSI controller. */
> > > > >       d = of_msi_get_domain(&bus->dev, bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
> > > > >       if (d)
> > > >
> > > > Nope, it didn't solve the issue.
> > >
> > > Can you try adding some prints of the domain, pci dev, and DT node to
> > > pci_set_bus_msi_domain(). Comparing those when having child nodes or
> > > not would be helpful.
> >
> > Debug patch enclosed.
> >
> > This is what happens when msi-parent is at /soc/pcie@f4000000/pcie@0,0:
> >
> > [    4.305247] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: ffff000104a2f6c0
> > [    4.442212] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: ffff000104a2f6c0
> > [    4.688145] pci_bus 0000:03: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0: IRQ domain: ffff000104a2f6c0
> > [    4.800613] pci_bus 0000:04: pci_set_bus_msi_domain: of_node (null): IRQ domain: ffff000104a2f6c0
> > [    4.856254] pci_bus 0000:05: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0: IRQ domain: ffff000104a2f6c0
> > [    4.922117] pci_bus 0000:06: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0: IRQ domain: ffff000104a2f6c0
> > [    5.032708] pci_bus 0000:07: pci_set_bus_msi_domain: of_node (null): IRQ domain: ffff000104a2f6c0
> >
> > And this is what happens when msi-parent is at /soc/pcie@f4000000
> > (either with or without your patch applied):
> >
> > [    4.120328] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.214541] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.226054] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.478858] pci_bus 0000:03: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@1,0: IRQ domain: 0000000000000000
> > [    4.491218] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.502793] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.588196] pci_bus 0000:04: pci_set_bus_msi_domain: of_node (null): IRQ domain: 0000000000000000
> > [    4.597161] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.608747] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.658892] pci_bus 0000:05: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@5,0: IRQ domain: 0000000000000000
> > [    4.671241] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.682869] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.732938] pci_bus 0000:06: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0/pcie@7,0: IRQ domain: 0000000000000000
> > [    4.745305] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.756880] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.850363] pci_bus 0000:07: pci_set_bus_msi_domain: of_node (null): IRQ domain: 0000000000000000
> > [    4.859322] pci_bus 0000:02: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0/pcie@0,0: IRQ domain: 0000000000000000
> > [    4.870895] pci_bus 0000:01: pci_set_bus_msi_domain: of_node /soc/pcie@f4000000/pcie@0,0: IRQ domain: 0000000000000000
> >
> > Btw, despite lspci works on both cases, the Ethernet adapter stops
> > working when msi-parent is at /soc/pcie@f4000000. I didn't notice it
> > before, as (up to last week) I was using WiFi to connect to this board.
> >
> > Thanks,
> > Mauro
> >
> > [PATCH] PCI: probe: Add a debug printk at pci_set_bus_msi_domain
> >
> > That helps to discover problems when trying to get the MSI IRQ
> > domain.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index c5dfc1afb1d3..f73bd81922b3 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -866,6 +866,8 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
> >         for (b = bus, d = NULL; !d && !pci_is_root_bus(b); b = b->parent) {
> >                 if (b->self)
> >                         d = dev_get_msi_domain(&b->self->dev);
> > +               dev_dbg(&b->dev, "%s: of_node %pOF: IRQ domain: %px\n",
> > +                       __func__, b->dev.of_node, d);
> >         }
> >
> >         if (!d)
> >
>
> I added a lot of other debug stuff (see attached).
>
> When msi-parent is at:
>
>         pcie@f4000000 {
>                 msi-parent = <&its_pcie>;
>         };

Are you sure the IRQ domain got created for its_pcie? From your dts
changes, you have a GICv3-ITS without a GICv3. I don't think that's
right.

The DWC driver will skip setting up it's own MSI controller if
'msi-parent' is present in the DWC node. So if you move it out of that
node, then the DWC MSI controller will be found and used. Try removing
'msi-parent' and the its_pcie node.

Rob
