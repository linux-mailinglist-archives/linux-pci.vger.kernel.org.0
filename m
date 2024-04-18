Return-Path: <linux-pci+bounces-6391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A1E8A9255
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 07:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9D64282745
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 05:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA88254BFD;
	Thu, 18 Apr 2024 05:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQEsRAUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF1E37162
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713417878; cv=none; b=ARN85wsqkzYhcp5uB+bgKQbhcrGMhVw8v8/VjdLDZ3K3ZyHQ4H1kSWlpfo8n+Eh27QAjTa/ZGuSzqXSOfT0PaLkC4s+c4YhstVn20ASt/0mN/i6TTai7s7dAxKOPu+yUOwrxXEehidTWBaqQ6FpXuszwHuTMj8TFcJqPYSmDFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713417878; c=relaxed/simple;
	bh=yTHNcJV6mkbvbACM8MlRUqxTGaeuT75VpWTO8vyzG/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCgt53qN/jK+Y9yPEdhYGxECFIPqvcANiN+4tIQ0A1wwKhQtc5nA3AWHGqcCdeFgFyxKZF97//HO9HnSZ9jTETGZ8/vwtmDt2ej3R7RT+Vpfr+MehN0/XWdsjv0YPdJWGxOCn9ZK02OfZjLw+4ujHhfWJmd6cnRnBcZtTao1WP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gQEsRAUM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so3738155ad.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713417875; x=1714022675; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RTmvBEErcjD5aHY5zUc6t4jtR6420JIpn91iQd/AW8M=;
        b=gQEsRAUMJOZFo4yXtaPsNZ8DPgyRdTS5amBreYnxB5EWDAKLpGUCNkiTQET/p38jnf
         kPaIRy9/WDX2PoLrjTFLlvlj5AEwtjQYZFeXalhxCpA6PAVURZ/eUAwfV4Bf89aLmqFg
         7Lwu2TW4i1k9qtn1Lw0T9A1K6NeEr0blu53quHt46GUJHvXjisxsAaLLpkgG1ts7IyWP
         3KDlHpMk5B5k2j+6ZyB0xKIG0cN3nMZM+nizddtkVR6DzDT4rruCtEjb/B2iL0aHHJLS
         vWc+pOPBGtifr7LNOigvz1smBntnKTUMVJ/YDmQhEpSCcBShSyK+8Zw4Uxv2CLPzQLEs
         qp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713417875; x=1714022675;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTmvBEErcjD5aHY5zUc6t4jtR6420JIpn91iQd/AW8M=;
        b=xJe/Ff7EFzs0lagOsZNhmysUsjSK7/pZ02HMZBUjwWZaHHl+M4bwyTdnTIbWysG9Ng
         6myKkjrqhCUgnceAB1Hpesh6OL1SdVNCkTRCv3573EEJFseH2YrefvFYwDSmHOwScMjk
         p6zX9CbVHJ8OzUEHFlIcNP4Z2BmiE0gQ5ebVzGMzhalurDQdovRFjCG8x1AX6ajsR5KG
         wQkrmABhYSthY/VHAYQAHtIUASWP2PE5Pj4n78G2UHmGyQwtsZ6hut9XjIv8LK1ZqhDP
         +v7TOO11Fzdg3AKoB5rUupfyZMzSDH+vbstzivIlczrTupxgagDUgPj6JqQvAqUNRlMa
         y52A==
X-Forwarded-Encrypted: i=1; AJvYcCU3PCUH6BsbN7B0QQ414MXAyJkHkOrc3WjWNiPgSitaWtU/ojjdyJ7J4w9BoxeesC4zdirWHZbRjwDWnhv46tcY+45vAMFfiC9W
X-Gm-Message-State: AOJu0Yxk+6hqe15vWvIoHqnr15j861eqvwYYBestJf/ae4a0j0GlZjq2
	FP/mncgTBa+/uZJMjKYUE9tuX7GbGSch7gWag7xvxgZ1mGZobb/WeRa8++Rshw==
