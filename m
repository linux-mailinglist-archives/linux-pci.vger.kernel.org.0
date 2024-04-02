Return-Path: <linux-pci+bounces-5518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D61D894B3E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 08:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7032B20F7B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 06:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA1F17C72;
	Tue,  2 Apr 2024 06:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFNSO88b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6916E17588
	for <linux-pci@vger.kernel.org>; Tue,  2 Apr 2024 06:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038863; cv=none; b=P1TWxarbDgC9wJr7L5xVVC3jHd1FiiOSSAKiEWUKi6fKmLXd8PZVU3TqoWbgbUnSSdkIz7WUC2ibXEfM2ZzD6+fUjmEemxgQaxkswbQ7ND/cz0PBl++5CtDYw07K74VW2486DAB0knK1tN9ltCagml6+1iWgfA8rvXPogZQsnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038863; c=relaxed/simple;
	bh=cNoa/WSKdG9WPeHZG826HsCLHIC3JAKzp9lZ2pmKVfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glUZxSUQJtPV0h05zGX3coQ9itRIGNLlU8Vvgklh/Jgt+K1D0WNX1DJK/WL6gg+aK2iS5/pCTCtIVq4ufUKhmKKA6NQc8pBvExApfDAJ7lUjgZd9SxSB1YAG3yYRqvWA6mSEFbWTLFGHhO8nPq+xJY+iSaFAi5+rnHpg392hqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFNSO88b; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c3d7e7402dso3173997b6e.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Apr 2024 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712038861; x=1712643661; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6yuI2DajbRXNfiAuxNce9EkhiBZe7RWyRs8b4oAe0EA=;
        b=GFNSO88bXjXH2PeBZW7LAYjHEk1Ptd7YcuIJ5D3zUGyEjQZtnbW02ALekw1eljdIrY
         CLE67+GaFcExGRgk2aYYP2blg2PyLgByhbJaXg8aFwLsMy1t2vXCIXxHDhdN76HgRwyv
         QQyPuzGAP1orDZ3LIFGV+xkDRER4Oss48Hesrzhfyc9gmd/N0M8efygPnbDUlrdbhaxL
         QhGSL4nyaIIzWge8hjcntG3M2wtmb4X50wxzP6+RXmPix6prhyxQRDg+yNm90DgJb5h1
         DgftHIifFqEAivlq3k1XAlMrEiEjn3PcJWOBPKnMnaR9r6lKSxgjartYDZzcMKNNrTOy
         I/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712038861; x=1712643661;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6yuI2DajbRXNfiAuxNce9EkhiBZe7RWyRs8b4oAe0EA=;
        b=f90a48byEsxpIQMpiuU5WeCPor9Axr5suaGtWIQ+TLxgUbPi2IYSizPN9O76J9dQ25
         EW5iK/vUt+qH/skr2x8JwBHwTqrC4o22ioV1TMrQHZikgHzpoH7eLMScZIcq3Nb/s9ID
         AnWpoiR23pfCJaKONN9MnqG3CVQWim4Ka+cbAJ8G5juZaRSHk5bEQckuiLE27m4Ruwm2
         tW8lmhmNXwnT4MD3hyC5arrnBT5AOuMu1i9aozbtX3Gh5yP9JpxCG1wXLCEwqcxtA0cL
         gcXr0ut9GfRzo6u10TQmzIve1gsVVlyxA/mSz1qmVOcCut+kbVaRXCGLcXZWtkropjjw
         dkpA==
X-Forwarded-Encrypted: i=1; AJvYcCXmTJP0CuhWR5TNQBeScLT5GQn1XOrF1sOeGhZ6aIIz4mY2jr78n/Xj/u0eoPtw05Xe7BV89vkdr/4SVs+3MrLB7YPCjZeo4ZQE
X-Gm-Message-State: AOJu0Yza2BG2jQucod259566cMitsOcfemh/ztILYOhPkVJdynwfjHit
	YNJDOb7OSD/Sxw7PHY7FLOgBtGQP7op6lUfhM2d7DsyTDk8kdPMNtKkpaNi/gw==
X-Google-Smtp-Source: AGHT+IG7fgTzLpJuGo2z55kJheG895TZsfWHkjmx9KC7ty7XYt+OjJ1AumllvKdmr19w8DVE6kNNIQ==
X-Received: by 2002:a05:6808:2e92:b0:3c3:ef02:6a87 with SMTP id gt18-20020a0568082e9200b003c3ef026a87mr18063298oib.31.1712038860338;
        Mon, 01 Apr 2024 23:21:00 -0700 (PDT)
Received: from thinkpad ([2406:7400:92:96cc:b954:3c38:e709:b65f])
        by smtp.gmail.com with ESMTPSA id r7-20020aa79ec7000000b006e65d66bb3csm8916207pfq.21.2024.04.01.23.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 23:20:59 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:50:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: cassel@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	kishon@kernel.org, kw@linux.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/1] misc: pci_endpoint_test: Refactor
 dma_set_mask_and_coherent() logic
Message-ID: <20240402062056.GB7183@thinkpad>
References: <20240328160632.848414-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328160632.848414-1-Frank.Li@nxp.com>

On Thu, Mar 28, 2024 at 12:06:32PM -0400, Frank Li wrote:
> dma_set_mask_and_coherent() will never return failure when mask >= 32bit.
> So needn't  fall back to set dma_set_mask_and_coherent(32).

dma_set_mask_and_coherent() should never fail when the mask is >= 32bit, unless
the architecture has no DMA support. So no need check for the error and also no
need to set dma_set_mask_and_coherent(32) as a fallback.

> 
> Even if dma_set_mask_and_coherent(48) failure,
> dma_set_mask_and_coherent(32) will be failure according to the same reason.
> 

Even if dma_set_mask_and_coherent(48) fails due to the lack of DMA support
(theoretically), then dma_set_mask_and_coherent(32) will also fail for the same
reason. So the fallback doesn't make sense.

> The function dma_set_mask_and_coherent() defines the device DMA access
> address width. If it's capable of accessing 48 bits, it inherently supports
> 32-bit space as well.
> 

Due to the above reasons, let's simplify the code by setting the streaming and
coherent DMA mask to 48 bits.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Notes:
>     Ref: https://lore.kernel.org/linux-pci/20240328154827.809286-1-Frank.Li@nxp.com/T/#u
>     
>     for document change patch. DMA document sample code is miss leading.
> 
>  drivers/misc/pci_endpoint_test.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index c38a6083f0a73..56ac6969a8f59 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -824,11 +824,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  	init_completion(&test->irq_raised);
>  	mutex_init(&test->mutex);
>  
> -	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
> -	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
> -		dev_err(dev, "Cannot set DMA mask\n");
> -		return -EINVAL;
> -	}
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
>  
>  	err = pci_enable_device(pdev);
>  	if (err) {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

