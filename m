Return-Path: <linux-pci+bounces-16828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7D9CD9C8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14325282AB9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF3B14A82;
	Fri, 15 Nov 2024 07:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EZESxr6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3827523A
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655174; cv=none; b=L7jFfqVSVZ7fXhTd4FrMYSSNbj5iHB4mZtUmNrQlonMNr3AAVW3XF2RACjMDQvtlG1NjntGIBejquPGxXlzZFBAcDKfa4MKZv3AqdL99PSzc5UEp6JCUbkEvxMUIXOdvOyG5qjw4i7tTw4k4UpsLuC/T76597mvtMAOIZFkSzJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655174; c=relaxed/simple;
	bh=SJ6ReGWio+Y7ptqxkcfbQORNCVOT4Dd9XJC5Zdk48eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK5uPIWb7sNqCTBBlYeLojZKTcWwbDbGRKopOz4z4NpPS6ReXzAqaL87Ab1WCMtmTHRyqYa/bm+w4NAQ2r7yShBGRrhhsjcPZukjx3uB04kxTxJ7gvTAzPscve/81Wa7bEgUc+CJ7tJ/GSjXRszZwueX0vVbZ0X5oEoikZ0NZcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EZESxr6Z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cb47387ceso17108725ad.1
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 23:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731655172; x=1732259972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E05l2WVMllOf+qhEx5yhRPvrNg7gHlgKIzqUw7keIo4=;
        b=EZESxr6ZOutzINsAexNjEke/iF8EUsnCb7uFTaqIoKkhOl2VaSOL/1hI+rnRzEC86n
         mIP2WFor8P/Hg+PCIk6Sa6TPwiQ0VNxNq6L2vdhl1+q4mrkqUN2i2dK6/rG6HMQS4DgO
         unvrXVrca9mDZwYaal0s8zj0tUhw8P75gZd6Cg6194xaeM4JNrxRPnfnVpJlly88nDzI
         XiPAa/OiFgAY1aBa1NFAvs49E8xKxJPD7Il1I1b1aIgSsUzudZEOcovRMkP77jL6L4b/
         lKqRB/ZreJAzErIivkScM0QjkYKXfj4DqCjd+0/uN9c6gNEbGUAOAWQ+NPIzSQjG83Om
         4Khg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731655172; x=1732259972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E05l2WVMllOf+qhEx5yhRPvrNg7gHlgKIzqUw7keIo4=;
        b=v51+pwj4plDI9WUMnRrsdSgx3v1tpkJlkbQqULYrvM5rkjuzQbOrv689vzM3i8PRhA
         zmYV9Uq70Otb9gjmRM8Tb8EbmBSxHrOPLQQKusp7nBLnkU0sNYRR0TLbxEj6jHyvcvJJ
         E/T3SZDpJHRuiYCaMFngR9VuyFGDu9eFc2EZi3WH5n7jmSh+y1TDqjfmsh5H5Wfvdsto
         MHonXajAjtjhl0reI4W9tq8y1T4H2/QprH9EIaupL6UERtv7mgH/8d65lwzMOCRSaSXl
         tRqX1pZMgkvZaZGGjj1da/2v8UGq6pPEEgYPRV23S593lm5ruQhdzoM95jXDiOj4qKVd
         EoQg==
X-Forwarded-Encrypted: i=1; AJvYcCUWzDRBEw7xj/irnKYP+lo1pptVhBDt+Ex8wMcPTOFYxlishrdD0rVtEvpY5RrE9N/MYsN+TJVhTWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vExXlvwGkcWMdEmzXhZZZV1myQ/VbyN7wrKZ9II/zCl1EHxY
	oIiv2W9Z6JKMtX6KhiFzYQgm8OjvgokTt20+SspquRLscf0G7WeHn4ppIvFaKw==
X-Google-Smtp-Source: AGHT+IHYNJuf9592B6mhambbCukGpp1uKuCVyZjcmQWRo8EoBPVfqmSoYlPw24LZsmzwnU3My5W69w==
X-Received: by 2002:a17:902:e843:b0:211:6b31:2f30 with SMTP id d9443c01a7336-211d0ed2bc3mr21645875ad.50.1731655171975;
        Thu, 14 Nov 2024 23:19:31 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f8c2c0sm6633345ad.182.2024.11.14.23.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:19:31 -0800 (PST)
Date: Fri, 15 Nov 2024 12:49:24 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Do not map more memory than needed to
 raise a MSI/MSI-X IRQ
Message-ID: <20241115071924.jn3xun6luqzd2ylp@thinkpad>
References: <20241104205144.409236-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104205144.409236-2-cassel@kernel.org>

On Mon, Nov 04, 2024 at 09:51:44PM +0100, Niklas Cassel wrote:
> In dw_pcie_ep_init() we allocate memory from the EPC address space that we
> will later use to raise a MSI/MSI-X IRQ. This memory is only freed in
> dw_pcie_ep_deinit().
> 
> Performing this allocation in dw_pcie_ep_init() is to ensure that we will
> not fail to allocate memory from the EPC address space when trying to raise
> a MSI/MSI-X IRQ.
> 
> We still map/unmap this memory every time we raise an IRQ, in order to not
> constantly occupy an iATU, especially for controllers with few iATUs.
> (So we can still fail to raise an MSI/MSI-X IRQ if all iATUs are occupied.)
> 
> When allocating this memory in dw_pcie_ep_init(), we allocate
> epc->mem->window.page_size memory, which is the smallest unit that we can
> allocate from the EPC address space.
> 
> However, when writing/sending the msg data, which is only 2 bytes for MSI,
> 4 bytes for MSI-X, in either case a single writel() is sufficient. Thus,
> the size that we need to map is a single PCI DWORD (4 bytes).
> 
> This is the size that we should send in to the pci_epc_ops::align_addr()
> API. It is align_addr()'s responsibility to return a size that is aligned
> to the EPC page size, for platforms that need a special alignment.
> 
> Modify the align_addr() call to send in the proper size that we need to
> map.
> 
> Before this patch on a system with a EPC page size 64k, we would
> incorrectly map 128k (which is larger than our allocation) instead of 64k.
> 
> After this patch, we will correctly map 64k (a single page). (We should
> never need to map more than a page to write a single DWORD.)
> 
> Fixes: f68da9a67173 ("PCI: dwc: ep: Use align addr function for dw_pcie_ep_raise_{msi,msix}_irq()")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

FWIW,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Feel free to squash this with the patch that it fixes, if you so prefer.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 9bafa62bed1dc..507e40bd18c8f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -503,7 +503,7 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t map_size = sizeof(u32);
>  	size_t offset;
>  	u16 msg_ctrl, msg_data;
>  	bool has_upper;
> @@ -532,9 +532,9 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>  
> -	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  msi_mem_size);
> +				  map_size);
>  	if (ret)
>  		return ret;
>  
> @@ -589,7 +589,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t map_size = sizeof(u32);
>  	size_t offset;
>  	u32 reg, msg_data, vec_ctrl;
>  	u32 tbl_offset;
> @@ -616,9 +616,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EPERM;
>  	}
>  
> -	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  map_size);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

