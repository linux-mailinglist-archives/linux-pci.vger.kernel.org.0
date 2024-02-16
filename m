Return-Path: <linux-pci+bounces-3585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFB3857B6A
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68031C22C7C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7855D47F;
	Fri, 16 Feb 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2M+M8ZU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCF75C90F;
	Fri, 16 Feb 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082360; cv=none; b=aLFvnHvQIQ+jemM71UaLu8OvPTK26Fe1RijFuONZlRRAIoLmQOdcFA1aFux6TcoRBIqAWj/PxgRCAYj6sRgUFlTH4orjkaOh6FI783JUpcIx2xOPA7lF8WZ1xA2/BFjg7mtYXRJR5TQcT8PHFnS38odsXPViv/onRYhRwhyKVR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082360; c=relaxed/simple;
	bh=KbiyK3bvGuFNTKYJJHAnEbGXH9z7NGmmzn+I+PaPUz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDF5wa7eSz+zwvrfnO6ehDBV9MX4fawW1mcWuLUV30t8O9VAt4IlLh5cSwh6/D1xBE7noKxzL3OT2w+6WOMqPgVoK9DhcYajVnsZbyeSUaVb/BnJPPlKwABRoZau5HPBQSSvzRU6t0urW/5o8K4qcHgk/0iOUDgEqAgdC5++7lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2M+M8ZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB9C433C7;
	Fri, 16 Feb 2024 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082360;
	bh=KbiyK3bvGuFNTKYJJHAnEbGXH9z7NGmmzn+I+PaPUz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G2M+M8ZUQhDqvRup5p9TlZYwfHP6CXltKW0DLJJzXwugtd4/H1nl86/IGFPjVQBr7
	 GCRemr582U0WH8hsjXa8e1U3s9b0Vl5yvGiqgI+fNcKVHuFDGHm7bPL4RGnQl3hFV0
	 cFWFdueXaG7/OjmB2SXtaC58pFYqaz053ojcdCGeZyjeXXjQcwbX7bhmTOGSqfCKAb
	 7mWtrvsPRDLrl5xI4ab5+bkNpl53Csknw7fcEchqTgt680PFUJO/jQRKvrP+jZvQrk
	 6AdJ1aVr+xyff4pRh2vw8Qc4coAE6C3qwV+TksfzuED4Cku5IveQ6lBc2Q+DFJkrMR
	 9pfzSd3QakT3A==
Date: Fri, 16 Feb 2024 16:49:08 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: endpoint: Clean up hardware description for BARs
Message-ID: <20240216111908.GC2559@thinkpad>
References: <20240210012634.600301-1-cassel@kernel.org>
 <20240210012634.600301-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240210012634.600301-2-cassel@kernel.org>

On Sat, Feb 10, 2024 at 02:26:25AM +0100, Niklas Cassel wrote:
> The hardware description for BARs is scattered in many different variables
> in pci_epc_features. Some of these things are mutually exclusive, so it
> can create confusion over which variable that has precedence over another.
> 
> Improve the situation by creating a struct pci_epc_bar_desc, and a new
> enum pci_epc_bar_type, and convert the endpoint controller drivers to use
> this more well defined format.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c         |  3 +-
>  drivers/pci/controller/dwc/pci-keystone.c     | 12 +++----
>  .../pci/controller/dwc/pci-layerscape-ep.c    |  5 ++-
>  drivers/pci/controller/dwc/pcie-keembay.c     |  8 +++--
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  4 ++-
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 10 ++++--
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 15 ++++++--
>  drivers/pci/controller/pcie-rcar-ep.c         | 14 +++++---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
>  drivers/pci/endpoint/pci-epc-core.c           | 32 +++++++++--------
>  drivers/pci/endpoint/pci-epf-core.c           | 15 ++++----
>  include/linux/pci-epc.h                       | 34 +++++++++++++++----
>  14 files changed, 108 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index dc2c036ab28c..47a9a96484ed 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1081,7 +1081,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = false,
> -	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  	.align = SZ_64K,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index c0c62533a3f1..b2b93b4fa82d 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -924,12 +924,12 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = true,
> -	.reserved_bar = 1 << BAR_0 | 1 << BAR_1,
> -	.bar_fixed_64bit = 1 << BAR_0,
> -	.bar_fixed_size[2] = SZ_1M,
> -	.bar_fixed_size[3] = SZ_64K,
> -	.bar_fixed_size[4] = 256,
> -	.bar_fixed_size[5] = SZ_1M,
> +	.bar[BAR_0] = { .type = BAR_RESERVED, .only_64bit = true, },
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> +	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
> +	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
>  	.align = SZ_1M,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index 2e398494e7c0..1f6ee1460ec2 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -250,7 +250,10 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
> -	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> +	ls_epc->bar[BAR_2].only_64bit = true;
> +	ls_epc->bar[BAR_3].type = BAR_RESERVED;

