Return-Path: <linux-pci+bounces-14368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725F699B1DF
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 09:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7C5284CEF
	for <lists+linux-pci@lfdr.de>; Sat, 12 Oct 2024 07:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43730126BE1;
	Sat, 12 Oct 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nhop+VGH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E77F13D53F
	for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 07:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719822; cv=none; b=Xf9XyVUtTyOfCEJQoVhXuQe9HOH3xQSWvVTlMKh97lTBVKNMl3nDM1wEa0qx+ZxfHYNR9iO2BX+4Uq6bu0Y0LtAutruAfJeQulrOid5iDIyPr2I6cRmwucLtpL1yS0Lt3GUhr4eQI0nonQrJgceqt7jxOfmLr5SWm91dCj1BLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719822; c=relaxed/simple;
	bh=X+Ov6N2DMA+YDC5jg+2pr+/h8n5WsdEHnFrs7M9UE5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFD46JmDHgVZX1E4IKcxAiMn66VyrWpbPFaTIeqpi52mxKSia6xiWMnMnqhis4VpfWE8l9ZKbpb7cPKikYLXAITzwACYoTSqBHfRO7BdFGURlAgZo8Zjoj99iUJhFTb0jdGhwx7T5INA/va8hQf0UzYCHxLjkb5jX2oV8LFHv+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nhop+VGH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-207115e3056so22673115ad.2
        for <linux-pci@vger.kernel.org>; Sat, 12 Oct 2024 00:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728719819; x=1729324619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AmFBCe7gbjWgMRYfCag2EJg+03xDsvkJhIfEIeIlZIk=;
        b=Nhop+VGHWzUiow1UAdCJN+dQQb/dp8hLBzWJGH3EQNFHJsY+b5/Tk/NBCWupw76XeU
         52rTcezo//x7Uy2Ko9JH5vb5olzn0dm9A2ffcMBsy7QEsDf2il+eMFCmaed8zNubiLWW
         Uu9ZrFsXCNRJF9Qk62Tk/HPvTQ/5ybIqPmXT1o49vVaKbrkHUA+xdIXxDqPhCIVTCPfK
         Wjwd2Y5yY0By3PHx7szm5IdPylm3pZkh4QUNv8SFkYX3w/qBzd8ve+v937C2IHFTCtN/
         rFcJ9iyvGUPQfHRxFhz94/nk3HOyPlZpiLX1KdA7i/U9mPp2/s1Bti7YWB7t6TvFv+0N
         U8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728719819; x=1729324619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AmFBCe7gbjWgMRYfCag2EJg+03xDsvkJhIfEIeIlZIk=;
        b=MaicaWE2iVRgEN2XGeLmu6CPfbyOU6toM1xa1KRdVUCMSyFsKRmuKmOL08+c+pen9H
         cO2GSsgj8QkxC55V8T9pHGhA0KC+1cSXUt759is1LH0legHKJcOpk4xG5q/evP5xc9Xg
         lvFJPBScBXBJCEIqzpSdrR+zGJJzdhX5R59jruNGUuFlpo32LW/WSvJKHJXHfUnLWmKM
         tY+ff+++PIvntr3qXSq1gIvWMSwRXouRxmZgHq0m7193AOoPP1gkGBAHxq/qo56oIYRm
         U4Vvoe8sQbyXd/Tdvc/8vBXhyXz7ablQ1av6vnPgBbMVxTu/sT5MeokNxCbkkftHO6IF
         UVMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+o+LRWG2IfG0ivEsXd3QSGZjEUVyTWHEvnwrA3lOEQgzVObY7scQs6a8cfRnPJIZ5kC3v1bF5qvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaPrKKsMjOeiUNkOUoqn0DEnp+gKs3xHGJCm1vPpyNDsNRFfes
	aLxfs2Qzg5iCugEDrkyubfsRHkpSUHJatnfB/ekkskM+N3/AlJ/Iwt8OaYtjvQ==
X-Google-Smtp-Source: AGHT+IFguBgvzB5t22j4wR9WorRHBNwfYpfSyCfV++xLU3mYl3nUL0KQP/JHPY4y+I1FntL5TAuxbQ==
X-Received: by 2002:a17:902:f542:b0:20b:a728:d130 with SMTP id d9443c01a7336-20ca144eca3mr89130715ad.14.1728719819542;
        Sat, 12 Oct 2024 00:56:59 -0700 (PDT)
