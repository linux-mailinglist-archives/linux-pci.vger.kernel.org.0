Return-Path: <linux-pci+bounces-3843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A5185EC98
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 00:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10FFB1F230A5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 23:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0694F85290;
	Wed, 21 Feb 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BboIDRIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B93EA8E
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557238; cv=none; b=UrENEgzM8xDsdWu8lVBFGIySrbGQ/zFFOcDTB3Ji2eRwjzoGPVSTObPHMnV7UK/SUjD4qeOQwB7Pwe5lWOX6hvnllJDSHffav3OMzedEfiuMlES6zo4TfQIyMid9YFGx5+wa125Gj7pZGl8F5HL4RchnEFYstgA7GEroNzXs9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557238; c=relaxed/simple;
	bh=vzKvZINe962Zjudqy358JK2X2+MTqkxR/Yj7DAgEZDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQflA0SilnkWqY2qJiF7zRDZ2AWmdHKafCPZFN+f26DapGop6B8qvWROw7z/iSnJcBSqX64foSd1Zz0KlBL9absiHnu1AE2FQQMd83IErsO3juUBomhZq6M4Q0+v5IT2uBtsSEF8NPQDPJt88M5CaFna/O8vaMPL/4ry9I+uY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BboIDRIY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d89f0ab02bso20305ad.1
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708557237; x=1709162037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=55JIFvKqCwK94dHrCaX/HsKENxqUMB89KHII77rnXgY=;
        b=BboIDRIYU//Ra23fWHkzyVlYNrnJPsafBOvxUEsBM4/Cdw7jZ+2YE4/9cZHEcG7/WZ
         jQZ2OOAmt6YNuSWgl96ieZn5pQMpxlnCCLoB2C3eReqyxMffgHFKt2tvq+X2uh+CXzt+
         O2Le15tCAV4cAyhdhNQhOX9WNvuO8WJ2CYpDdvUmizfAs1TtGMMRJ5sAbdm9etke6vH4
         XNHESjixlJd/5ViW/eRie2Vh9xOHPjCB4VUDzN99+9HjxI7KO2DgBczMMIGyqCOKjixQ
         kRPn4sMekTL5ZZJXGKQUWc+vd5mEQ71TC6MLbZkxHFbFaozA4q9N40VrMr9A7jkRJ1DE
         NgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708557237; x=1709162037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=55JIFvKqCwK94dHrCaX/HsKENxqUMB89KHII77rnXgY=;
        b=iSMH6FhX8MROcJS4Ca3s/hmHdUjoUFSMCH6g/BxiGGRwM5pWTIgWydHZVirprw3qWL
         toA5lisXruDSRMH5Xn9hmnvT+Y0K7Y4/OgObIqPG0uyqlDpOxx6XWZKgsuY1F+3Y2wau
         1Ia8BuO4Bea0m7zRROp0Hzd+4xM2Y9P0L0NM+DQyFt9EZWnuWXUHAxsGBzqtcexS9Trm
         LnaQW8vm3ZrrR0ySyBn89UrZOjIdKSvLO4YPh8VasffmTun4ZEbudQk/WThIORHvAywA
         XDUCRCUbzEzHNsjt/SudX8tCMQUx80xq7VRFkJjic6js6HRNDHojOcMf1xh+vEVztDWL
         9oQA==
X-Forwarded-Encrypted: i=1; AJvYcCWM6Z/f7hWsE8Slu78jdk/8CTXDEkpRDsxJhEL6srJSp8iVJa78bPiIUlXZHSudI+FZjY/8UaP/Yu1xvtUw+bQ55Pn/1fkcutrF
X-Gm-Message-State: AOJu0YwZZkzROw9AXdcstFJVaVNO3848X+rw9Nya6lAYPjF9wABN3Wff
	2rCqRLUDG1Vw5o0pPy2r0Yl4icsm7K7h1vrJv2zgLQyfYwIfS0U0u/ycFoF49w==
X-Google-Smtp-Source: AGHT+IEBs7JrnZVS+NYGuA8Ni+NlvcB5pRiH7hZtukzJO7gm059L+nE0FCzi7zGpChm5YCVJxurojg==
X-Received: by 2002:a17:902:c703:b0:1d9:310c:73be with SMTP id p3-20020a170902c70300b001d9310c73bemr305251plp.13.1708557236388;
        Wed, 21 Feb 2024 15:13:56 -0800 (PST)
Received: from google.com (69.8.247.35.bc.googleusercontent.com. [35.247.8.69])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902e9c600b001d706e373a9sm8580938plk.292.2024.02.21.15.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 15:13:55 -0800 (PST)
Date: Wed, 21 Feb 2024 15:13:52 -0800
From: William McVicker <willmcvicker@google.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZdaDsN675hiS6zhY@google.com>
References: <20240221153840.1789979-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221153840.1789979-1-ajayagarwal@google.com>

On 02/21/2024, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses.
> The current implementation of 32-bit IOVA allocation can fail for
> such platforms, eventually leading to the probe failure.
> 
> Try to allocate a 32-bit msi_data. If this allocation fails,
> attempt a 64-bit address allocation. Please note that if the
> 64-bit MSI address is allocated, then the EPs supporting 32-bit
> MSI address only will not work.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v5:
>  - Initialize temp variable 'msi_vaddr' to NULL
>  - Remove redundant print and check
> 
> Changelog since v4:
>  - Remove the 'DW_PCIE_CAP_MSI_DATA_SET' flag
>  - Refactor the comments and msi_data allocation logic
> 
> Changelog since v3:
>  - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
>  - Refactor the comments and print statements
> 
> Changelog since v2:
>  - If the vendor driver has setup the msi_data, use the same
> 
> Changelog since v1:
>  - Use reserved memory, if it exists, to setup the MSI data
>  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..d15a5c2d5b48 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -328,7 +328,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	u64 *msi_vaddr;
> +	u64 *msi_vaddr = NULL;
>  	int ret;
>  	u32 ctrl, num_ctrls;
>  
> @@ -379,15 +379,20 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * memory.
>  	 */
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +	if (!ret)
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
>  
> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> -					GFP_KERNEL);
>  	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;
> +		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
> +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to allocate MSI address\n");
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

Thanks for working through all the kinks, Ajay! The patch looks good to me.
I tested it on my Pixel 8 with ZONE_DMA32 disabled. I wasn't able to reproduce
the case where there was no 32-bit addresses available on boot, but I did
artificially test it by commenting out the first call to dmam_alloc_coherent()
to exercise the fallback case where msi_vaddr is NULL and the 64-bit coherent
mask is set. In both cases, I verified the PCIe device probes successfully with
this change and wifi works.

Feel free to include,

Reviewed-by: Will McVicker <willmcvicker@google.com>
Tested-by: Will McVicker <willmcvicker@google.com>

Thanks,
Will

