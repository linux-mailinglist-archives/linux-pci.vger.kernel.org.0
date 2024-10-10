Return-Path: <linux-pci+bounces-14211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0F9998E06
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0791F24DB1
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 17:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4812B199FDE;
	Thu, 10 Oct 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E59buwKE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09119922D
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728579940; cv=none; b=FzLgI0CIDazTqxA5xHQ+igQm1IoQWKIcVXV3laScJ8Hj1KjfNur+7YDj5tXvRt98vUeQumLmpHFZirnAVW1KiRBrivegjhBb+Uq5oKcA2SKRwCOmA0l2Sq1F9yMVR4bXPkrGCVPZ8FJYHXv6Gvf3UsIV0VA5dHkPSBkckyMO214=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728579940; c=relaxed/simple;
	bh=zWBxyW39BCErTINCr9TkzNOH0mDSrEswtS4Y4izOwwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiSbY2Q3Fu8zuNIf+gtyP3p3lIJG0t3rGasb+gP5yC8PDLhIwbj8su+VX4vdURmzep0qluDuf1cJhCwzTr0c1WW3Ty0YmSZNYfMT5bxSTI5/7jF16XCUDuGQzGAwLFiKvTYyxF6EacL7ZjS1mZx0cjtAPEIXY/CwSkwSQyg0Fxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E59buwKE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c7edf2872so10022315ad.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728579937; x=1729184737; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6g2rTDjnBgG34ReZRI4V+owCsPsodvuOlNe9Ao2oZE=;
        b=E59buwKEIudX/rPgb1TnVGoRCYOMGWKNGFN3RGKLqLh8J7Jvr/JABfXZMQaDXAh4/i
         wNavTO3CgJ2WkWFzpYw+/VxvS7GTyoOZGU2za3Dl+nFiyxmVCmpLLRqnA/qDty0UWfXg
         WWlqpUex1KzXqSMjGrzNw2zyI3R8iAWmoXLM/VpxDWooKMyNaTPaXG/EkxjYFPqMktEt
         fDcB0hFcQFzvBVJZSZ4QlzfjYbGfZUfXHX7KLDguZ1VLdK1PB+bRoB5Al3eaXUo4Tf1d
         2+VlQ1XSx9a9OpkjARUx3Ta4SB/fkkGwQcQk9cvCuGvyY4C4t974L1GJJcXsg7KywKfy
         i3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728579937; x=1729184737;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6g2rTDjnBgG34ReZRI4V+owCsPsodvuOlNe9Ao2oZE=;
        b=wVwZDoU1kpzuGNQ74TMYuScG2KCNPl4dbukzeETDZhYMpcC9v9yzowm3JMfQUA+xAh
         dSPdh4Rlhs3cS368xJHm4xfZt+GGNeBzTbfLI4bkfcWV5688tGM00TUGglKp/CjTkCxW
         C53xxGxxUYi/cLbI4Z3RVlaZqbCGtkX8TU6y4Jt6cnMqR3jzneKpIRfcYjLFvkZTLZ4D
         MmAFwEUbj1ZLHYkKo/psPwyUiPwvC+DMRZqhBo+mHWyPJFIkB1gK2aHUoxqy+FfT/R6s
         xUYlKYPFum0g7DIkepZi250kU6u4u4/uxgRctCY55KJfLnqswZD03EHHhbzPQP6myW5L
         e5uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkQ1i+83msjjEPndFB1dBxAhmRoiYg3+CSG7fYk1JZxcX4fv1iZFykXPlrgwk+85juVY4MrAsxgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWldBMkgkEUpyOcOQR/Cr1SzBywV/kyeHitmbHNEST4rBpOTQR
	7D/JWgdngwrbEy0JgEHCOmdJZGO42kYQUCLlnU7h888Gw3RumiXEBnHpklL/Fg==
X-Google-Smtp-Source: AGHT+IHCe9OjaCpP0U0EeoIxYwPZayGqrbk5YiYMLdQGydp7HsoUJkumYzHX++Agw3aHDziOyca6gg==
X-Received: by 2002:a17:902:c948:b0:20b:7373:67a6 with SMTP id d9443c01a7336-20c804c0fa7mr67457205ad.18.1728579937443;
        Thu, 10 Oct 2024 10:05:37 -0700 (PDT)
