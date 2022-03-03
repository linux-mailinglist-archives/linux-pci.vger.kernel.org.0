Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B434CBA7F
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiCCJnC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 04:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiCCJmz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 04:42:55 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFA4177D21
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 01:42:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id o8so4037300pgf.9
        for <linux-pci@vger.kernel.org>; Thu, 03 Mar 2022 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jFAtq+k5RhuCwjL3RHgwUp9mZpXZphx7ltJz88tnoU8=;
        b=serKmkufRJlH3LtR3ZBOSJKKLWvicVpVwsCoLP+tYoeRBXrpmhxIJFLn/RVxpuASsD
         RAK9uzlr8gcJREOYaP1gV1WvnDg8c8OQQoLfFiGT2029dBqVI8reyaxdW+X8f6uNCvIK
         L0xJw/EUEt/tf2o3bm/izA8f4OGf7ByrriqMoC5J68KxHwY+3BwryEJdB5kxX051X5nu
         fKxRXcywhljyv32tCVMy9+qRxtHEn9t9KCbg2S7pBylOgTv2Lmhc+/g3V81inSsCnny1
         aw1IRTVF94/m4sri4CPrZ98YhL/W0ykWYy9X1o99fZJ9AmLUTggH7YOaoJn/r352BoT7
         7E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jFAtq+k5RhuCwjL3RHgwUp9mZpXZphx7ltJz88tnoU8=;
        b=yDWvukuipwER9Gw7IFb4ATi2Wqj8DMeDpQDb698HgitTS8BbdUaBhaq5UrrgUj5ddo
         zyx84B1VpOr7h36hdZPyddcH3fjKMWrWsXbbLzg6YS0Axfq4JGu3mjcgzbakJZxj/vCO
         Mn7OuWOjp/RgLvwxDwtXtGJcWK7ZuZ1L/PcCY/WTfiWRLB/ixcnT1rn0RLH0atFWzvYZ
         9Iqo8COKo3g6YYTEQy6fp3SSeYs/z3uFYqU7vzyC9womgbdiOtqv0UtlN+D9DJShefv6
         G8Lo3yOUrTV91kx/kEXhKrmjHxigm0QfiX/cBGRg00uPImXnCqdDYuqat8PR3tJ/7kfZ
         Yneg==
X-Gm-Message-State: AOAM530hnAAZlGTUOOLTfq5wzvZnQV8WUrg+o/9zbhSNDRYc2o2oZiV6
        EuMsjDAN1hV17nfkCuJQ21Cw
X-Google-Smtp-Source: ABdhPJw4c/pxQHU8hTYB7OKoS6iA8g2gtLTj83vSF5NKJbUjLtBLb9FjNVZYmKI3fUotKOIkhSdkRg==
X-Received: by 2002:a63:8f18:0:b0:372:eacf:e8da with SMTP id n24-20020a638f18000000b00372eacfe8damr29257241pgd.362.1646300529434;
        Thu, 03 Mar 2022 01:42:09 -0800 (PST)
Received: from workstation ([117.207.24.195])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004e5c2c0b9dcsm2004969pfe.30.2022.03.03.01.42.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Mar 2022 01:42:09 -0800 (PST)
Date:   Thu, 3 Mar 2022 15:12:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org
Subject: Re: [PATCH 1/5] dmaengine: dw-edma: fix dw_edma_probe() can't be
 call globally
Message-ID: <20220303094204.GH12451@workstation>
References: <20220302032646.3793-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302032646.3793-1-Frank.Li@nxp.com>
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

On Tue, Mar 01, 2022 at 09:26:42PM -0600, Frank Li wrote:
> API dw_edma_probe(struct dw_edma_chip *chip) defined at include/linux/dma,
> but struct dw_edma_chip have a hidden internal struct dw_edma *dw,
> supposed dw should be allocated in API dw_edma_probe().
> 
> 	@dw: struct dw_edma that is filed by dw_edma_probe()
> 
> but dw need allocate and fill chip related information  before call dw_edma_probe()
> in current code. See ref
> 	drivers/dma/dw-edma/dw-edma-pci.c
> 
> Move chip related information from dw-edma-core.h to edma.h
> allocate memory inside dw_edma_probe()

Commit message could be reworded a bit:

"struct dw_edma_chip" contains an internal structure "struct dw_edma" that is
used by the eDMA core internally. This structure should not be touched
by the eDMA controller drivers themselves. But currently, the eDMA
controller drivers like "dw-edma-pci" allocates and populates this
internal structure then passes it on to eDMA core. The eDMA core further
populates the structure and uses it. This is wrong!

