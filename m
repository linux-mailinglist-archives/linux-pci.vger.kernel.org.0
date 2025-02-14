Return-Path: <linux-pci+bounces-21514-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C16A364F7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBB3A5FB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7D8267711;
	Fri, 14 Feb 2025 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KdNavlDg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338138635A
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555309; cv=none; b=LGCsZb+BYU62B6lXxDMOp63LzVReauGon5R86RsgBwY9ulZdLBeRpLoMU1X5dJ1qtgBjHA+VuZfEQCxIlx36gMJRSP9ey3IIkJ1WIZiWcnPSLWP6P+FwP/bkI/kJFpY7Asm+3DuwR1Toakar1PUi2TG3YdshI0Jbw2BMxpCDhUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555309; c=relaxed/simple;
	bh=t0Zv15PTV2R92PPnXEnZcjFKughFvTjZSCpEJAXeuwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQ2CRq4aM8XG6WROlQw54QztMW8c404qql938anSZfhaJR9iDPcQDlqkiK4y54X2BIiQlGlvrOVPipiqE75db14dcqK0aUvm+zqGTR2Jm8d7kxeEDnM9jwPzd0TZPuDhwO6luFJ4BrFMt1dPdIno8+OfkcH9DXgh4uA6T3AHjSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KdNavlDg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f48ebaadfso49844085ad.2
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739555307; x=1740160107; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wBQYf7HCQyW8u7awavRyoh/ZvBY5lLVNGTWVm/OpAyg=;
        b=KdNavlDgC0D2KczDQRw+vnHM6Ucph6a4Hcr2NcMKjihf6Schwj1DPZdOGJSI8gD+iZ
         nUr017MxaZ1/AGW5IPDFvvOODPaGvapCSZsXkC1IajFIplpFPowAx/JgqTme3UFvxra9
         ZoKsS6bOXyUHcG/zzbCFqtOMr6CwnZz9Hl8H1ALU1jipupw64EK+8MKO/oIZgyGO0Ccb
         JIPa9I8osRtsM7uwwFg5F9e7BkCh4c2LTuF0tPA6ivIXqNK7RI1tVA69dUs18PGz6XYD
         aXkxS/u6W3o8rDXS9/XsA5RshCVZKHoDg1CvSz7dCiBL5/VIqb/gLJ747ohfu0J73h8M
         UaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555307; x=1740160107;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBQYf7HCQyW8u7awavRyoh/ZvBY5lLVNGTWVm/OpAyg=;
        b=TBf0j4dPW8EkkhIAmLCKmHrGlFZMuKxjDhuLvChym3LDOSLqoaO6LuI7Tfr4hd+vIu
         HVpzNVkIs3XQX8nia6CRTFH2bjWXumHZfFn54/iyO/wg8NraS8NkSJdo5sjQTA8W/zAP
         aVcHeSTN3PXIZ7i2SdN7GHpTLGpCqE5QhmHQIFPgqQkFH5fuSpWWcPL2ytBN2t58Dwsi
         +PDgCGzAqnVYcCXdpyTLkWt6TcI7ebPc4YUkJOSBob0zRX0cNRBa0qBHJ8nQVyi+cr9P
         7vcVziB7sBjT49eUlcqYfVY3MpBvMdY0x1kpT3tsJwvcMw/DFuthVKYfrVnja9NQ38k2
         nCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvbT96Jf3Ab6WEJQjS59IMNko0+nlRoT2CBvvI9Gyk4qvBrwDayE1ll92DM53arv1zExrJqpgg5aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMYvDnk+DGfB9ZxC7RC5T5RszWmtUEps5VKCLZYpQqmcv1Lqv
	JfogghygW4H2pCIYV8N8RCc5b4nULoRhI2iEX+B42L5QvSY3Y+GhKnk96noMACzqYhg29uOX5IM
	=
X-Gm-Gg: ASbGncu0IrC4V0Y2GOqqzHUwwZthwQnyrE44of+QaObo2br6xHzJ66CaYOiw/1dLAS3
	HfBvVvAjk+MZ+Q9xcVRwEQ1xpUrgFge66c+jlb4HEv2EzWpZl0kh7bTBu66Zv0/NYTk1FfnakJG
	zf4KK4Dxe+shQzdz3EXfF3nBO93A/Du1K8PN6/DRHQzUXyRrDWnOFjjds6/aBDI0UYzadBaIHMC
	Q0hqJVe+Praov/dG1mv93XT8WHSTIKQk6ttZmFiGb6QR5P8FMmZWIKoioV8UhaCqPBHTkpsvCl0
	Gp4OhPpgOjKY5NmvxIqCvIR7H2c=
X-Google-Smtp-Source: AGHT+IGeKyRIqI8gyFlFLtdUqVGOKXt46IymsPmZYtHD6X7ZD4+FpnkBDafL/1lhDxbcLXcxiqa1Gw==
X-Received: by 2002:a17:903:41c3:b0:220:c113:714e with SMTP id d9443c01a7336-2210405c6c1mr2088665ad.21.1739555307576;
        Fri, 14 Feb 2025 09:48:27 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d051sm31454175ad.108.2025.02.14.09.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:48:27 -0800 (PST)
Date: Fri, 14 Feb 2025 23:18:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <20250214174822.l6gzzhupz43df4p5@thinkpad>
References: <20250124093300.3629624-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250124093300.3629624-2-cassel@kernel.org>

On Fri, Jan 24, 2025 at 10:33:01AM +0100, Niklas Cassel wrote:
> Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> is e.g. 8 GB.
> 
> The return value of the pci_resource_len() macro can be larger than that
> of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> the bar_size of the integer type will overflow.
> 
> Change bar_size from integer to resource_size_t to prevent integer
> overflow for large BAR sizes with 32-bit compilers.
> 
> In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> have needed to use a function like div_u64() or similar. Instead, change
> the code to use addition instead of division. This avoids the need for
> div_u64() or similar, while also simplifying the code.
> 
> Co-developed-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Added fixes tag and applied to pci/endpoint!

- Mani

> ---
> Changes since v1:
> -Add reason for why division was changed to addition in commit log.
> 
>  drivers/misc/pci_endpoint_test.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..8e48a15100f1 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -272,9 +272,9 @@ static const u32 bar_test_pattern[] = {
>  };
>  
>  static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> -					enum pci_barno barno, int offset,
> -					void *write_buf, void *read_buf,
> -					int size)
> +					enum pci_barno barno,
> +					resource_size_t offset, void *write_buf,
> +					void *read_buf, int size)
>  {
>  	memset(write_buf, bar_test_pattern[barno], size);
>  	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> @@ -287,10 +287,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters;
> +	resource_size_t bar_size, offset = 0;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int buf_size;
>  
>  	if (!test->bar[barno])
>  		return -ENOMEM;
> @@ -314,11 +315,12 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return -ENOMEM;
>  
> -	iters = bar_size / buf_size;
> -	for (j = 0; j < iters; j++)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
> -						 write_buf, read_buf, buf_size))
> +	while (offset < bar_size) {
> +		if (pci_endpoint_test_bar_memcmp(test, barno, offset, write_buf,
> +						 read_buf, buf_size))
>  			return -EIO;
> +		offset += buf_size;
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.48.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

