Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35294D0094
	for <lists+linux-pci@lfdr.de>; Mon,  7 Mar 2022 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiCGOAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Mar 2022 09:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbiCGOAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Mar 2022 09:00:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6103B4EF61
        for <linux-pci@vger.kernel.org>; Mon,  7 Mar 2022 05:59:47 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id mg21-20020a17090b371500b001bef9e4657cso13365330pjb.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Mar 2022 05:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6xW4OU4cM8616loZbqd4+ulFTpvKEgV8fxd7BF8TuBI=;
        b=hQeu7Sagwagj6EGxfRzvIjKGl7nhra+FnzvtnHPApRtmpr0cFvduEuY04Qrl8UO/s9
         SRoxjOIhxpLbbkWu8xRpbP1u0bBZdhPl/Wyi6eHpy5qa9vMFLGEai0CTckCnTJZ70uA6
         okP/IghgO0DifdP3t7de9n2BxKF/mwqwZAOXU3D/CxvPUvoHRmosUZUfC0m5LvaXF2vX
         zvrK5VqbebSzXM81tPUnngvrrUymLEM6EHqo/4Nij7H1BOew9OpGyGh9g85i1RZzLNnX
         49pgpGN8KzlIzh0oEw4JfZa9mLfsKnItYpC18/T3kFbwJnxJ7fKwZdl4C8blZMvdIVcE
         puYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6xW4OU4cM8616loZbqd4+ulFTpvKEgV8fxd7BF8TuBI=;
        b=OnYPb/MWVVZDj31YKNWXlWADjcTuK/0iUzWy+TERShJB1Q68gzZtrAUkcW8bDDpZmV
         Pe8PcRpbiRi62GyeHAVLOThgYbh5GkgyazqiXqzrzkdKEP/3RmesjneWIoH/bcA3U9JA
         K/ma5H82C/1FSBLbqdkKAqzIJAg9r+q0UvJmSyo9gWRBuPNYd9rEFCgGrjO8umEqy0z0
         6jED8AAyTok2HGrlwdoyN0EXypXSKxxUxw9AAuqvfejLNzecG0tfUivPBAyWZqajdA0K
         dcDyA6kYGMHX62BmAo0W9kRIQ8FFu5zwV2kBSro/5li/x1SoWci/NcQ9PK8gwOHy1A7b
         ZQOg==
X-Gm-Message-State: AOAM530DUGz5duQeBOPqvyV1cOmHEF3sPK3Oqp7AX9hctfIq4X1w9rpR
        PEWKKnKtWkWC5+IDIKFXIP7u
X-Google-Smtp-Source: ABdhPJy9QYyfkQXEWgTDD/frP8+EGqGmqfLDcVJkKN7HBQ2rHpvGnMDZmfIZYVmh7hDGG52idYaxtQ==
X-Received: by 2002:a17:902:8498:b0:150:d71c:39e0 with SMTP id c24-20020a170902849800b00150d71c39e0mr12052384plo.168.1646661586762;
        Mon, 07 Mar 2022 05:59:46 -0800 (PST)
Received: from workstation ([117.217.178.15])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7888c000000b004f3fc6d95casm17331381pfe.20.2022.03.07.05.59.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Mar 2022 05:59:45 -0800 (PST)
Date:   Mon, 7 Mar 2022 19:29:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v2 3/5] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220307135940.GN12451@workstation>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
 <20220303184635.2603-3-Frank.Li@nxp.com>
 <20220304161922.GL12451@workstation>
 <CAHrpEqSFj8eTc9adhh21Ju_=P8Rb0xXVTa5QMcY-w-8xn+m5xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSFj8eTc9adhh21Ju_=P8Rb0xXVTa5QMcY-w-8xn+m5xg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 04, 2022 at 11:16:11AM -0600, Zhi Li wrote:
