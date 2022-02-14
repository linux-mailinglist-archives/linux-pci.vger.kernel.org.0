Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272CE4B4A3F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 11:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiBNKHv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 05:07:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345351AbiBNKGI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 05:06:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225DB7463E
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 01:49:30 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 10so10115240plj.1
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/S2BvEODEAJUahCS59ViatHoyD/cWLeqwLgA2QTvjE8=;
        b=JUQGBXn8+euWZUwquBLidxbuLw3TdJfHMe5lIkxyYnB5E5+Phe4SJM/kzbR8LVgZLJ
         omYavMfQGq1XrSeFoRjwnWMWMy7yRDIgbekO0KHYkv8s0gH2vh8whPhUhPxwrcZ6XVl0
         uS0Ib/HK4qNAugHZ10eCwxmb7yWA/ZRPKv6G734jNdINZ+C6YkBZRSoRWZuykoaAmPGE
         TnqmxBsQNvEOOpJNpyzDQlo8NySA3K8Lle/JgGhv6XZ/I9EG+nyDS9yKwJ9960el5V3+
         Gh7T0qVbB5wEVxCp5E5TDp5a643j3lGzBzOp85KvPbiGro5WYSv/D3GfWNHGNWT/Q4DK
         drSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/S2BvEODEAJUahCS59ViatHoyD/cWLeqwLgA2QTvjE8=;
        b=EaEJEXTPJ565j7bwGs+YWdUeKmnvx93ZtPV5jFtKbj+kJY6ViCBp4kPaajloJ9wAU8
         gRQcD2bSZVpZK1IcCaiI58+kDWtJeT0w6LcQyA8uSKsVbSxzD0hF/TTFB0kZ4zZ/NIe7
         0WIsqBQ2WpaO8A5CgtTxUWc4CIBWTvLEn3xlgdHV8UEwFYDXZfaLXKfs0R+aEPKSy9TF
         XkJ4p9BQia0qBEAC3kBv1bN4Eny8T3/28jR8NY5J0kjgohYNNIVJNQaPXQKwG6L1oC0/
         HPs6JaA6J+SAOwgWK/YYAISgr7sNiWarpv6lrUGntBTqfQPL5hKSmwYtANKljotceK6g
         vRUQ==
X-Gm-Message-State: AOAM532Mu+vgwR6flFSl+opflQMNNPhDhMt+7ng8sMdKCvLVLw1+wxt6
        HW9zauY05GNkQ2p9XR+0BW6U
X-Google-Smtp-Source: ABdhPJz2Lk0La4YUA438Z/uoJgqgWO5edLzBJc/ODM441MaC7A5dLjTRPudSEXvP0SyxxMxIOPKrDg==
X-Received: by 2002:a17:903:2406:: with SMTP id e6mr13119868plo.21.1644832169511;
        Mon, 14 Feb 2022 01:49:29 -0800 (PST)
Received: from thinkpad ([2409:4072:817:5a6f:3104:62c0:1941:5033])
        by smtp.gmail.com with ESMTPSA id l17sm35406780pfu.61.2022.02.14.01.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 01:49:29 -0800 (PST)
Date:   Mon, 14 Feb 2022 15:19:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [RFC PATCH 2/5] PCI: endpoint: Add support to data transfer
 using internal dmac
Message-ID: <20220214094919.GJ3494@thinkpad>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220126195043.28376-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126195043.28376-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 26, 2022 at 07:50:40PM +0000, Lad Prabhakar wrote:
> For PCIe EP capable with internal DMAC, transfer data using this
> when -d option is used with pcitest.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++++++----
>  1 file changed, 141 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 90d84d3bc868..f792b1a15c44 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -55,6 +55,7 @@ struct pci_epf_test {
>  	struct dma_chan		*dma_chan;
>  	struct completion	transfer_complete;
>  	bool			dma_supported;
> +	bool			internal_dmac;

Please use "dma" everywhere.

>  	const struct pci_epc_features *epc_features;
>  };
>  
> @@ -148,6 +149,40 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
>  	return 0;
>  }
>  
> +/**
> + * pci_epf_test_internal_dmac_data_transfer() - Function that uses internal DMAC
> + *				to transfer data between PCIe EP and remote PCIe RC
> + * @epf_test: the EPF test device that performs the data transfer operation
> + * @dma_dst: The destination address of the data transfer. It can be a physical
> + *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
> + * @dma_src: The source address of the data transfer. It can be a physical
> + *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
> + * @len: The size of the data transfer
> + * @dir: Direction of data transfer
> + *
> + * Function that uses internal dmac supported by the controller to transfer data
> + * between PCIe EP and remote PCIe RC.
> + *
> + * The function returns '0' on success and negative value on failure.
> + */
> +static int
> +pci_epf_test_internal_dmac_data_transfer(struct pci_epf_test *epf_test,
> +					 dma_addr_t dma_dst, dma_addr_t dma_src,
> +					 size_t len, enum pci_epf_xfr_direction dir)
> +{
> +	struct pci_epf *epf = epf_test->epf;
> +	int ret;
> +
> +	if (!epf_test->internal_dmac)
> +		return -EINVAL;
> +
> +	ret = pci_epf_internal_dmac_xfr(epf, dma_dst, dma_src, len, dir);
> +	if (ret)
> +		return -EIO;

Why can't you return "ret"?

> +
> +	return 0;
> +}
> +
>  /**
>   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
>   * @epf_test: the EPF test device that performs data transfer operation
> @@ -238,6 +273,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  	struct pci_epc *epc = epf->epc;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	bool internal_dmac = epf_test->internal_dmac;
> +
> +	use_dma = !!(reg->flags & FLAG_USE_DMA);
> +
> +	if (use_dma && internal_dmac) {
> +		dev_err(dev, "Operation not supported\n");

Here you are erroring out but below you are checking for this condition to do
internal DMA transfer.

> +		return -EINVAL;
> +	}
>  
>  	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
> @@ -272,7 +315,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)

Why internal DMA is not used in pci_epf_test_copy()?

>  	}
>  
>  	ktime_get_ts64(&start);
> -	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  	if (use_dma) {
>  		if (!epf_test->dma_supported) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
> @@ -322,31 +364,49 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	bool internal_dmac = epf_test->internal_dmac;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> -	if (!src_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> +	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> -			       reg->src_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		goto err_addr;
> +	if (use_dma && internal_dmac) {

Both are mutually exclusive, isn't it?

> +		phys_addr = reg->src_addr;
> +		src_addr = NULL;
> +	} else {
> +		src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> +		if (!src_addr) {
> +			dev_err(dev, "Failed to allocate address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> +				       reg->src_addr, reg->size);
> +		if (ret) {
> +			dev_err(dev, "Failed to map address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			goto err_addr;
> +		}
>  	}
>  

[...]

>  
>  	ret = pci_epf_test_alloc_space(epf);
>  	if (ret)
> @@ -868,11 +964,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  			return ret;
>  	}
>  
> -	epf_test->dma_supported = true;
> +	epf_test->dma_supported = false;
>  
> -	ret = pci_epf_test_init_dma_chan(epf_test);
> -	if (ret)
> -		epf_test->dma_supported = false;
> +	if (!epf_test->internal_dmac) {
> +		ret = pci_epf_test_init_dma_chan(epf_test);
> +		if (!ret)
> +			epf_test->dma_supported = true;

You can set this flag to true inside pci_epf_test_init_dma_chan().

Thanks,
Mani

> +	}
>  
>  	if (linkup_notifier) {
>  		epf->nb.notifier_call = pci_epf_test_notifier;
> -- 
> 2.25.1
> 
