Return-Path: <linux-pci+bounces-4129-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7030F8698F7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C3E28525F
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C11419A1;
	Tue, 27 Feb 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd5j8wCR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666213F016
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045130; cv=none; b=sP0XzQgMlJYITbFEa2ijXUQm5KKsXr3Kx6L00H5o+4M1r1o+uLzCTRjlmQQJZEId8Com4c2LcvmPel71NAraXRdWD4ksAd9wrPpMgCesvwMWGrgpqeWuFrPbGsVyfvqvMX/1lHG1f/bq+469CDc9/yTjPQegw2qoJJ6YFuc5DJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045130; c=relaxed/simple;
	bh=DVoVH51u4LdxcXpNHtTvCJPGeJIeHqnFROiXTf1R5aU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP1Kgl1uyTZZa+uSjjz40VroHGQpxbeAda4xP18adLx90DqcsOFU4hfmOXxXhgxV0dpDqGPQMKLSZuFHxojziTuZ1VT6gQdRijRzbRqAdgknqi3LPf8qnzp9SJqE1lnAWvDaKt11YP0Zt6lQtTK6NVpk6Yb5WsqqzKzPQKyBMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd5j8wCR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A6EC433F1;
	Tue, 27 Feb 2024 14:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045130;
	bh=DVoVH51u4LdxcXpNHtTvCJPGeJIeHqnFROiXTf1R5aU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bd5j8wCRCgOumbrK06Woc/l/1o8kWoA0s/jhzNfBH7NNeE2LOcM5xyTcXQguyomYD
	 7wirPmhpiJaD+okIMLTKW88HK4En3bVAhMfjOADmgTYSKraySQ/QaTQ+nRIlIyCguP
	 rsaPdcZiokx+N4f94Kwos8ywKTmaeVi6M3cRAbhUChIZfT8OCzZ3uGl+rkSrLCauwp
	 boaAbC94RGPxLpHu7j10S4x//HZl/VuTfK7Fwh/ob98ssceP6DCTYXzBa5tHSqZnRu
	 Sl55cWNFJNMSfeCuHVZK85Merq+eJM0hE4RUHNchJR5hYUlUusu000v7in/4EE5UQw
	 7YAiLtTjfsVLQ==
Date: Tue, 27 Feb 2024 20:15:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <20240227144515.GQ2587@thinkpad>
References: <20240221153840.1789979-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

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
> 

-- 
மணிவண்ணன் சதாசிவம்

