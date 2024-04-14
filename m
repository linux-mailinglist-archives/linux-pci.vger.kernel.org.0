Return-Path: <linux-pci+bounces-6226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49568A4267
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5171C1F212C6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Apr 2024 13:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33AE20323;
	Sun, 14 Apr 2024 13:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i29OXoiC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8331CF89
	for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099667; cv=none; b=vDUUywFRddLNxLPhExzL07KrZOWWroE1QnynfUUbhuyJPvA9GQEb7LZkA0eGZ+93RcdOEoawMgmwIjMsNiN95q0g/91iqwDxj5GMNAFZutfeF1XGoCaRnyEjbitGmVN8R2nB4QGm+W43/91+bTNS2QDN//fB4S+A+RTFFo2buHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099667; c=relaxed/simple;
	bh=+JGinkGUgeetfZe7KdVXDzaihf5FNpwgQUbEfhGRNT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmGjnOpFtZ6SyMOgE2L0BEgIlfPdNZ/wVH6l/YlyhDan5lXqXES995v72LeXtyEAGMyJ4KleWR70PpDbnVhcsxZyp5LNKc/zFTZNbQaPsK23o3Gnf+6CjJW/uzkPpgYou7BTlryreKAZCxiDn4dsWgf0yTrbMTFtXjqyi+P9lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i29OXoiC; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a52c544077so1586522a91.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Apr 2024 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713099665; x=1713704465; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jvVS8fZDPWZ6C8BGJgV7+o1D33foaDJkSVY8UEluGQI=;
        b=i29OXoiCjtgSjs2WBqyG62ltMF/8D8w132h2e+o9kphYy9ihfvaP5X0ibOC3K6AU65
         c19NIO7yAlI/SCOT/LAH4wUZPYbAhG+eOyhb9v3l0eaZ0V/1dIF8f2Jm12aBSSWQfBiJ
         +qhARDzTXliTEexQkXCq5tXgeXrAW8x0joKuj1H5aOXKp68kQc9IbDw7NU6QbMGvPPI2
         f+yQx5JapUMoeUzhGPWomwr5MioNdAFi+QjlMAjgOoigA/wFD/MeqzlcAtrbJl4dH5ZX
         EwyBn+TG/7jsv0vt6j/j/lF43WaE8hmLdjHw1KNrnLDIVatgg4fJ62xewf4KwTU48eoh
         +50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713099665; x=1713704465;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvVS8fZDPWZ6C8BGJgV7+o1D33foaDJkSVY8UEluGQI=;
        b=T68IGFzTyxfrWh9LYv5Bz2w7BU6VbWcQQtyRc60Z+Ws/IqGar8ZUNMRCjswF5vkd+e
         tXVcCg/zHndGXVzVxovpdSncKgaB+4vI8YNlGSa18biH1R1/XtwQ4YR7Ky0FKnAW61i8
         IHNfBYi6cgpfOGcQ0FDz5GPJf5WsbOe3rmSIWKauM6wpjDMWBk4mYlXobk1nGDPbitTl
         Ldu3VIZ9+6BCP1tremjpLEc+iZciuIZCYO1kN8+8PbLFwH47A2PqIPHK4VqdeGRwJ3HV
         NHlHUk9IGof9+P3h5dURM9yc7OkLZiZvjoJiUm0OOpvAlVw8IHfKEDC5IMtmf01SjYKQ
         MsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn9AIZztwnBO7hPV+8gUkm15dQ6VOyaGgkII12ydc9BZfT25l7aeaYSnU6QAVRS0fBPPqJNhYN0DvtXRkUT5d2tMy0+dOGZKU+
X-Gm-Message-State: AOJu0Yx5/AukXuabPT1/xoL7VDEnPYXzyvJB1HiqJSEoIcNLTYxy9aPS
	90+855h1PnRqk7zcwe05O23tmzMXAa4wmTpgVG9pd+ovigWP7k9hgVS8njagag==
X-Google-Smtp-Source: AGHT+IFGLYOEvtQ17A4IP+js2HGKJp/jc1XXKTbOcw6VnyVS54fNx/L51bEWNL/vMzMdch8Lr03TXg==
X-Received: by 2002:a17:90a:2f65:b0:2a0:2fb3:c1ff with SMTP id s92-20020a17090a2f6500b002a02fb3c1ffmr5676444pjd.15.1713099664882;
        Sun, 14 Apr 2024 06:01:04 -0700 (PDT)
Received: from thinkpad ([103.246.195.153])
        by smtp.gmail.com with ESMTPSA id x15-20020a17090a164f00b002a5cf58aae2sm5989216pje.11.2024.04.14.06.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 06:01:04 -0700 (PDT)
