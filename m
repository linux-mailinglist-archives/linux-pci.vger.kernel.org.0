Return-Path: <linux-pci+bounces-15786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 726439B8BEB
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 08:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64AF61F223E4
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 07:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEB21514FB;
	Fri,  1 Nov 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wm+/LDTN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CC2154C0F
	for <linux-pci@vger.kernel.org>; Fri,  1 Nov 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730445369; cv=none; b=slNFG1h8bSRUAGWtLPQUh20HhdCWGM+TTD6jWFZOCJr8KZuJTH/PBMD4QxdeNsi96UpcAlWX/7n+HlDYi8/uNcf9rA9L5E3DTU1SwwLNXRSzO38hawWOOxlVZ199Tw0zis8kH3RaLlgx4bfbvVV7PlffMzkL/B/Ewo3UgFXNiuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730445369; c=relaxed/simple;
	bh=D9kKCU6Fhf2kjjszgcOh2hpl74PACyL8X9RgafA2PDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+V58y+fYLh7YjuGpQ9EvKw7du4NXxIV/fCe3umGBu1p6vIYyWm6URN4cahjrakKm8I3grhl41dGjd0n+DH7K4UC8vCgPht9fj59JZl/ExX0TYEMTw563SImsxGj5HBjDqj/FokKSFis0c3nOK1ufSR1/mXxDZxfzg1g5hoeCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wm+/LDTN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbb1cf324so14123595ad.0
        for <linux-pci@vger.kernel.org>; Fri, 01 Nov 2024 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730445367; x=1731050167; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NYu240j9MksEZkeTldMjgCKZPGZTXjvxvlG1i6B1nSY=;
        b=Wm+/LDTNEnJuBfiFBvfekMPSP8rcGZG6rYXWi7Im9fOP30PjEdscxmH8KJIIOLDHjJ
         JX1uE4jVka9cOxqlxkgr4V91M0j6SyBts37s8O2Vrzt9mAqvC639B5ItzmPfCRc6SE9m
         xJdT2uznUlyYeVMAiR5GkCdJ5yidC4WMtxIhrXXowQxySJqxcNUCE+2aBNx4qSfNdDvz
         5b1R0GudjacYUI0hKfuKbupaSCGGgJDLDpvtsMOJmJGVOGp6JPpkFL0L9k+va36mm9d3
         55Lvg7kSCe/CufTGC7h4ZVXMjmCjJqb34IBMVfvBWRbKvWakMx1YFUj75jCaberqzuZ3
         hdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730445367; x=1731050167;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NYu240j9MksEZkeTldMjgCKZPGZTXjvxvlG1i6B1nSY=;
        b=cz8/qxD73OjOVrbahoEhD9qXBQzqpiyTaliihHlELCXnMNw9rnw9jKgA8zdxVR40sN
         o9xl/N16Pm0l9Kge9GUB2vYuJAr8/+UtO5ZTuE2K8Og6suw89jAtCD+orRf/IJOnTKX3
         QuVfxBfSTEeYfagi8GWjd1YV7cMSTXaRiWBYuBKZHYOVwWKgZcvCF2zyoS1BbisDsgj1
         On2osDoLd0+SvIhdHuTvxC7FNBsKsUt0N9hlMSiKx1tYD+SlsJeyncNLwP7DcTbq8iK9
         YjiCMFsT9UkfQjIXNb7s0DPBkr7mGDZULSEUs7oq9zpMU8faalxv9JPq9vGoo+LQZJZu
         KIpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZCOJVoKVmdB6Yqcw62MV3rOz07/6jJ4YDkqF3Nap60O5X8WVB4ntWZLY3Hai7iG9B3jPPmlBI6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFTAdVh6XQcX4QPQweslef9anOsQ1RgZjTr7vxRTu3uqFOse+
	CiwOJ9ArVWtzfVmDk9Xk5kNV90T0I0gBh8hhXl02TVt+DMIyG4OXg25+RJ7jeg==
X-Google-Smtp-Source: AGHT+IHkJC5WAm3hZKcRBkYijkDLdFY9gmHmbds3J33GDElHPOzJOVDRQSlxlZrSiKU/YC+gQbbiXw==
X-Received: by 2002:a17:902:e890:b0:20c:8abc:733a with SMTP id d9443c01a7336-210c6ca8b77mr289398355ad.53.1730445366912;
        Fri, 01 Nov 2024 00:16:06 -0700 (PDT)
Received: from thinkpad ([120.60.51.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c1189sm17438665ad.204.2024.11.01.00.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 00:16:06 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:46:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <20241101071601.jxqc2nrmaqrx3lf4@thinkpad>
References: <20241017132052.4014605-4-cassel@kernel.org>
 <20241017132052.4014605-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017132052.4014605-6-cassel@kernel.org>

On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 20f67fd85e83..9bafa62bed1d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int aligned_offset;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u16 msg_ctrl, msg_data;
>  	bool has_upper;
>  	u64 msg_addr;
> @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>  
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  msi_mem_size);
>  	if (ret)
>  		return ret;
>  
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
>  
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>  
> @@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u32 reg, msg_data, vec_ctrl;
> -	unsigned int aligned_offset;
>  	u32 tbl_offset;
>  	u64 msg_addr;
>  	int ret;
> @@ -615,14 +616,13 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EPERM;
>  	}
>  
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
>  		return ret;
>  
> -	writel(msg_data, ep->msi_mem + aligned_offset);
> +	writel(msg_data, ep->msi_mem + offset);
>  
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

