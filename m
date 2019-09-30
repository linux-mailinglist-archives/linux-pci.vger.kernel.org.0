Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1511C28C1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 23:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfI3VYe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 17:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfI3VYe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Sep 2019 17:24:34 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 690E721920;
        Mon, 30 Sep 2019 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569878672;
        bh=O0YTj2vhvn3cLJ9bXhjvMPrKFz9pub2mp+NyxMOgLgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XbxRSBb5GzUwqvHLEh5933b2ncHabYYcy1H+PGoWAURC6L6OdvUSkMXSuI0Iao+qZ
         0/XMhv/X8S8fJpHTkfs7dgHQrJiQtHY7DLVpLSN5KbV0sqXQhr4XPG2Cj2rZnridY7
         w1jj9r+Rs3EGC9eEA/lZ15W3yzaU9R0022RF1Dto=
Received: by mail-qt1-f177.google.com with SMTP id 3so18976777qta.1;
        Mon, 30 Sep 2019 14:24:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXAshFanHEZgU5iZwlV8eAxuby5/lsuknWOk8eiTQuBJlikpRMh
        vdfvLeuBnE+lnknRZiRQaqqByPZDb6CuLwWPoQ==
X-Google-Smtp-Source: APXvYqwkGA20wZuKhUgCITJW9BMQhvKkz+h0oBRgQSxYR0zNJnVmKMOzb61pAR/bwav/Kg6q4m9o5OuCzIMOKst9NO8=
X-Received: by 2002:ac8:31b3:: with SMTP id h48mr28091603qte.300.1569878671519;
 Mon, 30 Sep 2019 14:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190927002455.13169-1-robh@kernel.org> <20190927002455.13169-6-robh@kernel.org>
 <20190930125752.GD12051@infradead.org> <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
In-Reply-To: <95f8dabea99f104336491281b88c04b58d462258.camel@suse.de>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Sep 2019 16:24:20 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com>
Message-ID: <CAL_JsqLnKxuQRR3sGGtXF3nwwDx7DOONPPYz37ROk7u_+cxRug@mail.gmail.com>
Subject: Re: [PATCH 05/11] of: Ratify of_dma_configure() interface
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 30, 2019 at 8:32 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> On Mon, 2019-09-30 at 05:57 -0700, Christoph Hellwig wrote:
> > On Thu, Sep 26, 2019 at 07:24:49PM -0500, Rob Herring wrote:
> > > -int of_dma_configure(struct device *dev, struct device_node *np, bool
> > > force_dma)
> > > +int of_dma_configure(struct device *dev, struct device_node *parent, bool
> > > force_dma)
> >
> > This creates a > 80 char line.
> >
> > >  {
> > >     u64 dma_addr, paddr, size = 0;
> > >     int ret;
> > >     bool coherent;
> > >     unsigned long offset;
> > >     const struct iommu_ops *iommu;
> > > +   struct device_node *np;
> > >     u64 mask;
> > >
> > > +   np = dev->of_node;
> > > +   if (!np)
> > > +           np = parent;
> > > +   if (!np)
> > > +           return -ENODEV;
> >
> > I have to say I find the older calling convention simpler to understand.
> > If we want to enforce the invariant I'd rather do that explicitly:
> >
> >       if (dev->of_node && np != dev->of_node)
> >               return -EINVAL;
>
> As is, this would break Freescale Layerscape fsl-mc bus' dma_configure():

This may break PCI too for devices that have a DT node.

> static int fsl_mc_dma_configure(struct device *dev)
> {
>         struct device *dma_dev = dev;
>
>         while (dev_is_fsl_mc(dma_dev))
>                 dma_dev = dma_dev->parent;
>
>         return of_dma_configure(dev, dma_dev->of_node, 0);
> }
>
> But I think that with this series, given the fact that we now treat the lack of
> dma-ranges as a 1:1 mapping instead of an error, we could rewrite the function
> like this:

Now, I'm reconsidering allowing this abuse... It's better if the code
which understands the bus structure in DT for a specific bus passes in
the right thing. Maybe I should go back to Robin's version (below).
OTOH, the existing assumption that 'dma-ranges' was in the immediate
parent was an assumption on the bus structure which maybe doesn't
always apply.

diff --git a/drivers/of/device.c b/drivers/of/device.c
index a45261e21144..6951450bb8f3 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -98,12 +98,15 @@ int of_dma_configure(struct device *dev, struct
device_node *parent, bool force_
        u64 mask;

        np = dev->of_node;
-       if (!np)
-               np = parent;
+       if (np)
+               parent = of_get_dma_parent(np);
+       else
+               np = of_node_get(parent);
        if (!np)
                return -ENODEV;

-       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
+       ret = of_dma_get_range(parent, &dma_addr, &paddr, &size);
+       of_node_put(parent);
        if (ret < 0) {
                /*
                 * For legacy reasons, we have to assume some devices need
