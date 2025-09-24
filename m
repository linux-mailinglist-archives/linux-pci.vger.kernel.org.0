Return-Path: <linux-pci+bounces-36861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC157B9AC6D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974133A8C31
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343D30F921;
	Wed, 24 Sep 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crGBPtS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A733F3002A9;
	Wed, 24 Sep 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729249; cv=none; b=vFDS3EIGBT/CQf+7IaKnA/RxgKuvsy15UDOg3JyeWZRiDXnYDvQGMHiXxtZCTGkB7ctW4YyOrkCgHuJ8hcxuDahoo1Sq8xeVyXonVjQ2RQtMc+vmkFU+CDjnP2YPrBzUB9Il2YGuM1gvUAnA9PWMvgESd+asa/hzhxAN92A1/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729249; c=relaxed/simple;
	bh=zHE8NBsFyiqCKh77s+I148Vr535yui9qMssrXrnl09M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXUAXwS3MzmmOx+lBOj1IkOH9hWYqLjSWwdEUJQbPvhtZvE8Gavr597WR6RU2hZFLfZVhMki1wLs/jQ31dgQ9VUAvnS2agmydHEhAfDRRqFPfqhKFnvfqbTk+spx67AgBQbGgI+n+3xN7bAoEwtLwDd37gXEv80sVxI68gXlxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crGBPtS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A67DC4CEE7;
	Wed, 24 Sep 2025 15:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758729249;
	bh=zHE8NBsFyiqCKh77s+I148Vr535yui9qMssrXrnl09M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=crGBPtS4p2lLuEgep68p0v9FbFAXIKWOP43JLGQ7oKZEyNPAh23chMaQfIywBkQMb
	 XL0gD9C+2aWXytQWsIslBKqK0EBxHeoDKEz1UORNUHzCPa5AvPuYLKOnRbx/FxRATA
	 289kxyewMbmajZ/JhM8VM8X2YZ7fRoy6VdOK36/EiCWOuM+EpElNEsFL3pk0thnq0l
	 ZzWEP8YHWOAcXoF4TZlMAcBCLI6TG6qSQC4j5WzwCcb/BSPmlbPVEt6QICKKZP4vya
	 7KVMMrrVRPTRZ3Isbe8BjVcNtfaqK3dlvcOFK9bpISFDoWMZst9FZWJF+geRonBVJ8
	 6RehcUc8SynKw==
Date: Wed, 24 Sep 2025 21:24:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: tegra194: Fix broken
 tegra_pcie_ep_raise_msi_irq()
Message-ID: <va2vktobo5dwfh6mkl6emilsnkeleh6ubkbiylv4zoxr2cezpa@s7h3yuytcpv4>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250922140822.519796-6-cassel@kernel.org>

On Mon, Sep 22, 2025 at 04:08:24PM +0200, Niklas Cassel wrote:
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
> Cc: stable@vger.kernel.org
> Fixes: c57247f940e8 ("PCI: tegra: Add support for PCIe endpoint mode in Tegra194")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 7c295ec6f0f16..63d310e5335f4 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1969,10 +1969,10 @@ static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
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
> @@ -2012,6 +2012,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.linkup_notifier = true,
> +	.msi_capable = true,

This change is unrelated to the above tegra_pcie_ep_raise_msi_irq() fix. So this
change should be in a separate patch.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

