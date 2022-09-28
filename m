Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E215B5EDBF2
	for <lists+linux-pci@lfdr.de>; Wed, 28 Sep 2022 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiI1Lln (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Sep 2022 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiI1Llm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Sep 2022 07:41:42 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD4627177;
        Wed, 28 Sep 2022 04:41:40 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id b6so13994671ljr.10;
        Wed, 28 Sep 2022 04:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M5mCF6ziBXfD5EgO9VcMjVbGRktThpK45PX3gGjrmso=;
        b=RrDbSzLtd35h9ODJaGvZ37irLEhhbK+6ztug7KgRPlpWr4g5xIcqbGM61uNeUVGiPj
         NP55u1cpyhdwf6f2S0ixV8UeVDB66xwhyM68wi1J4DHJTAj2htLMmmHq8nmf4JY/vKXA
         0Sl1SLV9xiyGQCXdlAzzovyMxWYoP1CEHw3qTXPxuAvTF1co71FrHKEbnfeQb1rvKUkK
         yBVqwVPRhNd2FXNEOiSm7uP2uDCYL61BmejJzXMQ7x9Po8Hz2ZEaDJymyXvVqfFd8bkV
         PoCjY6QdBb3vd13FvcK0JsM0Wf8MkdaKSnqEycmlB1/g4K5n0OC0kox0wh9arDOYmJJB
         U09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=M5mCF6ziBXfD5EgO9VcMjVbGRktThpK45PX3gGjrmso=;
        b=UB58vXu5rVenyTsOze7DPVhrc4L1FO60sQNKweVHU0FKf7nvaVTP3dHLNWCgIsSMZB
         d2IrWHCwwU3CmQPggrXSxxg1HXbPWJd+vtZBAHBfZ4K58R4HVENaqPUjLyPyE8l7Hc9m
         nAKuodVx584M3rXVToVhH3KfnULqmZTr8eMdzYc5HTAr89vytcLkxPzWSWkFMaXmgVo0
         xfO0wJa63pzxfY9fRdBfLpPSCNXTQYChSA9D/DZ5mdqqx43x6/xtJIxZLYZIQDkHfppI
         xhFVWrjy8ItUaNpyLnwLYEyNfwSEKvsl6X0H1LTo6vVWNCzHJlcr0djEzSpn4HePUiUZ
         fXCQ==
X-Gm-Message-State: ACrzQf10IWnQkWq69yh6QeN3oLep/vxgUjMW5VqU8LKl9cxlolpFHrkK
        /chf+2HnTX5/oDmzyyCC11A=
X-Google-Smtp-Source: AMsMyM4bZnbmeYtC3e9ASll75zLYHPJwlYQvHT7PHxhWZCf1qGxhH0x4pxMGbk76axUgruz1w0eE9A==
X-Received: by 2002:a05:651c:12c7:b0:26d:90a8:791e with SMTP id 7-20020a05651c12c700b0026d90a8791emr6294718lje.251.1664365299115;
        Wed, 28 Sep 2022 04:41:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026c4305e5e2sm420624ljc.53.2022.09.28.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:41:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:41:36 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Will McVicker <willmcvicker@google.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Vidya Sagar <vidyas@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Isaac J . Manjarres" <isaacmanjarres@google.com>
Subject: Re: [PATCH v5 1/2] PCI: dwc: Drop dependency on ZONE_DMA32
Message-ID: <20220928114136.4yvtfnrcril3jkgg@mobilestation>
References: <20220825185026.3816331-1-willmcvicker@google.com>
 <20220825185026.3816331-2-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825185026.3816331-2-willmcvicker@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 25, 2022 at 06:50:24PM +0000, Will McVicker wrote:
> Re-work the msi_msg DMA allocation logic to use dmam_alloc_coherent() which
> uses the coherent DMA mask to try to return an allocation within the DMA
> mask limits. With that, we now can drop the msi_page parameter in struct
> dw_pcie_rp. This allows kernel configurations that disable ZONE_DMA32 to
> continue supporting a 32-bit DMA mask. Without this patch, the PCIe host
> device will fail to probe when ZONE_DMA32 is disabled.

As Rob already said here
https://lore.kernel.org/all/CAL_JsqJh=d-B51b6yPBRq0tOwbChN=AFPr-a19U1QdQZAE7c1A@mail.gmail.com/
and I mentioned in this thread
https://lore.kernel.org/linux-pci/20220912000211.ct6asuhhmnatje5e@mobilestation/
DW PCIe MSI doesn't cause any DMA due to the way the iMSI-RX engine is
designed. So reserving any real system memory is a waste of one in
this case. Reserving DMA-coherent even more inappropriate since it
can be expensive on some platforms (see note in Part Ia of
Documentation/core-api/dma-api.rst). For instance on MIPS32 with
non-corehent common DMA.

> 
> Fixes: 35797e672ff0 ("PCI: dwc: Fix MSI msi_msg DMA mapping")
> Reported-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 28 +++++--------------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 -
>  2 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7746f94a715f..39f3b37d4033 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -267,15 +267,6 @@ static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
>  
>  	irq_domain_remove(pp->msi_domain);
>  	irq_domain_remove(pp->irq_domain);
> -
> -	if (pp->msi_data) {
> -		struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -		struct device *dev = pci->dev;
> -
> -		dma_unmap_page(dev, pp->msi_data, PAGE_SIZE, DMA_FROM_DEVICE);
> -		if (pp->msi_page)
> -			__free_page(pp->msi_page);
> -	}
>  }
>  
>  static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
> @@ -336,6 +327,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	u64 *msi_vaddr;
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
> @@ -375,22 +367,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  						    dw_chained_msi_isr, pp);
>  	}
>  

> -	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));

This has been redundant in the first place since none of the DW PCIe
low-level drivers update the mask, and it's of 32-bits wide by default
anyway:
https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L167

>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
>  
> -	pp->msi_page = alloc_page(GFP_DMA32);
> -	pp->msi_data = dma_map_page(dev, pp->msi_page, 0,
> -				    PAGE_SIZE, DMA_FROM_DEVICE);
> -	ret = dma_mapping_error(dev, pp->msi_data);
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to map MSI data\n");
> -		__free_page(pp->msi_page);
> -		pp->msi_page = NULL;
> -		pp->msi_data = 0;
> +	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +					GFP_KERNEL);

Changing the whole device DMA-mask due to something that doesn't
perform seems inappropriate. I'd suggest to preserve the ZONE_DMA32
here until there is something like suggested by @Robin
https://lore.kernel.org/linux-pci/1e63a581-14ae-b4b5-a5bf-ca8f09c33af6@arm.com/
in the last paragraph is implemented. Especially seeing there still
common drivers in kernel which still rely on that zone.

-Sergey

> +	if (!msi_vaddr) {
> +		dev_err(dev, "Failed to alloc and map MSI data\n");
>  		dw_pcie_free_msi(pp);
> -
> -		return ret;
> +		return -ENOMEM;
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 09b887093a84..a871ae7eb59e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -243,7 +243,6 @@ struct dw_pcie_rp {
>  	struct irq_domain	*irq_domain;
>  	struct irq_domain	*msi_domain;
>  	dma_addr_t		msi_data;
> -	struct page		*msi_page;
>  	struct irq_chip		*msi_irq_chip;
>  	u32			num_vectors;
>  	u32			irq_mask[MAX_MSI_CTRLS];
> -- 
> 2.37.2.672.g94769d06f0-goog
> 
> 
