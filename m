Return-Path: <linux-pci+bounces-13582-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F8987AA9
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 23:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF55E2814E4
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 21:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C85186E30;
	Thu, 26 Sep 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URiFvL+m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E54185944;
	Thu, 26 Sep 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727385704; cv=none; b=e/lmIgieDEJkyJG6AnW4yH6iv/Legp+EQTaeg+zYMFWYV1uwAAFxQ5+VlZ9RNmrTAdho9wkx5Mt/z9HtZyDHaIB18R8gSpF0slNSOIr/ZWVxA1grWYec/hvokDjYqOz1rVjDAsthh2wWI6fOVtkFPMwyEOoi/MPcmZe3MBMGyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727385704; c=relaxed/simple;
	bh=P93BfDBfk31T9g2CV/GdxWquPAM95ZIllGwYxAk/328=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tGE3YMtn9J8sMcQwKAD34THvrbNjVbDVSR8sECO0b3JVzQD+qFrWdcuqWqnbjCCddIkWOpJwY25hpgsR4QRvGLswkKu4vd/c5a3L5Ou385+iGfOL/ZcRJNgFgk622LvslIt5KKdiUE6uc3TdHAzeUqJvvu7swx5zPyppDA1b4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URiFvL+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DA4C4CEC7;
	Thu, 26 Sep 2024 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727385704;
	bh=P93BfDBfk31T9g2CV/GdxWquPAM95ZIllGwYxAk/328=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=URiFvL+mxevkavTQmOsc6gkslg44emIRGH53p/3i+0QNPxBQoargYV9ixz+6aMwV+
	 ITfDX3CbFMoGhRoi2Ckav9DWHly5MCSFfj30eSPKHHYttKqhZQS45Q41mZmoZqRwTM
	 q5IaQSB8a2XAwlSqOpDeOdcNDS3ku9v7IgD8mo0D3UNRR1isMWcudZQy74twWnAgMP
	 VsB5ZZL88xF05kjSRnf80yhmXY5nUCjx98kQ2koQ9yiO66AOsktJcSbqLGLsXFFLzi
	 AxiQQuuD9/U3TXHL/DlqUDuXOc5CLG+qdXfidzA5IjLvoPq44FNGvjnWFL8+AfdPMI
	 QaBVYBDqa2EXg==
Date: Thu, 26 Sep 2024 16:21:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc: linux-pci@vger.kernel.org, vigneshr@ti.com, s-vadapalli@ti.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk@kernel.org,
	alim.akhtar@samsung.com, shawn.guo@linaro.org,
	songxiaowei@hisilicon.com, marek.vasut+renesas@gmail.com,
	yoshihiro.shimoda.uh@renesas.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, thomas.petazzoni@bootlin.com, pali@kernel.org,
	florian.fainelli@broadcom.com,
	angelogioacchino.delregno@collabora.com, ryder.lee@mediatek.com,
	heiko@sntech.de, kevin.xie@starfivetech.com, kishon@kernel.org,
	dlemoal@kernel.org, shawn.lin@rock-chips.com,
	linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: controller: Switch back to struct
 platform_driver::remove()
Message-ID: <20240926212141.GA55466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923065706.728769-1-sergio.paracuellos@gmail.com>

On Mon, Sep 23, 2024 at 08:57:06AM +0200, Sergio Paracuellos wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all PCI controller drivers to use .remove(), with the eventual goal
> to drop struct platform_driver::remove_new(). As .remove() and .remove_new()
> have the same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Applied to pci/controller/remove for v6.13, thanks!

This branch will be rebased to -rc1 when it is tagged.

