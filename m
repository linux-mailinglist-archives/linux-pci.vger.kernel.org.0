Return-Path: <linux-pci+bounces-20385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C90A1D0E6
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 07:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C27B3A2DB4
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 06:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A801FC0EB;
	Mon, 27 Jan 2025 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npesmXrk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559A27701
	for <linux-pci@vger.kernel.org>; Mon, 27 Jan 2025 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737959218; cv=none; b=Jmph3IJ2qyG+B/X8mmqJ+ZhpCOqrm9+jOzGeViomYVWEQ28ME/JTDs2QkuM9KsluGPPH+Qw8OUhRCKk/CXZX4pQMKhS4MxqHLAmdRwp8POC1Y4rrWU/+4OlvzRMvzuQmkZ5EgqUnpABYGBBhZW2B/z1uhMP4XCiiD9HI46Za948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737959218; c=relaxed/simple;
	bh=mp6m7E/s4ibctAoNzSy8wZTg593eLjGK9fzN6TNpQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNEncpaqhvqgA9IM/tm71+LtL8ww/hheTbASpRLcBx8hqi4QhnRF5+5cg3WpnfOeJR2Wh7E3pkos+Fw/ETNDPKwiCf8fP351dihWzqdS9p4ExU1hVxu71Pd7TJbmOIBJ35LHtbC/39jNbITW/Lghxr4aip6iAffisPBlfc6KLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=npesmXrk; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso5330759a91.0
        for <linux-pci@vger.kernel.org>; Sun, 26 Jan 2025 22:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737959216; x=1738564016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3BEkm9vxURKa5GQg9Jb74/bKXw8JM6x9ywJhZbYwkg=;
        b=npesmXrkb8c5MyhfKSXI3WKCGMm0/fff8Fj/ci0nuopcjW+1P7m6h3JaGEmB+tjatB
         smW+aujyh1WpM1Vt3LpY+jNMIzjrtPKVNLFrbsP1b6DXRGSp4+5Y10ZHgU9LbuT7df6w
         +LwrMeG91SYNcS71hvI6GBCQr2sl9KGhAFKbZaCSfYgzoNRi9g9MZcWX/TZuw0LTkysv
         +27xvGiK+RjSRfm5mnvXZgBTltel4r2cHQJjAMbiwJr03+BNRgI90Ns6XNM0uggVgA2n
         c0ExsLijdDWXNL/H2Tl+p25aDGtlPeAnRmO9Kbpc1pAMeu1faS2shF6jfCj8w3qBCp8o
         QL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737959216; x=1738564016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3BEkm9vxURKa5GQg9Jb74/bKXw8JM6x9ywJhZbYwkg=;
        b=CGEx0Um5P136Sv+etB7Mv8sR0KXNCBunL2MJ2SFQimK7BDjdMtGPzaSXga/hyfsJPA
         gBDqAcIL0TZZ1dzl2cZ3DhU4JCyV7Na8QMBfZ8tsu88AtIzPzlAZCROhPca2A3500CQJ
         du8xof4suJYVISUmf/0kIvXgl4JjjnXXsUxoU637CO2PlBaLAB96+yMIY5uPhVKGBpOX
         y+9NfoQlTanucYtDlxnGS0Vn7du9y4NaBGxkuhjmN1EUyc1GCe8NYGooxUWkCV/rOBFB
         3u78bJ5hwBncFXTi5V9mzMUxiiG/JiE4fu3gDrXyMN00pg4IPgM8Zy1iQQlhocjurl50
         TWKg==
X-Forwarded-Encrypted: i=1; AJvYcCUEGmw6Bt0PhE0jYudwjzRd8Gat2QHcW/YU4FXNYcKEmgvMiZYO1wfZZu4p7pETF071Eu/Gstkm1Rg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZSgZmyoSBAleWtj2rwBgGSQmlwQFLgJuikmZgq5eshEXHiOy
	b80OnmppmHuSL8oVKHuWpsCv26Vmt+7KrFeXco+tiasVdYxzr5Gt1jSI9Ayd4w==
X-Gm-Gg: ASbGnct58SI2LGq+mt+fBh/QcYPJyZKlZ1zfveVA6+4pBxOYJWsIz7Xj9K9oSOax5cm
	tcIpxRctWU2ZXPm9kAom8by+1r8bFXst86RUADBdEoS0LTgb1xQa2YYjNpgAAdqk0sdgiTeSLdY
	vS/0rzFYDU6IuDY2c3Zrf7zXItHAtC4UUrcxx9RMJ2Dpq5K1CLaP8sMn2kKnfhDuMA75YS0iAMP
	pa9einwuMAaGuyghIxMUrOqxf5L/kTcLeqBOaOEeNoWREEZTLu8KPa9MhdT5yLUIBal7X+9HEsf
	r1JZ+daUYmsvX9vmtZv2X4e4cw==
