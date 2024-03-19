Return-Path: <linux-pci+bounces-4910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC2A88024C
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432851C230FA
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62F281ABB;
	Tue, 19 Mar 2024 16:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ovFvrKSk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CB8174F
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865716; cv=none; b=b5NTuE4rPj2Lgjy8T/kduFlL28j2/E0hQcUbJspeXIJ1hzIh2Ub4JrtcEmUPtk80KZuW9dp3btbItYONBHIvKB4T/AJCZ48my7uPftc2DXWPubBm2dxBjg52ClbzBgI01ncbi+pOxViCAJld5ctisJgN2QdeXduVUu51SvTkm8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865716; c=relaxed/simple;
	bh=HkiEPXUCTFfqbtJ8sf9ZvTeFC6es5DUbxVbgvDJiZ38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRnSsmL/Ouk5DkKFfdxmwXl7iW/z43Llj3l+7s6s91aes+e7TNzWoo+fQyNxZ2GbnOFFC8V7XzmyhYVN/sMNLV8MJplawpy9nTs98ZbxujG0HPRkfxOM2r/ZtdDtDQ7ovT9gSxN4h2s6jv1RB/ks67uSgSCEjsgYJbDszwy176Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ovFvrKSk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dd955753edso46395955ad.1
        for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 09:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710865714; x=1711470514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1U47eqHpSlotIb5fQzy6o7Nf4MoN9+bE4ics2eYzUcY=;
        b=ovFvrKSkXoFyZyrtSNbrXfnggRaMBrrTWrmd0dDz0PqpL3tkds6j2ByNj5MMn7OPKc
         O+Il9x1Vv+EQsp8Y0Ekgp57gIQhmVAsJA1AIO7JPlbJgT2ndlTaw+b2HZBSgCoL1RMA7
         OeOflezAbljQB/MtQzUaD1vZ8dQka5W5C9U8DXABb5EPKIjluteS3Pm/Bkxiqkc2666P
         JBlmx62Ujq1mA2ZCQxdJeNqn/BQ2zF9JGI3TvcgcWIf8VbqJs1N2aI9X8c7iki1Np5oM
         YD4b/51vx77P3qKaVtNX34EVbwgLZA0g7up3YKiYiiQBoSsOFeyAfxGFbXdDsHaKQOPM
         tEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865714; x=1711470514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U47eqHpSlotIb5fQzy6o7Nf4MoN9+bE4ics2eYzUcY=;
        b=sMuLm5zs5jY6htV5IGaRHny6+FISWZaM4O9YTaleS1rBe+U4iz4UVlu4v6IwnlgPiF
         viaOoaH1hF1A8YC1e2ICXY/H69WZ29T7pqMYgWiUQOGxa9ifn7y+sOOOa8FUG9vYKJSf
         GKOoKVfwuJdFmtGSOM/Lw93xgCcfhO50eI9tE//KUIYr+9iaV/cLtOO2+4KKFzQIvyl4
         IVX6WgWwL+WD4qpG4YIXjYmt49nsIqv6fHHbpXI2/beP8SpgHTETNqGZ2B1gjX9EELix
         +DfydluBsoyFyVpExzZ8QpGNTPX908Atoc1ALrjSoBE0HPvPFPKcSl634EuoDunjuk5n
         p82g==
X-Forwarded-Encrypted: i=1; AJvYcCWNNJ0HLZ8ir8vUK/B37SOZi0rxeV6tFOc1asPiEZCS6xZEgvFk5TCj98s2BepMRcxNtRfU6oWQ/lZdMiuKRMteN2vvMtpUvjD/
X-Gm-Message-State: AOJu0YwvbQZE3w3qZjz4aCS5QVz81NKRf+LiTA7lwTdBN4Pkgwo63MZy
	0hU/a8ukqJUdTwZsQ5NwxNTa6nBIhvUZZ6FIDnfBDSU+OSpUy5MeWJZaHT397w==
X-Google-Smtp-Source: AGHT+IF2xsZFQTxLkIAWYk6sOUNhPGPAbnn7VE8zl0zWINw6lhLGLkVenJENo35TIPeg+vlyw71Z+A==
X-Received: by 2002:a17:903:2305:b0:1df:f91a:ba35 with SMTP id d5-20020a170903230500b001dff91aba35mr10905397plh.67.1710865713625;
        Tue, 19 Mar 2024 09:28:33 -0700 (PDT)
