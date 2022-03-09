Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBCE4D3B5B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 21:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbiCIUuE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 15:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236059AbiCIUuD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 15:50:03 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197AB36301
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 12:49:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id kt27so7874793ejb.0
        for <linux-pci@vger.kernel.org>; Wed, 09 Mar 2022 12:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GyI3RPqfBAHKEq8g6/+1IXzIMUg9E9pyHUj0fOUfTg=;
        b=UtlDps3M04m0yZNYRkasZwDXkFWTVtoEpj4n2nl3fv2Yq42i6lK/U2cMkmtCu9NHMF
         cGKzuMtZLEyMryucBJWHoTockLsDFx+3No5lMNQRvaCt6sgF9cvz+u+pL82ovS1hhogn
         Oz0t5NuWq6wdl57rBkpdxs5FKJmdf/YDKvj5KXLDro/0AEwG4qetl9J86uVM3G0u7Xex
         zwcb05f8utBwAYXiqeuWIXY64O8iO7np+9qmzG37JyWGNUC7FREAODutNDmMgvPvvQGy
         SE5jdEWD/XoPj/nTxp0VDiuYdCv4QkDA1K7fw1guFgexiQP936y0v1ubkmYD05GRfNTG
         o4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GyI3RPqfBAHKEq8g6/+1IXzIMUg9E9pyHUj0fOUfTg=;
        b=mBnBDNCJ5XyF4zm72Fqtv8F+3uqbHZ5glXEKfm5pc1+DqvaFOMf+cYiGnMi2umWG5g
         ZnfoaFgN6xH49dIbFVwql566YzXgog0AUg01ilothRBqEL9WlxcE8fxMj+wosPD7Ex0L
         M522Q+scyOE5Fm6qvsEAtfCe8KiMBls5lRwGd64zN0c9OGh0lF97xU5AkNFGji/9sjME
         DfKteo5/CRQCdZ5ZhnTOmAoMKnMbC8ZKjLSoigkbkI9Xi6Z/mj3DwqDpXgCw1W/S8Li9
         QWRZuhzGwZLWXHMmDpMa3Cefm8lZsGReOrXTBYQuXSQmMCMKcZYqiFUhlcir8Nj4SLoi
         OWtA==
X-Gm-Message-State: AOAM533Ovb1RodYDsz6QLhlbP6z5OnLBpEZUAAQOKU/okxurFnriV/hM
        r25s1YpuYF8jU3gc1jyGbQFNMVDtPP77s4f16cM=
X-Google-Smtp-Source: ABdhPJwRSBo06PohkgJusmPptvXAPa5TMuC0XhaCgVISpv32hEs+xJ7VozcqYwEzsobt/0waW7IERrNn3tcL9c/WocA=
X-Received: by 2002:a17:906:974d:b0:6db:5745:e170 with SMTP id
 o13-20020a170906974d00b006db5745e170mr1502097ejy.276.1646858942434; Wed, 09
 Mar 2022 12:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20220303184635.2603-1-Frank.Li@nxp.com> <20220303184635.2603-4-Frank.Li@nxp.com>
 <20220309120149.GB134091@thinkpad> <CAHrpEqSikfyfoqb_Zjivc3QjwPrw55+aS2UKPqcYwjNCV=UfZg@mail.gmail.com>
 <20220309184207.GD134091@thinkpad> <CAHrpEqS6ejBR-etBKW1Rd_usVawJ3vPAsDe=M1LDCmE_JypUaA@mail.gmail.com>
In-Reply-To: <CAHrpEqS6ejBR-etBKW1Rd_usVawJ3vPAsDe=M1LDCmE_JypUaA@mail.gmail.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 9 Mar 2022 14:48:51 -0600
Message-ID: <CAHrpEqRhnKghxeRZay3r8S+sQtP-f7L6s4XvyVOANCams6h4Qw@mail.gmail.com>
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

On Wed, Mar 9, 2022 at 1:14 PM Zhi Li <lznuaa@gmail.com> wrote:
>
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

After I force channel number to 8,

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
b/drivers/pci/endpoint/functions/pci-epf-test.c
index f26afd02f3a86..04ec644ecde5a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -180,7 +180,7 @@ static bool epf_dma_filter_fn(struct dma_chan
*chan, void *node)

        memset(&caps, 0, sizeof(caps));
        dma_get_slave_caps(chan, &caps);
-
+pr_err("dma cap: 0x%llx\n", caps.directions);
        return chan->device->dev == filter->dev
                && (filter->dma_mask & caps.directions);
 }


[   17.715167] dma cap: 0x6    ( other DMA engine)
[   17.717707] dma cap: 0x6    ( other DMA engine)
[   17.720299] dma cap: 0x6     ( other DMA engine)
[   17.722893] dma cap: 0x6     ( other DMA engine)
[   17.725437] dma cap: 0x6     ( other DMA engine)
[   17.728040] dma cap: 0x6     ( other DMA engine)
[   17.730652] dma cap: 0x6     ( other DMA engine)
[   17.733197] dma cap: 0x4     (EDMA W)
[   17.735762] dma cap: 0x4     (EDMA W)
[   17.738390] dma cap: 0x4      .....
[   17.740937] dma cap: 0x4
[   17.743518] dma cap: 0x4
[   17.746108] dma cap: 0x4
[   17.748651] dma cap: 0x4
[   17.751219] dma cap: 0x2     (EDMA WR)

I get the correct DMA channel without your patch.

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