X-Google-Smtp-Source: AGHT+IEydYc7fIIUKZc8s8EA1NmH7jdjbpBZrewCiN6ZyJtX+dU0bu68pJ1snefNuKCgs9YqCbxALw==
X-Received: by 2002:a05:6a00:2e24:b0:728:8c17:127d with SMTP id d2e1a72fcca58-72daf948568mr63128747b3a.8.1737959215954;
        Sun, 26 Jan 2025 22:26:55 -0800 (PST)
Received: from thinkpad ([120.60.139.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a77c779sm6450605b3a.145.2025.01.26.22.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 22:26:55 -0800 (PST)
Date: Mon, 27 Jan 2025 11:56:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-test: Handle endianness properly
Message-ID: <20250127062647.ehadg6ji53hkbsbf@thinkpad>
References: <20250120115009.2748899-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120115009.2748899-2-cassel@kernel.org>

On Mon, Jan 20, 2025 at 12:50:10PM +0100, Niklas Cassel wrote:
> The struct pci_epf_test_reg is the actual data in pci-epf-test's test_reg
> BAR (usually BAR0), which the host uses to send commands (etc.), and which
> pci-epf-test uses to send back status codes.
> 
> pci-epf-test currently reads and writes this data without any endianness
> conversion functions, which means that pci-epf-test is completely broken
> on big-endian systems.

Not a big deal, but I'd like to mention 'big-endian endpoint systems' to clarify
the fact that the endianess issue is with the endpoint systems.

> 
> PCI devices are inherently little-endian, and the data stored in the PCI
> BARs should be in little-endian.
> 
> Use endianness conversion functions when reading and writing data to
> struct pci_epf_test_reg so that pci-epf-test will behave correctly on
> big-endian systems.
> 

Same here.

> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Fixes: 349e7a85b25f ("PCI: endpoint: functions: Add an EP function to test PCI")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

No need to respin, these can be ammended while applying.

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 126 ++++++++++--------
>  1 file changed, 73 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ffb534a8e50a..c1359f3662ae 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -66,17 +66,17 @@ struct pci_epf_test {
>  };
>  
>  struct pci_epf_test_reg {
> -	u32	magic;
> -	u32	command;
> -	u32	status;
> -	u64	src_addr;
> -	u64	dst_addr;
> -	u32	size;
> -	u32	checksum;
> -	u32	irq_type;
> -	u32	irq_number;
> -	u32	flags;
> -	u32	caps;
> +	__le32 magic;
> +	__le32 command;
> +	__le32 status;
> +	__le64 src_addr;
> +	__le64 dst_addr;
> +	__le32 size;
> +	__le32 checksum;
> +	__le32 irq_type;
> +	__le32 irq_number;
> +	__le32 flags;
> +	__le32 caps;
>  } __packed;
>  
>  static struct pci_epf_header test_header = {
> @@ -324,13 +324,17 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc_map src_map, dst_map;
> -	u64 src_addr = reg->src_addr;
> -	u64 dst_addr = reg->dst_addr;
> -	size_t copy_size = reg->size;
> +	u64 src_addr = le64_to_cpu(reg->src_addr);
> +	u64 dst_addr = le64_to_cpu(reg->dst_addr);
> +	size_t orig_size, copy_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 status = 0;
>  	void *copy_buf = NULL, *buf;
>  
> -	if (reg->flags & FLAG_USE_DMA) {
> +	orig_size = copy_size = le32_to_cpu(reg->size);
> +
> +	if (flags & FLAG_USE_DMA) {
>  		if (epf_test->dma_private) {
>  			dev_err(dev, "Cannot transfer data using DMA\n");
>  			ret = -EINVAL;
> @@ -350,7 +354,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  				      src_addr, copy_size, &src_map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map source address\n");
> -			reg->status = STATUS_SRC_ADDR_INVALID;
> +			status = STATUS_SRC_ADDR_INVALID;
>  			goto free_buf;
>  		}
>  
> @@ -358,7 +362,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  					   dst_addr, copy_size, &dst_map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map destination address\n");
> -			reg->status = STATUS_DST_ADDR_INVALID;
> +			status = STATUS_DST_ADDR_INVALID;
>  			pci_epc_mem_unmap(epc, epf->func_no, epf->vfunc_no,
>  					  &src_map);
>  			goto free_buf;
> @@ -367,7 +371,7 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  		map_size = min_t(size_t, dst_map.pci_size, src_map.pci_size);
>  
>  		ktime_get_ts64(&start);
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			ret = pci_epf_test_data_transfer(epf_test,
>  					dst_map.phys_addr, src_map.phys_addr,
>  					map_size, 0, DMA_MEM_TO_MEM);
> @@ -391,8 +395,8 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "COPY", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "COPY", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>  
>  unmap:
>  	if (map_size) {
> @@ -405,9 +409,10 @@ static void pci_epf_test_copy(struct pci_epf_test *epf_test,
>  
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_COPY_SUCCESS;
> +		status |= STATUS_COPY_SUCCESS;
>  	else
> -		reg->status |= STATUS_COPY_FAIL;
> +		status |= STATUS_COPY_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>  
>  static void pci_epf_test_read(struct pci_epf_test *epf_test,
> @@ -423,9 +428,14 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	u64 src_addr = reg->src_addr;
> -	size_t src_size = reg->size;
> +	u64 src_addr = le64_to_cpu(reg->src_addr);
> +	size_t orig_size, src_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 checksum = le32_to_cpu(reg->checksum);
> +	u32 status = 0;
> +
> +	orig_size = src_size = le32_to_cpu(reg->size);
>  
>  	src_buf = kzalloc(src_size, GFP_KERNEL);
>  	if (!src_buf) {
> @@ -439,12 +449,12 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  					   src_addr, src_size, &map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map address\n");
> -			reg->status = STATUS_SRC_ADDR_INVALID;
> +			status = STATUS_SRC_ADDR_INVALID;
>  			goto free_buf;
>  		}
>  
>  		map_size = map.pci_size;
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
>  						       DMA_FROM_DEVICE);
>  			if (dma_mapping_error(dma_dev, dst_phys_addr)) {
> @@ -481,11 +491,11 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "READ", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "READ", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>  
> -	crc32 = crc32_le(~0, src_buf, reg->size);
> -	if (crc32 != reg->checksum)
> +	crc32 = crc32_le(~0, src_buf, orig_size);
> +	if (crc32 != checksum)
>  		ret = -EIO;
>  
>  unmap:
> @@ -497,9 +507,10 @@ static void pci_epf_test_read(struct pci_epf_test *epf_test,
>  
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_READ_SUCCESS;
> +		status |= STATUS_READ_SUCCESS;
>  	else
> -		reg->status |= STATUS_READ_FAIL;
> +		status |= STATUS_READ_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>  
>  static void pci_epf_test_write(struct pci_epf_test *epf_test,
> @@ -514,9 +525,13 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  	struct pci_epc *epc = epf->epc;
>  	struct device *dev = &epf->dev;
>  	struct device *dma_dev = epf->epc->dev.parent;
> -	u64 dst_addr = reg->dst_addr;
> -	size_t dst_size = reg->size;
> +	u64 dst_addr = le64_to_cpu(reg->dst_addr);
> +	size_t orig_size, dst_size;
>  	ssize_t map_size = 0;
> +	u32 flags = le32_to_cpu(reg->flags);
> +	u32 status = 0;
> +
> +	orig_size = dst_size = le32_to_cpu(reg->size);
>  
>  	dst_buf = kzalloc(dst_size, GFP_KERNEL);
>  	if (!dst_buf) {
> @@ -524,7 +539,7 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  		goto set_status;
>  	}
>  	get_random_bytes(dst_buf, dst_size);
> -	reg->checksum = crc32_le(~0, dst_buf, dst_size);
> +	reg->checksum = cpu_to_le32(crc32_le(~0, dst_buf, dst_size));
>  	buf = dst_buf;
>  
>  	while (dst_size) {
> @@ -532,12 +547,12 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  					   dst_addr, dst_size, &map);
>  		if (ret) {
>  			dev_err(dev, "Failed to map address\n");
> -			reg->status = STATUS_DST_ADDR_INVALID;
> +			status = STATUS_DST_ADDR_INVALID;
>  			goto free_buf;
>  		}
>  
>  		map_size = map.pci_size;
> -		if (reg->flags & FLAG_USE_DMA) {
> +		if (flags & FLAG_USE_DMA) {
>  			src_phys_addr = dma_map_single(dma_dev, buf, map_size,
>  						       DMA_TO_DEVICE);
>  			if (dma_mapping_error(dma_dev, src_phys_addr)) {
> @@ -576,8 +591,8 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  		map_size = 0;
>  	}
>  
> -	pci_epf_test_print_rate(epf_test, "WRITE", reg->size, &start,
> -				&end, reg->flags & FLAG_USE_DMA);
> +	pci_epf_test_print_rate(epf_test, "WRITE", orig_size, &start, &end,
> +				flags & FLAG_USE_DMA);
>  
>  	/*
>  	 * wait 1ms inorder for the write to complete. Without this delay L3
> @@ -594,9 +609,10 @@ static void pci_epf_test_write(struct pci_epf_test *epf_test,
>  
>  set_status:
>  	if (!ret)
> -		reg->status |= STATUS_WRITE_SUCCESS;
> +		status |= STATUS_WRITE_SUCCESS;
>  	else
> -		reg->status |= STATUS_WRITE_FAIL;
> +		status |= STATUS_WRITE_FAIL;
> +	reg->status = cpu_to_le32(status);
>  }
>  
>  static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> @@ -605,39 +621,42 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
>  	struct pci_epf *epf = epf_test->epf;
>  	struct device *dev = &epf->dev;
>  	struct pci_epc *epc = epf->epc;
> -	u32 status = reg->status | STATUS_IRQ_RAISED;
> +	u32 status = le32_to_cpu(reg->status);
> +	u32 irq_number = le32_to_cpu(reg->irq_number);
> +	u32 irq_type = le32_to_cpu(reg->irq_type);
>  	int count;
>  
>  	/*
>  	 * Set the status before raising the IRQ to ensure that the host sees
>  	 * the updated value when it gets the IRQ.
>  	 */
> -	WRITE_ONCE(reg->status, status);
> +	status |= STATUS_IRQ_RAISED;
> +	WRITE_ONCE(reg->status, cpu_to_le32(status));
>  
> -	switch (reg->irq_type) {
> +	switch (irq_type) {
>  	case IRQ_TYPE_INTX:
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
>  				  PCI_IRQ_INTX, 0);
>  		break;
>  	case IRQ_TYPE_MSI:
>  		count = pci_epc_get_msi(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0) {
> +		if (irq_number > count || count <= 0) {
>  			dev_err(dev, "Invalid MSI IRQ number %d / %d\n",
> -				reg->irq_number, count);
> +				irq_number, count);
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_IRQ_MSI, reg->irq_number);
> +				  PCI_IRQ_MSI, irq_number);
>  		break;
>  	case IRQ_TYPE_MSIX:
>  		count = pci_epc_get_msix(epc, epf->func_no, epf->vfunc_no);
> -		if (reg->irq_number > count || count <= 0) {
> +		if (irq_number > count || count <= 0) {
>  			dev_err(dev, "Invalid MSIX IRQ number %d / %d\n",
> -				reg->irq_number, count);
> +				irq_number, count);
>  			return;
>  		}
>  		pci_epc_raise_irq(epc, epf->func_no, epf->vfunc_no,
> -				  PCI_IRQ_MSIX, reg->irq_number);
> +				  PCI_IRQ_MSIX, irq_number);
>  		break;
>  	default:
>  		dev_err(dev, "Failed to raise IRQ, unknown type\n");
> @@ -654,21 +673,22 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  	struct device *dev = &epf->dev;
>  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
>  	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> +	u32 irq_type = le32_to_cpu(reg->irq_type);
>  
> -	command = READ_ONCE(reg->command);
> +	command = le32_to_cpu(READ_ONCE(reg->command));
>  	if (!command)
>  		goto reset_handler;
>  
>  	WRITE_ONCE(reg->command, 0);
>  	WRITE_ONCE(reg->status, 0);
>  
> -	if ((READ_ONCE(reg->flags) & FLAG_USE_DMA) &&
> +	if ((le32_to_cpu(READ_ONCE(reg->flags)) & FLAG_USE_DMA) &&
>  	    !epf_test->dma_supported) {
>  		dev_err(dev, "Cannot transfer data using DMA\n");
>  		goto reset_handler;
>  	}
>  
> -	if (reg->irq_type > IRQ_TYPE_MSIX) {
> +	if (irq_type > IRQ_TYPE_MSIX) {
>  		dev_err(dev, "Failed to detect IRQ type\n");
>  		goto reset_handler;
>  	}
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

