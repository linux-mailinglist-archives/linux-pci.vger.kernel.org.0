Return-Path: <linux-pci+bounces-14195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258F5998A5A
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A6C1F2A66D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4FB1E908A;
	Thu, 10 Oct 2024 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFmQ7U95"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1F31E907F
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728570995; cv=none; b=HVWnGjCb1HfujYSmF2AwobbWhWtlxE52RFoi1jbKHiz2OhumTd1FGWLhwyocvwfvVUql4jn2aarbJ+dcDPPUp58BtTLeS3H1capMsJkryuIWXjhJAsOIPI943GFvsZ/MwbNi8elKQ2VNjVS6Sq2q7twuoZseKT24TJm6lculgVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728570995; c=relaxed/simple;
	bh=mRy55K8SnnkF/h4OBVmfeQZnYo/HmF+dTcg/0Mb4rXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeVsVSU4ndJG0p2CA1iVYb1Lxg99/R+C7x6m2Uv1tYcJ7OXdDqMJ527IUKi9NMGXD+h5CBnFBWtSCNPBjrASMSNBdTeBlUBR4WD5/fe683zF7+THt3pnggIwTY67ZI9t17l3+KU8btZ8OHFu0KF3uvvFi3YIqzeTEF7Fiq5AnkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFmQ7U95; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7163489149eso747289a12.1
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 07:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728570993; x=1729175793; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XCKuQ4AJSKzuZkL/kPhU3ECme4Cx0D9rVHcfa/651Ac=;
        b=VFmQ7U956dtu3gN5+c6XZw36kzGdyjRbYbMbLHBVPDSnHbyixaJNL/l/CcUFow3rT6
         +HBTN68doQvfmwLDVP3n2Af+JRwhc1C/h7XJ2pbfOhzPsHKrZisfmmNxYsDuuwBGdt4M
         3WVt9YVKqIOdR1W1Wfn1HiVanPNz8cdIP5EYJJh9oib7Nhcq0/Mjk2SszPeflrHmdT9C
         8zxF8rZWxaQgTBAy0ETv4kBhINy4FhcjtYRovrcrNHty8dFXI1fpJv8RJPEOTugn89qt
         jDiclD8R72udOMz8bC4aS6HKe1vsgLU1wDvG6ykCZb21qhys6EiNXTajgwI26W/3TN6z
         eZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728570993; x=1729175793;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCKuQ4AJSKzuZkL/kPhU3ECme4Cx0D9rVHcfa/651Ac=;
        b=kNTNX6Dnk0DiIfaY7bM3EmhelNxto8+cyX4plwiAYmk7c2qoT1Ok9AVebJQUMg8OJH
         oHJhDLiCvuLfuYwB3FIGqqIQ5+HSu0si44x8rpTMdkX+CFo39/9DcfrLVf5vHWL0CRvm
         1WZcdWv93AzJOw0iLInQg0eCl+qFK6EJU/OjbEpOpYfo4tqT99rzOZw+kppxRpKohS1Z
         KlQ7CdzwqRP3wJUORc9Q0670dgg6MX6bLScd2iuns/nOKqJmmYFedjgss0cDhm0AKJJ+
         1lelBEVkM4UcDda6okWzfA1xidS8ENnJHqQB4FzeU+5vhFij73Swn75npLe8VVaVuhhP
         9JPw==
X-Forwarded-Encrypted: i=1; AJvYcCWk8gM+rOvG6mnW5vYvgFxr5gfkk1dJrDdmIaXj90gLdsPZUw+XRIDwFvHbGS6BpN6JKSxJDZdCMew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhfk4BHvVk2iBSJciDaNPZ5/8Q0g4U345qnAcXitmgL/+GQsm
	qUKUPVlK7zNV9zwygDu3L27D5M9rY/mvrgqoWVzNAcDKsegny8i74GOG9PDQDJuB4wMYccy9tWU
	=
X-Google-Smtp-Source: AGHT+IHZYwfFqGDZdQC1nd7G2cEGmLIoww5Qt4qbZESHxlz6OsFzmHAtAksSLmT/jYA9LgVtTUOHIg==
X-Received: by 2002:a05:6a21:1192:b0:1d8:a3ab:720d with SMTP id adf61e73a8af0-1d8a3b5cafamr11233747637.0.1728570992898;
        Thu, 10 Oct 2024 07:36:32 -0700 (PDT)