Date: Sun, 14 Apr 2024 18:30:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kishon Vijay Abraham I <kvijayab@amd.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Migrate to Genalloc framework for
 outbound window memory allocation
Message-ID: <20240414130058.GA2231@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
 <20240320112928.GB2525@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320112928.GB2525@thinkpad>

On Wed, Mar 20, 2024 at 04:59:28PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
> > Hi Mani,
> > 
> > On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
> > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > framework for managing the endpoint outbound window memory allocation.
> > > 
> > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > driver from the start for managing the memory required to map the host
> > > address space (outbound) in endpoint. Even though it works well, it
> > > completely defeats the purpose of the 'Genalloc framework', a general
> > > purpose memory allocator framework created to avoid various custom memory
> > > allocators in the kernel.
> > > 
> > > The migration to Genalloc framework is done is such a way that the existing
> > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > need any modification (apart from the pcie-designware-epc driver that
> > > queries page size).
> > > 
> > > Internally, the EPC mem driver now uses Genalloc framework's
> > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > based on the requested size as like the previous allocator. And the
> > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > for the memory allocations.
> > > 
> > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > is now used to hold the address windows of the endpoint controller.
> > > 
> > > [1] https://lpc.events/event/17/contributions/1419/
> > 
> > Thank you for working on this!
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > >   drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > >   include/linux/pci-epc.h                         |  25 +---
> > >   3 files changed, 81 insertions(+), 140 deletions(-)
> > > 
> > .
> > .
> > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > @@ -4,37 +4,18 @@
> > >    *
> > >    * Copyright (C) 2017 Texas Instruments
> > >    * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > + *
> > > + * Copyright (C) 2024 Linaro Ltd.
> > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > >    */
> > > +#include <linux/genalloc.h>
> > >   #include <linux/io.h>
> > >   #include <linux/module.h>
> > >   #include <linux/slab.h>
> > >   #include <linux/pci-epc.h>
> > > -/**
> > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > - * @mem: address space of the endpoint controller
> > > - * @size: the size for which to get the order
> > > - *
> > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > - * always gets order with a constant PAGE_SIZE.
> > > - */
> > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > -{
> > > -	int order;
> > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > -
> > > -	size--;
> > > -	size >>= page_shift;
> > > -#if BITS_PER_LONG == 32
> > > -	order = fls(size);
> > > -#else
> > > -	order = fls64(size);
> > > -#endif
> > > -	return order;
> > > -}
> > > -
> > >   /**
> > >    * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > >    * @epc: the EPC device that invoked pci_epc_mem_init
> > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >   			   struct pci_epc_mem_window *windows,
> > >   			   unsigned int num_windows)
> > >   {
> > > -	struct pci_epc_mem *mem = NULL;
> > > -	unsigned long *bitmap = NULL;
> > > -	unsigned int page_shift;
> > > +	struct pci_epc_mem_window *window = NULL;
> > >   	size_t page_size;
> > > -	int bitmap_size;
> > > -	int pages;
> > >   	int ret;
> > >   	int i;
> > > -	epc->num_windows = 0;
> > > -
> > >   	if (!windows || !num_windows)
> > >   		return -EINVAL;
> > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > >   		page_size = windows[i].page_size;
> > >   		if (page_size < PAGE_SIZE)
> > >   			page_size = PAGE_SIZE;
> > > -		page_shift = ilog2(page_size);
> > > -		pages = windows[i].size >> page_shift;
> > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > -		if (!mem) {
> > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > > +		if (!windows[i].pool) {
> > >   			ret = -ENOMEM;
> > > -			i--;
> > > -			goto err_mem;
> > > +			goto err_free_mem;
> > > +		}
> > > +
> > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > +				  NULL);
> > > +
> > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > 
> > Do you have to ioremap upfront the entire window? This could be a problem in
> > 32-bit systems which has limited vmalloc space. I have faced issues before
> > when trying to map the entire memory window and had to manipulate vmalloc
> > boot parameter.
> > 
> > I'd prefer we find a way to do ioremap per allocation as before.
> > 
> 
> Hmm, thanks for pointing it out. Current genalloc implementation works on the
> virtual address as opposed to physical address (that might be due to majority of
> its users managing the virtual address only). That's the reason I did ioremap of
> the entire window upfront.
> 
> Let me see if we can somehow avoid this.
> 

Looks like we have to introduce some good amount of change to support dynamic
ioremap with genalloc. But IMO it doesn't worth the effort to introduce these
changes for some old systems which are supposed to go away soon.

So I think we can keep the old and genalloc based allocators and use the old one
only for 32bit systems and genalloc allocator for the rest.

What do you think?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

