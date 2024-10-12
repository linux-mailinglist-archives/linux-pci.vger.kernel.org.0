Return-Path: <linux-pci+bounces-14376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336FD99B29A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 11:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 878CAB210FC
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0513D516;
	Sat, 12 Oct 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+oiNdoX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94D08BE5
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728726075; cv=none; b=Li3QdBO294CPPiOJvhMyKpPk6BlFCRItcvaoM5wK3Tu+0vxSgSLdxjS92DpD/LNp5xxbIeart4M/PIbZbyVhPY0uO4NqAFgpf44EBwbVVVisDyfONDQbxAUhAzwMExRseikjFGaZY50TuSX4NkjtTsXZJcIXO+khsPB2uvGT13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728726075; c=relaxed/simple;
	bh=bStj+vp00q+N8xYK76RTR9YVSF6qWfG9l7f0/wK0n8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB8MRDfB7iBeG9h2cAn4Bv6zjJZ6jvmSFF5TYe3h88z53JPz3Ob0+uInfA//hOqS2Sn8U4lpHDnXuuGHHlDj1KmTIFvzij+pqD0hZfDEgXLkpKCYcLDK1X0dc66QdEoBSm16Okooaaaxw3aYEn8Zb6BZ+sg8zqAEVaPHy4D8Gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e+oiNdoX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b64584fd4so27251525ad.1
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 02:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728726073; x=1729330873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A63kbcQl+a/0JUXZgv27BuPYMqFpim3pD23eC9H8c8A=;
        b=e+oiNdoXYGtTiSdDHldPxjVBVbm9OEET6Y/RvO+4ee6ZvshVThP0T6r1UH5ocT35XD
         7saiBNm6cOw+h3zPxWOATdqUfUStVlcifyR+g4l4MwFjubsMl9WIprgOJDyvZRg9WXJv
         8O9S7dUEV+v28BPX8OvkYqfLjubNvDMuayxBh/mD02iHvkM7gG1Fqh7MaAa8Q1p0523W
         Q10hdNUAktIb9/5ZoO0LMGTv6XN3575l7mkfOkSVlSDiKZAALVnSo1KQ/oByl744oLy6
         4/nsM28Tlr7/af2kZERo3i1F4Rp6zkS2DUYErycQBe+HDsrPOpeZHztqNjWBdMtLr4wY
         mUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728726073; x=1729330873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A63kbcQl+a/0JUXZgv27BuPYMqFpim3pD23eC9H8c8A=;
        b=uAmRr6gPvNHR/SzLY3bWACHW8psPVnSKmT0hDBEykTBG7J1ZfznYFSscUE0LI7ZBWE
         oZ/5it+ZEGZpnkwrJbAgOs0WcwAy3pwvKk+OjajwdYIO4WSgayvnTtgqtPTiXncRMaJw
         coTMy5Bn8hPllnMqwvzWfpk65ZNhiJF6+kSI468+hMlsZA+skUOeTTgQyTU5SEcCjAa5
         9OTYZSHZp0H1uxJUonK6TU8TngkfczN//QTrrcNr7nn7iOdSI81Qhqz1qisbNNwMMSmS
         nlE02NtKIe5wAwF/sm3JQrgIvk9/bB+27HfAYl+10gNZEMuchwRxvk7yviK++Cjgj+UZ
         tWMg==
X-Forwarded-Encrypted: i=1; AJvYcCVfyLuQ38kQkW4gVdkvcRbEHxQlOEWADfyXfHZlc8fEx0M7QPfGqI3xJa1CWn1fRR+/EpzCbklrrOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNdB3Za9ydhwuPh/yarF9GYO8KIyQi/niAPW4OmHaN3mnL0bHb
	cObG/Ssu3J+vSNKyOraM55mBW1GMXlY1vC+IJh10lBHGocVV0Fa4Vm/KviJJTQ==
X-Google-Smtp-Source: AGHT+IGOdKD6j9dX5xjv+lP2pIo3gxEKND7CoYYsyasaAkbPKRRyMS/BhkdEsMth5xChGJFlFShkKg==
X-Received: by 2002:a17:903:1cf:b0:20b:4f95:932d with SMTP id d9443c01a7336-20ca144753emr61367605ad.3.1728726073034;
        Sat, 12 Oct 2024 02:41:13 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8badc69bsm34846455ad.17.2024.10.12.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 02:41:12 -0700 (PDT)
Date: Sat, 12 Oct 2024 15:11:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 4/7] PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
Message-ID: <20241012094108.ovxmd2ikhisyejqs@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-5-dlemoal@kernel.org>
 <20241010164355.okuasill4hzsipun@thinkpad>
 <ee174108-66d5-4a4e-8051-d4a5889ecd10@kernel.org>
 <20241012075654.d33yqcregmtjbkfi@thinkpad>
 <104e1cf9-f901-4e47-8a79-cf8df08d1ce1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <104e1cf9-f901-4e47-8a79-cf8df08d1ce1@kernel.org>

