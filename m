Return-Path: <linux-pci+bounces-1956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87489829013
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 23:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3157E288755
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B030A3DB9F;
	Tue,  9 Jan 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZNZbYjr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4A63DB90
	for <linux-pci@vger.kernel.org>; Tue,  9 Jan 2024 22:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50e80d14404so4009192e87.1
        for <linux-pci@vger.kernel.org>; Tue, 09 Jan 2024 14:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704840462; x=1705445262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+K3XNi88Nnf++s78Mr/Q6y3pBXHSdYsbyhgI/cCgXT8=;
        b=PZNZbYjr59Ahi9ETQu+VRrdBWXtAtXVidwhPZoO9TQAW5wz4BcvG4aquGg33suRE/f
         Qb2VvDrhDQ8Fh3oAjT4CJJk9tav3Sb93jm+NA8MwJaI+cZnz5MMG/d15t21KohiuSHYT
         IgQYul3XPWLBOicCa3SCjwRDMX9GXuS+FvQhLdD6ZO9Es+49sGqcYaeLqYNttHiRY2V8
         /KgH7f+H3siS1go0bqF/3JIxh9MAWQuctVSerKQXDq46s3dPq6ypgl61SCtoO6Pzerki
         Vzi0+yyG7TxDIK8e/Hc/OCFp9Ct9dW9L8REPxkpiE0tKsS8GFu99pbcJAHtOz4c9PEpJ
         PzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704840462; x=1705445262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+K3XNi88Nnf++s78Mr/Q6y3pBXHSdYsbyhgI/cCgXT8=;
        b=OPAnvh4RPnQFK1WUP+xYwln8O0IfAvvRrWK/SnJOB5YpeoTZ9g9hF6r1EKvkfCEdaU
         s2J4FeMm/39fYG/PVCNTlqVvUY3F24KI8oOPXT0lYeGcuxd7Wqq0Qdhf3C82Zjljsjl+
         lU3Sbpf2xNmlJfZo0dG9/r5Xv/URln5vRimpgnJnqHuPcWqcTcqhhwEHcGWKMKM8LByu
         VX6GFO4HNgW+qCgDblLJ1pQd7zXSLFq0so+ME07Uy0wclZypK0iQKveQzEnCs4CL5ewr
         yr1qf5BTghzcMc9NpHIpuQjrzSiTUJPeccsKUNA3CDgPypBVqZY4Sv767C8qgddvs5c+
         nbfA==
X-Gm-Message-State: AOJu0Yx/+4KnYVkhY0GTYXPirzf2Z3xdp6Lgn9tUV9hWnmwbvKog/QEG
	WurXR/APYETG5lzlpoNnsRU=
X-Google-Smtp-Source: AGHT+IG+mk6/ls+OdbOKvLn2A5wtrPAId+/+gKI2fIPwXozxZvv55pSOeYqFmPGplSU501gX0t0UfA==
X-Received: by 2002:a05:6512:3d05:b0:50e:c45f:87cd with SMTP id d5-20020a0565123d0500b0050ec45f87cdmr944889lfv.8.1704840461722;
        Tue, 09 Jan 2024 14:47:41 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id a8-20020a19ca08000000b0050e8ee30589sm487070lfg.175.2024.01.09.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:47:41 -0800 (PST)
Date: Wed, 10 Jan 2024 01:47:39 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>, 
	Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <foqjr2iqtjnkpbgefujshp7wj3pnbmk44dr2kwdqvvl5eg2dmp@6aroubspp3lt>
References: <20231221174051.35420-1-ajayagarwal@google.com>
 <y64obwzmcwo2raskreebfyda4sofncnsedzvnh4xo2zrnchokl@ovv4mtqzl7xb>
 <0635ac3c-94d3-4de4-bd56-d76de5d17067@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0635ac3c-94d3-4de4-bd56-d76de5d17067@arm.com>

On Mon, Jan 08, 2024 at 05:50:26PM +0000, Robin Murphy wrote:
> On 2023-12-21 6:33 pm, Serge Semin wrote:
> > Hi Ajay
> > 
> > On Thu, Dec 21, 2023 at 11:10:51PM +0530, Ajay Agarwal wrote:
> > > If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
> > > will fail to allocate the memory if there are no 32-bit addresses
> > > available. This will lead to the PCIe RC probe failure.
> > > Fix this by setting the DMA mask to 32 bits only if the kernel
> > > configuration enables DMA32 zone. Else, leave the mask as is.
> > > 
> > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > index 7991f0e179b2..163a78c5f9d8 100644
> > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > @@ -377,10 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > >   	 * Note until there is a better alternative found the reservation is
> > >   	 * done by allocating from the artificially limited DMA-coherent
> > >   	 * memory.
> > > +	 *
> > > +	 * Set the coherent DMA mask to 32 bits only if the DMA32 zone is
> > > +	 * supported. Otherwise, leave the mask as is.
> > > +	 * This ensures that the dmam_alloc_coherent is successful in
> > > +	 * allocating the memory.
> > >   	 */
> > > +#ifdef CONFIG_ZONE_DMA32
> > >   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > >   	if (ret)
> > >   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > +#endif
> > 
> > Without setting the mask the allocation below may cause having MSI
> > data from above 4GB which in its turn will cause MSI not working for
> > peripheral PCI-devices supporting 32-bit MSI only. That's the gist of
> > this questionable code above and below.
> 
> Right, this change is wrong on several levels, as it would end up hiding the
> warning in cases where it would be most relevant.
> 
> > The discussion around it can be found here:
> > https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com
> > and a problem similar to what you described was reported here:
> > https://lore.kernel.org/linux-pci/decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com/
> > 
> > The easiest solution in this case is to somehow pre-define
> > pp->msi_data with a PCI-bus address free from RAM behind and avoid
> > allocation below at all. The only question is how to do that. See the
> > discussions above for details.
> 

> FWIW there's also the potential question of whether failing to obtain a
> 32-bit address needs to be entirely fatal to probe at all. Perhaps it might
> be reasonable to just continue without MSI support, or maybe retry with a
> larger mask to attempt limited 64-bit-only MSI support - IIRC the latter was
> proposed originally, but Will's initial use-case didn't actually need it so
> we concluded it was hard to justify the complexity at the time. The main
> thing is not to quietly go ahead and do something which we can't guarantee
> to fully work, without at least letting the user know.

Hm, I guess you are right. It may be an overkill to halt the probe
procedure if 32-bit mask failed to be specified. Printing some big fat
warning looks better at least until it is possible to reserve a
PCIe-bus memory within lowest 4GB irrespective to the system RAM
availability and the device DMA capabilities.

Regarding the Will's patch. His solution wasn't entirely correct. It
implied to use the DW PCIe Root-Port MSI capability as a "storage" of
the MSI 64-bit flag. It was wrong from two perspective. First DW PCIe
iMSI-RX engine always supports 64-bit MSI addresses, so having the MSI
64-bit flag cleared would be at least misleading. Second it was much
easier and more correct to just define a flag with the same semantics
in the driver private data.

In anyway trying 32-bit mask and then falling back to the 64-bit one
sound reasonable indeed.

-Serge(y)

> 
> Thanks,
> Robin.
> 
> > 
> > -Serge(y)
> > 
> > >   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > >   					GFP_KERNEL);
> > > -- 
> > > 2.43.0.195.gebba966016-goog
> > > 
> > > 

