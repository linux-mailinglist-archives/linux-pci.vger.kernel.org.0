Return-Path: <linux-pci+bounces-14315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141F99A3C9
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1853B1C2297E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C80F20CCC5;
	Fri, 11 Oct 2024 12:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKZesgpO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58521802
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728649292; cv=none; b=jgO5iHbGmn2QRrBM4NVQrOvOAmLohh0kPZVaPyM51GRhlU0YeARJkTZ14olFV1yUfgH6G+rdz34XEEfSNW7LhmEmr/2bvrYHsT6eFcKdk14dHTFmMoEZFAFFT5DU4qLj5qJ4Lm2QlyyiGRGH+3kIufIyfj+GxBJ7iO3OcE5mS8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728649292; c=relaxed/simple;
	bh=hqYWTQVscWKdKmDQUohsu2kK1lFbyO8v4QouVPhfIPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAhbU/0pzTN7HP8WsXbWbSvD6bxujU/xccP6myqewtcGwehjxAucQHvSiL1Qwq/bggK9mUKA0coBN4L6MomQk5hJikwHdyeI0wfEpCDoK9eNQuL+it18MRwUy5jCpgwuFZecYbqyYEqPeX0zTfJGUhRxycNEG1tSnb703rpsIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKZesgpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3D7C4CECE;
	Fri, 11 Oct 2024 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728649291;
	bh=hqYWTQVscWKdKmDQUohsu2kK1lFbyO8v4QouVPhfIPo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PKZesgpOKvyidxLUwgZNyT6+cg2LY2zmvkTZTYJnhAbRjcDytwr0biYoFA0r9KITn
	 RpAk2RauvVHCqmjVO/4RM+3r3zjGhjxECI4quRaKRS0tivrt2DnTfSwT1G3ZEJPohh
	 ywRTZhoCwJaufSB6NeEKwE4dzaqWOcnFRcIscMgvBJRKKBmNoaZOxAHeac+RK9zXMG
	 xgahnaHc7i17Mb4KtBE3h8I89bxM3XxM5XdY12uhhxRHIbeNwP2rsDdRRiNLLE22Q0
	 fKM5OgHuYyZrqmt3bg5/I9AuTUaqUJPBCjRcvI8K9yaIGDaKSNfXezPauisFcfl0ix
	 A8jpdPCzvsY1Q==
Message-ID: <fb6d46ae-cbe1-4ba1-8064-10ebbb3edfa8@kernel.org>
Date: Fri, 11 Oct 2024 21:21:29 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jingoo Han <jingoohan1@gmail.com>,
 linux-pci@vger.kernel.org, Rick Wertenbroek <rick.wertenbroek@gmail.com>
References: <20241011120115.89756-1-dlemoal@kernel.org>
 <20241011120115.89756-4-dlemoal@kernel.org> <ZwkU68LjTkahz_RZ@ryzen.lan>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <ZwkU68LjTkahz_RZ@ryzen.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/11/24 21:07, Niklas Cassel wrote:
>> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
>> +{
>> +	int ret;
>> +
>> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
>> +		return -EINVAL;
>> +
>> +	if (!pci_size || !map)
>> +		return -EINVAL;
>> +
>> +	ret = pci_epc_get_mem_map(epc, func_no, vfunc_no,
>> +				  pci_addr, pci_size, map);
>> +	if (ret)
>> +		return ret;
>> +
>> +	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
>> +						map->map_size);
>> +	if (!map->virt_base)
>> +		return -ENOMEM;
>> +
>> +	map->phys_addr = map->phys_base + map->map_ofst;
>> +	map->virt_addr = map->virt_base + map->map_ofst;
>> +
>> +	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
>> +			       map->map_pci_addr, map->map_size);
>> +	if (ret) {
>> +		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
>> +				      map->map_size);
>> +		map->virt_base = 0;
> 
> As reported by the kernel test robot on both v3 and v4, this should be:
> map->virt_base = NULL;
> otherwise you introduce a new sparse warning.

