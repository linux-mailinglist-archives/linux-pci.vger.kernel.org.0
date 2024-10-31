Return-Path: <linux-pci+bounces-15751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832B9B8459
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 21:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 027C71F228C6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 20:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2ED1B3B28;
	Thu, 31 Oct 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu2sUAzl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51881A2562
	for <linux-pci@vger.kernel.org>; Thu, 31 Oct 2024 20:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406532; cv=none; b=bw2aIOu3h323CLpsQFgB4J3SViT4FAMAvoC6jfLbg6uIzJ8U82qnnH5iXaFSmZ1O0ElfecTN7YRlrscrshr2AIM/2wWd+9woLm8yPF/Bvqncu/xN8rLj3wPMHC1WNkHsYNOfNxfxYRLdtKLRBrZjxr56AXqjoVrwtSLZWmlvEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406532; c=relaxed/simple;
	bh=BJPL8kgo7OWUIiGC/AcPCXchbICif4ZxCX6nWCdxrKI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fMrEYL1zMBrHXwCOK7V54qG202qUNJfbA3Vzezn+4eRiHA9my4oKeWsBsAHG/8oj35getxdM7UXg58G480iTmukwi17kTHAZBdP9D1jyI7wGMBdfyyrx986jiHlZPbz4XSUXCzy2y/HjfuxhI4N+00Cvj1nocWjqZ0qj7oJBIbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu2sUAzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B06C4CEC3;
	Thu, 31 Oct 2024 20:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730406532;
	bh=BJPL8kgo7OWUIiGC/AcPCXchbICif4ZxCX6nWCdxrKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mu2sUAzl0fmgU7gibHIAyzIAKu2aM0IXt8zoIz7tUDvrAz1Rzbxo2g/FKZc9uWX0o
	 CZmUATvZFFR+mHQwZvy0L9S5uEWmvvsTM68hPUfw7fFWA9OP/iNjwe/RYkSW74rrzu
	 32Wt7SKSiON2/gRBKdce1EbJkd0Nt3+XYBB12xZrWl/uOODLpgm4pvXM7Rh46M3oL+
	 uEUGhdEpRiv79RpPAlZb8zgz1Avt1JAh6gjLf6VC7G8LYMD1eGTpy64ZSLUqPNr/Mt
	 /fcQQy28QDU0DkmW+dTckFiFGQdMzp3d1R6OOeNHRAFUB3oilCOSxltoOdMe6wIifj
	 dJbHgScy+Vo/Q==
Date: Thu, 31 Oct 2024 15:28:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: dwc: ep: Use align addr function for
 dw_pcie_ep_raise_{msi,msix}_irq()
Message-ID: <20241031202849.GA1266008@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017132052.4014605-6-cassel@kernel.org>

On Thu, Oct 17, 2024 at 03:20:55PM +0200, Niklas Cassel wrote:
> Use the dw_pcie_ep_align_addr() function to calculate the alignment in
> dw_pcie_ep_raise_{msi,msix}_irq() instead of open coding the same.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c    | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 20f67fd85e83..9bafa62bed1d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -503,7 +503,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int aligned_offset;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u16 msg_ctrl, msg_data;
>  	bool has_upper;
>  	u64 msg_addr;
> @@ -531,14 +532,13 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
>  
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> -				  epc->mem->window.page_size);
> +				  msi_mem_size);

I haven't worked through this; just double checking that this is
correct.  Previously we did ALIGN_DOWN() here, but
dw_pcie_ep_align_addr() uses ALIGN() (not ALIGN_DOWN()).  Similar
below in dw_pcie_ep_raise_msix_irq().

>  	if (ret)
>  		return ret;
>  
> -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + aligned_offset);
> +	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
>  
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>  
> @@ -589,8 +589,9 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	struct pci_epf_msix_tbl *msix_tbl;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> +	size_t msi_mem_size = epc->mem->window.page_size;
> +	size_t offset;
>  	u32 reg, msg_data, vec_ctrl;
> -	unsigned int aligned_offset;
>  	u32 tbl_offset;
>  	u64 msg_addr;
>  	int ret;
> @@ -615,14 +616,13 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		return -EPERM;
>  	}
>  
> -	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
> +	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &msi_mem_size, &offset);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
>  		return ret;
>  
> -	writel(msg_data, ep->msi_mem + aligned_offset);
> +	writel(msg_data, ep->msi_mem + offset);
>  
>  	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
>  
> -- 
> 2.47.0
> 

