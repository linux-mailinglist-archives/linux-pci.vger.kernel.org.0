Return-Path: <linux-pci+bounces-21512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF392A364E7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E296F3A7B92
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8D826869A;
	Fri, 14 Feb 2025 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aknN/cZd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30520267AEB
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739555074; cv=none; b=kT9VwGPaaGDor5xAAkSG/JHgqlopo2CjhDdqgoAbXoYymP/KwWess2/LR7WCY5kE93AmoMsw3nTc21ViSS0/04Wt7yTq/anh/fpTFsMogYz066rSMJ6rdHAsdxVTup3QgQiJVefbk8rKxNN2ql3rO4O4woYts5ADtrpoGvX01/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739555074; c=relaxed/simple;
	bh=yB/N/dmodWxGpg2pNJzfl2ggwDQTXm2uu8GMzqjQxVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYiJTztF7d6pwNWjPM3vEt7Od2csLBUWJRgd1mL761MOaUU3lLEF8p1J4h580HGFeMwSMKj0q1QVGJTpS0QDjcEYli0s5ujNgJ2PffYxmYJA4BBe8LLtyRhYCBCxAveXPrP/snM8sw8gJA+0gInjYcnk5NCet1hIV1NAGj665gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aknN/cZd; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220d39a5627so35187985ad.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739555072; x=1740159872; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rMF2FQJwD4AiHWSw8XkooqqJGsGsXZnRmnTTxBxizF4=;
        b=aknN/cZdCOlaw0lwj+7BUUxITG4LWMxHfb7DOO5onPXlMpsIh6lGzFRxv6BdCRuzPI
         6yCDgXxTKRvZ1Ol5hwZobvrlc1qetZpCZVSQwqcxKnEPPeqYFyEQDV9D6efpOtJoSBOw
         k7yDw9z70qwKAaXfdh3UHg7k6egrJM50F3wbRYZnOhSv9lQtUy8656db3yWEBXeDzVby
         CY/wScXpKOFOa03HDDimq/tTly5CVsrnjBQ4S+6OZIATQh/u0p7Y5U+2m+cp4nwsaBmo
         4/h2bcLvYhMCojlaGCY1UD1M3MxNNGKYO24LLMkNwAQ2XNEI2jAgLuXwZ0hYlVFZ7Fd2
         8gnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739555072; x=1740159872;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMF2FQJwD4AiHWSw8XkooqqJGsGsXZnRmnTTxBxizF4=;
        b=HnQkyQ+BFTPs7Wb2pBs/D7pu1HyL+cNKp4geSHpdV6chRFLZ+yoCO33zrgubRF+yuu
         2/Q5HJIpU0TDk2hBWsBQvRqrGkLzGaqMP4XOHt+DrUSw1AbXxDuh4CaqKu2ettI25qYB
         TmUwJDV+uEfcpehkKFIlJVEFofkHeQ1E6vzkTwCjvNOmOW0Eg8K3tOQdVWP8mdO5jw1s
         JjMY7AmWrKBmiVp8CxldC6cPJkswxIU6vF1IEyrUThS4n2/R1GujmsA/ykrBZUQcKTBW
         6cuDKkg+I1+UQZR+8aa7g5WTu235KaDbhT4IMap3Why2wEdgPL9YNODF9kGTJHtyHAAm
         SDcA==
X-Forwarded-Encrypted: i=1; AJvYcCUQD/OY97UkFbpltSwPSGoh8UDE6JUSW60Avw6XnwhLoyQCle8HA6lMwbz77cSE/e2VdJnmj9j2d8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjAO11OX52bcfXILaAQM/1sA6lOJ7JQEYuWMM29VK7TSkn2IdH
	85DJanWlswtj1J38eFdd+PDwpb5bG+9MH/4GbYVo4j0/9+Lo5eme8t5Jp018Ag==
X-Gm-Gg: ASbGnctoUDNSgZRZtCO3ttxRODuTLBpuv2fUIS5VlM2V70PFVmZpf+fOtrj+OC6/8XZ
	dpF9LaJKmouidR7HT4e1TJxPej1gWSRv6vo5AXZJzcwvZyaUZvLwYzUowziI3wQAnRjk7okaYMG
	d4AY7mJe40Z9kL8tMgmVcQlD6Q+IBaoyaXfS7gl0svgoQOXjg0XoOYsSv1G01O72Z8c79Ip2ra5
	+Xlf5Y+NrSSL8/WLkkCrrUpEn+fFGPDjCndC7OgidDcBDDQTzp9mJWLpkAJvXKfqO4lAn9b8PeT
	eRFQv4SlP4epRxf+ksu0sCpuXag=
X-Google-Smtp-Source: AGHT+IFPPV2L6UfIjBOJCgYVAwQL+H1yJLajnoN7rIqvq0UHGG8ilpnrBf/ind5JB91U3cBDb9FvKA==
X-Received: by 2002:a17:902:e848:b0:216:31aa:12eb with SMTP id d9443c01a7336-22104064cd6mr1615855ad.31.1739555072461;
        Fri, 14 Feb 2025 09:44:32 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d559614dsm31649175ad.256.2025.02.14.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:44:32 -0800 (PST)
Date: Fri, 14 Feb 2025 23:14:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a
 distinct error code
Message-ID: <20250214174428.bosbckzfvouh76o4@thinkpad>
References: <20250123120147.3603409-3-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123120147.3603409-3-cassel@kernel.org>

On Thu, Jan 23, 2025 at 01:01:48PM +0100, Niklas Cassel wrote:
> The current code returns -ENOMEM if test->bar[barno] is NULL.
> 
> There can be two reasons why test->bar[barno] is NULL:
> 1) The pci_ioremap_bar() call in pci_endpoint_test_probe() failed.
> 2) The BAR was skipped, because it is disabled by the endpoint.
> 
> Many PCI endpoint controller drivers will disable all BARs in their
> init function. A disabled BAR will have a size of 0.
> 
> A PCI endpoint function driver will be able to enable any BAR that
> is not marked as BAR_RESERVED (which means that the BAR should not
> be touched by the EPF driver).
> 
> Thus, perform check if the size is 0, before checking if
> test->bar[barno] is NULL, such that we can return different errors.
> 
> This will allow the selftests to return SKIP instead of FAIL for
> disabled BARs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Applied to pci/endpoint!

- Mani

> ---
> Hello PCI maintainers.
> This patch might give a trivial conflict with:
> https://lore.kernel.org/linux-pci/20250123095906.3578241-2-cassel@kernel.org/T/#u
> because the context lines (lines that haven't been changed)
> might be different. If there is a conflict, simply look at
> this patch by itself, and resolution should be trivial.
> 
>  drivers/misc/pci_endpoint_test.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index d5ac71a49386..b95980b29eb9 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -292,11 +292,13 @@ static int pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
>  
> +	bar_size = pci_resource_len(pdev, barno);
> +	if (!bar_size)
> +		return -ENODATA;
> +
>  	if (!test->bar[barno])
>  		return -ENOMEM;
>  
> -	bar_size = pci_resource_len(pdev, barno);
> -
>  	if (barno == test->test_reg_bar)
>  		bar_size = 0x4;
>  
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

