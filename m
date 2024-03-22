Return-Path: <linux-pci+bounces-4984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 880E6886A1C
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 11:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117DB1F2605A
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 10:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3675922611;
	Fri, 22 Mar 2024 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9JHV+sq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850EE225AF
	for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711102867; cv=none; b=ZKqbiNUP2He+GDd1wt949kdA6CysN6+9rP0RdVxsVD9F45Mof9bSK96FnabcaxUMnsscV5QS/XLE6EpJg2P6HRYEB9Ne4iDYqN+wFAE6xPVxbz/Kq3U4a63X2+aGaSQK8oBElbrpZu2BqNJTLMJD6nYG5phv/RWT/WisiDrlEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711102867; c=relaxed/simple;
	bh=21prII83XG7nX21JZ5i2hLL3aoc/WbDsqZsG3f7H3YQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbLRddwHUfDl7sNgW7Lznaf/Rhe+Oq47CCwaw7dy0FV/jcWXYrrz3X5GsPyvjcC63eB2heTtJAorVVziR+9MLhU126JKr9CeEVA5lfgcaFlMgAvUrvHVCT5rnKKi0vuTpj3L2byYG3Df3IIrDq+xvakCsduhHvfvUEN4UZC+5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X9JHV+sq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dddbe47ac1so19750425ad.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711102865; x=1711707665; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8VigwkgiyOX8VA3STTYLtJoDM4UxXvUlFRRYpSr3EcU=;
        b=X9JHV+sqepQ+SmpaEBQiH7syBd/Vf5N4w2ktvKN0KRDkeADiLv+cqpxS9JsH9h+Ski
         TBG2ZgGRzTNnKwHF/jU+CVzDgDMEerl7hHTx6+jTxilQ8sdYFts2QATiWSVyiXQ/0DXN
         SOApE0JVETQMYwQZhzPaqc/XjTunDhRjJr4aSv3y94j5YqPoxyC6Cw4Qt3F5YgjPgKxW
         aiGpIOR3iLypOuAYyKOr4xOWu0+uPm5B3aGJgSSt7Jl15Hdo2ttXY+zoHTRHNky0sfNN
         MC1NIOh4/6g4MGrkuPb6JP8c3eCc4Xb3HUEGDKzt7NNxD0vM4kFmWeHRS7mJJpBAe706
         WcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711102865; x=1711707665;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VigwkgiyOX8VA3STTYLtJoDM4UxXvUlFRRYpSr3EcU=;
        b=xIGAqork+AZoBv+eErGQYPBlMKpbQwS9eXAjzIMPgTGr/kO6AY0iSxJAKhtTd0ZfrW
         Q1qF8Z9uUZZhiL6c74xYRFjcULELCSNBt4ptW+pRpPjicyR2lU4+v7CI3NlY/VMXnuR3
         93eSc+0o7r2GBn4be7vFbvbAzGoua1/zkUyCTUAQG2fPuQCSmk5N3cU3nj5KEKgutGbg
         YnmoO+aIGuNNbv8xmJx1ZorJAgxf8B6IqrpIICEWvEfB3C17tbvKs85MB1sqezqgxl+z
         mCGCxZm1HkTqwJ4BnIau9lF0nNGg1keM25p8U+1zfm0mdQtGLZpdRrg+TZLfauoaZs21
         tmyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHbAXUmAKm2e9n68PCdDoTqPux2XzXKso7v7uUqT+993IyLyv+W5phDVZ0eal+KwWrhZZ2CdimtQQgBCZrm+5DWNFa6p00ax8S
X-Gm-Message-State: AOJu0YwTzt5XdSUN7Q3tar2UrG03kxYFoV5qfANaVnfFIpn/r4utpHrR
	nJVOcwMDPZKtdB/G1cmwAnuu97PUpt8+j7YQ2HqyqBPlKa+VZCtE1t3yhNVfAw==
