Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C880428E4E0
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgJNQwT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 12:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgJNQwT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Oct 2020 12:52:19 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24A802223F;
        Wed, 14 Oct 2020 16:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602694337;
        bh=X5bgjghslOqJAsbOkzEOy6nDMOO7kcdiRbjfFYly/cs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EkF0ezVo3WJGJZ/ttJh4S4FbWeq4dfgS9kErwHgkNuL/PnkVzIXNTooOHZyJsPoOq
         9FTFkLEx7qe8h7/FATEvHCzAonEudwkuXVMuWhaRb5RCa1NxOSaCuw/fjnZXhykRuq
         k5m/VlHo7DhPzGnjuhmYYYK9+onfKR1hh6hWDLwA=
Received: by mail-oi1-f175.google.com with SMTP id s81so3857287oie.13;
        Wed, 14 Oct 2020 09:52:17 -0700 (PDT)
X-Gm-Message-State: AOAM5306B1DRQhLGIN3MaVcVwBsW0fvPmOEzQffI19OGr3cpNCvWUkRi
        1VxEGJqRgYCZtNN+Y+medSaBvKR5JZPUUPcDmmU=
X-Google-Smtp-Source: ABdhPJztTOjfh01gOCxjPBWsnTisxuTJIOW1rNonNd9o7B4V1nPn2A8bNhkLmObIFazWOGfUN0W5dA3L8ylXi1LnR2E=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr175354oig.174.1602694336162;
 Wed, 14 Oct 2020 09:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201009155311.22d3caa5@xhacker.debian> <20201009155505.5a580ef5@xhacker.debian>
 <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
