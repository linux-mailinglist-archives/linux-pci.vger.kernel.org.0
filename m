Return-Path: <linux-pci+bounces-28769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43172AC9BDD
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 19:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572983BB52F
	for <lists+linux-pci@lfdr.de>; Sat, 31 May 2025 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C72918858C;
	Sat, 31 May 2025 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lss9qpmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE871442F4
	for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748711123; cv=none; b=kdjGcvijHsDFwL7wdieWYunWqokKNo+LBMr0DUxo/Rzi99iksvcwKihPH/Rlj+r7sYQ7FUIDpCsGLq/PZSW2CEtHOlRPvsAZVFKDqNkE35ywrBIE4O3jQXa5xNfThJ9cgdEx7NJfoC2z+T52tFjy6vXJ8I4SNin7Fy9ZvuS6fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748711123; c=relaxed/simple;
	bh=x0iEMPA1LrYRc3lyTC/SW6IUNprH/IgN7GM+dmDoORE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvXucgx9Pz7Lg8S5hGVvwoZuVgxHvCj1TRxcPpyuRoUPdhWjzRqDhHIZgXG+GizPvWC562NBwJbgVfpUQSPTnasjDDunyvPdciMhzOt/rAlZzRRMA5ii3nF9gMRXvALC1ebTbl3cv4fhyCz+lrys7fEr0+StlbtM0Ay7KKdjQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lss9qpmC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22e09f57ed4so36373005ad.0
        for <linux-pci@vger.kernel.org>; Sat, 31 May 2025 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748711120; x=1749315920; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lM+Vm1sxzlwErSkujNdEr6GDSE2t0p0EBV3tSTtUlbs=;
        b=lss9qpmCSOmcyVxg7ceJQ2HnWtOtDRTEcskH7JBtdCeCig+9Gzp+EUpc4PswxaAEAE
         IVx2zhpMLc9Vs4sStL85NsIYuP2g7BAWCsurnBvCiTidbIHfTtJCl/XX3sRmF/se9ytE
         PlkGHztNyMplHmeU0L/UDko1afRsjUfLoksysftg2xJMyaaM7PPWdRo7BcOPjr9M3ue9
         MPsLcbkkgRPio3MWHaR0WobUYHuZ3R6D9uqmOQvEFBiDlp7UoeeI7nbdCuGAq2qAjzkS
         NQJKDWYhJSBp+fQcCl50ImhCP+DFIvBovcVw+QLhwTw9N8apodn3VB3O1ZhOyPOR9SCN
         03nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748711120; x=1749315920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lM+Vm1sxzlwErSkujNdEr6GDSE2t0p0EBV3tSTtUlbs=;
        b=PZW2fb+sZpiP1GsAUz72werCEIOoFFIp2HT9r5euxj1yGflraWTKj2yfRKb/657N79
         qyhLdS+CVBbVe/qHwlmH64QtdlNmxETQAtGrs4jD8XcU9CW2+S8SMm9EwUm37aSk76cj
         ZtmRY3ftxcs6RJzek+6BBngPuCnyxmJemCj52ExzEoUfvjRh4kGrukZA/6jH/9ZNCYHJ
         a5Yng62w0Mkb4bSiY5JS15udjTsgMAn7esQa/jwkKmTMmGL/YxfEO25tEcj+fo0Lh2qv
         UvBg97WUhy9eMUBuuV6L7lOYsgL+QYxEy9vIVSfJoEnFmpbkEPpkfQPvp8WOnTS+qU/z
         WgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4gxxVVAKUbT37ZCcXdcR+MmZdFYSjTgESYehfzQD6OprfPusLX2gs5fQaBNgWxd8FP8Y2bgF5pY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxT/5QPc6kagBEHEc3WXQm46Q9FDO67/fjSug0r1DZZ/5ytEHY
	VRHdH455un1dw7bLqosDmvx5+2JbBXS31jb9XQrA35F+ryoPSyhC7eQ5CpM3JA7CEA==
X-Gm-Gg: ASbGncuIAfCDY4k9VnQ0hIXsRCGechipqtG4tY1Hwo9h2vcJf5YFQfViOhB4oRSyT6v
	iRBe8lr1dD1Up60Hvosq6ErKkQprY9sFAdy1FROWEHxEujR92mIs2YaJYr1SliBK8cQxZtga5cK
	5SvwOKuCGu0uQBtEqcxaPMq9d6GffnwgAKIabPlnNZW5iPfQhyAiZQuiWAarWbTtHHHbQt6VksN
	rwLn7E8qJlap7lVu8wm3fuo2UazXE4I0NeuG9cZAAdKLTCvvIT9l+8UkGgmik/SYEzpCfXRinr+
	FIr3jowbZ2/PfSgLKzu48yLgYdkqsOP4oLvYzl1T8M8TFlZkiaCPXBDviogW5w==
X-Google-Smtp-Source: AGHT+IFdEaiMsq9p/fY62ZuESsu9h6XTS78Q7H6VtGsbnxe3keQhoidzBkD/oQVVVD2Dr/Suvz582Q==
X-Received: by 2002:a17:902:e74f:b0:234:9fe1:8fc6 with SMTP id d9443c01a7336-234f6a08ab9mr185502615ad.18.1748711119638;
        Sat, 31 May 2025 10:05:19 -0700 (PDT)
Received: from thinkpad ([120.56.204.95])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd38e0sm44835625ad.138.2025.05.31.10.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 10:05:19 -0700 (PDT)
Date: Sat, 31 May 2025 22:35:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: shao.mingyin@zte.com.cn
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, michal.simek@amd.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn, 
	xu.xin16@zte.com.cn, ye.xingchen@zte.com.cn, xie.ludan@zte.com.cn
Subject: Re: [PATCH] PCI: xilinx-xdma: Use =?utf-8?Q?devm=5Fplatform=5Fior?=
 =?utf-8?B?ZW1hcF9yZXNvdXJjZV9ieW5hbWXCoMKg?=
Message-ID: <i4qf2oycket7gkvyd3tfdzub32xlx27oydcporfb6thc4yosbq@grgbbjgymvgw>
References: <20250403154654546Uoj1gN_pronbxhSLPEIUn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403154654546Uoj1gN_pronbxhSLPEIUn@zte.com.cn>

On Thu, Apr 03, 2025 at 03:46:54PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Xie Ludan <xie.ludan@zte.com.cn>
> 
> Introduce devm_platform_ioremap_resource_byname() to simplify
> resource retrieval and mapping.This new function consolidates
> platform_get_resource_byname() and devm_ioremap_resource() into a single
> call, improving code readability and reducing API call overhead.
> 
> Signed-off-by: Xie Ludan <xie.ludan@zte.com.cn>
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index dd117f07fc95..238deec3b948 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -753,8 +753,7 @@ static int xilinx_pl_dma_pcie_parse_dt(struct pl_dma_pcie *port,
> 
>  	if (port->variant->version == QDMA) {
>  		port->cfg_base = port->cfg->win;
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
> -		port->reg_base = devm_ioremap_resource(dev, res);
> +		port->reg_base = devm_platform_ioremap_resource_byname(pdev, "breg");

This patch is entirely wrong as 'res' is used below. Please do not send buggy
cleanup patches.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

