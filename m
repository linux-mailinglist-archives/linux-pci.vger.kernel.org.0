Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79C4CE1EA
	for <lists+linux-pci@lfdr.de>; Sat,  5 Mar 2022 02:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiCEBcn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 20:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiCEBcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 20:32:42 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D8E254A81
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 17:31:53 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gb39so20797585ejc.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 17:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ViDUJ8NE/3P5tVMga7ZfbaAxNu3oFZ8NIryGJJz8e8U=;
        b=YZ7H3cICpOPQf9yrMj4aUcXbFNdJLlOr0Ij7pC+lrIRns3d0D7BQkU0F1yh8gFT7AX
         gnDgbaqONG95EuUGoL+ddaW8dOaEdKAeGQ2oNxxxD8tEfBhTWJVJjxEjQxA7Kose+8YO
         Pv5wKAA4UctkoAIIa/eaDTuVuLQMYnEoXNS7RxapDs7ecOF2Zmmp7SkK7WayEjBC7UeU
         R6x5Qqer0U9LEzpH1uYHn+wtk3KnovxOx3uxhTqB7Ex0XvUsVJCRu9MHu3UlfPMqRN/K
         7OO7Np2e/aEOmD2tUUjgE0lCuDUAOkJgqybSgU9B8pnIRN4tNpBHN7QIO9pUOi6cF+ua
         DcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ViDUJ8NE/3P5tVMga7ZfbaAxNu3oFZ8NIryGJJz8e8U=;
        b=FH7AYeZjCJP82/eaq7/fDjJ1zzzrlMR1Ek1hriyU21sC3IUMmLtIW2xyrZXrQ/cTDh
         +/iQZh9eByKZhJokHtGY4UWyHsP9YXawHIJzGOVRkS38h3SC/KXfaGRmSrip5kAUfa0n
         htZV+M3+egIcHoFXX9RfR7bGdS02o9cZwA0BLui4lm3xbpwQkn6sRbjxwBp4qti1mvOa
         Sg0aZ4iH8FGDRpJ2ZkOGLXLFJi/uvG8M/IOyM61+mGUlPLc0Uf77UUiEXShsCHd8qHde
         MXpToN23uQP7oYtuAjdUFkl7xBxvLVHFR1DhkTGUY7F9Jdb7Uw3hjhlgAheghVJHglHG
         ulpg==
X-Gm-Message-State: AOAM532il/7Yv2NzfdYmxTTciatDX1USqg4xS7QM3Xl5GYbxfrKF4xTf
        cTi+Y/imlYCOvIrhnGADeJXCD27plJFyKDTWpFo=
X-Google-Smtp-Source: ABdhPJx51C4JBKpQtBmlp05N9YMfwcEdf6Qt3EbGWoqROGs0MYQuxPD7GN/T4x3gHbp9K2Zi8laQvDRMD27UGr4r/0c=
X-Received: by 2002:a17:907:9956:b0:6cf:cd25:c5a7 with SMTP id
 kl22-20020a170907995600b006cfcd25c5a7mr1133926ejc.635.1646443911657; Fri, 04
 Mar 2022 17:31:51 -0800 (PST)
MIME-Version: 1.0
References: <20220303184635.2603-4-Frank.Li@nxp.com> <20220304213352.GA1046827@bhelgaas>
In-Reply-To: <20220304213352.GA1046827@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 4 Mar 2022 19:31:40 -0600
Message-ID: <CAHrpEqTa5x7-XhqdskTr55cBc3U4hF-sv2cQyAS41oWMHebxBA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

On Fri, Mar 4, 2022 at 3:33 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Mar 03, 2022 at 12:46:34PM -0600, Frank Li wrote:
> > Add support for the DMA controller in the DesignWare PCIe core
> >
> > The DMA can transfer data to any remote address location
> > regardless PCI address space size.
> >
> > Prepare struct dw_edma_chip() and call dw_edma_probe()
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >
> > This patch depended on some ep enable patch for imx.
>
> This makes it really hard to apply because we don't know *which* patch
> this depends on.  Patches that depend on each other should be posted
> in the same series, or at the very least, include lore URL to what
> they depend on.

I did not realize It was missing some EP support patches in pci-imx6.c
upstream at v1.
Richard is working on this upstream work.

This patch don't impact previous patch 1-3 and 5

I will skip this patch next time and wait for richard finish imx6 EP
function upstream.
Other patches are independent and can be merged separately.

With patch 1-3 and 5, other platforms rather than imx that using
designware pci ip can be benefited.


>
> > Change from v1 to v2
> > - rework commit message
> > - align dw_edma_chip change
> >
> >  drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index efa8b81711090..7dc55986c947d 100644
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
> > @@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
> >       .get_features = imx_pcie_ep_get_features,
> >  };
> >
> > +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
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
> > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)
>
> Rename these functions to use "imx6" prefix, as the other functions in
> the file do.  Mentioned this last time, too.  Also applies to
> imx_add_pcie_ep() below; I guess that must be in the other
> prerequisite patch?
>
> > +{
> > +     unsigned int pcie_dma_offset;
> > +     struct dw_pcie *pci = imx6_pcie->pci;
> > +     struct device *dev = pci->dev;
> > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > +     int i = 0;
>
> No need to make a variable for this.  Just use 0 below, which will be
> easier to read.
>
> > +     int sz = PAGE_SIZE;
> > +
> > +     pcie_dma_offset = 0x970;
>
> This would be better as a #define.  No point in making a local
> variable on the stack.
>
> > +     dma->dev = dev;
> > +
> > +     dma->reg_base = pci->dbi_base + pcie_dma_offset;
> > +
> > +     dma->ops = &dma_ops;
> > +     dma->nr_irqs = 1;
> > +
> > +     dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> > +
> > +     dma->ll_wr_cnt = dma->ll_rd_cnt=1;
> > +     dma->ll_region_wr[0].sz = sz;
> > +     dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> > +                                                      &dma->ll_region_wr[i].paddr,
> > +                                                      GFP_KERNEL);
> > +
> > +     dma->ll_region_rd[0].sz = sz;
> > +     dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> > +                                                      &dma->ll_region_rd[i].paddr,
> > +                                                      GFP_KERNEL);
>
> Wrap all the above to fit in 80 columns.
>
> I would consider something like this to reduce some of the repetition:
>
>   struct dw_edma_region *region;
>
>   dma->ll_wr_cnt = 1;
>   region = &dma->ll_region_wr[0];
>   region->sz = sz;
>   region->vaddr = dmam_alloc_coherent(dev, sz, &region->paddr, GFP_KERNEL);
>
>   dma->ll_rd_cnt = 1;
>   region = &dma->ll_region_rd[0];
>   region->sz = sz;
>   region->vaddr = dmam_alloc_coherent(dev, sz, &region->paddr, GFP_KERNEL);
>
> > +
> > +     return dw_edma_probe(dma);
> > +}
> > +
> >  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> >                                       struct platform_device *pdev)
> >  {
> > @@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> >               goto err_ret;
> >       }
> >
> > +     if (imx_add_pcie_dma(imx6_pcie))
> > +             dev_info(dev, "pci edma probe failure\n");
> > +
> >       return 0;
> >
> >  err_ret:
> > --
> > 2.24.0.rc1
> >