On Sat, Oct 12, 2024 at 05:33:34PM +0900, Damien Le Moal wrote:
> On 10/12/24 16:56, Manivannan Sadhasivam wrote:
> > On Fri, Oct 11, 2024 at 11:01:09AM +0900, Damien Le Moal wrote:
> >> On 10/11/24 01:43, Manivannan Sadhasivam wrote:
> >>> On Mon, Oct 07, 2024 at 01:03:16PM +0900, Damien Le Moal wrote:
> >>>> Introduce the function pci_epc_mem_map() to facilitate controller memory
> >>>> address allocation and mapping to a RC PCI address region in endpoint
> >>>> function drivers.
> >>>>
> >>>> This function first uses pci_epc_map_align() to determine the controller
> >>>> memory address size (and offset into) depending on the controller
> >>>> address alignment constraints. The result of this function is used to
> >>>> allocate a controller physical memory region using
> >>>> pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
> >>>> space with pci_epc_map_addr().
> >>>>
> >>>> Since pci_epc_map_align() may indicate that the effective mapping
> >>>> of a PCI address region is smaller than the user requested size,
> >>>> pci_epc_mem_map() may only partially map the RC PCI address region
> >>>> specified. It is the responsibility of the caller (an endpoint function
> >>>> driver) to handle such smaller mapping.
> >>>>
> >>>> The counterpart of pci_epc_mem_map() to unmap and free the controller
> >>>> memory address region is pci_epc_mem_unmap().
> >>>>
> >>>> Both functions operate using a struct pci_epc_map data structure
> >>>> Endpoint function drivers can use struct pci_epc_map to access the
> >>>> mapped RC PCI address region using the ->virt_addr and ->pci_size
> >>>> fields.
> >>>>
> >>>> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >>>> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >>>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> >>>
> >>> Looks good to me. Just one comment below.
> >>>
> >>>> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> >>>> ---
> >>>>  drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
> >>>>  include/linux/pci-epc.h             |  4 ++
> >>>>  2 files changed, 82 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >>>> index 1adccf07c33e..d03c753d0a53 100644
> >>>> --- a/drivers/pci/endpoint/pci-epc-core.c
> >>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >>>> @@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>>>  }
> >>>>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
> >>>>  
> >>>> +/**
> >>>> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> >>>> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
> >>>> + * @func_no: the physical endpoint function number in the EPC device
> >>>> + * @vfunc_no: the virtual endpoint function number in the physical function
> >>>> + * @pci_addr: PCI address to which the CPU address should be mapped
> >>>> + * @pci_size: the number of bytes to map starting from @pci_addr
> >>>> + * @map: where to return the mapping information
> >>>> + *
> >>>> + * Allocate a controller memory address region and map it to a RC PCI address
> >>>> + * region, taking into account the controller physical address mapping
> >>>> + * constraints using pci_epc_map_align().
> >>>> + * The effective size of the PCI address range mapped from @pci_addr is
> >>>> + * indicated by @map->pci_size. This size may be less than the requested
> >>>> + * @pci_size. The local virtual CPU address for the mapping is indicated by
> >>>> + * @map->virt_addr (@map->phys_addr indicates the physical address).
> >>>> + * The size and CPU address of the controller memory allocated and mapped are
> >>>> + * respectively indicated by @map->map_size and @map->virt_base (and
> >>>> + * @map->phys_base).
> >>>> + *
> >>>> + * Returns 0 on success and a negative error code in case of error.
> >>>> + */
> >>>> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>>> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> >>>> +{
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
> >>>
> >>> I don't like the fact that one structure is passed to two functions and both
> >>> modify some members. If you get rid of the pci_epc_map_align() API and just use
> >>> the callback, then the arguments could be passed on their own without the 'map'
> >>> struct.
> >>
> >> That would be far too many arguments. The pci_epc functions already have many
> >> (minimum of 3 for epc, func and vfunc). So I prefer trying to minimize that.
> >>
> > 
> > Actually, there is no need to pass 'func, vfunc' as I don't think the controller
> > can have different alignment requirements for each functions.
> > 
> > So I'm envisioning a callback like this:
> > 
> > 	u64 (*align_addr)(struct pci_epc *epc, u64 addr, size_t *offset, size_t *size);
> > 
> > And there is no need to check the error return also. Also you can avoid passing
> > 'offset', as the caller can derive the offset using the mapped and unmapped
> > addresses. This also avoids the extra local function and allows the callers to
> > just use the callback directly.
> > 
> > NOTE: Please do not respin the patches without concluding the comments on
> > previous revisions. I understand that you want to get the series merged asap and
> > I do have the same adjective.
> 
> v5 that I posted yesterday addressed all your comment, except the one above.
> The controller operation (renamed get_mem_map) still uses the pci_mem_map
> structure as argument.
> 
> I need to respin a v6. Do you want me to change the controller op as you suggest
> above ?
> 

Please do so. I will apply it right away as everything else looks good.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

