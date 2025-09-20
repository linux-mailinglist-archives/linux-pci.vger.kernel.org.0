Return-Path: <linux-pci+bounces-36594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6AAB8CBB2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 17:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46EBC1BC26C1
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 15:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD578F4F;
	Sat, 20 Sep 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+SMrl4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DBB2AEF5;
	Sat, 20 Sep 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758382449; cv=none; b=DGpWAMlmT1qia/RigA+XPfvjTufzK3+qa1tH5tDvPHRqMUvEN82bTiUhRyk7rIC/iOUmkRMZ9i7ZL+e334S5AG1VgxAs8TrX1VsiMM1KWr+9sKkks+DqU3oCzDgFuqqXkYadeEzOYulB65oZTTUcY9pXk/Y5FOF5f/743LjGbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758382449; c=relaxed/simple;
	bh=kiHRUdofMJg2g8r9iYJBMX0J6c/E6p9ndFyoK1QRdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIkkh1Aiyz+E2n1e0Nm2yVoj65XdAdrS2VYdNeZ4f8dHn9ESVe2kIiJq+KO1Mo7FuRw3jISmbiXiICs0PSzl4phldNMAhT4tXq3Cz2Q8jhq2Pw+6zlndZSgqQqNeDxkdQEcGmxpk7mT/5WE9VIhcUuZEy++wdsFgOZSGAz3ZH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+SMrl4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71701C4CEF7;
	Sat, 20 Sep 2025 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758382449;
	bh=kiHRUdofMJg2g8r9iYJBMX0J6c/E6p9ndFyoK1QRdvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+SMrl4/kD7KuOKRCjcIw+FC9Na2TB/smQeYC+xw49eVgpjIyfo7ID0FK4AZto4iR
	 5L5y9YkvFbqmtX9oHFEASVlmIOqtw2krCyXIV+GRoVRI4uakgQn2k4lwqfO33nbtUi
	 OhnvfqxGvIu1L55MkK3BNoHHxjYGgCPrA/IqdTzpbrq2mZ0eTZBkig9BOu+iYKl5Os
	 m4KUD1n8C+5GkXRFgBQsnLCkwXHr9un8b4sIq5GWbe9jzoCOu0ugMRt4srw8wcKGaG
	 eEIY0PWhsRLq6G1gi2yQDiJi28xBJlKYNS/T5Z20jHFDV+8FgrqsxzgtGBuqMFqkA5
	 NXl4qxrIa7ZrA==
Date: Sat, 20 Sep 2025 21:04:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Vidya Sagar <vidyas@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra194: Reset BARs when running in PCIe endpoint
 mode
Message-ID: <lrox3l5cafqsom3eier6n7wpbfatlic42rxs5q5utrhg4fekls@kj3b5ue7ggt7>
References: <20250919131646.167330-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250919131646.167330-2-cassel@kernel.org>

On Fri, Sep 19, 2025 at 03:16:47PM +0200, Niklas Cassel wrote:
> Tegra already defines all BARs expect for BAR0 as BAR_RESERVED.
> This is sufficient for pci-epf-test to not allocate backing memory and to
> not call set_bar() for those BARs.
> 
> However, the host side driver, pci_endpoint_test, simply does an ioremap
> for all enabled BARs, and will run tests against all enabled BARs.
> 
> After running the BARs tests (which will write to all enabled BARs), the
> inbound address translation is broken.
> This is because the tegra controller exposes the ATU Port Logic Structure
> in BAR4. So when BAR4 is written, the inbound address translation settings
> get overwritten.
> 

BAR4 or BAR0?

- Mani

> To avoid this, implement the dw_pcie_ep_ops .init() callback and start off
> by disabling all BARs (pci-epf-test will later enable/configure BARs that
> are not defined as BAR_RESERVED).
> 
> This matches the behavior of other PCIe endpoint drivers:
> dra7xx, imx6, layerscape-ep, artpec6, dw-rockchip, qcom-ep, rcar-gen4, and
> uniphier-ep.
> 
> With this, the PCI endpoint kselftest test case CONSECUTIVE_BAR_TEST
> (which was specifically made to detect address translation issues) passes.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4f26086f25daf..9488805ecf608 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1941,6 +1941,15 @@ static irqreturn_t tegra_pcie_ep_pex_rst_irq(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static void tegra_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +};
> +
>  static int tegra_pcie_ep_raise_intx_irq(struct tegra_pcie_dw *pcie, u16 irq)
>  {
>  	/* Tegra194 supports only INTA */
> @@ -2017,6 +2026,7 @@ tegra_pcie_ep_get_features(struct dw_pcie_ep *ep)
>  }
>  
>  static const struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.init = tegra_pcie_ep_init,
>  	.raise_irq = tegra_pcie_ep_raise_irq,
>  	.get_features = tegra_pcie_ep_get_features,
>  };
> -- 
> 2.51.0
> 

-- 
மணிவண்ணன் சதாசிவம்

