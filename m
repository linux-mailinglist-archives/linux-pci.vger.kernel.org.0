Return-Path: <linux-pci+bounces-3428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8920485431C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 07:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E59C1F215A1
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 06:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DDE79E4;
	Wed, 14 Feb 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSoAnG7n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A240B11193
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893718; cv=none; b=CmOs4HZgn7G/5zU1+6Vs1jEgur2ZrIWSV27sNGj9vGzJZ7mXLDKJGykYzmXc2MzL8Ff1uvRnbM+GnnuzwZzCwJLEbEP/iJ1FZzJeAMKrWe1ymdHmuhhuLfeG1n354YWGWvLi2y1uJX8I7kVHinH2ZVwyWM3zqYCtRqNkQrI+hRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893718; c=relaxed/simple;
	bh=FnMTsGlB+S1pSgB1frz6lz54ywQWNkFc3hnp+HAmVsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuaWRP4c5I8MsDNCVrsIeIFgF/ZIscftOpeiLtXTAGdN5lk9nYvMBbGrp/VXe2vv/cTch6KQH5CP99N/fOshm74SHUsFJllaiPPVogABsbGA6Ohi+kMz2eqtr4Gz1mYROVYYeJ2VCKLM/8tSeRaGGNDxOtI7Loue7rMqioExi+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSoAnG7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD58C433F1;
	Wed, 14 Feb 2024 06:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707893718;
	bh=FnMTsGlB+S1pSgB1frz6lz54ywQWNkFc3hnp+HAmVsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSoAnG7nzHtBdVHH2A+/lteb2VtzEn6qfMhimH/4MaK1g4LQSR4DHgrEHa/vXXNJ7
	 QOCKhaMjGm3y/cHLUXzvDbpu3gcw4PeVsHcsaErcL3EpJd2JH/tkR+If6anFth5bgc
	 9l+dP/cNjSnJHLpjDMliPyTToN/GJDbM3N1v06gZegARLFuiKlaFB5KCf0O0ZOdInp
	 8e9uKMbIm2BplFtRfuwhCKAguAWIUO3QZtoBKJUEfkJ5OELedEnfKQhnAj7jdhD8V5
	 7jceq9L//O/Sb9YrQI60f2u1lRiXlzHAs1lqq7VAPyHBvoFq1/Gi6SqPgC+4mop/jD
	 UOxsebzZGsltA==
Date: Wed, 14 Feb 2024 12:25:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <20240214065509.GD4618@thinkpad>
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
 <ZcJhhHK6eQOUfVKf@google.com>
 <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>
 <ZcrZdhay6YvBzvWt@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcrZdhay6YvBzvWt@google.com>

