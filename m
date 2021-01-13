Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE602F4819
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 10:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbhAMJ4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 04:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbhAMJ4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Jan 2021 04:56:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A06E1233CE;
        Wed, 13 Jan 2021 09:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610531769;
        bh=PavsLJy5AvB8V+H/9/J4zxNIvFWCs0IilnDc/LFH19I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qN9L5CNXDr1eXpDKkeB/HAgCcrWWsfTkF9APPU4IrQDnQ3lg8s91JHFDGbk1ydp8C
         Oqzul/QOr2wB1OSlAGelie81gBlmCK+GFnkE+NXnklnjuh4hY4tr+G2QztFW5N3uPq
         SC/mjgpkqjnimB8efZK+h04AjKD2Se8VLVwjjjMj/h9DGJiapl7FuTxUdgN+Q7XNs3
         DkbWZ9gX/438kOuA0McgXLAJD/t40NB1UhfPNL5JVzky7+uF5qphpmaNuAEWaoutGj
         DjZdq3dS8S6nEZ7BvWkULYG55x9a5y1nGiCBiyvaO1uk7neU6HkCTeoJAIjdWY/4t4
         Sy+P9jmbg+Efg==
Received: by mail-ot1-f41.google.com with SMTP id r9so1325595otk.11;
        Wed, 13 Jan 2021 01:56:09 -0800 (PST)
X-Gm-Message-State: AOAM531QvuWQaOUpKwXcsgC9SF3qz5YbJY734Azg2Exdm/dx/3dAuk1C
        hLA2ClFFUF787dKmnGZiGrMY37dw4oOxiFCLlZ0=
X-Google-Smtp-Source: ABdhPJxT5BvCqmOpK4kasyQXmqEr7TJFFwvo3P8aUy4qHJcoxJQFQj1+vriju4Zim24/TfpNOO77V9WoOfz1hLYDcMs=
X-Received: by 2002:a9d:12c:: with SMTP id 41mr641161otu.77.1610531768832;
 Wed, 13 Jan 2021 01:56:08 -0800 (PST)
MIME-Version: 1.0
References: <20210109095353.13417-1-ardb@kernel.org> <20210112224919.GA1859692@bjorn-Precision-5520>
In-Reply-To: <20210112224919.GA1859692@bjorn-Precision-5520>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 13 Jan 2021 10:55:57 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHLPvaQ74fnDCfz-5ZSmCjkeZddiq+C-nd_Xmh2k-x1bg@mail.gmail.com>
Message-ID: <CAMj1kXHLPvaQ74fnDCfz-5ZSmCjkeZddiq+C-nd_Xmh2k-x1bg@mail.gmail.com>
Subject: Re: [PATCH] PCI: decline to resize resources if boot config must be preserved
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 12 Jan 2021 at 23:49, Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Sat, Jan 09, 2021 at 10:53:53AM +0100, Ard Biesheuvel wrote:
> > The _DSM #5 method in the ACPI host bridge object tells us whether the
> > OS is permitted to deviate from the resource assignment configured by
> > the firmware. If this is not the case, we should not permit drivers to
> > resize BARs on the fly. So make pci_resize_resource() take this into
> > account.
> >
> > Cc: <stable@vger.kernel.org> # v5.4+
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> Capitalized subject to match convention and applied to pci/resource
> for v5.11, thanks!
>
> Is there an email, bug report, etc that prompted this change?
>

No, I was just reviewing the recent Tianocore changes to perform BAR
resizing before resource assignment even takes places, which is
obviously a more appropriate time to do it, as it does not require the
OS to modify the firmware configuration at all. This reminded me of
_DSM #5 and the fact that the OS may not even be permitted to make any
changes.


> > ---
> >  drivers/pci/setup-res.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index 43eda101fcf4..3b38be081e93 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -410,10 +410,16 @@ EXPORT_SYMBOL(pci_release_resource);
> >  int pci_resize_resource(struct pci_dev *dev, int resno, int size)
> >  {
> >       struct resource *res = dev->resource + resno;
> > +     struct pci_host_bridge *host;
> >       int old, ret;
> >       u32 sizes;
> >       u16 cmd;
> >
> > +     /* Check if we must preserve the firmware's resource assignment */
> > +     host = pci_find_host_bridge(dev->bus);
> > +     if (host->preserve_config)
> > +             return -ENOTSUPP;
> > +
> >       /* Make sure the resource isn't assigned before resizing it. */
> >       if (!(res->flags & IORESOURCE_UNSET))
> >               return -EBUSY;
> > --
> > 2.17.1
> >
