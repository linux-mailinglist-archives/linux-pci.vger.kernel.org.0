Return-Path: <linux-pci+bounces-4327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D82D86E322
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 15:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5591F22CBE
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 14:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48276EF16;
	Fri,  1 Mar 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBkLgnxY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138A6D1A3
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 14:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302544; cv=none; b=arxRWqvZBgl0UgayTRj9W96NliSLOfWrRN+g6e9dRqNOsHdnS4eGI0sC4PkmZx2znT91MmRyqhGNxiMywhRwmYCXWfI8oLS5NH68EbcpxP0LrTA3dtbUsuACyu7nPCSMkIkxEJlVnqYMX85Ehi9Qf3PAnwUIEpuMYiRVHXPDIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302544; c=relaxed/simple;
	bh=5yD+ouLpM5/BEZ5lWwxqEFp8KD2dIFK7+Vh0jNPp2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfgZNw/4K4vtTFqWVn6YO1ca7Hs31HdeQNnoY6GXZL2JD32zB+UHG0nqHxat1rkGlHOKlPcdoZnC7af2DAUqoszPZJO41/EJAY4KUdU2EeEx+dMGGHx5UMj/2Tf6zlDzzW2kCqhNZ3poGt4sGZi+UtIJWcYe3MlDzr2uwqYNyhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBkLgnxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306CDC433C7;
	Fri,  1 Mar 2024 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709302544;
	bh=5yD+ouLpM5/BEZ5lWwxqEFp8KD2dIFK7+Vh0jNPp2eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBkLgnxYCwub9BPQy/z4Qm87/aHyTJID4Q3j9z9qg9X9mMaUR0DyM8U/lbxmPranw
	 x/NfgYdJBhg7vS45KamuKoQ1PZqMG/ie3yMmstZ5ysWARSgckw39tp4m1Nz7eoWjqm
	 NfB4YXB+dZ++IKYDMdhvuQtymw84cKssVCj7zwyMbXz3vDIjuumCwQ0iUcYcWV1Gtm
	 37Eta4hgDgijtTiCrr0ZgfgyAzeewIYd4+gvXljhlwzNPVSq4UbvZp0Q69DC+PISvR
	 UgkLErCtpaCERw8AydjidTaCVCQ39xunivAXuXRquYdBVg7BEwWZa6SxMOyM3yKHtk
	 hy4GjJwVKB4pw==
Date: Fri, 1 Mar 2024 15:15:38 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Lorenzo Pieralisi' <lpieralisi@kernel.org>,
	'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>,
	'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>,
	'Kishon Vijay Abraham I' <kishon@kernel.org>,
	'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: endpoint: Set prefetch when allocating memory
 for 64-bit BARs
Message-ID: <ZeHjCm13UHpPnHOi@fedora>
References: <20240229104900.894695-1-cassel@kernel.org>
 <20240229104900.894695-3-cassel@kernel.org>
 <CGME20240229183745epcas5p31e5cdc286a1d879e5e3d552adefd1964@epcas5p3.samsung.com>
 <ZeDO8RakU49eqXAl@fedora>
 <001001da6bc4$725e36b0$571aa410$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001001da6bc4$725e36b0$571aa410$@samsung.com>

Hello Shradha,

