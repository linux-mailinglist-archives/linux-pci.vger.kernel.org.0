Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A13B296507
	for <lists+linux-pci@lfdr.de>; Thu, 22 Oct 2020 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508690AbgJVTIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Oct 2020 15:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508666AbgJVTIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Oct 2020 15:08:41 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97922465B;
        Thu, 22 Oct 2020 19:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603393719;
        bh=LW+zas3af7dXjoe7QxdFLTLRVt53EpEk7WcsmCm6eFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ebROMbTtSy8Mkiz6KWTYhDw23tThdIaguNpzD40IB4AtXZlLkf/kj/qXr07WmRw45
         GxuDpV39OapVJiy9kocAFXHz6sZveQ8oucB7D3jZEUMbPholzrNpOpe4IhIpI7nKd1
         SFX79qOT5c+Jwb+dt87FZojbPjgHIiOQqOSEItf0=
Received: by mail-oi1-f171.google.com with SMTP id w141so2916136oia.2;
        Thu, 22 Oct 2020 12:08:39 -0700 (PDT)
X-Gm-Message-State: AOAM5331KjaaatPU50jybaHaGEEBs1o2BYUy1g7v1sbW24Bjrcln3h4S
        MKgyOtdWbP5SHbrhjpRF1s3lOl3yEnG0cbnQqg==
X-Google-Smtp-Source: ABdhPJymY2LlV+yGia2JpiwkoB+stWDifIbW9fJjBwwQob2vvpnFCmqk1vDaLgAxLZH4i21AjIWVcfTylCD9+65CYhg=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2670529oie.152.1603393718905;
 Thu, 22 Oct 2020 12:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201005121351.32516-1-vidyas@nvidia.com> <20201020195931.12470-1-vidyas@nvidia.com>
In-Reply-To: <20201020195931.12470-1-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Oct 2020 14:08:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+7caR1t=_v9Q_n43zEu9CNuiJmk0nPnvL8+S27rYhm9g@mail.gmail.com>
Message-ID: <CAL_Jsq+7caR1t=_v9Q_n43zEu9CNuiJmk0nPnvL8+S27rYhm9g@mail.gmail.com>
Subject: Re: [PATCH V2] PCI: dwc: Add support to handle prefetchable memory mapping
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kthota@nvidia.com, Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 20, 2020 at 2:59 PM Vidya Sagar <vidyas@nvidia.com> wrote:
>
> DWC sub-system currently doesn't differentiate between prefetchable and
> non-prefetchable memory aperture entries in the 'ranges' property and
> provides ATU mapping only for the first memory aperture entry out of all
> the entries present. This was introduced by the
> commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources").
> Mapping for a memory apreture is required if its CPU address and the bus
> address are different and the current mechanism works only if the memory
> aperture which needs mapping happens to be the first entry. It doesn't
> work either if the memory aperture that needs mapping is not the first
> entry or if both prefetchable and non-prefetchable apertures need mapping.

Well that's subtle...

> This patch fixes this issue by differentiating between prefetchable and
> non-prefetchable apertures in the 'ranges' property there by removing the
> dependency on the order in which they are specified and adds support for
> mapping prefetchable aperture using ATU region-3 if required.

Now you don't do any iATU entry for a 1:1 memory range which is a
change for pretty much every other platform. That means we leave the
PCI transaction config to the whims of how h/w designers hooked up the
sideband signals. I guess this is how Uniphier works as it only has 1
viewport...

