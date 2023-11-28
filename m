Return-Path: <linux-pci+bounces-228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE13E7FBF1A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 17:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8EB20F1C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Nov 2023 16:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B833237D27;
	Tue, 28 Nov 2023 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GacHvmkL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2AB37D1A
	for <linux-pci@vger.kernel.org>; Tue, 28 Nov 2023 16:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE2AC433C9;
	Tue, 28 Nov 2023 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701188498;
	bh=4qDVk8o7YVAgg3SDMtAc4y2tizKHp7K06sHoX/yZeek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GacHvmkLAyKN7EMYL2NprvWBJwvqx/+XeX2Tggo5o/jOGaU908Oae+HoRozWlF1EF
	 B/XLir21H/n6zaF38WisUDnWCz/mtXxG0Nu+uy2SoWAjFVLkRqcQgKoAGyWOx6i/Jz
	 CwXVfAHnteygSGNrgLvU/9WngAhhrvs6u+06GFpi2JP47YwqitucHqPh0QNsvElKmn
	 XDM+p/XaYZm0uprla5xRtQLYncBZmJrA9Q+4r4OCltQYlLb5J8WUt12zBeyoA8z2WZ
	 mptkmSNik1GFOgTvzWIIGAFMI9qYS0yNCSEvesou5Yp4LEjLIq/k939NjuQRx9JL4/
	 U44MQFXklgT2g==
Date: Tue, 28 Nov 2023 21:51:23 +0530
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
Message-ID: <20231128162123.GA3088@thinkpad>
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

Cc: stable@vger.kernel.org # 5.7

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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

