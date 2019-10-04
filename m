Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD1BCB328
	for <lists+linux-pci@lfdr.de>; Fri,  4 Oct 2019 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfJDBxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 21:53:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbfJDBxX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 21:53:23 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64E4621848;
        Fri,  4 Oct 2019 01:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570154001;
        bh=6odMtoguJBjNIxmq0WvWcpWk1CrE1EvPomXzTsSYIrs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AwYuS5MYR5UrpmjoK052xwB8qTp8H9UDlMezDdYyl1pA840CiRONdKV/9uIsNNUqR
         8lS/Fn/bEO6ooPXWi0TrohOTpOF3Ns2e31Xa3u0mQ1E/6uy2d7lmgYF3+oI2NEfjpu
         hqjRtZ6gUBLiJNLCfnIPomVdwPxetJaQRrPlwlY8=
Received: by mail-qk1-f171.google.com with SMTP id z67so4360929qkb.12;
        Thu, 03 Oct 2019 18:53:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWYhBOVbr3BzHbOF/38i/QVFFCMCGkCjs+NW2K3eZqo6YdzXBst
        gFNrqmW0B6riRUmUqtU6AJaPaGCQnYa9UICZhQ==
X-Google-Smtp-Source: APXvYqy3/i1ov1ukyfSyJerD8h8tAJrCXAUbX0bSNjR5ZiZsqQGKwdIgHZwn3X3XEQRrLm3086Gb58Gtpxhh9D2C0Ws=
X-Received: by 2002:a05:620a:12d5:: with SMTP id e21mr7829021qkl.152.1570154000420;
 Thu, 03 Oct 2019 18:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-6-robh@kernel.org>
 <20190930125752.GD12051@infradead.org> <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
 <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com> <0557c83bcb781724a284811fef7fdb122039f336.camel@suse.de>
In-Reply-To: <0557c83bcb781724a284811fef7fdb122039f336.camel@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Oct 2019 20:53:09 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLo0jtDcCDf5VTc+_grO3fJ1MsDTE8Bj=B0J+eLk3hpZg@mail.gmail.com>
Message-ID: <CAL_JsqLo0jtDcCDf5VTc+_grO3fJ1MsDTE8Bj=B0J+eLk3hpZg@mail.gmail.com>
Subject: Re: [PATCH 05/11] of: Ratify of_dma_configure() interface
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>, PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 1, 2019 at 10:43 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Mon, 2019-09-30 at 16:24 -0500, Rob Herring wrote:
> > On Mon, Sep 30, 2019 at 8:32 AM Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > On Mon, 2019-09-30 at 05:57 -0700, Christoph Hellwig wrote:
> > > > On Thu, Sep 26, 2019 at 07:24:49PM -0500, Rob Herring wrote:
> > > > > -int of_dma_configure(struct device *dev, struct device_node *np, bool
> > > > > force_dma)
> > > > > +int of_dma_configure(struct device *dev, struct device_node *parent,
> > > > > bool
> > > > > force_dma)
> > > >
> > > > This creates a > 80 char line.
> > > >
> > > > >  {
> > > > >     u64 dma_addr, paddr, size = 0;
> > > > >     int ret;
> > > > >     bool coherent;
> > > > >     unsigned long offset;
> > > > >     const struct iommu_ops *iommu;
> > > > > +   struct device_node *np;
> > > > >     u64 mask;
> > > > >
> > > > > +   np = dev->of_node;
> > > > > +   if (!np)
> > > > > +           np = parent;
> > > > > +   if (!np)
> > > > > +           return -ENODEV;
> > > >
> > > > I have to say I find the older calling convention simpler to understand.
> > > > If we want to enforce the invariant I'd rather do that explicitly:
> > > >
> > > >       if (dev->of_node && np != dev->of_node)
> > > >               return -EINVAL;
> > >
> > > As is, this would break Freescale Layerscape fsl-mc bus' dma_configure():
> >
> > This may break PCI too for devices that have a DT node.
> >
> > > static int fsl_mc_dma_configure(struct device *dev)
> > > {
> > >         struct device *dma_dev = dev;
> > >
> > >         while (dev_is_fsl_mc(dma_dev))
> > >                 dma_dev = dma_dev->parent;
> > >
> > >         return of_dma_configure(dev, dma_dev->of_node, 0);
> > > }
> > >
> > > But I think that with this series, given the fact that we now treat the lack
> > > of
> > > dma-ranges as a 1:1 mapping instead of an error, we could rewrite the
> > > function
> > > like this:
> >
> > Now, I'm reconsidering allowing this abuse... It's better if the code
> > which understands the bus structure in DT for a specific bus passes in
> > the right thing. Maybe I should go back to Robin's version (below).
> > OTOH, the existing assumption that 'dma-ranges' was in the immediate
> > parent was an assumption on the bus structure which maybe doesn't
> > always apply.
> >
> > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > index a45261e21144..6951450bb8f3 100644
> > --- a/drivers/of/device.c
> > +++ b/drivers/of/device.c
> > @@ -98,12 +98,15 @@ int of_dma_configure(struct device *dev, struct
> > device_node *parent, bool force_
> >         u64 mask;
> >
> >         np = dev->of_node;
> > -       if (!np)
> > -               np = parent;
> > +       if (np)
> > +               parent = of_get_dma_parent(np);
> > +       else
> > +               np = of_node_get(parent);
> >         if (!np)
> >                 return -ENODEV;
> >
> > -       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> > +       ret = of_dma_get_range(parent, &dma_addr, &paddr, &size);
> > +       of_node_put(parent);
> >         if (ret < 0) {
> >                 /*
> >                  * For legacy reasons, we have to assume some devices need
>
> I spent some time thinking about your comments and researching. I came to the
> realization that both these solutions break the usage in
> drivers/gpu/drm/sun4i/sun4i_backend.c:805. In that specific case both
> 'dev->of_node' and 'parent' exist yet the device receiving the configuration
> and 'parent' aren't related in any way.

I knew there was some reason I didn't like those virtual DT nodes...

That does seem to be the oddest case. Several of the others are just
non-DT child platform devices. Perhaps we need a "copy the DMA config
from another struct device (or parent struct device)" function to
avoid using a DT function on a non-DT device.

> IOW we can't just use 'dev->of_node' as a starting point to walk upwards the
> tree. We always have to respect whatever DT node the bus provided, and start
> there. This clashes with the current solutions, as they are based on the fact
> that we can use dev->of_node when present.

Yes, you are right.

> My guess at this point, if we're forced to honor that behaviour, is that we
> have to create a new API for the PCI use case. Something the likes of
> of_dma_configure_parent().

I think of_dma_configure just has to work with the device_node of
either the device or the device parent and dev->of_node is never used
unless the caller sets it.

Rob