X-Google-Smtp-Source: AGHT+IHEOOqHGUiSRn2TocR0J8LOMIOqxHp0qWssyNvOhSsUetlt1AXCFNMJ0XeZNG/NbwCklsQskw==
X-Received: by 2002:a17:902:d4c3:b0:1e2:abc5:e28b with SMTP id o3-20020a170902d4c300b001e2abc5e28bmr2131840plg.19.1713417874975;
        Wed, 17 Apr 2024 22:24:34 -0700 (PDT)
Received: from thinkpad ([120.56.197.253])
        by smtp.gmail.com with ESMTPSA id u7-20020a17090341c700b001e2a7fb6e01sm587621ple.44.2024.04.17.22.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 22:24:34 -0700 (PDT)
Date: Thu, 18 Apr 2024 10:54:29 +0530
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
Message-ID: <20240418052429.GA2861@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
 <20240320112928.GB2525@thinkpad>
 <20240414130058.GA2231@thinkpad>
 <6984ee8c-7848-46f8-a421-1b31d8c2231a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6984ee8c-7848-46f8-a421-1b31d8c2231a@amd.com>

On Thu, Apr 18, 2024 at 10:14:57AM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 4/14/2024 6:30 PM, Manivannan Sadhasivam wrote:
> > On Wed, Mar 20, 2024 at 04:59:28PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
> > > > Hi Mani,
> > > > 
> > > > On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
> > > > > As proposed during the last year 'PCI Endpoint Subsystem Open Items
> > > > > Discussion' of Linux Plumbers conference [1], let's migrate to Genalloc
> > > > > framework for managing the endpoint outbound window memory allocation.
> > > > > 
> > > > > PCI Endpoint subsystem is using a custom memory allocator in pci-epc-mem
> > > > > driver from the start for managing the memory required to map the host
> > > > > address space (outbound) in endpoint. Even though it works well, it
> > > > > completely defeats the purpose of the 'Genalloc framework', a general
> > > > > purpose memory allocator framework created to avoid various custom memory
> > > > > allocators in the kernel.
> > > > > 
> > > > > The migration to Genalloc framework is done is such a way that the existing
> > > > > API semantics are preserved. So that the callers of the EPC mem APIs do not
> > > > > need any modification (apart from the pcie-designware-epc driver that
> > > > > queries page size).
> > > > > 
> > > > > Internally, the EPC mem driver now uses Genalloc framework's
> > > > > 'gen_pool_first_fit_order_align' algorithm that aligns the allocated memory
> > > > > based on the requested size as like the previous allocator. And the
> > > > > page size passed during pci_epc_mem_init() API is used as the minimum order
> > > > > for the memory allocations.
> > > > > 
> > > > > During the migration, 'struct pci_epc_mem' is removed as it is seems
> > > > > redundant and the existing 'struct pci_epc_mem_window' in 'struct pci_epc'
> > > > > is now used to hold the address windows of the endpoint controller.
> > > > > 
> > > > > [1] https://lpc.events/event/17/contributions/1419/
> > > > 
> > > > Thank you for working on this!
> > > > > 
> > > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> > > > >    drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> > > > >    include/linux/pci-epc.h                         |  25 +---
> > > > >    3 files changed, 81 insertions(+), 140 deletions(-)
> > > > > 
> > > > .
> > > > .
> > > > > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > > > > index a9c028f58da1..f9e6e1a6aeaa 100644
> > > > > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > > > > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > > > > @@ -4,37 +4,18 @@
> > > > >     *
> > > > >     * Copyright (C) 2017 Texas Instruments
> > > > >     * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > > > > + *
> > > > > + * Copyright (C) 2024 Linaro Ltd.
> > > > > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > >     */
> > > > > +#include <linux/genalloc.h>
> > > > >    #include <linux/io.h>
> > > > >    #include <linux/module.h>
> > > > >    #include <linux/slab.h>
> > > > >    #include <linux/pci-epc.h>
> > > > > -/**
> > > > > - * pci_epc_mem_get_order() - determine the allocation order of a memory size
> > > > > - * @mem: address space of the endpoint controller
> > > > > - * @size: the size for which to get the order
> > > > > - *
> > > > > - * Reimplement get_order() for mem->page_size since the generic get_order
> > > > > - * always gets order with a constant PAGE_SIZE.
> > > > > - */
> > > > > -static int pci_epc_mem_get_order(struct pci_epc_mem *mem, size_t size)
> > > > > -{
> > > > > -	int order;
> > > > > -	unsigned int page_shift = ilog2(mem->window.page_size);
> > > > > -
> > > > > -	size--;
> > > > > -	size >>= page_shift;
> > > > > -#if BITS_PER_LONG == 32
> > > > > -	order = fls(size);
> > > > > -#else
> > > > > -	order = fls64(size);
> > > > > -#endif
> > > > > -	return order;
> > > > > -}
> > > > > -
> > > > >    /**
> > > > >     * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> > > > >     * @epc: the EPC device that invoked pci_epc_mem_init
> > > > > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > > >    			   struct pci_epc_mem_window *windows,
> > > > >    			   unsigned int num_windows)
> > > > >    {
> > > > > -	struct pci_epc_mem *mem = NULL;
> > > > > -	unsigned long *bitmap = NULL;
> > > > > -	unsigned int page_shift;
> > > > > +	struct pci_epc_mem_window *window = NULL;
> > > > >    	size_t page_size;
> > > > > -	int bitmap_size;
> > > > > -	int pages;
> > > > >    	int ret;
> > > > >    	int i;
> > > > > -	epc->num_windows = 0;
> > > > > -
> > > > >    	if (!windows || !num_windows)
> > > > >    		return -EINVAL;
> > > > > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> > > > >    		page_size = windows[i].page_size;
> > > > >    		if (page_size < PAGE_SIZE)
> > > > >    			page_size = PAGE_SIZE;
> > > > > -		page_shift = ilog2(page_size);
> > > > > -		pages = windows[i].size >> page_shift;
> > > > > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > > > > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > > > > -		if (!mem) {
> > > > > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > > > > +		if (!windows[i].pool) {
> > > > >    			ret = -ENOMEM;
> > > > > -			i--;
> > > > > -			goto err_mem;
> > > > > +			goto err_free_mem;
> > > > > +		}
> > > > > +
> > > > > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > > > > +				  NULL);
> > > > > +
> > > > > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> > > > 
> > > > Do you have to ioremap upfront the entire window? This could be a problem in
> > > > 32-bit systems which has limited vmalloc space. I have faced issues before
> > > > when trying to map the entire memory window and had to manipulate vmalloc
> > > > boot parameter.
> > > > 
> > > > I'd prefer we find a way to do ioremap per allocation as before.
> > > > 
> > > 
> > > Hmm, thanks for pointing it out. Current genalloc implementation works on the
> > > virtual address as opposed to physical address (that might be due to majority of
> > > its users managing the virtual address only). That's the reason I did ioremap of
> > > the entire window upfront.
> > > 
> > > Let me see if we can somehow avoid this.
> > > 
> > 
> > Looks like we have to introduce some good amount of change to support dynamic
> > ioremap with genalloc. But IMO it doesn't worth the effort to introduce these
> > changes for some old systems which are supposed to go away soon.
> > 
> > So I think we can keep the old and genalloc based allocators and use the old one
> > only for 32bit systems and genalloc allocator for the rest.
> > 
> > What do you think?
> 
> sure, that should be okay. But can we check with genalloc maintainers to see
> what they think?
> 

There seems to be no maintainer for genalloc. It was written way back in 2005
and improved by lot of folks. But there is no one to take care of it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