> ---
>  drivers/pci/controller/cadence/pci-j721e.c   | 2 +-
>  drivers/pci/controller/dwc/pci-exynos.c      | 2 +-
>  drivers/pci/controller/dwc/pci-keystone.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-bt1.c        | 2 +-
>  drivers/pci/controller/dwc/pcie-histb.c      | 2 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c   | 2 +-
>  drivers/pci/controller/dwc/pcie-kirin.c      | 2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c    | 2 +-
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c  | 2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c   | 2 +-
>  drivers/pci/controller/pci-aardvark.c        | 2 +-
>  drivers/pci/controller/pci-host-generic.c    | 2 +-
>  drivers/pci/controller/pci-mvebu.c           | 2 +-
>  drivers/pci/controller/pci-tegra.c           | 2 +-
>  drivers/pci/controller/pci-xgene-msi.c       | 2 +-
>  drivers/pci/controller/pcie-altera-msi.c     | 2 +-
>  drivers/pci/controller/pcie-altera.c         | 2 +-
>  drivers/pci/controller/pcie-brcmstb.c        | 2 +-
>  drivers/pci/controller/pcie-hisi-error.c     | 2 +-
>  drivers/pci/controller/pcie-iproc-platform.c | 2 +-
>  drivers/pci/controller/pcie-mediatek-gen3.c  | 2 +-
>  drivers/pci/controller/pcie-mediatek.c       | 2 +-
>  drivers/pci/controller/pcie-mt7621.c         | 2 +-
>  drivers/pci/controller/pcie-rockchip-host.c  | 2 +-
>  drivers/pci/controller/plda/pcie-starfive.c  | 2 +-
>  25 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 85718246016b..b9c534e9eb0a 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -591,7 +591,7 @@ static void j721e_pcie_remove(struct platform_device *pdev)
>  
>  static struct platform_driver j721e_pcie_driver = {
>  	.probe  = j721e_pcie_probe,
> -	.remove_new = j721e_pcie_remove,
> +	.remove = j721e_pcie_remove,
>  	.driver = {
>  		.name	= "j721e-pcie",
>  		.of_match_table = of_j721e_pcie_match,
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index fa45da28a218..6a830166d37f 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -383,7 +383,7 @@ static const struct of_device_id exynos_pcie_of_match[] = {
>  
>  static struct platform_driver exynos_pcie_driver = {
>  	.probe		= exynos_pcie_probe,
> -	.remove_new	= exynos_pcie_remove,
> +	.remove		= exynos_pcie_remove,
>  	.driver = {
>  		.name	= "exynos-pcie",
>  		.of_match_table = exynos_pcie_of_match,
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 52c6420ae200..9e87d6e29afe 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1370,7 +1370,7 @@ static void ks_pcie_remove(struct platform_device *pdev)
>  
>  static struct platform_driver ks_pcie_driver = {
>  	.probe  = ks_pcie_probe,
> -	.remove_new = ks_pcie_remove,
> +	.remove = ks_pcie_remove,
>  	.driver = {
>  		.name	= "keystone-pcie",
>  		.of_match_table = ks_pcie_of_match,
> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> index 76d0ddea8007..1340edc18d12 100644
> --- a/drivers/pci/controller/dwc/pcie-bt1.c
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -632,7 +632,7 @@ MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
>  
>  static struct platform_driver bt1_pcie_driver = {
>  	.probe = bt1_pcie_probe,
> -	.remove_new = bt1_pcie_remove,
> +	.remove = bt1_pcie_remove,
>  	.driver = {
>  		.name	= "bt1-pcie",
>  		.of_match_table = bt1_pcie_of_match,
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 7a11c618b9d9..615a0e3e6d7e 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -439,7 +439,7 @@ MODULE_DEVICE_TABLE(of, histb_pcie_of_match);
>  
>  static struct platform_driver histb_pcie_platform_driver = {
>  	.probe	= histb_pcie_probe,
> -	.remove_new = histb_pcie_remove,
> +	.remove = histb_pcie_remove,
>  	.driver = {
>  		.name = "histb-pcie",
>  		.of_match_table = histb_pcie_of_match,
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index acbe4f6d3291..177d23aa6180 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -443,7 +443,7 @@ static const struct of_device_id of_intel_pcie_match[] = {
>  
>  static struct platform_driver intel_pcie_driver = {
>  	.probe = intel_pcie_probe,
> -	.remove_new = intel_pcie_remove,
> +	.remove = intel_pcie_remove,
>  	.driver = {
>  		.name = "intel-gw-pcie",
>  		.of_match_table = of_intel_pcie_match,
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 0a29136491b8..8a86c636a645 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -769,7 +769,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
>  
>  static struct platform_driver kirin_pcie_driver = {
>  	.probe			= kirin_pcie_probe,
> -	.remove_new		= kirin_pcie_remove,
> +	.remove			= kirin_pcie_remove,
>  	.driver			= {
>  		.name			= "kirin-pcie",
>  		.of_match_table		= kirin_pcie_match,
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index a9b263f749b6..74742cdefa7e 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -926,7 +926,7 @@ MODULE_DEVICE_TABLE(of, qcom_pcie_ep_match);
>  
>  static struct platform_driver qcom_pcie_ep_driver = {
>  	.probe	= qcom_pcie_ep_probe,
> -	.remove_new = qcom_pcie_ep_remove,
> +	.remove = qcom_pcie_ep_remove,
>  	.driver	= {
>  		.name = "qcom-pcie-ep",
>  		.of_match_table	= qcom_pcie_ep_match,
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index f0f3ebd1a033..c9b2765ab9ab 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -770,7 +770,7 @@ static struct platform_driver rcar_gen4_pcie_driver = {
>  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe = rcar_gen4_pcie_probe,
> -	.remove_new = rcar_gen4_pcie_remove,
> +	.remove = rcar_gen4_pcie_remove,
>  };
>  module_platform_driver(rcar_gen4_pcie_driver);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4bf7b433417a..77675bee4aa8 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -2498,7 +2498,7 @@ static const struct dev_pm_ops tegra_pcie_dw_pm_ops = {
>  
>  static struct platform_driver tegra_pcie_dw_driver = {
>  	.probe = tegra_pcie_dw_probe,
> -	.remove_new = tegra_pcie_dw_remove,
> +	.remove = tegra_pcie_dw_remove,
>  	.shutdown = tegra_pcie_dw_shutdown,
>  	.driver = {
>  		.name	= "tegra194-pcie",
> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 8b3e1a079cf3..815cdfcf79f9 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -2002,7 +2002,7 @@ static struct platform_driver advk_pcie_driver = {
>  		.of_match_table = advk_pcie_of_match_table,
>  	},
>  	.probe = advk_pcie_probe,
> -	.remove_new = advk_pcie_remove,
> +	.remove = advk_pcie_remove,
>  };
>  module_platform_driver(advk_pcie_driver);
>  
> diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
> index 5f06f94db7b1..4051b9b61dac 100644
> --- a/drivers/pci/controller/pci-host-generic.c
> +++ b/drivers/pci/controller/pci-host-generic.c
> @@ -82,7 +82,7 @@ static struct platform_driver gen_pci_driver = {
>  		.of_match_table = gen_pci_of_match,
>  	},
>  	.probe = pci_host_common_probe,
> -	.remove_new = pci_host_common_remove,
> +	.remove = pci_host_common_remove,
>  };
>  module_platform_driver(gen_pci_driver);
>  
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 29fe09c99e7d..46d3afe1d308 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -1727,7 +1727,7 @@ static struct platform_driver mvebu_pcie_driver = {
>  		.pm = &mvebu_pcie_pm_ops,
>  	},
>  	.probe = mvebu_pcie_probe,
> -	.remove_new = mvebu_pcie_remove,
> +	.remove = mvebu_pcie_remove,
>  };
>  module_platform_driver(mvebu_pcie_driver);
>  
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 038d974a318e..42a5ce412cc0 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2806,6 +2806,6 @@ static struct platform_driver tegra_pcie_driver = {
>  		.pm = &tegra_pcie_pm_ops,
>  	},
>  	.probe = tegra_pcie_probe,
> -	.remove_new = tegra_pcie_remove,
> +	.remove = tegra_pcie_remove,
>  };
>  module_platform_driver(tegra_pcie_driver);
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 3ce38dfd0d29..88c0977bc41a 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -518,7 +518,7 @@ static struct platform_driver xgene_msi_driver = {
>  		.of_match_table = xgene_msi_match_table,
>  	},
>  	.probe = xgene_msi_probe,
> -	.remove_new = xgene_msi_remove,
> +	.remove = xgene_msi_remove,
>  };
>  
>  static int __init xgene_pcie_msi_init(void)
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index 16336a525c16..318736171d63 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -274,7 +274,7 @@ static struct platform_driver altera_msi_driver = {
>  		.of_match_table = altera_msi_of_match,
>  	},
>  	.probe = altera_msi_probe,
> -	.remove_new = altera_msi_remove,
> +	.remove = altera_msi_remove,
>  };
>  
>  static int __init altera_msi_init(void)
> diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
> index ef73baefaeb9..b921bbb4de80 100644
> --- a/drivers/pci/controller/pcie-altera.c
> +++ b/drivers/pci/controller/pcie-altera.c
> @@ -817,7 +817,7 @@ static void altera_pcie_remove(struct platform_device *pdev)
>  
>  static struct platform_driver altera_pcie_driver = {
>  	.probe		= altera_pcie_probe,
> -	.remove_new	= altera_pcie_remove,
> +	.remove	= altera_pcie_remove,
>  	.driver = {
>  		.name	= "altera-pcie",
>  		.of_match_table = altera_pcie_of_match,
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..470c48b4aaa6 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1690,7 +1690,7 @@ static const struct dev_pm_ops brcm_pcie_pm_ops = {
>  
>  static struct platform_driver brcm_pcie_driver = {
>  	.probe = brcm_pcie_probe,
> -	.remove_new = brcm_pcie_remove,
> +	.remove = brcm_pcie_remove,
>  	.driver = {
>  		.name = "brcm-pcie",
>  		.of_match_table = brcm_pcie_match,
> diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
> index ad9d5ffcd9e3..cb5fcfe032d1 100644
> --- a/drivers/pci/controller/pcie-hisi-error.c
> +++ b/drivers/pci/controller/pcie-hisi-error.c
> @@ -317,7 +317,7 @@ static struct platform_driver hisi_pcie_error_handler_driver = {
>  		.acpi_match_table = hisi_pcie_acpi_match,
>  	},
>  	.probe		= hisi_pcie_error_handler_probe,
> -	.remove_new	= hisi_pcie_error_handler_remove,
> +	.remove	= hisi_pcie_error_handler_remove,
>  };
>  module_platform_driver(hisi_pcie_error_handler_driver);
>  
> diff --git a/drivers/pci/controller/pcie-iproc-platform.c b/drivers/pci/controller/pcie-iproc-platform.c
> index 4e6aa882a567..0cb78c583c7e 100644
> --- a/drivers/pci/controller/pcie-iproc-platform.c
> +++ b/drivers/pci/controller/pcie-iproc-platform.c
> @@ -134,7 +134,7 @@ static struct platform_driver iproc_pltfm_pcie_driver = {
>  		.of_match_table = of_match_ptr(iproc_pcie_of_match_table),
>  	},
>  	.probe = iproc_pltfm_pcie_probe,
> -	.remove_new = iproc_pltfm_pcie_remove,
> +	.remove = iproc_pltfm_pcie_remove,
>  	.shutdown = iproc_pltfm_pcie_shutdown,
>  };
>  module_platform_driver(iproc_pltfm_pcie_driver);
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index b7e8e24f6a40..ebef1be0d168 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -1082,7 +1082,7 @@ MODULE_DEVICE_TABLE(of, mtk_pcie_of_match);
>  
>  static struct platform_driver mtk_pcie_driver = {
>  	.probe = mtk_pcie_probe,
> -	.remove_new = mtk_pcie_remove,
> +	.remove = mtk_pcie_remove,
>  	.driver = {
>  		.name = "mtk-pcie-gen3",
>  		.of_match_table = mtk_pcie_of_match,
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 7fc0d7709b7f..f571de8de283 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1243,7 +1243,7 @@ MODULE_DEVICE_TABLE(of, mtk_pcie_ids);
>  
>  static struct platform_driver mtk_pcie_driver = {
>  	.probe = mtk_pcie_probe,
> -	.remove_new = mtk_pcie_remove,
> +	.remove = mtk_pcie_remove,
>  	.driver = {
>  		.name = "mtk-pcie",
>  		.of_match_table = mtk_pcie_ids,
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 9b4754a45515..776caa0b1011 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -541,7 +541,7 @@ MODULE_DEVICE_TABLE(of, mt7621_pcie_ids);
>  
>  static struct platform_driver mt7621_pcie_driver = {
>  	.probe = mt7621_pcie_probe,
> -	.remove_new = mt7621_pcie_remove,
> +	.remove = mt7621_pcie_remove,
>  	.driver = {
>  		.name = "mt7621-pci",
>  		.of_match_table = mt7621_pcie_ids,
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index cbec71114825..06cdb68f0920 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -1050,7 +1050,7 @@ static struct platform_driver rockchip_pcie_driver = {
>  		.pm = &rockchip_pcie_pm_ops,
>  	},
>  	.probe = rockchip_pcie_probe,
> -	.remove_new = rockchip_pcie_remove,
> +	.remove = rockchip_pcie_remove,
>  };
>  module_platform_driver(rockchip_pcie_driver);
>  
> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> index c9933ecf6833..0567ec373a3e 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -480,7 +480,7 @@ static struct platform_driver starfive_pcie_driver = {
>  		.pm = pm_sleep_ptr(&starfive_pcie_pm_ops),
>  	},
>  	.probe = starfive_pcie_probe,
> -	.remove_new = starfive_pcie_remove,
> +	.remove = starfive_pcie_remove,
>  };
>  module_platform_driver(starfive_pcie_driver);
>  
> -- 
> 2.25.1
> 

