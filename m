Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045B150C9C2
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 13:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiDWMCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbiDWMCJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:02:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A911571C
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 04:59:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h12so12831015plf.12
        for <linux-pci@vger.kernel.org>; Sat, 23 Apr 2022 04:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6UgDg+2ocpLNFbTRpYBn+WlrNf2yGr3rEuN7ORq6hS8=;
        b=CFgvbUpEgsr3uFL27hNbBlqDosNfssBbN5MdHtjqVkA5fRXAoPlRlIev/Vt6uUcnJr
         IzSzozbZxjCnu1KQiEzT6jGI7AtQ6iKYA15oIFbtosEcYo8VJ5rrtIpcAb1OadQ0dUSi
         cvAD+PKsuqImNe5XBhtvGiukBrrgwlwXxd3FhgVEhR5LmKSXPxe9f3J0iH5cgIv9w6+V
         WJPbjVCDk8UWpzq5qzd23EAVv6CmWUezrGJL05LGHpJcJjj2ISlkcenwCVvOUTLPNiB2
         /hAJ5xOoVWJ/InfNq0jOIJA58VxbAhzTW7du+LhBKO38m7gH+qz70h4R1pW4570b08AK
         vqCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UgDg+2ocpLNFbTRpYBn+WlrNf2yGr3rEuN7ORq6hS8=;
        b=XQtvGeY4W8v8Oi56pq9FYvRvf+iaLp+7GoT6QDHj2R36XfzDCpd/ELIWGWnRChJTLu
         8yUbe0OBJiK933qLeS6HLMvCE6UzKfxP+oznxZwhCOe5MO88l0YwzvAbL/hynwO9xfS6
         EJNj3G911mkuY/gfPgd0fxR0EDailLQY0rG0aUlhsgSoWKxUmZQjla1wW811EPVCAa7Y
         YMIb+NyT7fJQrSryRWCjYgJpL8i5ph7/K2iY9xWpAHHBZIFEOvzZBgkPOd2QKYgmr7wE
         6Hybh9M5EknOySWNLu0adxXyoTDYypjELUnXL2QJfDpJKa4wmCBuHj6Jos68rL5K05Vk
         3J5Q==
X-Gm-Message-State: AOAM533UsMWHFczkZo2nPtkAUTCCCidhb9mGuVN7CXxQShrvq7mLOQPy
        kx5ep46+tNBWJqnbRoxzZwNI
X-Google-Smtp-Source: ABdhPJx+DuEs2H3Icp+ylUzLWKTMO82C+ulce3xm0y26BHvn5ZMiXtB2VAD2AkKwNShFCVK29W3LZA==
X-Received: by 2002:a17:90b:390c:b0:1d0:9963:6eb8 with SMTP id ob12-20020a17090b390c00b001d099636eb8mr21030746pjb.59.1650715149265;
        Sat, 23 Apr 2022 04:59:09 -0700 (PDT)
Received: from thinkpad ([117.207.28.196])
        by smtp.gmail.com with ESMTPSA id p4-20020a637404000000b00375948e63d6sm4605905pgc.91.2022.04.23.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:59:08 -0700 (PDT)
Date:   Sat, 23 Apr 2022 17:29:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        fancer.lancer@gmail.com, lznuaa@gmail.com, helgaas@kernel.org,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v9 3/9] dmaengine: dw-edma: Change rg_region to reg_base
 in struct dw_edma_chip
Message-ID: <20220423115902.GF374560@thinkpad>
References: <20220422143643.727871-1-Frank.Li@nxp.com>
 <20220422143643.727871-4-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422143643.727871-4-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 22, 2022 at 09:36:37AM -0500, Frank Li wrote:
> struct dw_edma_region rg_region included virtual address, physical
> address and size informaiton. But only virtual address is used by EDMA

information

> driver. Change it to void __iomem *reg_base to clean up code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> ---
> Change from v6 to v9:
>  - none
> Change from v5 to v6:
>  -s/change/Change at subject
> New patch at v4
> 
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c       | 6 +++---
>  drivers/dma/dw-edma/dw-edma-v0-core.c    | 2 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 2 +-
>  include/linux/dma/edma.h                 | 3 ++-
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2c1c5fa4e9f28..ae42bad24dd5a 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -233,8 +233,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	chip->wr_ch_cnt = vsec_data.wr_ch_cnt;
>  	chip->rd_ch_cnt = vsec_data.rd_ch_cnt;
>  
> -	chip->rg_region.vaddr = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> -	if (!chip->rg_region.vaddr)
> +	chip->reg_base = pcim_iomap_table(pdev)[vsec_data.rg.bar];
> +	if (!chip->reg_base)
>  		return -ENOMEM;
>  
>  	for (i = 0; i < chip->wr_ch_cnt; i++) {
> @@ -299,7 +299,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	pci_dbg(pdev, "Registers:\tBAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p)\n",
>  		vsec_data.rg.bar, vsec_data.rg.off, vsec_data.rg.sz,
> -		chip->rg_region.vaddr);
> +		chip->reg_base);
>  
>  
>  	for (i = 0; i < chip->wr_ch_cnt; i++) {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 6cf6c28ce0cc9..c59e23b9f9fdb 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -25,7 +25,7 @@ enum dw_edma_control {
>  
>  static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  {
> -	return dw->chip->rg_region.vaddr;
> +	return dw->chip->reg_base;
>  }
>  
>  #define SET_32(dw, name, value)				\
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index da88958399a95..f59e7c37feac3 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -287,7 +287,7 @@ void dw_edma_v0_debugfs_on(struct dw_edma *dw)
>  	if (!dw)
>  		return;
>  
> -	regs = dw->chip->rg_region.vaddr;
> +	regs = dw->chip->reg_base;
>  	if (!regs)
>  		return;
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 6fd374cc72c8e..e9ce652b88233 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -39,6 +39,7 @@ enum dw_edma_map_format {
>   * @id:			 instance ID
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
> + * @reg_base		 DMA register base address
>   * @wr_ch_cnt		 DMA write channel number
>   * @rd_ch_cnt		 DMA read channel number
>   * @rg_region		 DMA register region
> @@ -53,7 +54,7 @@ struct dw_edma_chip {
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
>  
> -	struct dw_edma_region	rg_region;
> +	void __iomem		*reg_base;
>  
>  	u16			wr_ch_cnt;
>  	u16			rd_ch_cnt;
> -- 
> 2.35.1
> 
