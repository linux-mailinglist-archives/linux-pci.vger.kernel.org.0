Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A9D4CD9E8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiCDRRP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 12:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbiCDRRO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 12:17:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19741CD9DE
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 09:16:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id qx21so18792238ejb.13
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 09:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLhqRoNTg+ZDaT34K4dUwQH5OVgc02M3+d9wpBEHmcA=;
        b=daDIKssMTS/3fGvOT55pJxqboXno+cEDb+Izj7iKBL1Bg+aW1cICk5GiGiIJc/KGOF
         XqaVU76Ux8nQZRUAXa6y7AbixWYU/FoFOB0TuWSbbSMJdYImZX1hkpZ7bydER73jIW6C
         A/xBSczT9rSDIsp5iOHwcJNcPa21KFlfWCDlQ52G4A+JsGDgCUZV+bJ0gLijGjujP/x5
         ai7k5RjEAnH/XEG8xFYsID/7e+ujC9bCR6WQBVI7JPlnE10cmJKzxkjuj+/Tt+0fuC2J
         U8x2xfB7FHIG/8p0tJbuyhF8yhZdQTm8w02/7b5QC4DkpTV00MJmYMt3GoVEnAPnRX0E
         iVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLhqRoNTg+ZDaT34K4dUwQH5OVgc02M3+d9wpBEHmcA=;
        b=vSXDDkJZde58SNa83VBmifiPJL4MMMbX+nsizWyRLf0GwgX4FB9xe0U1i+N5+3nJi8
         tB4vpr2u4Wl+L9bt3QAaosZjRrcDMQOg5fFitRFwVcp9cuk8awrMhGKpwnQXphJbKnkT
         7P6ne0z3nmecvqhURhB1aNk2X77l+TdtgHvaHsWdqXDySwAnOFAU6A4QFtwijSM//emm
         9fXGNiNnxETULlcx61zY6Axx93X3tZMaKW/rGP1ZBV8mwb/aKNw5b5IAIo7d4vkRGYed
         7WcQJEMAcPwx1Ejg2Wg+0/LuOwcYyBMsjIwhW1JQ/y/GLLJuakbA6WIv6TKLdkEwFCgP
         e4ug==
X-Gm-Message-State: AOAM530DFuKjA83sBmofB+R3rmDc/4xiQwgG7bFn3AwisZqh72X4V7DY
        9vBm2RqrqGDlOSITVc/xosKHui7G+2Y549arM68=
X-Google-Smtp-Source: ABdhPJy6L8jVzo1zLc5T1l21XrtcwJe/LPQR0940VYf0aMPpkHi3Kr+fVVgvQ+muFheIZFrpVlPbIoCdG8cefIaA518=
X-Received: by 2002:a17:907:1c13:b0:6da:62bb:f1ff with SMTP id
 nc19-20020a1709071c1300b006da62bbf1ffmr11343475ejc.276.1646414184083; Fri, 04
 Mar 2022 09:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20220303184635.2603-1-Frank.Li@nxp.com> <20220303184635.2603-3-Frank.Li@nxp.com>
 <20220304161922.GL12451@workstation>
In-Reply-To: <20220304161922.GL12451@workstation>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Fri, 4 Mar 2022 11:16:11 -0600
Message-ID: <CAHrpEqSFj8eTc9adhh21Ju_=P8Rb0xXVTa5QMcY-w-8xn+m5xg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dmaengine: dw-edma: add flags at struct dw_edma_chip
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

 i