Received: from thinkpad ([36.255.17.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c33e413sm11508035ad.252.2024.10.10.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 10:05:36 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:35:30 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 6/7] PCI: endpoint: test: Use pci_epc_mem_map/unmap()
Message-ID: <20241010170530.u3tw43ykobh24vog@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-7-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007040319.157412-7-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:03:18PM +0900, Damien Le Moal wrote:
> Modify the endpoint test driver to use the functions pci_epc_mem_map()
> and pci_epc_mem_unmap() for the read, write and copy tests. For each
> test case, the transfer (dma or mmio) are executed in a loop to ensure
> that potentially partial mappings returned by pci_epc_mem_map() are
> correctly handled.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 372 +++++++++---------
>  1 file changed, 193 insertions(+), 179 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 7c2ed6eae53a..a73bc0771d35 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -317,91 +317,92 @@ static void pci_epf_test_print_rate(struct pci_epf_test *epf_test,
>  static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *src_addr;
> -	void __iomem *dst_addr;
> -	phys_addr_t src_phys_addr;
> -	phys_addr_t dst_phys_addr;
> +	int ret = 0;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
> +	struct pci_epc_map src_map, dst_map;
> +	u64 src_addr = reg->src_addr;
> +	u64 dst_addr = reg->dst_addr;
> +	size_t copy_size = reg->size;
> +	ssize_t map_size = 0;
> +	void *copy_buf = NULL, *buf;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
> -	if (!src_addr) {
> -		dev_err(dev, "Failed to allocate source address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		ret = -ENOMEM;
> -		goto err;
> -	}
> -
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr,
> -			       reg->src_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map source address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		goto err_src_addr;
> -	}
> -
> -	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
> -	if (!dst_addr) {
> -		dev_err(dev, "Failed to allocate destination address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		ret = -ENOMEM;
> -		goto err_src_map_addr;
> -	}
> -
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr,
> -			       reg->dst_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map destination address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		goto err_dst_addr;
> -	}
> -
> -	ktime_get_ts64(&start);
>  	if (reg->flags & FLAG_USE_DMA) {
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> -			goto err_map_addr;
> +			goto set_status;
>  		}
> -
> -		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 src_phys_addr, reg->size, 0,
> -						 DMA_MEM_TO_MEM);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
>  	} else {
> -		void *buf;
> -
> -		buf = kzalloc(reg->size, GFP_KERNEL);
> -		if (!buf) {
> +		copy_buf = kzalloc(copy_size, GFP_KERNEL);
> +		if (!copy_buf) {
>  			ret = -ENOMEM;
> -			goto err_map_addr;
> +			goto set_status;
>  		}
> -
> -		memcpy_fromio(buf, src_addr, reg->size);
> -		memcpy_toio(dst_addr, buf, reg->size);
> -		kfree(buf);
> +		buf = copy_buf;
>  	}
> -	ktime_get_ts64(&end);
> -	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
>  
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, dst_phys_addr);
> +	while (copy_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +				      src_addr, copy_size, &src_map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map source address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			goto free_buf;
> +		}
> +
> +		ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
> +					   dst_addr, copy_size, &dst_map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map destination address\n");
> +			reg->status = STATUS_DST_ADDR_INVALID;
> +			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
> +					  &src_map);
> +			goto free_buf;
> +		}
> +
> +		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
> +
> +		ktime_get_ts64(&start);
> +		if (reg->flags & FLAG_USE_DMA) {
> +			ret = pci_epf_test_data_transfer(epf_test,
> +					dst_map.phys_addr, src_map.phys_addr,
> +					map_size, 0, DMA_MEM_TO_MEM);
> +			if (ret) {
> +				dev_err(dev, "Data transfer failed\n");
> +				goto unmap;
> +			}
> +		} else {
> +			memcpy_fromio(buf, src_map.virt_addr, map_size);
> +			memcpy_toio(dst_map.virt_addr, buf, map_size);
> +			buf += map_size;
> +		}
> +		ktime_get_ts64(&end);
>  
> -err_dst_addr:
> -	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
> +		copy_size -= map_size;
> +		src_addr += map_size;
> +		dst_addr += map_size;
>  
> -err_src_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, src_phys_addr);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
> +		map_size = 0;
> +	}
>  
> -err_src_addr:
> -	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
> +	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
> -err:
> +unmap:
> +	if (map_size) {
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &dst_map);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &src_map);
> +	}
> +
> +free_buf:
> +	kfree(copy_buf);
> +
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_COPY_SUCCESS;
>  	else
> @@ -411,82 +412,89 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  			      struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *src_addr;
> -	void *buf;
> +	int ret = 0;
> +	void *src_buf, *buf;
>  	u32 crc32;
> -	phys_addr_t phys_addr;
> +	struct pci_epc_map map;
>  	phys_addr_t dst_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> +	u64 src_addr = reg->src_addr;
> +	size_t src_size = reg->size;
> +	ssize_t map_size = 0;
>  
> -	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> -	if (!src_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> +	src_buf = kzalloc(src_size, GFP_KERNEL);
> +	if (!src_buf) {
>  		ret = -ENOMEM;
> -		goto err;
> +		goto set_status;
>  	}
> +	buf = src_buf;
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> -			       reg->src_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map address\n");
> -		reg->status = STATUS_SRC_ADDR_INVALID;
> -		goto err_addr;
> -	}
> -
> -	buf = kzalloc(reg->size, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto err_map_addr;
> -	}
> +	while (src_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +					   src_addr, src_size, &map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map address\n");
> +			reg->status = STATUS_SRC_ADDR_INVALID;
> +			goto free_buf;
> +		}
>  
> -	if (reg->flags & FLAG_USE_DMA) {
> -		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
> -					       DMA_FROM_DEVICE);
> -		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> -			dev_err(dev, "Failed to map destination buffer addr\n");
> -			ret = -ENOMEM;
> -			goto err_dma_map;
> +		map_size = map.pci_size;
> +		if (reg->flags & FLAG_USE_DMA) {
> +			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
> +						       DMA_FROM_DEVICE);
> +			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> +				dev_err(dev,
> +					"Failed to map destination buffer addr\n");
> +				ret = -ENOMEM;
> +				goto unmap;
> +			}
> +
> +			ktime_get_ts64(&start);
> +			ret = pci_epf_test_data_transfer(epf_test,
> +					dst_phys_addr, map.phys_addr,
> +					map_size, src_addr, DMA_DEV_TO_MEM);
> +			if (ret)
> +				dev_err(dev, "Data transfer failed\n");
> +			ktime_get_ts64(&end);
> +
> +			dma_unmap_single(dma_dev, dst_phys_addr, map_size,
> +					 DMA_FROM_DEVICE);
> +
> +			if (ret)
> +				goto unmap;
> +		} else {
> +			ktime_get_ts64(&start);
> +			memcpy_fromio(buf, map.virt_addr, map_size);
> +			ktime_get_ts64(&end);
>  		}
>  
> -		ktime_get_ts64(&start);
> -		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> -						 phys_addr, reg->size,
> -						 reg->src_addr, DMA_DEV_TO_MEM);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
> +		src_size -= map_size;
> +		src_addr += map_size;
> +		buf += map_size;
>  
> -		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
> -				 DMA_FROM_DEVICE);
> -	} else {
> -		ktime_get_ts64(&start);
> -		memcpy_fromio(buf, src_addr, reg->size);
> -		ktime_get_ts64(&end);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
> +		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
> -	crc32 = crc32_le(~0, buf, reg->size);
> +	crc32 = crc32_le(~0, src_buf, reg->size);
>  	if (crc32 != reg->checksum)
>  		ret = -EIO;
>  
> -err_dma_map:
> -	kfree(buf);
> -
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
> +unmap:
> +	if (map_size)
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
>  
> -err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
> +free_buf:
> +	kfree(src_buf);
>  
> -err:
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_READ_SUCCESS;
>  	else
> @@ -496,71 +504,79 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  			       struct pci_epf_test_reg *reg)
>  {
> -	int ret;
> -	void __iomem *dst_addr;
> -	void *buf;
> -	phys_addr_t phys_addr;
> +	int ret = 0;
> +	void *dst_buf, *buf;
> +	struct pci_epc_map map;
>  	phys_addr_t src_phys_addr;
>  	struct timespec64 start, end;
>  	struct pci_epf *epf = epf_test->epf;
> -	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> +	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> +	u64 dst_addr = reg->dst_addr;
> +	size_t dst_size = reg->size;
> +	ssize_t map_size = 0;
>  
> -	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
> -	if (!dst_addr) {
> -		dev_err(dev, "Failed to allocate address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> +	dst_buf = kzalloc(dst_size, GFP_KERNEL);
> +	if (!dst_buf) {
>  		ret = -ENOMEM;
> -		goto err;
> +		goto set_status;
>  	}
> +	get_random_bytes(dst_buf, dst_size);
> +	reg->checksum = crc32_le(~0, dst_buf, dst_size);
> +	buf = dst_buf;
>  
> -	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
> -			       reg->dst_addr, reg->size);
> -	if (ret) {
> -		dev_err(dev, "Failed to map address\n");
> -		reg->status = STATUS_DST_ADDR_INVALID;
> -		goto err_addr;
> -	}
> -
> -	buf = kzalloc(reg->size, GFP_KERNEL);
> -	if (!buf) {
> -		ret = -ENOMEM;
> -		goto err_map_addr;
> -	}
> -
> -	get_random_bytes(buf, reg->size);
> -	reg->checksum = crc32_le(~0, buf, reg->size);
> -
> -	if (reg->flags & FLAG_USE_DMA) {
> -		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
> -					       DMA_TO_DEVICE);
> -		if (dma_mapping_error(dma_dev, src_phys_addr)) {
> -			dev_err(dev, "Failed to map source buffer addr\n");
> -			ret = -ENOMEM;
> -			goto err_dma_map;
> +	while (dst_size) {
> +		ret = pci_epc_mem_map(epc, epf->func_no, epf->vfunc_no,
> +					   dst_addr, dst_size, &map);
> +		if (ret) {
> +			dev_err(dev, "Failed to map address\n");
> +			reg->status = STATUS_DST_ADDR_INVALID;
> +			goto free_buf;
>  		}
>  
> -		ktime_get_ts64(&start);
> +		map_size = map.pci_size;
> +		if (reg->flags & FLAG_USE_DMA) {
> +			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
> +						       DMA_TO_DEVICE);
> +			if (dma_mapping_error(dma_dev, src_phys_addr)) {
> +				dev_err(dev,
> +					"Failed to map source buffer addr\n");
> +				ret = -ENOMEM;
> +				goto unmap;
> +			}
> +
> +			ktime_get_ts64(&start);
> +
> +			ret = pci_epf_test_data_transfer(epf_test,
> +						map.phys_addr, src_phys_addr,
> +						map_size, dst_addr,
> +						DMA_MEM_TO_DEV);
> +			if (ret)
> +				dev_err(dev, "Data transfer failed\n");
> +			ktime_get_ts64(&end);
> +
> +			dma_unmap_single(dma_dev, src_phys_addr, map_size,
> +					 DMA_TO_DEVICE);
> +
> +			if (ret)
> +				goto unmap;
> +		} else {
> +			ktime_get_ts64(&start);
> +			memcpy_toio(map.virt_addr, buf, map_size);
> +			ktime_get_ts64(&end);
> +		}
>  
> -		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> -						 src_phys_addr, reg->size,
> -						 reg->dst_addr,
> -						 DMA_MEM_TO_DEV);
> -		if (ret)
> -			dev_err(dev, "Data transfer failed\n");
> -		ktime_get_ts64(&end);
> +		dst_size -= map_size;
> +		dst_addr += map_size;
> +		buf += map_size;
>  
> -		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
> -				 DMA_TO_DEVICE);
> -	} else {
> -		ktime_get_ts64(&start);
> -		memcpy_toio(dst_addr, buf, reg->size);
> -		ktime_get_ts64(&end);
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
> +		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start, &end,
> -				reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
> +				&end, reg->flags & FLAG_USE_DMA);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> @@ -568,16 +584,14 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	 */
>  	usleep_range(1000, 2000);
>  
> -err_dma_map:
> -	kfree(buf);
> -
> -err_map_addr:
> -	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
> +unmap:
> +	if (map_size)
> +		pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no, &map);
>  
> -err_addr:
> -	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
> +free_buf:
> +	kfree(dst_buf);
>  
> -err:
> +set_status:
>  	if (!ret)
>  		reg->status |= STATUS_WRITE_SUCCESS;
>  	else
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

