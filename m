Return-Path: <linux-pci+bounces-4926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47C880B03
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 07:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85304B21D18
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 06:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F841755C;
	Wed, 20 Mar 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="apH8oDEH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C581CD1E
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 06:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915044; cv=none; b=DxeNO/LdlqUEoJ4OJxDAfVwdnV+1hRyh9bPkIhc7oD++4PG9iCiyy2ZOsGoaxrRSXGLmswFbwlgbfARkoogs2WKeW8IrDUpsOAgeJVKyUwdSnnfwqVStKA0gwsmwg8ExsrdZpf5MaB+zqfAZCORtOB1Ulp3/cCKCgoBAxbIYgQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915044; c=relaxed/simple;
	bh=RF2gKBUaOF79gNywl1nt9n25iR7hxgWOt2AcR0MCtIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjwcuOuTCl/g5Dbq5CWmgeUbafCrS969UGShRBnF7w1nxtb+X50LWX2kJ5urrJKfNuqo4Rz2paJsIt2wBnDp+mGIPk7bPADz34sQmiELGH1wvOUng1C5ojOWhrVEG/0jmP2LrkZPj8Z92F2MAh9MlrCdKeSA02hJoJjRnOrq1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=apH8oDEH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e034607879so21124635ad.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 23:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710915041; x=1711519841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jjGpwd2+hgs3NwYJ0tzCuCu9xWQmzkcWFYyJwiGu2OI=;
        b=apH8oDEHc1HdWTyANGBMR6WuHy+jEY2LmHAZOG7VAayJJgoCFxgLkFeXfaMBpQ0DTa
         PbrXa7G/J46i+HQog/GgLMWHrsRkoPHulxcZrhtWddgywKE4/7YKzZjpzlrmJDLWcaZs
         DPUWqG87gItoxz7+bloxYsXBlWn/GtCjBcv0gl4m1KE7rHvEV+y4VMndLOimWvrcxj3W
         xPfK4OUsN7Ttak5/4hEjPl24a87PUoCBjfV6lzd/ozHGwnxZLo2dzxCyUd8hd/sx8Dvq
         3t7ZX/x7UAqnfACPgpdHqJzMJeLkpT6PMOLsfrtmZ3SOb1H2W0J2PikWnO/WvGgmmUsF
         3jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710915041; x=1711519841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jjGpwd2+hgs3NwYJ0tzCuCu9xWQmzkcWFYyJwiGu2OI=;
        b=SV0h/58m/Tg19bCC5NaTBvj0TA/gIstGpt3QpjVD2DJcMYKMLsQUOjCPwEVhDsJNiE
         7dermnNEqS7G4rYk+UPA2qIFvuaFkpRwG1TXnbBa3+EcrGMsmm7DSSa2sYfi7X5ETQgn
         PDWWSok2F3ajTY6hWi7Y9ZQsPLLNTgIBFsWeloQuxzCBGC5JWbz2CtJM1ZNdY35Zpome
         WBD47gLvuOh/vYjM6gRSR5/FXdMCb4/YsRqDQ4TqKSH/4ett+AexwoC7NdCn3Or8OnXN
         czHlgPoShqtmTNBM2Bknna2n5F7jh391v0eXxd9QehhdHAp5TTqokd4FyTm0IVAtDX5u
         ZV7w==
X-Forwarded-Encrypted: i=1; AJvYcCX6EakHsxQeCj9xR3j3Sj0KzcDPTn4StKKBy5L2GfDg5HjEZBpoQm6MSWQ/m8lZArcMv/VnfbsSCu/o6QATI7GS8pfXN3pHMcGf
X-Gm-Message-State: AOJu0YzW508u0NgDVgdHQObS4U1vntxNpvkP8LXkgwUWjgB8eH4ZYHdd
	b15phUo0XGbAgSyn0mvCRZK9hHjIpkGS++yTjuzBiJDgy5hcQkLxW8pHQ2032w==
X-Google-Smtp-Source: AGHT+IED0oWBNyX3DizC7FdH5zxw2hP7Nb+5X5DUV+nkHRpIjxvSHC3HUDuVqvfORvXSyRW9Ukg4WQ==
X-Received: by 2002:a17:902:ec8c:b0:1e0:2c15:f327 with SMTP id x12-20020a170902ec8c00b001e02c15f327mr7192339plg.49.1710915041315;
        Tue, 19 Mar 2024 23:10:41 -0700 (PDT)
