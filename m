Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B54CBAF5
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 11:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiCCKGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 05:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiCCKGP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 05:06:15 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F01795E0
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 02:05:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b8so4198924pjb.4
        for <linux-pci@vger.kernel.org>; Thu, 03 Mar 2022 02:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wm9ovrWsjWqvSDGKx53Rt222ammJ0/6sBP3fPfn6Jps=;
        b=yQAQTNZ/CQzigZS84nxXXvyYd3pZhZm4HkbxSr/LMg85ms4AJD21g9lTN9vis0exk4
         uwMrgldtd3xNxdnpX0fEUZDkVJkec30hN6CNnByVHfwuC39X9blMVKPf2QL5Z2m5Q4Im
         O8J84ag9Y+l1ODTk2s2Td3E13qWoZPD9WGx7UM7Ld94y1GkboB++v//BvKOzls5Z4fB+
         AfTX44En+Brq7eEZvbXh+UVD1QKWotpdK6Sfs1ZcR/E6zVoYbBrBHzlejIqJUR1VhsNC
         ara0hNBQ6FuGCvYh6+LOaqZvC/uqKrLYL8ro7K1jwrJBJv3P92Pq1Aa5MLEQ78EsG+M9
         SjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wm9ovrWsjWqvSDGKx53Rt222ammJ0/6sBP3fPfn6Jps=;
        b=z/vdMqc4GExggIAFtyC8op3Ov4PWCsT7xwYJNVHKPEC/9ucSDGWwhq9Ct9xAdkalje
         SdP+cxwZnPSQYpqiacNblMOqz9syoaCE9kQTkkk5TwHzO0pHwXxAv6HGDk8K+M5D4tle
         smdUsKBIM56bubbyYMjJ72UkqLQ9bcdWeJOBoGJFN/wvixgTkGLGvK52zTSS9clg5d0v
         ctr4T/gCE+ZxFpqDc5H1Ipk2EUKmmEVvoVWJcEpxEiRe87+QTZ41SzdCQt9Sk3YRKP/R
         b2zO9pDI87LLRd7bv4uNp4ebsLWXqFKWrQHP37JJIIMiEYpBRagm/qGWSPSS8zRLy8jj
         Tt2A==
X-Gm-Message-State: AOAM530DDBf96TMVakyHRKY839v/E1mNAtLeOWJRReNFfNkgdV5rNMDm
        erdPajOIYmXf5sXV7A/22wRS
X-Google-Smtp-Source: ABdhPJw5NIEs78pEyFCFCGmGj6LGynjbKoNTwgUyqTsJVc6yonEPnQQshGhfUxBNRws/Ru8hjSZEkQ==
X-Received: by 2002:a17:90a:5794:b0:1b9:8932:d475 with SMTP id g20-20020a17090a579400b001b98932d475mr4492718pji.24.1646301929303;
        Thu, 03 Mar 2022 02:05:29 -0800 (PST)
Received: from workstation ([117.207.24.195])
        by smtp.gmail.com with ESMTPSA id s7-20020a056a00178700b004e1a15e7928sm2249220pfg.145.2022.03.03.02.05.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Mar 2022 02:05:28 -0800 (PST)
Date:   Thu, 3 Mar 2022 15:35:23 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, lznuaa@gmail.com, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, shawnguo@kernel.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 1/5] dmaengine: dw-edma: fix dw_edma_probe() can't be
 call globally
Message-ID: <20220303100523.GJ12451@workstation>
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

Hi Frank,

+ Dmitry

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
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

I started reviewing your eDMA patches because me and my colleague Dmitry are
also working on the eDMA support for Qualcomm platforms. By looking at the eDMA
driver in mainline, it looks like there is a bit of cleanup required. So for
avoiding the duplication of efforts, let's work together for fixing the eDMA
driver and add support for respective platforms.

Please CC us for all of your future patches as well. We will also share the
patches so that all can be combined into a single series.

Thanks,
Mani

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
> +	dw->wr_ch_cnt = min_t(u16, chip->wr_ch_cnt,
>  			      dw_edma_v0_core_ch_count(dw, EDMA_DIR_WRITE));
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
>  	struct dw_edma_irq		*irq;
>  	int				nr_irqs;
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 329fc2e57b703..884ba55fbd530 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,7 +25,7 @@ enum dw_edma_control {
>  
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  {
> -	return dw->rg_region.vaddr;
> +	return dw->rg_region->vaddr;
>  }
>  
>  #define SET_32(dw, name, value)				\
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 4b3bcffd15ef1..a42047791e727 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -288,7 +288,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return;
>  
> -	regs = dw->rg_region.vaddr;
> +	regs = dw->rg_region->vaddr;
>  	if (!regs)
>  		return;
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index cab6e18773dad..fdb19c717aa09 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -12,19 +12,63 @@
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
>  
> +#define EDMA_MAX_WR_CH                                  8
> +#define EDMA_MAX_RD_CH                                  8
> +
>  struct dw_edma;
>  
> +struct dw_edma_region {
> +	phys_addr_t	paddr;
> +	void __iomem	*vaddr;
> +	size_t		sz;
> +};
> +
> +struct dw_edma_core_ops {
> +	int (*irq_vector)(struct device *dev, unsigned int nr);
> +};
> +
> +enum dw_edma_map_format {
> +	EDMA_MF_EDMA_LEGACY = 0x0,
> +	EDMA_MF_EDMA_UNROLL = 0x1,
> +	EDMA_MF_HDMA_COMPAT = 0x5
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
>   * @id:			 instance ID
> - * @irq:		 irq line
> + * @nr_irqs:		 total dma irq number
> + * reg64bit		 if support 64bit write to register
> + * @ops			 DMA channel to IRQ number mapping
> + * @wr_ch_cnt		 DMA write channel number
> + * @rd_ch_cnt		 DMA read channel number
> + * @rg_region		 DMA register region
> + * @ll_region_wr	 DMA descriptor link list memory for write channel
> + * @ll_region_rd	 DMA descriptor link list memory for read channel
> + * @mf			 DMA register map format
>   * @dw:			 struct dw_edma that is filed by dw_edma_probe()
>   */
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			id;
> -	int			irq;
> +	int			nr_irqs;
> +	const struct dw_edma_core_ops   *ops;
> +
> +	u16			wr_ch_cnt;
> +	u16			rd_ch_cnt;
> +
> +	struct dw_edma_region	rg_region;      /* Registers */
> +
> +	/* link list address */
> +	struct dw_edma_region	ll_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	ll_region_rd[EDMA_MAX_RD_CH];
> +
> +	/* data region */
> +	struct dw_edma_region	dt_region_wr[EDMA_MAX_WR_CH];
> +	struct dw_edma_region	dt_region_rd[EDMA_MAX_RD_CH];
> +
> +	enum dw_edma_map_format	mf;
> +
>  	struct dw_edma		*dw;
>  };
>  
> -- 
> 2.24.0.rc1
> 
