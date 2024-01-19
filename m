Return-Path: <linux-pci+bounces-2331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B3832479
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 06:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD4AA2815DA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3843C4A0F;
	Fri, 19 Jan 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvBfbu6e"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4E44A0C
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 05:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643942; cv=none; b=tkDfgikiVkxtWTzN91ovD2hbfW/Xv7CnvYIfmUrLbIkqebmJSwSTQ9bisxI4h24X1qSqblNLT3vxA2bp58X4RxZToW7fTYSWguLDGctsx+iIM/EwG8Yf6iFzj98a0S9V43BQoz86Ge0F93eb2Nd/ULGccYb5/zirXo+L6azvA5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643942; c=relaxed/simple;
	bh=x3oD/eCnpdMqXLCF4Bb9H9DUQqYgnJ+iIEAJ2Wh0dZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6r6hRT35eFobs8NbPld0XitNlgiYDSvv8DmeZVR7b7kSPZwEMjc3j9C++2AiXkMh+mJnVZwY+jxn+fkQXDkI8sjBDPY5pFb433mHHEpndI3MhFYpmOXvp0a7eqEyXxsmzqgfFBnbIGpAs6ttOpPjhfkVWLgg/s883udIC2FZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dvBfbu6e; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d5f388407bso2660205ad.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 21:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705643940; x=1706248740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZzI0OE9IgUNFfjo81qP82IlT41lwB8TRI+ESwTV9qyA=;
        b=dvBfbu6etND2qbSSst/HW393SEXjhIsO9jhCRN3Qg4xK6eg01UrW7wuNW47R+8iyhG
         P8D0e54XvqgzyuGdFYkH/UuI7vjscHX7SqmKkm8LyQHiG6ZgMfASIXNWddCfsskCaA9U
         Wnq8WZxHu5eW6mzDfOzpq0pCvST//puWwXvw/b6DE0GXtpgQjLPRgwoObhXiZR/IQBzs
         97IX8s7jRWzucW/KHvSu+DkapIKmNmtCpWN2sUe92Ed3P4monbawRM5ZF5rZMuqLgISY
         LHaL82d0uXtBU2wny/QJwtKzb5GPOY+9VxWI2E+fLcBlTjn1CQmweaD8XXuF52hKJFTV
         O3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705643940; x=1706248740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzI0OE9IgUNFfjo81qP82IlT41lwB8TRI+ESwTV9qyA=;
        b=A8r/mUSvwat4DUNmlMzwNzOg7U9rGfZziDRhkJIJVTE/GoWGuZD8bU5oPxRySMGN/j
         HoliAabtNSAWwtb3yTR/juIZ/yFJ07GDm5KCbHUoP0FRivh6QyMZBYKHUGY2mveDcdnc
         qLqxu5dusdeVs8ALtcbvuYZNQimN4D0m0k7hTiJ8hwfB5kmseGcQ5eta6Oe6E+bARgHK
         5e5bu9RTcZ+voYDg/PafIYgE7Ncmq1rCf4rC+05UHcoSlpZQwnsAsuMvqkhDNRJhVppw
         mcjtyh1pOyRtqfWt/OS2JSdvNLE86uEPSDm4OiPYKjgCGIe3JSR8+oj3w2CdWTKC9kln
         Nv9A==
X-Gm-Message-State: AOJu0YzLfRmq+RNAz3MG6vJb6CDQtC3to1lFNvzgDb4oOvkpVv4eEmOd
	UROeyPLq+a/DEncejQ80W+PmIVbfnjNb6I2DVWpjbg8m9BD8brhw5rJZP2H3Eg==
X-Google-Smtp-Source: AGHT+IG38oKjtDdhUfyeZ6rtDOf/DOMvBATI+t5jHKzSE99OearXtRzLvFhVwC5JgwAhD884jpmz6Q==
X-Received: by 2002:a17:90a:6fe2:b0:290:1a95:2c5d with SMTP id e89-20020a17090a6fe200b002901a952c5dmr1475733pjk.92.1705643939703;
        Thu, 18 Jan 2024 21:58:59 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id co19-20020a17090afe9300b0028db1713cbbsm2965437pjb.1.2024.01.18.21.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 21:58:59 -0800 (PST)
Date: Fri, 19 Jan 2024 11:28:50 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Sajid Dalvi <sdalvi@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
Message-ID: <ZaoPmgeVfXeseTfN@google.com>
References: <20240111042103.392939-1-ajayagarwal@google.com>
 <b1ef4ad8-99c4-46ba-90fd-d57bd17163b9@arm.com>
 <CAEbtx1=hoDTtpkavk7gp5tmcvdYj6euAuDsQYRPW=EDeVsbUqg@mail.gmail.com>
 <5ef31b1c-3069-4da7-8124-44efba0ad718@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef31b1c-3069-4da7-8124-44efba0ad718@arm.com>

