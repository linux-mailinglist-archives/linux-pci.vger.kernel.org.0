Return-Path: <linux-pci+bounces-4728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E78785DE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 17:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FE928133F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C49D405DB;
	Mon, 11 Mar 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXeLvoBY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0D3C6A6
	for <linux-pci@vger.kernel.org>; Mon, 11 Mar 2024 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176321; cv=none; b=H66QfMjbtk+9B0Qr4ISvfQrz3Kfcnst2joRJ4iSm04AqgQvuTxIZm9TzInafPijoOLN9GinRuYgPHZDnGw9REg49n5s3nvmOv9IiEkz1DXVc3hB+F24hisfcdPhWfv6KkJ6YGDhp+ijJg4CfimR4WVRyGRG5tWKeaJbLbmkszEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176321; c=relaxed/simple;
	bh=jOUNnWt+9ejC0OL6sH8TQinGDFXWuJCuoXbX886q9Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZpRDFlc38KeOwZ8afN3tY6qVprDDzv7HxgXPVOseFifGmJzirdV3ypDMpmyyXyyIfLm6JWVTDKuFug1venA67sjtA5WkiLxVncact72iKlFNZQtGOA5G/c3dwsolkJuajpLVw7Z4flkrt3jpkqbNtF85ARGmJT1Maav03eXASIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXeLvoBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4EEC433F1;
	Mon, 11 Mar 2024 16:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710176320;
	bh=jOUNnWt+9ejC0OL6sH8TQinGDFXWuJCuoXbX886q9Tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mXeLvoBYt2XI5Dfostv88puWOpRnOV3U8rsgKc/T7kg8hUsjJJomlQ/+x2Zn+v6KU
	 Wvqy430BEk008ap2V2HItlELAqN0hvo/1zjr6R7YPJEw+tOFfsllY/q8UdKfPJmen4
	 a65KECFwLk0+aa0gqo9xbUx8WugVuiylIZ1lU+uj1wyD7ROJ+Rj76Y9UuH4HQDxCzP
	 nsMAA+8r7jF6RI87030GsxHNwhIeLma3ybhMJJWmXe0QE36z4MrCmsRP3j7DcpPRIt
	 RhQIWXvfp9lCm0hYp74YbCFrTWZ27pimATmExVK+NyIhyn3yHwnEX2hrXYLbjhUJ2B
	 Ecejy+u+JbKkg==
Date: Mon, 11 Mar 2024 11:58:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20240311165839.GA799766@bhelgaas>
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

What happens when we fail to allocate a 32-bit address, we allocate a
64-bit address, we have an endpoint that only supports 32-bit
addresses, and the driver tries to enable MSI?  Does it fall back to
INTx?  Fail the MSI enable?  Emit a warning?

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

