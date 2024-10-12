Return-Path: <linux-pci+bounces-14390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0635B99B492
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 13:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708881F24DA1
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C7D19ABDE;
	Sat, 12 Oct 2024 11:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RGly05kt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5894170A2E
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733661; cv=none; b=iHQmkuVvU7Y2Dl2N/+1JM581z8h/e0to/g921L37u+VJssSxywlkDzbzsaxqL1ul2tCR2pk2+FM+N/YqI8yIRA7VXjCrPUnPvx4IVhKT6D4urOpUavJ6T23L9E42xoVQZ8faeQqDh0SXbMoJyvk3Xux2W/Q7g7lkMcviN67D6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733661; c=relaxed/simple;
	bh=YMCmAIOEvss3j2dF0KmRyEPT2LbU8PIediTuvWNzly0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYYZ34UXeWJjvYPsoHvXHOpJ9iOnRKePen9SeGPMulM1hAvdjgaQ8qJPNYadqw+PNBnQotbBbad4JgTlefCQVs28O0kdjr15Cgzs4tUXdP0+9ghTo+TygXjE0lBj/30bRe/MvO5cpIIiswhgRADp983IDD7cj+Ln5l4FkwZo5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RGly05kt; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e49ef3bb9so606929b3a.1
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728733659; x=1729338459; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L7g6Z21cvLqQO2HMmtvAhQSQsqH1X0EqDt5Mv4wdMqw=;
        b=RGly05ktcxEFt4Z3c/qGG0USN0Q70mwuZn77EaX96Xok2WYFn22yBuvdGCWNFN6Wkg
         puJ3f0L95hXbNToSDMs8xvqs14uHXuGiM1iH0KvmVaZIaq0xP9o7dBlB3MrsGpK7eTD0
         vL1CBSIU8eLn8JYzY3RYgIWgQLXonjDWJ/WsD66f9FO8c+UOrSqgdZiuphPt6jDGJ2ak
         vmrvcy9pxgME7uDkZznAXjK83Fl8WYt1SPrhgphJis3eWOTLswmImcVDRrcvxK2nsKjA
         CIP17etFLArXyMSOcTjSU6vRVmwfigjeeOCIcj86AsEIU/ZX1yqS5/s99OSUR4/Eobv+
         glWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733659; x=1729338459;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7g6Z21cvLqQO2HMmtvAhQSQsqH1X0EqDt5Mv4wdMqw=;
        b=VFOG/56kVk0XP4kVVtkF8HawY6mcdGsiuZrcR00Rx75rLikW5ArWNmjyvcUKO/1ruK
         V5iBnIoDBR/rFJc0QMrvnAnlW9VamwfGRWOZOT7rhwPDV1hzls650HFaoxr+GfdxCLPR
         fDKASx2DrSo6F+v4EW3nqcuvj8VKyTA8oCZOpzln7cwGXWzX/IWdtgBerKkUs0MgnBD2
         fHCwvNDi3hlRnzaTVMsjHWn6D+dHr/cgTgQr9S3KpJrpHiX2RQlN9TZe+Y1j1KzUpVqX
         cLDm2+lU3rk6oeKJ5BiRnX2xIzoKe9jPmCox6Iq4HKFFU4bZVr4pdBwIs36BTQwusEWc
         YbNw==
X-Forwarded-Encrypted: i=1; AJvYcCXBLjA9E69qCm3z6v+BvkYjQJgHXsk5kffU1Q6MsKvI0P1Y+Yybt2w7C7ctX83vttDZ/3AO3maUxpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWF2CQf9hEd4lv8CO/SvJ9TJNM3reV34qttHxVdgBPScEd8pog
	r/Ni/oXqj8QLC1FcOxrWiXoz8fSYbeEVmBDrpKw49XBzCsCDv2oScdDGig1Wmw==
X-Google-Smtp-Source: AGHT+IFcFM1dyUUsMfk8xM5q55tiyeYdosHSLf8KpO0vE3b3mSX5Lhpv6u+8FCmJbd7RrAE/QgFzUQ==
X-Received: by 2002:a05:6a00:2d0e:b0:71e:d8e:7676 with SMTP id d2e1a72fcca58-71e37987c15mr8946308b3a.12.1728733658907;
        Sat, 12 Oct 2024 04:47:38 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f53f8sm4023966b3a.55.2024.10.12.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 04:47:38 -0700 (PDT)
Date: Sat, 12 Oct 2024 17:17:33 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v6 3/6] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <20241012114733.sffroea47e2jljwt@thinkpad>
References: <20241012113246.95634-1-dlemoal@kernel.org>
 <20241012113246.95634-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241012113246.95634-4-dlemoal@kernel.org>

