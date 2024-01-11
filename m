Return-Path: <linux-pci+bounces-2023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CC82A6B6
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398081F23EA1
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 03:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D839AED4;
	Thu, 11 Jan 2024 03:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFuOBPVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57530EC0
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3f2985425so25354755ad.3
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 19:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704945534; x=1705550334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=843E1j+ytC4dpoAD+2eo2an3ENNVlI/ZsKrJRiTl7q4=;
        b=wFuOBPVqcFrrpy5cniXOIMYq9LBmzDFmKNoKoxcDN1vPwIjNxGXo/qcSLLChMI7zny
         JkbCr8u5mgzT/+r7C2ProGnrobkaEyoGI0VWjgHrFRy8TT+2vwGvVl3u1+tKjxS6MuYM
         4haeOuAXmSSIEmN6y1WZ1WdkM9lFEBhM87so6iJY2h0ot3dcvWhPSHOMcBtrDO0iRD8n
         4BaiibIAjULfDYdY6jIuFsLQR3L83VMhdLF02ENwdyucluZzh1cUcb9UjXJtOvvQ8VYj
         Opy5ZTsmsw8zq9YWw1n6Nkspx2mOVu1CAAATMhnseLLsXhIRhRIfAPo7JcUWPgzuwldY
         R6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704945534; x=1705550334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=843E1j+ytC4dpoAD+2eo2an3ENNVlI/ZsKrJRiTl7q4=;
        b=BtXk5JFVK+XDtSPq7pWhUUaIhebO9PDuwj3+5TGIOArAZcQvF6xYs/7hUMeHs/ho20
         5QkJFrkuRdAbr3ULRSdBK2oeYTLzNR7d6KjoC4YxJ/fiNyVcTuhbu/By/zBJLfdWsbTU
         xJH6hQwfYkI8kjcqrzNxoQTexgIEEvQfqgecm1JSjyaRy9bAEwrpTU57oOAX8WSzTT6J
         iYPIZ3+7Gox0WFdb6QdDy9e4h5naRpxL5VixIyvl7NrC1yDcIMQkayvCDK0xys+tZmO5
         iINWP0xsi1VkO+poW7eVD1c8VfQQIHEwQ1adJKWE9SYNB5ULmSYbdObfZRX3HDOHhJ+S
         hUyw==
X-Gm-Message-State: AOJu0YyixUOuk1M+VV/ECd1GBoNeY5mkKNhH9ryJxGTXUsrdBtvJ5r8J
	96nDkTb2YLvln+3UTrZyGsvxC+I3NuZc
X-Google-Smtp-Source: AGHT+IEbaotSIcA5d3U8yADzRW9dGMVKJH7bXKtBZw2OZ1DiLkmZ227p/wQSDi0izrrGGl1mkfwwkA==
X-Received: by 2002:a17:903:41c4:b0:1d4:e308:d703 with SMTP id u4-20020a17090341c400b001d4e308d703mr480884ple.73.1704945534305;
        Wed, 10 Jan 2024 19:58:54 -0800 (PST)
Received: from google.com (108.93.126.34.bc.googleusercontent.com. [34.126.93.108])
        by smtp.gmail.com with ESMTPSA id g12-20020a170902c38c00b001d52198a83esm110742plg.153.2024.01.10.19.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 19:58:54 -0800 (PST)
Date: Thu, 11 Jan 2024 09:28:45 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>,
	Sajid Dalvi <sdalvi@google.com>,
	William McVicker <willmcvicker@google.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is
 enabled
Message-ID: <ZZ9nde5wAdeYlzdD@google.com>
References: <20231221174051.35420-1-ajayagarwal@google.com>
 <y64obwzmcwo2raskreebfyda4sofncnsedzvnh4xo2zrnchokl@ovv4mtqzl7xb>
 <0635ac3c-94d3-4de4-bd56-d76de5d17067@arm.com>
 <foqjr2iqtjnkpbgefujshp7wj3pnbmk44dr2kwdqvvl5eg2dmp@6aroubspp3lt>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <foqjr2iqtjnkpbgefujshp7wj3pnbmk44dr2kwdqvvl5eg2dmp@6aroubspp3lt>

