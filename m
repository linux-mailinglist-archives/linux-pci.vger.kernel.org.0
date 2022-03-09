Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB00D4D39A6
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 20:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiCITPr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 14:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237346AbiCITPq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 14:15:46 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB210E576
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 11:14:46 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id x5so4125488edd.11
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2022 11:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffI2zv8LkXfLxEnkOCROZxBrxhxUGsImvVn943PHyBE=;
        b=ijy50pfCLftZT+H7yD7AbZ3BOMOiIJPDrniwp1G5h8gp/N4IBwpeSEqO/OJBuJrP7J
         sq6NvjleT+rkCMUpW0oLf0HupJ1suILpGDNFA0DusdubamFqdOvhnRWzL68qqMeurpVe
         GwsCDG6/g1akZJ6kbfXYD1yHYLJX1HuTJ9LGprPpAiYbKsQIsgvwpHoC2UJcRkNMkvwk
         5ILPBWtbxPu9vlusZv83T+e9O3yf7gI8wt2tvE9XFIrCnbSzmlRyYORSso4nphdnbVOQ
         D8Vcpbanq3c80IDEguW02YQFkp+G6YUxhL8PaLX/bBWqzGPo2umc7vwpzy0f9DW2R5EM
         Zaig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffI2zv8LkXfLxEnkOCROZxBrxhxUGsImvVn943PHyBE=;
        b=3d42wQqUi0lUi+M5szPFYjy2HluM+IVHNpJe8PIM+QvvZBzB0PKk2TOLpVzHNCpn3b
         C0FbJ22tcOFcbPmbqujfC1lbqRnrZb0lcp5sM+GFuGNZHbp+JcpvvknTMF2OAMCe9ieW
         ZhBnBg7Cmz6xK7IudY7MwtSLIQAOz4klF9gzQ+6dw4V6NDxG6frZoM0CvW9laM5b4Jx7
         XKV5kuF0rQrmc+laPgoyBNPq7B3BNQr1VDxpHkULoV2VXTVOBEJtlvFPDA7jxTs5UG7N
         sLw27ssAsCC/Ypf+But7XOhSyj2PL2wNDV4VEi9g0RsIUTSKEnzjZS27nXpSKISSFXpe
         gqTA==
X-Gm-Message-State: AOAM531orrye1nKmDV9r/+ZlCNNADSC8j4IaGzf8WqT+IPL6rtUU7x6z
        n+XWKN8UQaX1L5CDSYWtDFOJBNUSkhYDDIr+qF0=
X-Google-Smtp-Source: ABdhPJz1EzXNj0yVTxu+7ElBUCl+S83/6trSD4IXwiwK1F/1gTLV+BVTQGtfbpvX9r4zJlZ0UhTphyYj+ZYKY+86Y1g=
X-Received: by 2002:a05:6402:1e89:b0:416:a641:9fe with SMTP id
 f9-20020a0564021e8900b00416a64109femr941275edf.312.1646853284783; Wed, 09 Mar
 2022 11:14:44 -0800 (PST)
MIME-Version: 1.0
References: <20220303184635.2603-1-Frank.Li@nxp.com> <20220303184635.2603-4-Frank.Li@nxp.com>
 <20220309120149.GB134091@thinkpad> <CAHrpEqSikfyfoqb_Zjivc3QjwPrw55+aS2UKPqcYwjNCV=UfZg@mail.gmail.com>
 <20220309184207.GD134091@thinkpad>
In-Reply-To: <20220309184207.GD134091@thinkpad>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 9 Mar 2022 13:14:33 -0600
Message-ID: <CAHrpEqS6ejBR-etBKW1Rd_usVawJ3vPAsDe=M1LDCmE_JypUaA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI: imx6: add PCIe embedded DMA support
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
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