On Fri, Mar 4, 2022 at 10:19 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Thu, Mar 03, 2022 at 12:46:33PM -0600, Frank Li wrote:
> > Allow user don't enable remote MSI irq.
> > PCI ep probe dma locally, don't want to raise irq
> > to remote PCI host.
> >
> > Add option allow force 32bit register access even at
> > 64bit system. i.MX8 hardware only allowed 32bit register
> > access.
> >
> > Add option allow EP side probe dma. remote side dma is
> > continue physical memory, local memory is scatter list.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v1 to v2
> > - none
> >
> >  drivers/dma/dw-edma/dw-edma-core.c    |  7 ++++++-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 14 ++++++++++----
> >  include/linux/dma/edma.h              |  7 +++++++
> >  3 files changed, 23 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 0cb66434f9e14..a43bb26c8bf96 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -336,6 +336,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >       struct dw_edma_desc *desc;
> >       u32 cnt = 0;
> >       int i;
> > +     bool b;
> >
> >       if (!chan->configured)
> >               return NULL;
> > @@ -424,7 +425,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> >               chunk->ll_region.sz += burst->sz;
> >               desc->alloc_sz += burst->sz;
> >
> > -             if (chan->dir == EDMA_DIR_WRITE) {
> > +             b = (chan->dir == EDMA_DIR_WRITE);
> > +             if (chan->chip->flags & DW_EDMA_CHIP_LOCAL_EP)
> > +                     b = !b;
> > +
> > +             if (b) {
>
> I've added a patch that uses the xfer direction and channel direction to
> find out whether it is a read operation or not. Please take a look:
>
> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=d6a3f432204614ad8531321949a8a9e2c3e94c3b
>

I think your patch is better.  Can I include your patch into this sequence ?

> The patch could also make use of the "DW_EDMA_CHIP_LOCAL" flag if you
> prefer.
>
> >                       burst->sar = src_addr;
> >                       if (xfer->type == EDMA_XFER_CYCLIC) {
> >                               burst->dar = xfer->xfer.cyclic.paddr;
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 6e2f83e31a03a..d5c2415e2c616 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -307,13 +307,18 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
> >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  {
> >       struct dw_edma_burst *child;
> > +     struct dw_edma_chan *chan = chunk->chan;
> >       struct dw_edma_v0_lli __iomem *lli;
> >       struct dw_edma_v0_llp __iomem *llp;
> >       u32 control = 0, i = 0;
> > +     u32 rie = 0;
> >       int j;
> >
> >       lli = chunk->ll_region.vaddr;
> >
> > +     if (!(chan->chip->flags & DW_EDMA_CHIP_NO_MSI))
> > +             rie = DW_EDMA_V0_RIE;
> > +
> >       if (chunk->cb)
> >               control = DW_EDMA_V0_CB;
> >
> > @@ -321,7 +326,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >       list_for_each_entry(child, &chunk->burst->list, list) {
> >               j--;
> >               if (!j)
> > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > +                     control |= (DW_EDMA_V0_LIE | rie);
>
> I think the MSI makes sense only for eDMA access from remote. So how
> about reusing the same flag you used above?

Understand,  DW_EDMA_CHIP_NO_MSI is more direct.  User can know what
exactly control.

DW_EDMA_CHIP_LOCAL is quite general.  User don't know what to do from naming.

I am okay for both naming.

If I pick up your patch for dma dir,  Only below two flags need,
          #define DW_EDMA_CHIP_NO_MSI            BIT(0)
          #define DW_EDMA_CHIP_REG32BIT        BIT(1)

vs
          #define DW_EDMA_CHIP_LOCAL              BIT(0)
          #define DW_EDMA_CHIP_REG32BIT        BIT(1)

which one is better?

>
>         control |= DW_EDMA_V0_LIE;
>
>         /* Raise MSI only if the eDMA is accessed by remote */
>         if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
>                 control |= DW_EDMA_V0_RIE;
>
> >
> >               /* Channel control */
> >               SET_LL_32(&lli[i].control, control);
> > @@ -420,15 +425,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >               SET_CH_32(chip, chan->dir, chan->id, ch_control1,
> >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >               /* Linked list */
> > -             #ifdef CONFIG_64BIT
> > +             if (!(chan->chip->flags & DW_EDMA_CHIP_REG32BIT) &&
> > +                     IS_ENABLED(CONFIG_64BIT)) {
> >                       SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> >                                 chunk->ll_region.paddr);
>
> Why you are doing 32bit access here only and not in other places?
>

Only here access DBI register, other place is access dma link list,
which is memory.

> Thanks,
> Mani
>
> > -             #else /* CONFIG_64BIT */
> > +             } else {
> >                       SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
> >                                 lower_32_bits(chunk->ll_region.paddr));
> >                       SET_CH_32(chip, chan->dir, chan->id, llp.msb,
> >                                 upper_32_bits(chunk->ll_region.paddr));
> > -             #endif /* CONFIG_64BIT */
> > +             }
> >       }
> >       /* Doorbell */
> >       SET_RW_32(chip, chan->dir, doorbell,
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index fcfbc0f47f83d..e74ee15d9832a 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -33,6 +33,10 @@ enum dw_edma_map_format {
> >       EDMA_MF_HDMA_COMPAT = 0x5
> >  };
> >
> > +#define DW_EDMA_CHIP_NO_MSI  BIT(0)
> > +#define DW_EDMA_CHIP_REG32BIT        BIT(1)
> > +#define DW_EDMA_CHIP_LOCAL_EP        BIT(2)
>
> As per my understanding the

what's you mean?

>
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:              struct device of the eDMA controller
> > @@ -40,6 +44,8 @@ enum dw_edma_map_format {
> >   * @nr_irqs:          total dma irq number
> >   * reg64bit           if support 64bit write to register
> >   * @ops                       DMA channel to IRQ number mapping
> > + * @flags             - DW_EDMA_CHIP_NO_MSI can't generate remote MSI irq
> > + *                    - DW_EDMA_CHIP_REG32BIT only support 32bit register write
> >   * @wr_ch_cnt                 DMA write channel number
> >   * @rd_ch_cnt                 DMA read channel number
> >   * @rg_region                 DMA register region
> > @@ -53,6 +59,7 @@ struct dw_edma_chip {
> >       int                     id;
> >       int                     nr_irqs;
> >       const struct dw_edma_core_ops   *ops;
> > +     u32                     flags;
> >
> >       void __iomem            *reg_base;
> >
> > --
> > 2.24.0.rc1
> >
