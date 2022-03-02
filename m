Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D5E4CB046
	for <lists+linux-pci@lfdr.de>; Wed,  2 Mar 2022 21:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiCBUuu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Mar 2022 15:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240153AbiCBUuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Mar 2022 15:50:46 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91413DBD2E
        for <linux-pci@vger.kernel.org>; Wed,  2 Mar 2022 12:49:58 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id qx21so6265489ejb.13
        for <linux-pci@vger.kernel.org>; Wed, 02 Mar 2022 12:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFEJyvKNrk0x243QAHZ6hHbi3fA5VKzYBTQg5puC4mM=;
        b=eJHGZBpm9wGhGr/tBroUaNWaZ5TN4K7Vgx492MVO5Djvkbs/iI9GucwbfASdyzb8I3
         MNjFxgIycKOvEOW09x8YHU+L2Szn7cJADhk3HgWppiPiuD9XPTU0uMjAbMSxaLRPjGR+
         B8PbBRSwrSTsHvIYsXyqcN5viOtrYX5LQNk/rr6THIT4PkiqqE9UTEd6HLX+qNqYHG0k
         IiAsTSKCB42kPSHX9sqWx9+QWqXh3xBIcnBzxqtGAwnXA1NwHZlGCbVgcnQpWFTxpFhg
         PQpI7IF+F7613D66Tvq2y70qBzj62/Cti+upDvB6mO/uCHN0ml5NI162n6IHnrW1n7WW
         SY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFEJyvKNrk0x243QAHZ6hHbi3fA5VKzYBTQg5puC4mM=;
        b=J2GDDwaBAlMJP7Z6MSvyRIMeY/RsJGuZWo7HbRMpv8VSB2FMinGXR8P2YsjBL2Lj8M
         5onmmToth23SteDBG7l5Khk7h2NEPpLM9suPoOR0MVwUye9phyxyAJDmFpI46V6/yocN
         WTIoA1FIFXiNx0XL+el2MCFrvf2qu0MVVmEL8Uc3/Db0I/3rFBixVtnvzTYHGtDvtdJQ
         67mtUNhV7QUqvQdsxnonr3CNG/wSKUTp6vajfo3yCDMcqaeUGZlrRGPemHztuJr9smfY
         MOHg4MpqO+DE6kcExvWM9qD8EPJkacCB9NavwbhVj5cNo49juj+UwPjVbz1ugDmusMz9
         vNZQ==
X-Gm-Message-State: AOAM5332d45NZFPtSLxokjCdrvI3OOg60wv6Zrey32+Rvhq825Dfx7Fz
        ypTtxrTwUKMeDejOtDSBxHklD5t2GbNSbRT0DOo=
X-Google-Smtp-Source: ABdhPJw0qZWcW46bGqKzfi6dKlByATYjnFbvabTH7DbgThEnfEAeAn3xYRmt1DADUpqaHA8NTxxPgGQooxg4uTFqLPA=
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id
 o24-20020a17090608d800b006d2131dbe51mr24701886eje.564.1646254196801; Wed, 02
 Mar 2022 12:49:56 -0800 (PST)
MIME-Version: 1.0
References: <20220302032646.3793-4-Frank.Li@nxp.com> <20220302201520.GA746237@bhelgaas>
In-Reply-To: <20220302201520.GA746237@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 2 Mar 2022 14:49:45 -0600
Message-ID: <CAHrpEqR8ZwNVFqqRo0hAAt8aDDrduXnBRTTw3G868wkOP3EKYg@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI: imx6: add PCIe embedded DMA support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>
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

On Wed, Mar 2, 2022 at 2:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jingoo for DesignWare generic question]
>
> In subject:
>
>   PCI: imx6: Add embedded DMA support
>
> to match existing style.  "PCIe" seems superfluous here since we
> already mentioned it earlier in the subject.

Sorry, it is PCI when git log to check old history.

>
> On Tue, Mar 01, 2022 at 09:26:45PM -0600, Frank Li wrote:
> > Designware PCIe control have embedded DMA controller.
> > This enable the DMA controller support.
>
> Maybe:
>
>   Add support for the DMA controller in the DesignWare PCIe core.
>
> If this DMA controller is in the DesignWare core, is everything in
> this patch specific to imx6?  Or could some of it be shared with other
> dwc-based drivers?