Oops. Missed that... OK, sending v6 with this removed as that is not necessary
anyway.

> 
> 
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_mem_map);
>> +
>> +/**
>> + * pci_epc_mem_unmap() - unmap and free a CPU address region
>> + * @epc: the EPC device on which the CPU address is allocated and mapped
>> + * @func_no: the physical endpoint function number in the EPC device
>> + * @vfunc_no: the virtual endpoint function number in the physical function
>> + * @map: the mapping information
>> + *
>> + * Unmap and free a CPU address region that was allocated and mapped with
>> + * pci_epc_mem_map().
>> + */
>> +void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		       struct pci_epc_map *map)
>> +{
>> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
>> +		return;
>> +
>> +	if (!map || !map->virt_base)
>> +		return;
>> +
>> +	pci_epc_unmap_addr(epc, func_no, vfunc_no, map->phys_base);
>> +	pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
>> +			      map->map_size);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
>> +
>>  /**
>>   * pci_epc_clear_bar() - reset the BAR
>>   * @epc: the EPC device for which the BAR has to be cleared
>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>> index 42ef06136bd1..b5f5c1eb54c5 100644
>> --- a/include/linux/pci-epc.h
>> +++ b/include/linux/pci-epc.h
>> @@ -32,11 +32,44 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>>  	}
>>  }
>>  
>> +/**
>> + * struct pci_epc_map - information about EPC memory for mapping a RC PCI
>> + *                      address range
>> + * @pci_addr: start address of the RC PCI address range to map
>> + * @pci_size: size of the RC PCI address range mapped from @pci_addr
>> + * @map_pci_addr: RC PCI address used as the first address mapped (may be lower
>> + *                than @pci_addr)
>> + * @map_size: size of the controller memory needed for mapping the RC PCI address
>> + *            range @pci_addr..@pci_addr+@pci_size
>> + * @map_ofst: offset into the mapped controller memory to access @pci_addr
>> + * @phys_base: base physical address of the allocated EPC memory for mapping the
>> + *             RC PCI address range
>> + * @phys_addr: physical address at which @pci_addr is mapped
>> + * @virt_base: base virtual address of the allocated EPC memory for mapping the
>> + *             RC PCI address range
>> + * @virt_addr: virtual address at which @pci_addr is mapped
>> + */
>> +struct pci_epc_map {
>> +	phys_addr_t	pci_addr;
>> +	size_t		pci_size;
>> +
>> +	phys_addr_t	map_pci_addr;
>> +	size_t		map_size;
>> +	phys_addr_t	map_ofst;
>> +
>> +	phys_addr_t	phys_base;
>> +	phys_addr_t	phys_addr;
>> +	void __iomem	*virt_base;
>> +	void __iomem	*virt_addr;
>> +};
>> +
>>  /**
>>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>>   * @write_header: ops to populate configuration space header
>>   * @set_bar: ops to configure the BAR
>>   * @clear_bar: ops to reset the BAR
>> + * @get_mem_map: operation to get the size and offset into a controller memory
>> + *               window needed to map an RC PCI address region
>>   * @map_addr: ops to map CPU address to PCI address
>>   * @unmap_addr: ops to unmap CPU address and PCI address
>>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
>> @@ -61,6 +94,8 @@ struct pci_epc_ops {
>>  			   struct pci_epf_bar *epf_bar);
>>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  			     struct pci_epf_bar *epf_bar);
>> +	int	(*get_mem_map)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +			       struct pci_epc_map *map);
>>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> @@ -278,6 +313,10 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>>  				     phys_addr_t *phys_addr, size_t size);
>>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>>  			   void __iomem *virt_addr, size_t size);
>> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map);
>> +void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>> +		       struct pci_epc_map *map);
>>  
>>  #else
>>  static inline void pci_epc_init_notify(struct pci_epc *epc)
>> -- 
>> 2.47.0
>>


-- 
Damien Le Moal
Western Digital Research

