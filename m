Return-Path: <linux-pci+bounces-4845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F8487C895
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 06:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FE91C21CCB
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 05:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469E1DF51;
	Fri, 15 Mar 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WO2KR7ji"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98820846B
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 05:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710481586; cv=none; b=EXPCYhQ5NoRyREIXTPZoiPhBS9b/sQU7LuM/tN/Vm8LDn/1IgCBkR29f9VI1o8NxkvlFae9lic9wojRyteO9O0Gu/Swofthc0pOOQAC6Z+5A+grM1L20SZeAb9X3ixST1f0fjr+0gL19HgeBR6jfvGVB2Xm0r6WaumQOG87CFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710481586; c=relaxed/simple;
	bh=9Kl0OBKdDFjf8cMj5tCqsHzRx7LMNUy71bPZNRlfbjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRNSopQD2ghTkmXg4T06CzMa1OSJxdCI9eqhmlBjZqGu/zeHQvk8cp+Tw53RIU/RM+ENtk/btZ/rIAnlnz5jy/394eVBmQBxRHD9pM7G01j21ZxHY0XUvDCitDnVfNmDKJuUY4Vj8BZy1zo7GycII12JY3O88TBG7jpTCBdo7Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WO2KR7ji; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c3775ce48fso159380b6e.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 22:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710481583; x=1711086383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OXCcWDukCyisGQz4jXAQxZulmhpme8v455rQusBXZZk=;
        b=WO2KR7jiqMu7aV0pd6BoS8ymbQX0SbhYhL/5dU/2DrzHsplImCxhygoSdzICJsWNzu
         g8fz9PaHHPFW9v82KFRLYU7DfWgX6ZDxou76uR6dhiYqnz3wcFcZ6N69KXhUFUauCltd
         EETtLgkbMLNCAtF3Nd/ygSC3i9qIhKMAoJXc3xhx3/qgelzBdSAW2rFCinBBW8BTGUHg
         WK07DtbZZCJ32I5WN5o6ase7DP4BQy+/jGnNeG6fyMwN2Ypsrezvab7q+mI7YYrG5yoU
         2w82D6tJoycnlQcNphDbbVm90QZLvSxFB0dPA9Sll0eDCWVmDynlBzQuC+MhL4KSiMtt
         qr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710481583; x=1711086383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXCcWDukCyisGQz4jXAQxZulmhpme8v455rQusBXZZk=;
        b=FkhhdRtOjAxi2CqOMYuGVsEUdBHzXCnuxTR554fDV8bL+yKMAbBXVIeYhC/L1Oq8d4
         HtTKtC01ivUA8YFKbqpqnXJU8hRrMzVMVm52w3miZpA6qPLzMG/Qlhr4zocqZOQBNigM
         lWbMczrWT8caioeKC2L8wEedRqEJiZv2/5qM25IiKsCcvM8/z5rtsyliO1MAuOaFijCI
         i3BdyrXLFap8qXd6XYeCcjSdqmRJFacFw5VroaVfAkBPPVg7V7LmJHt8rzzJLr4eZ6WY
         R39A/7q8A3cP2mUTXQTDlEKuspxyU367ZmVykF8SUJofZRwcopU7tXlEQ+ESvDdRuhPw
         PvNA==
X-Forwarded-Encrypted: i=1; AJvYcCUEdMgnFJZ8mHcUDKYDZuCSt3u5Uk5w5dvfnxgoMkkehZVhuvs0L4zkigwJEvi+kSCsLewKyn1O6qXWT78LDfPAGifT06Rv8nFj
X-Gm-Message-State: AOJu0Yzztglvly13EnNdtLFueoHHG5QUlVGIxAUHhGESUNKDPjuAA+7t
	+ECyPKYtMu6NQWLBBjc6Q7qigcNlkpF006l1n3MH+YUZ/wv6Qv3dp48eCSCOjQ==
X-Google-Smtp-Source: AGHT+IFLJKorf8NvnFZ6Rg8WVbrD72Q5OJAUZhFpKak51FC91Y4WxKgxktqTBlx5e4a58cHahvwf7g==
X-Received: by 2002:a05:6808:4c8e:b0:3c2:39c8:435f with SMTP id lt14-20020a0568084c8e00b003c239c8435fmr2848130oib.51.1710481582799;
        Thu, 14 Mar 2024 22:46:22 -0700 (PDT)
Received: from thinkpad ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id o14-20020a63fb0e000000b005cfc1015befsm1688718pgh.89.2024.03.14.22.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 22:46:22 -0700 (PDT)
Date: Fri, 15 Mar 2024 11:16:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 7/9] PCI: cadence: Set a 64-bit BAR if requested
Message-ID: <20240315054616.GG3375@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240313105804.100168-8-cassel@kernel.org>

On Wed, Mar 13, 2024 at 11:57:59AM +0100, Niklas Cassel wrote:
> Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> is invalid if 64-bit flag is not set") it has been impossible to get the
> .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> requested to be configured as a 64-bit BAR.
> 
> Thus, forcing setting the 64-bit flag for BARs larger than 4 GB in the

2 GB

> lower level driver is dead code and can be removed.
> 
> It is however possible that an EPF driver configures a BAR as 64-bit,
> even if the requested size is < 4 GB.
> 
> Respect the requested BAR configuration, just like how it is already
> repected with regards to the prefetchable bit.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Okay, here you are fixing this driver. But this should be moved before patch
5/9. With that,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 2d0a8d78bffb..de10e5edd1b0 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
>  		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
>  	} else {
>  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> -		bool is_64bits = sz > SZ_2G;
> +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
>  
>  		if (is_64bits && (bar & 1))
>  			return -EINVAL;
>  
> -		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> -			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> -
>  		if (is_64bits && is_prefetch)
>  			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
>  		else if (is_prefetch)
> -- 
> 2.44.0
> 

-- 
மணிவண்ணன் சதாசிவம்

