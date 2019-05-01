Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0367310A3B
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 17:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfEAPoU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 11:44:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39345 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEAPoU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 May 2019 11:44:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id a9so25029495wrp.6
        for <linux-pci@vger.kernel.org>; Wed, 01 May 2019 08:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihqeIyGh+Y0PhIVYUkh50s+LpirgFvDtjhB/Se6zeC8=;
        b=gNkzwNiArWy5yewD/+hCc/NoNCTC4qqIVgOLD0Em21KOQs330a4EVeaHeS52tSmWif
         zhUZJP4XmgDWOwMejTM0kSJpYHbwQJPL8hEKaH7qArPj7UoNmCoPoeXBGsx5gYT4a5wl
         9i57NGYnzfI6HOk9fkB/GcNW1pbqu40Ii6kHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihqeIyGh+Y0PhIVYUkh50s+LpirgFvDtjhB/Se6zeC8=;
        b=JJkXTvxGPay5c4yPYlBv3i9IcvOPkP/u6w753O0bCxPWtZh53IpMY+SL+opcvclmVn
         7z3YMNP+QjC6XTZtDuGyOUwiF3qZYgjNrkMhiG9xXELrDxqwX3IbO47VmuQfiqjC+QYL
         WbB71k2PojR6dXhCZ1MJaeZhOEYhCzrmqObAcyBeaWFVvLQtGLXtC3TVGA7QCTmiSSBj
         Gg1MYHUb/ug/SaWssxXtRqYd3JQBvXjKMdr+Q1oWrbYfYVJan2mumHNIM5DCX/J6s2WH
         ITR+vr1R87ogCeAEfJbPCvKCapbifOTTijx/MZ2qXBU6leAGaBkyYQUnDwEOHrlI53Wa
         IyYw==
X-Gm-Message-State: APjAAAXbOIHjALuN0UoY1J5hNOYIRUjz59JoyddlBoehgdDN8Sy80jSf
        I9+NRxlUQVpiAcjcCkNpj2bkNCpBi0TMBoO4UU5Jpw==
X-Google-Smtp-Source: APXvYqxXc5jGnGaJFZyfJ2rjjTdiDutg0T5xSEPxqrkoHXM+EaLYQMJpSL5Z/eCSoYW68v9gMTV6cUYlNz/ZT9sBNR0=
X-Received: by 2002:a5d:4fc3:: with SMTP id h3mr8375115wrw.54.1556725458010;
 Wed, 01 May 2019 08:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <1555038815-31916-1-git-send-email-srinath.mannam@broadcom.com>
 <1555038815-31916-4-git-send-email-srinath.mannam@broadcom.com> <20190501143742.GA13089@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190501143742.GA13089@e121166-lin.cambridge.arm.com>
From:   Srinath Mannam <srinath.mannam@broadcom.com>
Date:   Wed, 1 May 2019 21:14:06 +0530
Message-ID: <CABe79T58F+xikMGthd4wc19qQzC3=Q4znaaf6qDMjBXn+PBpfw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] PCI: iproc: Add sorted dma ranges resource entries
 to host bridge
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, poza@codeaurora.org,
        Ray Jui <rjui@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

Please see my reply below.

On Wed, May 1, 2019 at 8:07 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 12, 2019 at 08:43:35AM +0530, Srinath Mannam wrote:
> > IPROC host has the limitation that it can use only those address ranges
> > given by dma-ranges property as inbound address. So that the memory
> > address holes in dma-ranges should be reserved to allocate as DMA address.
> >
> > Inbound address of host accessed by PCIe devices will not be translated
> > before it comes to IOMMU or directly to PE.
>
> What does that mean "directly to PE" ?
In general, with IOMMU enable case, inbound address access of endpoint
will come to IOMMU.
If IOMMU disable then it comes to PE (processing element - ARM).
>
> IIUC all you want to say is that there is no entity translating
> PCI memory transactions addresses before they it the PCI host
> controller inbound regions address decoder.
In our SOC we have an entity (Inside PCIe RC) which will translate
inbound address before it goes to
IOMMU or PE. In other SOCs this will not be the case, all inbound
address access will go to IOMMU or
PE.
Regards,
Srinath.
>
> > But the limitation of this host is, access to few address ranges are
> > ignored. So that IOVA ranges for these address ranges have to be
> > reserved.
> >
> > All allowed address ranges are listed in dma-ranges DT parameter. These
> > address ranges are converted as resource entries and listed in sorted
> > order add added to dma_ranges list of PCI host bridge structure.
> >
> > Ex:
> > dma-ranges = < \
> >   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> >   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> >   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> >
> > In the above example of dma-ranges, memory address from
> > 0x0 - 0x80000000,
> > 0x100000000 - 0x800000000,
> > 0x1000000000 - 0x8000000000 and
> > 0x10000000000 - 0xffffffffffffffff.
> > are not allowed to use as inbound addresses.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > Based-on-patch-by: Oza Pawandeep <oza.oza@broadcom.com>
> > Reviewed-by: Oza Pawandeep <poza@codeaurora.org>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 44 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index c20fd6b..94ba5c0 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1146,11 +1146,43 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
> >       return ret;
> >  }
> >
> > +static int
> > +iproc_pcie_add_dma_range(struct device *dev, struct list_head *resources,
> > +                      struct of_pci_range *range)
> > +{
> > +     struct resource *res;
> > +     struct resource_entry *entry, *tmp;
> > +     struct list_head *head = resources;
> > +
> > +     res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> > +     if (!res)
> > +             return -ENOMEM;
> > +
> > +     resource_list_for_each_entry(tmp, resources) {
> > +             if (tmp->res->start < range->cpu_addr)
> > +                     head = &tmp->node;
> > +     }
> > +
> > +     res->start = range->cpu_addr;
> > +     res->end = res->start + range->size - 1;
> > +
> > +     entry = resource_list_create_entry(res, 0);
> > +     if (!entry)
> > +             return -ENOMEM;
> > +
> > +     entry->offset = res->start - range->cpu_addr;
> > +     resource_list_add(entry, head);
> > +
> > +     return 0;
> > +}
> > +
> >  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> >  {
> > +     struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> >       struct of_pci_range range;
> >       struct of_pci_range_parser parser;
> >       int ret;
> > +     LIST_HEAD(resources);
> >
> >       /* Get the dma-ranges from DT */
> >       ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> > @@ -1158,13 +1190,23 @@ static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> >               return ret;
> >
> >       for_each_of_pci_range(&parser, &range) {
> > +             ret = iproc_pcie_add_dma_range(pcie->dev,
> > +                                            &resources,
> > +                                            &range);
> > +             if (ret)
> > +                     goto out;
> >               /* Each range entry corresponds to an inbound mapping region */
> >               ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
> >               if (ret)
> > -                     return ret;
> > +                     goto out;
> >       }
> >
> > +     list_splice_init(&resources, &host->dma_ranges);
> > +
> >       return 0;
> > +out:
> > +     pci_free_resource_list(&resources);
> > +     return ret;
> >  }
> >
> >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
> > --
> > 2.7.4
> >
