Return-Path: <linux-pci+bounces-3171-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0184BB70
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E6F28493B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70BD4A34;
	Tue,  6 Feb 2024 16:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvElM4ZJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23CD63DF
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238406; cv=none; b=gPvE9Z07babsV+u2jr9/TpBYOkWpQjNrpQZ79/hNBG1KQ3Fr2Vbmr3p/XZizNzMokyKe6bwq/wIlWIE5cP2LYzmmiIcACANMKxjCEkAHKripJG/XS0hLjAHcOl2k6GUkpo1IKpBp7rdHaHZutdRUWXWTQkjU8b44QGO75pjcbIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238406; c=relaxed/simple;
	bh=rou4R/beABf8TRM7GWkpkjoc7CoYJQTcpclMYyHpsR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nvl3OrKnSSiypU3o2TQqcDTqsSQ50mjOLjKk4MoX/WAhTup/EH1t99kunf5wPD6NE4+r2FCf+z7+c4EPibQAMvucI0OLAJbKXdBgAwvBNhLyd7sOHnqG2VvgopuXxD7ujkufvd24FeApNm/sPOOV6Wr/s0udAavkH3tHpt78EwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvElM4ZJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-511206d1c89so8435202e87.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 08:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707238403; x=1707843203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XXDFMhYZw8LhChEWFgEkWByxhKuOaFOTpUlUGtwQ6VU=;
        b=BvElM4ZJhTBsrUNEtAkiFgevarE1ruKM/0ygQjk7m7fk8K+Clwf0YUiQjUwsdz08qB
         Jd0DJv5XrEatyTT5o4u8UPCmVPmFxqT1xMBEJ5PpnGImtIredDCgpnXNZ1Nyi2lr2x4L
         oUjJRJ4+xepnH+lfKQ4dw5CNmY0RU07DwJUY6nl0jriSWEgGa9Dl1UYP34khGOLvWase
         MydT7F+iQtdFuEgg4Vbfc/oKrubT/TTkYfRpOyr3tcBZfSiBFW6Z4UHfdz8OjBAyZxna
         HbkPOD+O+LrugqIIHa/DHb/SjgDg/3DF423vJWwYtbyLMIl5W9SK6R9Sod6Sa/uk90qX
         djpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707238403; x=1707843203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XXDFMhYZw8LhChEWFgEkWByxhKuOaFOTpUlUGtwQ6VU=;
        b=G5+5sV0c8d0fZCZkrkJe8Mu4bjuo0ZhXS2wYTZiY4KQkYftkLauyfzONpyJnJstg7F
         Gyy0EoP3iALlkfqFd6cEwrNLvLJu9E0yJgEvVeEvoexturW/ZyE+bwrZaOEIuowz30/C
         JouGNTsTjd7QOgWqYs1SIkS/8Ytkv7XGRxTJErNzmA2yA8pssDxnfyE/YGQ5Kd0SGNyd
         vWTsT3eniHWgrUGxYq/FoO14EvB1q4HIjJ8UiYEX7HhfghzgEiKH3+DahmC3q6JVSxDE
         oH9xq57VR12R+nJCRj442aiPNYW6qUn7cwQjEsNBxemRPxUc/XkqXY28I1ulzCD2jJrp
         e/xA==
X-Gm-Message-State: AOJu0YzxHInvQh+TBrGrgoJzUVjBNCMfv5iidmRuOakuS8v4LBx4uzFA
	kL7/BBoQw6EW2GKmwHxAHHRWJHcuKBiUEwt8QbiMlIjEwqMZff+K
X-Google-Smtp-Source: AGHT+IHahpbMGr++ieUCZHx1YkmJuKEwJmxd1q5N9CRY6ITDLETLwoP2pP6f0mOes6TgLndXx2csjg==
X-Received: by 2002:a05:6512:3ca1:b0:511:62f7:14fa with SMTP id h33-20020a0565123ca100b0051162f714famr154632lfv.29.1707238402492;
        Tue, 06 Feb 2024 08:53:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXr2RWC6kVO5ZYBcHRmwnrBEGtfVurE4uA3XzXHi0W4kP1LRycE0Ii2REehi1kEQQM5vpP3Wy/KHSL3Xq2jYWgZPDzFfrXteCX3Bb9AVv011Q2zjEfyCW6+lrenjmqn6yKBHgYR3eCXwY+TtGDYqGmMghf1opcfTdAqIU3gzrrKLjgFHFk5dMPlnGN6VJx0MZ9TsjnwYudezTR6Ei1OypZKK9jMq70TiB9jIt0BJTldWwms9nnRN5eRsUyonZLX5uKaOrrcccMX7qpqEt2m0Gc45ZkYxupoUe49g4VgVDVQEPkzzkbiftjVdf939J8wajIpPOcGMMV71Bg94vCPF2QAWm2Z5piaObSrrhMWmTX8aQC4oqeB+CyLG+3pIhE=
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id j11-20020ac2550b000000b005113e122511sm287327lfk.17.2024.02.06.08.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 08:53:22 -0800 (PST)
Date: Tue, 6 Feb 2024 19:53:19 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>, 
	Sajid Dalvi <sdalvi@google.com>, William McVicker <willmcvicker@google.com>, 
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
 <ZcJhhHK6eQOUfVKf@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcJhhHK6eQOUfVKf@google.com>

