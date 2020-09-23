Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4E4275DB1
	for <lists+linux-pci@lfdr.de>; Wed, 23 Sep 2020 18:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIWQl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Sep 2020 12:41:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQl7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Sep 2020 12:41:59 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 460B6212CC;
        Wed, 23 Sep 2020 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600879318;
        bh=H/X54/9jjWgX70+wPfPiiKTHZeodTG5ZIAFYl/owpiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xyw8QgUlBVbDnDx66/3JJe7kWGDnxv+A6AZroC4M6/hjmR4QXH2I6G1HvF/v/oQcj
         E09cUFRtjQ7bQHXaVTY3vGDQ/UUhzN+oTE975DvARbiGg7eeVVNoJZjL4Q+D1ujwy5
         Z/R7wxqrRzaJVmELmFNdNHaQw1Jz4HwjWSrzqRQ0=
Received: by mail-ot1-f49.google.com with SMTP id n61so318856ota.10;
        Wed, 23 Sep 2020 09:41:58 -0700 (PDT)
X-Gm-Message-State: AOAM531vz+1zE0w44jYDP7cqTe4irqcFVknoBghEZ9qoDj6Vxfl0U2Hb
        koQG0UdqGxY6DegB6e1aS+8WmL/idK4KG4qCzA==
X-Google-Smtp-Source: ABdhPJwLbfDZiK9Pm9S8+Ij5u6rYx0WjoXRoutVyMdSeHNE/MwsRZePtNTTSEW871CePVnni7eI/l+9oJjB3GKIsTiE=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr345792otp.107.1600879317500;
 Wed, 23 Sep 2020 09:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200923142607.10c89bd2@xhacker.debian>
In-Reply-To: <20200923142607.10c89bd2@xhacker.debian>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Sep 2020 10:41:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJV_8sCVB2fAi6kk19ZLbO+nKbk-kYsBNEbN+jR84LUgg@mail.gmail.com>
Message-ID: <CAL_JsqJV_8sCVB2fAi6kk19ZLbO+nKbk-kYsBNEbN+jR84LUgg@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of dw_pcie_msi_init()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 23, 2020 at 12:27 AM Jisheng Zhang
<Jisheng.Zhang@synaptics.com> wrote:
>
> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> may lose power during suspend-to-RAM, so when we resume, we want to
> redo the latter but not the former. If designware based driver (for
> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> previous msi page will be leaked.

It's worse than this. I think there's also error paths too leaking the
page. Also, there's never a dma_unmap_page call which should happen
before freeing.

> Move the allocate and map msi page from dw_pcie_msi_init() to
> dw_pcie_host_init() to fix this problem.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c       | 18 ++++++++++++-
>  .../pci/controller/dwc/pcie-designware-host.c | 27 +++++++++----------
>  2 files changed, 30 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index dc387724cf08..4301cf844a4c 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -490,7 +490,9 @@ static struct irq_chip dra7xx_pci_msi_bottom_irq_chip = {
>  static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
>  {
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +       struct device *dev = pci->dev;
>         u32 ctrl, num_ctrls;
> +       int ret;
>
>         pp->msi_irq_chip = &dra7xx_pci_msi_bottom_irq_chip;
>
> @@ -506,7 +508,21 @@ static int dra7xx_pcie_msi_host_init(struct pcie_port *pp)
>                                     ~0);
>         }
>
> -       return dw_pcie_allocate_domains(pp);
> +       ret = dw_pcie_allocate_domains(pp);
> +       if (ret)
> +               return ret;
> +
> +       pp->msi_page = alloc_page(GFP_KERNEL);
> +       pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
> +                                   DMA_FROM_DEVICE);
> +       ret = dma_mapping_error(dev, pp->msi_data);
> +       if (ret) {
> +               dev_err(dev, "Failed to map MSI data\n");
> +               __free_page(pp->msi_page);
> +               pp->msi_page = NULL;
> +               dw_pcie_free_msi(pp);
> +       }

I don't like having 2 copies of the same thing. Also, doesn't keystone
need this too?

The other thing is .msi_host_init() is abused by having an empty
function to disable MSI support. We should have a flag instead to
enable/disable MSI support and then we can key off of that in the
common code.

> +       return ret;
>  }
>
>  static const struct dw_pcie_host_ops dra7xx_pcie_host_ops = {
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9dafecba347f..c23ba64f64fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -294,20 +294,7 @@ void dw_pcie_free_msi(struct pcie_port *pp)
>
>  void dw_pcie_msi_init(struct pcie_port *pp)

Might be good to rename this function with exactly what it does.
There's too many 'init' and 'setup' functions...

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
> +       u64 msi_target = (u64)pp->msi_data;
>
>         /* Program the msi_data */
>         dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
> @@ -440,6 +427,18 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                                 irq_set_chained_handler_and_data(pp->msi_irq,
>                                                             dw_chained_msi_isr,
>                                                             pp);
> +
> +                       pp->msi_page = alloc_page(GFP_KERNEL);
> +                       pp->msi_data = dma_map_page(pci->dev, pp->msi_page,
> +                                                   0, PAGE_SIZE,
> +                                                   DMA_FROM_DEVICE);
> +                       ret = dma_mapping_error(pci->dev, pp->msi_data);
> +                       if (ret) {
> +                               dev_err(pci->dev, "Failed to map MSI data\n");
> +                               __free_page(pp->msi_page);
> +                               pp->msi_page = NULL;
> +                               goto err_free_msi;
> +                       }
>                 } else {
>                         ret = pp->ops->msi_host_init(pp);
>                         if (ret < 0)
> --
> 2.28.0
>