Received: from thinkpad ([120.56.201.52])
        by smtp.gmail.com with ESMTPSA id kw11-20020a170902f90b00b001dcc18e1c10sm11587869plb.174.2024.03.19.09.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 09:28:33 -0700 (PDT)
Date: Tue, 19 Mar 2024 21:58:29 +0530
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
Message-ID: <20240319162829.GC3297@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zfm0Ws/Zg1W2UVZt@lizhi-Precision-Tower-5810>

On Tue, Mar 19, 2024 at 11:50:50AM -0400, Frank Li wrote:
> On Sun, Mar 17, 2024 at 11:39:17AM +0530, Manivannan Sadhasivam wrote:
> > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > framework for managing the endpoint outbound window memory allocation.
> > 
> > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > driver from the start for managing the memory required to map the host
> > address space (outbound) in endpoint. Even though it works well, it
> > completely defeats the purpose of the 'Genalloc framework', a general
> > purpose memory allocator framework created to avoid various custom memory
> > allocators in the kernel.
> > 
> > The migration to Genalloc framework is done is such a way that the existing
> > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > need any modification (apart from the pcie-designware-epc driver that
> > queries page size).
> > 
> > Internally, the EPC mem driver now uses Genalloc framework's
> > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > based on the requested size as like the previous allocator. And the
> > page size passed during pci_epc_mem_init() API is used as the minimum order
> > for the memory allocations.
> > 
> > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > is now used to hold the address windows of the endpoint controller.
> > 
> > [1] https://lpc.events/event/17/contributions/1419/
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> >  drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> >  include/linux/pci-epc.h                         |  25 +---
> >  3 files changed, 81 insertions(+), 140 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 5befed2dc02b..37c612282eb6 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -482,11 +482,11 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  		reg = ep_func->msi_cap + PCI_MSI_DATA_32;
> >  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
> >  	}
> > -	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> > +	aligned_offset = msg_addr_lower & (epc->windows[0]->page_size - 1);
> >  	msg_addr = ((u64)msg_addr_upper) << 32 |
> >  			(msg_addr_lower & ~aligned_offset);
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  epc->mem->window.page_size);
> > +				  epc->windows[0]->page_size);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -550,10 +550,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  		return -EPERM;
> >  	}
> >  
> > -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> > +	aligned_offset = msg_addr & (epc->windows[0]->page_size - 1);
> >  	msg_addr &= ~aligned_offset;
> >  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  epc->mem->window.page_size);
> > +				  epc->windows[0]->page_size);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -572,7 +572,7 @@ void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
> >  	dw_pcie_edma_remove(pci);
> >  
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > -			      epc->mem->window.page_size);
> > +			      epc->windows[0]->page_size);
> >  
> >  	pci_epc_mem_exit(epc);
> >  
> > @@ -742,7 +742,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  	}
> >  
> >  	ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > -					     epc->mem->window.page_size);
> > +					     epc->windows[0]->page_size);
> >  	if (!ep->msi_mem) {
> >  		ret = -ENOMEM;
> >  		dev_err(dev, "Failed to reserve memory for MSI/MSI-X\n");
> > @@ -770,7 +770,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> >  
> >  err_free_epc_mem:
> >  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> > -			      epc->mem->window.page_size);
> > +			      epc->windows[0]->page_size);
> >  
> >  err_exit_epc_mem:
> >  	pci_epc_mem_exit(epc);
> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index a9c028f58da1..f9e6e1a6aeaa 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > @@ -4,37 +4,18 @@
> >   *
> >   * Copyright (C) 2017 Texas Instruments
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > + *
> > + * Copyright (C) 2024 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >   */
> >  
> > +#include <linux/genalloc.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  
> >  #include <linux/pci-epc.h>
> >  
> > -/**
> > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > - * @mem: address space of the endpoint controller
> > - * @size: the size for which to get the order
> > - *
> > - * Reimplement get_order() for mem->page_size since the generic get_order
> > - * always gets order with a constant PAGE_SIZE.
> > - */
> > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > -{
> > -	int order;
> > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > -
> > -	size--;
> > -	size >>= page_shift;
> > -#if BITS_PER_LONG == 32
> > -	order = fls(size);
> > -#else
> > -	order = fls64(size);
> > -#endif
> > -	return order;
> > -}
> > -
> >  /**
> >   * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> >   * @epc: the EPC device that invoked pci_epc_mem_init
> > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >  			   struct pci_epc_mem_window *windows,
> >  			   unsigned int num_windows)
> >  {
> > -	struct pci_epc_mem *mem = NULL;
> > -	unsigned long *bitmap = NULL;
> > -	unsigned int page_shift;
> > +	struct pci_epc_mem_window *window = NULL;
> >  	size_t page_size;
> > -	int bitmap_size;
> > -	int pages;
> >  	int ret;
> >  	int i;
> >  
> > -	epc->num_windows = 0;
> > -
> >  	if (!windows || !num_windows)
> >  		return -EINVAL;
> >  
> > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >  		page_size = windows[i].page_size;
> >  		if (page_size < PAGE_SIZE)
> >  			page_size = PAGE_SIZE;
> > -		page_shift = ilog2(page_size);
> > -		pages = windows[i].size >> page_shift;
> > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> >  
> > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > -		if (!mem) {
> > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> 
> I think it is not good to modify caller's memory. This funciton suppose
> pass down read-only information. And set to epc->windows[i]. I think it'd
> better to use epc->windows[i].pool/windows.
> 

What do you mean by modifying caller's memory? Here, the memory for epc->windows
is being allocated and the pool is created for each window.

> > +		if (!windows[i].pool) {
> >  			ret = -ENOMEM;
> > -			i--;
> > -			goto err_mem;
> > +			goto err_free_mem;
> > +		}
> > +
> > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > +				  NULL);
> > +
> > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > +		ret = gen_pool_add_virt(windows[i].pool, (unsigned long)windows[i].virt_base,
> > +					windows[i].phys_base, windows[i].size, -1);
> > +		if (ret) {
> > +			iounmap(windows[i].virt_base);
> > +			gen_pool_destroy(epc->windows[i]->pool);
> 
> I think move all free to err path will be easy to understand.
> 

It is not straightforward. First we need to free the memory for current
iteration and then all previous iterations, that too from different places.
Moving the code to free current iteration to the error label will look messy.

> > +			goto err_free_mem;
> >  		}
> >  
> > -		bitmap = kzalloc(bitmap_size, GFP_KERNEL);
> > -		if (!bitmap) {
> > +		window = kzalloc(sizeof(*window), GFP_KERNEL);
> 
> According to below code                                                    
>                                                                            
>         epc->windows = kcalloc(num_windows, sizeof(*epc->windows), GFP_KERNEL);
>         if (!epc->windows)                                                 
>                 return -ENOMEM;                                            
>                                                                            
> epc->windows already allocate whole num_windows * "struct pci_epc_mem_window".
> I think you can direct use 'window = epc->windows + i', so needn't alloc      
> additional memory for epc->windows[i].
> 

First we are allocating the memory for 'struct pci_epc_mem_window' _pointers_ in
epc->windows. Then we need to allocate memory for each pointer in epc->windows
to actually store data. Otherwise, we will be referencing the nulll pointer.

- Mani

> 
> > +		if (!window) {
> >  			ret = -ENOMEM;
> > -			kfree(mem);
> > -			i--;
> > -			goto err_mem;
> > +			iounmap(windows[i].virt_base);
> > +			gen_pool_destroy(epc->windows[i]->pool);
> > +			goto err_free_mem;
> >  		}
> >  
> > -		mem->window.phys_base = windows[i].phys_base;
> > -		mem->window.size = windows[i].size;
> > -		mem->window.page_size = page_size;
> > -		mem->bitmap = bitmap;
> > -		mem->pages = pages;
> > -		mutex_init(&mem->lock);
> > -		epc->windows[i] = mem;
> > +		window->phys_base = windows[i].phys_base;
> > +		window->size = windows[i].size;
> > +		window->page_size = page_size;
> > +		window->pool = windows[i].pool;
> > +		epc->windows[i] = window;
> >  	}
> >  
> > -	epc->mem = epc->windows[0];
> >  	epc->num_windows = num_windows;
> >  
> >  	return 0;
> >  
> > -err_mem:
> > -	for (; i >= 0; i--) {
> > -		mem = epc->windows[i];
> > -		kfree(mem->bitmap);
> > -		kfree(mem);
> > +err_free_mem:
> > +	for (--i; i >= 0; i--) {
> > +		iounmap(windows[i].virt_base);
> > +		gen_pool_destroy(epc->windows[i]->pool);
> > +		kfree(epc->windows[i]);
> >  	}
> > +
> >  	kfree(epc->windows);
> >  
> >  	return ret;
> > @@ -128,14 +109,15 @@ EXPORT_SYMBOL_GPL(pci_epc_multi_mem_init);
> >  int pci_epc_mem_init(struct pci_epc *epc, phys_addr_t base,
> >  		     size_t size, size_t page_size)
> >  {
> > -	struct pci_epc_mem_window mem_window;
> > +	struct pci_epc_mem_window window;
> >  
> > -	mem_window.phys_base = base;
> > -	mem_window.size = size;
> > -	mem_window.page_size = page_size;
> > +	window.phys_base = base;
> > +	window.size = size;
> > +	window.page_size = page_size;
> >  
> > -	return pci_epc_multi_mem_init(epc, &mem_window, 1);
> > +	return pci_epc_multi_mem_init(epc, &window, 1);
> >  }
> > +
> 
> Remove extra empty line change
> 
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >  
> >  /**
> > @@ -147,21 +129,20 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_init);
> >   */
> >  void pci_epc_mem_exit(struct pci_epc *epc)
> >  {
> > -	struct pci_epc_mem *mem;
> >  	int i;
> >  
> >  	if (!epc->num_windows)
> >  		return;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > -		kfree(mem->bitmap);
> > -		kfree(mem);
> > +		iounmap(epc->windows[i]->virt_base);
> > +		gen_pool_destroy(epc->windows[i]->pool);
> > +		kfree(epc->windows[i]);
> >  	}
> > +
> >  	kfree(epc->windows);
> >  
> >  	epc->windows = NULL;
> > -	epc->mem = NULL;
> >  	epc->num_windows = 0;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> > @@ -178,55 +159,42 @@ EXPORT_SYMBOL_GPL(pci_epc_mem_exit);
> >  void __iomem *pci_epc_mem_alloc_addr(struct pci_epc *epc,
> >  				     phys_addr_t *phys_addr, size_t size)
> >  {
> > +	struct pci_epc_mem_window *window;
> >  	void __iomem *virt_addr = NULL;
> > -	struct pci_epc_mem *mem;
> > -	unsigned int page_shift;
> > +	struct gen_pool *genpool;
> >  	size_t align_size;
> > -	int pageno;
> > -	int order;
> >  	int i;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > -		mutex_lock(&mem->lock);
> > -		align_size = ALIGN(size, mem->window.page_size);
> > -		order = pci_epc_mem_get_order(mem, align_size);
> > -
> > -		pageno = bitmap_find_free_region(mem->bitmap, mem->pages,
> > -						 order);
> > -		if (pageno >= 0) {
> > -			page_shift = ilog2(mem->window.page_size);
> > -			*phys_addr = mem->window.phys_base +
> > -				((phys_addr_t)pageno << page_shift);
> > -			virt_addr = ioremap(*phys_addr, align_size);
> > -			if (!virt_addr) {
> > -				bitmap_release_region(mem->bitmap,
> > -						      pageno, order);
> > -				mutex_unlock(&mem->lock);
> > -				continue;
> > -			}
> > -			mutex_unlock(&mem->lock);
> > -			return virt_addr;
> > -		}
> > -		mutex_unlock(&mem->lock);
> > +		window = epc->windows[i];
> > +		genpool = window->pool;
> > +		align_size = ALIGN(size, window->page_size);
> > +
> > +		virt_addr = (void __iomem *)gen_pool_alloc(genpool, align_size);
> > +		if (!virt_addr)
> > +			continue;
> > +
> > +		*phys_addr = gen_pool_virt_to_phys(genpool, (unsigned long)virt_addr);
> > +
> > +		break;
> >  	}
> >  
> >  	return virt_addr;
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_alloc_addr);
> >  
> > -static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> > +static struct pci_epc_mem_window *pci_epc_get_matching_window(struct pci_epc *epc,
> >  						       phys_addr_t phys_addr)
> >  {
> > -	struct pci_epc_mem *mem;
> > +	struct pci_epc_mem_window *window;
> >  	int i;
> >  
> >  	for (i = 0; i < epc->num_windows; i++) {
> > -		mem = epc->windows[i];
> > +		window = epc->windows[i];
> >  
> > -		if (phys_addr >= mem->window.phys_base &&
> > -		    phys_addr < (mem->window.phys_base + mem->window.size))
> > -			return mem;
> > +		if (phys_addr >= window->phys_base &&
> > +		    phys_addr < (window->phys_base + window->size))
> > +			return window;
> >  	}
> >  
> >  	return NULL;
> > @@ -244,27 +212,15 @@ static struct pci_epc_mem *pci_epc_get_matching_window(struct pci_epc *epc,
> >  void pci_epc_mem_free_addr(struct pci_epc *epc, phys_addr_t phys_addr,
> >  			   void __iomem *virt_addr, size_t size)
> >  {
> > -	struct pci_epc_mem *mem;
> > -	unsigned int page_shift;
> > -	size_t page_size;
> > -	int pageno;
> > -	int order;
> > +	struct pci_epc_mem_window *window;
> >  
> > -	mem = pci_epc_get_matching_window(epc, phys_addr);
> > -	if (!mem) {
> > +	window = pci_epc_get_matching_window(epc, phys_addr);
> > +	if (!window) {
> >  		pr_err("failed to get matching window\n");
> >  		return;
> >  	}
> >  
> > -	page_size = mem->window.page_size;
> > -	page_shift = ilog2(page_size);
> > -	iounmap(virt_addr);
> > -	pageno = (phys_addr - mem->window.phys_base) >> page_shift;
> > -	size = ALIGN(size, page_size);
> > -	order = pci_epc_mem_get_order(mem, size);
> > -	mutex_lock(&mem->lock);
> > -	bitmap_release_region(mem->bitmap, pageno, order);
> > -	mutex_unlock(&mem->lock);
> > +	gen_pool_free(window->pool, (unsigned long)virt_addr, size);
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_mem_free_addr);
> >  
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 40ea18f5aa02..37ea96ed3432 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -87,30 +87,19 @@ struct pci_epc_ops {
> >  /**
> >   * struct pci_epc_mem_window - address window of the endpoint controller
> >   * @phys_base: physical base address of the PCI address window
> > + * @virt_base: virtual base address of the PCI address window
> > + * @pool: memory pool descriptor
> >   * @size: the size of the PCI address window
> >   * @page_size: size of each page
> >   */
> >  struct pci_epc_mem_window {
> >  	phys_addr_t	phys_base;
> > +	void __iomem	*virt_base;
> > +	struct gen_pool *pool;
> >  	size_t		size;
> >  	size_t		page_size;
> >  };
> >  
> > -/**
> > - * struct pci_epc_mem - address space of the endpoint controller
> > - * @window: address window of the endpoint controller
> > - * @bitmap: bitmap to manage the PCI address space
> > - * @pages: number of bits representing the address region
> > - * @lock: mutex to protect bitmap
> > - */
> > -struct pci_epc_mem {
> > -	struct pci_epc_mem_window window;
> > -	unsigned long	*bitmap;
> > -	int		pages;
> > -	/* mutex to protect against concurrent access for memory allocation*/
> > -	struct mutex	lock;
> > -};
> > -
> >  /**
> >   * struct pci_epc - represents the PCI EPC device
> >   * @dev: PCI EPC device
> > @@ -118,9 +107,6 @@ struct pci_epc_mem {
> >   * @list_lock: Mutex for protecting pci_epf list
> >   * @ops: function pointers for performing endpoint operations
> >   * @windows: array of address space of the endpoint controller
> > - * @mem: first window of the endpoint controller, which corresponds to
> > - *       default address space of the endpoint controller supporting
> > - *       single window.
> >   * @num_windows: number of windows supported by device
> >   * @max_functions: max number of functions that can be configured in this EPC
> >   * @max_vfs: Array indicating the maximum number of virtual functions that can
> > @@ -134,8 +120,7 @@ struct pci_epc {
> >  	struct list_head		pci_epf;
> >  	struct mutex			list_lock;
> >  	const struct pci_epc_ops	*ops;
> > -	struct pci_epc_mem		**windows;
> > -	struct pci_epc_mem		*mem;
> > +	struct pci_epc_mem_window	**windows;
> >  	unsigned int			num_windows;
> >  	u8				max_functions;
> >  	u8				*max_vfs;
> > 
> > ---
> > base-commit: 256833a66670ff28b7c1bddbd17973619e5281fd
> > change-id: 20240317-pci-ep-genalloc-fa89f5e487e3
> > 
> > Best regards,
> > -- 
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 

-- 
மணிவண்ணன் சதாசிவம்

