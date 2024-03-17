Return-Path: <linux-pci+bounces-4862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500E087DD17
	for <lists+linux-pci@lfdr.de>; Sun, 17 Mar 2024 12:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2CDB281011
	for <lists+linux-pci@lfdr.de>; Sun, 17 Mar 2024 11:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CE118EAD;
	Sun, 17 Mar 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQPLrWqQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDA117BDC
	for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2024 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710676457; cv=none; b=IvUdzmSMjp/J8xSYAsH5CwGd+o79Iha/ghSeaJkMHRDTu1mhKYF9TR9MpsmXJvi7Kct2E+LgExM023XVKRLcwktmljbCNt1tCPeWUwTH+KfcT7SMhjXl4qGAQ0FZdK699C4V6h91SAn8HxSRT2BSJ3LPOh92dXtv3KICJOzlcJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710676457; c=relaxed/simple;
	bh=nHSE4H5SQLJGvIIxNaV3DlS87Jl5fjkwcNA2TNQcwPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7RP7uEq3d9sYeGT4zWMwaEtL2gD18rczbnx9USPgO3VljhbVyzmJC3UGoNSHj+WbZi98M80+RTKqjheNEOrd2/wzVQdEmlQ7B8OmsAHnb8URaw3Nwh9p0pNTiDwMpWBdlaRTBtjS3YSzEu53jxdO9PV76SUwZgGx3opF3zJIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQPLrWqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD8FC433A6;
	Sun, 17 Mar 2024 11:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710676456;
	bh=nHSE4H5SQLJGvIIxNaV3DlS87Jl5fjkwcNA2TNQcwPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQPLrWqQdOIuXN5cOmkWBvLJEJtTcg/B8b25ltyLxo5kwHIuXFq6RtHFOc8fmfs96
	 N+G8UZW0IakBJzuP0droDWoOopZIhofp41B7RRYVAnXfelpPiCxvn/aom7YtDH0TfH
	 yajAm0QdIRRhECFur5Jx79akg2LFHHNbapzncxW4rWXWshuG2DLdx/bbWU7cbyVvDl
	 v4F57NbDhrsbf539j/Tg3HxwOb8z6OlkP99lHa1a2SgJ8mLyY9YJY0jn3jDoa6fJtH
	 ajk/EugAmUcF7/FEU0+jdTwBsnweZvPqup8wt2/Z09WnCZ9u5vNEmZQMnemQpZ2bsW
	 WzbinoOlLwyHQ==
Date: Sun, 17 Mar 2024 12:54:11 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 9/9] PCI: endpoint: Set prefetch when allocating
 memory for 64-bit BARs
Message-ID: <ZfbZ45-ZWZG6Wkcv@ryzen>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>

Hello all,

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

I think the question is if the PCI epf-core, which runs on the endpoint
side, and which calls dma_alloc_coherent() to allocate backing memory for
a BAR, can set/mark the Prefetchable bit for the BAR (if we also set/mark
the BAR as a 64-bit BAR).

The PCIe 6.0 spec, 7.5.1.2.1 Base Address Registers (Offset 10h - 24h),
states:
"Any device that has a range that behaves like normal memory should mark
the range as prefetchable. A linear frame buffer in a graphics device is
an example of a range that should be marked prefetchable."

Does not backing memory allocated for a specific BAR using
dma_alloc_coherent() on the EP side behave like normal memory from the
host's point of view?



On the host side, this will mean that the host driver sees the
Prefetchable bit, and as according to:
https://docs.kernel.org/driver-api/device-io.html
The host might map the BAR using ioremap_wc().

Looking specifically at drivers/misc/pci_endpoint_test.c, it maps the
BARs using pci_ioremap_bar():
https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pci.c#L252
which will not map it using ioremap_wc().
(But the code we have in the PCI epf-core must of course work with host
side drivers other than pci_endpoint_test.c as well.)


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

I don't follow. When doing DMA *from* the endpoint, then the DMA HW
on the EP side will read or write data to a buffer allocated on the
host side (most likely using dma_alloc_coherent()), but what does
that got to do with how the EP configures the BARs that it exposes?


>   need to map it as uncacheable to allow data consistency with
>   a the CPU on the PCI host side. On higher-end SoCs (e.g. most
>   non-ARM ones) DMA is coherent with the caches, so the CPU
>   on the endpoint side may map the buffer as cached and
>   still be coherent with a CPU on the PCI host side that has
>   mapped it with ioremap().


Kind regards,
Niklas