In-Reply-To: <38a00dde-598f-b6de-ecf3-5d012bd7594a@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 14 Oct 2020 18:52:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZnFLaGAFuyMPC8c8TPKf25d1matV9UT2AD2LqO1Rbpw@mail.gmail.com>
Message-ID: <CAMj1kXGZnFLaGAFuyMPC8c8TPKf25d1matV9UT2AD2LqO1Rbpw@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: dwc: Fix MSI page leakage in suspend/resume
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 12 Oct 2020 at 13:38, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-10-09 08:55, Jisheng Zhang wrote:
> > Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> > program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> > may lose power during suspend-to-RAM, so when we resume, we want to
> > redo the latter but not the former. If designware based driver (for
> > example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> > msi page will be leaked.
> >
> > As pointed out by Rob and Ard, there's no need to allocate a page for
> > the MSI address, we could use an address in the driver data.
> >
> > To avoid map the MSI msg again during resume, we move the map MSI msg
> > from dw_pcie_msi_init() to dw_pcie_host_init().
>
> You should move the unmap there as well. As soon as you know what the
> relevant address would be if you *were* to do DMA to this location, then
> the exercise is complete. Leaving it mapped for the lifetime of the
> device in order to do not-DMA to it seems questionable (and represents
> technically incorrect API usage without at least a sync_for_cpu call
> before any other access to the data).
>
> Another point of note is that using streaming DMA mappings at all is a
> bit fragile (regardless of this change). If the host controller itself
> has a limited DMA mask relative to physical memory (which integrators
> still seem to keep doing...) then you could end up punching your MSI
> hole right in the middle of the SWIOTLB bounce buffer, where it's then
> almost *guaranteed* to interfere with real DMA :(
>

Wouldn't it be the unmap you are suggesting that would create this
problem? If the bounce buffer is never released, the fake MSI doorbell
address can never conflict with any other DMA mappings.


> If no DWC users have that problem and the current code is working well
> enough, then I see little reason not to make this partucular change to
> tidy up the implementation, just bear in mind that there's always the
> possibility of having to come back and change it yet again in future to
> make it more robust. I had it in mind that this trick was done with a
> coherent DMA allocation, which would be safe from addressing problems
> but would need to be kept around for the lifetime of the device, but
> maybe that was a different driver :/
>
> Robin.
>
> > Suggested-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >   drivers/pci/controller/dwc/pci-dra7xx.c       | 18 +++++++++-
> >   .../pci/controller/dwc/pcie-designware-host.c | 33 ++++++++++---------
> >   drivers/pci/controller/dwc/pcie-designware.h  |  2 +-
> >   3 files changed, 36 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > index 8f0b6d644e4b..6d012d2b1e90 100644
> > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > @@ -466,7 +466,9 @@ static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
> >   static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
> >   {
> >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +     struct device *dev = pci->dev;
> >       u32 ctrl, num_ctrls;
> > +     int ret;
> >
> >       pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
> >
> > @@ -482,7 +484,21 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
> >                                   ~0);
> >       }
> >
> > -     return dw_pcie_allocate_domains(pp);
> > +     ret = dw_pcie_allocate_domains(pp);
> > +     if (ret)
> > +             return ret;
> > +
> > +     pp->msi_data = dma_map_single_attrs(dev, &pp->msi_msg,
> > +                                        sizeof(pp->msi_msg),
> > +                                        DMA_FROM_DEVICE,
> > +                                        DMA_ATTR_SKIP_CPU_SYNC);
> > +     ret = dma_mapping_error(dev, pp->msi_data);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to map MSI data\n");
> > +             pp->msi_data = 0;
> > +             dw_pcie_free_msi(pp);
> > +     }
> > +     return ret;
> >   }
> >
> >   static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d3e9ea11ce9e..d02c7e74738d 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -266,30 +266,23 @@ void dw_pcie_free_msi(struct pcie_port *pp)
> >       irq_domain_remove(pp->msi_domain);
> >       irq_domain_remove(pp->irq_domain);
> >
> > -     if (pp->msi_page)
> > -             __free_page(pp->msi_page);
> > +     if (pp->msi_data) {
> > +             struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +             struct device *dev = pci->dev;
> > +
> > +             dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
> > +                                    DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> > +     }
> >   }
> >
> >   void dw_pcie_msi_init(struct pcie_port *pp)
> >   {
> >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > -     struct device *dev = pci->dev;
> > -     u64 msi_target;
> > +     u64 msi_target = (u64)pp->msi_data;
> >
> >       if (!IS_ENABLED(CONFIG_PCI_MSI))
> >               return;
> >
> > -     pp->msi_page = alloc_page(GFP_KERNEL);
> > -     pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> > -                                 DMA_FROM_DEVICE);
> > -     if (dma_mapping_error(dev, pp->msi_data)) {
> > -             dev_err(dev, "Failed to map MSI data\n");
> > -             __free_page(pp->msi_page);
> > -             pp->msi_page = NULL;
> > -             return;
> > -     }
> > -     msi_target = (u64)pp->msi_data;
> > -
> >       /* Program the msi_data */
> >       dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
> >       dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
> > @@ -394,6 +387,16 @@ int dw_pcie_host_init(struct pcie_port *pp)
> >                               irq_set_chained_handler_and_data(pp->msi_irq,
> >                                                           dw_chained_msi_isr,
> >                                                           pp);
> > +
> > +                     pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> > +                                                   sizeof(pp->msi_msg),
> > +                                                   DMA_FROM_DEVICE,
> > +                                                   DMA_ATTR_SKIP_CPU_SYNC);
> > +                     if (dma_mapping_error(pci->dev, pp->msi_data)) {
> > +                             dev_err(pci->dev, "Failed to map MSI data\n");
> > +                             pp->msi_data = 0;
> > +                             goto err_free_msi;
> > +                     }
> >               } else {
> >                       ret = pp->ops->msi_host_init(pp);
> >                       if (ret < 0)
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 97c7063b9e89..9d2f511f13fa 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -190,8 +190,8 @@ struct pcie_port {
> >       int                     msi_irq;
> >       struct irq_domain       *irq_domain;
> >       struct irq_domain       *msi_domain;
> > +     u16                     msi_msg;
> >       dma_addr_t              msi_data;
> > -     struct page             *msi_page;
> >       struct irq_chip         *msi_irq_chip;
> >       u32                     num_vectors;
> >       u32                     irq_mask[MAX_MSI_CTRLS];
> >
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