The DMA register base address,
Irq number.
Can't support 64bit register access.

>
> > The DMA can transfer data to any remote address location
> > regardless PCI address space size.
>
> What is this sentence telling us?  Is it merely that the DMA "inbound
> address space" may be larger than the MMIO "outbound address space"?
> I think there's no necessary connection between them, and there's no
> need to call it out as though it's something special.

There are outbound address windows. such as 256M, but RC sides have more
than 256M ddr memory, such as 16GB. If CPU or external DMA controller,
only can access 256M
address space.

But if using an embedded DMA controller,  it can access the whole RC's
16G address without
changing iAtu mapping.

I want to say why I need enable embedded DMA for EP.

>
> > Prepare struct dw_edma_chip and call dw_edma_probe
>
> "dw_edma_probe()" so it's obvious this is a function.
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c | 61 +++++++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index efa8b81711090..a588b848a1650 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -38,6 +38,7 @@
> >  #include "../../pci.h"
> >
> >  #include "pcie-designware.h"
> > +#include "linux/dma/edma.h"
> >
> >  #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET              0x7c
> >  #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US               GENMASK(18, 17)
> > @@ -164,6 +165,8 @@ struct imx6_pcie {
> >       const struct imx6_pcie_drvdata *drvdata;
> >       struct regulator        *epdev_on;
> >       struct phy              *phy;
> > +
> > +     struct dw_edma_chip     dma_chip;
> >  };
> >
> >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > @@ -2031,6 +2034,61 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
> >       .get_features = imx_pcie_ep_get_features,
> >  };
> >
> > +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
>
> Function names should match existing style in this driver, i.e., they
> should start with "imx6", not "imx".
>
> > +{
> > +     struct platform_device *pdev = to_platform_device(dev);
> > +
> > +     return platform_get_irq_byname(pdev, "dma");
> > +}
> > +
> > +static struct dw_edma_core_ops dma_ops = {
> > +     .irq_vector = imx_dma_irq_vector,
> > +};
> > +
> > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie,
> > +                         struct platform_device *pdev,
>
> You don't use "pdev" in this function, so no need to pass it in.
>
> > +                         struct resource *dbi_base)
>
> IIUC this is already in pci->dbi_base, so why not use that instead of
> passing it in?  Passing both a struct and the contents of a member of
> the struct is an opportunity for a mistake.

pci->dbi_base just provides a virtual address.
I can change dbi_base as dbi_res.

>
> > +{
> > +     unsigned int pcie_dma_offset;
> > +     struct dw_pcie *pci = imx6_pcie->pci;
> > +     struct device *dev = pci->dev;
> > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > +     int i = 0;
> > +     u64 pbase;
> > +     void *vbase;
> > +     int sz = PAGE_SIZE;
> > +
> > +     pcie_dma_offset = 0x970;
> > +
> > +     pbase = dbi_base->start + pcie_dma_offset;
> > +     vbase = pci->dbi_base + pcie_dma_offset;
> > +
> > +     dma->dev = dev;
> > +
> > +     dma->rg_region.paddr = pbase;
> > +     dma->rg_region.vaddr = vbase;
> > +     dma->rg_region.sz = 0x424;
> > +
> > +     dma->wr_ch_cnt = dma->rd_ch_cnt = 1;
> > +
> > +     dma->ops = &dma_ops;
> > +     dma->nr_irqs = 1;
> > +
> > +     dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> > +
> > +     dma->ll_region_wr[0].sz = sz;
> > +     dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> > +                                                      &dma->ll_region_wr[i].paddr,
> > +                                                      GFP_KERNEL);
> > +
> > +     dma->ll_region_rd[0].sz = sz;
> > +     dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> > +                                                      &dma->ll_region_rd[i].paddr,
> > +                                                      GFP_KERNEL);
> > +
> > +     return dw_edma_probe(dma);
> > +}
> > +
> >  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> >                                       struct platform_device *pdev)
> >  {
> > @@ -2694,6 +2752,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >               goto err_ret;
> >       }
> >
> > +     if (imx_add_pcie_dma(imx6_pcie, pdev, dbi_base))
> > +             dev_info(dev, "pci edma probe failure\n");
> > +
> >       return 0;
> >
> >  err_ret:
> > --
> > 2.24.0.rc1
> >