On Wed, Jan 10, 2024 at 01:47:39AM +0300, Serge Semin wrote:
> On Mon, Jan 08, 2024 at 05:50:26PM +0000, Robin Murphy wrote:
> > On 2023-12-21 6:33 pm, Serge Semin wrote:
> > > Hi Ajay
> > > 
> > > On Thu, Dec 21, 2023 at 11:10:51PM +0530, Ajay Agarwal wrote:
> > > > If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
> > > > will fail to allocate the memory if there are no 32-bit addresses
> > > > available. This will lead to the PCIe RC probe failure.
> > > > Fix this by setting the DMA mask to 32 bits only if the kernel
> > > > configuration enables DMA32 zone. Else, leave the mask as is.
> > > > 
> > > > Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
> > > >   1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 7991f0e179b2..163a78c5f9d8 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -377,10 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
> > > >   	 * Note until there is a better alternative found the reservation is
> > > >   	 * done by allocating from the artificially limited DMA-coherent
> > > >   	 * memory.
> > > > +	 *
> > > > +	 * Set the coherent DMA mask to 32 bits only if the DMA32 zone is
> > > > +	 * supported. Otherwise, leave the mask as is.
> > > > +	 * This ensures that the dmam_alloc_coherent is successful in
> > > > +	 * allocating the memory.
> > > >   	 */
> > > > +#ifdef CONFIG_ZONE_DMA32
> > > >   	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> > > >   	if (ret)
> > > >   		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
> > > > +#endif
> > > 
> > > Without setting the mask the allocation below may cause having MSI
> > > data from above 4GB which in its turn will cause MSI not working for
> > > peripheral PCI-devices supporting 32-bit MSI only. That's the gist of
> > > this questionable code above and below.
> > 
> > Right, this change is wrong on several levels, as it would end up hiding the
> > warning in cases where it would be most relevant.
> > 
> > > The discussion around it can be found here:
> > > https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com
> > > and a problem similar to what you described was reported here:
> > > https://lore.kernel.org/linux-pci/decae9e4-3446-2384-4fc5-4982b747ac03@yadro.com/
> > > 
> > > The easiest solution in this case is to somehow pre-define
> > > pp->msi_data with a PCI-bus address free from RAM behind and avoid
> > > allocation below at all. The only question is how to do that. See the
> > > discussions above for details.
> > 
> 
> > FWIW there's also the potential question of whether failing to obtain a
> > 32-bit address needs to be entirely fatal to probe at all. Perhaps it might
> > be reasonable to just continue without MSI support, or maybe retry with a
> > larger mask to attempt limited 64-bit-only MSI support - IIRC the latter was
> > proposed originally, but Will's initial use-case didn't actually need it so
> > we concluded it was hard to justify the complexity at the time. The main
> > thing is not to quietly go ahead and do something which we can't guarantee
> > to fully work, without at least letting the user know.
> 
> Hm, I guess you are right. It may be an overkill to halt the probe
> procedure if 32-bit mask failed to be specified. Printing some big fat
> warning looks better at least until it is possible to reserve a
> PCIe-bus memory within lowest 4GB irrespective to the system RAM
> availability and the device DMA capabilities.
>
Thanks Robin and Serge for your inputs. In the next version of the
patch, I will try to use the reserved memory, if it exists, to set up
the MSI data. If the reserved memory does not exist, the patch will try
to use the standard DMA API to allocate the msi_data.

> Regarding the Will's patch. His solution wasn't entirely correct. It
> implied to use the DW PCIe Root-Port MSI capability as a "storage" of
> the MSI 64-bit flag. It was wrong from two perspective. First DW PCIe
> iMSI-RX engine always supports 64-bit MSI addresses, so having the MSI
> 64-bit flag cleared would be at least misleading. Second it was much
> easier and more correct to just define a flag with the same semantics
> in the driver private data.
> 
> In anyway trying 32-bit mask and then falling back to the 64-bit one
> sound reasonable indeed.
> 
Yes, I will add the fallback to 64-bit if the 32-bit allocation fails.
This fallback will be irrespective of whether the connected/intended EP
supports 64-bit MSI or not.

> -Serge(y)
> 
> > 
> > Thanks,
> > Robin.
> > 
> > > 
> > > -Serge(y)
> > > 
> > > >   	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
> > > >   					GFP_KERNEL);
> > > > -- 
> > > > 2.43.0.195.gebba966016-goog
> > > > 
> > > > 

