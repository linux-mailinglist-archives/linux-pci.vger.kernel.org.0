Return-Path: <linux-pci+bounces-19061-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D1C9FCBE6
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 17:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26BBF1882521
	for <lists+linux-pci@lfdr.de>; Thu, 26 Dec 2024 16:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF90E3A1B6;
	Thu, 26 Dec 2024 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrE7BJAT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A71028EC
	for <linux-pci@vger.kernel.org>; Thu, 26 Dec 2024 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735230694; cv=none; b=kexNbeUN90OMNNenQiN/Jj8+1F3NP0saH521R/sCpgEFL6J/0ucfSRyzHXip2kt+lVQcD+gVZe9pys/fiSFGiRahag6+PWCs1Gf8gCm0MuzoF2bg7/s0MKKw47ifFOTqhmBG24gycu89PTq3VBjAXzTyDAjoNHr4PqQK6EpLpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735230694; c=relaxed/simple;
	bh=QOX4GpQHMKaujnZhjnaloafPHbT9QB4jfXqf2/m6YwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2tUZK9PXCE8Q3iqf1x53AN4n3/Mp3fcXnAY4WDr0vorXZqpxbJuluT78rzu+2JM2R/kaii+BmCZ7IA+qsM18bVOY/yg86m45jhvWoE3imuapHbkwMGeBAoXpQ0bFHhyw+LUbtudr1y/ikNzasv5uMW+0znLtncV/2z1jcikRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NrE7BJAT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2161eb95317so79053445ad.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Dec 2024 08:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735230692; x=1735835492; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4NVjePzjPUL25kSTYWHfZhN3AdxWwbK2D9YWqDeOy1I=;
        b=NrE7BJATYMu/R5opinZYxwLIAda43vYTehRwFp81vk/kwAJHHcb44/ssbMtkJaIAWn
         LFBEXQ18/2GUKQZrzvNaJGGYAXrmFE7VJdEJC4clL5DO96bx4PJ2LgrS3xxy58/ZjaFc
         3yjz+87PE7/AMGu7FzfZTnuCCbgFbfzkBmNXFpFzCi7zsKYSUJIkTSMga2rF9HUQBrF0
         SzHawqc3HDhKNJPSUE5aYvXg3rv15wg1nv10L5WaldkS78+Wvm//ZiltNgx+/dghrFqT
         roMZMQsqYxdiem/5DwgdlGSmpPn8i0qEczWjeMhLh2gv/tTD+Kr3fL5SdEV5uav7AUH+
         oB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735230692; x=1735835492;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4NVjePzjPUL25kSTYWHfZhN3AdxWwbK2D9YWqDeOy1I=;
        b=FwCV4uv0HKBo0k5jI+kMDRfki4J/K7hRTTEVTRipfsKmMHoHWXUKIViWff0l7rZ6+4
         qmohxBS4qonE5W0zaYpH4ZtSPlsQu6QbrJCLGXb8WLDi84y2e7UDkM0Se/JR5tK/6I4K
         mFe6j4pFuTV3Sn2SMTVW3D6Zcyu4PVnSY7gZTwPjxnbDDarcpDGnMixC7YelzKvNehxl
         jv/hU6iZR9U4e+1zgpKRFKrz7i+ecx+35M/aKELK1OFAs6+uvRTLa+KZkTk9JtXyY71O
         c4NaMIXUw1Tm7LCdOHcySU9IPoPWlZImJr6DYgji/nlxAy0TGWc/pcUH/HDebDM7UV4Y
         +ndg==
X-Forwarded-Encrypted: i=1; AJvYcCW5X6clyObz9pH+MbJU68NGZOlGlFy92JQVs5vI7LShhxZQZg1Pqf9bClXt4OnJALdHKuLejR/9qYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVn8IImOkwS63cNEn2AuncP2riFRdtkjrJxXHhjs9q2UUbsWkn
	BbP1/VqP0FJcsadlQLpc/tbdN89QNBINLeBgWjt2RuKqz9BTReCVP3swQvLk/A==
X-Gm-Gg: ASbGncvcsPZMTKvnfvMx0oglVlDRGtDnb6DR0G7VX0H67Sui02GUAa9o7KrUJGdwj7D
	/vGpugrGG3ghPeTg6QREhsrEW3fVJ6SjMocM1Y4giB3eSG7VbpyXkMAjGp/jKCjZr/AnpEp7OWS
	tC+39t1/67hJrDxLcRMDEvEXSDWnLaIr8i3YEEwAQx8ybn8eWvtApJp7CW8fjfvMkWK9TkQ4B1V
	drOjpQARUHF/6CGOBY4N/Gmj4asUh8Rk6+Dyu5KpC6b3juoHe9RiV0T2FyGX3Bo9JU=
X-Google-Smtp-Source: AGHT+IF9yrfaTFZ5jPZ59uUH9NRApTu9Y/LOOoKnJ8ECUb+TAGhvbQCGP65rwUCwKPGDU6DfsN9Eng==
X-Received: by 2002:a17:903:2286:b0:215:b087:5d62 with SMTP id d9443c01a7336-219e6f1483fmr341124765ad.36.1735230692395;
        Thu, 26 Dec 2024 08:31:32 -0800 (PST)
Received: from thinkpad ([120.56.206.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca01931sm122090265ad.245.2024.12.26.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 08:31:31 -0800 (PST)
Date: Thu, 26 Dec 2024 22:01:21 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mohamed Khalfella <khalfella@gmail.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Wang Jiang <jiangwang@kylinos.cn>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: Set RX DMA channel to NULL after
 freeing it
Message-ID: <20241226163121.n2itccd4glm6vum4@thinkpad>
References: <Z2Z7Ru9bEhCEFqmc@ryzen>
 <20241221173453.1625232-1-khalfella@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241221173453.1625232-1-khalfella@gmail.com>

On Sat, Dec 21, 2024 at 09:34:42AM -0800, Mohamed Khalfella wrote:
> Fix a small bug in pci-epf-test driver. When requesting TX DMA channel
> fails, free already allocated RX channel and set it to NULL.
> 

Patch description should accurately describe what the patch does. Here, the
patch is fixing the NULL ptr assignment to dma_chan_rx pointer and that's it.

Reword it as such.

- Mani

> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index ef6677f34116..d90c8be7371e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -251,7 +251,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
>  
>  fail_back_rx:
>  	dma_release_channel(epf_test->dma_chan_rx);
> -	epf_test->dma_chan_tx = NULL;
> +	epf_test->dma_chan_rx = NULL;
>  
>  fail_back_tx:
>  	dma_cap_zero(mask);
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