Received: from thinkpad ([220.158.156.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c34aaaasm33588315ad.290.2024.10.12.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 00:56:58 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:26:54 +0530
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
Message-ID: <20241012075654.d33yqcregmtjbkfi@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-5-dlemoal@kernel.org>
 <20241010164355.okuasill4hzsipun@thinkpad>
 <ee174108-66d5-4a4e-8051-d4a5889ecd10@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee174108-66d5-4a4e-8051-d4a5889ecd10@kernel.org>

On Fri, Oct 11, 2024 at 11:01:09AM +0900, Damien Le Moal wrote:
> On 10/11/24 01:43, Manivannan Sadhasivam wrote:
> > On Mon, Oct 07, 2024 at 01:03:16PM +0900, Damien Le Moal wrote:
> >> Introduce the function pci_epc_mem_map() to facilitate controller memory
> >> address allocation and mapping to a RC PCI address region in endpoint
> >> function drivers.
> >>
> >> This function first uses pci_epc_map_align() to determine the controller
> >> memory address size (and offset into) depending on the controller
> >> address alignment constraints. The result of this function is used to
> >> allocate a controller physical memory region using
> >> pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
> >> space with pci_epc_map_addr().
> >>
> >> Since pci_epc_map_align() may indicate that the effective mapping
> >> of a PCI address region is smaller than the user requested size,
> >> pci_epc_mem_map() may only partially map the RC PCI address region
> >> specified. It is the responsibility of the caller (an endpoint function
> >> driver) to handle such smaller mapping.
> >>
> >> The counterpart of pci_epc_mem_map() to unmap and free the controller
> >> memory address region is pci_epc_mem_unmap().
> >>
> >> Both functions operate using a struct pci_epc_map data structure
> >> Endpoint function drivers can use struct pci_epc_map to access the
> >> mapped RC PCI address region using the ->virt_addr and ->pci_size
> >> fields.
> >>
> >> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> >> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> > 
> > Looks good to me. Just one comment below.
> > 
> >> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> >> ---
> >>  drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
> >>  include/linux/pci-epc.h             |  4 ++
> >>  2 files changed, 82 insertions(+)
> >>
> >> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> >> index 1adccf07c33e..d03c753d0a53 100644
> >> --- a/drivers/pci/endpoint/pci-epc-core.c
> >> +++ b/drivers/pci/endpoint/pci-epc-core.c
> >> @@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >>  }
> >>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
> >>  
> >> +/**
> >> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> >> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
> >> + * @func_no: the physical endpoint function number in the EPC device
> >> + * @vfunc_no: the virtual endpoint function number in the physical function
> >> + * @pci_addr: PCI address to which the CPU address should be mapped
> >> + * @pci_size: the number of bytes to map starting from @pci_addr
> >> + * @map: where to return the mapping information
> >> + *
> >> + * Allocate a controller memory address region and map it to a RC PCI address
> >> + * region, taking into account the controller physical address mapping
> >> + * constraints using pci_epc_map_align().
> >> + * The effective size of the PCI address range mapped from @pci_addr is
> >> + * indicated by @map->pci_size. This size may be less than the requested
> >> + * @pci_size. The local virtual CPU address for the mapping is indicated by
> >> + * @map->virt_addr (@map->phys_addr indicates the physical address).
> >> + * The size and CPU address of the controller memory allocated and mapped are
> >> + * respectively indicated by @map->map_size and @map->virt_base (and
> >> + * @map->phys_base).
> >> + *
> >> + * Returns 0 on success and a negative error code in case of error.
> >> + */
> >> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);
> > 
> > I don't like the fact that one structure is passed to two functions and both
> > modify some members. If you get rid of the pci_epc_map_align() API and just use
> > the callback, then the arguments could be passed on their own without the 'map'
> > struct.
> 
> That would be far too many arguments. The pci_epc functions already have many
> (minimum of 3 for epc, func and vfunc). So I prefer trying to minimize that.
> 

Actually, there is no need to pass 'func, vfunc' as I don't think the controller
can have different alignment requirements for each functions.

So I'm envisioning a callback like this:

	u64 (*align_addr)(struct pci_epc *epc, u64 addr, size_t *offset, size_t *size);

And there is no need to check the error return also. Also you can avoid passing
'offset', as the caller can derive the offset using the mapped and unmapped
addresses. This also avoids the extra local function and allows the callers to
just use the callback directly.

NOTE: Please do not respin the patches without concluding the comments on
previous revisions. I understand that you want to get the series merged asap and
I do have the same adjective.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