On Sat, Oct 12, 2024 at 08:32:43PM +0900, Damien Le Moal wrote:
> Some endpoint controllers have requirements on the alignment of the
> controller physical memory address that must be used to map a RC PCI
> address region. For instance, the endpoint controller of the RK3399 SoC
> uses at most the lower 20 bits of a physical memory address region as
> the lower bits of a RC PCI address region. For mapping a PCI address
> region of size bytes starting from pci_addr, the exact number of
> address bits used is the number of address bits changing in the address
> range [pci_addr..pci_addr + size - 1]. For this example, this creates
> the following constraints:
> 1) The offset into the controller physical memory allocated for a
>    mapping depends on the mapping size *and* the starting PCI address
>    for the mapping.
> 2) A mapping size cannot exceed the controller windows size (1MB) minus
>    the offset needed into the allocated physical memory, which can end
>    up being a smaller size than the desired mapping size.
> 
> Handling these constraints independently of the controller being used
> in an endpoint function driver is not possible with the current EPC
> API as only the ->align field in struct pci_epc_features is provided
> but used for BAR (inbound ATU mappings) mapping only. A new API is
> needed for function drivers to discover mapping constraints and handle
> non-static requirements based on the RC PCI address range to access.
> 
> Introduce the endpoint controller operation ->align_addr() to allow
> the EPC core functions to obtain the size and the offset into a
> controller address region that must be allocated and mapped to access
> a RC PCI address region. The size of the mapping provided by the
> align_addr() operation can then be used as the size argument for the
> function pci_epc_mem_alloc_addr() and the offset into the allocated
> controller memory provided can be used to correctly handle data
> transfers. For endpoint controllers that have PCI address alignment
> constraints, the align_addr() operation may indicate upon return an
> effective PCI address mapping size that is smaller (but not 0) than the
> requested PCI address region size.
> 
> The controller ->align_addr() operation is optional: controllers that
> do not have any alignment constraints for mapping RC PCI address regions
> do not need to implement this operation. For such controllers, it is
> always assumed that the mapping size is equal to the requested size of
> the PCI region and that the mapping offset is 0.
> 
> The function pci_epc_mem_map() is introduced to use this new controller
> operation (if it is defined) to handle controller memory allocation and
> mapping to a RC PCI address region in endpoint function drivers.
> 
> This function first uses the ->align_addr() controller operation to
> determine the controller memory address size (and offset into) needed
> for mapping an RC PCI address region. The result of this operation is
> used to allocate a controller physical memory region using
> pci_epc_mem_alloc_addr() and then to map that memory to the RC PCI
> address space with pci_epc_map_addr().
> 
> Since ->align_addr() () may indicate that not all of a RC PCI address
> region can be mapped, pci_epc_mem_map() may only partially map the RC
> PCI address region specified. It is the responsibility of the caller
> (an endpoint function driver) to handle such smaller mapping by
> repeatedly using pci_epc_mem_map() over the desried PCI address range.
> 
> The counterpart of pci_epc_mem_map() to unmap and free a mapped
> controller memory address region is pci_epc_mem_unmap().
> 
> Both functions operate using the new struct pci_epc_map data structure.
> This new structure represents a mapping PCI address, mapping effective
> size, the size of the controller memory needed for the mapping as well
> as the physical and virtual CPU addresses of the mapping (phys_base and
> virt_base fields). For convenience, the physical and virtual CPU
> addresses within that mapping to use to access the target RC PCI address
> region are also provided (phys_addr and virt_addr fields).
> 
> Endpoint function drivers can use struct pci_epc_map to access the
> mapped RC PCI address region using the ->virt_addr and ->pci_size
> fields.
> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/pci-epc-core.c | 103 ++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  38 ++++++++++
>  2 files changed, 141 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index b854f1bab26f..04a85d2f7e2a 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -466,6 +466,109 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>  
> +/**
> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @pci_addr: PCI address to which the CPU address should be mapped
> + * @pci_size: the number of bytes to map starting from @pci_addr
> + * @map: where to return the mapping information
> + *
> + * Allocate a controller memory address region and map it to a RC PCI address
> + * region, taking into account the controller physical address mapping
> + * constraints using the controller operation align_addr(). If this operation is
> + * not defined, we assume that there are no alignment constraints for the
> + * mapping.
> + *
> + * The effective size of the PCI address range mapped from @pci_addr is
> + * indicated by @map->pci_size. This size may be less than the requested
> + * @pci_size. The local virtual CPU address for the mapping is indicated by
> + * @map->virt_addr (@map->phys_addr indicates the physical address).
> + * The size and CPU address of the controller memory allocated and mapped are
> + * respectively indicated by @map->map_size and @map->virt_base (and
> + * @map->phys_base for the physical address of @map->virt_base).
> + *
> + * Returns 0 on success and a negative error code in case of error.
> + */
> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> +{
> +	size_t map_size = pci_size;
> +	size_t map_offset = 0;
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!pci_size || !map)
> +		return -EINVAL;
> +
> +	/*
> +	 * Align the PCI address to map. If the controller defines the
> +	 * .align_addr() operation, use it to determine the PCI address to map
> +	 * and the size of the mapping. Otherwise, assume that the controller
> +	 * has no alignment constraint.
> +	 */
> +	memset(map, 0, sizeof(*map));
> +	map->pci_addr = pci_addr;
> +	if (epc->ops->align_addr)
> +		map->map_pci_addr =
> +			epc->ops->align_addr(epc, pci_addr,
> +					     &map_size, &map_offset);
> +	else
> +		map->map_pci_addr = pci_addr;
> +	map->map_size = map_size;
> +	if (map->map_pci_addr + map->map_size < pci_addr + pci_size)
> +		map->pci_size = map->map_pci_addr + map->map_size - pci_addr;
> +	else
> +		map->pci_size = pci_size;
> +
> +	map->virt_base = pci_epc_mem_alloc_addr(epc, &map->phys_base,
> +						map->map_size);
> +	if (!map->virt_base)
> +		return -ENOMEM;
> +
> +	map->phys_addr = map->phys_base + map_offset;
> +	map->virt_addr = map->virt_base + map_offset;
> +
> +	ret = pci_epc_map_addr(epc, func_no, vfunc_no, map->phys_base,
> +			       map->map_pci_addr, map->map_size);
> +	if (ret) {
> +		pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
> +				      map->map_size);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_mem_map);
> +
> +/**
> + * pci_epc_mem_unmap() - unmap and free a CPU address region
> + * @epc: the EPC device on which the CPU address is allocated and mapped
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @map: the mapping information
> + *
> + * Unmap and free a CPU address region that was allocated and mapped with
> + * pci_epc_mem_map().
> + */
> +void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		       struct pci_epc_map *map)
> +{
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return;
> +
> +	if (!map || !map->virt_base)
> +		return;
> +
> +	pci_epc_unmap_addr(epc, func_no, vfunc_no, map->phys_base);
> +	pci_epc_mem_free_addr(epc, map->phys_base, map->virt_base,
> +			      map->map_size);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_mem_unmap);
> +
>  /**
>   * pci_epc_clear_bar() - reset the BAR
>   * @epc: the EPC device for which the BAR has to be cleared
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 42ef06136bd1..f4b8dc37e447 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -32,11 +32,43 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
>  	}
>  }
>  
> +/**
> + * struct pci_epc_map - information about EPC memory for mapping a RC PCI
> + *                      address range
> + * @pci_addr: start address of the RC PCI address range to map
> + * @pci_size: size of the RC PCI address range mapped from @pci_addr
> + * @map_pci_addr: RC PCI address used as the first address mapped (may be lower
> + *                than @pci_addr)
> + * @map_size: size of the controller memory needed for mapping the RC PCI address
> + *            range @pci_addr..@pci_addr+@pci_size
> + * @phys_base: base physical address of the allocated EPC memory for mapping the
> + *             RC PCI address range
> + * @phys_addr: physical address at which @pci_addr is mapped
> + * @virt_base: base virtual address of the allocated EPC memory for mapping the
> + *             RC PCI address range
> + * @virt_addr: virtual address at which @pci_addr is mapped
> + */
> +struct pci_epc_map {
> +	phys_addr_t	pci_addr;
> +	size_t		pci_size;
> +
> +	phys_addr_t	map_pci_addr;
> +	size_t		map_size;
> +
> +	phys_addr_t	phys_base;
> +	phys_addr_t	phys_addr;
> +	void __iomem	*virt_base;
> +	void __iomem	*virt_addr;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
>   * @set_bar: ops to configure the BAR
>   * @clear_bar: ops to reset the BAR
> + * @align_addr: operation to get the mapping address, mapping size and offset
> + *		into a controller memory window needed to map an RC PCI address
> + *		region
>   * @map_addr: ops to map CPU address to PCI address
>   * @unmap_addr: ops to unmap CPU address and PCI address
>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> @@ -61,6 +93,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> +	phys_addr_t (*align_addr)(struct pci_epc *epc, phys_addr_t pci_addr,
> +				  size_t *size, size_t *offset);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> @@ -278,6 +312,10 @@ void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
>  				     phys_addr_t *phys_addr, size_t size);
>  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
>  			   void __iomem *virt_addr, size_t size);
> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map);
> +void pci_epc_mem_unmap(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		       struct pci_epc_map *map);
>  
>  #else
>  static inline void pci_epc_init_notify(struct pci_epc *epc)
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

