Return-Path: <linux-pci+bounces-34329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7476B2CF2B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 00:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63F5586834
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C4126F2B0;
	Tue, 19 Aug 2025 22:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myRKS3Ep"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA10221ADCB;
	Tue, 19 Aug 2025 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641870; cv=none; b=U+PYd5o2TV1X0yiDP4By0jU5TKPJyKLE9tAdM6n1mRruCGNdQcX02HuO/hefa1bhF+GczfCxZXKz6uMKST4Ao6uveqUba/bjNPG7XOJT9sFR5A4f97A5s9yvprFPqrSZ+u0UmAGnQaVxktWSBoVAAGeuCSpe07ttRsXX7CfI4bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641870; c=relaxed/simple;
	bh=1JrAVDh/u7Or7cM+GzW7ht59rngYQArrkAFlU9OUDFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DnOF1XVN9iEoE9C+ajyANS1kgJToIGYLrV0hS0o7xMK3uhleNnNm62vSvU5biQdEAAkwesvFEOhgg++hVFoUlGMCIvbT6z4iijcJ0Nhgr9UbN2eQan06exViYkrYvyl5kE9UEsCQfI7/d1AifdtSLDnRxx8pdfN31kZBSWLvSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myRKS3Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C2AC4CEF1;
	Tue, 19 Aug 2025 22:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755641869;
	bh=1JrAVDh/u7Or7cM+GzW7ht59rngYQArrkAFlU9OUDFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=myRKS3Epcwhnu+JKihvMQhxUoukI8QoCauZA2CJRC1IrWULufH6OFgIC5bkObqvkF
	 ACPMVqwcAjtPj+XR3bBu5IuI78nbe/L5U5Y7QarEZtlb7om7EvGRZ7pG5ur04h2Fh9
	 qu+qIegnjT1hsqDxFO4552ooARGutvY/QYqr7L/prFP0svAMpHBSebFmqdV3uOXjCJ
	 rOw/ca+QTHpaZdAmSwIPdXvt1DWyMrcgq40rWSQ4FFxuSMU5UnanJWdNeXrN1x9Cnp
	 JVGOucm+WjK4QzXnyYVCRmmC2GhbZEKu6Lu6J7PgrdHJGDxmQ63FZgR8dHHKdKY0ua
	 DrzhLDyZLaZWw==
Date: Tue, 19 Aug 2025 17:17:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	vigneshr@ti.com, stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2] PCI: j721e: Fix programming sequence of "strap"
 settings
Message-ID: <20250819221748.GA598958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819101336.292013-1-s-vadapalli@ti.com>

On Tue, Aug 19, 2025 at 03:43:35PM +0530, Siddharth Vadapalli wrote:
> The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
> Root-Complex and Endpoint modes of operation. The Glue Layer allows
> "strapping" the mode of operation of the Controller, the Link Speed
> and the Link Width. This is enabled by programming the "PCIEn_CTRL"
> register (n corresponds to the PCIe instance) within the CTRL_MMR
> memory-mapped register space.
> 
> In the PCIe Controller's register space, the same set of registers
> that correspond to the Root-Port configuration space when the
> Controller is configured for Root-Complex mode of operation, also
> correspond to the Physical Function configuration space when the
> Controller is configured for Endpoint mode of operation. As a result,
> the "reset-value" of these set of registers _should_ vary depending
> on the selected mode of operation. This is the expected behavior
> according to the description of the registers and their reset values
> in the Technical Reference Manual for the SoCs.
> 
> However, it is observed that the "reset-value" seen in practice
> do not match the description. To be precise, when the Controller
> is configured for Root-Complex mode of operation, the "reset-value"
> of the Root-Port configuration space reflect the "reset-value"
> corresponding to the Physical Function configuration space.
> This can be attributed to the fact that the "strap" settings play
> a role in "switching" the "reset-value" of the registers to match
> the expected values as determined by the selected mode of operation.
> Since the "strap" settings are sampled the moment the PCIe Controller
> is powered ON, the "reset-value" of the registers are setup at that
> point in time. As a result, if the "strap" settings are programmed
> at a later point in time, it _will not_ update the "reset-value" of
> the registers. This will cause the Physical Function configuration
> space to be seen when the Root-Port configuration space is accessed
> after programming the PCIe Controller for Root-Complex mode of
> operation.
> 
> Fix this by powering off the PCIe Controller before programming the
> "strap" settings and powering it on after that. This will ensure
> that the "strap" settings that have been sampled convey the intended
> mode of operation, thereby resulting in the "reset-value" of the
> registers being accurate.

