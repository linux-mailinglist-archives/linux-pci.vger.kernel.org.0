Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115F34B0BD1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240421AbiBJLGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 06:06:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiBJLGL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 06:06:11 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E443D1015;
        Thu, 10 Feb 2022 03:06:12 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g14so14233410ybs.8;
        Thu, 10 Feb 2022 03:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSXTr8EbSggRAILOsifB7L+WTvBTHnKRcWh9Uy6RMsI=;
        b=IapKPtHaA4c/p6NPNWO59i3DRLOAboIm8zEmA/PrlzfF2Fgw5Hui86uyhdri3qtsoB
         DJUzoEIh0Sm6qFsLIBmStpCzB+51LrAMP9ade4ahB0BEHXPrlN+8NR5VaFVik88L39Cp
         //fSQqX4eqkbG0pCTM8bahvaUx4uALuAERxrk+fkLNWv2VQ8HDmPeF0oDESfJJe4r74J
         EcukBdwpUgFoVMcU3RJl1SBAO2w6PRWYKOVd0ZPTpklLhNDOEooMDwj4MIXFjHLYOtKf
         e65tLXyzzz4YapTsFCD7YkRdhKScm8mFIhY6qVlJxBn5nnP7Cf2PrqfpsvjyQghX7Zd0
         Gj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSXTr8EbSggRAILOsifB7L+WTvBTHnKRcWh9Uy6RMsI=;
        b=YK1aJe26uywhafTjt23VtDXV/J7nLBAt5RqPBLpqqR08oPhw9bzPIBoRnPtTzP0aA7
         mxuh1B8bya8/LCNUvqnANmuXJ8/KVYOZz+lzwujMs2X1e7sIQeWMUU0QXXu/CaXaJeKV
         0Z+Jl7Ti64FKulwGIKQ8yMwET7Nw+MhcSVBdPBLpJraFgSGm8jYbivwGMLvS0mU/RBTQ
         yo7YGD5vN3de7Kuz1DaPCX//37/J7Kbhi1JjwllvPRHb4hpScp8udoG1VJ4e/I2kIZW0
         i34Wy/snKZuTZSghT2eUTWKNdtKvgMWCpS3kqM4jEQ6Pa2skYLrV6zF87kowoQSUB3tX
         vaLQ==
X-Gm-Message-State: AOAM532sVM/uchz6YhD2QPvFR9HbZusrn9thOfJkGjOicPI3Km5d2x5S
        vcfJskn9WmngQbSNZ1mZymtMGWJUP0zgS3v9t+E=
X-Google-Smtp-Source: ABdhPJzhQRBibnT4EIVhPnNYy4wRcBBzDm5AgJALelT2TvVSoiTG1+8VPhHvNfma4t62mqYkVJ3N29QUkIbi6+K+nQ4=
X-Received: by 2002:a81:c607:: with SMTP id l7mr6604698ywi.265.1644491172099;
 Thu, 10 Feb 2022 03:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220210084052.GA69529@thinkpad> <CA+V-a8tivrjPoae69pqH1D+B=_Bd7ZzKjCA0PcfBz7Rpf022mA@mail.gmail.com>
 <20220210105023.GB69529@thinkpad>
In-Reply-To: <20220210105023.GB69529@thinkpad>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 10 Feb 2022 11:05:45 +0000
Message-ID: <CA+V-a8tfUgvzPyMe_FHuz=8mmC6dPHP7E=e+nCzOey04vCcAkg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] PCIe EPF support for internal DMAC handling and
 driver update for R-Car PCIe EP to support DMAC
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 10, 2022 at 10:50 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Feb 10, 2022 at 09:24:19AM +0000, Lad, Prabhakar wrote:
> > Hi,
> >
> > On Thu, Feb 10, 2022 at 8:40 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Jan 26, 2022 at 07:50:38PM +0000, Lad Prabhakar wrote:
> > > > Hi All,
> > > >
> > > > The current PCIe EPF framework supports DMA data transfers using external
> > > > DMA only, this patch series aims to add support for platforms supporting
> > > > internal DMAC on PCIe for data transfers.
> > > >
> > > > R-Car PCIe supports internal DMAC to transfer data between Internal Bus to
> > > > PCI Express and vice versa. Last patch fills up the required flags and ops
> > > > to support internal DMAC.
> > > >
> > > > Patches 1-3 are for PCIe EPF core to support internal DMAC handling, patch
> > > > 4/5 is to fix test cases based on the conversation [1].
> > > >
> > >
> > > This looks similar to the Synopsys eDMA IP [1] that goes with the Synopsys PCIe
> > > endpoint IP. Why can't you represent it as a dmaengine driver and use the
> > > existing DMA support?
> > >
> > Let me have a look. Could you please share a link to the Synopsys PCIe
> > endpoint HW manual (the driver doesn't have a binding doc).
> >
>
> I don't think the PCIe reference manual is available publicly. And you are right
> that the driver is not tied to devicetree. The reason is, it gets probed using
> the PCI ID of the EP and all the resources are defined statically in the driver
> itself.
>
In R-Car PCIe the internal dmac is part of the PCIe block itself [0]
and not a separate block. I don't see any drivers implementing the
internal dmac drivers as a DMA engine driver. For example the Renesas
SDHI driver has internal dmac too, this is handled in the SDHI driver
itself [1] and not implemented as DMA engine driver. Let me know if my
understanding is wrong here.

[0] https://elixir.bootlin.com/linux/v5.17-rc3/source/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml#L76
[1] https://elixir.bootlin.com/linux/v5.17-rc3/source/drivers/mmc/host/renesas_sdhi_internal_dmac.c

Cheers,
Prabhakar

> Thanks,
> Mani
>
> > Cheers,
> > Prabhakar
> >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/dw-edma
> > >
> > > > Patches are based on top of [1] next branch.
> > > >
> > > > [0] https://www.spinics.net/lists/linux-pci/msg92385.html
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
> > > >
> > > > Cheers,
> > > > Prabhakar
> > > >
> > > > Lad Prabhakar (5):
> > > >   PCI: endpoint: Add ops and flag to support internal DMAC
> > > >   PCI: endpoint: Add support to data transfer using internal dmac
> > > >   misc: pci_endpoint_test: Add driver data for Renesas RZ/G2{EHMN}
> > > >   misc: pci_endpoint_test: Add support to pass flags for buffer
> > > >     allocation
> > > >   PCI: rcar-ep: Add support for DMAC
> > > >
> > > >  drivers/misc/pci_endpoint_test.c              |  56 ++++-
> > > >  drivers/pci/controller/pcie-rcar-ep.c         | 227 ++++++++++++++++++
> > > >  drivers/pci/controller/pcie-rcar.h            |  23 ++
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++----
> > > >  drivers/pci/endpoint/pci-epf-core.c           |  32 +++
> > > >  include/linux/pci-epc.h                       |   8 +
> > > >  include/linux/pci-epf.h                       |   7 +
> > > >  7 files changed, 483 insertions(+), 54 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > > >
