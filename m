Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED24CDFC9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 22:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiCDVc0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 16:32:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDVc0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 16:32:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A99F38
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 13:31:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D15F0B82B7D
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 21:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C14C340E9;
        Fri,  4 Mar 2022 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646429494;
        bh=sHTU/AnBJtGOZPf71ygUxRmV3Mf/nzxPUDTe5AYjpAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kUWisp3IQZIN8Thn//5rn81OD1MQrpWX6g5M5ZxxD1xu0pezo8p85SO/0a6FyAyym
         FV1PB7Xlo6VluMOsMZEJHPkvBoW1lxp7++R7ahHYf8UsuUCHlMFmOTMq0sFzUXLIiF
         aCHhsAxat+PxnlUOdQNPVob3zvFQu8rWn85+0xHFdBHORQHSQm8LJwDuCt+lv/hrwt
         qxlIYdN07/beZHfxueya7x/y8s0cr3IQzUx876g9vaXnYn0IEb5BPqDactxCbcYrn7
         ZbLnet3PemVpsfvs2K+vocs+FacM0f98Rbf7KNDsbZpb3MiYDzfUhF5ndRcjn/5afI
         PI9yk3c9wgmjg==
Date:   Fri, 4 Mar 2022 15:31:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v2 3/5] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220304213132.GA1047737@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303184635.2603-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 03, 2022 at 12:46:33PM -0600, Frank Li wrote:
> Allow user don't enable remote MSI irq.
> PCI ep probe dma locally, don't want to raise irq
> to remote PCI host.
> 
> Add option allow force 32bit register access even at
> 64bit system. i.MX8 hardware only allowed 32bit register
> access.
> 
> Add option allow EP side probe dma. remote side dma is
> continue physical memory, local memory is scatter list.

s/Allow user don't enable remote MSI/Allow user to prevent use of remote MSI/ ?
s/irq/IRQ/ (several, and in comment below)
s/ep/EP/ (capitalize consistently)
s/dma/DMA/ (several)
s/Add option allow force 32bit/Add option to force 32-bit/
s/even at 64bit system/even on 64-bit systems/
s/remote side/Remote side/ (start sentence with capital letter)

s/Add option allow EP side probe dma/Add option to allow EP to probe DMA/
(I'm not quite sure what this means).

s/continue physical memory/contiguous physical memory/ ?

Rewrap above to fill 75 columns.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - none
> 
>  drivers/dma/dw-edma/dw-edma-core.c    |  7 ++++++-
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 14 ++++++++++----
>  include/linux/dma/edma.h              |  7 +++++++
>  3 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 0cb66434f9e14..a43bb26c8bf96 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -336,6 +336,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  	struct dw_edma_desc *desc;
>  	u32 cnt = 0;
>  	int i;
> +	bool b;
>  
>  	if (!chan->configured)
>  		return NULL;
> @@ -424,7 +425,11 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		chunk->ll_region.sz += burst->sz;
>  		desc->alloc_sz += burst->sz;
>  
> -		if (chan->dir == EDMA_DIR_WRITE) {
> +		b = (chan->dir == EDMA_DIR_WRITE);
> +		if (chan->chip->flags & DW_EDMA_CHIP_LOCAL_EP)
> +			b = !b;
> +
> +		if (b) {
>  			burst->sar = src_addr;
>  			if (xfer->type == EDMA_XFER_CYCLIC) {
>  				burst->dar = xfer->xfer.cyclic.paddr;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 6e2f83e31a03a..d5c2415e2c616 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -307,13 +307,18 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma_chip *chip, enum dw_edma_dir
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> +	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control = 0, i = 0;
> +	u32 rie = 0;
>  	int j;
>  
>  	lli = chunk->ll_region.vaddr;
>  
> +	if (!(chan->chip->flags & DW_EDMA_CHIP_NO_MSI))
> +		rie = DW_EDMA_V0_RIE;
> +
>  	if (chunk->cb)
>  		control = DW_EDMA_V0_CB;
>  
> @@ -321,7 +326,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	list_for_each_entry(child, &chunk->burst->list, list) {
>  		j--;
>  		if (!j)
> -			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> +			control |= (DW_EDMA_V0_LIE | rie);

Could drop "rie" and do this, which would keep DW_EDMA_CHIP_NO_MSI
closer to where it's used:

  if (!j) {
    control |= DW_EDMA_V0_LIE;
    if (!(chan->chip->flags & DW_EDMA_CHIP_NO_MSI))
      control |= DW_EDMA_V0_RIE;
  }

>  		/* Channel control */
>  		SET_LL_32(&lli[i].control, control);
> @@ -420,15 +425,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(chip, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		#ifdef CONFIG_64BIT
> +		if (!(chan->chip->flags & DW_EDMA_CHIP_REG32BIT) &&
> +			IS_ENABLED(CONFIG_64BIT)) {
>  			SET_CH_64(chip, chan->dir, chan->id, llp.reg,
>  				  chunk->ll_region.paddr);
> -		#else /* CONFIG_64BIT */
> +		} else {
>  			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
>  				  lower_32_bits(chunk->ll_region.paddr));
>  			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
>  				  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */

I think this would read better if you reversed the sense:

  if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
      !IS_ENABLED(CONFIG_64BIT)) {
    SET_CH_32(...);
    SET_CH_32(...);
  } else {
    SET_CH_64(...);
  }

> +		}
>  	}
>  	/* Doorbell */
>  	SET_RW_32(chip, chan->dir, doorbell,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index fcfbc0f47f83d..e74ee15d9832a 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -33,6 +33,10 @@ enum dw_edma_map_format {
>  	EDMA_MF_HDMA_COMPAT = 0x5
>  };
>  
> +#define DW_EDMA_CHIP_NO_MSI	BIT(0)
> +#define DW_EDMA_CHIP_REG32BIT	BIT(1)
> +#define DW_EDMA_CHIP_LOCAL_EP	BIT(2)
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -40,6 +44,8 @@ enum dw_edma_map_format {
>   * @nr_irqs:		 total dma irq number
>   * reg64bit		 if support 64bit write to register
>   * @ops			 DMA channel to IRQ number mapping
> + * @flags		 - DW_EDMA_CHIP_NO_MSI can't generate remote MSI irq
> + *			 - DW_EDMA_CHIP_REG32BIT only support 32bit register write

Looks like DW_EDMA_CHIP_LOCAL_EP should be documented here, too?

>   * @wr_ch_cnt		 DMA write channel number
>   * @rd_ch_cnt		 DMA read channel number
>   * @rg_region		 DMA register region
> @@ -53,6 +59,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	u32			flags;
>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.24.0.rc1
> 
