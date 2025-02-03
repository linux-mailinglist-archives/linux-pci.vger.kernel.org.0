Return-Path: <linux-pci+bounces-20668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF583A2607F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 17:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C59D57A1BB9
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2025 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DFE209F59;
	Mon,  3 Feb 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f5ptihPc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AE20B7E0
	for <linux-pci@vger.kernel.org>; Mon,  3 Feb 2025 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738601219; cv=none; b=e9bIknjNXrIY/PPeYkKtRyjvvZCy1clNFdg4sfd8sdo+ZScDhIMNTVt5kTQ2FGXoptRso3ohDHh4NOUVpWsrNa6h22UlciGA3qrBH/RFxJIV3NNPq/7IWx64NWG7VNIMzvR8KJNzp7ZVRedIPGZkzJ/BQi/0Kn00uURXEhX/fOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738601219; c=relaxed/simple;
	bh=oPuO6+y5Ch8+3t5fklBZMsIEy13TC/lriruGMbXavTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0B4DldsEsquv9imb8ZuE9JM9nl87vYQqTZDkhbO7ZoXEOw2fWVPGwie7fNWft5pD5yrAFB/B71BM5Ue+uQm6zrBbm8Oq2WLSAFXroWpp6qhyZxEjoTmoaECMvqYXogN4LhfDPem3BlQ4Dh8arf8zJYVi9UfET0HnaZO/0JcYXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f5ptihPc; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-467b74a1754so59379991cf.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2025 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738601216; x=1739206016; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+j1L+4jvQNDUpA3HWhjXx2Lq3Pzav+YGqjyReZafTQQ=;
        b=f5ptihPc0Q0iJnwN3c0C+Iigk7P1NBvcP1QaSRZ0Rt4QfB1jtUF3xfeRNp9u2HrzB0
         uFyyH2haCT0rNyAd2vRYcpvczPY36gi3U10/SNY5j4mos/odPbfQrblcgMSn3bAb4maN
         Ln37RxQ/kIbSTlTvHZGm7wZEGlMjVozQIxNg7G88r2R7eNGTQs9+AkKpkAo+PZeC0VrL
         Xuw2ofHLrFRjI3yO6hSSlvtn6zh2usIr1Fqf4LkZ0WiW3t10wRbjuyUyTFjaJ/ycHQwB
         4Yu4+M3gbNRkLWOunLXH1pCB4Rbh3XVE+Pywwu/5vB7dlQESPG1C4dJyQF6YjzqHNQVJ
         dWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738601216; x=1739206016;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+j1L+4jvQNDUpA3HWhjXx2Lq3Pzav+YGqjyReZafTQQ=;
        b=HyO8vh63v/jNllVFqE33j0k67KriQFKuLk/0+6JRdnWdgi1KXUQxjBk/JMP0JXV5eM
         9oPTQB7MxPQthg97zqBKyga5x/PqQLEECvmhgscU1f2xav02f9czBEl+iAE0gXoApEHD
         tyR3Z4+bBPHuPuodVcftwiYc/ZZxj2BN0uE4A0Ne7VAooQxM9pBQ44nRdvbGDR8IY6lg
         xlJ7ellDp3e8KjHXRIKSvDRdj1E/nCuxu71Uk1uc42ENxdpcWLFvMBAZG9SYSbEa+qtn
         0zAXx4rAtIw27OwxH5nnoToAx99rjpmU0SLlF3lDtBwJFHd0hLqL++nUEgvZXTCyCQbo
         I4pg==
X-Forwarded-Encrypted: i=1; AJvYcCWOcdLVcgEQ3mCM/e75y1qqfL2RfHVx6zAtYtEzJkx0oeA/68etD1miSk1wMEiBmp2YCdmlfvNXJgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBAyqxraEAI18ke3tk+mOQxHgG0nrqhkA7u1ZEDpw5s0pjYGbH
	Al9q5eL+G6/4nrWIyZugDtvs8aWR3BY9Ez0guoJkkTv6rxV1vaYTvI0Pcvbfz67Xxltfc9Q5JBU
	=
X-Gm-Gg: ASbGnctAV+vVpW8eVcvyxLqXyRV456lX6vP7rP2fNq7AIRJVC3TIsSzqUfqV7kZzxhy
	7BZ/OueCpwd0PvV2hpA7DGLHEQwzUZInpPD+1LaxuYAMBvHxtnFnE0HDXNvCYr7dcWCaVEvSqE0
	a7kvqAhalQvbxhlIMorn3/nt/cH8AH9f+hAFJ7nm8noEQf00PYp/+jIvP0FIuCmmQZz15g7VGBc
	Jg+6DlWcI3itlUoF+AKSVCJML4IT5SYiqfkjlnLA9Q6PnSPgjxtYQArPjt4TbUuoDLau3qr48bC
	8I2qyrPjWXxq799r/2T3C6KUSQ==
X-Google-Smtp-Source: AGHT+IHrFweDFwKoOEmRTN59Uomc+Brz5YLPX0hWCTptBMIIDyrG04lGI+m05w/b/HeGG02jJWBNkw==
X-Received: by 2002:a17:90b:5408:b0:2ee:5bc9:75c7 with SMTP id 98e67ed59e1d1-2f83abbea88mr30670143a91.5.1738601205592;
        Mon, 03 Feb 2025 08:46:45 -0800 (PST)
Received: from thinkpad ([120.60.129.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bccc8bcsm11584902a91.13.2025.02.03.08.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 08:46:45 -0800 (PST)
Date: Mon, 3 Feb 2025 22:16:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] misc: pci_endpoint_test: Give disabled BARs a
 distinct error code
Message-ID: <20250203164640.2oyjgurfjohdsaiq@thinkpad>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

