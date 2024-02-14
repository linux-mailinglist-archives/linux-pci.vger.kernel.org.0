Return-Path: <linux-pci+bounces-3423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9185421F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 05:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EA2028C2C8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Feb 2024 04:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C263D72;
	Wed, 14 Feb 2024 04:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UETADNZ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A210A01
	for <linux-pci@vger.kernel.org>; Wed, 14 Feb 2024 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707886438; cv=none; b=JHvkHHP57DivxI8esSPGnlL7UQzZB/WMCPY3/0TblXQ8hhKgLdvMpO3DBjjUvMvst7P+F9P2wGPiyvzTIaOVPwN34JdFHQ+GQ+BVtTcBQ1lYK0eSV0QGgmP5i94HWAVQfCdnySavjmbajCygkhliUW4VBX/qDpHcGIDDZEriwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707886438; c=relaxed/simple;
	bh=8NLis7YVO2gTWthqPYdjtEO64icPaDYgb2pCG5nvqbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s532hq1zW8203eDBL1XCWZbvECt5IcWUolLPK+EILJedKgCuvir4g+jxSYVTN0RQANzWl/QAv8ZMaUy56BLSWXVhRt0b8V08OhgUZCxjguJmhIVDPI0wqvFiDLA0v0pUu0vSx9jQXRL0T59vJYIwkmbeHh7yeo9VZEtWSHM9Vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UETADNZ3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0dcf0a936so281846b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 20:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707886435; x=1708491235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DdprcBR4QLL2h3YRNv+cnNKVLEsWolwD0ki1YkcAuqI=;
        b=UETADNZ3kVfYZGLVZY4DEz6MK9x2j+JEx3LiBrIAKCyLb4VQhtZFSexf5wLUpnYQOQ
         /S0w6xBD5xTwzt9XPZjKvGtLFk5OY4SH998KdjAqD+8xmXDD5Bovr/t/6O2cPCYOeJ4F
         pzDGbrXrjzpxSNB0+r/BdMFIRHq6qf8Uz7+Ph+01vZo1ADuQyQ0uMNQicaiNqYeQ7Kzh
         ONiuz8IeAjxAIVcJ92QIwjYZ4QnzNRyVdY3z/x0X7Tj87BkYgQT0AE6QSGPUvC4kTFcm
         rg72CElAfnlZU3/rUQAWfPPsedhwwj9jj4Dseo+Q7M1E4nW+CDiCegMxEixVcGYqS2o+
         nHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707886436; x=1708491236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdprcBR4QLL2h3YRNv+cnNKVLEsWolwD0ki1YkcAuqI=;
        b=MQdTzphHlTWelpKOfw3DfM5aUt6/ghqeXa9eHTuqL8NlASnklRxB9VLI1FDbzFESGI
         m+gAxJHUed/vZauFTR38p7i4/GNW3g7bxYfdAfGP2kzpytii3fiN8TCpMyjPyAbMQgYW
         PQ7dCiWtq6t5Td9gZSJVLbURHajh0GNI2m77tYRLyQ6zGD/v1PZhglD90UpZT8cByy87
         x8hAQjZMWpzuHNSK1zDk41r5r/DaRLWAKJL6eht08uT/YizVBANaENyor+pVQZp69fMT
         qNhjkf12NGzW/sianp81gtJQm4oI65ZPvXkK2VC6BY8KzDjQDhsGEQ+9vDe7LfEJO4zz
         WS+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwODhcgC32wJyzfELZ+esDlX3BE1ZrtxijDGErrD2ZZWPco7ALDOYPxQrPVnCNEHlBkszVkchm9WH5Y5rhOhO0b9WOSQBq2t4b
X-Gm-Message-State: AOJu0YyTrc2UEj4QRq0QDLTBctzxg3MYLTcKf9yx4sWxmovynCq9Jj1/
	B/iCtlHqMBlPq8fkNqnkTTd2QYnmeblQNmVjaWvw2uG4oWmlOLByDqmWjXJHmgK8i6/uxLqh4df
	tJqx2
