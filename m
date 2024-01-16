Return-Path: <linux-pci+bounces-2206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED94482EFC0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 14:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6378A1F23BEF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 13:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2001EEAE;
	Tue, 16 Jan 2024 13:30:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F25F1BDC3
	for <linux-pci@vger.kernel.org>; Tue, 16 Jan 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C1E52F4;
	Tue, 16 Jan 2024 05:31:20 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B835C3F6C4;
	Tue, 16 Jan 2024 05:30:30 -0800 (PST)
Message-ID: <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
Date: Tue, 16 Jan 2024 13:30:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
To: Ajay Agarwal <ajayagarwal@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>,
 William McVicker <willmcvicker@google.com>,
 Serge Semin <fancer.lancer@gmail.com>
Cc: linux-pci@vger.kernel.org
References: <20240111042103.392939-1-ajayagarwal@google.com>
Content-Language: en-GB
In-Reply-To: <20240111042103.392939-1-ajayagarwal@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-11 4:21 am, Ajay Agarwal wrote:
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
>   - Use reserved memory, if it exists, to setup the MSI data
>   - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> 
>   .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
>   drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>   2 files changed, 39 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7991f0e179b2..8c7c77b49ca8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   	u64 *msi_vaddr;
>   	int ret;
>   	u32 ctrl, num_ctrls;
> +	struct device_node *np;
> +	struct resource r;
>   
>   	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
>   		pp->irq_mask[ctrl] = ~0;
> @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>   	 * order not to miss MSI TLPs from those devices the MSI target
>   	 * address has to be within the lowest 4GB.
>   	 *
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
>   	 */
> -	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> +	np = of_parse_phandle(dev->of_node, "memory-region", 0);
> +	if (np) {
> +		ret = of_address_to_resource(np, 0, &r);

This is incorrect in several ways - reserved-memory nodes represent 
actual system memory, so can't be used to reserve arbitrary PCI memory 
space (which may be different if DMA offsets are involved); the whole 
purpose of going through the DMA API is to ensure we get a unique *bus* 
address. Obviously we don't want to reserve actual memory for something 
that functionally doesn't need it, but conversely having a 
reserved-memory region for an address which isn't memory would be 
nonsensical. And even if this *were* a viable approach, you haven't 
updated the DWC binding to allow it, nor defined a reserved-memory 
binding for the node itself.

If it was reasonable to put something in DT at all, then the logical 
thing would be a property expressing an MSI address directly on the 
controller node itself, but even that would be dictating software policy 
rather than describing an aspect of the platform itself. Plus this is 
far from the only driver with this concern, so it wouldn't make much 
sense to hack just one binding without all the others as well. The rest 
of the DT already describes everything an OS needs to know in order to 
decide an MSI address to use, it's just a matter of making this 
particular OS do a better job of putting it all together.

Thanks,
Robin.

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
>   	}
>   
>   	return 0;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 55ff76e3d384..c85cf4d56e98 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -317,6 +317,7 @@ struct dw_pcie_rp {
>   	phys_addr_t		io_bus_addr;
>   	u32			io_size;
>   	int			irq;
> +	u8			coherent_dma_bits;
>   	const struct dw_pcie_host_ops *ops;
>   	int			msi_irq[MAX_MSI_CTRLS];
>   	struct irq_domain	*irq_domain;

