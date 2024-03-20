Return-Path: <linux-pci+bounces-4952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D68810F2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5208C1C20AF2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B593BBC8;
	Wed, 20 Mar 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OM1DZP7l"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349C3D54B
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710934179; cv=none; b=a3wg0CNBfnDMQDVDA1gJdfoNTAS7He0/WHmTk6Uryg60lJWsHjzNq9PVKio6yWWifz8L/oQ19XcQi/vVdIcd/wlgxAouYkN+Fdm8zAH85DhOWrAFtBasfwOWfdRcdDqrimjorMOtePrQPLDFW0V5cRUBUZABiFQGc1M82rOhDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710934179; c=relaxed/simple;
	bh=OcApL4d7Arq8AjBdKl4uQc/K2QcIn0+ghw4HCVX9avY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OinytdB7i1s4o/6bP/9frD0nokTh8vRbs299zwc+ndpZ0g6V3raEo5L8p5pikd8PfUqetqZfhE50ebnoqmydoTBWvgkXN/S4K6zdEe/30EI4bABwmgu71z4vpFuv+6aPcheha/kzDNljQ+Nki8fxB7apa7KRw9q1nBSWb7vgb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OM1DZP7l; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1deffa23bb9so34091895ad.2
        for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 04:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710934177; x=1711538977; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=foBbDOK3qU2e/ouxw1I330bhNf/1gu0pIPvAkw9hmpU=;
        b=OM1DZP7l8KBZ3PAV6zJogydlPftdYiiZfXc+G4Hszc2o4tqepqPGkqjd5tOaxWkhyG
         5mNbYhbpaSDwHlsTRA7Vg8PzqMz988qtZ4Z3k5H9zaBwBGm7DzDakqoFqWmCVSFPH4X4
         D+/yw0K66NfW+7pXvbmhFiXGk/GdXVXFqZUEKGDNq1yiJ24L7fMq5Q3ZooumgnttMffX
         fPrJ5dgeL86Pn/iM5V8oO5RKDjnseM17mriNBMuqKYgKOSVMEb7je9oFXgUHPyA57CNW
         0nLwknez0vtQ4lmPQZAH3/k1UVx1AyqxOsA6c16puVlLUQNwIKjTWVtWuDo/xGdVH3ZX
         KeAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710934177; x=1711538977;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=foBbDOK3qU2e/ouxw1I330bhNf/1gu0pIPvAkw9hmpU=;
        b=QJVlbBiOJ7WK36wE93pLOW6iMDngM/a6d39Vu3qes2LWQHkaP7xXoPKunk0Rp5HInv
         U6tWZDgINsw0sPnaoih86WP/eJTNCU+kVXOMm8EGtRBDwN+DDPpgO74VSe52VAQbaqHd
         YerpOYiq10xjPN6Z9VWRMtDyUADdBFoOm3zfTHwRgfPnFl5E0KyqzZuauo6EHi0JfCUU
         bmG1McdK/09gOwTcxSErnOcyEbcr336aNx6ssbSR4eEg1XMBvLRSUHIJYyD5d8aGg0E8
         GFIW4qVDurVojzn3P7R5+gixkjsv1X0bH/hgkH4JutEyoceV6u352z2Cw9UNH0ivMDzq
         +Oxg==
X-Forwarded-Encrypted: i=1; AJvYcCUljerybTkE0zwIKCT2OY06lGZWjeWPmmzXqyQwb+yCnWdgAIYCI7VtRK1ADmCO9FFXL/1oVzaLRYijINIUojDYIoGmo5oTk7fW
X-Gm-Message-State: AOJu0YzqmeUpQPp11+98AFlrJVCrYcDSx3ZQNjaT+r1pdnY2u3cYOBEb
	p4W0QLhUM1S1eXCJO+h55nQHlpRV88lEJtw0uOLoGrtTL8PDCdpkOiKc98V4vw==
X-Google-Smtp-Source: AGHT+IE8V8wF2FV30LEbxFAaWf+vmCpGAEhYR9/Iz4zaW4K9EGVe0j06LoPmSTUT641/SPg96WrTtw==
X-Received: by 2002:a17:903:187:b0:1de:de58:2a55 with SMTP id z7-20020a170903018700b001dede582a55mr22557653plg.26.1710934177044;
        Wed, 20 Mar 2024 04:29:37 -0700 (PDT)
