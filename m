Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676012DB0CD
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 17:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgLOQCY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 11:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgLOQCU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Dec 2020 11:02:20 -0500
X-Gm-Message-State: AOAM530+4WJ1aG2hHbP2t37mSuwJ4oT6bskNspQcGZOlpNFJlddUhzfI
        9Td3TZ/mr6qAb8wbPiSdwGyEC/ufBzVhzkEabQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608048098;
        bh=qkXORLSczMYIGgm4TRmpzxFMYrqSUAG1qScBIBBvO2w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TSkGPz9HS3BEF456KrpHsjgNO20bDWQLM4lQEIoSbIHtACo/crOcu+YrpYKLoWdZe
         b89EgoXiEDy1bMkwyRq14RINWg2h+0hafcJrfrLT7Gw5t+dFVSh+v+KnLH5RGhrQ20
         PJx/P4/SmbRZUMKcVDHscxd7a/bL/sMXPFCqA+E37fmZjZH0fxdl8rLBRSYPKSbrwF
         31vIOkLk8OCPu2ezZAQBpRq1m+E1v6Cb8LUeeg5/U+0k2+seZ31InssUubTg8quqts
         7GEbHO97MnCR2jxeGCW1tH8xSiDAKz50rO9rcMkaADP4wUfq2bi5cQkTduqMkFrrpS
         95O/zhdwXrxPg==
X-Google-Smtp-Source: ABdhPJwdWryKXagk9cpZnUkyQ2HJtEyx7PK81m9x3dkM+ArsS56YV4eOyna5XThKS7LWtESiqA706YAJEkxFslJwtzc=
X-Received: by 2002:a17:906:d784:: with SMTP id pj4mr26750000ejb.360.1608048097128;
 Tue, 15 Dec 2020 08:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20201111153559.19050-1-kishon@ti.com> <20201111153559.19050-12-kishon@ti.com>
In-Reply-To: <20201111153559.19050-12-kishon@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Dec 2020 10:01:25 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Message-ID: <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Subject: Re: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        PCI <linux-pci@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 9:37 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Implement ->msi_map_irq() ops in order to map physical address to
> MSI address and return MSI data.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 84cc58dc8512..1fe6b8baca97 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -382,6 +382,57 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>         return 0;
>  }
>
> +static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
> +                                   phys_addr_t addr, u8 interrupt_num,
> +                                   u32 entry_size, u32 *msi_data,
> +                                   u32 *msi_addr_offset)
> +{
> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +       struct cdns_pcie *pcie = &ep->pcie;
> +       u64 pci_addr, pci_addr_mask = 0xff;
> +       u16 flags, mme, data, data_mask;
> +       u8 msi_count;
> +       int ret;
> +       int i;
> +


> +       /* Check whether the MSI feature has been enabled by the PCI host. */
> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +       if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +               return -EINVAL;
> +
> +       /* Get the number of enabled MSIs */
> +       mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
> +       msi_count = 1 << mme;
> +       if (!interrupt_num || interrupt_num > msi_count)
> +               return -EINVAL;
> +
> +       /* Compute the data value to be written. */
> +       data_mask = msi_count - 1;
> +       data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> +       data = data & ~data_mask;
> +
> +       /* Get the PCI address where to write the data into. */
> +       pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> +       pci_addr <<= 32;
> +       pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> +       pci_addr &= GENMASK_ULL(63, 2);

Wouldn't all of the above be the same code for any endpoint driver? We
just need endpoint config space accessors for the same 32-bit only
access issues. Not asking for that in this series, but if that's the
direction we should go.

> +
> +       for (i = 0; i < interrupt_num; i++) {
> +               ret = cdns_pcie_ep_map_addr(epc, fn, addr,
> +                                           pci_addr & ~pci_addr_mask,
> +                                           entry_size);
> +               if (ret)
> +                       return ret;
> +               addr = addr + entry_size;
> +       }
> +
> +       *msi_data = data;
> +       *msi_addr_offset = pci_addr & pci_addr_mask;
> +
> +       return 0;
> +}
> +
>  static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
>                                       u16 interrupt_num)
>  {
> @@ -481,6 +532,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
>         .linkup_notifier = false,
>         .msi_capable = true,
>         .msix_capable = true,
> +       .align = 256,
>  };
>
>  static const struct pci_epc_features*
> @@ -500,6 +552,7 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>         .set_msix       = cdns_pcie_ep_set_msix,
>         .get_msix       = cdns_pcie_ep_get_msix,
>         .raise_irq      = cdns_pcie_ep_raise_irq,
> +       .map_msi_irq    = cdns_pcie_ep_map_msi_irq,
>         .start          = cdns_pcie_ep_start,
>         .get_features   = cdns_pcie_ep_get_features,
>  };
> --
> 2.17.1
>
