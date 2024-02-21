Return-Path: <linux-pci+bounces-3835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC6D85E4A1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92001F251C5
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 17:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8309C82D9F;
	Wed, 21 Feb 2024 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1o6dMFz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208581737
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536784; cv=none; b=rMdRaVKf9TZFVqCrGdzmiBYX2gXpEx42XSvluyD64BqUvRaaL1Lxz5OC464/quPSy+UBiPuQ96hUIHdarREOOXD+4i1CkhoH/BTZdRanDK07mg3F+2OdiQAEJsnNbdWptmQMWrsgmi5/G2kl+K6t2VqkMWJKddU/SvtDdEIjfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536784; c=relaxed/simple;
	bh=OMsPDkawTUCI2KaH0zmfsV3wLNgl2mRyjDHO6yHU1r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3mYBfoafFAexA8L22pruYlV+Tm1yiTPvu77wiDnXWRiVkPcPsccuKp+XsHCRTaHW+XF5uj1BTG7fjz3w3ZRl9JjIVupWqAsI57uuqVoeiHoew5ruYJRENpdiIXuUXsPv1FnaRTfSKoPWekKaGWTGrBac5hLHG0+kjv3dYaPlJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1o6dMFz; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512d5744290so861016e87.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 09:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708536781; x=1709141581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FFiTqD9jqMstGNrGAiCi3vBor+d2igePV6tJUi8N4kY=;
        b=H1o6dMFzitMx9RLb5PKbnb/cPj/DKfTG+8811u3XEQiZydl6jX6Gs7vmmRWDpcYPgy
         0Up1Vg4ii0O+cyN87uysrZxnBuUnMwg88/bIAkp/2xN22XO06+DGy/5XCDHG78gRizTT
         U1wq/oUiBu59rVxmKjYoiMWjjppcm5I+8ckU4O0jhj2b2xnAqCGOQM8tlM/vMVj7RdVc
         VpIoDXl6q6scOh3A2HQpeStlJ3XYbEAHVAJk0WFKpXtDgCH5JwBWXUWpqJxvI4z4G/oi
         UeynNgtk+xjOoCXdiuQVyn8FuVCR3jLne+bscej1tXgw9gqsTNHOGvq19rmped3kokJZ
         BZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708536781; x=1709141581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFiTqD9jqMstGNrGAiCi3vBor+d2igePV6tJUi8N4kY=;
        b=YsAplFIWtTcjLRSU+h4U71OCUFh/Et1+PMcxTf+YhF1qffsEQqslI0CYRAnNDLHF2O
         MKu2zXObLHDC9h4X5lQVKEvzfueTfWvvpL/UCjWHeBA5+c607nT3Hg0Z+6ZEDYkNnyuB
         gf/63IFXwc5oM4k6pyoTV9psZ4uu3hV/aQz4ur7EwkWty4KjT1VY0fI8DquC15nwgl9H
         8lPJwh9ycl5kM+/OPhi/sfQVU/68NYMptP2/E7JvJEklriKUsgnIJNXBFUVj7d6p+wMn
         OIDKl1IJHDpm6+0WXHHfD7UNLqgFv3/eeTIzQzi693g0pAhfx3cJQBwiHtK7f1FpwyVB
         3Rjw==
X-Forwarded-Encrypted: i=1; AJvYcCWqM/2mh24vtRxZn11ER5MVRYcdcmUrcPAbfMKmhCTfjuquq/j1CGL50FiBL0o5wdsYE4W0ot2mzesMvOOVExBOJkl1Lym4U58V
X-Gm-Message-State: AOJu0YzsOfKGiCuwFMOR5ZPabvCLg1FBtiPMuQ66MFx7PoMI00fY7bz9
	bK/rfg/20ayMyKtHU2srtQ1Q8NiWrMUGVHNazJzGHVLWtlUwTzcx
X-Google-Smtp-Source: AGHT+IErosB8ALdePQl7HufTJpsEzDv9t8F1Ibcvx6w8A3zECWL41ixwWwLtQqSuJsNQIyTjujNRjw==
X-Received: by 2002:a05:6512:318a:b0:512:cb0c:d984 with SMTP id i10-20020a056512318a00b00512cb0cd984mr4402799lfe.68.1708536780555;
        Wed, 21 Feb 2024 09:33:00 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b00511776d214fsm1730352lfr.269.2024.02.21.09.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 09:33:00 -0800 (PST)
Date: Wed, 21 Feb 2024 20:32:56 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <aa2e5t63sbuqqnoh3ew6sy24gekozlght7bf3xxetqunvdq7uf@4mn6h4aabvwj>
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

On Wed, Feb 21, 2024 at 09:08:40PM +0530, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses.
> The current implementation of 32-bit IOVA allocation can fail for
> such platforms, eventually leading to the probe failure.
> 
> Try to allocate a 32-bit msi_data. If this allocation fails,
> attempt a 64-bit address allocation. Please note that if the
> 64-bit MSI address is allocated, then the EPs supporting 32-bit
> MSI address only will not work.

LGTM now. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

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

