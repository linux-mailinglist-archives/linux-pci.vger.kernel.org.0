Return-Path: <linux-pci+bounces-24242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D6A6A9ED
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 16:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C79898115C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FF21E5B6D;
	Thu, 20 Mar 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVgq75X2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3D14B08A
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484460; cv=none; b=AlkRi0LXRc0v1hQmGAkdSoZIHYlQPISlN8tpmWoJlfokztiX1KdrwpP1XDhxk6bH2Ubo/0+kWQ1yuJFYtoeaLkUs4mVIxIkyd8+qNApJc/Ov83FxNXblYPDUZc2eqHKTgdt409F5Fkb+j3XENebWPel8fofiPWV5FU2ja+dBW28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484460; c=relaxed/simple;
	bh=+YiBdAVUBzLgSfU9Zu/PYZgcee7y090TXxDmJRoQC3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA9G+F7Oibnos9T122wz3ZB70HlJ9nFiKPAApLNgzW335YnQLXfaFE7xqlw22xDs0G6myMO6jyWQ8Jzx9pCxwGtLnKFPJqjTW18opUp2wPQYWjTyYhnyG25QFzbKHkNBzn4nLWz2C13fSNP39pfpi0qZUoZBfTYBK/ESkGhTbkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HVgq75X2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2241053582dso22881365ad.1
        for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 08:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742484458; x=1743089258; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xrL9P/1puFkHJt5XCanQRpLTSwYlrVdw6HI7j3JjPz8=;
        b=HVgq75X2a/evvdYIxZMdpMHHV0xe0zCm0YqZ+kO1EqTyCf0FYKu6ddGWdnHSaoC3Jj
         nDQepW29ieqU+ewpGkI62RWyy9PXAT99oCnjE2cfPx+dQE+zWMqNcl1iffehJp2Z7woo
         qekwb6NqSdYqQ3PZg5QfCuihaPfpF6weF0vWJsYJGFyUej69/v08Bf2KcB/YikxXUacP
         FwKfVbgalk9eSD/pHM809lGiu5tnLhRUR9I32TXB2rPwsNDCUEWOS+HUxZpIPirTfU4u
         eOrgY5R0IUh5bvB9MRhAulRwEn7d9SkoITIO4YaN1cGNQvWP5vLXi6DkNhJTyygIiIQy
         3FYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484458; x=1743089258;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xrL9P/1puFkHJt5XCanQRpLTSwYlrVdw6HI7j3JjPz8=;
        b=w6UstdW3TGf1iZ/x2uLojLZHZdrHKyR+J1ZrNQj3OQCrvL1Q3WGtoD/7xocWxMwVYu
         SluQEM27k6zxa43teBfvbDn6/Bsap2AZPQ89ajqqBoQgk/iJXF4VXAA4YKViKT6XyZ1U
         Z1I/Oa9o79Y1o2HGfxbxrXey0iNtGSLIhmQR8ROi6TQd1Rw/WjxMOmsXuPKdcIs4zVMF
         KxFBIq9XLu2MtXBTl77M1xMLH0Jne4iu8flJseFS0RZS63p7vhgvyd83q7xDYFTCKP4P
         jcCDBFdZeiSq2rHguIyQQUdowqRTZlvvRlv2H8S7iWO/6z98tdpCjlQFaJMb4xCO/a0M
         oCag==
X-Forwarded-Encrypted: i=1; AJvYcCWEl5u+WYe85O/dUXqEDWHeh8lrVjZiuF0izCUHprlDyakTJ72RfQ9IHmq/ktDj5ocxs1MGuJ7TCnc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4tM5+HYc+Vg1IEIwxkEGtfFl28KCWK62LpeJ7Q9yUJntw+VCK
	I7asJpUBZBDODRmV3zQueuFSXYqlY4JNRLbTwLSWi2quRQ3+5hlW5Jq+tImR3w==
