Return-Path: <linux-pci+bounces-3169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69A84BB36
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F30C1C24C60
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2AB1113;
	Tue,  6 Feb 2024 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vgwg+kCO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798584A3C
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237776; cv=none; b=BASMSV6N643Qn/TQZ9I36CuPnOEahI74Qk6Ttw2++OE6+KpMOTZkNQy0G5vVoVwMmtDaNcohEujn0CtK58jHjMI8Q6lnG2p3q8jZDRd9MSYWhmXIW/GjzvG0HgP7rIOyGUT+2bP4YP9hEdy2xqySbgH3HsgL0VlQUSRAJCQ5SDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237776; c=relaxed/simple;
	bh=fMcyF0M4QGbcJV5iH5pAE/XrjaGRAw1h1FENKSlcwWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5S3iU1VEhuKHX5pfEIrYg/+4cXs/NtSNZeJOCNvE8a4CtelgFDVQZQay6SlBf1HQXw1kytuS4VI/zQbggprU/Zqp5V1uyruTjNBgHIIf19lrr0IS+tnS3O341+YLhinrgxUrYZAdMXKDKAjS1Pvj23lm/RI8JjxOccGMLH6vv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vgwg+kCO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d7354ba334so50621815ad.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 08:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707237774; x=1707842574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tzx+BZhk4/I2+vYIi/1Bq4png4DGafaMd2yFNyD/nGE=;
        b=Vgwg+kCO4WMThyJmKIqoSk3lSp93hBH/7I4q8g8pWa963dZ1v9f4Nqpkt3iDl1Gky5
         E6rXeH/jiMSORkhtMXIGI7O3hvKZoeksQCfHUuL7e+EX0RyUUmH8NsgyxoWsDbUIVoR3
         iRzfvQUk/B7BUEpEFHeDY10gZ3+jcX760k7JutHwikSg/waYwh6ZpQogH52+ld40oA91
         A/QtnPpj4ZCrlqxntceit7rTvlvJG9vQ6N9VwI6GVaW7Fuwm4VCCyNOKqEUNKL/j9zH6
         BE7+Zl2RsHtvcR4OR79kDaA/cOEYezOBHqC7k30z0qDTT8SqNpmP4pu3WMLr0bcNle3o
         bcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237774; x=1707842574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tzx+BZhk4/I2+vYIi/1Bq4png4DGafaMd2yFNyD/nGE=;
        b=v5BGDZtvZt12HxzyK5HZGjsOPSwfRoWsLgtWG5ZWKHlm3TGJoqsiFZx02oYThTFbry
         BGIyBe5Vr2avxiy9cns/7rVh67CPciu4Sxe7hmLcpj99RUIGkW1gR2k4+pkOE070vZHx
         k3E2A4NzimK/99uenfLghiNYMEJO1lXFinHuFS41Q15PkiG8LsWT+tP0Q+fYgcWiG+fw
         1bLdbIQAcK2KsCYVKAEW4U855uAVyi2Y+j0QwHRvLsHNe67JiyF4UpIuQeYkS3EOw/Xq
         vQzY9jOOzKXPz86UenbNkFAcrddEPO+pwyZ6a4fWLmXOBiwwTsM8lF2vmWbpTH2YMSSn
         0xLA==
X-Gm-Message-State: AOJu0YzTWE9jd4aMfgL+zb0+xxKJePwp5sivldpmZ7q8IdVrLcOAREfF
	dAGfSw6+hvvaVRvcWVr/3TKgtl4S3SA0mEKTR7zqzOq0mp05LCRW+tJgBC5pAQ==
X-Google-Smtp-Source: AGHT+IEkddjNixcXlWc4RkcF2xhu6dOuB+xMQpVNItHop2WYlbAhw19cTMjmWoBtmm0dCiD9AzrN1A==
X-Received: by 2002:a17:902:bb16:b0:1d8:e06a:3d16 with SMTP id im22-20020a170902bb1600b001d8e06a3d16mr2024119plb.38.1707237773435;
        Tue, 06 Feb 2024 08:42:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU+n3V1CJTk0llgPnPpZTgRBwv6MD9tySsV1YlL+fLKAcWOVRHshu3eZ9DWpfhW6l4Ilj/HlF+spDQk2lBoV3lkhUwinqqz7wA9lIFFbnTYc7rXW7V2KdDyMZErwqP0VELUYzzHcEUOm1C+6LP+ZAs+15xt75SkKJoqDWff490ZGSLb0ynRiF99df4lahOYgX9ZqwLDKEDFxIyxurDVsRbhtSlMOoAvrbLJ6YeLtFXtjpGivO1ISshTUZqOO2oXdO0OMeQVr+Og7p7oq4tlNaIFeAZYsxgdDMn7RvUvbOKV3Cd7FqiofhL2w2PXPi7376lDU3UYgJVej9UWpD9MEJoUgwTptc8REtRcTVyziDNabs6frxglc3HZtPFhaR8=
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id oh14-20020a17090b3a4e00b00296bc8d1144sm1902555pjb.41.2024.02.06.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:42:52 -0800 (PST)
Date: Tue, 6 Feb 2024 22:12:44 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZcJhhHK6eQOUfVKf@google.com>
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>

