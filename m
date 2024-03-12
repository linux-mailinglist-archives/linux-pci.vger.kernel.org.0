Return-Path: <linux-pci+bounces-4747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E3879049
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 10:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 359EE283804
	for <lists+linux-pci@lfdr.de>; Tue, 12 Mar 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1858B77F21;
	Tue, 12 Mar 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv5xst78"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671078265;
	Tue, 12 Mar 2024 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234264; cv=none; b=PuxRQT9DckiHzbnYKs8RdzCVWxbTVkOaWU6P8uuHRILlhsehtr+FpJNQjmEcUTkEY2amX2KmIQ0gRLwASbsL2gPSJVcN9zdhUnlbfL6u+vTaEna7suk8GPMrgkih342mkjZBVugUNMtwi6/qLT8ldwii9nXMqlPJ37QkvzwFsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234264; c=relaxed/simple;
	bh=qdhaJZYzAfGiNZcY1AyLkSazWvntkfiFETQEFvh2LUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9HXPNg9ws3DdXZSk+T3Mh3tdsyjysJCm8I99+XtZsDqwjy64i1cQUcHQYBChsCQaveW1Iagce8424DaTwUKgLT/z0H8e5MullVpmGNiWYk5bVsNSwpC9s2/44DHVqTFo82JsTcPAPtT+SFeDl5PSpR/xC0bEUiJhEZzAq1rAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv5xst78; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d459a0462fso4603281fa.2;
        Tue, 12 Mar 2024 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710234261; x=1710839061; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7rk9dzFLtOBBhT0DXPNQ6GEvnLtRWY6goiKR1vrVJs=;
        b=Tv5xst78+A8ASuTgxrg58ew1kXl/8m5G0Dr1XjWa/6jVCSFp3+6FyBEgeAt75EUJal
         eAD7E9uCgjh8qdN+0FiCetLnWRqnU8fs0YMt+THCCZAYRvGn9OZ1YFYPjtYNXKV/DwjD
         T7T1aROpSHvS+Jx2fr6Z5b2jZfKjkXmRfd6qHw9LG8NVdKoNzJ/nZL5C7BjYWqbLVetc
         OHbUK1ZRZY32oiDK/ACjtQfnLUvKJAyT1EJxx3vqmAWRB/3/Ae8AlJdPhcdWuXKYmG9D
         abRDgZiYb7nV5zTqx+zMKazeED2zLPUeHdk1iMZhVp2PYhDP4p+iJ3uoCv1cVYVxro47
         LqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234261; x=1710839061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7rk9dzFLtOBBhT0DXPNQ6GEvnLtRWY6goiKR1vrVJs=;
        b=WhizYavShXxuRHm90XA/Hkf5vHsLnHSk+F1L1vJv+Fh8kcufYPTmdINmfRsYjxoZ0C
         17E/TkrvmphV4oc1Nq5H4vrAZCMi1/VzOv5cw6nXCFLwtbeiSBBubX0ECQbp14lEWdJw
         g3OH5AaL7kXTYbUKBmo7ByEJAcZCGpbqKmEJvQh4gEtuWvc7W5rH+nAwWK/PWm+zAuav
         Sdr6UlLEfhIOO7h41TzQnYm4GK/UjkEZXVyAIHXINUHAiCdlzR4avqYG4My8gXavN88+
         6LQYFcFA6Mw9w4UQ5J/q0UZUWSmy4QUv58ILm4dcDhb80eTcpT/BMAAwwITyGyhUXc58
         KqdA==
X-Forwarded-Encrypted: i=1; AJvYcCX+X25MmAaSAKYz8B9kiTzCs/XFhkv7sUlvs7bya2YdsQqRq1IR1RX0E4XCRW8y9qC6Ty4V0yuGe5EJk1lKlB2JCBazK8Rwm3BwII2hlwXGpVcNUTf+bvpUTUFLGzmTSoH5RGkXacR4JoU7aC0QxEGwPHlNCbAJfOu1ZBo4NtzHht1TVn3gLdToc//L0dQYOlmvUyneOLPiR05CuDjcii20X00i/K4m7j4b
X-Gm-Message-State: AOJu0Yyi0hZ6BIK09mg2DgONbU4De50Q8taq776pSjlEdxkLH5TB30w7
	+SV470RalbkBdMYlbuRIZEZRGaEPWUcTgu3zD81IoINxuV9aw05T
X-Google-Smtp-Source: AGHT+IHq5fMBsDl048RBn+pRrCOIdHvh26Fn3Ebv41AXt4kex74sIY36NhN7e05VM3Pbi21f/tWJ7Q==
X-Received: by 2002:a05:651c:141e:b0:2d3:3e83:8309 with SMTP id u30-20020a05651c141e00b002d33e838309mr4968298lje.19.1710234261019;
        Tue, 12 Mar 2024 02:04:21 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id q17-20020a2eb4b1000000b002d43dfc5d5csm804351ljm.7.2024.03.12.02.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:04:20 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:04:17 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <flwmqlr3irjuwfqpjn227qnrkyyayym57d5v3ksr4xqmfxshaj@ibdi3dyetkou>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
 <20240306-dw-hdma-v4-1-9fed506e95be@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306-dw-hdma-v4-1-9fed506e95be@linaro.org>

Hi Mani

On Wed, Mar 06, 2024 at 03:51:57PM +0530, Manivannan Sadhasivam wrote:
> In order to add support for Hyper DMA (HDMA), let's refactor the existing
> dw_pcie_edma_find_chip() API by moving the common code to separate
> functions.
> 
> No functional change.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++++++++++++++++++-----
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..3a26dfc5368f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> +{
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +}
> +
> +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> @@ -902,8 +912,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  
>  	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  	} else if (val != 0xFFFFFFFF) {
>  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
> @@ -912,12 +920,17 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  		return -ENODEV;
>  	}
>  
> -	pci->edma.dev = pci->dev;
> +	return 0;
> +}
>  
> -	if (!pci->edma.ops)
> -		pci->edma.ops = &dw_pcie_edma_ops;
> +static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> +{
> +	u32 val;
>  

> -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +	else
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);

Once again:

On Tue, Feb 27, 2024 at 01:04:55PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 12:00:41AM +0300, Serge Semin wrote:
> > The entire
> > 
> > +	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
> > +		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > +	else
> > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > 
> > can be replaced with a single line
> > 
> > +	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > 
> > since in the legacy case (reg_base = PCIE_DMA_VIEWPORT_BASE) the
> > pci->edma.reg_base has been initialized by now.
> > 
> 
> Ah okay, got it!

-Serge(y)

>  
>  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
>  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> @@ -930,6 +943,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	dw_pcie_edma_init_data(pci);
> +
> +	ret = dw_pcie_edma_find_mf(pci);
> +	if (ret)
> +		return ret;
> +
> +	return dw_pcie_edma_find_channels(pci);
> +}
> +
>  static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  {
>  	struct platform_device *pdev = to_platform_device(pci->dev);
> 
> -- 
> 2.25.1
> 

