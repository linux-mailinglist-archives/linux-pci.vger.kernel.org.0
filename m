Return-Path: <linux-pci+bounces-19096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DEE9FE988
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF1818805C1
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 17:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1B1ACDE7;
	Mon, 30 Dec 2024 17:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ni/X16Oz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1E19DFAB
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581186; cv=none; b=C+BUe5TOcmqGMXAcif1W0SDHrJ1g3WayxoEXwEDglf3Rd7opKXw64pUPHrpa9OJFklDgldRh8bIw/k5iutljKmipYBh0aOZgXtigyEKy+kAoW8PlaWNCRqfwFMGi2mdeldw9dZlpSzWbBPegZmjjHBCcBTI8ZM9AxO4005ucpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581186; c=relaxed/simple;
	bh=OinC3bhugjWs81HQ/VUVqwQh9XcC/WrGz1Uup6D/m4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3Fj9XpToi1zX0qBu99fNdcK5ZusK1JfVdwXPxN2eOVLnJvEP2ZrxCSQuRDHIB5DXIIPBPsSlYTlqeADbkeAWwlxuRhS2CVKsm8VvPcgvnjBNkxSzwSEFfyw6gqvUugVHqnY6N743hw1Gr9HRF8zc9t6KWrSGIADWfnrt2YoxAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ni/X16Oz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21636268e43so25649565ad.2
        for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 09:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735581184; x=1736185984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o3xI5DjH4HAYdB6G5OXMtCQ/yI27laowdH1Ku4WAUuU=;
        b=ni/X16OzrW3z/sHrJU46Lb3L2Sct2albf0LX20NodAVZY9VvHiUPNZnXRSf4G20xh8
         ZRAe7A1bu7ZeaOgcCM+IkardlB7ZR7xyqi/CkHyGKSwQ7xNZi9MDLZqpt6ouxEZ4ipN8
         1QQ/wb2m8+gEoIGME1T/n0BJPFufURAYUMvZhJszAQnNATGPpxXRwDkFPT/WQCoStXmM
         F7/jj4W3fGwA+e50DsRczqfAPBtHYbFTJu7IzSLsuU9rr5xTcYt4b0i9sVH9S7mK46f/
         KPCtuTwZ3xCT+br7fnnZBbYKsCZ38/gvW9Q5qmCbUdfEDKX/cxsfXAjk2XC9W9JwZyhT
         yLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735581184; x=1736185984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3xI5DjH4HAYdB6G5OXMtCQ/yI27laowdH1Ku4WAUuU=;
        b=O/3aNjDCHTymZmFYUr4M0gtgrbb5F8Z2v1pgfFqFGyAw68rGpXHWD0AMzLUdDlN/30
         YBnjaadNIqTRk52MweazdJiJybH7bR2cGNKA5bWeVzkAddRp3oibFqkwT1wp213JUfhQ
         C5FuK/7/sr43Ada0Wt6veACPyUIzqqCZPTDAVZsuCzD2FcbwtjRhxzinZhDrpSgfMycE
         dCujRBAXQ649NxqaBaqSLxXbysJ5DCUWYFBJXDdVx9ScnIJyxDk/BufBR3Nld6BOg1+P
         rKu5C357nIaFYdt65q/wTNNF+zcy2vb3fuWFdC9DPp45GOj4khD0T3QrXHua+0JKgUT1
         Qvtg==
X-Forwarded-Encrypted: i=1; AJvYcCViupkwk6A7Y7Y0OvuYwQVSURuTKqj9nlD9Wg0FFheCoVjWaCsy0apbCIaRF3RWGKa2AZA59sqzp8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGsIQCSifNdY71p/FHhYzgLCCMjN2IwIZm7/TPe1RE1Qb9c2p
	6NlsMuQwHLe0ozE7x3i8gLlsPSQgH4y67hBzLU4N8d6ZD/nNq7C/9ozok4YFxg==
X-Gm-Gg: ASbGncsbVjyzA4AEjC/yzrKPZ3Kf2BdaTKHS7ktynYxL/3Q7UnocXYlqg2W/G/dhFoz
	qzBSUH7+H3nbRzLeGyJwYQkcEdeGt1/FIdRDTqfCIwdMAq2F8YFkk27LEvaUeDYxTuoM55EmWwE
	6tidcgysiUU0laxW4sWm4kvsb52GVya6jVokKZUQysFPXxocJyzUddLGjGO9UYe75yaF/LdHNeN
	QYblXIpUJsbnkXDNdEroFf29UnUWQI/YYjQzTq0Eki3RLOsAdbIf+iKbtYAvt4G7Cgy
X-Google-Smtp-Source: AGHT+IHeD2wPRjHlfgF7pPwJpRkMuKUiK6/XjQte9rKjKeYvH/JFjbDy3YIRqFOuyyy1Rnljy5snSA==
X-Received: by 2002:a17:902:ce88:b0:215:620f:8de4 with SMTP id d9443c01a7336-219e6e8baffmr468933345ad.2.1735581184321;
        Mon, 30 Dec 2024 09:53:04 -0800 (PST)
Received: from thinkpad ([120.60.139.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97181fsm180454425ad.108.2024.12.30.09.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 09:53:03 -0800 (PST)
Date: Mon, 30 Dec 2024 23:22:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v3] misc: pci_endpoint_test: Fix return resource_size_t from
 pci_resource_len
Message-ID: <20241230175249.lx32nb2adsm54qh3@thinkpad>
References: <20241221141009.27317-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221141009.27317-1-18255117159@163.com>

On Sat, Dec 21, 2024 at 10:10:09PM +0800, Hans Zhang wrote:

Subject should be improved:

misc: pci_endpoint_test: Fix overflow of bar_size

> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED".
> 
> The return value of the `pci_resource_len` interface is not an integer.
> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
> overflow.
> Change the data type of bar_size from integer to resource_size_t, to fix
> the above issue.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> 
> ---
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
>  drivers/misc/pci_endpoint_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..414c4e55fb0a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> +	int j, buf_size, iters, remain;
> +	resource_size_t bar_size;
>  
>  	if (!test->bar[barno])
>  		return false;
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

