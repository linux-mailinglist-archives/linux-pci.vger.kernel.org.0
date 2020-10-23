Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C7F297275
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462899AbgJWPhk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 11:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462875AbgJWPhk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Oct 2020 11:37:40 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDB621D47;
        Fri, 23 Oct 2020 15:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603467459;
        bh=7PkBHCYEbyNP8onfA6mvPaVgTh+GNXLRKpFjWBF8efY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rxXGT1pfR2VL9s4O/YTW7JT5f4VjzpMRFW4BuvzGMaxmygBMhH6TaPlBXthmc9LsK
         NZEO+oH9lqi3BEMmrHISxLQLs4A988qqcJpV1G4unMMxtIzLlqGJ1BWc/MbitSnBfx
         725t8z8HTjZ54fpVZfLOck6jCEz6XfUblH6XseQc=
Received: by mail-oi1-f173.google.com with SMTP id l4so2262203oii.13;
        Fri, 23 Oct 2020 08:37:39 -0700 (PDT)
X-Gm-Message-State: AOAM533t8Lr2nJS8wx1Pmri+W3VoQ0N3Urn406Gqf1ByUGStyd1Ldbw3
        v/5g4nwhTnS9lNefRmhUDNX8sn/zeCCc/hb4YQ==
X-Google-Smtp-Source: ABdhPJzLaW1h+KEFpdaDOvwAW4UnoYFK+ea2NKbLArGAms1NIFC981gZ21I4aTPiIV13hMa+Xhlv6r/8EIcMIG34X34=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2237219oie.152.1603467458423;
 Fri, 23 Oct 2020 08:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201005121351.32516-1-vidyas@nvidia.com> <20201020195931.12470-1-vidyas@nvidia.com>
 <CAL_Jsq+7caR1t=_v9Q_n43zEu9CNuiJmk0nPnvL8+S27rYhm9g@mail.gmail.com> <baa80ff4-5510-5c7b-303c-454adbf88a19@nvidia.com>
In-Reply-To: <baa80ff4-5510-5c7b-303c-454adbf88a19@nvidia.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 23 Oct 2020 10:37:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJbxuwwWqL3c_N9Rufk4TDoOBwETiUQqiE0P+W+d0RDow@mail.gmail.com>
Message-ID: <CAL_JsqJbxuwwWqL3c_N9Rufk4TDoOBwETiUQqiE0P+W+d0RDow@mail.gmail.com>
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

On Fri, Oct 23, 2020 at 2:38 AM Vidya Sagar <vidyas@nvidia.com> wrote:
>
>
>
> On 10/23/2020 12:38 AM, Rob Herring wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Oct 20, 2020 at 2:59 PM Vidya Sagar <vidyas@nvidia.com> wrote:
> >>
> >> DWC sub-system currently doesn't differentiate between prefetchable and
> >> non-prefetchable memory aperture entries in the 'ranges' property and
> >> provides ATU mapping only for the first memory aperture entry out of all
> >> the entries present. This was introduced by the
> >> commit 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources").
> >> Mapping for a memory apreture is required if its CPU address and the bus
> >> address are different and the current mechanism works only if the memory
> >> aperture which needs mapping happens to be the first entry. It doesn't
> >> work either if the memory aperture that needs mapping is not the first
> >> entry or if both prefetchable and non-prefetchable apertures need mapping.
> >
> > Well that's subtle...
> >
> >> This patch fixes this issue by differentiating between prefetchable and
> >> non-prefetchable apertures in the 'ranges' property there by removing the
> >> dependency on the order in which they are specified and adds support for
> >> mapping prefetchable aperture using ATU region-3 if required.
> >
> > Now you don't do any iATU entry for a 1:1 memory range which is a
> > change for pretty much every other platform. That means we leave the
> > PCI transaction config to the whims of how h/w designers hooked up the
> > sideband signals. I guess this is how Uniphier works as it only has 1
> > viewport...
> >
> > I think the assignment should be in this order:
> > - config space
> > - non-prefetchable (IIRC, it's required)
> > - prefetchable
> > - i/o
> >
> > Stopping assignment and warning if you run out of viewports. Looking
> > at the platforms, I think that would always work. There's only
> > uniphier and ls1012a where we run out. Those would still behave the
> > same.
> As I see from the code this is how the current mapping is done
>
> Region-0: [Fixed] Non-Prefetchable memory mapping
>
> Region-1: [Shared] if the num of view ports <= 2
>          Used for I/O by default but whenever config space is accessed,
> it is programmed to generate config space, and once done, will program
> it back for I/O generation. I'm not sure how they are synchonized when
> two different entities are trying to access the config space as well as
> the I/O at the same time.  I don't see any locking mechanism (or am I
> missing something here??)

They aren't synchronized. We just get lucky that I/O and config
accesses aren't interleaved frequently. IMO, we should just not
support I/O space on those platforms. AIUI, almost everything doesn't
use I/O nowadays.

>            [Fixed] if the num of view ports > 2
>          Used to generate configuration space accesses
>
> Region-2: [Fixed] I/O accesses
>
> Region-3: [Fixed] Prefetchable memory mapping (This patch is adding it)
>
> I honestly think that an attempt to re-assing what region is used for
> what purpose should go into a different patch.

Normally, I'd agree for a fix. If you want to fix it in a minimal way
such that we just setup the last memory region instead of the first,
then that's fine. But to implement the review feedback, you will
simply be adding support for multiple memory regions. The ATU doesn't
care about prefetchable or not. I think it will end up being a more
simple implementation if you just do the I/O region last and only if
you have an available.