On Tue, Jan 16, 2024 at 09:02:48PM +0000, Robin Murphy wrote:
> On 2024-01-16 5:18 pm, Sajid Dalvi wrote:
> > On Tue, Jan 16, 2024 at 7:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > 
> > > On 2024-01-11 4:21 am, Ajay Agarwal wrote:
> > > > There can be platforms that do not use/have 32-bit DMA addresses
> > > > but want to enumerate endpoints which support only 32-bit MSI
> > > > address. The current implementation of 32-bit IOVA allocation can
> > > > fail for such platforms, eventually leading to the probe failure.
> > > > 
> > > > If there is a memory region reserved for the pci->dev, pick up
> > > > the MSI data from this region. This can be used by the platforms
> > > > described above.
> > > > 
> > > > Else, if the memory region is not reserved, try to allocate a
> > > > 32-bit IOVA. Additionally, if this allocation also fails, attempt
> > > > a 64-bit allocation for probe to be successful. If the 64-bit MSI
> > > > address is allocated, then the EPs supporting 32-bit MSI address
> > > > will not work.
> > > > 
> > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > ---
> > > > Changelog since v1:
> > > >    - Use reserved memory, if it exists, to setup the MSI data
> > > >    - Fallback to 64-bit IOVA allocation if 32-bit allocation fails
> > > > 
> > > >    .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
> > > >    drivers/pci/controller/dwc/pcie-designware.h  |  1 +
> > > >    2 files changed, 39 insertions(+), 12 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 7991f0e179b2..8c7c77b49ca8 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp
> > *pp)
> > > >        u64 *msi_vaddr;
> > > >        int ret;
> > > >        u32 ctrl, num_ctrls;
> > > > +     struct device_node *np;
> > > > +     struct resource r;
> > > > 
> > > >        for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
> > > >                pp->irq_mask[ctrl] = ~0;
> > > > @@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct
> > dw_pcie_rp *pp)
> > > >         * order not to miss MSI TLPs from those devices the MSI target
> > > >         * address has to be within the lowest 4GB.
> > > >         *
> > > > -      * Note until there is a better alternative found the reservation
> > is
> > > > -      * done by allocating from the artificially limited DMA-coherent
> > > > -      * memory.
> > > > +      * Check if there is memory region reserved for this device. If
> > yes,
> > > > +      * pick up the msi_data from this region. This will be helpful for
> > > > +      * platforms that do not use/have 32-bit DMA addresses but want
> > to use
> > > > +      * endpoints which support only 32-bit MSI address.
> > > > +      * Else, if the memory region is not reserved, try to allocate a
> > 32-bit
> > > > +      * IOVA. Additionally, if this allocation also fails, attempt a
> > 64-bit
> > > > +      * allocation. If the 64-bit MSI address is allocated, then the
> > EPs
> > > > +      * supporting 32-bit MSI address will not work.
> > > >         */
> > > > -     ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > > -     if (ret)
> > > > -             dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices
> > with only 32-bit MSI support may not work properly\n");
> > > > +     np = of_parse_phandle(dev->of_node, "memory-region", 0);
> > > > +     if (np) {
> > > > +             ret = of_address_to_resource(np, 0, &r);
> > > 
> > > This is incorrect in several ways - reserved-memory nodes represent
> > > actual system memory, so can't be used to reserve arbitrary PCI memory
> > > space (which may be different if DMA offsets are involved); the whole
> > > purpose of going through the DMA API is to ensure we get a unique *bus*
> > > address. Obviously we don't want to reserve actual memory for something
> > > that functionally doesn't need it, but conversely having a
> > > reserved-memory region for an address which isn't memory would be
> > > nonsensical. And even if this *were* a viable approach, you haven't
> > > updated the DWC binding to allow it, nor defined a reserved-memory
> > > binding for the node itself.
> > > 
> > > If it was reasonable to put something in DT at all, then the logical
> > > thing would be a property expressing an MSI address directly on the
> > > controller node itself, but even that would be dictating software policy
> > > rather than describing an aspect of the platform itself. Plus this is
> > > far from the only driver with this concern, so it wouldn't make much
> > > sense to hack just one binding without all the others as well. The rest
> > > of the DT already describes everything an OS needs to know in order to
> > > decide an MSI address to use, it's just a matter of making this
> > > particular OS do a better job of putting it all together.
> > > 
> > > Thanks,
> > > Robin.
> > > 
> > 
> > Robin,
> > Needed some clarification.
> > It seems you are implying that the pcie device tree node should define a
> > property for the MSI address within the PCIe address space.
> > However, you also state that this would not be an ideal solution, and
> > would prefer using existing device tree constructs.
> > I am not sure what you mean by, " The rest of the DT already describes
> > everything."
> > Do you mean adding an "msi" reg to reg-names and defining the address
> > in the reg list?
> 
> No, I'm saying the closest this should come to DT at all is the possibility
> of the low-level driver hard-coding a platform-specific value for

I am assuming that you mean the platform driver (IOW, vendor driver) by
the "low-level" driver? Please confirm.

> pp->msi_data based on some platform-specific compatible, as Serge pointed to
> on v1.
>
Does this look ok to you? The expectation is that the pp->msi_data will
have to be populated by the platform driver if it wants to ensure the
support for all kinds of endpoints.

+       if (pp->msi_data)
+               return 0;
+
        ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
        if (ret)
                dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
 
        msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
                                        GFP_KERNEL);
+       if (!msi_vaddr) {
+               dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
+               dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+               msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+                                               GFP_KERNEL);
+       }
+
        if (!msi_vaddr) {
                dev_err(dev, "Failed to alloc and map MSI data\n");
                dw_pcie_free_msi(pp);

> Otherwise, based on the system memory layout and dma-ranges of the
> controller node we have enough information to figure out what PCI bus
> address ranges can't collide with any valid DMA mapping of RAM, and thus
> generate a suitable MSI address, but that really wants to be a generic
> PCI-layer helper (which could also generically implement the various DMA API
> tricks as a fallback if necessary).
> 
> Thanks,
> Robin.