On Tue, Feb 06, 2024 at 10:12:44PM +0530, Ajay Agarwal wrote:
> On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> > On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> > > There can be platforms that do not use/have 32-bit DMA addresses
> > > but want to enumerate endpoints which support only 32-bit MSI
> > > address. The current implementation of 32-bit IOVA allocation can
> > > fail for such platforms, eventually leading to the probe failure.
> > > 
> > > If there vendor driver has already setup the MSI address using
> > > some mechanism, use the same. This method can be used by the
> > > platforms described above to support EPs they wish to.
> > > 
> > > Else, if the memory region is not reserved, try to allocate a
> > > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > > address is allocated, then the EPs supporting 32-bit MSI address
> > > will not work.
> > > 
> > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > ---
> > > Changelog since v2:
> > >  - If the vendor driver has setup the msi_data, use the same
> > > 
> > > Changelog since v1:
> > >  - Use reserved memory, if it exists, to setup the MSI data
> > >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > > 
> > >  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
> > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index d5fc31f8345f..512eb2d6591f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	 * order not to miss MSI TLPs from those devices the MSI target
> > >  	 * address has to be within the lowest 4GB.
> > >  	 *
> > 
> > > -	 * Note until there is a better alternative found the reservation is
> > > -	 * done by allocating from the artificially limited DMA-coherent
> > > -	 * memory.
> > 
> > Why do you keep deleting this statement? The driver still uses the
> > DMA-coherent memory as a workaround. Your solution doesn't solve the
> > problem completely. This is another workaround. One more time: the
> > correct solution would be to allocate a 32-bit address or some range
> > within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
> > Your solution relies on the platform firmware/glue-driver doing that,
> > which isn't universally applicable. So please don't drop the comment.
> >
> ACK.
> 
> > > +	 * Check if the vendor driver has setup the MSI address already. If yes,
> > > +	 * pick up the same.
> > 
> > This is inferred from the code below. So drop it.
> > 
> ACK.
> 
> > > This will be helpful for platforms that do not
> > > +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> > > +	 * only 32-bit MSI address.
> > 
> > Please merge it into the first part of the comment as like: "Permit
> > the platforms to override the MSI target address if they have a free
> > PCIe-bus memory specifically reserved for that."
> > 
> ACK.
> 
> > > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > > +	 * supporting 32-bit MSI address will not work.
> > 
> > This is easily inferred from the code below. So drop it.
> > 
> ACK.
> 
> > >  	 */
> > 
> > > +	if (pp->msi_data)
> > 
> > Note this is a physical address for which even zero value might be
> > valid. In this case it's the address of the PCIe bus space for which
> > AFAICS zero isn't reserved for something special.
> >

> That is a fair point. What do you suggest we do? Shall we define another
> op `set_msi_data` (like init/msi_init/start_link) and if it is defined
> by the vendor, then call it? Then vendor has to set the pp->msi_data
> there? Let me know.

You can define a new capability flag here
drivers/pci/controller/dwc/pcie-designware.h (see DW_PCIE_CAP_* macros)
, set it in the glue driver by means of the dw_pcie_cap_set() macro
function and instead of checking msi_data value test the flag for
being set by dw_pcie_cap_is().

> 
> > > +		return 0;
> > > +
> > >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > >  	if (ret)
> > >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > >  					GFP_KERNEL);
> > >  	if (!msi_vaddr) {
> > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > -		dw_pcie_free_msi(pp);
> > > -		return -ENOMEM;
> > > +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > +						GFP_KERNEL);
> > > +		if (!msi_vaddr) {
> > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > +			dw_pcie_free_msi(pp);
> > > +			return -ENOMEM;
> > > +		}
> > 
> > On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> > > Yeah, something like that. Personally I'd still be tempted to try some
> > > mildly more involved logic to just have a single dev_warn(), but I think
> > > that's less important than just having something which clearly works.
> > 
> > I guess this can be done but in a bit clumsy way. Like this:
> > 
> > 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
> > 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > 	if (ret) {
> > 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
> > 
> > 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > 		if (ret) {
> > 			dev_err(dev, "Failed to allocate MSI target address\n");
> > 			return -ENOMEM;
> 
> As you pointed out already, this looks pretty clumsy. I think we should
> stick to the more descriptive and readable code that I suggested.

I do not know which solution is better really. Both have pros and
cons. Let's wait for Bjorn, Mani or Robin opinion about this.

-Serge(y)

> 
> > 		}
> > 	}
> > 
> > Not sure whether it's much better than what Ajay suggested but at
> > least it has a single warning string describing the error, and we can
> > drop the unused msi_vaddr variable.
> > 
> > -Serge(y)
> > 
> > >  	}
> > >  
> > >  	return 0;
> > > -- 
> > > 2.43.0.594.gd9cf4e227d-goog
> > > 

