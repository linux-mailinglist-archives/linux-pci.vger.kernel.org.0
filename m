Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C33276F31
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIXLAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:00:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLAj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:00:39 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E497239D2;
        Thu, 24 Sep 2020 11:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600945238;
        bh=mcQstb6kgrv0RCLL5uYxJdTKMZzoQT1OGetbZvl4Dys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HoERfLtzBHHfF9t7LHk1EVr5ENzggxhqG1fq2bIBjO0rsHGK7+wyVwfYjlsSOHeVA
         M2Wa79HeFQQdgQZtj7cflzJuVlevXeBaUrbCsrOhW3X/dRNU9OBkViJu/G4EEt7sy5
         tU5Ik3Bfo84YfhmKKB2zzpIf67hmF9bIGgyaHe2M=
Received: by mail-oi1-f180.google.com with SMTP id v20so3230816oiv.3;
        Thu, 24 Sep 2020 04:00:38 -0700 (PDT)
X-Gm-Message-State: AOAM531Appt7O9pFAt8jBm2tWPQqJCLmPNwi6dlhl5HJdSGFsRaOOvRJ
        s9BAUFKezVDQ9qkEgUTUqpXxpJrjU0a+R4mJzi0=
X-Google-Smtp-Source: ABdhPJw672kHZvlPXq/Xj5fIkVqsPRuNnsOGNIheEW6trScKa826onwsLVZV11OPHvh1+Q14Z8+jPRWJ3pwlGNVeYa8=
X-Received: by 2002:a54:4517:: with SMTP id l23mr2228436oil.174.1600945237175;
 Thu, 24 Sep 2020 04:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200923142607.10c89bd2@xhacker.debian>
In-Reply-To: <20200923142607.10c89bd2@xhacker.debian>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 24 Sep 2020 13:00:26 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
Message-ID: <CAMj1kXEyQGEu7=-kbDuTDW9_xXkmns1HM2dQMrLn=XL9W88vJw@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: Move allocate and map page for msi out of dw_pcie_msi_init()
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thierry Reding <treding@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 23 Sep 2020 at 08:28, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> Currently, dw_pcie_msi_init() allocates and maps page for msi, then
> program the PCIE_MSI_ADDR_LO and PCIE_MSI_ADDR_HI. The Root Complex
> may lose power during suspend-to-RAM, so when we resume, we want to
> redo the latter but not the former. If designware based driver (for
> example, pcie-tegra194.c) calls dw_pcie_msi_init() in resume path, the
> previous msi page will be leaked.
>
> Move the allocate and map msi page from dw_pcie_msi_init() to
> dw_pcie_host_init() to fix this problem.
>
> Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Why do you allocate a page for this in the first place? Isn't
PCIE_MSI_ADDR_HI:PCIE_MSI_ADDR_LO simply a magic DMA address that
never gets forwarded across to the CPU side of the host bridge, and
triggers a SPI instead, which gets handled by reading
PCIE_MSI_INTR0_STATUS ?

Couldn't you just map the zero page instead?


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
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