X-Google-Smtp-Source: AGHT+IHoxIC3XY3B+lCPo762mAbjcIITajOMGsziFY1l6Dn/z6sZ0Ojaf7wkfN1QI+Bq9QAZtKNPIQ==
X-Received: by 2002:a17:902:b187:b0:1e0:188c:ad4f with SMTP id s7-20020a170902b18700b001e0188cad4fmr1828285plr.26.1711102864495;
        Fri, 22 Mar 2024 03:21:04 -0700 (PDT)
Received: from thinkpad ([2409:40f4:101a:4667:2dab:fb9d:47a0:28fe])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902b10f00b001db2b8b2da7sm1513832plr.122.2024.03.22.03.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:21:03 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:50:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <20240322102025.GA3638@thinkpad>
References: <20240320090106.310955-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320090106.310955-1-cassel@kernel.org>

On Wed, Mar 20, 2024 at 10:01:05AM +0100, Niklas Cassel wrote:
> The current code uses writel()/readl(), which has an implicit memory
> barrier for every single readl()/writel().
> 
> Additionally, reading 4 bytes at a time over the PCI bus is not really
> optimal, considering that this code is running in an ioctl handler.
> 
> Use memcpy_toio()/memcpy_fromio() for BAR tests.
> 
> Before patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 1.56s
> 
> After patch with a 4MB BAR:
> $ time /usr/bin/pcitest -b 1
> BAR1:           OKAY
> real    0m 0.54s
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2:
> -Actually free the allocated memory... (thank you Kuppuswamy)
> 
>  drivers/misc/pci_endpoint_test.c | 68 ++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 705029ad8eb5..1d361589fb61 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,33 +272,75 @@ static const u32 bar_test_pattern[] = {
>  	0xA5A5A5A5,
>  };
>  
> +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> +					enum pci_barno barno, int offset,
> +					void *write_buf, void *read_buf,
> +					int size)
> +{
> +	memset(write_buf, bar_test_pattern[barno], size);
> +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> +
> +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> +
> +	return memcmp(write_buf, read_buf, size);
> +}
> +
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j;
> -	u32 val;
> -	int size;
> +	int j, bar_size, buf_size, iters, remain;
> +	void *write_buf;
> +	void *read_buf;
>  	struct pci_dev *pdev = test->pdev;
> +	bool ret;
>  
>  	if (!test->bar[barno])
>  		return false;
>  
> -	size = pci_resource_len(pdev, barno);
> +	bar_size = pci_resource_len(pdev, barno);
>  
>  	if (barno == test->test_reg_bar)
> -		size = 0x4;
> +		bar_size = 0x4;
>  
> -	for (j = 0; j < size; j += 4)
> -		pci_endpoint_test_bar_writel(test, barno, j,
> -					     bar_test_pattern[barno]);
> +	buf_size = min(SZ_1M, bar_size);
>  
> -	for (j = 0; j < size; j += 4) {
> -		val = pci_endpoint_test_bar_readl(test, barno, j);
> -		if (val != bar_test_pattern[barno])
> -			return false;
> +	write_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!write_buf)
> +		return false;
> +
> +	read_buf = kmalloc(buf_size, GFP_KERNEL);
> +	if (!read_buf) {
> +		ret = false;
> +		goto err;

This frees read_buf also. Please fix that and also rename the labels to:

err_free_write_buf
err_free_read_buf

- Mani

>  	}
>  
> -	return true;
> +	iters = bar_size / buf_size;
> +	for (j = 0; j < iters; j++) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> +						 write_buf, read_buf,
> +						 buf_size)) {
> +			ret = false;
> +			goto err;
> +		}
> +	}
> +
> +	remain = bar_size % buf_size;
> +	if (remain) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> +						 write_buf, read_buf,
> +						 remain)) {
> +			ret = false;
> +			goto err;
> +		}
> +	}
> +
> +	ret = true;
> +
> +err:
> +	kfree(write_buf);
> +	kfree(read_buf);
> +
> +	return ret;
>  }
>  
>  static bool pci_endpoint_test_intx_irq(struct pci_endpoint_test *test)
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

