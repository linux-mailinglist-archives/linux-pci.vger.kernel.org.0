Return-Path: <linux-pci+bounces-14193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C649988D7
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB861F25490
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22061C9B67;
	Thu, 10 Oct 2024 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZXPTbhU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DB21C8FD6
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728569438; cv=none; b=NjHcDktoi5nQfWw8idSyNC/hY+ViSDhzdNSNmqo40/gfNF8Kwc1YMCtEdk0rjUDHTaQNqnklLmMVXq5921IUjjeQUqiOKS1e8MH1qX+AsY2CHXC42b7wL2O9vk4Nbvw4WgkWKdxKQx/KOA3JkZFYxbqrBO0fhpK541SG+8Paa9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728569438; c=relaxed/simple;
	bh=MIWus4AikIXF8Ds8JP2d7UuZ6R0SGQw48OMa01u4sy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfUviXfhHNDnVpPpuc4PcA9appbsQmYim3ji5KYKFomvo2JQ43fcjyv1EQKLDJC13JxB6ZwDize+UdCTaigspxvt7RnawqaFPoAtJRC5S4USdltYvMISrFe4B9IODo+P2iuoAKZ+reldKw0kVGrYBCWNvdlUCbady6eAXof1yMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZXPTbhU; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a0c8b81b4eso4224165ab.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728569436; x=1729174236; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j6OzBykZDvSRfwEOuaXOs3NxkQ6/TznhHqIuRe5qjUM=;
        b=OZXPTbhU9GmjOPGH0tfggUnNXEvRWQfHO2u3MCPIny0Ime57n0P5GzRx3F+Reuf0g+
         oBaxpanTW4R69JrGoRdbE6bvZMzrxm1k7EcW4YOxbRdlNlweLEkQYCl4FEJ1Aixzv8ts
         vvq/6J4hIS4xUS3ucCPmMpXAtVuFj5rkRIC3sJUuwrBY4wsgRgtiD39rIJn/yRnlWiiS
         m6/PM3tegHHjpQD5D2s/F3iRXegxZ/bPd8YYhppD3FAbN9QQ14uvI4OnE3/l7/1u4RNM
         OhIXkiVBNKGPCUbvFP8/pqQImUXdmjmgugguY4uQcUl3v7b8qOfPdIaugw34YKBeaU7k
         IuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728569436; x=1729174236;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6OzBykZDvSRfwEOuaXOs3NxkQ6/TznhHqIuRe5qjUM=;
        b=Jl3E1PkbseDf68aXQdfC+zvl+6gxoTTR1K74rhPPezbDnI3XSE/pVSkQKw2pJv/cYw
         o8nrcP20vR83uEWDmVCMI6iuiJiqKEg4FcTGvAj8hkCyPraOVguhP0ajLjx7v6Yow+kt
         HfrH6pfiGXEutpaoB0o7DP541CBzAiKDe2Qgsgd3rLWXJ8fUua2t5/u8S1/kSAGxDZCb
         oOOakexBcX1Vs8ftQDILjPxIdIWH77LTbXa9id2b8bM7TQSMXy3gdi/qG7zc3YpvxYWv
         gDWunDknXHOBm+8oLczllwEV165IF81ZM5cEqxYO1S0rTlQRPxz6rEEea5N+WTEDpggq
         hjBg==
X-Forwarded-Encrypted: i=1; AJvYcCWG1jiGO/HvISVdQdHrzy8+wOWavPhxHQgNza84ZMBLL98Sgf1QME/btii85nM/pWniu/W/iteTFHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLNZRy3hCQmqcyyqtU5QdYmAMZH3++YJGSytqb0LKP40It5UHW
	aXD/Eui7BQjc4T01yf4aC6lc6j5UAlknpY2lZ/TgPCsL2w/15UBkmwh81dfnOA==
X-Google-Smtp-Source: AGHT+IGkaq4cXguxjWr6ddngE5j+zzE1jQG5GM6Q3KhBXmPcCyPHZFdAUFVhm3tQ7tQh8Pv0omUinQ==
X-Received: by 2002:a05:6e02:178d:b0:3a0:8d8a:47c with SMTP id e9e14a558f8ab-3a3a5cd5641mr42271715ab.14.1728569436403;
        Thu, 10 Oct 2024 07:10:36 -0700 (PDT)
Received: from thinkpad ([36.255.17.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea448f93f0sm1069748a12.32.2024.10.10.07.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:10:35 -0700 (PDT)
Date: Thu, 10 Oct 2024 19:40:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Improve pci_epc_mem_alloc_addr()
Message-ID: <20241010141029.xsk6olgcenba473d@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-3-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007040319.157412-3-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:03:14PM +0900, Damien Le Moal wrote:
> There is no point in attempting to allocate memory from an endpoint
> controller memory window if the requested size is larger than the memory
> window size. Add a check to skip bitmap_find_free_region() calls for
> such case. This check can be done without the mem->lock mutex held as
> memory window sizes are constant and never modified at runtime.
> Also change the final return to return NULL to simplify the code.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-mem.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> index a9c028f58da1..218a60e945db 100644
> --- a/drivers/pci/endpoint/pci-epc-mem.c
> +++ b/drivers/pci/endpoint/pci-epc-mem.c
> @@ -178,7 +178,7 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
>  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size)
>  {
> -	void __iomem *virt_addr = NULL;
> +	void __iomem *virt_addr;
>  	struct pci_epc_mem *mem;
>  	unsigned int page_shift;
>  	size_t align_size;
> @@ -188,10 +188,13 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  
>  	for (i = 0; i < epc->num_windows; i++) {
>  		mem = epc->windows[i];
> -		mutex_lock(&mem->lock);
> +		if (size > mem->window.size)
> +			continue;
> +
>  		align_size = ALIGN(size, mem->window.page_size);
>  		order = pci_epc_mem_get_order(mem, align_size);
>  
> +		mutex_lock(&mem->lock);
>  		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
>  						 order);
>  		if (pageno >= 0) {
> @@ -211,7 +214,7 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  		mutex_unlock(&mem->lock);
>  	}
>  
> -	return virt_addr;
> +	return NULL;
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
>  
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