Received: from thinkpad ([117.207.18.167])
        by smtp.gmail.com with ESMTPSA id p20-20020a170902ead400b001db9cb62f7bsm13282507pld.153.2024.03.20.04.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 04:29:36 -0700 (PDT)
Date: Wed, 20 Mar 2024 16:59:28 +0530
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
Message-ID: <20240320112928.GB2525@thinkpad>
References: <20240317-pci-ep-genalloc-v1-1-70fe52a3b9be@linaro.org>
 <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37cfa724-f9ed-41ef-bad4-f00246a4ee8a@amd.com>

On Wed, Mar 20, 2024 at 03:26:41PM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 3/17/2024 11:39 AM, Manivannan Sadhasivam wrote:
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
> 
> Thank you for working on this!
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/controller/dwc/pcie-designware-ep.c |  14 +-
> >   drivers/pci/endpoint/pci-epc-mem.c              | 182 +++++++++---------------
> >   include/linux/pci-epc.h                         |  25 +---
> >   3 files changed, 81 insertions(+), 140 deletions(-)
> > 
> .
> .
> > diff --git a/drivers/pci/endpoint/pci-epc-mem.c b/drivers/pci/endpoint/pci-epc-mem.c
> > index a9c028f58da1..f9e6e1a6aeaa 100644
> > --- a/drivers/pci/endpoint/pci-epc-mem.c
> > +++ b/drivers/pci/endpoint/pci-epc-mem.c
> > @@ -4,37 +4,18 @@
> >    *
> >    * Copyright (C) 2017 Texas Instruments
> >    * Author: Kishon Vijay Abraham I <kishon@ti.com>
> > + *
> > + * Copyright (C) 2024 Linaro Ltd.
> > + * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >    */
> > +#include <linux/genalloc.h>
> >   #include <linux/io.h>
> >   #include <linux/module.h>
> >   #include <linux/slab.h>
> >   #include <linux/pci-epc.h>
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
> >   /**
> >    * pci_epc_multi_mem_init() - initialize the pci_epc_mem structure
> >    * @epc: the EPC device that invoked pci_epc_mem_init
> > @@ -48,17 +29,11 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >   			   struct pci_epc_mem_window *windows,
> >   			   unsigned int num_windows)
> >   {
> > -	struct pci_epc_mem *mem = NULL;
> > -	unsigned long *bitmap = NULL;
> > -	unsigned int page_shift;
> > +	struct pci_epc_mem_window *window = NULL;
> >   	size_t page_size;
> > -	int bitmap_size;
> > -	int pages;
> >   	int ret;
> >   	int i;
> > -	epc->num_windows = 0;
> > -
> >   	if (!windows || !num_windows)
> >   		return -EINVAL;
> > @@ -70,45 +45,51 @@ int pci_epc_multi_mem_init(struct pci_epc *epc,
> >   		page_size = windows[i].page_size;
> >   		if (page_size < PAGE_SIZE)
> >   			page_size = PAGE_SIZE;
> > -		page_shift = ilog2(page_size);
> > -		pages = windows[i].size >> page_shift;
> > -		bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
> > -		mem = kzalloc(sizeof(*mem), GFP_KERNEL);
> > -		if (!mem) {
> > +		windows[i].pool = gen_pool_create(ilog2(page_size), -1);
> > +		if (!windows[i].pool) {
> >   			ret = -ENOMEM;
> > -			i--;
> > -			goto err_mem;
> > +			goto err_free_mem;
> > +		}
> > +
> > +		gen_pool_set_algo(windows[i].pool, gen_pool_first_fit_order_align,
> > +				  NULL);
> > +
> > +		windows[i].virt_base = ioremap(windows[i].phys_base, windows[i].size);
> 
> Do you have to ioremap upfront the entire window? This could be a problem in
> 32-bit systems which has limited vmalloc space. I have faced issues before
> when trying to map the entire memory window and had to manipulate vmalloc
> boot parameter.
> 
> I'd prefer we find a way to do ioremap per allocation as before.
> 

Hmm, thanks for pointing it out. Current genalloc implementation works on the
virtual address as opposed to physical address (that might be due to majority of
its users managing the virtual address only). That's the reason I did ioremap of
the entire window upfront.

Let me see if we can somehow avoid this.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