Received: from thinkpad ([36.255.17.48])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1060112a12.94.2024.10.10.07.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 07:36:32 -0700 (PDT)
Date: Thu, 10 Oct 2024 20:06:27 +0530
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
Subject: Re: [PATCH v4 3/7] PCI: endpoint: Introduce pci_epc_map_align()
Message-ID: <20241010143627.5eo5n2rp75pgtgpt@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-4-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007040319.157412-4-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:03:15PM +0900, Damien Le Moal wrote:
> Some endpoint controllers have requirements on the alignment of the
> controller physical memory address that must be used to map a RC PCI
> address region. For instance, the rockchip endpoint controller uses
> at most the lower 20 bits of a physical memory address region as the
> lower bits of an RC PCI address. For mapping a PCI address region of
> size bytes starting from pci_addr, the exact number of address bits
> used is the number of address bits changing in the address range
> [pci_addr..pci_addr + size - 1].
> 
> For this example, this creates the following constraints:
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
> and used for BAR (inbound ATU mappings) mapping. A new API is needed
> for function drivers to discover mapping constraints and handle
> non-static requirements based on the RC PCI address range to access.
> 
> Introduce the function pci_epc_map_align() and the endpoint controller
> operation ->map_align to allow endpoint function drivers to obtain the
> size and the offset into a controller address region that must be
> allocated and mapped to access an RC PCI address region. The size
> of the mapping provided by pci_epc_map_align() can then be used as the
> size argument for the function pci_epc_mem_alloc_addr().
> The offset into the allocated controller memory provided can be used to
> correctly handle data transfers.
> 
> For endpoint controllers that have PCI address alignment constraints,
> pci_epc_map_align() may indicate upon return an effective PCI address
> region mapping size that is smaller (but not 0) than the requested PCI
> address region size. For such case, an endpoint function driver must
> handle data accesses over the desired PCI address range in fragments,
> by repeatedly using pci_epc_map_align() over the PCI address range.
> 
> The controller operation ->map_align is optional: controllers that do
> not have any alignment constraints for mapping a RC PCI address region
> do not need to implement this operation. For such controllers,
> pci_epc_map_align() always returns the mapping size as equal to the
> requested size of the PCI region and an offset equal to 0.
> 
> The new structure struct pci_epc_map is introduced to represent a
> mapping start PCI address, mapping effective size, the size and offset
> into the controller memory needed for mapping the PCI address region as
> well as the physical and virtual CPU addresses of the mapping (phys_base
> and virt_base fields). For convenience, the physical and virtual CPU
> addresses within that mapping to access the target RC PCI address region
> are also provided (phys_addr and virt_addr fields).
> 

I'm fine with the concept of this patch, but I don't get why you need an API for
this and not just a callback to be used in the pci_epc_mem_{map/unmap} APIs.
Furthermore, I don't see an user of this API (in 3 series you've sent out so
far). Let me know if I failed to spot it.

Also, the API name pci_epc_map_align() sounds like it does the mapping, but it
doesn't. So I'd not have it exposed as an API at all.

- Mani

> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 66 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 37 ++++++++++++++++
>  2 files changed, 103 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index b854f1bab26f..1adccf07c33e 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -435,6 +435,72 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>  
> +/**
> + * pci_epc_map_align() - Get the offset into and the size of a controller memory
> + *			 address region needed to map a RC PCI address region
> + * @epc: the EPC device on which address is allocated
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @pci_addr: The RC PCI address to map
> + * @pci_size: the number of bytes to map starting from @pci_addr
> + * @map: populate here the actual size and offset into the controller memory
> + *       that must be allocated for the mapping
> + *
> + * If defined, invoke the controller map_align operation to obtain the size and
> + * the offset into a controller address region that must be allocated to map
> + * @pci_size bytes of the RC PCI address space starting from @pci_addr.
> + *
> + * On return, @map->pci_size indicates the effective size of the mapping that
> + * can be handled by the controller. This size may be smaller than the requested
> + * @pci_size. In such case, the endpoint function driver must handle the mapping
> + * using several fragments. The offset into the controller memory for the
> + * effective mapping of the RC PCI address range
> + * @pci_addr..@pci_addr+@map->pci_size is indicated by @map->map_ofst.
> + *
> + * If the target controller does not define a map_align operation, it is assumed
> + * that the controller has no PCI address mapping alignment constraint.
> + */
> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		      u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> +{
> +	int ret;
> +
> +	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
> +		return -EINVAL;
> +
> +	if (!pci_size || !map)
> +		return -EINVAL;
> +
> +	/*
> +	 * Initialize and remember the PCI address region to be mapped. The
> +	 * controller ->map_align() operation may change the map->pci_size to a
> +	 * smaller value.
> +	 */
> +	memset(map, 0, sizeof(*map));
> +	map->pci_addr = pci_addr;
> +	map->pci_size = pci_size;
> +
> +	if (!epc->ops->map_align) {
> +		/*
> +		 * Assume that the EP controller has no alignment constraint,
> +		 * that is, that the PCI address to map and the size of the
> +		 * controller memory needed for the mapping are the same as
> +		 * specified by the caller.
> +		 */
> +		map->map_pci_addr = pci_addr;
> +		map->map_size = pci_size;
> +		map->map_ofst = 0;
> +		return 0;
> +	}
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->map_align(epc, func_no, vfunc_no, map);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_map_align);
> +
>  /**
>   * pci_epc_map_addr() - map CPU address to PCI address
>   * @epc: the EPC device on which address is allocated
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index 42ef06136bd1..9df8a83e8d10 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -32,11 +32,44 @@ pci_epc_interface_string(enum pci_epc_interface_type type)
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
> + * @map_ofst: offset into the mapped controller memory to access @pci_addr
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
> +	phys_addr_t	map_ofst;
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
> + * @map_align: operation to get the size and offset into a controller memory
> + *             window needed to map an RC PCI address region
>   * @map_addr: ops to map CPU address to PCI address
>   * @unmap_addr: ops to unmap CPU address and PCI address
>   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> @@ -61,6 +94,8 @@ struct pci_epc_ops {
>  			   struct pci_epf_bar *epf_bar);
>  	void	(*clear_bar)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			     struct pci_epf_bar *epf_bar);
> +	int	(*map_align)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +			    struct pci_epc_map *map);
>  	int	(*map_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  			    phys_addr_t addr, u64 pci_addr, size_t size);
>  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> @@ -241,6 +276,8 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    struct pci_epf_bar *epf_bar);
>  void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		       struct pci_epf_bar *epf_bar);
> +int pci_epc_map_align(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		      u64 pci_addr, size_t size, struct pci_epc_map *map);
>  int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		     phys_addr_t phys_addr,
>  		     u64 pci_addr, size_t size);
> -- 
> 2.46.2
> 

-- 
மணிவண்ணன் சதாசிவம்