Received: from thinkpad ([120.56.201.52])
        by smtp.gmail.com with ESMTPSA id ju9-20020a170903428900b001dddce2291esm12590281plb.31.2024.03.19.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 23:10:40 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:40:34 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <20240320061034.GA2525@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
 <20240319162829.GC3297@thinkpad>
 <ZfnEz9w6ICZXFZeb@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnEz9w6ICZXFZeb@lizhi-Precision-Tower-5810>

On Tue, Mar 19, 2024 at 01:01:03PM -0400, Frank Li wrote:
> On Tue, Mar 19, 2024 at 09:58:29PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Mar 19, 2024 at 11:50:50AM -0400, Frank Li wrote:
> > > On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > > framework for managing the endpoint outbound window memory allocation.
> > > > 
> > > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > > driver from the start for managing the memory required to map the host
> > > > address space (outbound) in endpoint. Even though it works well, it
> > > > completely defeats the purpose of the 'Genalloc framework', a general
> > > > purpose memory allocator framework created to avoid various custom memory
> > > > allocators in the kernel.
> > > > 
> > > > The migration to Genalloc framework is done is such a way that the existing
> > > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > > need any modification (apart from the pcie-designware-epc driver that
> > > > queries page size).
> > > > 
> > > > Internally, the EPC mem driver now uses Genalloc framework's
> > > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > > based on the requested size as like the previous allocator. And the
> > > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > > for the memory allocations.
> > > > 
> > > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > > is now used to hold the address windows of the endpoint controller.
> > > > 
> > > > [1] https://lpc.events/event/17/contributions/1419/
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > > >  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > > >  include/linux/pci-epc.h                         |  25 +---
> > > >  3 files changed, 81 insertions(+), 140 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index 5befed2dc02b..37c612282eb6 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > >  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> > > >  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> > > >  	}
> > > > -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> > > > +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
> > > >  	msg_addr = ((u64)msg_addr_upper) << 32 |
> > > >  			(msg_addr_lower & ~aligned_offset);
> > > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > > -				  epc->mem->window.page_size);
> > > > +				  epc->windows[0]->page_size);
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> > > >  		return -EPERM;
> > > >  	}
> > > >  
> > > > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > > > +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
> > > >  	msg_addr &= ~aligned_offset;
> > > >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > > > -				  epc->mem->window.page_size);
> > > > +				  epc->windows[0]->page_size);
> > > >  	if (ret)
> > > >  		return ret;
> > > >  
> > > > @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> > > >  	dw_pcie_edma_remove(pci);
> > > >  
> > > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > > -			      epc->mem->window.page_size);
> > > > +			      epc->windows[0]->page_size);
> > > >  
> > > >  	pci_epc_mem_exit(epc);
> > > >  
> > > > @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	}
> > > >  
> > > >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > > > -					     epc->mem->window.page_size);
> > > > +					     epc->windows[0]->page_size);
> > > >  	if (!ep->msi_mem) {
> > > >  		ret = -ENOMEM;
> > > >  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> > > > @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  
> > > >  err_free_epc_mem:
> > > >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > > > -			      epc->mem->window.page_size);
> > > > +			      epc->windows[0]->page_size);
> > > >  
> > > >  err_exit_epc_mem:
> > > >  	pci_epc_mem_exit(epc);
> > > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > > @@ -4,37 +4,18 @@
> > > >   *
> > > >   * Copyright (C) 2017 Texas Instruments
> > > >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > > + *
> > > > + * Copyright (C) 2024 Linaro Ltd.
> > > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > >   */
> > > >  
> > > > +#include <linux/genalloc.h>
> > > >  #include <linux/io.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/slab.h>
> > > >  
> > > >  #include <linux/pci-epc.h>
> > > >  
> > > > -/**
> > > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > > - * @mem: address space of the endpoint controller
> > > > - * @size: the size for which to get the order
> > > > - *
> > > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > > - * always gets order with a constant PAGE_SIZE.
> > > > - */
> > > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > > -{
> > > > -	int order;
> > > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > > -
> > > > -	size--;
> > > > -	size >>= page_shift;
> > > > -#if BITS_PER_LONG == 32
> > > > -	order = fls(size);
> > > > -#else
> > > > -	order = fls64(size);
> > > > -#endif
> > > > -	return order;
> > > > -}
> > > > -
> > > >  /**
> > > >   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > > >   * @epc: the EPC device that invoked pci_epc_mem_init
> > > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > >  			   struct pci_epc_mem_window *windows,
> > > >  			   unsigned int num_windows)
> > > >  {
> > > > -	struct pci_epc_mem *mem = NULL;
> > > > -	unsigned long *bitmap = NULL;
> > > > -	unsigned int page_shift;
> > > > +	struct pci_epc_mem_window *window = NULL;
> > > >  	size_t page_size;
> > > > -	int bitmap_size;
> > > > -	int pages;
> > > >  	int ret;
> > > >  	int i;
> > > >  
> > > > -	epc->num_windows = 0;
> > > > -
> > > >  	if (!windows || !num_windows)
> > > >  		return -EINVAL;
> > > >  
> > > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > >  		page_size = windows[i].page_size;
> > > >  		if (page_size < PAGE_SIZE)
> > > >  			page_size = PAGE_SIZE;
> > > > -		page_shift = ilog2(page_size);
> > > > -		pages = windows[i].size >> page_shift;
> > > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > > >  
> > > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > > -		if (!mem) {
> > > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > > 
> > > I think it is not good to modify caller's memory. This funciton suppose
> > > pass down read-only information. And set to epc->windows[i]. I think it'd
> > > better to use epc->windows[i].pool/windows.
> > > 
> > 
> > What do you mean by modifying caller's memory? Here, the memory for epc->windows
> > is being allocated and the pool is created for each window.
> 
> windows[i].pool = gen_pool_create(ilog2(page_size), -1)
> 
> 'windows' pass down from argument pci_epc_multi_mem_init(
> ..struct pci_epc_mem_window *windows, )
> 			     ^^^^^^^
> windows[i].pool = gen_pool_create() actually change the caller's stack
> memory.
> 

Hmm, you are right. Will fix it.

> > 
> > > > +		if (!windows[i].pool) {
> > > >  			ret = -ENOMEM;
> > > > -			i--;
> > > > -			goto err_mem;
> > > > +			goto err_free_mem;
> > > > +		}
> > > > +
> > > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > > +				  NULL);
> > > > +
> > > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > > > +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> > > > +					windows[i].phys_base, windows[i].size, -1);
> > > > +		if (ret) {
> > > > +			iounmap(windows[i].virt_base);
> > > > +			gen_pool_destroy(epc->windows[i]->pool);
> > > 
> > > I think move all free to err path will be easy to understand.
> > > 
> > 
> > It is not straightforward. First we need to free the memory for current
> > iteration and then all previous iterations, that too from different places.
> > Moving the code to free current iteration to the error label will look messy.
> 
> All from current iteration.
> 
> err_free_mem:
>    iounmap(windows[i].virt_base);
>    if (epc->windows[i]->pool)
> 	gen_pool_destroy(epc->windows[i]->pool)

Initially I thought it would look messy if the memory for current iteration is
freed in the error labels. But now I implemented it and it doesn't look that
bad. So will change it in next iteration.

> 
> > 
> > > > +			goto err_free_mem;
> > > >  		}
> > > >  
> > > > -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > > > -		if (!bitmap) {
> > > > +		window = kzalloc(sizeof(*window), GFP_KERNEL);
> > > 
> > > According to below code                                                    
> > >                                                                            
> > >         epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
> > >         if (!epc->windows)                                                 
> > >                 return -ENOMEM;                                            
> > >                                                                            
> > > epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
> > > I think you can direct use 'window = epc->windows + i', so needn't alloc      
> > > additional memory for epc->windows[i].
> > > 
> > 
> > First we are allocating the memory for 'struct pci_epc_mem_window' _pointers_ in
> > epc->windows. Then we need to allocate memory for each pointer in epc->windows
> > to actually store data. Otherwise, we will be referencing the nulll pointer.
> 
> I think two layer pointer is totally unecessary.
> You can use one layer pointer 'struct pci_epc_mem_window       *windows;'
> 

How can you store multiple 'struct pci_epc_mem_window' with a single pointer?
Please elaborate.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

