Return-Path: <linux-pci+bounces-19910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDBCA1294F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6623F18899E3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6902B1A00EC;
	Wed, 15 Jan 2025 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8gHveMi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C54196D9D
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960331; cv=none; b=h13lZMkY2nA5vNiorwSiNsOKqMeCMczmU2eKgt0ekuQWZZFrwFs1Q3RhNzLdJNqKcxI78c+SwNU+JNyeaj0t9nxIUF43OOugFOVVIYCd0ZOH68Pd1m3IMmHhigH9FG1MGLd6AXr7feYSkVFUV/guZI49iB+MCMfZM42h4Uam2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960331; c=relaxed/simple;
	bh=yxrAxqRd8UvREJetjceJE5L6LXlFDICJeDkl1GtrOXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frvVClguUlGzDdiL+1NNMf8TSZ9XHkZKyui+Gw+WK3MjIq2Sc7LS9NU1EjrBD1K5xiWOcwvLTlOXX+/YB8nWiscX1+pfdLIZM+c8ZBXnG9SPgWQxGl+k4sk2fnhIXafXGH6bVacCr9Gz5X88ipOe8rhQTSf1j0wUGkb/3vjT+ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8gHveMi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216426b0865so125660485ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736960329; x=1737565129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JX5dAU6UqGYCV3f/R8cp2ijzYrxD5GR/sC/arTSxTiE=;
        b=O8gHveMiy3Lwqrl0ySP/j2Cg6oMEYE3qv3kV8ZF553h9JXsC40DJrPH2tAtPLSprCn
         wvuk6qSQx2jpO+C4CQ9iP5zJPIo35Pn5UCFyXBEMO8zAkWGFvKkVSwYasPgHEfIpgWAp
         aKGtw1fLyHJrCeY5vAUYGvK1M7fErSvQ7gV8PoV4t6BjCR51YztlmYAIkL53kVNinZHj
         JMWNFfoIkszg+pphAsf64XJSQdBVpS1apeWyRjFNNIDA8BCv8JTowzdNU5HUlGoq0zyJ
         24JgKmgjrgpWUyzfQRPp4iNoWtv1Qodoe0FHBAEcjvIWKxqrkBmLCqZk/RQB48wEI0Op
         1l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960329; x=1737565129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JX5dAU6UqGYCV3f/R8cp2ijzYrxD5GR/sC/arTSxTiE=;
        b=M/qx7S/Itmp2swpl96mkzSmFOg9kqBi4Ahr5JyGodji3sUKw6v7iMNEt+3HjdCP8EN
         H8BX87PtLKNPDn3OsFp92NZHAhlKFhT3JUURvIhWtsEd9jKWgt27xjZSk4dSrjC6dL9E
         x9BjKcELmCov2pjaKNgmQ0mjDhb93kIzIcihaiB5Tb9KcnUZs9pEx3xCWTj+KURxkClP
         6TMydog97+MxPWA2AFZ26s4lUOxKgJZKSQY1kGPQf4r4MYb9QtjMw8dBJsHoTBCLG0L+
         OgWUojf8IpJy8fEVNOEU3d5EL1OSNnqEJK8cCANREwDoVzijTXvho12oYnuVC48likYe
         VvzA==
X-Forwarded-Encrypted: i=1; AJvYcCUtEee+KNWyiFty+f2ZbGJAJFiRg7SRSdAY1iLg1cgwrssnw+2up56RKEYn02hLA4lfDRJ5IKW1CVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTAJy/xi4a5KD5V1crl4VXXENMI5fl6DU9qnAsEXzRQOGyNrKE
	207mzLPwntgWlX6luj3HeqUUFtD07hrJ1zH81mR+bc70VzUf7B0uS83jVP5+/w==
X-Gm-Gg: ASbGncuhJVJQiXtLojrvQSPqAfAZkkJYUFoJ7lPP8jWocG+RINSKohCALrEJeT6EfUr
	uXKpKXMpB4xgvTYRFVoh3S8qqm1ihyzV/Z40uH87o0o2gCgcMo++iUhNkpyrwOdbZ7wGHyBC1dd
	pNE0d/TO2jqxkekhklCl5ed83+p8pgi0xDK8uLJ4tzHGGunil7qZ9rtcn1nH8hQG62ufOtql8j7
	6VbP0L0RpVr7TTS0cXc99X1k/QH6GXW6LRLehaX7PlG3qbOG4V0tlX3k153LWm3RL8=
X-Google-Smtp-Source: AGHT+IFN9a11qzInPycSnxIEWAIFaC5uazBZeosmZzRcUVsS3UQEeV2IUtu1WyUK6I20zDaD6mAU0g==
X-Received: by 2002:a05:6a00:2e97:b0:71e:2a0:b0b8 with SMTP id d2e1a72fcca58-72d21f17b37mr40379617b3a.1.1736960328957;
        Wed, 15 Jan 2025 08:58:48 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658bb4sm9366258b3a.86.2025.01.15.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:58:46 -0800 (PST)
Date: Wed, 15 Jan 2025 22:28:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <20250115165842.p7vo24zwjvej2tbc@thinkpad>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109094556.1724663-3-18255117159@163.com>

On Thu, Jan 09, 2025 at 05:45:56PM +0800, Hans Zhang wrote:
> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> 
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v10:
> https://lore.kernel.org/linux-pci/20250108080951.1700230-3-18255117159@163.com/
> 
> - Replace do_div with the div_u64 API.
> 
> Changes since v8-v9:
> https://lore.kernel.org/linux-pci/20250104151652.1652181-1-18255117159@163.com/
> 
> - Split the patch.
> 
> Changes since v4-v7:
> https://lore.kernel.org/linux-pci/20250102120222.1403906-1-18255117159@163.com/
> 
> - Fix 32-bit OS warnings and errors.
> - Fix undefined reference to `__udivmoddi4`
> 
> Changes since v3:
> https://lore.kernel.org/linux-pci/20241221141009.27317-1-18255117159@163.com/
> 
> - The patch subject were modified.
> 
> Changes since v2:
> https://lore.kernel.org/linux-pci/20241220075253.16791-1-18255117159@163.com/
> 
> - Fix "changes" part goes below the --- line
> - The patch commit message were modified.
> 
> Changes since v1:
> https://lore.kernel.org/linux-pci/20241217121220.19676-1-18255117159@163.com/
> 
> - The patch subject and commit message were modified.
> ---
>  drivers/misc/pci_endpoint_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index f78c7540c52c..0f6291801078 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters;
> +	int j, buf_size, iters;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	resource_size_t bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	if (!read_buf)
>  		return false;
>  
> -	iters = bar_size / buf_size;
> +	iters = div_u64(bar_size, buf_size);

This change is worth mentioning in the commit message. With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

