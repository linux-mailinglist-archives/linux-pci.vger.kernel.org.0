Return-Path: <linux-pci+bounces-43556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5352CD8489
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B9953016343
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 06:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F7AF1E22E9;
	Tue, 23 Dec 2025 06:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q08axT54"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260341C62;
	Tue, 23 Dec 2025 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472357; cv=none; b=CiE0vLQw1X8EichXZIoYwsWUQqFNLT7ULGI/rDKT4yl6txvAphmqnahFHnWYSIyHbodsfW4nmzEQlloUMpBCpvc8qLzQbVTGI6ciDdrbMddbQId2BYWY5LHVuK5oHraJ3Z+L2uAVV7qAjchgi8mdxHsaYtu+4Q1rZ0ywQWtCEfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472357; c=relaxed/simple;
	bh=MiNr133oXx3dQO0+21q58C/IxFmhbI0hGeUc9eUgfoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUpYyzapyF+pehTrN8R3DwtEo4ICsh9zougikaeGebvXKkwcUm5KCL8C1eNHQL5JKXsOVyNgaGoJL7O7JurqLItwuZYrdcoduErQu9T24iTpciJuALx+pFHh76/uhw6Q0aFq+RVqDJmF7BGw2ThQ7PdoRNTER4nsbF073blKvHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q08axT54; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7C8C113D0;
	Tue, 23 Dec 2025 06:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766472356;
	bh=MiNr133oXx3dQO0+21q58C/IxFmhbI0hGeUc9eUgfoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q08axT540irYtcj5pPhT5p11xDzpoftq8aBIjKB2WcTTQjLF0ELjJM7LEYDh2e6TP
	 HU6IqeAftynWuBx3+wNG+sCBJcCqP3I9kzUbZkYfqCQrtVDfPcgZDW+AvBN3sCnGMh
	 PB0d0cSkbvycxoe0jQPQm+l4x2T6QJrldpSFsIwFzU1Viyj+U6hbbaZzCl1TeFu3O8
	 25RohQdAcu759IXjj5/YQ2CDx1oWoAh/m+kfZjH0Ighs7lpGegY0zkPcLirNcJu7BN
	 EKNtd+S2+VxXs+GZzSMgmu3OV2e1NMr6KzJoUBq1ARHI0D2w883yZp5q3BsdDI89vp
	 iDo6NPUjStpqQ==
Date: Tue, 23 Dec 2025 12:15:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>, thierry.reding@gmail.com, 
	jonathanh@nvidia.com
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Mayank Rana <mayank.rana@oss.qualcomm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Shradha Todi <shradha.t@samsung.com>, 
	Thippeswamy Havalige <thippeswamy.havalige@amd.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pci: controller: tegra194: remove dependency on Tegra194
 SoC
Message-ID: <xh2att7wpqowricyifxmoaijbhtrtoht25pomu4voosfctf36e@4p27y7rezz22>
References: <20251126102530.4110067-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251126102530.4110067-1-flavra@baylibre.com>

On Wed, Nov 26, 2025 at 11:25:30AM +0100, Francesco Lavra wrote:

+ Tegra maintainers

> This driver runs (for both host and endpoint operation) also on other Tegra
> SoCs (e.g. Tegra234).
> Replace the Kconfig dependency on ARCH_TEGRA_194_SOC with a more generic
> dependency on ARCH_TEGRA; in addition, amend the Kconfig help text to
> reflect the fact that this driver is no longer exclusive to Tegra194.
> 

I vaguely remember asking about this a while back during some other patch review
and I don't remember what we concluded.

Thierry, Jon, thoughts?

- Mani

> Fixes: a54e19073718 ("PCI: tegra194: Add Tegra234 PCIe support")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ec..1123752e43ef 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -227,33 +227,33 @@ config PCIE_TEGRA194
>  
>  config PCIE_TEGRA194_HOST
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PHY_TEGRA194_P2U
>  	select PCIE_TEGRA194
>  	help
> -	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -	  work in host mode. There are two instances of PCIe controllers in
> -	  Tegra194. This controller can work either as EP or RC. In order to
> -	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> -	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> -	  selected. This uses the DesignWare core.
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 and
> +	  later SoCs to work in host mode. This controller can work either as
> +	  EP or RC. In order to enable host-specific features
> +	  PCIE_TEGRA194_HOST must be selected and in order to enable
> +	  device-specific features PCIE_TEGRA194_EP must be selected. This uses
> +	  the DesignWare core.
>  
>  config PCIE_TEGRA194_EP
>  	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
> -	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> +	depends on ARCH_TEGRA || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PHY_TEGRA194_P2U
>  	select PCIE_TEGRA194
>  	help
> -	  Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -	  work in endpoint mode. There are two instances of PCIe controllers in
> -	  Tegra194. This controller can work either as EP or RC. In order to
> -	  enable host-specific features PCIE_TEGRA194_HOST must be selected and
> -	  in order to enable device-specific features PCIE_TEGRA194_EP must be
> -	  selected. This uses the DesignWare core.
> +	  Enables support for the PCIe controller in the NVIDIA Tegra194 and
> +	  later SoCs to work in endpoint mode. This controller can work either
> +	  as EP or RC. In order to enable host-specific features
> +	  PCIE_TEGRA194_HOST must be selected and in order to enable
> +	  device-specific features PCIE_TEGRA194_EP must be selected. This uses
> +	  the DesignWare core.
>  
>  config PCIE_DW_PLAT
>  	bool
> -- 
> 2.39.5
> 

-- 
மணிவண்ணன் சதாசிவம்

