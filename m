Return-Path: <linux-pci+bounces-4876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4A887EBD2
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 16:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A7D1F2155B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 15:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A36F4E1C5;
	Mon, 18 Mar 2024 15:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qesTpJ1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6D4F1E0
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774823; cv=none; b=TM0p7K7+rzU9ltWleEbpOgoc0sqAxJ8W0XJyrKEb0y+zkx2C2cSVGDynyJjWNq0ldEc5vXsHWtmGzmT8Mt82rFgXgBggrLClb1ZZ8pS2wFaZTK90zBJJ64yXrzxCrSmU9LWcbnWf5+rlOX7zIxZ0Xq9LFEk++H2axPUhXAd6wIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774823; c=relaxed/simple;
	bh=IlU/Kzwz4QV9EcZ9elStkgnRHAO/5o9xBH6Odcd9Qs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdnY5QA6u4K+I1BOwyrF9kR/sPPuToktWktB9AUM5pmJhEmm5BEL/IS8RVS7O4p4TVWDM3l3VFssD0hAfHiFZg+Pt6E0apl+Bw73Zr+jeIJG5fKgWd/kGoJfxGY+DgBzBNpE8ehu8SRvXLbxdhX47cxDR82dv5gaOkL/E0YG3aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qesTpJ1U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95856C433F1;
	Mon, 18 Mar 2024 15:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774822;
	bh=IlU/Kzwz4QV9EcZ9elStkgnRHAO/5o9xBH6Odcd9Qs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qesTpJ1U0Nm3gvGiWoJ+GyLMWvJPLq7vr7hCTJLlf9NWhfJtsGZlL9oSnpFz0vjbT
	 86kimMhK4nwJJG+ILpcaKJS5Ers9EY5PAuo3nagH2B7WyhvrBK1sVbI95zlM+kur8E
	 2ftYMPh+BCeX2/bm52fu+nXr6EincFwYELeTbmaD2iawEoKWgQiJIbyh2e2grVyxc+
	 NwNn+PY3zg6/38b+aKE+sSOzlliXfJBJDWFKrvu0/uKEJqobvedCVxP2juJSeFur2L
	 3nw5ViNoQyEBzcHwVb5jDUZTTkYSUChSkoqoFLkg79HrHDawRRdbrLi+ciXqRgzu2z
	 L+qtvOPNmIrHw==
Date: Mon, 18 Mar 2024 16:13:37 +0100
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
Message-ID: <ZfhaIbTcy0vgdT1A@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-10-cassel@kernel.org>
 <20240315064408.GI3375@thinkpad>
 <9173aa22-4c15-40ec-bf70-39d25eebe4c2@app.fastmail.com>
 <ZfbZ45-ZWZG6Wkcv@ryzen>
 <7003f4e3-fe3c-43d7-8562-efaacc3d65d3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7003f4e3-fe3c-43d7-8562-efaacc3d65d3@app.fastmail.com>

Hello Arnd,

On Mon, Mar 18, 2024 at 08:25:36AM +0100, Arnd Bergmann wrote:
> 
> I'm not sure I follow this logic: If the device wants the
> buffer to act like "normal memory", then it can be marked
> as prefetchable and mapped into the host as write-combining,
> but I think in this case you *don't* want it to be coherent
> on the endpoint side either but use a streaming mapping with
> explicit cache management instead.
> 
> Conversely, if the endpoint side requires a coherent mapping,
> then I think you will want a strictly ordered (non-wc,
> non-frefetchable) mapping on the host side as well.
> 
> It would be helpful to have actual endpoint function drivers
> in the kernel rather than just the test drivers to see what type
> of serialization you actually want for best performance on
> both sides.

Yes, that would be nice.

This specific API, pci_epf_alloc_space(), is only used by the
following drivers:
drivers/pci/endpoint/functions/pci-epf-test.c
drivers/pci/endpoint/functions/pci-epf-ntb.c
drivers/pci/endpoint/functions/pci-epf-vntb.c

pci_epf_alloc_space() is only used to allocate backing
memory for the BARs.


> 
> Can you give a specific example of an endpoint that you are
> actually interested in, maybe just one that we have a host-side
> device driver for in tree?

I personally just care about pci-epf-test, but obviously I don't
want to regress any other user of pci_epf_alloc_space().

Looking at the endpoint side driver:
drivers/pci/endpoint/functions/pci-epf-test.c
and the host side driver:
drivers/misc/pci_endpoint_test.c

On the RC side, allocating buffers that the EP will DMA to is
done using: kzalloc() + dma_map_single().

On EP side:
drivers/pci/endpoint/functions/pci-epf-test.c
uses dma_map_single() when using DMA, and signals completion using MSI.

On EP side:
When reading/writing to the BARs, it simply does:
READ_ONCE()/WRITE_ONCE():
https://github.com/torvalds/linux/blob/v6.8/drivers/pci/endpoint/functions/pci-epf-test.c#L643-L648

There is no dma_sync(), so the pci-test-epf driver currently seems to
depend on the backing memory being allocated by dma_alloc_coherent().


> If you don't care about ordering on that level, I would use
> dma_map_sg() on the endpoint side and prefetchable mapping on
> the host side, with the endpoint using dma_sync_*() to pass
> buffer ownership between the two sides, as controlled by some
> other communication method (non-prefetchable BAR, MSI, ...).

I don't think that there is no big reason why pci-epf-test is
implemented using dma_alloc_coherent() rather than dma_sync()
for the memory backing the BARs, but that is the way it is.

Since I don't feel like totally rewriting pci-epf-test, and since
you say that we shouldn't use dma_alloc_coherent() for the memory
backing the BARs together with exporting the BAR as prefetchable,
I will drop this patch from the series in the next revision.


Kind regards,
Niklas

