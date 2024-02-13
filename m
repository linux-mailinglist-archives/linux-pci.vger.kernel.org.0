Return-Path: <linux-pci+bounces-3378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61982852797
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 03:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D851F2383F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 02:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4222133E1;
	Tue, 13 Feb 2024 02:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kxnNcTTs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2542B8827
	for <linux-pci@vger.kernel.org>; Tue, 13 Feb 2024 02:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707792772; cv=none; b=j21iwtC/cOE4IrW5bimL49TzkgmSgEbiEP7gv56c4mpb93PkSid4miQq0WSfXrf/D0YYsUbtSxbW5I5NdHl4vKe+3ASiuqncviwJGdxJ68lp1OblXR5VRqKGdDURJp/Xh+HCMuPK6QeLEWC9qgPgQBQ0j8Htc+jw3SKUvlrHh88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707792772; c=relaxed/simple;
	bh=zvz9TRmRM+06fjNoOUaEcu7w+TRQrXyMGZn4fHYEN8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/500z1e3A3++rdOxtwBWlQIz3cM7QF5K4ARgwbLuXA7MM2AiRFqkZn5A1o3rH/Xs8K6l2a3585ONrODV0isOvBBu9FtO94t0Yj+bnCo7x4nGfYNJdMBzQFOPJ7Piqej0yhi66tk+3RTwcFGcc+gSBOWF0lrgc7N3CqIKV6ezdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kxnNcTTs; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363ce3a220aso15365815ab.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Feb 2024 18:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707792769; x=1708397569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bYKjq/RYiHTpCRnmkXpwFolWy/LWfF7jHoB8wZYSP8=;
        b=kxnNcTTs4UGn3ebN9xi6+rxKDUSZGymyd/rssiIN0Gk+5HzFvEO9g6iZORgksvxMrb
         yJ3NYuGD15mXqNr4S/dSTRyD/QROA0WxdAdBswSTUU7tVgtgTd3WO6l32SETbrrlqxzM
         /gOjacN2fkTWS8IIFR4SptZndOGT32GjsAFgkx4nA3lyG9epRNgdPsqWly3tYjaCAxJy
         VOh1zWcVp5ajvyvPPCsGZK8PkDRO+wAEvs3DzavnEuB6lLVwna9uUrQmfFmQyljBjtJG
         tBz8R6XpyOpNsPUvPlH2t66XEUbUCBmV9yMcHTUd11PRZ0SIPy/RCxY5M/nQQGAcVk/e
         OOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707792769; x=1708397569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bYKjq/RYiHTpCRnmkXpwFolWy/LWfF7jHoB8wZYSP8=;
        b=V5LXg50hlqAeTo5Ll7Dp+ROPSlVS9j5STTs3W4VqE0EBcPqxFy1u6bNAVVhOC0h9dS
         IcL0NtG5UDciuToC0Hp0eV/0WhB+81II5ebHb6sdD48lv5Nb1NKG+17stw6dXTST2N2X
         7a66/2ykWNVcTLcPEL2vngf1bBfmvn4MLq1QxB6umsRnHDwxbGZZwUN4zOAOkTz5LdV1
         Ybx0zfhTkmkFEslh28SwtNMSoY4A5YlP1QClWKHyWdPyT2hR1tcprUePZY8WB2i8I4kC
         eZ5PFIA0eNrsiywshtpZ/yhU7pzd2AI65Cu27AbDE5y3apkNlE2dKZv1A4f42gzRm8Co
         I1tA==
X-Forwarded-Encrypted: i=1; AJvYcCWeyaPCLmmQJ5iJ0Ow5YNZvnfspF3mKMG4U5jG84v/JOQ6EvtnE/uzpyr74/DFQBwZ9E6OU7nly3GNwFZNO+F/yPED9IFLmX1IM
X-Gm-Message-State: AOJu0YyRV8FhFT2DWTDPJJ4rR+45w7VnE1tLfF/EL/nDtTApPYPppvx2
	QxqboaZnIfL9QDR8mVhpJVN5Sx/5KIqfgoN454LgOLkTB1YPXd6hJYq4lsb67Q==
