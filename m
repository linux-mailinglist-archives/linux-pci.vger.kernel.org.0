Return-Path: <linux-pci+bounces-4951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4F48810B4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 12:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B51F1F21852
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9C3BBC8;
	Wed, 20 Mar 2024 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyvwzzud"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AB43FB86
	for <linux-pci@vger.kernel.org>; Wed, 20 Mar 2024 11:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933299; cv=none; b=oeRwTTVyjZnwqQDmasMPVree53ub6gxzgO2JpVYrNju15xAXvLXi0wXv4QMDwmnU4fLyndXg55n49cg7iQt6NHf2pNIU3vpwBFFz8Y+zUaVoiYdz+bIIq/OKDZ2NJeDmhc5hxM48NUq3Y8zFizJRs9K3PryV74yqiu3ZAlz2mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933299; c=relaxed/simple;
	bh=vXzKN1xeEbXo0yRIB/4wM4z1MRyzkM4ekKSJ2qPKkF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZPTLeak2tf+dimbjqi6sv3CGnKfbBW03Fg/2FgvCdufsoXxGnVcTjaXJ8yG5Z2jfyGXeiGXakEzd60zVHwz0STbv/bB+frEM9yf3tth6giGXoEbRMyX+BPnL1W7v0oLVrIhEcjQhuRawExAqs5kqb6vT9rFu5vYupb+pRsVQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyvwzzud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7940C433C7;
	Wed, 20 Mar 2024 11:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933298;
	bh=vXzKN1xeEbXo0yRIB/4wM4z1MRyzkM4ekKSJ2qPKkF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qyvwzzudwVvIKDUAkjRpiscSWFH74LV5t7lLIoYqIcwDsmWE7hfUML/0zTdeKRPGT
	 0F06BPujkOoeY44Cl19HoMHcFZi3qAOFvgMF6d//Ast8Y+DQ06vAsGQDvy9bfw06AN
	 j9ytJjp3ZKfSXpUWM0EYXAS6BABtEurzxPCI/at/wQE/6BEy0bJOzg4f9S1bvIN5uY
	 lWpgsVD97jO+V1+4vXA7b+PJoEUva+As/ACInj3Q77dv6nzHqrGTiELbiHUeaoqki/
	 eZzyironPvdkTrrO1PhfE5kblM8apTFgqmYjZgcLe28fAJo6es08tnRKN9MSXzJafI
	 /f5DU0NqXSeog==
Date: Wed, 20 Mar 2024 12:14:53 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shradha Todi <shradha.t@samsung.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 7/9] PCI: cadence: Set a 64-bit BAR if requested
Message-ID: <ZfrFLeXoU6XzEOEu@ryzen>
References: <20240313105804.100168-1-cassel@kernel.org>
 <20240313105804.100168-8-cassel@kernel.org>
 <20240315054616.GG3375@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315054616.GG3375@thinkpad>

On Fri, Mar 15, 2024 at 11:16:16AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Mar 13, 2024 at 11:57:59AM +0100, Niklas Cassel wrote:
> > Ever since commit f25b5fae29d4 ("PCI: endpoint: Setting a BAR size > 4 GB
> > is invalid if 64-bit flag is not set") it has been impossible to get the
> > .set_bar() callback with a BAR size > 4 GB, if the BAR was also not
> > requested to be configured as a 64-bit BAR.
> > 
> > Thus, forcing setting the 64-bit flag for BARs larger than 4 GB in the
> 
> 2 GB

Will fix in V4.


> 
> > lower level driver is dead code and can be removed.
> > 
> > It is however possible that an EPF driver configures a BAR as 64-bit,
> > even if the requested size is < 4 GB.
> > 
> > Respect the requested BAR configuration, just like how it is already
> > repected with regards to the prefetchable bit.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Okay, here you are fixing this driver. But this should be moved before patch
> 5/9. With that,

As I wrote in my reply to patch 5/9, I don't think we need to move them
around.

The code that sets flag PCI_BASE_ADDRESS_MEM_TYPE_64 in this driver is dead code,
it couldn't happen before this commit. So unless you insist, I think it is better
to keep the current ordering, such that all pci-epf-test patches are after each
other.


Kind regards,
Niklas

> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> - Mani
> 
> > ---
> >  drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > index 2d0a8d78bffb..de10e5edd1b0 100644
> > --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> > @@ -99,14 +99,11 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn, u8 vfn,
> >  		ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_IO_32BITS;
> >  	} else {
> >  		bool is_prefetch = !!(flags & PCI_BASE_ADDRESS_MEM_PREFETCH);
> > -		bool is_64bits = sz > SZ_2G;
> > +		bool is_64bits = !!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64);
> >  
> >  		if (is_64bits && (bar & 1))
> >  			return -EINVAL;
> >  
> > -		if (is_64bits && !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
> > -			epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
> > -
> >  		if (is_64bits && is_prefetch)
> >  			ctrl = CDNS_PCIE_LM_BAR_CFG_CTRL_PREFETCH_MEM_64BITS;
> >  		else if (is_prefetch)
> > -- 
> > 2.44.0
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

