Return-Path: <linux-pci+bounces-2067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C782B437
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 18:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98952286DE0
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 17:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0634B5A9;
	Thu, 11 Jan 2024 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="upnxYtko"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A2D537F5
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d47fae33e0so1855ad.0
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 09:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704994688; x=1705599488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0whomz5a0Tw0vuiJue7tFIh96lkiU1Gem+vCt9Z07Fs=;
        b=upnxYtkoghDrGfT/suRvq+Dt/4Jxh2TUANKdL5kxv35gPWeZLlF5zwvtjDQmLFZ34Y
         z2uYSSsJLVEo6SMI+yUWJwUrYhncEtl6lFM0OYj8wCLy6tc8NnJHfA4hmO7fZJyO3AED
         N2vzClAIV7EQcJqiHr5s/XUovzDmDYO6+Dw1OZa1rGpx760X9tdiOR5evuSyU5DohWKZ
         cfFNGQIk2vOrf0Ay/51YU50CAKV1yaubbKMapWZjPt2vYsegAq8C+jrSduQHlMDmRNiQ
         PBQ9Pv4tlqY0eSSg8euJUozpGoFSR19/JrfkPERkESV1s4GpglFUyECc6AL+Mhrhgv0q
         V8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704994688; x=1705599488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0whomz5a0Tw0vuiJue7tFIh96lkiU1Gem+vCt9Z07Fs=;
        b=B8bmgoR8IyZF/L/lFdCo2xrC/Ysk5iZU5TO3LcryA1x+ND0PDxnyp8mVLq9vPgp+yB
         T2ZohpBZb6b3XIXeYMH19HcY1dbjS7lfWPsOc9ezqlkzvdzGKMwva5mnlSxeE4bFdfSf
         X4cyfsNkoy+LhQxSASQNL8NUM22W5Ei+DhtaSACkxRR7KHxEDB4dk3OomrS9IDwMu2e2
         fVbTNtQklK2vLBuU5Sszk1fqc3+K7hJ7yup0JdH2q/ai6nxPFLlaKSaG+w2E1rVsHpRe
         zsLaH4N9TRn3pOC8hUA2HzlofMbN+oIIAAr+jZGFOri5OYQtP22cekvuKFQsBpHGkz+Q
         7t+Q==
X-Gm-Message-State: AOJu0YzRLvw88rMFUK4kB33k6++tx+EWvoTOuh+/FYuBML1kctr1TzWD
	NjD3n+Qaif/Chwiu1S+QJXskDSfIt7qM
X-Google-Smtp-Source: AGHT+IHM//y/Nc0i3nypbvjV/SZ7HeNBlNaxWfrXDnkQqj8IhJ/b5uNQakJTBQRcm049adWacItAAw==
X-Received: by 2002:a17:902:ba8a:b0:1d4:d451:b439 with SMTP id k10-20020a170902ba8a00b001d4d451b439mr154663pls.5.1704994687889;
        Thu, 11 Jan 2024 09:38:07 -0800 (PST)
Received: from google.com (78.250.82.34.bc.googleusercontent.com. [34.82.250.78])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001d1cd7e4ad2sm1421644plg.125.2024.01.11.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 09:38:07 -0800 (PST)
Date: Thu, 11 Jan 2024 09:38:03 -0800
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
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZaAne_KeJaOYnBcu@google.com>
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

Hi Ajay,

Thanks for sending the patch!

On 01/11/2024, Ajay Agarwal wrote:
> There can be platforms that do not use/have 32-bit DMA addresses
> but want to enumerate endpoints which support only 32-bit MSI
> address. The current implementation of 32-bit IOVA allocation can
> fail for such platforms, eventually leading to the probe failure.
> 
> If there is a memory region reserved for the pci->dev, pick up
> the MSI data from this region. This can be used by the platforms
> described above.
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

Should we just put this second if-check inside the above fallback?

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

Looks like this is a lingering change? Please drop.

Thanks,
Will

> -- 
> 2.43.0.275.g3460e3d667-goog
> 