X-Gm-Gg: ASbGncv5PAHndQKlltBStm9IpLgZmWmONofdTMbHDJ1f++rUmNQaZp0s75qGu0+Bwzr
	5M99iTfgjzirI71mro0TxyBgH97cxA+PvmVZxNenK59CGxo9u7JyoKpkZ4sxL76v6tfWOoEWmrX
	BV5G2oI381hZgO6slBF43ifPF20gN0lxc1VuPTHdd8NwLWSyVlWbQwcfwglv5Nkr9/nZrHWuVtP
	X8juuLK+9CTI47MCtvRjBjFQlfhUHm+DDKVfZXE6g1GYCSRCfB175r1HNMem0xlvml7NNlMQcI7
	8XOyYNhg9TOTqUWVl23qko7uGAI5ng3klOaYSx2chTK2UcZGSHGjgUDoGKlE
X-Google-Smtp-Source: AGHT+IFvs6cVHqAtZVkE9DRS+gJcji1u2+sYhS08wJb0ez8IWjnLqtZ2hcYglB6SboEehpT3B543pg==
X-Received: by 2002:a17:903:2349:b0:21f:859a:9eab with SMTP id d9443c01a7336-22649a67fa4mr86641805ad.37.1742484457492;
        Thu, 20 Mar 2025 08:27:37 -0700 (PDT)
Received: from thinkpad ([2409:40f4:3109:f8b2:e8d0:5797:6511:46aa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1103sm13968737b3a.167.2025.03.20.08.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:27:36 -0700 (PDT)
Date: Thu, 20 Mar 2025 20:57:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 3/4] misc: pci_endpoint_test: Let
 PCITEST_{READ,WRITE,COPY} set IRQ type automatically
Message-ID: <20250320152732.l346sbaioubb5qut@thinkpad>
References: <20250318103330.1840678-6-cassel@kernel.org>
 <20250318103330.1840678-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250318103330.1840678-9-cassel@kernel.org>

On Tue, Mar 18, 2025 at 11:33:34AM +0100, Niklas Cassel wrote:
> The test cases for read/write/copy currently do:
> 1) ioctl(PCITEST_SET_IRQTYPE, MSI)
> 2) ioctl(PCITEST_{READ,WRITE,COPY})
> 
> This design is quite bad for a few reasons:
> -It assumes that all PCI EPCs support MSI.
> -One ioctl should be sufficient for these test cases.
> 
> Modify the PCITEST_{READ,WRITE,COPY} ioctls to set IRQ type automatically,
> overwriting the currently configured IRQ type. It there are no IRQ types
> supported in the CAPS register, fall back to MSI IRQs. This way the
> implementation is no worse than before this commit.
> 
> Any test case that requires a specific IRQ type, e.g. MSIX_TEST, will do
> an explicit PCITEST_SET_IRQTYPE ioctl at the start of the test case, thus
> it is safe to always overwrite the configured IRQ type.
> 

I don't quite understand this sentence. What if users wants to use a specific
IRQ type like MSI-X if the platform supports both MSI/MSI-X? That's why I wanted
to honor 'test->irq_type' if already set before READ,WRITE,COPY testcases.

Everything else looks good to me.

- Mani

> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 126 +++++++++++++++++--------------
>  1 file changed, 68 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3c04121d24733..cfaeeea7642ac 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -464,6 +464,62 @@ static int pci_endpoint_test_validate_xfer_params(struct device *dev,
>  	return 0;
>  }
>  
> +static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
> +{
> +	pci_endpoint_test_release_irq(test);
> +	pci_endpoint_test_free_irq_vectors(test);
> +
> +	return 0;
> +}
> +
> +static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> +				      int req_irq_type)
> +{
> +	struct pci_dev *pdev = test->pdev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
> +	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
> +		dev_err(dev, "Invalid IRQ type option\n");
> +		return -EINVAL;
> +	}
> +
> +	if (test->irq_type == req_irq_type)
> +		return 0;
> +
> +	pci_endpoint_test_release_irq(test);
> +	pci_endpoint_test_free_irq_vectors(test);
> +
> +	ret = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_endpoint_test_request_irq(test);
> +	if (ret) {
> +		pci_endpoint_test_free_irq_vectors(test);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pci_endpoint_test_set_auto_irq(struct pci_endpoint_test *test,
> +					  int *irq_type)
> +{
> +	if (test->ep_caps & CAP_MSI)
> +		*irq_type = PCITEST_IRQ_TYPE_MSI;
> +	else if (test->ep_caps & CAP_MSIX)
> +		*irq_type = PCITEST_IRQ_TYPE_MSIX;
> +	else if (test->ep_caps & CAP_INTX)
> +		*irq_type = PCITEST_IRQ_TYPE_INTX;
> +	else
> +		/* fallback to MSI if no caps defined */
> +		*irq_type = PCITEST_IRQ_TYPE_MSI;
> +
> +	return pci_endpoint_test_set_irq(test, *irq_type);
> +}
> +
>  static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  				   unsigned long arg)
>  {
> @@ -483,7 +539,7 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  	dma_addr_t orig_dst_phys_addr;
>  	size_t offset;
>  	size_t alignment = test->alignment;
> -	int irq_type = test->irq_type;
> +	int irq_type;
>  	u32 src_crc32;
>  	u32 dst_crc32;
>  	int ret;
> @@ -504,11 +560,9 @@ static int pci_endpoint_test_copy(struct pci_endpoint_test *test,
>  	if (use_dma)
>  		flags |= FLAG_USE_DMA;
>  
> -	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
> -	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		return -EINVAL;
> -	}
> +	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
> +	if (ret)
> +		return ret;
>  
>  	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
>  	if (!orig_src_addr) {
> @@ -616,7 +670,7 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
>  	dma_addr_t orig_phys_addr;
>  	size_t offset;
>  	size_t alignment = test->alignment;
> -	int irq_type = test->irq_type;
> +	int irq_type;
>  	size_t size;
>  	u32 crc32;
>  	int ret;
> @@ -637,11 +691,9 @@ static int pci_endpoint_test_write(struct pci_endpoint_test *test,
>  	if (use_dma)
>  		flags |= FLAG_USE_DMA;
>  
> -	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
> -	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		return -EINVAL;
> -	}
> +	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
> +	if (ret)
> +		return ret;
>  
>  	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
>  	if (!orig_addr) {
> @@ -714,7 +766,7 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
>  	dma_addr_t orig_phys_addr;
>  	size_t offset;
>  	size_t alignment = test->alignment;
> -	int irq_type = test->irq_type;
> +	int irq_type;
>  	u32 crc32;
>  	int ret;
>  
> @@ -734,11 +786,9 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
>  	if (use_dma)
>  		flags |= FLAG_USE_DMA;
>  
> -	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
> -	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		return -EINVAL;
> -	}
> +	ret = pci_endpoint_test_set_auto_irq(test, &irq_type);
> +	if (ret)
> +		return ret;
>  
>  	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
>  	if (!orig_addr) {
> @@ -790,46 +840,6 @@ static int pci_endpoint_test_read(struct pci_endpoint_test *test,
>  	return ret;
>  }
>  
> -static int pci_endpoint_test_clear_irq(struct pci_endpoint_test *test)
> -{
> -	pci_endpoint_test_release_irq(test);
> -	pci_endpoint_test_free_irq_vectors(test);
> -
> -	return 0;
> -}
> -
> -static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
> -				      int req_irq_type)
> -{
> -	struct pci_dev *pdev = test->pdev;
> -	struct device *dev = &pdev->dev;
> -	int ret;
> -
> -	if (req_irq_type < PCITEST_IRQ_TYPE_INTX ||
> -	    req_irq_type > PCITEST_IRQ_TYPE_MSIX) {
> -		dev_err(dev, "Invalid IRQ type option\n");
> -		return -EINVAL;
> -	}
> -
> -	if (test->irq_type == req_irq_type)
> -		return 0;
> -
> -	pci_endpoint_test_release_irq(test);
> -	pci_endpoint_test_free_irq_vectors(test);
> -
> -	ret = pci_endpoint_test_alloc_irq_vectors(test, req_irq_type);
> -	if (ret)
> -		return ret;
> -
> -	ret = pci_endpoint_test_request_irq(test);
> -	if (ret) {
> -		pci_endpoint_test_free_irq_vectors(test);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
>  				    unsigned long arg)
>  {
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

