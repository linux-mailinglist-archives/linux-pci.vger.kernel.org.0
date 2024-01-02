Return-Path: <linux-pci+bounces-1599-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E83B821F08
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 311831C22357
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5D114A9C;
	Tue,  2 Jan 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeaq0CCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C0614A9A
	for <linux-pci@vger.kernel.org>; Tue,  2 Jan 2024 15:54:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F52C433C7;
	Tue,  2 Jan 2024 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704210861;
	bh=d+QOV5HREj4MesagpDuiJHlqER5Pdbshz+JFNNmMhZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeaq0CCTJ43lyvGvY4x820jT2qY6Hk+5rYBdNnrW9zhQRJgVbBWW7Q2nwHKLz1tmK
	 gYlJbqdx+plu8dQve64XqQwUrmj6gLs1P15S0sIgUd9o3JqyzoYdZDComu3PQD11K/
	 cyJIMoerCyAUXAC8vxsrI1OwpWxiJ7LoMeg3FDkz/9Lkzublpfg+ivObsq6NVoDARX
	 DpD4+vOIZaDY3f956/wC6ijy14nkatcf5iTh85QiA2eCloig9gpEA6a11qbObDijAy
	 uvjA5UbeLaAcG6VfhTAMUlAZRBr/a3Nd8PHhQqBE09sbmyz3dacc8MXmu3Z2xKk+ub
	 cJ8TM1UDaeZ3Q==
Date: Tue, 2 Jan 2024 21:24:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <nks@flawful.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Niklas Cassel <niklas.cassel@wdc.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq()
 alignment support
Message-ID: <20240102155406.GA4917@thinkpad>
References: <20231128132231.2221614-1-nks@flawful.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128132231.2221614-1-nks@flawful.org>

On Tue, Nov 28, 2023 at 02:22:30PM +0100, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Commit 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get
> correct MSI-X table address") modified dw_pcie_ep_raise_msix_irq() to
> support iATUs which require a specific alignment.
> 
> However, this support cannot have been properly tested.
> 
> The whole point is for the iATU to map an address that is aligned,
> using dw_pcie_ep_map_addr(), and then let the writel() write to
> ep->msi_mem + aligned_offset.
> 
> Thus, modify the address that is mapped such that it is aligned.
> With this change, dw_pcie_ep_raise_msix_irq() matches the logic in
> dw_pcie_ep_raise_msi_irq().
> 
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>
> Fixes: 6f5e193bfb55 ("PCI: dwc: Fix dw_pcie_ep_raise_msix_irq() to get correct MSI-X table address")
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>

I apparently missed this patch... LGTM!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Btw, since you are sending this patch from a different address, relevant s-o-b
should also be present.

- Mani

> ---
> Changes since v1:
> -Clarified commit message.
> -Add a working email for Kishon to CC.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..bc94d7f39535 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -615,6 +615,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  	}
>  
>  	aligned_offset = msg_addr & (epc->mem->window.page_size - 1);
> +	msg_addr &= ~aligned_offset;
>  	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
>  				  epc->mem->window.page_size);
>  	if (ret)
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

