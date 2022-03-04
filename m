Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2174CD8FB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 17:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiCDQUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Mar 2022 11:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbiCDQUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Mar 2022 11:20:43 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209314890B
        for <linux-pci@vger.kernel.org>; Fri,  4 Mar 2022 08:19:55 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s1so8141461plg.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Mar 2022 08:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bjAUk1naewG/bvIzUISR+RF7Wh5obo6+Fl+cayIrxfE=;
        b=VoAbr5+6Pmsbio1laXp/9E0mN7xNHZWvJY6RoJ2rn44VNIQKuRY/Lus/YknDEnywIe
         Zk+wnn/7O3KW4hSzwtihoohUisQuOcLXFyqknORpb0a7iBUXQRl0IqDk3rO5wmzOJ2m4
         hipfIKr7vX67/O/DW8Mv0XZOpGDVpchmSZfxujE7OFLclqH+ri3yndS+peiWihf7aMXp
         Ggh9Zr+GHJJq1z4K63Bvnz9evJgYKPDKfWvYV+DW0wSZ8IX4pmHDs+GZrUS+Hwjaz4xk
         ORy1ZyoVkexAuS9pW0Dk5C2Rw/Rx3X89z5kUMZZgRthcy+4UIFTTM+uJMqvyEpDuGGtK
         ef+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjAUk1naewG/bvIzUISR+RF7Wh5obo6+Fl+cayIrxfE=;
        b=dl7s0dqk+yQ3hlYCmS/lwpqPLqemsHBLc72d46GTj9AvfAsmZP0pFWAZRxsqDAuJBR
         9ZD8pWE8OMWR+P2ESEPzrQgN09Ww1znsoQ+FY64fgbQs7oHoe6AE/mq6DneK5r19pucy
         v63ffcFW+D3FDhCMdgXAt0R9BVcCdxSYDAhQ7JITFbAILd6z9FOHDZCQhVOlDwCOZZEs
         ATwOIyXhLO7tptbKCuPjHbL6oNih1Txe93dFOdrnIvmVKRf6dJ7ipWwE9b5hiORHYXb5
         5qf2jDOgOMpSBeQcsUumivC4979HFE8CSe9WEAxD9COIbY46IEBo8eYIaH8ewP4k5Cls
         LzgA==
X-Gm-Message-State: AOAM532Cc3y0qZB8ObGfTK05ZcJ3kmuK8/zYPHljErYDB3YTsShoq5FK
        GLYBff+/8UitMIveOYvqtPFHqM07ArBL
X-Google-Smtp-Source: ABdhPJx/5CWd7bx2j67QNg+fK9VAQ+HvQpdQdNp9kw1qukPGcXArgJUqT1gBzq78EoKNGFQlBshz2w==
X-Received: by 2002:a17:902:f60f:b0:151:4f66:55b4 with SMTP id n15-20020a170902f60f00b001514f6655b4mr31419163plg.127.1646410794678;
        Fri, 04 Mar 2022 08:19:54 -0800 (PST)
Received: from workstation ([117.207.24.215])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm6689154pfh.58.2022.03.04.08.19.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Mar 2022 08:19:45 -0800 (PST)
Date:   Fri, 4 Mar 2022 21:49:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org
Subject: Re: [PATCH v2 3/5] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220304161922.GL12451@workstation>
References: <20220303184635.2603-1-Frank.Li@nxp.com>
 <20220303184635.2603-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303184635.2603-3-Frank.Li@nxp.com>
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
> 
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

I've added a patch that uses the xfer direction and channel direction to
find out whether it is a read operation or not. Please take a look:

https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=d6a3f432204614ad8531321949a8a9e2c3e94c3b

The patch could also make use of the "DW_EDMA_CHIP_LOCAL" flag if you
prefer.

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

I think the MSI makes sense only for eDMA access from remote. So how
about reusing the same flag you used above?

	control |= DW_EDMA_V0_LIE;

	/* Raise MSI only if the eDMA is accessed by remote */
	if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
		control |= DW_EDMA_V0_RIE;

>  
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

Why you are doing 32bit access here only and not in other places?

Thanks,
Mani

> -		#else /* CONFIG_64BIT */
> +		} else {
>  			SET_CH_32(chip, chan->dir, chan->id, llp.lsb,
>  				  lower_32_bits(chunk->ll_region.paddr));
>  			SET_CH_32(chip, chan->dir, chan->id, llp.msb,
>  				  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */
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

As per my understanding the 

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
