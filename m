Return-Path: <linux-pci+bounces-14210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E067998DBB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 18:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02DA1C23AD0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244FC198A39;
	Thu, 10 Oct 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rs9WlPv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D0198A16
	for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728578647; cv=none; b=a+IB1mJf0QsUSJXW16046xkuilrIlRfW8yd2TzwK9gxabnYQ1Z1cgtxFItBsZjfaw9hKKhA5YaolzLoSMIlAAgSOF0U5XVRDERlloSclNchbn7vsYOTYMneIQXltG4HazMgA6ImcNGY24DXIFGkE//Lrt3gXlyvxz3jnfoEEOMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728578647; c=relaxed/simple;
	bh=JMYzHqUsQbb4EegJpZuK14CNMniHTrfjYwjZ0ma0YU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJJTAVtg/J2G1L8clJw1jQ/PLPN7GzUzkgShTKg2D9MvrVi3E+ybMJ3eVzhZuxzQPUuw62uOT/VqArXcAXU5bdDMqkGYI4kOG/YEi8oHbVbwlDKsX6+7aVEg2o2ROJYPVpcwzLb7D/YV558S4EJR969fSw+OWTNjP3k9+joIz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rs9WlPv6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso240875a91.3
        for <linux-pci@vger.kernel.org>; Thu, 10 Oct 2024 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728578645; x=1729183445; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=503i92klikUB2VXf1HDMT0Z+iQNwQyNsTacW5O/ASCY=;
        b=rs9WlPv6sJzBZQbjlzhE5x5h7zrRFIzi3OyMTCdoEhtVCdIv6pQrqXMRpkVeaZcZZQ
         rvOHxTZIe+8qpw+yQxj1x/QsIqaGPHv/qtbkyhYQnIW/PJ4XO+iAhL5naGNazzt2x0KD
         EyP+21kQLmHAbfeKdMysyWAjNvR5tUHEmElSyjLoa9C/cwIx8h4NTb8gaUiy+2OtZO9x
         mTzxJ4ohZU3OplhTM7PfBtyNx5I6mKlq6rd0lPsa1sKVVKJk33b28dFJ/ldsYYVVpYF6
         etOLHiWaPKv+jVAfu9pNCZYqqCh94YR/CvA4LFQs/g8PkywuC2r28bm/hbyMrdNKaqwP
         9lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728578645; x=1729183445;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=503i92klikUB2VXf1HDMT0Z+iQNwQyNsTacW5O/ASCY=;
        b=B+BY+t+OipeJQ5mkIpr+BhY8zuf29IJ9uFlQ7E165yJ5Oz3rmpxROom1lsK63u8Nxl
         mV0H/lIZAZxnDA5mzR5uUrXfIqnQSNMxsOQeWZTOrq1mOzDCygtgPvg5WBo0PKeAc/uA
         NjcPd3rL88AD3VBCxRif6J13gcCfpJAE4YzI5q3UIffJasV9ZSt1hMsZLJJsDaYzCa8l
         V3QSWbXPpoC/0hmvUtfF4VzRvbfhU3NDsGI9ROtIR0SjNvxVo5p3D2HcIbUOkSFEmHTJ
         jIbzqiiesOGPHDpUDjmFzMn5FPu5VMW67HfGzt7THOuCKgx8zfI7lCzrboKHO3L7tYHT
         kOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeE3uE1enG9F+eEnbUs2JS+job4h7+KkcARFqdG/I+pkhTOWTPlTi4Ihrc2FfECEcD+z8R1YFLC+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHaPjCWjbq4j0pWCUEw6DHHKIhOJeD5CBHaG8MOVx9Jheye3gR
	XmAFK3hNVU2FAVUVnfWmP83TbbDHd3rBiqIyOdZVlQm5RiDuOeQBWHwNUj92xQ==
