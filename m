Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967304D4064
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 05:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiCJEqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 23:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239505AbiCJEqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 23:46:36 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E255E3381
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 20:45:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso4166331pjo.5
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2022 20:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2U6++UgXtqUk+c9sH11uXNL+EaK7bVMKB3iZHiWyL1g=;
        b=hzFDy4Tdxwb/gw2yfjKMa3Sq/c1svvGljUeeWMUdwYWmag3TD9lt8ZA5PGovHesgEo
         eL6q0Jd8KEJIDrrnzjNXNbIjzeKTdwmjeCmmgny0+VPmibxUmHv4CHCMY9eNKsLJ07TE
         UTmjY7TY2HVQAE1gvre1x9N0Le0ovFMejl/AaalMTXIYlOJ77c5FnHTF/Nwi+aj8YrWy
         nWmtq2D1KivG+GS9XCphMp8ljE31C4VRoelBvV12V+XlKyeudTilrgDySvz68PmPqZda
         HypoN05JyCKpAlv2YJnz9fIeWF1WJxkWyQ2qDA/1Ksi0ciTB161SFB5FO10+IK89pzTk
         QF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2U6++UgXtqUk+c9sH11uXNL+EaK7bVMKB3iZHiWyL1g=;
        b=pkPklqTqGTji0d/yFfSAVncwtFR9gr/qTvYeA1znW50YtaK5Y1oAnYCl/SmAAfoL7n
         l6Q3Lxnz8R7zI0pwxNEjX20jjHL5vlHK3MXfb75J4TLUdRLefEJKFs5fekWe1EogdVks
         b3vG2JU/ylb+H1bWsCUYMiZyDlt9PuNCvQWZmZ1XA4uglCKoETOfPDVNqwBWu2P4SF1H
         bpRLYIZNkPLrb3zw2WliUYRvxjRApZzv67AjRZujNPVsKYFZ29/frXtiPttdD7fFlKmi
         LcvdMmAtwFs+L8B1Np6fsQ+jMTCpWBLN7ks86UWm2F1gjU0TdrMOUUHcaUbZxrk34VVK
         LmNQ==
X-Gm-Message-State: AOAM533nBmjhq7gEIsNlLpYmcVI0YbDLzFZ/S5uEVN46SRywQyJTuB8M
        RpJi53S8GSwYrs+rDpXS8nxn
X-Google-Smtp-Source: ABdhPJw9ZqPMvpSH7kGFA/jAcphPPb6aZj0ndA9JxPHYrn+MTBjkMbXzkTKtKZiAVYoN2YEOcq3N2g==
X-Received: by 2002:a17:90a:7883:b0:1bd:2372:c990 with SMTP id x3-20020a17090a788300b001bd2372c990mr13942052pjk.55.1646887535366;
        Wed, 09 Mar 2022 20:45:35 -0800 (PST)
Received: from thinkpad ([117.193.208.22])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f75d5f9b5csm4093889pfk.26.2022.03.09.20.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 20:45:35 -0800 (PST)
Date:   Thu, 10 Mar 2022 10:15:28 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
Message-ID: <20220310044528.GA4869@thinkpad>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
 <20220303184635.2603-4-Frank.Li@nxp.com>
 <20220309120149.GB134091@thinkpad>
 <CAHrpEqSikfyfoqb_Zjivc3QjwPrw55+aS2UKPqcYwjNCV=UfZg@mail.gmail.com>
 <20220309184207.GD134091@thinkpad>
 <CAHrpEqS6ejBR-etBKW1Rd_usVawJ3vPAsDe=M1LDCmE_JypUaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqS6ejBR-etBKW1Rd_usVawJ3vPAsDe=M1LDCmE_JypUaA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 09, 2022 at 01:14:33PM -0600, Zhi Li wrote:
> On Wed, Mar 9, 2022 at 12:42 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Wed, Mar 09, 2022 at 12:31:57PM -0600, Zhi Li wrote:
> > > On Wed, Mar 9, 2022 at 6:02 AM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Thu, Mar 03, 2022 at 12:46:34PM -0600, Frank Li wrote:
> > > > > Add support for the DMA controller in the DesignWare PCIe core
> > > > >
> > > > > The DMA can transfer data to any remote address location
> > > > > regardless PCI address space size.
> > > > >
> > > > > Prepare struct dw_edma_chip() and call dw_edma_probe()
> > > > >
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >
> > > > > This patch depended on some ep enable patch for imx.
> > > > >
> > > > > Change from v1 to v2
> > > > > - rework commit message
> > > > > - align dw_edma_chip change
> > > > >
> > > > >  drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
> > > > >  1 file changed, 51 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > index efa8b81711090..7dc55986c947d 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > > @@ -38,6 +38,7 @@
> > > > >  #include "../../pci.h"
> > > > >
> > > > >  #include "pcie-designware.h"
> > > > > +#include "linux/dma/edma.h"
> > > > >
> > > > >  #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET              0x7c
> > > > >  #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US               GENMASK(18, 17)
> > > > > @@ -164,6 +165,8 @@ struct imx6_pcie {
> > > > >       const struct imx6_pcie_drvdata *drvdata;
> > > > >       struct regulator        *epdev_on;
> > > > >       struct phy              *phy;
> > > > > +
> > > > > +     struct dw_edma_chip     dma_chip;
> > > > >  };
> > > > >
> > > > >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > > > > @@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
> > > > >       .get_features = imx_pcie_ep_get_features,
> > > > >  };
> > > > >
> > > > > +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
> > > > > +{
> > > > > +     struct platform_device *pdev = to_platform_device(dev);
> > > > > +
> > > > > +     return platform_get_irq_byname(pdev, "dma");
> > > > > +}
> > > > > +
> > > > > +static struct dw_edma_core_ops dma_ops = {
> > > > > +     .irq_vector = imx_dma_irq_vector,
> > > > > +};
> > > > > +
> > > > > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)
> > > > > +{
> > > > > +     unsigned int pcie_dma_offset;
> > > > > +     struct dw_pcie *pci = imx6_pcie->pci;
> > > > > +     struct device *dev = pci->dev;
> > > > > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > > > > +     int i = 0;
> > > >
> > > > Unused?
> > > >
> > > > > +     int sz = PAGE_SIZE;
> > > > > +
> > > > > +     pcie_dma_offset = 0x970;
> > > >
> > > > Can you get this offset from the devicetree node of ep?
> > > >
> > > > > +
> > > > > +     dma->dev = dev;
> > > > > +
> > > > > +     dma->reg_base = pci->dbi_base + pcie_dma_offset;
> > > > > +
> > > > > +     dma->ops = &dma_ops;
> > > > > +     dma->nr_irqs = 1;
> > > > > +
> > > > > +     dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> > > > > +
> > > > > +     dma->ll_wr_cnt = dma->ll_rd_cnt=1;
> > > >
> > > > Is this a hard limitation of the eDMA implementation or because of difficulties
> > > > in requesting the correct channel from client driver?
> > > >
> > > > If it's the latter, you could use my patch:
> > >
> > > It is  because our hardware only has 1 channel.
> >
> > Ah okay. It is fine if that's the case.
> >
> > >
> > > >
> > > > https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810
> > >
> > > My problem is
> > > in   dw_edma_channel_setup()
> > > dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
> > >
> > > Already set direction.  why need overwrite default device_caps?
> > >
> >
> > The above sets both direction in the caps.
> 
> Why set both direction?
>            write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV
> Only one bit set
> 
> > That's fine if you want to verify
> > whether the channel is valid or not. But that won't help you want to choose the
> > correct channel.
> >
> > In your case it will work because, read and write channel count is 1. But what
> > if the channel count is 8?
> 
> I know my case is special one.  I just feel strange.
> 
> dma_async_device_register(dma); register two devices, one read, one write.
> 
> The default int dma_get_slave_caps(struct dma_chan *chan, struct
> dma_slave_caps *caps)
> {
>           device = chan->device;
>           caps->directions = device->directions;
> }
> 
> It should return read/write devices's directions.
> 

Urgh... In our kernel tree, my colleague merged two dma devices into one and I
failed to notice that :/

So yeah, it should work by default. Sorry for the noise.

Thanks,
Mani

> >
> > write channel - 0 to 7
> > read channel - 8 to 15
> >
> > Now without identifying the channel direction, the client would be getting the
> > wrong one. For instance, if client requests read channel after write, the
> > dmaengine would pass 1 because the requested direction matches the caps and
> > that's wrong.
> 
> Do you mean if I request a read after write can reproduce the problem?
> 
> 
> >
> > Thanks,
> > Mani
> >
> > > >
> > > > > +     dma->ll_region_wr[0].sz = sz;
> > > > > +     dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > > > +                                                      &dma->ll_region_wr[i].paddr,
> > > > > +                                                      GFP_KERNEL);
> > > >
> > > > Allocation could fail. Please add error checking here and below.
> > > >
> > > > Thanks,
> > > > Mani
> > > >
> > > > > +
> > > > > +     dma->ll_region_rd[0].sz = sz;
> > > > > +     dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > > > +                                                      &dma->ll_region_rd[i].paddr,
> > > > > +                                                      GFP_KERNEL);
> > > > > +
> > > > > +     return dw_edma_probe(dma);
> > > > > +}
> > > > > +
> > > > >  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> > > > >                                       struct platform_device *pdev)
> > > > >  {
> > > > > @@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > > >               goto err_ret;
> > > > >       }
> > > > >
> > > > > +     if (imx_add_pcie_dma(imx6_pcie))
> > > > > +             dev_info(dev, "pci edma probe failure\n");
> > > > > +
> > > > >       return 0;
> > > > >
> > > > >  err_ret:
> > > > > --
> > > > > 2.24.0.rc1
> > > > >
