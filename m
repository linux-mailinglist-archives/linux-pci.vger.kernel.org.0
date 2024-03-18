Return-Path: <linux-pci+bounces-4865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4871087E2C6
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 05:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22AB2816AC
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 04:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698E4C84;
	Mon, 18 Mar 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hexw4/Y7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4881B7E9
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 04:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710736267; cv=none; b=gRSN1n6VFMBFHxvxmyycoC/wcGZX7C3JTKyliEx9HPZ+hdBsd5z+31VtkWulh7GdKH8KjqauQ5QGrazao3kcCm3jJgEB0Bg6AYKF78nHHF6C1PXwfJTWg77SUFd6wQvFBvaXYnQubpXDuAk/oJwEKzQ49/XeD5s17IDSxhU1Zzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710736267; c=relaxed/simple;
	bh=VraJrZkXVcIiBqn/5GgUdxn7qkoZ3LpF3DMB9fUfbM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwolkHPzUUnNBgd1uPdmOrJbcWbl0s+fhcZEOodGkUvTrdzpnOlH7gJ5MxpsTxtxVJicHKbR95sHcLpyLBtkm285DrjjrUSwZ8tyDAiD2LBO/CYBr4x32nH7kxcLYmcXDVdt5zesIHGHY0Dwi4rp/lVgYN8gr5l9DlnO6KqNbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hexw4/Y7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dddb160a37so28191245ad.2
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2024 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710736265; x=1711341065; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FAUmNZjEXWrfWm3aX4u3ZDdFYXhSIGUztF8ORLBIzwM=;
        b=hexw4/Y7Bto9yNJhb8K1wApohbhCCnKcB7jswIY8qooHIWppVfU1jvZv7jMMsr16RA
         K9KsCRuRd1c7ZCD+dQbA3lTtWDVMQvPJm+i8Ej7G9kFSEF3fsbiKppmZAzsioBTkpD8L
         /Y4joBzTMl2yG6qQxkB5tx/cphMrncK0K0zw14E7CU9vzuZZemErZQoJ2Zx0DVe7yrgP
         LC/N9SPz6u6+BbqBpTj3kfDRGa5L+rb56i+4t1EP5i1b0m7BYLwLkLieQDKOgwKiliov
         3QQUbob5kvWHNSfGfWE/Qppbt5QzMTC5WM2v2c4B4Y1qFGYfV1xCNYCtkVycDx21AI51
         +6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710736265; x=1711341065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAUmNZjEXWrfWm3aX4u3ZDdFYXhSIGUztF8ORLBIzwM=;
        b=cIl3hWUeET78faT/Rn7o66S6k3H48poB7HycKtf3R0Ue9oKSVbkQ2KIPHoUBzWpex5
         UhWq0Cy+K7wGwXbWD/f72IhORdPWlJIrRXjf0MQT6jMPHLOot+UNxhylZQwXQpNazkVx
         op7SLgJ98UYT8xSYQYnp99SqjY9AqIXnVpvKpnnf7hk2eFtsu5YX+qksQmFR6/5YyL9A
         fIUbujgZa20l4O4nYSMMtoSJAmkIn6179mG5OBdm5ok7NKn+fng7WlkbT+/xGpmv+8uJ
         FQ9EbXuJlafA/2PCKdyt0RRsGaErSawbMbvrwAWkAoz1fEZZOp9897FNvN6LKVNUD4as
         k54w==
X-Forwarded-Encrypted: i=1; AJvYcCWwu+sYmHWH1wDDOWQG06Cxrk9l/Jh8A2rsfRC6iRkRbNOSUZKXpIUBwbEXoOOdKnC+wUIwZDp2T6Cu/2KIBh9pBjiUiFLP+zG4
X-Gm-Message-State: AOJu0Ywezjqem8nBB88z/V9oTtEf3bYlrMzqb6cw4WqwLqBQ0kdU9t3a
	79GNrvc4jJHilewO9MZcY72hQoza+k4nAutj1s/C6Lsi5iEsSPiiaGZ3mknmHw==
