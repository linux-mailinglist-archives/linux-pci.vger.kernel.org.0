Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D92E9837
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbhADPP4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 10:15:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbhADPP4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 10:15:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E15A2224D2;
        Mon,  4 Jan 2021 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609773315;
        bh=p8kP/U9QN951y10f76W6/BibIiCnI+P7NCIXYJzkvtA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KCalrsAuywRlNVcWsfH2hODWuxNImvpyP/tb41E8hbejJSCEGX2YZb7Hbi+M4easn
         tSFuvo/suqLleLfbInN2O8QCzVOT4REzRNtCNaUH4RsIz5d7OnAljX/UX+cRJ2atvJ
         A1S74gFoAERuk+5PKQWtXrDoAoBBJTSQrVhK0qF1pK9oEvTty3qAcsp6LuNL/9tIf8
         HEpFzBtaIQ3dyzhd6bw90yPHYvc8dhwc8iJUtEInEDtn/+5Vbtpz+frF4eEtiZRZtw
         0MdUpqWxbECaGXxcGwpB00v2Ph0x+khA0gBP4ndLQgr3QcKu8Nz++jpdMh8h9MEbiX
         00/KxkhOu+F5g==
Received: by mail-ej1-f50.google.com with SMTP id b9so37292377ejy.0;
        Mon, 04 Jan 2021 07:15:14 -0800 (PST)
X-Gm-Message-State: AOAM5326nJDTGBGEQ8UXi5WNAgWeDb45D/xWBqFg9E2yIH1WmKvrBV68
        qnaMOvZWkMjWeW4ZOECokHPmSr3m/ZBOMhuJJA==
X-Google-Smtp-Source: ABdhPJyf7uupoU6sG5geL91AdWoU3hK2Fsuphz6syrA8HdaQFK5xN86Vgte38FB6Zx87006bAm5QabMwd1PJXp2Y7v0=
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr28583308ejf.468.1609773313402;
 Mon, 04 Jan 2021 07:15:13 -0800 (PST)
MIME-Version: 1.0
References: <20201111153559.19050-1-kishon@ti.com> <20201111153559.19050-12-kishon@ti.com>
 <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com> <992b5423-89a2-a03b-539d-a9b2822f598a@ti.com>
In-Reply-To: <992b5423-89a2-a03b-539d-a9b2822f598a@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 4 Jan 2021 08:15:00 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKT8WUVy4qhQkRuYLuqkQa11=7JzXcVxvNRsB0KFj+qVQ@mail.gmail.com>
Message-ID: <CAL_JsqKT8WUVy4qhQkRuYLuqkQa11=7JzXcVxvNRsB0KFj+qVQ@mail.gmail.com>
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

On Mon, Jan 4, 2021 at 6:13 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Rob,
>
> On 15/12/20 9:31 pm, Rob Herring wrote:
> > On Wed, Nov 11, 2020 at 9:37 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> >>
> >> Implement ->msi_map_irq() ops in order to map physical address to
> >> MSI address and return MSI data.
> >>
> >> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> >> ---
> >>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
> >>  1 file changed, 53 insertions(+)
> >>
> >> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> index 84cc58dc8512..1fe6b8baca97 100644
> >> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> >> @@ -382,6 +382,57 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
> >>         return 0;
> >>  }
> >>
> >> +static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
> >> +                                   phys_addr_t addr, u8 interrupt_num,
> >> +                                   u32 entry_size, u32 *msi_data,
> >> +                                   u32 *msi_addr_offset)
> >> +{
> >> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> >> +       u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> >> +       struct cdns_pcie *pcie = &ep->pcie;
> >> +       u64 pci_addr, pci_addr_mask = 0xff;
> >> +       u16 flags, mme, data, data_mask;
> >> +       u8 msi_count;
> >> +       int ret;
> >> +       int i;
> >> +
> >
> >
> >> +       /* Check whether the MSI feature has been enabled by the PCI host. */
> >> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> >> +       if (!(flags & PCI_MSI_FLAGS_ENABLE))
> >> +               return -EINVAL;
> >> +
> >> +       /* Get the number of enabled MSIs */
> >> +       mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
> >> +       msi_count = 1 << mme;
> >> +       if (!interrupt_num || interrupt_num > msi_count)
> >> +               return -EINVAL;
> >> +
> >> +       /* Compute the data value to be written. */
> >> +       data_mask = msi_count - 1;
> >> +       data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> >> +       data = data & ~data_mask;
> >> +
> >> +       /* Get the PCI address where to write the data into. */
> >> +       pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> >> +       pci_addr <<= 32;
> >> +       pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> >> +       pci_addr &= GENMASK_ULL(63, 2);
> >
> > Wouldn't all of the above be the same code for any endpoint driver? We
> > just need endpoint config space accessors for the same 32-bit only
> > access issues. Not asking for that in this series, but if that's the
> > direction we should go.
>
> Do you mean "endpoint" variant of pci_generic_config_read() which takes
> function number and capability offset? That could be done but we have to
> add support to traverse the linked list of capabilities though the
> capabilities are going to be at a fixed location for a given IP.

Well, the above code would call the equivalent of
pci_bus_read_config_*() functions which then calls driver specific
read/write ops like pci_generic_config_read().

Once we have common accessors, then functions to get the capability
offsets would be common too. It shouldn't matter that they happen to
be fixed, walking the linked list should work either way. Getting rid
of fixed offsets for the host side drivers is something I've been
doing too.

> Also in some cases, the writes are to a different register than the
> configuration space registers like vendor_id in Cadence EP should be
> written to Local Management register instead of the configuration space
> register.

We have the same issue on the host side as well. That just means we
need to wrap the generic ops functions.

Rob
