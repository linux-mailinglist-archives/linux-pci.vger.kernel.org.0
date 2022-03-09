Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84D14D3911
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 19:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiCISnO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 13:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiCISnN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 13:43:13 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5D18BA76
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 10:42:14 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z15so3055682pfe.7
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2022 10:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s2nn3M2kb6W/RNAFSrJsK1rYAzyMi1dBL+An+TUQuUw=;
        b=MBrsaUJPMHsf+PveoAQCpWvP8Qc1kjLnE+YYp7uujfzLBPsva0cm7O7eUN4Q+rqcpn
         8s4roVII1KYs5LJHrz/BZ6cDQTToMGEQz0Xi2wkm5/F6ivX/+6GWWiW9kngUPqYVEOiL
         V8j9ozOvM3brc/YP93zMe+AXvmPgSN9lorrZ2gO5u9zfKeEUW+LgDYcGVbn42hrc8yvu
         saw16SvGBp/VFqJS8FclvKgIJyJkxbI1l4yQUbJ/wBovmXnqpS4gJVNKIJ/XsPBLNwz/
         Z30Vy4RcuIt3x97RLBWj/u9c0W0DagMFUH7a5lj08ot1LkwE46921vBuJZCQm/Sqvzbn
         iIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s2nn3M2kb6W/RNAFSrJsK1rYAzyMi1dBL+An+TUQuUw=;
        b=E6KfUtoZL58VwwelYs8xITDaWmQB4faf3RTerqmwQYk61+X4nH+QcigaCiIQxPQlGx
         9xz+ROXUmBVdS1r05/rMZiibOOf07FTWuZErL7Xj7gMp5RCFtrQDMLPAVvPXwmfE+A0o
         E2fQy4OWtQil7HNV9y3vOg6nXHHezESf/pcAwombertMPU8WVv/iJfsoM0ht0TlbPVLl
         6V5S70n30HFSE02wcvdZw/AZIGyQtFchEwI6VcW+bj/7mubwBWgyuV8cDV/DhGy7jRso
         oW6doKd//TJwAdr67AatkcsAdhWb4kgNAEjm7IQWWRQDLvwfCVypKubG4XNX0DW7+9LH
         3n9Q==
X-Gm-Message-State: AOAM530hNxCsC/kj/eF0WXVTyIe9bwf+eUMameZm+q5kKBZ7DsLJ4nOo
        RjusC3dkI1FPBkYK+Wb88BUF
X-Google-Smtp-Source: ABdhPJw5wjP6j8hUSAwuugmGko/Boeukht88cPDEIgXsp4Cj1026E/IhoB2efUm5kQLShbWrcyLG2Q==
X-Received: by 2002:a63:134a:0:b0:378:9ef8:950a with SMTP id 10-20020a63134a000000b003789ef8950amr877441pgt.548.1646851333811;
        Wed, 09 Mar 2022 10:42:13 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id pg5-20020a17090b1e0500b001bf48f8904fsm7899542pjb.49.2022.03.09.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 10:42:13 -0800 (PST)
Date:   Thu, 10 Mar 2022 00:12:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220309184207.GD134091@thinkpad>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
 <20220303184635.2603-4-Frank.Li@nxp.com>
 <20220309120149.GB134091@thinkpad>
 <CAHrpEqSikfyfoqb_Zjivc3QjwPrw55+aS2UKPqcYwjNCV=UfZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSikfyfoqb_Zjivc3QjwPrw55+aS2UKPqcYwjNCV=UfZg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 09, 2022 at 12:31:57PM -0600, Zhi Li wrote:
