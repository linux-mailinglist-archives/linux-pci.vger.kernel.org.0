Return-Path: <linux-pci+bounces-3430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D759A854347
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 08:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5CB2860FA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 07:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D02111B0;
	Wed, 14 Feb 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CahuPmZP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8658D111A4
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 07:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707894531; cv=none; b=BxHQE0F719FMgCaO1tOC1+Uzxh4tCLh3rVdSdiDA3Yf009beoaeyq4q+VIIBglJw2qtGY4fZvY/FUaQszkggEMmuaMt4J1XwRVBzgbKry247VO/EE9u/vcKqbtUBrEC9wTve0xLhedIGtEUadGUYPMdSXOW1jsjgsRb9lwOfMEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707894531; c=relaxed/simple;
	bh=6bEvhsqJkCXEROCHQg/tAO47BCmkEhFbjMv7nQWtl5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVHS7Y2x2DCt1CANmD6KhAh9HgCQEV8TyxgjINHlxww/k27scQ2/Pj7jbD1vN+c0CHJ8IRFV3ewDEXekoo4LWR//iquv5x5if8F8te0aq2I+1wZdqIEIpFfgD1I1ZFKkQeT861FygWVP7yYpcJIvHirhTkHnM69d4CHXvXAUSC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CahuPmZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923FCC433F1;
	Wed, 14 Feb 2024 07:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707894531;
	bh=6bEvhsqJkCXEROCHQg/tAO47BCmkEhFbjMv7nQWtl5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CahuPmZPsVmkWubc6Lw7nPpFMQHKQb8ahF+hKqCp3ArDgRw22LfEAMdDxGa1kCAXt
	 1aCNmXswCwiYq/Ajstxr6HbzBY80EYqL+6jtNEy9YNYZUgwa/amZZYgW3qulabwr5m
	 LwFmZWoOX77dDSs8TX43h6vNeB3IM2rZJJjkw+mvJFb2L0pZlrePmpJlX5ZBRjXwgA
	 KBSmlTkRYpg8sbWUE9B0qScbSvfjnNuVoaPxyXH1T8A7jzMfL3Kuq4a3t22t+Bu8mY
	 H5+j5ZC7nCVCdCP7UZt5E6tpvwyKhbE8pS2ZdUDwc1Ryn0PoTV10lOtkUnHIEaN1Au
	 /9KhLvWVuaNOQ==
Date: Wed, 14 Feb 2024 12:38:42 +0530
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
Subject: Re: [PATCH v4] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <20240214070842.GE4618@thinkpad>
References: <20240214053415.3360897-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214053415.3360897-1-ajayagarwal@google.com>

On Wed, Feb 14, 2024 at 11:04:15AM +0530, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses
> but want to enumerate endpoints which support only 32-bit MSI
> address. The current implementation of 32-bit IOVA allocation can
> fail for such platforms, eventually leading to the probe failure.
> 
> If the vendor driver has already setup the MSI address using
> some mechanism, use the same. This method can be used by the
> platforms described above to support EPs they wish to. Such
> drivers should set the DW_PCIE_CAP_MSI_DATA_SET flag.
> 
> Else, try to allocate a 32-bit IOVA. Additionally, if this
> allocation also fails, attempt a 64-bit allocation for probe to
> be successful. If the 64-bit MSI address is allocated, then the
> EPs supporting 32-bit MSI address will not work.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
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
>  .../pci/controller/dwc/pcie-designware-host.c  | 18 +++++++++++++++---
>  drivers/pci/controller/dwc/pcie-designware.h   |  1 +
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index d5fc31f8345f..06ee2e5deebc 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -373,11 +373,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * peripheral PCIe devices may lack 64-bit message support. In
>  	 * order not to miss MSI TLPs from those devices the MSI target
>  	 * address has to be within the lowest 4GB.
> +	 * Permit the platforms to override the MSI target address if they
> +	 * have a free PCIe-bus memory specifically reserved for that. Such
> +	 * platforms should set the 'DW_PCIE_CAP_MSI_DATA_SET' cap flag.
>  	 *
>  	 * Note until there is a better alternative found the reservation is
>  	 * done by allocating from the artificially limited DMA-coherent
>  	 * memory.
>  	 */

Now the above comments are misplaced. Please move the comments related to
setting coherent mask just above the dma_set_coherent_mask() API and keep the
flag related comments here.

> +	if (dw_pcie_cap_is(pci, MSI_DATA_SET))

Who is setting this flag? You should not add code when there are no in-kernel
consumers.

> +		return 0;
> +
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>  	if (ret)
>  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> @@ -385,9 +391,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>  					GFP_KERNEL);
>  	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;
> +		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");

This is a duplicated error log.

> +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));

Is there a guarantee that this will never fail?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