X-Google-Smtp-Source: AGHT+IGqY11vLZxMrO/0xPIt3XxyXev3z02bcMZILFOO5d5XzQUP5egdOj3x4XOTmJUKemIHbg2xhQ==
X-Received: by 2002:a92:ca85:0:b0:363:e060:85fa with SMTP id t5-20020a92ca85000000b00363e06085famr9445354ilo.20.1707792769002;
        Mon, 12 Feb 2024 18:52:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHiV/0nNEY8vLSa5VhntdtX/qimfxgz0g/PoFHAp8MLOfP2P9McXzt3MSbK3lXTgNo1UBQ5YyBdlvp0QeOvphpdZx4qTCWc7aMARp91Bww88Nrp58QTwDD2XyVG8fCogtsp8RK7pNoTol8y2vpYx+1G/FLQF6sAyzHyWjY3ZYj3XRXE0qXyzCqtqfSz49NplHgCvgIqaCewcQgTozsOPgGiaqu1POo0Mj9lCpr9xnmSuw7urBSS1qnMwVtN7mynQ+rT5Q2vllvO5sttU069u75HRyI5XvNdnShD9/1pmEsA4a1de3JqzxTSxb3l/cC0fEWDe5ofhPDNYbbrh17BpDJX0AVHa+jBKhgEwNnlZKJ/7oLi001mOAkG5wrt3E=
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id b13-20020a65668d000000b005c6e8fa9f24sm1020855pgw.49.2024.02.12.18.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 18:52:46 -0800 (PST)
Date: Tue, 13 Feb 2024 08:22:38 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZcrZdhay6YvBzvWt@google.com>
References: <20240204112425.125627-1-ajayagarwal@google.com>
 <2kvgqhaitacl7atqf775vr2z3ty5qeqxuv5g3wflkmhgj4yk76@fsmrosfwobfx>
 <ZcJhhHK6eQOUfVKf@google.com>
 <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjhceek7fjr6qglqewzrojc2nooewmhxq5ifzpqhpzuvc5deqa@l4u7kgzn2vo7>

On Tue, Feb 06, 2024 at 07:53:19PM +0300, Serge Semin wrote:
> On Tue, Feb 06, 2024 at 10:12:44PM +0530, Ajay Agarwal wrote:
> > On Mon, Feb 05, 2024 at 12:52:45AM +0300, Serge Semin wrote:
> > > On Sun, Feb 04, 2024 at 04:54:25PM +0530, Ajay Agarwal wrote:
> > > > There can be platforms that do not use/have 32-bit DMA addresses
> > > > but want to enumerate endpoints which support only 32-bit MSI
> > > > address. The current implementation of 32-bit IOVA allocation can
> > > > fail for such platforms, eventually leading to the probe failure.
> > > > 
> > > > If there vendor driver has already setup the MSI address using
> > > > some mechanism, use the same. This method can be used by the
> > > > platforms described above to support EPs they wish to.
> > > > 
> > > > Else, if the memory region is not reserved, try to allocate a
> > > > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > > > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > > > address is allocated, then the EPs supporting 32-bit MSI address
> > > > will not work.
> > > > 
> > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > ---
> > > > Changelog since v2:
> > > >  - If the vendor driver has setup the msi_data, use the same
> > > > 
> > > > Changelog since v1:
> > > >  - Use reserved memory, if it exists, to setup the MSI data
> > > >  - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > > > 
> > > >  .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
> > > >  1 file changed, 20 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index d5fc31f8345f..512eb2d6591f 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > >  	 * order not to miss MSI TLPs from those devices the MSI target
> > > >  	 * address has to be within the lowest 4GB.
> > > >  	 *
> > > 
> > > > -	 * Note until there is a better alternative found the reservation is
> > > > -	 * done by allocating from the artificially limited DMA-coherent
> > > > -	 * memory.
> > > 
> > > Why do you keep deleting this statement? The driver still uses the
> > > DMA-coherent memory as a workaround. Your solution doesn't solve the
> > > problem completely. This is another workaround. One more time: the
> > > correct solution would be to allocate a 32-bit address or some range
> > > within the 4GB PCIe bus memory with no _RAM_ or some other IO behind.
> > > Your solution relies on the platform firmware/glue-driver doing that,
> > > which isn't universally applicable. So please don't drop the comment.
> > >
> > ACK.
> > 
> > > > +	 * Check if the vendor driver has setup the MSI address already. If yes,
> > > > +	 * pick up the same.
> > > 
> > > This is inferred from the code below. So drop it.
> > > 
> > ACK.
> > 
> > > > This will be helpful for platforms that do not
> > > > +	 * use/have 32-bit DMA addresses but want to use endpoints which support
> > > > +	 * only 32-bit MSI address.
> > > 
> > > Please merge it into the first part of the comment as like: "Permit
> > > the platforms to override the MSI target address if they have a free
> > > PCIe-bus memory specifically reserved for that."
> > > 
> > ACK.
> > 
> > > > +	 * Else, if the memory region is not reserved, try to allocate a 32-bit
> > > > +	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
> > > > +	 * allocation. If the 64-bit MSI address is allocated, then the EPs
> > > > +	 * supporting 32-bit MSI address will not work.
> > > 
> > > This is easily inferred from the code below. So drop it.
> > > 
> > ACK.
> > 
> > > >  	 */
> > > 
> > > > +	if (pp->msi_data)
> > > 
> > > Note this is a physical address for which even zero value might be
> > > valid. In this case it's the address of the PCIe bus space for which
> > > AFAICS zero isn't reserved for something special.
> > >
> 
> > That is a fair point. What do you suggest we do? Shall we define another
> > op `set_msi_data` (like init/msi_init/start_link) and if it is defined
> > by the vendor, then call it? Then vendor has to set the pp->msi_data
> > there? Let me know.
> 
> You can define a new capability flag here
> drivers/pci/controller/dwc/pcie-designware.h (see DW_PCIE_CAP_* macros)
> , set it in the glue driver by means of the dw_pcie_cap_set() macro
> function and instead of checking msi_data value test the flag for
> being set by dw_pcie_cap_is().
>
Sure, good suggestion. ACK.