> On Wed, Mar 9, 2022 at 6:02 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 12:46:34PM -0600, Frank Li wrote:
> > > Add support for the DMA controller in the DesignWare PCIe core
> > >
> > > The DMA can transfer data to any remote address location
> > > regardless PCI address space size.
> > >
> > > Prepare struct dw_edma_chip() and call dw_edma_probe()
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >
> > > This patch depended on some ep enable patch for imx.
> > >
> > > Change from v1 to v2
> > > - rework commit message
> > > - align dw_edma_chip change
> > >
> > >  drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > index efa8b81711090..7dc55986c947d 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -38,6 +38,7 @@
> > >  #include "../../pci.h"
> > >
> > >  #include "pcie-designware.h"
> > > +#include "linux/dma/edma.h"
> > >
> > >  #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET              0x7c
> > >  #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US               GENMASK(18, 17)
> > > @@ -164,6 +165,8 @@ struct imx6_pcie {
> > >       const struct imx6_pcie_drvdata *drvdata;
> > >       struct regulator        *epdev_on;
> > >       struct phy              *phy;
> > > +
> > > +     struct dw_edma_chip     dma_chip;
> > >  };
> > >
> > >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > > @@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
> > >       .get_features = imx_pcie_ep_get_features,
> > >  };
> > >
> > > +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
> > > +{
> > > +     struct platform_device *pdev = to_platform_device(dev);
> > > +
> > > +     return platform_get_irq_byname(pdev, "dma");
> > > +}
> > > +
> > > +static struct dw_edma_core_ops dma_ops = {
> > > +     .irq_vector = imx_dma_irq_vector,
> > > +};
> > > +
> > > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)
> > > +{
> > > +     unsigned int pcie_dma_offset;
> > > +     struct dw_pcie *pci = imx6_pcie->pci;
> > > +     struct device *dev = pci->dev;
> > > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > > +     int i = 0;
> >
> > Unused?
> >
> > > +     int sz = PAGE_SIZE;
> > > +
> > > +     pcie_dma_offset = 0x970;
> >
> > Can you get this offset from the devicetree node of ep?
> >
> > > +
> > > +     dma->dev = dev;
> > > +
> > > +     dma->reg_base = pci->dbi_base + pcie_dma_offset;
> > > +
> > > +     dma->ops = &dma_ops;
> > > +     dma->nr_irqs = 1;
> > > +
> > > +     dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> > > +
> > > +     dma->ll_wr_cnt = dma->ll_rd_cnt=1;
> >
> > Is this a hard limitation of the eDMA implementation or because of difficulties
> > in requesting the correct channel from client driver?
> >
> > If it's the latter, you could use my patch:
> 
> It is  because our hardware only has 1 channel.

Ah okay. It is fine if that's the case.

> 
> >
> > https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810
> 
> My problem is
> in   dw_edma_channel_setup()
> dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
> 
> Already set direction.  why need overwrite default device_caps?
> 

The above sets both direction in the caps. That's fine if you want to verify
whether the channel is valid or not. But that won't help you want to choose the
correct channel.

In your case it will work because, read and write channel count is 1. But what
if the channel count is 8?

write channel - 0 to 7
read channel - 8 to 15

Now without identifying the channel direction, the client would be getting the
wrong one. For instance, if client requests read channel after write, the
dmaengine would pass 1 because the requested direction matches the caps and
that's wrong.

Thanks,
Mani 

> >
> > > +     dma->ll_region_wr[0].sz = sz;
> > > +     dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > +                                                      &dma->ll_region_wr[i].paddr,
> > > +                                                      GFP_KERNEL);
> >
> > Allocation could fail. Please add error checking here and below.
> >
> > Thanks,
> > Mani
> >
> > > +
> > > +     dma->ll_region_rd[0].sz = sz;
> > > +     dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > +                                                      &dma->ll_region_rd[i].paddr,
> > > +                                                      GFP_KERNEL);
> > > +
> > > +     return dw_edma_probe(dma);
> > > +}
> > > +
> > >  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> > >                                       struct platform_device *pdev)
> > >  {
> > > @@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > >               goto err_ret;
> > >       }
> > >
> > > +     if (imx_add_pcie_dma(imx6_pcie))
> > > +             dev_info(dev, "pci edma probe failure\n");
> > > +
> > >       return 0;
> > >
> > >  err_ret:
> > > --
> > > 2.24.0.rc1
> > >
