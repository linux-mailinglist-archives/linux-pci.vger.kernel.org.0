Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD1355CF4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 22:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhDFUfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 16:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:36744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhDFUfQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 16:35:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46D4B613D5;
        Tue,  6 Apr 2021 20:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617741308;
        bh=N/P/v83SVqNFY3Fry7EvoEZEpk4y/c7ESbkj/VS1lHg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CiNE4Z4BihALsyCnKHSZxUeDOGqCP4QtrZKYtJ0+3H7wfbdlejkzy4MtQ/LOQm9v7
         Y4YEbo0XPX4LU3hpaZAIG1XgEnZ/tUbHzltHYCvZNfGYnUYmgOs9vEeC85Wdp4Nckf
         s743+1JMPYonwGWYoqyezxwN/8qTZF73UE4s646s1bZ30gsXT9bZfLuda10Fx1+Ub0
         9tK5P1svYqZd5d+o+SRXysnR9jSH4QMYsxgisLf8U3WxLWnEmwDck499AI4WOTVUVC
         TLPVo3LZCI2x99IgIYoQFI/kOKKQSm3TXe7LbbzXqIFY0e+aL2yWMPnQQFT6cG5UO2
         IQ1S5xCiXyruA==
Received: by mail-qv1-f51.google.com with SMTP id 30so7862642qva.9;
        Tue, 06 Apr 2021 13:35:08 -0700 (PDT)
X-Gm-Message-State: AOAM5335GdCOpgOibbDJ8Plczoqa64hN6HGInSRdMaE04vsUet0wZh4U
        QSkurOmr4oT9yR0bgUaLyQV+rMFyRuFnlf/IYg==
X-Google-Smtp-Source: ABdhPJwg+M3sUpoOAcY6QNJB29EAcEzTm+oglmAhJGlpHQdhW52fxF5MqlsGat4RgDZvcKKE9l41rMv0BC2r+Cq+9Gc=
X-Received: by 2002:a05:6214:18d2:: with SMTP id cy18mr30403123qvb.50.1617741307499;
 Tue, 06 Apr 2021 13:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com> <20210406142004.GA25082@lpieralisi>
In-Reply-To: <20210406142004.GA25082@lpieralisi>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Apr 2021 15:34:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+TKsZpHsjm0dBVTGdCMeDYLeOxqFBmNhuM_-xLizX6Fg@mail.gmail.com>
Message-ID: <CAL_Jsq+TKsZpHsjm0dBVTGdCMeDYLeOxqFBmNhuM_-xLizX6Fg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic
 using CCI
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Robin Murphy <robin.murphy@arm.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 9:20 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> [+ Rob, Robin]
>
> On Mon, Feb 22, 2021 at 02:17:31PM +0530, Bharat Kumar Gogada wrote:
> > Add support for routing PCIe DMA traffic coherently when
> > Cache Coherent Interconnect (CCI) is enabled in the system.
> > The "dma-coherent" property is used to determine if CCI is enabled
> > or not.
> > Refer to https://developer.arm.com/documentation/ddi0470/k/preface
> > for the CCI specification.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> > ---
> >  drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> > index 07e36661bbc2..8689311c5ef6 100644
> > --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> > +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> > @@ -26,6 +26,7 @@
> >
> >  /* Bridge core config registers */
> >  #define BRCFG_PCIE_RX0                       0x00000000
> > +#define BRCFG_PCIE_RX1                       0x00000004
> >  #define BRCFG_INTERRUPT                      0x00000010
> >  #define BRCFG_PCIE_RX_MSG_FILTER     0x00000020
> >
> > @@ -128,6 +129,7 @@
> >  #define NWL_ECAM_VALUE_DEFAULT               12
> >
> >  #define CFG_DMA_REG_BAR                      GENMASK(2, 0)
> > +#define CFG_PCIE_CACHE                       GENMASK(7, 0)
> >
> >  #define INT_PCI_MSI_NR                       (2 * 32)
> >
> > @@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
> >       nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
> >                         BRCFG_PCIE_RX_MSG_FILTER);
> >
> > +     /* This routes the PCIe DMA traffic to go through CCI path */
> > +     if (of_dma_is_coherent(dev->of_node))
> > +             nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
> > +                               CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
> > +
>
> This is weird. FW is telling us that the RC is DMA coherent hence
> we have to program the RC so that it is indeed DMA coherent.
>
> It does not make much sense. I think this is a set-up that should be
> programmed by firmware and reported to the kernel via the standard
> "dma-coherent" property. The kernel can read that register to check the
> HW configuration complies with the DT property.
>
> I'd like to get RobH/Robin thoughts on this before proceeding - they
> have more insights about the DT dma-coherent usage/bindings and
> expected behaviour.

Without the above change or firmware setup, a DT with 'dma-coherent'
and a kernel without it will be broken because the above register
won't be configured, yet we'll be using coherent DMA ops.

Originally when I added 'dma-coherent' (for Calxeda h/w), I had to do
all the coherent path setup in the kernel to ensure the h/w setup was
in-sync with the DMA ops. Nowadays, it's probably safe to assume the
OS has coherent support, but can we say that for sure for all OSs?

It also is going to depend if this register survives resets of the
module. If not, then it needs to be done in the kernel.

Rob
