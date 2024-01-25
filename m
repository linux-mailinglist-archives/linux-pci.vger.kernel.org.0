Return-Path: <linux-pci+bounces-2555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8320183C97E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4C81F21E15
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 17:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E413BEAE;
	Thu, 25 Jan 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gxnmfUgS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388D13BEB2
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202223; cv=none; b=KECyhCw+APa1DBxDXjca1UOhi0vy8ww8JklV9gXrVXRY9eOkW/JXtI+Oa1VZ+sINxDM+r13pT1hoNHz3S9htxUzCxra9QMehEvZKV7+FDiIrakMm4d5j25eeFQaA8KxktMHQ29ujlcEFFXu77XKeDacGGBEk/HOQPI3Ha00Z5fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202223; c=relaxed/simple;
	bh=EtjuxVfRaMmROi8vU5EKNyZbFHvQzfftjUCQ1eYs2Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amMfAslO4O2QvkP2EyffbzwSX7HdbQUA8MwCZgKhkifJqv4hKRBytFQ88bdIrbIP1slAmnVl78+3EMjoBvz/ZhvCPtBjrygsBkyEaWcQftSkKXwR0nxEwObiXwrFzt457IgmVJp6b+4GyKNFToDC9j6irZlflqbt6tK7I/qCE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gxnmfUgS; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso3406535a12.3
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 09:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706202220; x=1706807020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c23ZTeIVxs6yEnWydo0j3V6m4oKMAUU00aaWAQnKjog=;
        b=gxnmfUgSAiyPTtVHdomyCyCTp10Zhrx+hUqhaqyi4zmyHpa+rNbSO3yHHqPsVPpNNm
         6iJ4YQnpPLASme479i4S0gI+xXqiY67GMO8JO9FuYkBTCmeTSM58O++OxYbpx+gweRHe
         WgEbfQtxF+M5r2a3d17P+eUeLrKiabZ0JC1mt4Q5fKg73Kml7DywI30NAyIOHn4UvjHr
         6DTilvtTemupZ5BgdMeCe+IpGHfqlbV8LFjISjHDizXsmJPt9Uv0jifz11Nj0+2Y4PyQ
         9umNfDYvtt82KkpjC/K7sEXP6BHu3KLOLJS/ug3bDeKp+vVTMzquUS5xjbWktGozRa0K
         u3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202220; x=1706807020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c23ZTeIVxs6yEnWydo0j3V6m4oKMAUU00aaWAQnKjog=;
        b=KHIL1VhBwvUcALOsb93qIhJ7gATDOvwcSziavOpIKJUW5J4+gQJLzN+pE1mvFX9kco
         L5Ksxq0SwmXZwaMC3fYpSBdQ+cvym0lEw3w2wFDP/Ble/YkroQQ96R5wJ5hAqA6ELL7t
         PwGwBCe16wHZeJETMMkzoBfHAUfFC+1sycIy3VgIdI3Wul3RJiMCXrya/Tut06YdL379
         y1wATgsekTxTW9uPUBlY/Ljxe19/dzjf8KlA+DHP8nDzvGkk8B2KVsIbUkdTm7KJPq9I
         ZgWHPFllIsZ9HsWNAJHtcGEKBZuYsfg/ETeqlRlMLXOmCJp0MKAY/WaQCKrUwIUCrrnM
         70/w==
X-Gm-Message-State: AOJu0Yx+NV/ZYou/4PPU24uK0Fgm4IGyGnqJcP6Ho86rbVd0SK4nErZh
	1d1Cv9piOV699X6XKf5I0IJGBBm8eKvkG3iXh1b85poI4l6kPq6cMr7/Lrk+Iw==
X-Google-Smtp-Source: AGHT+IFb5JGtW8dJ+mUO3mIA3dSMaKRRrd77+BxY9Bk/slj5Q2gpOozeiZOOGGMJe5dfpWi69/EH9A==
X-Received: by 2002:a17:90a:6fe2:b0:290:2844:50a9 with SMTP id e89-20020a17090a6fe200b00290284450a9mr1107862pjk.26.1706202220345;
        Thu, 25 Jan 2024 09:03:40 -0800 (PST)
Received: from thinkpad ([117.217.187.68])
        by smtp.gmail.com with ESMTPSA id s17-20020aa78d51000000b006ce9c8c4001sm16075282pfe.47.2024.01.25.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:03:39 -0800 (PST)
Date: Thu, 25 Jan 2024 22:33:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <20240125170332.GB6390@thinkpad>
References: <888c23ff-1ee4-4795-8c24-7631c6c37da6@moroto.mountain>
 <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64ef42f0-5618-40fd-b715-0d412121045c@moroto.mountain>

On Wed, Jan 24, 2024 at 06:03:51PM +0300, Dan Carpenter wrote:
> I recently changed the alignment code in dw_pcie_ep_raise_msix_irq().
> The code in dw_pcie_ep_raise_msi_irq() is similar so update it to match
> as well, just for consistency.  (No effect on runtime, just a cleanup).
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v4: style improvements
> v3: use ALIGN_DOWN()
> v2: new patch
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 51679c6702cf..d2de41f02a77 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -482,9 +482,10 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
>  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
> -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> -	msg_addr = ((u64)msg_addr_upper) << 32 |
> -			(msg_addr_lower & ~aligned_offset);
> +	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +
> +	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

