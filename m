Return-Path: <linux-pci+bounces-4864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2635887E2AE
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 04:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70E71B20E19
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 03:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18391EB55;
	Mon, 18 Mar 2024 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OZhMJyxt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063A51E866
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 03:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710734014; cv=none; b=ZsPvhnw2gC0ZQ7ZQhTuuFHQo7TG9rxWNWp2eNBGxnU5p55a9eozwJ+8UKDuggTyrvL66YBvmD5fiD5GN8LBD57DtozCTSlZoZMjHx1gUkI5qm/JareGNCd3RuwyVNoZvGvFgITqQN21gN1JOMi4BBt+08xjxVTeXAC8jGVc8BHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710734014; c=relaxed/simple;
	bh=BPuynh27hYjA1FJlv2mR3rPWXwgaZUxU2GSK8pzC1jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1y004utbEAivtmANbIVADz9ibcnpOL1sIvHGDukKwhLmEnqDOwiEZPyqPc8Vb2AFv4ZwTJ1izm6r1hwih0CxM9blreZHvhL/8Tr8IxfkCdoorJ61ei7Z+EtmxivHPBbkuS+/irk26Gh/fylhzE2OU3oIWNeXds2855jugLHc9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OZhMJyxt; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e709e0c123so1013436b3a.1
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2024 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710734012; x=1711338812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bwJ3PzIo02nqEuJSnITbTqF29AmQmlSYdzsEx02HkPM=;
        b=OZhMJyxtIQlCzTuvToYFnYJD7xWBGA4B2JsRArDqYr4bIAGM4s5bSbC5ej98p8d9dD
         QjIkKdZTjbfdY8NYcF9ScjHXmFHIe2KV3VHki4GPOOXQ0RWAj+H7SPA8KQpE6L4vzt/s
         nXweDEg8PikMND6D3WNMHcOJa4TIMqAb12VWcwqKpdJG/cq5FnvOht8GCe8bkmrFnNmN
         pzDth9JXRiUpmQyleubuKGy+z7SrPuD4qvMEKYWlOxeaXMQCh6WOaqjcrxP7aMo7t+Gt
         z+yL6/v4r1USVCBY2UwJdWy7EOyheFeSWsVs22uO/Klth1FAJHIkE6dVbZx+MnF6nLmk
         /M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710734012; x=1711338812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bwJ3PzIo02nqEuJSnITbTqF29AmQmlSYdzsEx02HkPM=;
        b=oH0twW5Y02DstoFvzt63ZylbVkSntzYD2rt5FpHYLLqwgPzICV/8XvXejbjZOCZ+pk
         BVgv/1Zg32kG9B7Yc32eIfrw9NxoykSHFXINS7q755BAJhTzlBPnMhi78ixq3I9OylKL
         eV2gQw4gNhNC41gb+7Wez8mwWEXbPjZr01BE0HHVvoyd4RU7Hlk499d80//MV+0nfLbf
         0R1TjRyAICIWMOb9HTTQZtxhSU/q15suCadAzjXSNDDy2yB3hLLQ3nO8+MZ2TgJMk8NL
         VDNwS7Ej2MfItuUVa/MoogHno41shmmCdqPogOvMilTBEb0gNtymUVTvzRVEzjRt3zR6
         xGkg==
X-Forwarded-Encrypted: i=1; AJvYcCV24Ie8516W2dUCgsmUPjZuDlxbrQQ1dGjyiPlfz4PayBfGoRllBIcTBpIordU6cC3B/WkO/q9awDcP8GcShjdu6OwzmQ0tYm/w
X-Gm-Message-State: AOJu0Yytk0VWcFmmQZCUNMnW5qHv5RebaREWveZYXR60L/5eqfJU5/2h
	n/C9C1OSBAY6H98v8uxeJ3bQIQZEal8obrjKmiS2Pcb6CsaoZJ/vxnEMjhuFKg==
X-Google-Smtp-Source: AGHT+IHuS0RJJQl0+17Umn8JmVi8FXA1mtkyd8ReIc4P+SK6pTOsu3ZoVkqLyvhxSkt5UcCkgpZ+GQ==
X-Received: by 2002:a05:6a21:33a3:b0:1a3:560c:15d8 with SMTP id yy35-20020a056a2133a300b001a3560c15d8mr4130431pzb.41.1710734011964;
        Sun, 17 Mar 2024 20:53:31 -0700 (PDT)
Received: from thinkpad ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b001dd7d66ac95sm8143603plk.78.2024.03.17.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 20:53:31 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:23:27 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <20240318035327.GA2748@thinkpad>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
 <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <ZfbZ45-ZWZG6Wkcv@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfbZ45-ZWZG6Wkcv@ryzen>

