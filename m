Return-Path: <linux-pci+bounces-4012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C029867579
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 13:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5044F1C24382
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685CA7F49D;
	Mon, 26 Feb 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFATgu95"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB57F475;
	Mon, 26 Feb 2024 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951523; cv=none; b=pwoHvbtWGMmGjkzl4EwA0/yjlkWkYh1Z/8mz8sKzi+6cMo7lUbzpsiP9iz+bRGghQTc5jzGwWNDQlNYeDHanlLrxrvlmmNqC3nK7BNcj8f8X8V0hCdvMYb5voSbayxFpwfPV8sFglDd4uBm/mXW9ySDiBmzIGWaxsWYpNuUeFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951523; c=relaxed/simple;
	bh=TZVUR9ocsVnQ0pHZ0RxO5osTV317Ybr1stOPtvhwMVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t46Slly8HLYvTB+l2aSCZ8zafU9GX8dKLscZ/VQVgmWGzScMcQQhnrBFf/Dh+QEYfGXlstAZ1Wk9sJT6ap53Uodfko8my/vW6v8JyG3CFvEdhYBoRgDcO2uuzD7y8erOZZjU3Z8W/ykjJIXeviyWHVxPtXkVK83+I/7BDjVFl8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFATgu95; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d22b8c6e0dso30821091fa.2;
        Mon, 26 Feb 2024 04:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708951519; x=1709556319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5inM5MIJdH95rtY5NIhYJAB5BjouiCH5y6Mv4miue6E=;
        b=CFATgu955PKZ5Q3KOI/IJrC4V/mVJUHH78HzHoPcgVhmJ47kFoWlHNbJHqKMJBCMt3
         xfXtTgcAltKvTw178tvGpS3pgHgYwneheFHXE8/fZRM+nR5+MnlnYEFkkRkaIlh+SG7o
         CPtYYh7FuDIHRaAhtLm8OaA4e+kON0V/5RDnaxh3LMLI7Yg/cD+oH7ID69xEHqzAaHOv
         uQDnxBV2h5CKt3V56cjDrlfPZbFNZXIc3yhGDNNm1z2Y9AcHKRjsxoCfjSx1GccREqzK
         aLh1wN75U1qLh0d5YYPFOS5Hb7tvXC+CuFEkdUScAG/L5ZSbWUkFWB+indjKd7n6mwDc
         laug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708951519; x=1709556319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5inM5MIJdH95rtY5NIhYJAB5BjouiCH5y6Mv4miue6E=;
        b=T85w89LF+2Ak4Pg2bk1QcrJGoNapnimwcuMk/aUV1mdJVr8MY/7L/uQhdOsEFeFJnS
         SXrS4yU404YrP8YfMuutu3wHk6OyCKMVyhKb9TDCFlTNWLMF/DYCrtsicZT93K78LZN/
         k6/EFV75GiMMuGfQrmp/mcgP6sA2teOItULNoYRU6Zt2TFchSyUbNcl8qPYlTNpIc27S
         EfLPqRmlj/p86Kkyvp6VG5qtTG63H/lm/7vfV++0FuJR5EDFkvpbnieBWn56MOtRrA+R
         58KSIlx0IvZjBFzfCGFTGNMmXaKfJeDLdgoZW9iquOHlomwCj+TgGeFrMwVsX3DY1K6B
         idLw==
X-Forwarded-Encrypted: i=1; AJvYcCVwL6czKDZvcJvlFmsGYvj5UJKFd8MyUikkFWJXfvBWg2VOR52U2A3fdxdSwTf+cPugRzqkmzy95b8RiBNfsdWHma3L0sw/XV/bTskNrB85c24pHKHujTTzK9moWPCGcr+1fS732lcemdhe7S48cLn08hyRSnNGwim5xjNHt8WOD0pJFI4U/GPX3hXngD+iNRxHWAOBkirlbO5nstAuUKmcGs+3Qi1TAEhz
X-Gm-Message-State: AOJu0YyQC72C4iP+P3PjcWpcH0d04NFCA4qUlXh9Kly4xOSSa/MNAP6s
	dUDQs6HeT5/jEiycxQLN5JZz+WLqwgSQxkwY4ZsoZsAFkmSIc9eM
X-Google-Smtp-Source: AGHT+IFTcXELJgIuddDmuX7MVZviLk/f/Js23B+qxWOY8L55q/M6wGDtHgANSMV7Pitn4EaDSF8hvA==
X-Received: by 2002:a05:6512:3605:b0:512:fccc:f289 with SMTP id f5-20020a056512360500b00512fcccf289mr1822609lfs.6.1708951519358;
        Mon, 26 Feb 2024 04:45:19 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id f21-20020a193815000000b00512d8cecd78sm856365lfa.197.2024.02.26.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:45:18 -0800 (PST)
Date: Mon, 26 Feb 2024 15:45:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: Re: [PATCH v3 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <fielxplkgrvz5qmqrrq5ahmah5yqx7anjylrlcqyev2z2cl2wo@3ltyl242vkba>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
 <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226-dw-hdma-v3-1-cfcb8171fc24@linaro.org>

Hi Manivannan

On Mon, Feb 26, 2024 at 05:07:26PM +0530, Manivannan Sadhasivam wrote:
> In order to add support for Hyper DMA (HDMA), let's refactor the existing
> dw_pcie_edma_find_chip() API by moving the common code to separate
> functions.
> 
> No functional change.
> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 52 +++++++++++++++++++++-------
>  1 file changed, 39 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..193fcd86cf93 100644
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
> @@ -900,24 +910,27 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	else
>  		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> 

> -	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> -		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> -	} else if (val != 0xFFFFFFFF) {
> -		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> +	/* Set default mapping format here and update it below if needed */
> +	pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
> +	if (val == 0xFFFFFFFF && pci->edma.reg_base)
> +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> +	else if (val != 0xFFFFFFFF)
>  		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> -	} else {
> +	else
>  		return -ENODEV;
> -	}

Sorry for not posting my opinion about this earlier, but IMO v2 code
was more correct than this one. This version makes the code being not
linear as it was in v2, thus harder to comprehend:

1. Setting up a default value and then overriding it or not makes the
reader to keep in mind the initialized value which is harder than to
just read what is done in the respective branch.

2. Splitting up the case clause with respective inits and the mapping
format setting up also makes it harder to comprehend what's going on.
In the legacy case the reg-base address and the mapping format init are
split up while they should have been done simultaneously only if (val
!= 0xFFFFFFFF).

3. The most of the current devices has the unrolled mapping (available
since v4.9 IP-core), thus having the mf field pre-initialized produces
a redundant store operation for the most of the modern devices.

4. Getting rid from the curly braces isn't something what should be
avoided at any cost and doesn't give any optimization really. It
doesn't cause having less C-lines of the source code and doesn't
improve the code readability.

So to speak, I'd suggest to get back the v2 implementation here.

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

Just dw_pcie_readl_dma(pci, PCIE_DMA_CTRL)

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