X-Google-Smtp-Source: AGHT+IF4rVatdmppyHlGhUyYCXR+PPvxbKeLkByn+WOHXk7bVpYzu0LZRHIW5309ZyZh/P03DI29rw==
X-Received: by 2002:a62:ce04:0:b0:6e0:70ed:59c0 with SMTP id y4-20020a62ce04000000b006e070ed59c0mr1225525pfg.13.1707886435277;
        Tue, 13 Feb 2024 20:53:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJ5cgoD3n/NbriKVEYu40IyAg4RglLzFkCkM1N3JhLn+NcSA/781BDDfXxK1YQZyvDSw4HMIGO31Bd4kR6f39q69PP7msBd86SzL9Jdr8hVrgOdnmOIqEqIB1hGmkw0xHnpCuAAksGfFOYKYlf582W9i0+MVojl+N/e/X+vMLzvJIl1SyZTmpHcFTaG6I6JzU4RZ0opiiRnOBmFtFaxUwEkCkhGsWnwytxjq9mg3rvf2fAfJUEmRbro4zKb40hGLenBt7ih840/xdjHOeRMdlBOi+wEs7a33Eqp3sekuEtb6viBroRLOTQFjAHPND6sOkG/Virio0D6PfpE84oz1bxQxSu3jmISz0Uf9fQmFs1vVHURhKlw0yxkMOselA=
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b006e07eb192cfsm8325129pfk.59.2024.02.13.20.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 20:53:54 -0800 (PST)
Date: Wed, 14 Feb 2024 10:23:46 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
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
Message-ID: <ZcxHWuoUX3rEGVux@google.com>
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
 <ZcJhhHK6eQOUfVKf@google.com>
 <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>
 <ZcrZdhay6YvBzvWt@google.com>
 <7cd42851-37cc-49d6-b9ad-74a256a73904@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cd42851-37cc-49d6-b9ad-74a256a73904@arm.com>