X-Google-Smtp-Source: AGHT+IFTgMgM7Z1uiD5w+IVSlxAkNM07nWDSWxnkrg7+o6IJZpB6yJPIB2OrlwWi9GvYkmF9WCvDdQ==
X-Received: by 2002:a17:90a:1784:b0:2e2:a96c:f009 with SMTP id 98e67ed59e1d1-2e2a96cf022mr7642628a91.9.1728578644709;
        Thu, 10 Oct 2024 09:44:04 -0700 (PDT)
Received: from thinkpad ([36.255.17.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5eeb024sm1541438a91.22.2024.10.10.09.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 09:44:03 -0700 (PDT)
Date: Thu, 10 Oct 2024 22:13:55 +0530
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
Message-ID: <20241010164355.okuasill4hzsipun@thinkpad>
References: <20241007040319.157412-1-dlemoal@kernel.org>
 <20241007040319.157412-5-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241007040319.157412-5-dlemoal@kernel.org>

On Mon, Oct 07, 2024 at 01:03:16PM +0900, Damien Le Moal wrote:
> Introduce the function pci_epc_mem_map() to facilitate controller memory
> address allocation and mapping to a RC PCI address region in endpoint
> function drivers.
> 
> This function first uses pci_epc_map_align() to determine the controller
> memory address size (and offset into) depending on the controller
> address alignment constraints. The result of this function is used to
> allocate a controller physical memory region using
> pci_epc_mem_alloc_addr() and map that memory to the RC PCI address
> space with pci_epc_map_addr().
> 
> Since pci_epc_map_align() may indicate that the effective mapping
> of a PCI address region is smaller than the user requested size,
> pci_epc_mem_map() may only partially map the RC PCI address region
> specified. It is the responsibility of the caller (an endpoint function
> driver) to handle such smaller mapping.
> 
> The counterpart of pci_epc_mem_map() to unmap and free the controller
> memory address region is pci_epc_mem_unmap().
> 
> Both functions operate using a struct pci_epc_map data structure
> Endpoint function drivers can use struct pci_epc_map to access the
> mapped RC PCI address region using the ->virt_addr and ->pci_size
> fields.
> 
> Co-developed-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Looks good to me. Just one comment below.

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 78 +++++++++++++++++++++++++++++
>  include/linux/pci-epc.h             |  4 ++
>  2 files changed, 82 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 1adccf07c33e..d03c753d0a53 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -532,6 +532,84 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>  
> +/**
> + * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> + * @epc: the EPC device on which the CPU address is to be allocated and mapped
> + * @func_no: the physical endpoint function number in the EPC device
> + * @vfunc_no: the virtual endpoint function number in the physical function
> + * @pci_addr: PCI address to which the CPU address should be mapped
> + * @pci_size: the number of bytes to map starting from @pci_addr
> + * @map: where to return the mapping information
> + *
> + * Allocate a controller memory address region and map it to a RC PCI address
> + * region, taking into account the controller physical address mapping
> + * constraints using pci_epc_map_align().
> + * The effective size of the PCI address range mapped from @pci_addr is
> + * indicated by @map->pci_size. This size may be less than the requested
> + * @pci_size. The local virtual CPU address for the mapping is indicated by
> + * @map->virt_addr (@map->phys_addr indicates the physical address).
> + * The size and CPU address of the controller memory allocated and mapped are
> + * respectively indicated by @map->map_size and @map->virt_base (and
> + * @map->phys_base).
> + *
> + * Returns 0 on success and a negative error code in case of error.
> + */
> +int pci_epc_mem_map(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +		    u64 pci_addr, size_t pci_size, struct pci_epc_map *map)
> +{
> +	int ret;
> +
> +	ret = pci_epc_map_align(epc, func_no, vfunc_no, pci_addr, pci_size, map);

I don't like the fact that one structure is passed to two functions and both
modify some members. If you get rid of the pci_epc_map_align() API and just use
the callback, then the arguments could be passed on their own without the 'map'
struct.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