>  i
> 
> On Fri, Mar 4, 2022 at 10:19 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Thu, Mar 03, 2022 at 12:46:33PM -0600, Frank Li wrote:
> > > Allow user don't enable remote MSI irq.
> > > PCI ep probe dma locally, don't want to raise irq
> > > to remote PCI host.
> > >
> > > Add option allow force 32bit register access even at
> > > 64bit system. i.MX8 hardware only allowed 32bit register
> > > access.
> > >
> > > Add option allow EP side probe dma. remote side dma is
> > > continue physical memory, local memory is scatter list.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Change from v1 to v2
> > > - none
> > >
> > >  drivers/dma/dw-edma/dw-edma-core.c    |  7 ++++++-
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 14 ++++++++++----
> > >  include/linux/dma/edma.h              |  7 +++++++
> > >  3 files changed, 23 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index 0cb66434f9e14..a43bb26c8bf96 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > @@ -336,6 +336,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > >       struct dw_edma_desc *desc;
> > >       u32 cnt = 0;
> > >       int i;
> > > +     bool b;
> > >
> > >       if (!chan->configured)
> > >               return NULL;
> > > @@ -424,7 +425,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
> > >               chunk->ll_region.sz += burst->sz;
> > >               desc->alloc_sz += burst->sz;
> > >
> > > -             if (chan->dir == EDMA_DIR_WRITE) {
> > > +             b = (chan->dir == EDMA_DIR_WRITE);
> > > +             if (chan->chip->flags & DW_EDMA_CHIP_LOCAL_EP)
> > > +                     b = !b;
> > > +
> > > +             if (b) {
> >
> > I've added a patch that uses the xfer direction and channel direction to
> > find out whether it is a read operation or not. Please take a look:
> >
> > https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=d6a3f432204614ad8531321949a8a9e2c3e94c3b
> >
> 
> I think your patch is better.  Can I include your patch into this sequence ?
> 

Yes, feel free to. Also, there is one more cleanup patch I've added:
https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=85eb58bd078000dd938487f560cee5d259f06577

> > The patch could also make use of the "DW_EDMA_CHIP_LOCAL" flag if you
> > prefer.
> >
> > >                       burst->sar = src_addr;
> > >                       if (xfer->type == EDMA_XFER_CYCLIC) {
> > >                               burst->dar = xfer->xfer.cyclic.paddr;
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 6e2f83e31a03a..d5c2415e2c616 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -307,13 +307,18 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
> > >  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >  {
> > >       struct dw_edma_burst *child;
> > > +     struct dw_edma_chan *chan = chunk->chan;
> > >       struct dw_edma_v0_lli __iomem *lli;
> > >       struct dw_edma_v0_llp __iomem *llp;
> > >       u32 control = 0, i = 0;
> > > +     u32 rie = 0;
> > >       int j;
> > >
> > >       lli = chunk->ll_region.vaddr;
> > >
> > > +     if (!(chan->chip->flags & DW_EDMA_CHIP_NO_MSI))
> > > +             rie = DW_EDMA_V0_RIE;
> > > +
> > >       if (chunk->cb)
> > >               control = DW_EDMA_V0_CB;
> > >
> > > @@ -321,7 +326,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> > >       list_for_each_entry(child, &chunk->burst->list, list) {
> > >               j--;
> > >               if (!j)
> > > -                     control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> > > +                     control |= (DW_EDMA_V0_LIE | rie);
> >
> > I think the MSI makes sense only for eDMA access from remote. So how
> > about reusing the same flag you used above?
> 
> Understand,  DW_EDMA_CHIP_NO_MSI is more direct.  User can know what
> exactly control.
> 

Right but isn't using "DW_EDMA_CHIP_LOCAL" implies NO_MSI? Or is there
any endpoint implementation that makes use of MSIs also?

> DW_EDMA_CHIP_LOCAL is quite general.  User don't know what to do from naming.
> 
> I am okay for both naming.
> 
> If I pick up your patch for dma dir,  Only below two flags need,
>           #define DW_EDMA_CHIP_NO_MSI            BIT(0)
>           #define DW_EDMA_CHIP_REG32BIT        BIT(1)
> 
> vs
>           #define DW_EDMA_CHIP_LOCAL              BIT(0)
>           #define DW_EDMA_CHIP_REG32BIT        BIT(1)

How about "DW_EDMA_CHIP_32BIT_DBI"?

Also add comments for both flags.

> 
> which one is better?
> 
> >
> >         control |= DW_EDMA_V0_LIE;
> >
> >         /* Raise MSI only if the eDMA is accessed by remote */
> >         if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
> >                 control |= DW_EDMA_V0_RIE;
> >
> > >
> > >               /* Channel control */
> > >               SET_LL_32(&lli[i].control, control);
> > > @@ -420,15 +425,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > >               SET_CH_32(chip, chan->dir, chan->id, ch_control1,
> > >                         (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> > >               /* Linked list */
> > > -             #ifdef CONFIG_64BIT
> > > +             if (!(chan->chip->flags & DW_EDMA_CHIP_REG32BIT) &&
> > > +                     IS_ENABLED(CONFIG_64BIT)) {
> > >                       SET_CH_64(chip, chan->dir, chan->id, llp.reg,
> > >                                 chunk->ll_region.paddr);
> >
> > Why you are doing 32bit access here only and not in other places?
> >
> 
> Only here access DBI register, other place is access dma link list,
> which is memory.
> 

Okay. Then you need to specify it clearly in commit message as well.

Thanks,
Mani

> > Thanks,
> > Mani
> >
> > > -             #else /* CONFIG_64BIT */
> > > +             } else {
> > >                       SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
> > >                                 lower_32_bits(chunk->ll_region.paddr));
> > >                       SET_CH_32(chip, chan->dir, chan->id, llp.msb,
> > >                                 upper_32_bits(chunk->ll_region.paddr));
> > > -             #endif /* CONFIG_64BIT */
> > > +             }
> > >       }
> > >       /* Doorbell */
> > >       SET_RW_32(chip, chan->dir, doorbell,
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index fcfbc0f47f83d..e74ee15d9832a 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -33,6 +33,10 @@ enum dw_edma_map_format {
> > >       EDMA_MF_HDMA_COMPAT = 0x5
> > >  };
> > >
> > > +#define DW_EDMA_CHIP_NO_MSI  BIT(0)
> > > +#define DW_EDMA_CHIP_REG32BIT        BIT(1)
> > > +#define DW_EDMA_CHIP_LOCAL_EP        BIT(2)
> >
> > As per my understanding the
> 
> what's you mean?
> 
> >
> > > +
> > >  /**
> > >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> > >   * @dev:              struct device of the eDMA controller
> > > @@ -40,6 +44,8 @@ enum dw_edma_map_format {
> > >   * @nr_irqs:          total dma irq number
> > >   * reg64bit           if support 64bit write to register
> > >   * @ops                       DMA channel to IRQ number mapping
> > > + * @flags             - DW_EDMA_CHIP_NO_MSI can't generate remote MSI irq
> > > + *                    - DW_EDMA_CHIP_REG32BIT only support 32bit register write
> > >   * @wr_ch_cnt                 DMA write channel number
> > >   * @rd_ch_cnt                 DMA read channel number
> > >   * @rg_region                 DMA register region
> > > @@ -53,6 +59,7 @@ struct dw_edma_chip {
> > >       int                     id;
> > >       int                     nr_irqs;
> > >       const struct dw_edma_core_ops   *ops;
> > > +     u32                     flags;
> > >
> > >       void __iomem            *reg_base;
> > >
> > > --
> > > 2.24.0.rc1
> > >