> > 
> > > > +		return 0;
> > > > +
> > > >  	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > >  	if (ret)
> > > >  		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > > @@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > >  	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > >  					GFP_KERNEL);
> > > >  	if (!msi_vaddr) {
> > > > -		dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > -		dw_pcie_free_msi(pp);
> > > > -		return -ENOMEM;
> > > > +		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
> > > > +		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > > +		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > > +						GFP_KERNEL);
> > > > +		if (!msi_vaddr) {
> > > > +			dev_err(dev, "Failed to alloc and map MSI data\n");
> > > > +			dw_pcie_free_msi(pp);
> > > > +			return -ENOMEM;
> > > > +		}
> > > 
> > > On Tue, Jan 30, 2024 at 08:40:48PM +0000, Robin Murphy wrote:
> > > > Yeah, something like that. Personally I'd still be tempted to try some
> > > > mildly more involved logic to just have a single dev_warn(), but I think
> > > > that's less important than just having something which clearly works.
> > > 
> > > I guess this can be done but in a bit clumsy way. Like this:
> > > 
> > > 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32)) ||
> > > 	      !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > 	if (ret) {
> > > 		dev_warn(dev, "Failed to allocate 32-bit MSI target address\n");
> > > 
> > > 		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
> > > 		ret = !dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data, GFP_KERNEL);
> > > 		if (ret) {
> > > 			dev_err(dev, "Failed to allocate MSI target address\n");
> > > 			return -ENOMEM;
> > 
> > As you pointed out already, this looks pretty clumsy. I think we should
> > stick to the more descriptive and readable code that I suggested.
> 
> I do not know which solution is better really. Both have pros and
> cons. Let's wait for Bjorn, Mani or Robin opinion about this.
> 
> -Serge(y)
> 
Bjorn/Mani/Robin,
Can you please provide your comment?

> > 
> > > 		}
> > > 	}
> > > 
> > > Not sure whether it's much better than what Ajay suggested but at
> > > least it has a single warning string describing the error, and we can
> > > drop the unused msi_vaddr variable.
> > > 
> > > -Serge(y)
> > > 
> > > >  	}
> > > >  
> > > >  	return 0;
> > > > -- 
> > > > 2.43.0.594.gd9cf4e227d-goog
> > > > 