On Fri, Mar 01, 2024 at 04:07:21PM +0530, Shradha Todi wrote:
> 
> 
> > -----Original Message-----
> > From: Niklas Cassel <cassel@kernel.org>
> > Sent: 01 March 2024 00:08
> > To: Lorenzo Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński
> > <kw@linux.com>; Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org>; Kishon Vijay Abraham I
> > <kishon@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Shradha Todi <shradha.t@samsung.com>; linux-pci@vger.kernel.org
> > Subject: Re: [PATCH 2/2] PCI: endpoint: Set prefetch when allocating memory
> for
> > 64-bit BARs
> > 
> > On Thu, Feb 29, 2024 at 11:48:59AM +0100, Niklas Cassel wrote:
> > > From the PCIe 6.0 base spec:
> > > "Generally only 64-bit BARs are good candidates, since only Legacy
> > > Endpoints are permitted to set the Prefetchable bit in 32-bit BARs,
> > > and most scalable platforms map all 32-bit Memory BARs into
> > > non-prefetchable Memory Space regardless of the Prefetchable bit value."
> > >
> > > "For a PCI Express Endpoint, 64-bit addressing must be supported for
> > > all BARs that have the Prefetchable bit Set. 32-bit addressing is
> > > permitted for all BARs that do not have the Prefetchable bit Set."
> > >
> > > "Any device that has a range that behaves like normal memory should
> > > mark the range as prefetchable. A linear frame buffer in a graphics
> > > device is an example of a range that should be marked prefetchable."
> > >
> > > The PCIe spec tells us that we should have the prefetchable bit set
> > > for 64-bit BARs backed by "normal memory". The backing memory that we
> > > allocate for a 64-bit BAR using pci_epf_alloc_space() (which calls
> > > dma_alloc_coherent()) is obviously "normal memory".
> > >
> > > Thus, set the prefetchable bit when allocating backing memory for a
> > > 64-bit BAR.
> > >
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > >  drivers/pci/endpoint/pci-epf-core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pci/endpoint/pci-epf-core.c
> > > b/drivers/pci/endpoint/pci-epf-core.c
> > > index e7dbbeb1f0de..10264d662abf 100644
> > > --- a/drivers/pci/endpoint/pci-epf-core.c
> > > +++ b/drivers/pci/endpoint/pci-epf-core.c
> > > @@ -305,7 +305,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t
> > size, enum pci_barno bar,
> > >  	epf_bar[bar].size = size;
> > >  	epf_bar[bar].barno = bar;
> > >  	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> > > -		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > > +		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64 |
> > > +				      PCI_BASE_ADDRESS_MEM_PREFETCH;
> > >  	else
> > >  		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
> > 
> > This should probably be:
> > 
> > if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
> > 	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64; else
> > 	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_32;
> > 
> > if (epf_bar[bar].flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
> > 	epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
> > 
> > so that we set PREFETCH even for a EPF driver that had
> > PCI_BASE_ADDRESS_MEM_TYPE_64 set in flags even before calling
> > pci_epf_alloc_space. Will fix in V2.
> > 
> > 
> > 
> > 
> > I also found a bug in the existing code.
> > If pci_epf_alloc_space() allocated a 64-bit BAR because of bits in size, then
> the
> > increment in pci_epf_test_alloc_space() was incorrect.
> > (I guess no one uses BARs > 4GB).
> > 
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -865,6 +865,12 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >                         dev_err(dev, "Failed to allocate space for BAR%d\n",
> >                                 bar);
> >                 epf_test->reg[bar] = base;
> > +
> > +               /*
> > +                * pci_epf_alloc_space() might have given us a 64-bit BAR,
> > +                * even if we only requested a 32-bit BAR.
> > +                */
> > +               add = (epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ?
> > + 2 : 1;
> > 
> > Will send a separate fix with the above.
> > 
> > 
> > Kind regards,
> > Niklas
> 
> Hi Niklas,
> 
> A similar fix should go for pci_epf_test_set_bar() as well, since
> pci_epc_set_bar()
> may change the flags.

I do see that this text is here:
https://github.com/torvalds/linux/blob/v6.8-rc6/drivers/pci/endpoint/functions/pci-epf-test.c#L725-L729

Looking at the orginal author of that text:
https://github.com/torvalds/linux/commit/fca83058753456528bef62579ae2b50799d7a473
(turned out that it was me :p)

I see that the reason was that epc->ops->set_bar() for Cadence EP controller
could set PCI_BASE_ADDRESS_MEM_TYPE_64 even if only 32 bits BAR was requested.

Looking at the Cadence set_bar():
https://github.com/torvalds/linux/blob/master/drivers/pci/controller/cadence/pcie-cadence-ep.c#L107-L108
They do set a 64-bit even if a user only requested a 32-bit BAR,
if the requested BAR size was > 4G.

However, we have this check:
https://github.com/torvalds/linux/commit/f25b5fae29d4e5fe6ae17d3f898a959d72519b6a

So that would never happen. pci_epc_set_bar() would error out before calling
the lower level device driver with such a requested configuration.


Now when we have epc_features, if a BAR requires 64-bits, they should set that
as a hardware requirement in epc_features.

A epc->ops->set_bar() should never be allowed to override whas is being
requested IMO.
(It could give an error if it can't fulfill the requested configuration though.)

So what I think should be done:
1) Clean up the Cadence driver, since that code is dead code.
2) Remove the "pci_epc_set_bar() might have given us a 64-bit BAR",
   since it is not true.


Note that pci_epf_test_set_bar() still needs to do:
https://github.com/torvalds/linux/blob/master/drivers/pci/endpoint/functions/pci-epf-test.c#L730

But that is because pci_epf_alloc_space() could have set
PCI_BASE_ADDRESS_MEM_TYPE_64. But I don't think that we need a comment for this,
just like how the "add =" in pci_epf_test_alloc_space() does not have a comment:
https://github.com/torvalds/linux/blob/v6.8-rc6/drivers/pci/endpoint/functions/pci-epf-test.c#L860


Kind regards,
Niklas

