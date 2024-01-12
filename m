Return-Path: <linux-pci+bounces-2094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DE682BE10
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 11:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212E8B211A4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 10:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8219557310;
	Fri, 12 Jan 2024 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJFUuC5a"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85425D8F4
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd2f472665so67886841fa.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705053869; x=1705658669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XBcGK2syEZl20W5ZI7UH16GWhJlkkz3OJf6IWgd3bLI=;
        b=AJFUuC5aXOZ8mdSdXABwI3sxVJEOwjKdblndCsWXDEPZGSOS5yFJJLn/D7qbXN2eK1
         dUPNXlTA83mEEUtrC9QCw+hiaBeo+GSEpNb+HrqlsNMPHn5vjJC/EKtXWi4BJo+9Mvfi
         GeWEyLK5yQz4B0auKC/nKNexRN8X1/+oz704BiWQMXWdUEPEVjBtGTCZndHhTCzcflws
         Z6gzJo4fGkRKPgJSAXCH2sMWQff6pTJgF1gsZe78PEfdnxEWu92r7hRRVxJQ8+n/tqut
         4yg44h+/zqaS6KkqAbEJqWK2ngb3cO1WULXAW6cfZG31WvuEhTSeaVfL94WsPulQzg/E
         t96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705053869; x=1705658669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBcGK2syEZl20W5ZI7UH16GWhJlkkz3OJf6IWgd3bLI=;
        b=vahopKynkF5n5ccZxlC2TWUIh/mgZwFgvKxVnVrrY/lUgwXLPgdJ9+mBY6RCDn4QYn
         vNKjLUdRUr107FIqamXyF2AwyidGdF772AVUDkcSs5fpCETJNMgWQkfV9UNs2/58JOhZ
         rbxIz4AcMYs12ADdBOU60L3G4J+FQLILqennhMtr4hQ2Oi6IOIqd92oGEPvWkd238u74
         Y/SolmVOG+L1bCdk7dtWJNxY9bwkXzGJqDE3EjrFT3Bxm20xtS/SaLCsW1yZ+UI/JYp1
         Xg9RJxejZX1NyVa8Kyk9NWHlOY6tSexRcd/Z/bSpslbShomunrLzxoIGRL1upceZZSxN
         m64A==
X-Gm-Message-State: AOJu0YwLQ2qGLKEgEwdaxz56jvvE5B6MpywiLwCOggeU9TYI5YOgocbX
	2OdjMeqV9oOEftn+BlD85fk=
X-Google-Smtp-Source: AGHT+IG6glVRlZSCq11vBHMsKx1BVzkf/OLxSVN6f/USCBmAc9jmCdjDXjItMAlNqO3XJTVRLRz+KQ==
X-Received: by 2002:a2e:870d:0:b0:2cd:cf7:9b4a with SMTP id m13-20020a2e870d000000b002cd0cf79b4amr596852lji.73.1705053869257;
        Fri, 12 Jan 2024 02:04:29 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id m14-20020a2ea58e000000b002cd51dfe317sm410628ljp.117.2024.01.12.02.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 02:04:28 -0800 (PST)
Date: Fri, 12 Jan 2024 13:04:25 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <whpdxeilgbishmdb5d57h2qflg4hbd5mzltidrhcoeygvmshhb@bwg6b2ocphd7>
References: <20240111042103.392939-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111042103.392939-1-ajayagarwal@google.com>

On Thu, Jan 11, 2024 at 09:51:03AM +0530, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses
> but want to enumerate endpoints which support only 32-bit MSI
> address. The current implementation of 32-bit IOVA allocation can
> fail for such platforms, eventually leading to the probe failure.
> 
> If there is a memory region reserved for the pci->dev, pick up
> the MSI data from this region. This can be used by the platforms
> described above.

I don't like this part of the change. Here is why