On Tue, Feb 13, 2024 at 08:22:38AM +0530, Ajay Agarwal wrote:
> On Tue, Feb 06, 2024 at 07:53:19PM +0300, Serge Semin wrote:
> > On Tue, Feb 06, 2024 at 10:12:44PM +0530, Ajay Agarwal wrote:
> > > On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> > > > On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> > > > > There can be platforms that do not use/have 32-bit DMA addresses
> > > > > but want to enumerate endpoints which support only 32-bit MSI
> > > > > address. The current implementation of 32-bit IOVA allocation can
> > > > > fail for such platforms, eventually leading to the probe failure.
> > > > > 
> > > > > If there vendor driver has already setup the MSI address using
> > > > > some mechanism, use the same. This method can be used by the
> > > > > platforms described above to support EPs they wish to.
> > > > > 
> > > > > Else, if the memory region is not reserved, try to allocate a
> > > > > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > > > > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > > > > address is allocated, then the EPs supporting 32-bit MSI address
> > > > > will not work.
> > > > > 
> > > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > > ---
> > > > > Changelog since v2:
> > > > >  - If the vendor driver has setup the msi_data, use the same
> > > > > 
> > > > > Changelog since v1:
> > > > >  - Use reserved memory, if it exists, to setup the MSI data
> > > > >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > > > > 
> > > > >  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
> > > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > index d5fc31f8345f..512eb2d6591f 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >  	 * order not to miss MSI TLPs from those devices the MSI target
> > > > >  	 * address has to be within the lowest 4GB.
> > > > >  	 *
> > > > 
> > > > > -	 * Note until there is a better alternative found the reservation is
> > > > > -	 * done by allocating from the artificially limited DMA-coherent
> > > > > -	 * memory.
> > > > 
> > > > Why do you keep deleting this statement? The driver still uses the
> > > > DMA-coherent memory as a workaround. Your solution doesn't solve the
> > > > problem completely. This is another workaround. One more time: the
> > > > correct solution would be to allocate a 32-bit address or some range
> > > > within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
> > > > Your solution relies on the platform firmware/glue-driver doing that,
> > > > which isn't universally applicable. So please don't drop the comment.
> > > >
> > > ACK.
> > > 
> > > > > +	 * Check if the vendor driver has setup the MSI address already. If yes,
> > > > > +	 * pick up the same.
> > > > 
> > > > This is inferred from the code below. So drop it.
> > > > 
> > > ACK.
> > > 
> > > > > This will be helpful for platforms that do not
> > > > > +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> > > > > +	 * only 32-bit MSI address.
> > > > 
> > > > Please merge it into the first part of the comment as like: "Permit
> > > > the platforms to override the MSI target address if they have a free
> > > > PCIe-bus memory specifically reserved for that."
> > > > 
> > > ACK.
> > > 
> > > > > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > > > > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > > > > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > > > > +	 * supporting 32-bit MSI address will not work.
> > > > 
> > > > This is easily inferred from the code below. So drop it.
> > > > 
> > > ACK.
> > > 
> > > > >  	 */
> > > > 
> > > > > +	if (pp->msi_data)
> > > > 
> > > > Note this is a physical address for which even zero value might be
> > > > valid. In this case it's the address of the PCIe bus space for which
> > > > AFAICS zero isn't reserved for something special.
> > > >
> > 
> > > That is a fair point. What do you suggest we do? Shall we define another
> > > op `set_msi_data` (like init/msi_init/start_link) and if it is defined
> > > by the vendor, then call it? Then vendor has to set the pp->msi_data
> > > there? Let me know.
> > 
> > You can define a new capability flag here
> > drivers/pci/controller/dwc/pcie-designware.h (see DW_PCIE_CAP_* macros)
> > , set it in the glue driver by means of the dw_pcie_cap_set() macro
> > function and instead of checking msi_data value test the flag for
> > being set by dw_pcie_cap_is().
> >
> Sure, good suggestion. ACK.
> 
> > > 
> > > > > +		return 0;
> > > > > +
> > > > >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > > >  	if (ret)
> > > > >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > > > @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > >  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > >  					GFP_KERNEL);
> > > > >  	if (!msi_vaddr) {
> > > > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > -		dw_pcie_free_msi(pp);
> > > > > -		return -ENOMEM;
> > > > > +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > > > > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > +						GFP_KERNEL);
> > > > > +		if (!msi_vaddr) {
> > > > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > +			dw_pcie_free_msi(pp);
> > > > > +			return -ENOMEM;
> > > > > +		}
> > > > 
> > > > On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> > > > > Yeah, something like that. Personally I'd still be tempted to try some
> > > > > mildly more involved logic to just have a single dev_warn(), but I think
> > > > > that's less important than just having something which clearly works.
> > > > 
> > > > I guess this can be done but in a bit clumsy way. Like this:
> > > > 
> > > > 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
> > > > 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > > 	if (ret) {
> > > > 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
> > > > 
> > > > 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > > 		if (ret) {
> > > > 			dev_err(dev, "Failed to allocate MSI target address\n");
> > > > 			return -ENOMEM;
> > > 
> > > As you pointed out already, this looks pretty clumsy. I think we should
> > > stick to the more descriptive and readable code that I suggested.
> > 
> > I do not know which solution is better really. Both have pros and
> > cons. Let's wait for Bjorn, Mani or Robin opinion about this.
> > 
> > -Serge(y)
> > 
> Bjorn/Mani/Robin,
> Can you please provide your comment?
> 

Sergey's suggestion masks out the error coming from "dma_set_coherent_mask()" by
using the same error log. This is equivalent to printing the same error log for
both API failures:

	ret = dma_set_coherent_mask()
	if (ret)
		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");

	ret = dmam_alloc_coherent()
	if (ret)
		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");

Which doesn't look correct to me. So let's stick to what Ajay had initially.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

