Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100F31C9DB7
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 23:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgEGVpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 17:45:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39721 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEGVoV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 17:44:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id m13so5857164otf.6;
        Thu, 07 May 2020 14:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N9AdjN2grTDKj0LC6+6n7CezqEC5sJdE8xDXYQF1i3s=;
        b=lCnY1uExZeEzYZ5pv9G78d1PkSXsKddixvbrn48Oxuy1oxzIjCAyFuBzBVm1OvzjRh
         G5P91h9l+Mkh/85EbzPgxn3qAjmGWFxR3FbOmLh60/t0p/n4boDbF90/bT3DeJQbm6LS
         YcFLod5OUPp9c6f1MSo+2AgGdzCHqnWSDHJ5eqo8y2wqPXGIYn9i0vDT4bGkrSbwpNe2
         fILb+Jrgp/oTpoUBMh2cVT0ORRo559M0y4/ro6SyO3xoooHFpTMEXrIHxZ+V4+PNIj0Z
         qoJqMglYokdW6YMHgFoLzraiAsqFboejcv7QZGYsDPOKHDAnJaSjc+mmQ8iilswzhiY+
         58fg==
X-Gm-Message-State: AGi0PuZKXCHFx6E+99SlDp6S3lfEwuuOpy6sk8j8cah6epaSSQVmBsUh
        6tmF4wNRoiBAKR0CV/PEGw==
X-Google-Smtp-Source: APiQypLhRJk4LtAJP8Fc/YOnELVetovZB3qLkmaTtGMFxTfHBSM/5ti/Wip+PxXNkxCkyJss2ezbvg==
X-Received: by 2002:a05:6830:154c:: with SMTP id l12mr12665391otp.120.1588887860161;
        Thu, 07 May 2020 14:44:20 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s13sm1705690oic.27.2020.05.07.14.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:19 -0700 (PDT)
Received: (nullmailer pid 24797 invoked by uid 1000);
        Thu, 07 May 2020 21:44:18 -0000
Date:   Thu, 7 May 2020 16:44:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alan Mikhak <alan.mikhak@sifive.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        efremov@linux.com, b.zolnierkie@samsung.com, vidyas@nvidia.com,
        paul.walmsley@sifive.com
Subject: Re: [PATCH] PCI: endpoint: functions/pci-epf-test: Support slave DMA
 transfer
Message-ID: <20200507214418.GA22159@bogus>
References: <1588379352-22550-1-git-send-email-alan.mikhak@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588379352-22550-1-git-send-email-alan.mikhak@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 01, 2020 at 05:29:12PM -0700, Alan Mikhak wrote:
> From: Alan Mikhak <alan.mikhak@sifive.com>
> 
> Modify pci_epf_test_data_transfer() to also support slave DMA transfers.
> Adds a direction parameter so caller can specify one of the supported DMA
> transfer directions: DMA_MEM_TO_MEM, DMA_MEM_TO_DEV, and DMA_DEV_TO_MEM.
> For DMA_MEM_TO_MEM, the function calls dmaengine_prep_dma_memcpy() as it
> did before. For DMA_MEM_TO_DEV or DMA_DEV_TO_MEM direction, the function
> calls dmaengine_slave_config() to configure the slave channel before it
> calls dmaengine_prep_slave_single().
> 
> Modify existing callers to specify DMA_MEM_TO_MEM since that is the only
> possible option so far. Rename the phys_addr local variable in some of the
> callers for more readability. Tighten some of the timing function calls to
> avoid counting error print time in case of error.

Looks fine, but also needs a user. The last sentence sounds like a 
separate change.

