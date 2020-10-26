Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E89F299148
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 16:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784284AbgJZPlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 11:41:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784274AbgJZPlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 11:41:01 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D92BE2242A;
        Mon, 26 Oct 2020 15:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726861;
        bh=On1puDX3q0PmU4wb7lNbIX0t14xreWLTAZs/PTcSHbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rwhuTTFr7RmihUwkHv3J3UfV5Y76DuFXIbAsZVyaCVuTBaJZuB0nwcREVNoG5gwQv
         PveS10nE0JcE2GWcSYIQdp6tkYqy0HwBWbJ4cdeyAaHGR35AkbuVjAMb9x7DimBzAQ
         PZFy5YiUduO6/Y4M+/QHIE6K3/iTgnUquyRdTHvs=
Received: by mail-oi1-f172.google.com with SMTP id u127so10889884oib.6;
        Mon, 26 Oct 2020 08:41:00 -0700 (PDT)
X-Gm-Message-State: AOAM530x6pmuQ3yXcRSnRC71nfT9gPP798Lg2qpkuXJbtRLzZjblcSvr
        7CUvJsHUnJIK8CzNO/BLnSZ377ovSQ5cL2ZIZw==
X-Google-Smtp-Source: ABdhPJwG7r6OCD247gug+6UcyA11VYpVkShlq/R+HXcH3OsuhZLtTc9S2gv/h9HFnYWYGRrg967JZshcNWAw073n5DE=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr13272586oib.106.1603726860182;
 Mon, 26 Oct 2020 08:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201023195655.11242-1-vidyas@nvidia.com> <20201023195655.11242-4-vidyas@nvidia.com>
In-Reply-To: <20201023195655.11242-4-vidyas@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 26 Oct 2020 10:40:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ2yO-es3AnE3tGcEx0c4ANxyAeZWjsbsrMA6LVzNa1tA@mail.gmail.com>
Message-ID: <CAL_JsqJ2yO-es3AnE3tGcEx0c4ANxyAeZWjsbsrMA6LVzNa1tA@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI: dwc: Add support to handle prefetchable memory mapping
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

On Fri, Oct 23, 2020 at 2:57 PM Vidya Sagar <vidyas@nvidia.com> wrote:
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
>
> This patch fixes this issue by differentiating between prefetchable and
> non-prefetchable apertures in the 'ranges' property there by removing the
> dependency on the order in which they are specified and adds support for
> mapping prefetchable aperture using ATU region-3 if required.
>
> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")

Fixes should come first, then new features.

> Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/

'Link' is the link for this message and should be a lore.kernel.org
link. Maintainers will add it.

>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> Changes from previous versions:
> * Addressed Rob's comments and as part of that split the patch into three sub-patches
> * Rewrote commit subject and description
> * Addressed review comments from Lorenzo
>
>  .../pci/controller/dwc/pcie-designware-host.c | 39 ++++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 34 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 674f32db85ca..a1f319ccd816 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -529,9 +529,39 @@ static struct pci_ops dw_pcie_ops = {
>         .write = pci_generic_config_write,
>  };
>
> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> +                                 struct resource_entry *win)
> +{
> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +       /* Check for prefetchable memory aperture */
> +       if (win->res->flags & IORESOURCE_PREFETCH) {
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
> +       } else { /* Non-prefetchable memory aperture */
> +               dw_pcie_prog_outbound_atu(pci,
> +                                         PCIE_ATU_REGION_INDEX0,
> +                                         PCIE_ATU_TYPE_MEM,
> +                                         win->res->start,
> +                                         win->res->start - win->offset,
> +                                         resource_size(win->res));
> +       }
> +}
> +

This is in no way a minimal fix. I'll send my proposed fix.

>  void dw_pcie_setup_rc(struct pcie_port *pp)
>  {
>         u32 val, ctrl, num_ctrls;
> +       struct resource_entry *win;
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>
>         /*
> @@ -586,13 +616,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
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
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e7f441441db2..21dd06831b50 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -80,6 +80,7 @@
>  #define PCIE_ATU_VIEWPORT              0x900
>  #define PCIE_ATU_REGION_INBOUND                BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND       0
> +#define PCIE_ATU_REGION_INDEX3         0x3
>  #define PCIE_ATU_REGION_INDEX2         0x2
>  #define PCIE_ATU_REGION_INDEX1         0x1
>  #define PCIE_ATU_REGION_INDEX0         0x0
> --
> 2.17.1
>