X-Google-Smtp-Source: AGHT+IFoczAkSWSnmRm7uM5+c+DxcSPNaw1gCTVN9B6kA81zDmOVx2X4LfQYrlOAIVco/1NPm6G8WA==
X-Received: by 2002:a17:902:9895:b0:1dd:b77a:d825 with SMTP id s21-20020a170902989500b001ddb77ad825mr11943719plp.28.1710736264707;
        Sun, 17 Mar 2024 21:31:04 -0700 (PDT)
Received: from thinkpad ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001dd99fe365dsm8256042pla.42.2024.03.17.21.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 21:31:04 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:00:58 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <20240318043058.GB2748@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
 <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>

On Fri, Mar 15, 2024 at 06:29:52PM +0100, Arnd Bergmann wrote:
> On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
> > On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
> >> "Generally only 64-bit BARs are good candidates, since only Legacy
> >> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
> >> and most scalable platforms map all 32-bit Memory BARs into
> >> non-prefetchable Memory Space regardless of the Prefetchable bit value."
> >> 
> >> "For a PCI Express Endpoint, 64-bit addressing must be supported for all
> >> BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
> >> for all BARs that do not have the Prefetchable bit Set."
> >> 
> >> "Any device that has a range that behaves like normal memory should mark
> >> the range as prefetchable. A linear frame buffer in a graphics device is
> >> an example of a range that should be marked prefetchable."
> >> 
> >> The PCIe spec tells us that we should have the prefetchable bit set for
> >> 64-bit BARs backed by "normal memory". The backing memory that we allocate
> >> for a 64-bit BAR using pci_epf_alloc_space() (which calls
> >> dma_alloc_coherent()) is obviously "normal memory".
> >> 
> >
> > I'm not sure this is correct. Memory returned by 'dma_alloc_coherent' is not the
> > 'normal memory' but rather 'consistent/coherent memory'. Here the question is,
> > can the memory returned by dma_alloc_coherent() be prefetched or write-combined
> > on all architectures.
> >
> > I hope Arnd can answer this question.
> 
> I think there are three separate questions here when talking about
> a scenario where a PCI master accesses memory behind a PCI endpoint:
> 
> - The CPU on the host side ususally uses ioremap() for mapping
>   the PCI BAR of the device. If the BAR is marked as prefetchable,
>   we usually allow mapping it using ioremap_wc() for write-combining
>   or ioremap_wt() for a write-through mappings that allow both
>   write-combining and prefetching. On some architectures, these
>   all fall back to normal register mappings which do none of these.
>   If it uses write-combining or prefetching, the host side driver
>   will need to manually serialize against concurrent access from
>   the endpoint side.
> 
> - The endpoint device accessing a buffer in memory is controlled
>   by the endpoint driver and may decide to prefetch data into a
>   local cache independent of the other two. I don't know if any
>   of the suppored endpoint devices actually do that. A prefetch
>   from the PCI host side would appear as a normal transaction here.
> 
> - The local CPU on the endpoint side may access the same buffer as
>   the endpoint device. On low-end SoCs the DMA from the PCI
>   endpoint is not coherent with the CPU caches, so the CPU may
>   need to map it as uncacheable to allow data consistency with
>   a the CPU on the PCI host side. On higher-end SoCs (e.g. most
>   non-ARM ones) DMA is coherent with the caches, so the CPU
>   on the endpoint side may map the buffer as cached and
>   still be coherent with a CPU on the PCI host side that has
>   mapped it with ioremap().
> 

Thanks Arnd for the reply.

But I'm not sure I got the answer I was looking for. So let me rephrase my
question a bit.

For BAR memory, PCIe spec states that,

'A PCI Express Function requesting Memory Space through a BAR must set the BAR's
Prefetchable bit unless the range contains locations with read side effects or
locations in which the Function does not tolerate write merging'

So here, spec refers the backing memory allocated on the endpoint side as the
'range' i.e, the BAR memory allocated on the host that gets mapped on the
endpoint.

Currently on the endpoint side, we use dma_alloc_coherent() to allocate the
memory for each BAR and map it using iATU.

So I want to know if the memory range allocated in the endpoint through
dma_alloc_coherent() satisfies the above two conditions in PCIe spec on all
architectures:

1. No Read side effects
2. Tolerates write merging

I believe the reason why we are allocating the coherent memory on the endpoint
first up is not all PCIe controllers are DMA coherent as you said above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

