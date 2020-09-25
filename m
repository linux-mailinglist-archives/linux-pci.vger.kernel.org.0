Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC4278CCF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 17:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgIYPeH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgIYPeH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 11:34:07 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5269235FD;
        Fri, 25 Sep 2020 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601048047;
        bh=vPP/w0K31Opcdj94EwGLsJZUhJx/552tm+7tEiIB8CY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kPe5NpmEUh6RfG07lmHnYDpCVVt8xg2uOhJ1iVFuReAR4FjgRzyZPV9VNkmb20no2
         FaqAJ6eBjeb9jIjEMglpsXkQ2x2JP2wNT6qtZd3kSjEAYVzPQfig3NJriC+HxcSivP
         7lP1G/YhMmbroRSWQwR+DomDighodPbfFoY200H0=
Received: by mail-oi1-f176.google.com with SMTP id 185so3157076oie.11;
        Fri, 25 Sep 2020 08:34:06 -0700 (PDT)
X-Gm-Message-State: AOAM53238jZqLCV8Zqy0hY4vT5vEb41P33ZMnPm7jAuWGEOI0k0tXOvM
        lMvZGIB25TfY9yy5lqUQy6q8A7ItOa/RXJX0Gw==
X-Google-Smtp-Source: ABdhPJwbqRmOxy10BFQq2A7qgWOoGCwXLRKRV70JO1o/mNjxDjDT+3k7nmWKHg7UeGJg29406ZkFTXYS6SWSQPKxXyE=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr4291oii.106.1601048046148;
 Fri, 25 Sep 2020 08:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200925163435.680b8e08@xhacker.debian> <20200925163852.051e3da2@xhacker.debian>
In-Reply-To: <20200925163852.051e3da2@xhacker.debian>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 25 Sep 2020 09:33:54 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK6QURYdt-0mbuv6oeoqFr0acVh6Q7F2-FSXN-zOk34XA@mail.gmail.com>
Message-ID: <CAL_JsqK6QURYdt-0mbuv6oeoqFr0acVh6Q7F2-FSXN-zOk34XA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI: dwc: Use an address in the driver data for
 MSI address
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <nks@flawful.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Niklas

On Fri, Sep 25, 2020 at 2:39 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> There's no need to allocate a page for the MSI address, we could use
> an address in the driver data.
>
> One side effect of this patch is fixing the MSI page leakage during
> suspend/resume. Take the pcie-tegra194.c for example, it calls
> dw_pcie_msi_init() in resume path, thus the previous MSI page is
> leaked.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 22 ++-----------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  2 files changed, 2 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index f08f4d97f321..bf25d783b5c5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -126,9 +126,7 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
>  {
>         struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -       u64 msi_target;
> -
> -       msi_target = (u64)pp->msi_data;
> +       u64 msi_target = virt_to_phys(&pp->msi_data);
>
>         msg->address_lo = lower_32_bits(msi_target);
>         msg->address_hi = upper_32_bits(msi_target);
> @@ -287,27 +285,11 @@ void dw_pcie_free_msi(struct pcie_port *pp)
>
>         irq_domain_remove(pp->msi_domain);
>         irq_domain_remove(pp->irq_domain);
> -
> -       if (pp->msi_page)
> -               __free_page(pp->msi_page);
>  }
>
>  void dw_pcie_msi_init(struct pcie_port *pp)
>  {
> -       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -       struct device *dev = pci->dev;
> -       u64 msi_target;
> -
> -       pp->msi_page = alloc_page(GFP_KERNEL);
> -       pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> -                                   DMA_FROM_DEVICE);
> -       if (dma_mapping_error(dev, pp->msi_data)) {
> -               dev_err(dev, "Failed to map MSI data\n");
> -               __free_page(pp->msi_page);
> -               pp->msi_page = NULL;
> -               return;
> -       }
> -       msi_target = (u64)pp->msi_data;
> +       u64 msi_target = virt_to_phys(&pp->msi_data);
>
>         /* Program the msi_data */
>         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f911760dcc69..a88e15a09745 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -195,7 +195,6 @@ struct pcie_port {
>         struct irq_domain       *irq_domain;
>         struct irq_domain       *msi_domain;
>         dma_addr_t              msi_data;

You should probably change the type here. u16 I guess since that's the
MSI data size.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

Would be nice to hear from others that have touched this code as with
Fixes it's going to get backported.

Rob


> -       struct page             *msi_page;
>         struct irq_chip         *msi_irq_chip;
>         u32                     num_vectors;
>         u32                     irq_mask[MAX_MSI_CTRLS];
> --
> 2.28.0
>