I think the assignment should be in this order:
- config space
- non-prefetchable (IIRC, it's required)
- prefetchable
- i/o

Stopping assignment and warning if you run out of viewports. Looking
at the platforms, I think that would always work. There's only
uniphier and ls1012a where we run out. Those would still behave the
same.


>
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V2:
> * Rewrote commit subject and description
> * Addressed review comments from Lorenzo
>
>  .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
>  3 files changed, 46 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index db547ee6ff3a..dae6da39bb90 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -521,9 +521,42 @@ static struct pci_ops dw_pcie_ops = {
>         .write = pci_generic_config_write,
>  };
>
> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> +                                 struct resource_entry *win)
> +{
> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +       /* Check for prefetchable memory aperture */
> +       if (win->res->flags & IORESOURCE_PREFETCH && win->offset) {
> +               /* Number of view ports must at least be 4 to enable mapping */
> +               if (pci->num_viewport < 4) {
> +                       dev_warn(pci->dev,
> +                                "Insufficient ATU regions to map Prefetchable memory\n");
> +               } else {
> +                       dw_pcie_prog_outbound_atu(pci,
> +                                                 PCIE_ATU_REGION_INDEX3,
> +                                                 PCIE_ATU_TYPE_MEM,
> +                                                 win->res->start,
> +                                                 win->res->start - win->offset,
> +                                                 resource_size(win->res));
> +               }
> +       } else if (win->offset) { /* Non-prefetchable memory aperture */
> +               if (upper_32_bits(resource_size(win->res)))
> +                       dev_warn(pci->dev,
> +                                "Memory resource size exceeds max for 32 bits\n");

This is not designware specific. Either core code should check this or
write a DT schema to check it.

> +               dw_pcie_prog_outbound_atu(pci,
> +                                         PCIE_ATU_REGION_INDEX0,
> +                                         PCIE_ATU_TYPE_MEM,
> +                                         win->res->start,
> +                                         win->res->start - win->offset,
> +                                         resource_size(win->res));
> +       }
> +}
> +
>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>         u32 val, ctrl, num_ctrls;
> +       struct resource_entry *win;
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
>         /*
> @@ -578,13 +611,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>          * ATU, so we should not program the ATU here.
>          */
>         if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -               struct resource_entry *entry =
> -                       resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +               resource_list_for_each_entry(win, &pp->bridge->windows)
> +                       if (resource_type(win->res) == IORESOURCE_MEM)
> +                               dw_pcie_setup_mem_atu(pp, win);
>
> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> -                                         PCIE_ATU_TYPE_MEM, entry->res->start,
> -                                         entry->res->start - entry->offset,
> -                                         resource_size(entry->res));
>                 if (pci->num_viewport > 2)
>                         dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
>                                                   PCIE_ATU_TYPE_IO, pp->io_base,
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c2dea8fc97c8..b5e438b70cd5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>                                              int index, int type,
>                                              u64 cpu_addr, u64 pci_addr,
> -                                            u32 size)
> +                                            u64 size)

How was this working for you before? Looks like a different change
from what I broke.

>  {
>         u32 retries, val;
>         u64 limit_addr = cpu_addr + size - 1;
> @@ -245,8 +245,10 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>                                  lower_32_bits(pci_addr));
>         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_UPPER_TARGET,
>                                  upper_32_bits(pci_addr));
> -       dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1,
> -                                type | PCIE_ATU_FUNC_NUM(func_no));
> +       val = type | PCIE_ATU_FUNC_NUM(func_no);
> +       val = upper_32_bits(size - 1) ?
> +               val | PCIE_ATU_INCREASE_REGION_SIZE : val;
> +       dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL1, val);
>         dw_pcie_writel_ob_unroll(pci, index, PCIE_ATU_UNR_REGION_CTRL2,
>                                  PCIE_ATU_ENABLE);
>
> @@ -267,7 +269,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
>
>  static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>                                         int index, int type, u64 cpu_addr,
> -                                       u64 pci_addr, u32 size)
> +                                       u64 pci_addr, u64 size)
>  {
>         u32 retries, val;
>
> @@ -311,7 +313,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
>  }
>
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -                              u64 cpu_addr, u64 pci_addr, u32 size)
> +                              u64 cpu_addr, u64 pci_addr, u64 size)
>  {
>         __dw_pcie_prog_outbound_atu(pci, 0, index, type,
>                                     cpu_addr, pci_addr, size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9d2f511f13fa..21dd06831b50 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -80,10 +80,12 @@
>  #define PCIE_ATU_VIEWPORT              0x900
>  #define PCIE_ATU_REGION_INBOUND                BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND       0
> +#define PCIE_ATU_REGION_INDEX3         0x3
>  #define PCIE_ATU_REGION_INDEX2         0x2
>  #define PCIE_ATU_REGION_INDEX1         0x1
>  #define PCIE_ATU_REGION_INDEX0         0x0
>  #define PCIE_ATU_CR1                   0x904
> +#define PCIE_ATU_INCREASE_REGION_SIZE  BIT(13)
>  #define PCIE_ATU_TYPE_MEM              0x0
>  #define PCIE_ATU_TYPE_IO               0x2
>  #define PCIE_ATU_TYPE_CFG0             0x4
> @@ -295,7 +297,7 @@ void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>                                int type, u64 cpu_addr, u64 pci_addr,
> -                              u32 size);
> +                              u64 size);
>  void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>                                   int type, u64 cpu_addr, u64 pci_addr,
>                                   u32 size);
> --
> 2.17.1
>