1. One more time DW PCIe iMSI-RX doesn't need any actual _system
memory_ to work! What is needed a single dword within the PCIe
bus address space! The solution with using the coherent DMA allocation
is mainly a hack/workaround to make sure the system memory behind the
MSI address isn't utilized for something else. The correct solution
would be to reserve PCIe-bus space memory for MSIs with no RAM behind
at all. For instance, if no RAM below 4GB what prevents us from using
the lowest PCIe bus address memory for iMSI-Rx (not saying that IOMMU
and stuff like in-/outbound iATU can be also utilized to set the
lowest PCIe bus address space free).

You on the contrary suggest to convert a temporal workaround to being
the platforms DT-bindings convention by defining new "memory-region"
property semantics. This basically propagates a weak software solution
to the DT-bindings, which isn't right.

2. Even if we get used to the solution with always coherent DMA
allocating for iMSI-Rx, I don't really see much benefit in reserving a
specific system memory for it. If there is no actual RAM below 4GB
then reserving won't work. If there is what's the point in reserving
it if normal DMA-mask and dma_alloc_coherent() will work just fine?

3. If, as an emergency solution for this problem, you wish to assign a
specific DMA-buffer then you don't need to define new non-standard
"memory-region" property semantics. What about using the
"restricted-dma-pool" reserved-memory region?

https://www.kernel.org/doc/Documentation/devicetree/bindings/reserved-memory/shared-dma-pool.yaml

-Serge(y)

> 
> Else, if the memory region is not reserved, try to allocate a
> 32-bit IOVA. Additionally, if this allocation also fails, attempt
> a 64-bit allocation for probe to be successful. If the 64-bit MSI
> address is allocated, then the EPs supporting 32-bit MSI address
> will not work.

> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> Changelog since v1:
>  - Use reserved memory, if it exists, to setup the MSI data
>  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  2 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7991f0e179b2..8c7c77b49ca8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	u64 *msi_vaddr;
>  	int ret;
>  	u32 ctrl, num_ctrls;
> +	struct device_node *np;
> +	struct resource r;
>  
>  	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>  		pp->irq_mask[ctrl] = ~0;
> @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	 * order not to miss MSI TLPs from those devices the MSI target
>  	 * address has to be within the lowest 4GB.
>  	 *
> -	 * Note until there is a better alternative found the reservation is
> -	 * done by allocating from the artificially limited DMA-coherent
> -	 * memory.
> +	 * Check if there is memory region reserved for this device. If yes,
> +	 * pick up the msi_data from this region. This will be helpful for
> +	 * platforms that do not use/have 32-bit DMA addresses but want to use
> +	 * endpoints which support only 32-bit MSI address.
> +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> +	 * supporting 32-bit MSI address will not work.
>  	 */
> -	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (np) {
> +		ret = of_address_to_resource(np, 0, &r);
> +		if (ret) {
> +			dev_err(dev, "No memory address assigned to the region\n");
> +			return ret;
> +		}
>  
> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> -					GFP_KERNEL);
> -	if (!msi_vaddr) {
> -		dev_err(dev, "Failed to alloc and map MSI data\n");
> -		dw_pcie_free_msi(pp);
> -		return -ENOMEM;
> +		pp->msi_data = r.start;
> +	} else {
> +		dev_dbg(dev, "No %s specified\n", "memory-region");
> +		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
> +		if (!msi_vaddr) {
> +			dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> +			dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> +			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +							GFP_KERNEL);
> +		}
> +
> +		if (!msi_vaddr) {
> +			dev_err(dev, "Failed to alloc and map MSI data\n");
> +			dw_pcie_free_msi(pp);
> +			return -ENOMEM;
> +		}
>  	}
>  
>  	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 55ff76e3d384..c85cf4d56e98 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -317,6 +317,7 @@ struct dw_pcie_rp {
>  	phys_addr_t		io_bus_addr;
>  	u32			io_size;
>  	int			irq;
> +	u8			coherent_dma_bits;
>  	const struct dw_pcie_host_ops *ops;
>  	int			msi_irq[MAX_MSI_CTRLS];
>  	struct irq_domain	*irq_domain;
> -- 
> 2.43.0.275.g3460e3d667-goog
> 