>
> I agree that I'm removing configuring an iATU region if it is for 1:1
> memory mapping. What I heard from our HW designers is that it is the
> default behavior of the Synopsys IP that if the CPU access falls in the
> aperture owned by Synopsys IP and there is no iATU region mapped to
> capture and generate any specific transaction for that address, then, by
> default it generates a memory transaction over the PCIe bus.
> It is also possible that some implementors might have chosen to alter
> this behavior.

If we assume they haven't, that pretty much guarantees they did. :)

> In any case, I can continue to have the iATU programming
> done irrespective of whether it is for 1:1 mapping or not.
>
> >
> >
> >>
> >> Fixes: 0f71c60ffd26 ("PCI: dwc: Remove storing of PCI resources")
> >> Link: http://patchwork.ozlabs.org/project/linux-pci/patch/20200513190855.23318-1-vidyas@nvidia.com/
> >>
> >> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> >> ---
> >> V2:
> >> * Rewrote commit subject and description
> >> * Addressed review comments from Lorenzo
> >>
> >>   .../pci/controller/dwc/pcie-designware-host.c | 42 ++++++++++++++++---
> >>   drivers/pci/controller/dwc/pcie-designware.c  | 12 +++---
> >>   drivers/pci/controller/dwc/pcie-designware.h  |  4 +-
> >>   3 files changed, 46 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> index db547ee6ff3a..dae6da39bb90 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> >> @@ -521,9 +521,42 @@ static struct pci_ops dw_pcie_ops = {
> >>          .write = pci_generic_config_write,
> >>   };
> >>
> >> +static void dw_pcie_setup_mem_atu(struct pcie_port *pp,
> >> +                                 struct resource_entry *win)
> >> +{
> >> +       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >> +
> >> +       /* Check for prefetchable memory aperture */
> >> +       if (win->res->flags & IORESOURCE_PREFETCH && win->offset) {
> >> +               /* Number of view ports must at least be 4 to enable mapping */
> >> +               if (pci->num_viewport < 4) {
> >> +                       dev_warn(pci->dev,
> >> +                                "Insufficient ATU regions to map Prefetchable memory\n");
> >> +               } else {
> >> +                       dw_pcie_prog_outbound_atu(pci,
> >> +                                                 PCIE_ATU_REGION_INDEX3,
> >> +                                                 PCIE_ATU_TYPE_MEM,
> >> +                                                 win->res->start,
> >> +                                                 win->res->start - win->offset,
> >> +                                                 resource_size(win->res));
> >> +               }
> >> +       } else if (win->offset) { /* Non-prefetchable memory aperture */
> >> +               if (upper_32_bits(resource_size(win->res)))
> >> +                       dev_warn(pci->dev,
> >> +                                "Memory resource size exceeds max for 32 bits\n");
> >
> > This is not designware specific. Either core code should check this or
> > write a DT schema to check it.
> Ok. I'll move it to pci_parse_request_of_pci_ranges() API. A change like
> below would do right?

Yes.

>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index ac24cd5439a9..6d872458196c 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -556,6 +556,11 @@ static int pci_parse_request_of_pci_ranges(struct
> device *dev,
>                          break;
>                  case IORESOURCE_MEM:
>                          res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> +
> +                       if (!(res->flags & IORESOURCE_PREFETCH))
> +                               if (upper_32_bits(resource_size(res)))
> +                                       dev_warn(dev,
> +                                                "Memory resource size
> exceeds max for 32 bits\n");
>                          break;
>                  }
>          }
>
> I hope that is the right place for it.
>
> >
> >> +               dw_pcie_prog_outbound_atu(pci,
> >> +                                         PCIE_ATU_REGION_INDEX0,
> >> +                                         PCIE_ATU_TYPE_MEM,
> >> +                                         win->res->start,
> >> +                                         win->res->start - win->offset,
> >> +                                         resource_size(win->res));
> >> +       }
> >> +}
> >> +
> >>   void dw_pcie_setup_rc(struct pcie_port *pp)
> >>   {
> >>          u32 val, ctrl, num_ctrls;
> >> +       struct resource_entry *win;
> >>          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> >>
> >>          /*
> >> @@ -578,13 +611,10 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
> >>           * ATU, so we should not program the ATU here.
> >>           */
> >>          if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> >> -               struct resource_entry *entry =
> >> -                       resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> >> +               resource_list_for_each_entry(win, &pp->bridge->windows)
> >> +                       if (resource_type(win->res) == IORESOURCE_MEM)
> >> +                               dw_pcie_setup_mem_atu(pp, win);
> >>
> >> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> >> -                                         PCIE_ATU_TYPE_MEM, entry->res->start,
> >> -                                         entry->res->start - entry->offset,
> >> -                                         resource_size(entry->res));
> >>                  if (pci->num_viewport > 2)
> >>                          dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
> >>                                                    PCIE_ATU_TYPE_IO, pp->io_base,
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> >> index c2dea8fc97c8..b5e438b70cd5 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> >> @@ -228,7 +228,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
> >>   static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, u8 func_no,
> >>                                               int index, int type,
> >>                                               u64 cpu_addr, u64 pci_addr,
> >> -                                            u32 size)
> >> +                                            u64 size)
> >
> > How was this working for you before? Looks like a different change
> > from what I broke.
> Tegra194 has a 1:1 mapping for prefetchable memory as of today. But,
> when it is changed to a non 1:1 mapping, we need this support.

It's not about a non 1:1 map, but the size. In any case, it's a
separate change from fixing the regression.

Rob
