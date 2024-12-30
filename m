Return-Path: <linux-pci+bounces-19089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA69FE335
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 08:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42AC3A1A9C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 07:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3365119F42D;
	Mon, 30 Dec 2024 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/qbQLnr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E537219EEC2
	for <linux-pci@vger.kernel.org>; Mon, 30 Dec 2024 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735543619; cv=none; b=I6f9Mh2NyD/cB/r+lyaAzuUF6DVw8mXU+MV6Z6E9KH8XQZ8kcCLh6/Oql8R+C6GWamu1+RDUKQI28hPtTp8kap6/QSx4ZyVQNmtEfrVAMC9pAhvjTWwRWAjTbiwZOVpZLYl4t+phQRo+85VFzocEWqVLrIVhkMV7H9vmm8qKuYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735543619; c=relaxed/simple;
	bh=MWxDXOlW7j53jIn6RPlpS06cck+wPdGtjnIckqK7d9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKG4ocWC7CQsmmdVdz2UUb0JcaI31EwQA2HJjdZOiigz/kNou3nLUHoP81Xbbog9qUcxgxVdxKXgIKHcuYh/sKWyEg+u9WXpnA4hz722egg5MpYCJwVbzXC9N0y4bqcIj6NAzp6kks7NTwJqcmcP7lQV+CV6qoXCW0PzT5yY/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/qbQLnr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2165cb60719so115192755ad.0
        for <linux-pci@vger.kernel.org>; Sun, 29 Dec 2024 23:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735543613; x=1736148413; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8OryNJDFLOIaLKOtNOzgr4ZnUh1tIsAApTSyQ1wgHI=;
        b=s/qbQLnrJXmQU6oZRiHo8qnA3oVEcZmWpOCtLSC4czIcTAgr6igSxcMTLQBjC6Cj88
         ZEV8AaKsFIS00tHL46kKihXdHhoFkMDlP0cQZzqAx0TWI5IzqVam+KvSexzA9ruEBwPq
         Y9Wg691/0AxwGCJsaqSFC/lZTv2e6YsFtMLhzwlfxHsD9GQ/m/L/0qxDQ3o5wL81/Vb5
         sBrfs4E1ccQuFRgIImwZ7gwaz7lqYvwtM5CqiaaogDRlhgicBbrFT0+jbCWSfvP9dNFI
         jhnHKnNUUoZc0yn4yOC1d000LZm8OkxkHzs37EpA2jAw05nuC9dt+VBpFlBGWgCTumom
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735543613; x=1736148413;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8OryNJDFLOIaLKOtNOzgr4ZnUh1tIsAApTSyQ1wgHI=;
        b=XvrrA2HhnAIpYM3nkvp8q/2/OKTLDzJWMAOB9xU9MkHnxo787CB0kLQOLNtl1nHKSx
         PY2K/SAk1LPDpIFDmoCDHWq92rWSWv30laT8z1x/2rK1hv4qxR1T/IsmXNhnFyLeuKtE
         QSa0ahuw8Ruzwj0V5MjdtiEQNowGAirDmDz3bPUmuffH2POMgq7OQ0FN4lBsynUhTKuJ
         pXlyhJ5j/8eE4SjdrmxIC2DsD4wvkZY4wP8nBqtTPJeW0bGPadQ34FjyBFwTAxNXw2AV
         GgRUgsYv+f5fGSEG73M5ZW+Br6FI5Ca1GWcZEgLpJ8BdQSCnJzyt2QGxSaqaDvInv5m5
         1Jrg==
X-Forwarded-Encrypted: i=1; AJvYcCXXK/gcG9h8y/1yGB6XzIXp9zKMuj1+dLf6QFKTCk7tNJAkLWSlKW48xfwilKz1yDr3ZybYnvGcuKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAd9Bfrop8qpOi+dttKl2p2Hlsa/w2jc0SVAo/QdT/teHg6SeI
	Wn1rdX0H0Z3604Hdhs6hJShm6lbY2XNXjOEfDMvbplzijyH6afUQxBXbkG7CxA==
X-Gm-Gg: ASbGncv7prG2m7B4oIzf4CZqT/xn1NN3/+Z4LRIE10CAoYB4SR6FffIdhqj+JqH14Wt
	0mOsEiOe42q0An+PNh2ha0G4ZBpwhsWeOI8w3goDpGKqefH1Ed4LHyoFuy7lfTuNLjSQ/mi9wU7
	Ue1gZo3dYbMBmkehSMMEk9kTZMZ+I3XrODn456vB/vF/q14WJ7NmzYN5ZhHyo5b/NRSnjBzGSoB
	URlho64Zs/t0uGwr2O6j9T/sURBYTiStQCy9GWVUIcJkvo1fvm+3dZVHzGHYftJDUkA
X-Google-Smtp-Source: AGHT+IHDI+emEyeYMjERnHzVZ9Z57rQZmYe1MWE2uLjANDmiMpD/jKYagU/EQarks6y0gK+c0am63g==
X-Received: by 2002:a17:90b:53c8:b0:2ee:c2df:5d30 with SMTP id 98e67ed59e1d1-2f452eb11e2mr25494784a91.26.1735543613274;
        Sun, 29 Dec 2024 23:26:53 -0800 (PST)
Received: from thinkpad ([120.60.139.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962961sm173019025ad.13.2024.12.29.23.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2024 23:26:52 -0800 (PST)
Date: Mon, 30 Dec 2024 12:56:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mohamed Khalfella <khalfella@gmail.com>
Cc: Frank.Li@nxp.com, bhelgaas@google.com, cassel@kernel.org,
	dlemoal@kernel.org, jiangwang@kylinos.cn, kishon@kernel.org,
	kw@linux.com, kwilczynski@kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Fix NULL ptr assignment
 to dma_chan_rx
Message-ID: <20241230072645.6x4awglfwbjis27e@thinkpad>
References: <20241227135948.ztxxx2u37og3ixxn@thinkpad>
 <20241227160841.92382-1-khalfella@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241227160841.92382-1-khalfella@gmail.com>

On Fri, Dec 27, 2024 at 08:08:41AM -0800, Mohamed Khalfella wrote:
> If dma_chan_tx allocation fails, set dma_chan_rx to NULL after it is
> freed.
> 
> Fixes: 8353813c88ef ("PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities")
> Signed-off-by: Mohamed Khalfella <khalfella@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Btw, you are sending next version as a reply to the previous one. But you should
send it separately.

- Mani

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