On Tue, Feb 13, 2024 at 03:32:14PM +0000, Robin Murphy wrote:
> On 13/02/2024 2:52 am, Ajay Agarwal wrote:
> > On Tue, Feb 06, 2024 at 07:53:19PM +0300, Serge Semin wrote:
> > > On Tue, Feb 06, 2024 at 10:12:44PM +0530, Ajay Agarwal wrote:
> > > > On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> > > > > On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> > > > > > There can be platforms that do not use/have 32-bit DMA addresses
> > > > > > but want to enumerate endpoints which support only 32-bit MSI
> > > > > > address. The current implementation of 32-bit IOVA allocation can
> > > > > > fail for such platforms, eventually leading to the probe failure.
> > > > > > 
> > > > > > If there vendor driver has already setup the MSI address using
> > > > > > some mechanism, use the same. This method can be used by the
> > > > > > platforms described above to support EPs they wish to.
> > > > > > 
> > > > > > Else, if the memory region is not reserved, try to allocate a
> > > > > > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > > > > > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > > > > > address is allocated, then the EPs supporting 32-bit MSI address
> > > > > > will not work.
> > > > > > 
> > > > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > > > ---
> > > > > > Changelog since v2:
> > > > > >   - If the vendor driver has setup the msi_data, use the same
> > > > > > 
> > > > > > Changelog since v1:
> > > > > >   - Use reserved memory, if it exists, to setup the MSI data
> > > > > >   - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > > > > > 
> > > > > >   .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
> > > > > >   1 file changed, 20 insertions(+), 6 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > index d5fc31f8345f..512eb2d6591f 100644
> > > > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > > > @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > >   	 * order not to miss MSI TLPs from those devices the MSI target
> > > > > >   	 * address has to be within the lowest 4GB.
> > > > > >   	 *
> > > > > 
> > > > > > -	 * Note until there is a better alternative found the reservation is
> > > > > > -	 * done by allocating from the artificially limited DMA-coherent
> > > > > > -	 * memory.
> > > > > 
> > > > > Why do you keep deleting this statement? The driver still uses the
> > > > > DMA-coherent memory as a workaround. Your solution doesn't solve the
> > > > > problem completely. This is another workaround. One more time: the
> > > > > correct solution would be to allocate a 32-bit address or some range
> > > > > within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
> > > > > Your solution relies on the platform firmware/glue-driver doing that,
> > > > > which isn't universally applicable. So please don't drop the comment.
> > > > > 
> > > > ACK.
> > > > 
> > > > > > +	 * Check if the vendor driver has setup the MSI address already. If yes,
> > > > > > +	 * pick up the same.
> > > > > 
> > > > > This is inferred from the code below. So drop it.
> > > > > 
> > > > ACK.
> > > > 
> > > > > > This will be helpful for platforms that do not
> > > > > > +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> > > > > > +	 * only 32-bit MSI address.
> > > > > 
> > > > > Please merge it into the first part of the comment as like: "Permit
> > > > > the platforms to override the MSI target address if they have a free
> > > > > PCIe-bus memory specifically reserved for that."
> > > > > 
> > > > ACK.
> > > > 
> > > > > > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > > > > > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > > > > > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > > > > > +	 * supporting 32-bit MSI address will not work.
> > > > > 
> > > > > This is easily inferred from the code below. So drop it.
> > > > > 
> > > > ACK.
> > > > 
> > > > > >   	 */
> > > > > 
> > > > > > +	if (pp->msi_data)
> > > > > 
> > > > > Note this is a physical address for which even zero value might be
> > > > > valid. In this case it's the address of the PCIe bus space for which
> > > > > AFAICS zero isn't reserved for something special.
> > > > > 
> > > 
> > > > That is a fair point. What do you suggest we do? Shall we define another
> > > > op `set_msi_data` (like init/msi_init/start_link) and if it is defined
> > > > by the vendor, then call it? Then vendor has to set the pp->msi_data
> > > > there? Let me know.
> > > 
> > > You can define a new capability flag here
> > > drivers/pci/controller/dwc/pcie-designware.h (see DW_PCIE_CAP_* macros)
> > > , set it in the glue driver by means of the dw_pcie_cap_set() macro
> > > function and instead of checking msi_data value test the flag for
> > > being set by dw_pcie_cap_is().
> > > 
> > Sure, good suggestion. ACK.
> > 
> > > > 
> > > > > > +		return 0;
> > > > > > +
> > > > > >   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > > > >   	if (ret)
> > > > > >   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > > > > @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > > > >   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > >   					GFP_KERNEL);
> > > > > >   	if (!msi_vaddr) {
> > > > > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > > -		dw_pcie_free_msi(pp);
> > > > > > -		return -ENOMEM;
> > > > > > +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > > > > > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > > > +						GFP_KERNEL);
> > > > > > +		if (!msi_vaddr) {
> > > > > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > > > +			dw_pcie_free_msi(pp);
> > > > > > +			return -ENOMEM;
> > > > > > +		}
> > > > > 
> > > > > On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> > > > > > Yeah, something like that. Personally I'd still be tempted to try some
> > > > > > mildly more involved logic to just have a single dev_warn(), but I think
> > > > > > that's less important than just having something which clearly works.
> > > > > 
> > > > > I guess this can be done but in a bit clumsy way. Like this:
> > > > > 
> > > > > 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
> > > > > 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > > > 	if (ret) {
> > > > > 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
> > > > > 
> > > > > 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > > 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > > > 		if (ret) {
> > > > > 			dev_err(dev, "Failed to allocate MSI target address\n");
> > > > > 			return -ENOMEM;
> > > > 
> > > > As you pointed out already, this looks pretty clumsy. I think we should
> > > > stick to the more descriptive and readable code that I suggested.
> > > 
> > > I do not know which solution is better really. Both have pros and
> > > cons. Let's wait for Bjorn, Mani or Robin opinion about this.
> > > 
> > > -Serge(y)
> > > 
> > Bjorn/Mani/Robin,
> > Can you please provide your comment?
> 
> FWIW I had a go at sketching out what I think I'd do, on top of the v3
> patch. Apparently I'm not in a too-clever-for-my-own-good mood today,
> since what came out seems to have ended up pretty much just simplifying
> the pre-existing code. I'll leave the choice up to you.
> 
> Thanks,
> Robin.
> 
> ----->8-----
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 512eb2d6591f..7b68c65e5d11 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -328,7 +328,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct device *dev = pci->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	u64 *msi_vaddr;
> +	u64 *msi_vaddr = NULL;
>  	int ret;
>  	u32 ctrl, num_ctrls;
> @@ -387,18 +387,16 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
>  		return 0;
>  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> -	if (ret)
> -		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> -
> -	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> -					GFP_KERNEL);
> +	if (!ret)
> +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> +						GFP_KERNEL);
>  	if (!msi_vaddr) {
> -		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> +		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
>  		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>  		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
>  						GFP_KERNEL);
>  		if (!msi_vaddr) {
> -			dev_err(dev, "Failed to alloc and map MSI data\n");
> +			dev_err(dev, "Failed to configure MSI address\n");
>  			dw_pcie_free_msi(pp);
>  			return -ENOMEM;
>  		}
Thanks Robin for your suggestion. I will keep my patch but pick up the
dev_err prints from your suggestion.

