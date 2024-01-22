Return-Path: <linux-pci+bounces-2444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CCB8373BE
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 21:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D171E290BA2
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716DB47773;
	Mon, 22 Jan 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEmMchw9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5847A74;
	Mon, 22 Jan 2024 20:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955392; cv=none; b=ZCe+t+StRvAyuONsNytGa9/H8Jmr+2fMI0m4J7+VLbK9dlj7WalVaciHTJ+FEzkNPPybRnvGHU90W6/2CU3x8FtmdQ0sysDsA1QnaCH9+YVDKV0Gyas1DNXPFLnaTQ1neLWf+jog3vF0Lx1+lBkqa2bhN0GgFuXNBzdEE+SJ/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955392; c=relaxed/simple;
	bh=Y3EXBEoU3EZ5ZxGkaPVnRGmzkLJq9ZuinS9YeAT7Mic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDpIvJR1h1U98uvvM00bQsOSW3reB+FE9RERk3/LFwhDE+Mxm+TV1uZL4fyCwReZPJFpVu8QacQH/NjS+3ix7DZcfESeFvCzyD8ItmUVzJdMSxcA5ds+cNGtGeOJ1099YKGxtV2/ZjwzF/BRVcrMJ9HwKzTKKtyral5RJi2aCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEmMchw9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A95C433C7;
	Mon, 22 Jan 2024 20:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955392;
	bh=Y3EXBEoU3EZ5ZxGkaPVnRGmzkLJq9ZuinS9YeAT7Mic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEmMchw9gV9k72seBZMorakDsZ/Zb6H26fE9aXHqJ2xFoX1Fq3gBFToRBhCniqT4/
	 EiWahqeUVyo5s6YuQ/Dnt7ivt+PxDNQgtYb5KXheBtaq5Dd/+N1Jgd+GLdKRYsSAvd
	 za3iKKjrSSCnhiFuJvz5dTp9/VqqN/MK+ik0q6wMl2iZLOkipVqPwl5in9GHzKwC0M
	 e0TPOhexIydLbLMcctK9q8CyvNf91IWylUWTLOIs33YR9qj9rIF3G3PZDCAFy7EaOF
	 PYuTFiaSgY0PZrBR31Cz3kd4zfjIzo7kKwXUdtJLFDxmbGv7TMQ61CxU2GX4TVzeDt
	 o22UIQpqoD0Nw==
Date: Mon, 22 Jan 2024 21:29:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Niklas Cassel <niklas.cassel@wdc.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3 1/2] PCI: dwc: Fix a 64bit bug in
 dw_pcie_ep_raise_msix_irq()
Message-ID: <Za7QOLQEOcUTfhSX@x1-carbon>
References: <d0d5b689-9437-43cd-8c1f-daa72aeafb2e@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0d5b689-9437-43cd-8c1f-daa72aeafb2e@moroto.mountain>

On Mon, Jan 22, 2024 at 06:19:52PM +0300, Dan Carpenter wrote:
> The "msg_addr" variable is u64.  However, the "aligned_offset" is an
> unsigned int.  This means that when the code does:
> 
>         msg_addr &= ~aligned_offset;
> 
> it will unintentionally zero out the high 32 bits.  Use ALIGN_DOWN()
> to do the alignment instead.
> 
> Fixes: 2217fffcd63f ("PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: fix typo in commit message
> v3: Use ALIGN_DOWN() instead of ANDing with ~aligned_offset (this is a
>     style improvement).
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 5befed2dc02b..51679c6702cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -551,7 +551,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> -	msg_addr &= ~aligned_offset;
> +	msg_addr = ALIGN_DOWN(msg_addr, epc->mem->window.page_size);
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

Oh.. I just got emails that the patch that this fixes has been backported,
so perhaps we should add:
Cc: stable@vger.kernel.org
as well...?


Kind regards,
Niklas

