Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763753C0FF
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 00:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239777AbiFBWrP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 18:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbiFBWrO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 18:47:14 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C26D11A
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 15:47:13 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id rq11so12715387ejc.4
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pu75bWmrBbYHAw0OFfUcO0avMr1ot5HtxjbiP+g2b0=;
        b=bQTQJT0Q14fCxBGXzBNMiNwAgJmsUptbojmJ5kDmOcKl44mnQAWrNnh97RUMzzYDkv
         FH39yoZizrisDYwdKloMDZZaVw598diyW5L5GCQK5XSzdzEEBCHagagbbCtgHfuf/uj3
         Ksu/fE/XQabHkViVTOIEvEMuo/VXEZjpR2SoOvLi+dxorRQNX9j6ncG2PsuGnJO++0vA
         XSOWuB+WJGkqFMP319FD1E/XbIFjsxg9kBPDe4OK7Qb5WJ41M7HwfW0IzaXa/UIHYv00
         b6RpautIHtBd4XQCGKt9UCoMWzZAnCEDcshtoLhZpdHDPdmh9Mu1NXmqrXYq8H+u8dJi
         xWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pu75bWmrBbYHAw0OFfUcO0avMr1ot5HtxjbiP+g2b0=;
        b=Bm/tDPUHRRm4SOBz0iEd0bBxI9S326b/HSdHSw2WHxru9Sge8aOL9jFLfFIM3kmlvK
         FMsz+UWHX1wGt4V6CcS6vtCBmEbKrqFey73bVd32uWkkNNZfkSeaRExkV0vMrFXT7XbX
         izwXVI5eu5MaZut9liWiw6N5yrQu29ddDJbr/Dx+dduM8sm3gwlZ87ZAy/ME76BlEYaA
         ur2Nt7cC7lkKLqp7QbielJySK5YAR+4vg25BlwWnQgyGGFa38XdpYzo0aN9K74PqKTpj
         DIEubtWYAxrIfS80A8WvMf4XUuEMAzw7A2JtOQiealj7fz4V4NFkQ/RBc1aPVP3ba+Tr
         2mjg==
X-Gm-Message-State: AOAM532QBxG00fylWUl2MOsUyy8XySgPTCZU1YGrghD2jk6Q9CiniUqT
        iXAQ/JJ7VLPhXv3S+2JApQuAvddtGYbQtp+VZrjVmA==
X-Google-Smtp-Source: ABdhPJyDBimCwFU8GwUejJSnaLwopZ8mdmlNAnudYa0MFtBeTfetuVO2kGArO4IQ552v3S3vxozxlofhswmJmORlHLI=
X-Received: by 2002:a17:907:7ba9:b0:6fe:5636:1636 with SMTP id
 ne41-20020a1709077ba900b006fe56361636mr6433385ejc.463.1654210031999; Thu, 02
 Jun 2022 15:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220525223316.388490-1-willmcvicker@google.com>
In-Reply-To: <20220525223316.388490-1-willmcvicker@google.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Thu, 2 Jun 2022 15:46:56 -0700
Message-ID: <CABYd82YK9M6ZP8znpCxCA2RXUrjPiWen6_+Y+41V3DtBpEkK4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Fix MSI msi_msg dma mapping
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Cc: Android Kernel" <kernel-team@android.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 25, 2022 at 3:33 PM Will McVicker <willmcvicker@google.com> wrote:
>
> As of commit 07940c369a6b ("PCI: dwc: Fix MSI page leakage in
> suspend/resume"), the PCIe designware host driver has been using the
> driver data allocation for the msi_msg dma mapping which can result in
> a DMA_MAPPING_ERROR due to the DMA overflow check in
> dma_direct_map_page() when the address is greater than 32-bits (reported
> in [1]). The commit was trying to address a memory leak on
> suspend/resume by moving the MSI mapping to dw_pcie_host_init(), but
> subsequently dropped the page allocation thinking it wasn't needed.
>
> To fix the DMA mapping issue as well as make msi_msg DMA'able, let's
> switch back to allocating a 32-bit page for the msi_msg. To avoid the
> suspend/resume leak, we can allocate the page in dw_pcie_host_init()
> since that function shouldn't be called during suspend/resume.
>
> [1] https://lore.kernel.org/all/Yo0soniFborDl7+C@google.com/
>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 ++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h      |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f32d964..3655c6f88bf1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -267,8 +267,9 @@ static void dw_pcie_free_msi(struct pcie_port *pp)
>                 struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>                 struct device *dev = pci->dev;
>
> -               dma_unmap_single_attrs(dev, pp->msi_data, sizeof(pp->msi_msg),
> -                                      DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC);
> +               dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> +               if (pp->msi_page)
> +                       __free_page(pp->msi_page);
>         }
>  }
>
> @@ -392,12 +393,13 @@ int dw_pcie_host_init(struct pcie_port *pp)
>                         if (ret)
>                                 dev_warn(pci->dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>
> -                       pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
> -                                                     sizeof(pp->msi_msg),
> -                                                     DMA_FROM_DEVICE,
> -                                                     DMA_ATTR_SKIP_CPU_SYNC);
> +                       pp->msi_page = alloc_page(GFP_DMA32);
> +                       pp->msi_data = dma_map_page(pci->dev, pp->msi_page, 0, PAGE_SIZE,
> +                                                   DMA_FROM_DEVICE);
>                         if (dma_mapping_error(pci->dev, pp->msi_data)) {
>                                 dev_err(pci->dev, "Failed to map MSI data\n");
> +                               __free_page(pp->msi_page);
> +                               pp->msi_page = NULL;
>                                 pp->msi_data = 0;
>                                 goto err_free_msi;
>                         }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 7d6e9b7576be..b5f528536358 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -190,8 +190,8 @@ struct pcie_port {
>         int                     msi_irq;
>         struct irq_domain       *irq_domain;
>         struct irq_domain       *msi_domain;
> -       u16                     msi_msg;
>         dma_addr_t              msi_data;
> +       struct page             *msi_page;
>         struct irq_chip         *msi_irq_chip;
>         u32                     num_vectors;
>         u32                     irq_mask[MAX_MSI_CTRLS];
> --
> 2.36.1.124.g0e6072fb45-goog
>

Friendly ping for review.

Thanks,
Will