On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> > There can be platforms that do not use/have 32-bit DMA addresses
> > but want to enumerate endpoints which support only 32-bit MSI
> > address. The current implementation of 32-bit IOVA allocation can
> > fail for such platforms, eventually leading to the probe failure.
> > 
> > If there vendor driver has already setup the MSI address using
> > some mechanism, use the same. This method can be used by the
> > platforms described above to support EPs they wish to.
> > 
> > Else, if the memory region is not reserved, try to allocate a
> > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > address is allocated, then the EPs supporting 32-bit MSI address
> > will not work.
> > 
> > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > ---
> > Changelog since v2:
> >  - If the vendor driver has setup the msi_data, use the same
> > 
> > Changelog since v1:
> >  - Use reserved memory, if it exists, to setup the MSI data
> >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > 
> >  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d5fc31f8345f..512eb2d6591f 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	 * order not to miss MSI TLPs from those devices the MSI target
> >  	 * address has to be within the lowest 4GB.
> >  	 *
> 
> > -	 * Note until there is a better alternative found the reservation is
> > -	 * done by allocating from the artificially limited DMA-coherent
> > -	 * memory.
> 
> Why do you keep deleting this statement? The driver still uses the
> DMA-coherent memory as a workaround. Your solution doesn't solve the
> problem completely. This is another workaround. One more time: the
> correct solution would be to allocate a 32-bit address or some range
> within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
> Your solution relies on the platform firmware/glue-driver doing that,
> which isn't universally applicable. So please don't drop the comment.
>
ACK.

> > +	 * Check if the vendor driver has setup the MSI address already. If yes,
> > +	 * pick up the same.
> 
> This is inferred from the code below. So drop it.
> 
ACK.

> > This will be helpful for platforms that do not
> > +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> > +	 * only 32-bit MSI address.
> 
> Please merge it into the first part of the comment as like: "Permit
> the platforms to override the MSI target address if they have a free
> PCIe-bus memory specifically reserved for that."
> 
ACK.

> > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > +	 * supporting 32-bit MSI address will not work.
> 
> This is easily inferred from the code below. So drop it.
> 
ACK.

> >  	 */
> 
> > +	if (pp->msi_data)
> 
> Note this is a physical address for which even zero value might be
> valid. In this case it's the address of the PCIe bus space for which
> AFAICS zero isn't reserved for something special.
>
That is a fair point. What do you suggest we do? Shall we define another
op `set_msi_data` (like init/msi_init/start_link) and if it is defined
by the vendor, then call it? Then vendor has to set the pp->msi_data
there? Let me know.

> > +		return 0;
> > +
> >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> >  	if (ret)
> >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> >  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> >  					GFP_KERNEL);
> >  	if (!msi_vaddr) {
> > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > -		dw_pcie_free_msi(pp);
> > -		return -ENOMEM;
> > +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > +						GFP_KERNEL);
> > +		if (!msi_vaddr) {
> > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > +			dw_pcie_free_msi(pp);
> > +			return -ENOMEM;
> > +		}
> 
> On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> > Yeah, something like that. Personally I'd still be tempted to try some
> > mildly more involved logic to just have a single dev_warn(), but I think
> > that's less important than just having something which clearly works.
> 
> I guess this can be done but in a bit clumsy way. Like this:
> 
> 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
> 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> 	if (ret) {
> 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
> 
> 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> 		if (ret) {
> 			dev_err(dev, "Failed to allocate MSI target address\n");
> 			return -ENOMEM;

As you pointed out already, this looks pretty clumsy. I think we should
stick to the more descriptive and readable code that I suggested.

> 		}
> 	}
> 
> Not sure whether it's much better than what Ajay suggested but at
> least it has a single warning string describing the error, and we can
> drop the unused msi_vaddr variable.
> 
> -Serge(y)
> 
> >  	}
> >  
> >  	return 0;
> > -- 
> > 2.43.0.594.gd9cf4e227d-goog
> > 

