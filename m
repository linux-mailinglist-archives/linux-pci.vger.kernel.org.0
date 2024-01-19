Return-Path: <linux-pci+bounces-2351-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90598329A4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55FA4B227BD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 12:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599895103F;
	Fri, 19 Jan 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfUiVApl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42651018;
	Fri, 19 Jan 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668381; cv=none; b=bvB8rk1928jozqp8xyT9Xcr0Na4o6pecg5D6jPcDMauGjtq3kt0HCtJbw4ZrqNsdCxByyNiFSumENWGvRhGRnoJXVPbJVLuWLW6eDhShziz0ZoYQ1FSUnR+QAVQCidOhqbfQZeWPTeiCTg+RpsXzYfgG1q+3n6jC98KUfJ6lghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668381; c=relaxed/simple;
	bh=xk3x+2RM2H/oAdspTIOEfhbsgKMkXla9iDqO6jQMg9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjK5gf/X223H2du87MXZU2MF/OmRXFWQbatBC933fiqzZYFh3J18/vsOvhbG+/qBzuvUf7XZh6DA1CGpCkWgT+LdBNlr9VeRPlzQe5hF/KKsIVjeIwbK2Y0AGbPCcDicMHvxX+Jmzs9OQ7y3rG/id18sqXn+rIKfw7sQScyAGy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfUiVApl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8450AC433F1;
	Fri, 19 Jan 2024 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705668380;
	bh=xk3x+2RM2H/oAdspTIOEfhbsgKMkXla9iDqO6jQMg9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfUiVAplPTiBub9LycMtmRS8kyKnJwiWqP+Ej/vi17J69lPhymH5nTmCXvLGlxY8u
	 k6VNqjchBuLPnqiWUAww7Pv2NTVX7VxAl69BMMoDyUDfpRgRt884JIjZvRan68GpWd
	 R9EukABSUPGXAvyId+6ej9ZXkICKHIrLaIEn/Xue6vGP+2cZKW55MtoHIZBaOaIMG4
	 2JplkA4DX/6ArH46zF9ocdvsrUeODfJMiuFin2LRchWbNLTOWhzBnkfxc3msEYaFKr
	 rjq1ic5DwwiC8cRFlUtAEM4N316Kzpy2ztrXWoxcjt68sY7vn7LqS4BRoiADWQ/9ZD
	 sps0MZ5+CZkbA==
Date: Fri, 19 Jan 2024 13:46:12 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: Cleanup in dw_pcie_ep_raise_msi_irq()
Message-ID: <ZapvFNHnhppQkoys@x1-carbon>
References: <c5035dc2-a379-48f0-8544-aa57d642136b@moroto.mountain>
 <e231e268-d537-4613-a87c-876d99ea49e4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e231e268-d537-4613-a87c-876d99ea49e4@moroto.mountain>

On Fri, Jan 19, 2024 at 11:24:18AM +0300, Dan Carpenter wrote:
> The alignment code in dw_pcie_ep_raise_msix_irq() and
> dw_pcie_ep_raise_msi_irq() is quite similar.  I recently update the code
> in the former, so tweak the latter to match as well for consistency sake.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Add this new patch
> 
> I wrote two versions of this, one where both patches were folded
> together and this one where the style tweaks are separated out into
> their own patch.  This is the better version.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 2b6607c23541..ccfc21cd0bb0 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -456,8 +456,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	u32 msg_addr_lower, msg_addr_upper, reg;
>  	struct dw_pcie_ep_func *ep_func;
>  	struct pci_epc *epc = ep->epc;
> -	unsigned int aligned_offset;
>  	u16 msg_ctrl, msg_data;
> +	u64 aligned_offset;
>  	bool has_upper;
>  	u64 msg_addr;
>  	int ret;
> @@ -483,8 +483,8 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
>  		msg_data = dw_pcie_ep_readw_dbi(ep, func_no, reg);
>  	}
>  	aligned_offset = msg_addr_lower & (epc->mem->window.page_size - 1);
> -	msg_addr = ((u64)msg_addr_upper) << 32 |
> -			(msg_addr_lower & ~aligned_offset);
> +	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> +	msg_addr &= ~aligned_offset;
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

I like this change, but like Ilpo said, perhaps even cleaner with:
msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);

As we can remove the aligned_offset variable completely,
no need to even change the type.

(dw_pcie_ep_raise_msix_irq() would obviously only need the
second statement.)


Kind regards,
Niklas