This is a lot of text to convey the idea that:

  - The PCIe controller powers on and latches reset values of several
    registers

  - Later, the driver programs Glue Layer "mode", which determines
    those reset values

  - Therefore, controller has latched the wrong values

What does this problem look like to a user? 

> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> 
> Hello,
> 
> This patch is based on commit
> be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> of Mainline Linux.
> 
> v1 of this patch is at:
> https://lore.kernel.org/r/20250716102851.121742-1-s-vadapalli@ti.com/
> Changes since v1:
> - Rebased patch on latest Mainline Linux.
> 
> Regards,
> Siddharth.
> 
>  drivers/pci/controller/cadence/pci-j721e.c | 82 ++++++++++++++--------
>  1 file changed, 53 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> index 6c93f39d0288..d5e7cb7277dc 100644
> --- a/drivers/pci/controller/cadence/pci-j721e.c
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
> @@ -173,10 +174,9 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
>  	.link_up = j721e_pcie_link_up,
>  };
>  
> -static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
> -			       unsigned int offset)
> +static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct device *dev,
> +			       struct regmap *syscon, unsigned int offset)
>  {
> -	struct device *dev = pcie->cdns_pcie->dev;
>  	u32 mask = J721E_MODE_RC;
>  	u32 mode = pcie->mode;
>  	u32 val = 0;
> @@ -193,9 +193,9 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
>  }
>  
>  static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
> +				     struct device *dev,
>  				     struct regmap *syscon, unsigned int offset)
>  {
> -	struct device *dev = pcie->cdns_pcie->dev;
>  	struct device_node *np = dev->of_node;
>  	int link_speed;
>  	u32 val = 0;
> @@ -214,9 +214,9 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
>  }
>  
>  static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
> +				     struct device *dev,
>  				     struct regmap *syscon, unsigned int offset)
>  {
> -	struct device *dev = pcie->cdns_pcie->dev;
>  	u32 lanes = pcie->num_lanes;
>  	u32 mask = BIT(8);
>  	u32 val = 0;
> @@ -234,9 +234,9 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
>  }
>  
>  static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
> +				       struct device *dev,
>  				       struct regmap *syscon)
>  {
> -	struct device *dev = pcie->cdns_pcie->dev;
>  	struct device_node *node = dev->of_node;
>  	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
>  	struct of_phandle_args args;
> @@ -263,9 +263,8 @@ static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
>  	return 0;
>  }
>  
> -static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> +static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie, struct device *dev)
>  {
> -	struct device *dev = pcie->cdns_pcie->dev;
>  	struct device_node *node = dev->of_node;
>  	struct of_phandle_args args;
>  	unsigned int offset = 0;
> @@ -284,19 +283,19 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  	if (!ret)
>  		offset = args.args[0];
>  
> -	ret = j721e_pcie_set_mode(pcie, syscon, offset);
> +	ret = j721e_pcie_set_mode(pcie, dev, syscon, offset);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set pci mode\n");
>  		return ret;
>  	}
>  
> -	ret = j721e_pcie_set_link_speed(pcie, syscon, offset);
> +	ret = j721e_pcie_set_link_speed(pcie, dev, syscon, offset);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set link speed\n");
>  		return ret;
>  	}
>  
> -	ret = j721e_pcie_set_lane_count(pcie, syscon, offset);
> +	ret = j721e_pcie_set_lane_count(pcie, dev, syscon, offset);
>  	if (ret < 0) {
>  		dev_err(dev, "Failed to set num-lanes\n");
>  		return ret;
> @@ -308,7 +307,7 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
>  	if (!syscon)
>  		return 0;
>  
> -	return j721e_enable_acspcie_refclk(pcie, syscon);
> +	return j721e_enable_acspcie_refclk(pcie, dev, syscon);
>  }
>  
>  static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> @@ -469,6 +468,47 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  	if (!pcie)
>  		return -ENOMEM;
>  
> +	pcie->mode = mode;
> +
> +	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> +	if (ret || num_lanes > data->max_lanes) {
> +		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
> +		num_lanes = 1;
> +	}
> +
> +	pcie->num_lanes = num_lanes;
> +	pcie->max_lanes = data->max_lanes;
> +
> +	/*
> +	 * The PCIe Controller's registers have different "reset-values" depending
> +	 * on the "strap" settings programmed into the Controller's Glue Layer.
> +	 * This is because the same set of registers are used for representing the
> +	 * Physical Function configuration space in Endpoint mode and for
> +	 * representing the Root-Port configuration space in Root-Complex mode.
> +	 *
> +	 * The registers latch onto a "reset-value" based on the "strap" settings
> +	 * sampled after the Controller is powered on. Therefore, for the
> +	 * "reset-value" to be accurate, it is necessary to program the "strap"
> +	 * settings when the Controller is powered off, and power on the Controller
> +	 * after the "strap" settings have been programmed.
> +	 *
> +	 * The "strap" settings are programmed by "j721e_pcie_ctrl_init()".
> +	 * Therefore, power off the Controller before invoking "j721e_pcie_ctrl_init()",
> +	 * program the "strap" settings, and then power on the Controller. This ensures
> +	 * that the reset values are accurate and reflect the "strap" settings.

Wrap to fit in 80 columns like the rest of the file.  And maybe
shorten.

> +	dev_pm_domain_detach(dev, true);
> +
> +	ret = j721e_pcie_ctrl_init(pcie, dev);

This moves the "num-lanes" lookup and the call of
j721e_pcie_ctrl_init() earlier, but I don't think that move is
necessary.  Even before this patch, we don't actually touch anything
in the hardware before j721e_pcie_ctrl_init().  The code between the
new call location and the old call location is just memory allocation,
data structure initialization, ioremap, DMA mask setting, etc.

AFAICT, the important thing is to power off the PCIe controller before
j721e_pcie_ctrl_init() programs the mode in the glue layer, and you
should be able to do that without moving the call location.

And that means you probably don't have to add the "struct device *dev"
parameter to all those interfaces.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dev_pm_domain_attach(dev, true);

dev_pm_domain_detach() takes a bool, but dev_pm_domain_attach() does
not, so this doesn't look right.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to power on device\n");
> +		return ret;
> +	}
> +
>  	switch (mode) {
>  	case PCI_MODE_RC:
>  		if (!IS_ENABLED(CONFIG_PCI_J721E_HOST))
> @@ -510,7 +550,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		return 0;
>  	}
>  
> -	pcie->mode = mode;
>  	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
>  
>  	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
> @@ -523,15 +562,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	pcie->user_cfg_base = base;
>  
> -	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> -	if (ret || num_lanes > data->max_lanes) {
> -		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
> -		num_lanes = 1;
> -	}
> -
> -	pcie->num_lanes = num_lanes;
> -	pcie->max_lanes = data->max_lanes;
> -
>  	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
>  		return -EINVAL;
>  
> @@ -547,12 +577,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
>  		goto err_get_sync;
>  	}
>  
> -	ret = j721e_pcie_ctrl_init(pcie);
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
> -		goto err_get_sync;
> -	}
> -
>  	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
>  			       "j721e-pcie-link-down-irq", pcie);
>  	if (ret < 0) {
> @@ -680,7 +704,7 @@ static int j721e_pcie_resume_noirq(struct device *dev)
>  	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
>  	int ret;
>  
> -	ret = j721e_pcie_ctrl_init(pcie);
> +	ret = j721e_pcie_ctrl_init(pcie, dev);
>  	if (ret < 0)
>  		return ret;
>  
> -- 
> 2.43.0
> 

