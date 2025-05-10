Return-Path: <linux-pci+bounces-27539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F0AB218D
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 08:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3B61882C42
	for <lists+linux-pci@lfdr.de>; Sat, 10 May 2025 06:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD11DE2A8;
	Sat, 10 May 2025 06:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MVXIBFaN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8621CD21C
	for <linux-pci@vger.kernel.org>; Sat, 10 May 2025 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746858697; cv=none; b=KWpyjHsa9D9Tu3FldkWnZ3mkS++e1NdtaNHHJQ6hpNJIBnX/ghGzsAAl4FQFKZZkdsnqmWiaCV8+FAwjEpNZzvJf2QT8/hdCcvt1ok8V8Xl6FlLdrrmrvU+b22+IyW4Y3FF2W5DPFD689tix5bJXqgaAozovNGXsvTFfmvUR2u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746858697; c=relaxed/simple;
	bh=/CUWNCKJLlL2ZUz9MqaxNPY5UPyrCzuEVCDqSKKaiwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1aSyl9jGEg9bISqhGMNPrUt/O3NfPrSTZE8Q9ExF3HbM6LZ+jVTBAUhKxR11Ed4FfHJ2Nt3fOSur//BSnvvK5qkYzNwJ00L4wE578tElrn9L4dvkV5WKcGX3M+tTbnTIN4Roi+THQv/rDuJB8kaWLyBqeW/LxOQVD9NegIpdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MVXIBFaN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso705478f8f.0
        for <linux-pci@vger.kernel.org>; Fri, 09 May 2025 23:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746858694; x=1747463494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=al12x7untsw9gT40SLDOdxEjze2k19FQIlHKuwT2kqQ=;
        b=MVXIBFaNTzcJH/anR5qym88MwkABM+Zj7KoL7uATZcH+BcrAecC9frL5VeS0sVdzdi
         hUJv3H9ojh1IGvebhzIZkbD1w/6ZixvlV4Qdke2ddT52SO8kUrjsCP0L+sbHUuMy8TPq
         OBLL8tROouoczzulH4wuBAmedzNO3y1XAiQes2ZVN4UmKsvhAns6yiyH9zNA5Y7xWcPy
         6NHTOR3EB4XXbB4UwUVIrXFzK2zEPnVyWg+8b/S3HHkmOxwDIHsLOIeJcExhv5WjdvEm
         2RcvTRvBZxupHzftBZLBo2042CXYaCwZXXcKWUj+CSvLlBgMUTBWrKI/zRN15cBJrU01
         Pl3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746858694; x=1747463494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=al12x7untsw9gT40SLDOdxEjze2k19FQIlHKuwT2kqQ=;
        b=emoQycnWqxOiqD670t7NnqoQazm7LWK7RlLsnq3zCm/jVMRidzFyUgH4hBnG81uD6P
         MHp7RI86kbtoYIctiEFbO2hsm6Ez0cS1G2W2494Jy5FRKE4OwTKf76aaij41+wK19nmM
         4SROofV4EZdngRGFhTr8HGsBEKxZMLXhRQQTMIkcqgZVolYUaw2vLmgIJ7FfXVoHvteI
         EVK/Ek2nCfjRogN8u2mucd+GmEXFc6maB2Qk6t9IxXoLqF5otXoOK75Sn9Bh75J7nGA5
         NvY/59hZM4FVpK4n+hdssJLXq3tLzRi7skH385AmnrkVX+zT+2PEKfh8lvAI38J3zx48
         Ai8w==
X-Forwarded-Encrypted: i=1; AJvYcCW6S5MeqH7qPUeLKtxq9rv2+S5SBTcroARLADPUBppAmhtYr87W1oCqLgPs8gaBbNDIDjPN7MMgRDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9xft2Ju1roNxZXHCWYRXd1LyYPE/bjrgbAQpJRVOshbcAwXzj
	qVBjZ2nOC0r4WNMkDdcSuZvYgeV83/Sxsc+VGX1z3XJVzv1oX+uaSS7P6zB3ow==
X-Gm-Gg: ASbGncsJUrTIMhWKrOmgyfSULNDNosJ0ASaYaT8S+t9nvkl7NqocRL5iqDiQsgvF7e0
	tkOQhKeKvVbyh48jK83DESqMc2abt912kGv5I84L/rvlN+UjVq8u/mPUealg5VOGT+uBL0z6Qyb
	72Oa58Ac8+ZAaR0RfBNLpJRLsrasmHOWg2EwwFHkO2n+danOqVCvqCqzt1lI/Bi61njpkFXSf2o
	59PMzTqIY23CtwJLDP0uchjtjk+uc10MV0LthhgRwNGkN2dzkudN9PFoGnFxAE7dARdLEIa9ofF
	nvnnmta5l3THFW2p+aJyBAZYvhJNM0gUqJETltK0wNc13BbRXwOHl+CjNV3/lA7s6v/8/KI+ggt
	sQghpdy2F8iNogxqdb+1e1FmFsWBqPl2zfw==
X-Google-Smtp-Source: AGHT+IETPcny+oJkB2S2QRPRO7MBeUeS+pHJgVEZyOPsrPJBO7sk8jq/SJTSNUR5nO2ekoZ3PrRZwg==
X-Received: by 2002:a05:6000:22ca:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3a1f64b5c99mr4768988f8f.48.1746858693887;
        Fri, 09 May 2025 23:31:33 -0700 (PDT)
Received: from thinkpad (cust-east-par-46-193-69-61.cust.wifirst.net. [46.193.69.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c583sm5351182f8f.84.2025.05.09.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 23:31:33 -0700 (PDT)
Date: Sat, 10 May 2025 12:01:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Krzysztof Wilczy??ski <kwilczynski@kernel.org>, bhelgaas@google.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 382/642] PCI/pwrctrl: Move
 pci_pwrctrl_unregister() to pci_destroy_dev()
Message-ID: <tfil3k6pjl5pvyu5hrhnoq7bleripyvdpcimuvjrvswpqrail3@65t65y2owbpw>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-382-sashal@kernel.org>
 <aBnDI_40fX7SM4tp@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBnDI_40fX7SM4tp@wunner.de>

On Tue, May 06, 2025 at 10:06:59AM +0200, Lukas Wunner wrote:
> On Mon, May 05, 2025 at 06:09:58PM -0400, Sasha Levin wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > [ Upstream commit 2d923930f2e3fe1ecf060169f57980da819a191f ]
> > 
> > The PCI core will try to access the devices even after pci_stop_dev()
> > for things like Data Object Exchange (DOE), ASPM, etc.
> > 
> > So, move pci_pwrctrl_unregister() to the near end of pci_destroy_dev()
> > to make sure that the devices are powered down only after the PCI core
> > is done with them.
> 
> The above was patch [2/5] in this series:
> 
> https://lore.kernel.org/r/20250116-pci-pwrctrl-slot-v3-0-827473c8fbf4@linaro.org/
> 
> ... so I think the preceding patch [1/5] is a prerequisite and would
> need to be cherry-picked as well.  Upstream commit id is:
> 957f40d039a98d630146f74f94b3f60a40a449e4
> 

Yes, thanks for spotting it Lukas, appreciated!

> That said, I'm not sure this is really a fix that merits backporting
> to stable.  Mani may have more comments whether it makes sense.
> 

Both this commit and the one corresponding to patch 1/5 are not bug fixes that
warrants backporting. So please drop this one from the queue.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

