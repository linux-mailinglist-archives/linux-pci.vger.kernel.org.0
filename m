Return-Path: <linux-pci+bounces-66-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BEE7F386F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD88281623
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB2584F3;
	Tue, 21 Nov 2023 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSNOEppC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563B584F2
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 21:37:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A28C433C8;
	Tue, 21 Nov 2023 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700602677;
	bh=kK9LzfZt6D3Gt4ZliyPofIg9r8bVnd54yLxBigI3P8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FSNOEppCFUuR8bEdizt5WFfa63bqJeeTsuMPB9YHGyagrl3KbEjJZvcyEI2ScJk8z
	 AFYqJxId27DI6YNscx8+h//NL70SSdRaYKpIt0rPiMlElci7dFUdprtbRno+eG3vR1
	 nAcGM1RtL4tUEMZ53b3jP+kpzTZSoI35ZlUefGgLW7We/QkQd5whew9Awg5cfVB6uk
	 b5YdOZiuh0jOFkHi1fmXrgANf8I2LsKjkZC9wgNk1F7vdTRh1WnNEcXpQgVM99mOcr
	 RbCwXiXqXFxWxbiPCEKFHRdnOprSqBF8kJNlCO2kyX6TpVq3mFWI7ERlb9ahlwWyxc
	 VgMFCX9qz92yA==
Date: Tue, 21 Nov 2023 15:37:55 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, skinsburskii@gmail.com
Subject: Re: [PATCH] PCI: mediatek: Fix sparse warning caused to
 virt_to_phys() prototype change
Message-ID: <20231121213755.GA258354@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170052362584.21270.8345708191142620624.stgit@skinsburskii.>

On Mon, Nov 20, 2023 at 03:40:33PM -0800, Stanislav Kinsburskii wrote:
> Explicitly cast __iomem pointer to const void* with __force to fix the
> following warning:
> 
>   warning: incorrect type in argument 1 (different address spaces)
>      expected void const volatile *address
>      got void [noderef] __iomem *

I have two questions about this:

  1) There's no other use of __force in drivers/pci, so I don't know
  what's special about pcie-mediatek.c.  There should be a way to fix
  the types so it's not needed.

  2) virt_to_phys() is not quite right to begin with because what we
  want is a *bus* address, not the CPU physical address we get from
  virt_to_phys().  Obviously the current platforms that use this must
  not apply any offset between bus and CPU physical addresses, but
  it's not something we should rely on.

  There are only three drivers (pci-aardvark.c, pcie-xilinx.c, and
  this one) that use virt_to_phys(), and they're all slightly wrong
  here.

The *_compose_msi_msg() methods could use a little more consistency
across the board.

> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 66a8f73296fc..27f0f79810a1 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -397,7 +397,7 @@ static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	phys_addr_t addr;
>  
>  	/* MT2712/MT7622 only support 32-bit MSI addresses */
> -	addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +	addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
>  	msg->address_hi = 0;
>  	msg->address_lo = lower_32_bits(addr);
>  
> @@ -520,7 +520,7 @@ static void mtk_pcie_enable_msi(struct mtk_pcie_port *port)
>  	u32 val;
>  	phys_addr_t msg_addr;
>  
> -	msg_addr = virt_to_phys(port->base + PCIE_MSI_VECTOR);
> +	msg_addr = virt_to_phys((__force const void *)port->base + PCIE_MSI_VECTOR);
>  	val = lower_32_bits(msg_addr);
>  	writel(val, port->base + PCIE_IMSI_ADDR);
>  
> 
> 
> 