On Wed, Mar 9, 2022 at 12:42 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, Mar 09, 2022 at 12:31:57PM -0600, Zhi Li wrote:
> > On Wed, Mar 9, 2022 at 6:02 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Thu, Mar 03, 2022 at 12:46:34PM -0600, Frank Li wrote:
> > > > Add support for the DMA controller in the DesignWare PCIe core
> > > >
> > > > The DMA can transfer data to any remote address location
> > > > regardless PCI address space size.
> > > >
> > > > Prepare struct dw_edma_chip() and call dw_edma_probe()
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >
> > > > This patch depended on some ep enable patch for imx.
> > > >
> > > > Change from v1 to v2
> > > > - rework commit message
> > > > - align dw_edma_chip change
> > > >
> > > >  drivers/pci/controller/dwc/pci-imx6.c | 51 +++++++++++++++++++++++++++
> > > >  1 file changed, 51 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > > > index efa8b81711090..7dc55986c947d 100644
> > > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > > @@ -38,6 +38,7 @@
> > > >  #include "../../pci.h"
> > > >
> > > >  #include "pcie-designware.h"
> > > > +#include "linux/dma/edma.h"
> > > >
> > > >  #define IMX8MQ_PCIE_LINK_CAP_REG_OFFSET              0x7c
> > > >  #define IMX8MQ_PCIE_LINK_CAP_L1EL_64US               GENMASK(18, 17)
> > > > @@ -164,6 +165,8 @@ struct imx6_pcie {
> > > >       const struct imx6_pcie_drvdata *drvdata;
> > > >       struct regulator        *epdev_on;
> > > >       struct phy              *phy;
> > > > +
> > > > +     struct dw_edma_chip     dma_chip;
> > > >  };
> > > >
> > > >  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> > > > @@ -2031,6 +2034,51 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
> > > >       .get_features = imx_pcie_ep_get_features,
> > > >  };
> > > >
> > > > +static int imx_dma_irq_vector(struct device *dev, unsigned int nr)
> > > > +{
> > > > +     struct platform_device *pdev = to_platform_device(dev);
> > > > +
> > > > +     return platform_get_irq_byname(pdev, "dma");
> > > > +}
> > > > +
> > > > +static struct dw_edma_core_ops dma_ops = {
> > > > +     .irq_vector = imx_dma_irq_vector,
> > > > +};
> > > > +
> > > > +static int imx_add_pcie_dma(struct imx6_pcie *imx6_pcie)
> > > > +{
> > > > +     unsigned int pcie_dma_offset;
> > > > +     struct dw_pcie *pci = imx6_pcie->pci;
> > > > +     struct device *dev = pci->dev;
> > > > +     struct dw_edma_chip *dma = &imx6_pcie->dma_chip;
> > > > +     int i = 0;
> > >
> > > Unused?
> > >
> > > > +     int sz = PAGE_SIZE;
> > > > +
> > > > +     pcie_dma_offset = 0x970;
> > >
> > > Can you get this offset from the devicetree node of ep?
> > >
> > > > +
> > > > +     dma->dev = dev;
> > > > +
> > > > +     dma->reg_base = pci->dbi_base + pcie_dma_offset;
> > > > +
> > > > +     dma->ops = &dma_ops;
> > > > +     dma->nr_irqs = 1;
> > > > +
> > > > +     dma->flags = DW_EDMA_CHIP_NO_MSI | DW_EDMA_CHIP_REG32BIT | DW_EDMA_CHIP_LOCAL_EP;
> > > > +
> > > > +     dma->ll_wr_cnt = dma->ll_rd_cnt=1;
> > >
> > > Is this a hard limitation of the eDMA implementation or because of difficulties
> > > in requesting the correct channel from client driver?
> > >
> > > If it's the latter, you could use my patch:
> >
> > It is  because our hardware only has 1 channel.
>
> Ah okay. It is fine if that's the case.
>
> >
> > >
> > > https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810
> >
> > My problem is
> > in   dw_edma_channel_setup()
> > dma->directions = BIT(write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV);
> >
> > Already set direction.  why need overwrite default device_caps?
> >
>
> The above sets both direction in the caps.

Why set both direction?
           write ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV
Only one bit set

> That's fine if you want to verify
> whether the channel is valid or not. But that won't help you want to choose the
> correct channel.
>
> In your case it will work because, read and write channel count is 1. But what
> if the channel count is 8?

I know my case is special one.  I just feel strange.

dma_async_device_register(dma); register two devices, one read, one write.

The default int dma_get_slave_caps(struct dma_chan *chan, struct
dma_slave_caps *caps)
{
          device = chan->device;
          caps->directions = device->directions;
}

It should return read/write devices's directions.

>
> write channel - 0 to 7
> read channel - 8 to 15
>
> Now without identifying the channel direction, the client would be getting the
> wrong one. For instance, if client requests read channel after write, the
> dmaengine would pass 1 because the requested direction matches the caps and
> that's wrong.

Do you mean if I request a read after write can reproduce the problem?


>
> Thanks,
> Mani
>
> > >
> > > > +     dma->ll_region_wr[0].sz = sz;
> > > > +     dma->ll_region_wr[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > > +                                                      &dma->ll_region_wr[i].paddr,
> > > > +                                                      GFP_KERNEL);
> > >
> > > Allocation could fail. Please add error checking here and below.
> > >
> > > Thanks,
> > > Mani
> > >
> > > > +
> > > > +     dma->ll_region_rd[0].sz = sz;
> > > > +     dma->ll_region_rd[0].vaddr = dmam_alloc_coherent(dev, sz,
> > > > +                                                      &dma->ll_region_rd[i].paddr,
> > > > +                                                      GFP_KERNEL);
> > > > +
> > > > +     return dw_edma_probe(dma);
> > > > +}
> > > > +
> > > >  static int imx_add_pcie_ep(struct imx6_pcie *imx6_pcie,
> > > >                                       struct platform_device *pdev)
> > > >  {
> > > > @@ -2694,6 +2742,9 @@ static int imx6_pcie_probe(struct platform_device *pdev)
> > > >               goto err_ret;
> > > >       }
> > > >
> > > > +     if (imx_add_pcie_dma(imx6_pcie))
> > > > +             dev_info(dev, "pci edma probe failure\n");
> > > > +
> > > >       return 0;
> > > >
> > > >  err_ret:
> > > > --
> > > > 2.24.0.rc1
> > > >