> 
> Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 67 ++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 60330f3e3751..1d026682febb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -104,25 +104,41 @@ static void pci_epf_test_dma_callback(void *param)
>   * The function returns '0' on success and negative value on failure.
>   */
>  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> -				      dma_addr_t dma_dst, dma_addr_t dma_src,
> -				      size_t len)
> +				      dma_addr_t dma_dst,
> +				      dma_addr_t dma_src,
> +				      size_t len,
> +				      enum dma_transfer_direction dir)
>  {
>  	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>  	struct dma_chan *chan = epf_test->dma_chan;
>  	struct pci_epf *epf = epf_test->epf;
> +	struct dma_slave_config sconf;
>  	struct dma_async_tx_descriptor *tx;
>  	struct device *dev = &epf->dev;
>  	dma_cookie_t cookie;
> +	dma_addr_t buf;
>  	int ret;
>  
>  	if (IS_ERR_OR_NULL(chan)) {
> -		dev_err(dev, "Invalid DMA memcpy channel\n");
> +		dev_err(dev, "Invalid DMA channel\n");
>  		return -EINVAL;
>  	}
>  
> -	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> +	if (dir == DMA_MEM_TO_MEM) {
> +		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src,
> +					       len, flags);
> +	} else {
> +		memset(&sconf, 0, sizeof(sconf));
> +		sconf.direction = dir;
> +		sconf.dst_addr = dma_dst;
> +		sconf.src_addr = dma_src;
> +		dmaengine_slave_config(chan, &sconf);
> +
> +		buf = (dir == DMA_MEM_TO_DEV) ? dma_dst : dma_src;
> +		tx = dmaengine_prep_slave_single(chan, buf, len, dir, flags);
> +	}
>  	if (!tx) {
> -		dev_err(dev, "Failed to prepare DMA memcpy\n");
> +		dev_err(dev, "Failed to prepare DMA transfer\n");
>  		return -EIO;
>  	}
>  
> @@ -268,7 +284,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  		goto err_dst_addr;
>  	}
>  
> -	ktime_get_ts64(&start);
>  	use_dma = !!(reg->flags & FLAG_USE_DMA);
>  	if (use_dma) {
>  		if (!epf_test->dma_supported) {
> @@ -277,14 +292,18 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
>  			goto err_map_addr;
>  		}
>  
> +		ktime_get_ts64(&start);
>  		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 src_phys_addr, reg->size);
> +						 src_phys_addr, reg->size,
> +						 DMA_MEM_TO_MEM);
> +		ktime_get_ts64(&end);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
>  	} else {
> +		ktime_get_ts64(&start);
>  		memcpy(dst_addr, src_addr, reg->size);
> +		ktime_get_ts64(&end);
>  	}
> -	ktime_get_ts64(&end);
>  	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
>  
>  err_map_addr:
> @@ -310,7 +329,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	void *buf;
>  	u32 crc32;
>  	bool use_dma;
> -	phys_addr_t phys_addr;
> +	phys_addr_t src_phys_addr;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> @@ -319,8 +338,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> +	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
>  	if (!src_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
>  		reg->status = STATUS_SRC_ADDR_INVALID;
> @@ -328,7 +348,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  		goto err;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
> +	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
>  			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "Failed to map address\n");
> @@ -360,10 +380,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  
>  		ktime_get_ts64(&start);
>  		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 phys_addr, reg->size);
> +						 src_phys_addr, reg->size, dir);
> +		ktime_get_ts64(&end);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
>  
>  		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
>  				 DMA_FROM_DEVICE);
> @@ -383,10 +403,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
>  	kfree(buf);
>  
>  err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
>  
>  err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
> +	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
>  
>  err:
>  	return ret;
> @@ -398,7 +418,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	void __iomem *dst_addr;
>  	void *buf;
>  	bool use_dma;
> -	phys_addr_t phys_addr;
> +	phys_addr_t dst_phys_addr;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> @@ -407,8 +427,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	struct device *dma_dev = epf->epc->dev.parent;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
>  
> -	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> +	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
>  	if (!dst_addr) {
>  		dev_err(dev, "Failed to allocate address\n");
>  		reg->status = STATUS_DST_ADDR_INVALID;
> @@ -416,7 +437,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  		goto err;
>  	}
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
> +	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
>  			       reg->size);
>  	if (ret) {
>  		dev_err(dev, "Failed to map address\n");
> @@ -450,11 +471,11 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  		}
>  
>  		ktime_get_ts64(&start);
> -		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> -						 src_phys_addr, reg->size);
> +		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> +						 src_phys_addr,	reg->size, dir);
> +		ktime_get_ts64(&end);
>  		if (ret)
>  			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
>  
>  		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
>  				 DMA_TO_DEVICE);
> @@ -476,10 +497,10 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
>  	kfree(buf);
>  
>  err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
> +	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
>  
>  err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
> +	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
>  
>  err:
>  	return ret;
> -- 
> 2.7.4
> 