Hence, move all the "struct dw_edma" specifics from controller drivers
to the eDMA core.

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c       | 31 ++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h       | 28 +++-----------
>  drivers/dma/dw-edma/dw-edma-v0-core.c    |  2 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c |  2 +-
>  include/linux/dma/edma.h                 | 48 +++++++++++++++++++++++-
>  5 files changed, 78 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 53289927dd0d6..029085c035067 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -905,19 +905,32 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (!dev)
>  		return -EINVAL;
>  
> -	dw = chip->dw;
> -	if (!dw || !dw->irq || !dw->ops || !dw->ops->irq_vector)
> +	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;
> +
> +	chip->dw = dw;
> +
> +	if (!chip->nr_irqs || !chip->ops)
>  		return -EINVAL;
>  
>  	raw_spin_lock_init(&dw->lock);
>  
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt,
> +	dw->rg_region = &chip->rg_region;
> +	dw->ll_region_wr = chip->ll_region_wr;
> +	dw->ll_region_rd = chip->ll_region_rd;
> +	dw->dt_region_wr = chip->dt_region_wr;
> +	dw->dt_region_rd = chip->dt_region_rd;
> +
> +	dw->mf = chip->mf;
> +

The eDMA core should be able to reuse the existing fields from "dw_edma_chip".
I don't think the duplication is needed here.

> +	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));

Eventhough this is an old code, I don't get the logic. Can the controller driver
pass channel count that is beyond the range hardware actually supports?

I think we should let the eDMA core to read the registers and populate
these fields instead of relying on the controller drivers.

> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt, EDMA_MAX_WR_CH);
>  
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt,
> +	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->rd_ch_cnt = min_t(u16, chip->rd_ch_cnt, EDMA_MAX_RD_CH);
>  
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;
> @@ -936,6 +949,12 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	/* Disable eDMA, only to establish the ideal initial conditions */
>  	dw_edma_v0_core_off(dw);
>  
> +	dw->nr_irqs = chip->nr_irqs;
> +	dw->ops = chip->ops;
> +	dw->irq = devm_kcalloc(dev, dw->nr_irqs, sizeof(*dw->irq), GFP_KERNEL);
> +	if (!dw->irq)
> +		return -ENOMEM;
> +
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(chip, &wr_alloc, &rd_alloc);
>  	if (err)
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index 60316d408c3e0..8ca195814a878 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -15,20 +15,12 @@
>  #include "../virt-dma.h"
>  
>  #define EDMA_LL_SZ					24
> -#define EDMA_MAX_WR_CH					8
> -#define EDMA_MAX_RD_CH					8
>  
>  enum dw_edma_dir {
>  	EDMA_DIR_WRITE = 0,
>  	EDMA_DIR_READ
>  };
>  
> -enum dw_edma_map_format {
> -	EDMA_MF_EDMA_LEGACY = 0x0,
> -	EDMA_MF_EDMA_UNROLL = 0x1,
> -	EDMA_MF_HDMA_COMPAT = 0x5
> -};
> -
>  enum dw_edma_request {
>  	EDMA_REQ_NONE = 0,
>  	EDMA_REQ_STOP,
> @@ -57,12 +49,6 @@ struct dw_edma_burst {
>  	u32				sz;
>  };
>  
> -struct dw_edma_region {
> -	phys_addr_t			paddr;
> -	void				__iomem *vaddr;
> -	size_t				sz;
> -};
> -
>  struct dw_edma_chunk {
>  	struct list_head		list;
>  	struct dw_edma_chan		*chan;
> @@ -109,10 +95,6 @@ struct dw_edma_irq {
>  	struct dw_edma			*dw;
>  };
>  
> -struct dw_edma_core_ops {
> -	int	(*irq_vector)(struct device *dev, unsigned int nr);
> -};
> -
>  struct dw_edma {
>  	char				name[20];
>  
> @@ -122,11 +104,11 @@ struct dw_edma {
>  	struct dma_device		rd_edma;
>  	u16				rd_ch_cnt;
>  
> -	struct dw_edma_region		rg_region;	/* Registers */
> -	struct dw_edma_region		ll_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region		ll_region_rd[EDMA_MAX_RD_CH];
> -	struct dw_edma_region		dt_region_wr[EDMA_MAX_WR_CH];
> -	struct dw_edma_region		dt_region_rd[EDMA_MAX_RD_CH];
> +	struct dw_edma_region		*rg_region;	/* Registers */
> +	struct dw_edma_region		*ll_region_wr;
> +	struct dw_edma_region		*ll_region_rd;
> +	struct dw_edma_region		*dt_region_wr;
> +	struct dw_edma_region		*dt_region_rd;
>  

As I said above, can we just reuse the existing fields from "dw_edma_chip"?

Thanks,
Mani
