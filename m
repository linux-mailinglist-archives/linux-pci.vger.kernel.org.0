Return-Path: <linux-pci+bounces-2442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E583735F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 21:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7444828379D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jan 2024 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E46C3FE5C;
	Mon, 22 Jan 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pl3sBx1h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56BB3B790;
	Mon, 22 Jan 2024 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953637; cv=none; b=VzeJnyxEPcNmOsoI0vKun+jd2TFKZozeWdZupmZ90rQq94mzU7cHjlZbJXK3g3npBAYcs9DQIi2zJ+FMAk24qkhPmzmefkGaunU9Ff44sB4n4hPtxhTePzpMP+lcpuJXeq85f/0cj+MYvswcJYBZOSjn8EAxb8HO3QfTaZNz58E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953637; c=relaxed/simple;
	bh=zSVvwnD2LANWDKYMIGKtC/aUqoKUraMfvhOhQu1rYuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijJHLOwo9dki/MCPEulWJ+6ENx2rZ2YRP4l+g7E3mrrZVEIhQhuIlZs5clmafLaxW2hYX8g7uhrqoONJQzMDQrH3MX8tPYXoK69JWR2+ABUSjn53sXDWhegfdsmTXqV5nh90wsf8hPF2/6v6N10tcR5QRcV5v+j8zeYjBM7A6hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pl3sBx1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F412C433F1;
	Mon, 22 Jan 2024 20:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705953637;
	bh=zSVvwnD2LANWDKYMIGKtC/aUqoKUraMfvhOhQu1rYuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pl3sBx1h9R7FS8xM5FOwXsZdDpNmIghy8nnHcpg50m7KRa2byb8exGgVut8a28qKt
	 PfY/sQhqsAh7cvz3LMYL1Lct/GtxQWiaJuCpunV0jvxaKzb9hc+SMiBNDRhUsd7WU1
	 5pBwrFsETpM9dyzLDr/c1KEWm8vypI0rFSvN8RdZ/7PidlcIMpqiU6A9+o1YZ5LI/s
	 M81uSLpk+8Uz/Oo7GkGtUj3BOEdMTWfeceKLRBh4jbA8L99jK9DlMfQmrx1rsG1dPm
	 +IcSM89SU8XL08xcvw04hIefSpeNmvGu18cQfVVmuzmMLmB9iFFHlWYxkxTYV/U7NA
	 NAnbYYwK9SDFw==
Date: Mon, 22 Jan 2024 21:00:27 +0100
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
Message-ID: <Za7JW3ThCXI4axH+@x1-carbon>
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

Reviewed-by: Niklas Cassel <cassel@kernel.org>