On Sun, Mar 17, 2024 at 12:54:11PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> On Fri, Mar 15, 2024 at 06:29:52PM +0100, Arnd Bergmann wrote:
> > On Fri, Mar 15, 2024, at 07:44, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 13, 2024 at 11:58:01AM +0100, Niklas Cassel wrote:
> > >> "Generally only 64-bit BARs are good candidates, since only Legacy
> > >> Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
> > >> and most scalable platforms map all 32-bit Memory BARs into
> > >> non-prefetchable Memory Space regardless of the Prefetchable bit value."
> > >> 
> > >> "For a PCI Express Endpoint, 64-bit addressing must be supported for all
> > >> BARs that have the Prefetchable bit Set. 32-bit addressing is permitted
> > >> for all BARs that do not have the Prefetchable bit Set."
> > >> 
> > >> "Any device that has a range that behaves like normal memory should mark
> > >> the range as prefetchable. A linear frame buffer in a graphics device is
> > >> an example of a range that should be marked prefetchable."
> > >> 
> > >> The PCIe spec tells us that we should have the prefetchable bit set for
> > >> 64-bit BARs backed by "normal memory". The backing memory that we allocate
> > >> for a 64-bit BAR using pci_epf_alloc_space() (which calls
> > >> dma_alloc_coherent()) is obviously "normal memory".
> > >> 
> > >
> > > I'm not sure this is correct. Memory returned by 'dma_alloc_coherent' is not the
> > > 'normal memory' but rather 'consistent/coherent memory'. Here the question is,
> > > can the memory returned by dma_alloc_coherent() be prefetched or write-combined
> > > on all architectures.
> > >
> > > I hope Arnd can answer this question.
> > 
> > I think there are three separate questions here when talking about
> > a scenario where a PCI master accesses memory behind a PCI endpoint:
> 
> I think the question is if the PCI epf-core, which runs on the endpoint
> side, and which calls dma_alloc_coherent() to allocate backing memory for
> a BAR, can set/mark the Prefetchable bit for the BAR (if we also set/mark
> the BAR as a 64-bit BAR).
> 
> The PCIe 6.0 spec, 7.5.1.2.1 Base Address Registers (Offset 10h - 24h),
> states:
> "Any device that has a range that behaves like normal memory should mark
> the range as prefetchable. A linear frame buffer in a graphics device is
> an example of a range that should be marked prefetchable."
> 
> Does not backing memory allocated for a specific BAR using
> dma_alloc_coherent() on the EP side behave like normal memory from the
> host's point of view?
> 
> 
> 
> On the host side, this will mean that the host driver sees the
> Prefetchable bit, and as according to:
> https://docs.kernel.org/driver-api/device-io.html
> The host might map the BAR using ioremap_wc().
> 
> Looking specifically at drivers/misc/pci_endpoint_test.c, it maps the
> BARs using pci_ioremap_bar():
> https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pci.c#L252
> which will not map it using ioremap_wc().
> (But the code we have in the PCI epf-core must of course work with host
> side drivers other than pci_endpoint_test.c as well.)
> 
> 

Right. I don't see any problem with the host side assumption. But my question
is, is it OK to advertise the coherent memory allocated on the endpoint as
prefetchable to the host.

As you quoted the spec,

"Any device that has a range that behaves like normal memory should mark
the range as prefetchable."

Here, the coherent memory allocated by the device(endpoint) won't behave as a
normal memory on the _endpoint_. But I'm certainly not sure if there are any
implications in exposing this memory as a 'normal memory' to the host.

- Mani

> > 
> > - The CPU on the host side ususally uses ioremap() for mapping
> >   the PCI BAR of the device. If the BAR is marked as prefetchable,
> >   we usually allow mapping it using ioremap_wc() for write-combining
> >   or ioremap_wt() for a write-through mappings that allow both
> >   write-combining and prefetching. On some architectures, these
> >   all fall back to normal register mappings which do none of these.
> >   If it uses write-combining or prefetching, the host side driver
> >   will need to manually serialize against concurrent access from
> >   the endpoint side.
> > 
> > - The endpoint device accessing a buffer in memory is controlled
> >   by the endpoint driver and may decide to prefetch data into a
> >   local cache independent of the other two. I don't know if any
> >   of the suppored endpoint devices actually do that. A prefetch
> >   from the PCI host side would appear as a normal transaction here.
> > 
> > - The local CPU on the endpoint side may access the same buffer as
> >   the endpoint device. On low-end SoCs the DMA from the PCI
> >   endpoint is not coherent with the CPU caches, so the CPU may
> 
> I don't follow. When doing DMA *from* the endpoint, then the DMA HW
> on the EP side will read or write data to a buffer allocated on the
> host side (most likely using dma_alloc_coherent()), but what does
> that got to do with how the EP configures the BARs that it exposes?
> 
> 
> >   need to map it as uncacheable to allow data consistency with
> >   a the CPU on the PCI host side. On higher-end SoCs (e.g. most
> >   non-ARM ones) DMA is coherent with the caches, so the CPU
> >   on the endpoint side may map the buffer as cached and
> >   still be coherent with a CPU on the PCI host side that has
> >   mapped it with ioremap().
> 
> 
> Kind regards,
> Niklas

-- 
மணிவண்ணன் சதாசிவம்

