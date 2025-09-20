Return-Path: <linux-pci+bounces-36597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63F8B8CC2D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 627457C3CDC
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 15:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131E2236E8;
	Sat, 20 Sep 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci7RwxtL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A640A1EBFE0;
	Sat, 20 Sep 2025 15:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758383480; cv=none; b=XcF8HvjnUinYIJYq55HBcmAt8ZFJJWbJXWlBWuY9ltaAOg1IdUQBggA3+tAJZu9SeGjxalMv5lllM/MFGP8D616ZXyT04+L9NVbfgHvSHyp4fceaON2a8GPMerc5gYQxmQPwNeTeyuHDOGaaGXiR5/WrF4F3U9P/y7CetOzcVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758383480; c=relaxed/simple;
	bh=mR4v4EXQdRB/Jtk6fzE7auVcBUrgzQ2QkUJHyK5XQiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbc1LaNMwlmdN7wvki1Jlb9q1ddZ3mx3B0cUFoiekbFppCMkYZDokVudZgQpVY2Oh97zcs1ENgCOZCDLJZAy04HZ9VMi2lYtsqYUNSSdGJDt9LMROPXusNkfyUSBqkrmCOPZr2RTw+8TxvCYjsioQOXG40LftbbbcAJkO7y0IRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci7RwxtL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D414AC4CEEB;
	Sat, 20 Sep 2025 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758383480;
	bh=mR4v4EXQdRB/Jtk6fzE7auVcBUrgzQ2QkUJHyK5XQiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci7RwxtLdmcq8ea/FVl1MeSshBDTUPr5jjyoL6uPwL903LIjwtn99Lgc6a69lWT32
	 31lFsYfk1St8N4y21j5v6BL3aqQPEpIZlyGhftp4KRZ5jKOUbwc9h8RH4Bmv6WPMDc
	 Xt8nqCUnqTvjDg+9uHdC4iml28UldaHZeWOaUAGF4nXy3FHFABIDjshctrG2JyIp2x
	 6s5h26Y3C8xOUvGX+CNMP771/g3T42MRXwTGA0pi5BnkhsThm2rTjV7eVLVQLh9Kti
	 NaWpksmxSr27f9thz/r58N8uNy6L53HnTHwS9GqS9jXcCdbC5PWZPipXXX0RNWA78l
	 1ARfBaqt5VAXA==
Date: Sat, 20 Sep 2025 21:21:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ravi Kumar Bandi <ravib@amazon.com>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, michal.simek@amd.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: xilinx-xdma: Enable legacy interrupts
Message-ID: <472oclxowztq4zfvtqjdrn4whe2hpcecgmgmsrkw2gwfuvac7r@xrgouxxp3qva>
References: <20250919231330.886-1-ravib@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919231330.886-1-ravib@amazon.com>

On Fri, Sep 19, 2025 at 11:13:30PM +0000, Ravi Kumar Bandi wrote:

+ Thippeswamy (author or 8d786149d78c)

> Starting with kernel 6.6.0, legacy interrupts from PCIe endpoints
> do not flow through the Xilinx XDMA root port bridge because
> interrupts are not enabled after initializing the port.
> 
> This issue is seen after XDMA driver received support for QDMA and
> underwent relevant code restructuring of old xdma-pl driver to
> xilinx-dma-pl (ref commit: 8d786149d78c).
> 

The above mentioned commmit added a new driver. So I don't see when the driver
restructuring happened.

> This patch re-enables legacy interrupts to use with PCIe endpoints
> with legacy interrupts.

s/legacy/INTx, here and everywhere.

> Tested the fix on a board with two endpoints
> generating legacy interrupts. Interrupts are properly detected and
> serviced. The /proc/interrupts output shows:
> [...]
> 32:        320          0  pl_dma:RC-Event  16 Level     400000000.axi-pcie, azdrv
> 52:        470          0  pl_dma:RC-Event  16 Level     500000000.axi-pcie, azdrv
> [...]
> 
> Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>

Missing Fixes tag and you should CC stable list for backporting.

- Mani

> ---
>  drivers/pci/controller/pcie-xilinx-dma-pl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> index b037c8f315e4..cc539292d10a 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
> @@ -659,6 +659,12 @@ static int xilinx_pl_dma_pcie_setup_irq(struct pl_dma_pcie *port)
>  		return err;
>  	}
>  
> +	/* Enable interrupts */
> +	pcie_write(port, XILINX_PCIE_DMA_IMR_ALL_MASK,
> +		   XILINX_PCIE_DMA_REG_IMR);
> +	pcie_write(port, XILINX_PCIE_DMA_IDRN_MASK,
> +		   XILINX_PCIE_DMA_REG_IDRN_MASK);
> +
>  	return 0;
>  }
>  
> -- 
> 2.47.3
> 

-- 
மணிவண்ணன் சதாசிவம்