BAR_3 and BAR_4 were not reserved previously.

> +	ls_epc->bar[BAR_4].only_64bit = true;
> +	ls_epc->bar[BAR_5].type = BAR_RESERVED;
>  	ls_epc->linkup_notifier = true;
>  
>  	pcie->pci = pci;
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 208d3b0ba196..5e8e54f597dd 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -312,8 +312,12 @@ static const struct pci_epc_features keembay_pcie_epc_features = {
>  	.linkup_notifier	= false,
>  	.msi_capable		= true,
>  	.msix_capable		= true,
> -	.reserved_bar		= BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> -	.bar_fixed_64bit	= BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> +	.bar[BAR_0]		= { .only_64bit = true, },
> +	.bar[BAR_1]		= { .type = BAR_RESERVED, },
> +	.bar[BAR_2]		= { .only_64bit = true, },
> +	.bar[BAR_3]		= { .type = BAR_RESERVED, },
> +	.bar[BAR_4]		= { .only_64bit = true, },
> +	.bar[BAR_5]		= { .type = BAR_RESERVED, },
>  	.align			= SZ_16K,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index e9166619b1f9..0be760ed420b 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -383,7 +383,9 @@ static const struct pci_epc_features rcar_gen4_pcie_epc_features = {
>  	.linkup_notifier = false,
>  	.msi_capable = true,
>  	.msix_capable = false,
> -	.reserved_bar = 1 << BAR_1 | 1 << BAR_3 | 1 << BAR_5,
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_1M,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 7afa9e9aabe2..1f7b662cb8e1 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2007,9 +2007,13 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.core_init_notifier = true,
>  	.msi_capable = false,
>  	.msix_capable = false,
> -	.reserved_bar = 1 << BAR_2 | 1 << BAR_3 | 1 << BAR_4 | 1 << BAR_5,
> -	.bar_fixed_64bit = 1 << BAR_0,
> -	.bar_fixed_size[0] = SZ_1M,
> +	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
> +			.only_64bit = true, },
> +	.bar[BAR_1] = { .type = BAR_RESERVED, },

Same, BAR_1 was not reserved.

> +	.bar[BAR_2] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = { .type = BAR_RESERVED, },
> +	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  };
>  
>  static const struct pci_epc_features*
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index 3fced0d3e851..265f65fc673f 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -411,8 +411,12 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
>  		.msi_capable = true,
>  		.msix_capable = false,
>  		.align = 1 << 16,
> -		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> -		.reserved_bar =  BIT(BAR_4),
> +		.bar[BAR_0] = { .only_64bit = true, },
> +		.bar[BAR_1] = { .type = BAR_RESERVED, },

Same as above.

> +		.bar[BAR_2] = { .only_64bit = true, },
> +		.bar[BAR_3] = { .type = BAR_RESERVED, },
> +		.bar[BAR_4] = { .type = BAR_RESERVED, .only_64bit = true, },
> +		.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	},
>  };
>  
> @@ -425,7 +429,12 @@ static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
>  		.msi_capable = true,
>  		.msix_capable = false,
>  		.align = 1 << 12,
> -		.bar_fixed_64bit = BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> +		.bar[BAR_0] = { .only_64bit = true, },
> +		.bar[BAR_1] = { .type = BAR_RESERVED, },

Same as above.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

