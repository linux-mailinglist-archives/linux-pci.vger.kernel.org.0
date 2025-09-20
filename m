Return-Path: <linux-pci+bounces-36595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F88B8CBC1
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 17:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94DD463168
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A4C22156A;
	Sat, 20 Sep 2025 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqpOIW3v"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADF46B5;
	Sat, 20 Sep 2025 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382716; cv=none; b=BQGH+cRosQUvFC4UVKdxM9wmbR2BpFoz6gOMWkzo72xkn5MwgnGoxzjh34Hr7r70d8+zaKtdqjA03fhgqNhf1LXt/BtmFXT64zPNS3CYW/kfQCho0HP8tBMqgtp/qjEr0teiA+kFBdfuCqQxDOII2+uE27wmzSqJau+n/W7aZnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382716; c=relaxed/simple;
	bh=n+UOPBvdftIRAtCqf1bXZMH3Pfgbq+0ieflZ/GGI664=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crhhm0RugQrOb58X9Unj4XLLrlCRwjD4iqycjBGmkeN4IZMBDTlOuKecil/SHah6x/zoqFEj+dzFP29x6NVbPZa8HteWfIsv40LHOwlIicJEZGHEcb6+Xq8OG4m3g1phySYu/tquyZ/Ai7w+I8T1x/zxhfXApsEYP//VbsEi19g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqpOIW3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74CC4CEEB;
	Sat, 20 Sep 2025 15:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758382715;
	bh=n+UOPBvdftIRAtCqf1bXZMH3Pfgbq+0ieflZ/GGI664=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nqpOIW3vrwBn0NAloYwtD8wd5r8y8w+VvYIyolaDsVQsHSAcLqD8WhPFslRKaa7RO
	 4r48Go1v1KQNFV9aKJE/Bh48pj4RKOFBrJsohev60gfBsIqdoDo/EDNbTYWYC2BpsP
	 /Fdmv33SLDWhTP51vRIpg3INEw02TE6xJlfAWwLivrb7q1nzq9t0mwXePzf4y6jpcL
	 FSblhMmoxx42ljhj4AMuI1ztAZw5DALEfGh9otFeM2GQ4lvIMcP7d2lzA4UzyLVGK1
	 A66TaaUnM12ZT+3vZGY9c631TV1EdZHbvw5tjJJxohscyRSH7YDi/V7WLee/9X7HY2
	 yxv5HiS3UPDqw==
Date: Sat, 20 Sep 2025 21:08:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Fix broken tegra_pcie_ep_raise_msi_irq()
Message-ID: <y2ec4hglgaefewmtl2tdfpbx6w5htvrsycthafagmlclpilnit@deejprqbtdyd>
References: <20250919152329.239160-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919152329.239160-2-cassel@kernel.org>

On Fri, Sep 19, 2025 at 05:23:30PM +0200, Niklas Cassel wrote:
> The pci_epc_raise_irq() supplies a MSI or MSI-X interrupt number in range
> (1-N), see kdoc for pci_epc_raise_irq().
> 
> Thus, for MSI pci_epc_raise_irq() will supply interrupt number 1-32.
> 
> Convert the interrupt number to an MSI vector.
> 
> With this, the PCI endpoint kselftest test case MSI_TEST passes.
> 
> Also, set msi_capable to true, as the driver obviously supports MSI.
> This helps pci_endpoint_test to use the optimal IRQ type when using
> PCITEST_IRQ_TYPE_AUTO.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

This is a bug fix. Hence, it deserves a Fixes tag and stable list should be
CCed for backporting.

- Mani

> ---
> Note to PCI maintainers: this patch is made on top of
> 27fce9e8c6f0 ("PCI: endpoint: Drop superfluous pci_epc_features initialization")
> which is currently queued on branch pci/endpoint.
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 0e413857649fd..fe418b9bfbb4b 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1955,10 +1955,10 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  
>  static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  {
> -	if (unlikely(irq > 31))
> +	if (unlikely(irq > 32))
>  		return -EINVAL;
>  
> -	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
> +	appl_writel(pcie, BIT(irq - 1), APPL_MSI_CTRL_1);
>  
>  	return 0;
>  }
> @@ -1998,6 +1998,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.linkup_notifier = true,
> +	.msi_capable = true,
>  	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
>  			.only_64bit = true, },
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

