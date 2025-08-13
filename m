Return-Path: <linux-pci+bounces-34000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3861AB25747
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 01:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB08885E7E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 23:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B462FB98F;
	Wed, 13 Aug 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpTjru7i"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1792C08BE;
	Wed, 13 Aug 2025 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126455; cv=none; b=ERlshxFq6lxkIC6jjeydu8Oni497t2flFOnauK+EkDEyrcxwqnU2eSB1roYfIZrOJSaLy3xG8Vdrj+E5O37xWLSWOIsYcTrv+1CQcqhkB0/tC0cxldgxKaiTlE6/9f3J2La/RhpXKm+IFVheo/JZ7RcAscId/s3Ip4vGtZySHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126455; c=relaxed/simple;
	bh=RQj7R/jUfcb1J1MF9Yb8oU2r7g6moV6/qYad+4ZXOe4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=X+TVHPIA3sFtmC5Xh68mMD+OHDojxgm9uKQleb6lTlTdZZFCSNf2ZO6i4FJ7csERB2ZRXw+Pa6kZTIP2g81+/SCG7I9iXwsCpZDhwkFxW7KQiSPhnoFr4UBVlX4OyLYF5nWBS6JrMTXiKBfgN/GwKaJNJaEpcRA+/e3wHvv3k1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpTjru7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF59C4CEEB;
	Wed, 13 Aug 2025 23:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755126454;
	bh=RQj7R/jUfcb1J1MF9Yb8oU2r7g6moV6/qYad+4ZXOe4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gpTjru7i4m4RoZ4EYlG4lFGBOruosmV4U/17OhCTtwc+ykzNjEe3rqSxnfDIYHzlD
	 G9XuNJcVxwlaC6A+75nCAaf7zKVwbp/3S50yhzQdWy06TltL8KoOE4wruyWkOH5Sbb
	 SJtXMVB5WUas49uX21yhB13ir/9JnOmaZ7O8Y9Hu5TUuDTHaJs7STOqKbNfIM5JcEp
	 x5JWQUaanvYepl7WByJCFtY0DbsIdImDNv4fL6hex6xdmRErwx3c/KbAZH+3FLeDc0
	 I4YTaUOVAjyiIkJ827QL863oHECSlTcaTX9dDLcutLc+5uBW/ef2RwO3tyxoUTcKpU
	 vfJcISNe5BuiQ==
Date: Wed, 13 Aug 2025 18:07:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, mani@kernel.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, jingoohan1@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alim.akhtar@samsung.com, vkoul@kernel.org,
	kishon@kernel.org, arnd@arndb.de, m.szyprowski@samsung.com,
	jh80.chung@samsung.com, pankaj.dubey@samsung.com
Subject: Re: [PATCH v3 05/12] PCI: exynos: Add resource ops, soc variant and
 device mode
Message-ID: <20250813230733.GA299608@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811154638.95732-6-shradha.t@samsung.com>

On Mon, Aug 11, 2025 at 09:16:31PM +0530, Shradha Todi wrote:
> Some resources might differ based on platforms and we need platform
> specific functions to initialize or alter them. For better code
> re-usability, making a separate res_ops which will hold all such
> function pointers or other resource specific data. Include ops like
>  - init_regulator (initialize the regulator data)
>  - pcie_irq_handler (interrupt handler for PCIe)
>  - set_device_mode (set device mode to EP or RC)
> 
> Some operations maybe specific to certain SoCs and not applicable
> to others. For such use cases, adding an SoC variant data field
> which can be used to distinguish between the variants.
> 
> Some SoCs may have dual-role PCIe controller which can work as
> RC or EP. Add device_mode to store the role and take decisions
> accordingly.
> 
> Make enable/disable of regulator and initialization of IRQ as
> common functions to be used by all Samsung SoCs.

As hinted above, this patch ends up being a mixture of several things
that makes this kind of hard to review.  Separating these into their
own patches would make it easier.

> Suggested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> ---
>  drivers/pci/controller/dwc/pci-exynos.c | 143 +++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
> index c830b20d54f0..ef1f42236575 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -49,10 +49,18 @@
>  #define EXYNOS_PCIE_ELBI_SLV_ARMISC		0x120
>  #define EXYNOS_PCIE_ELBI_SLV_DBI_ENABLE		BIT(21)
>  
> +/* to store different SoC variants of Samsung */
> +enum samsung_pcie_variants {
> +	EXYNOS_5433,
> +};
> +
>  struct samsung_pcie_pdata {
>  	struct pci_ops				*pci_ops;
>  	const struct dw_pcie_ops		*dwc_ops;
>  	const struct dw_pcie_host_ops		*host_ops;
> +	const struct samsung_res_ops		*res_ops;
> +	unsigned int				soc_variant;
> +	enum dw_pcie_device_mode		device_mode;
>  };
>  
>  struct exynos_pcie {
> @@ -61,7 +69,14 @@ struct exynos_pcie {
>  	const struct samsung_pcie_pdata	*pdata;
>  	struct clk_bulk_data		*clks;
>  	struct phy			*phy;
> -	struct regulator_bulk_data	supplies[2];
> +	struct regulator_bulk_data	*supplies;
> +	int				supplies_cnt;
> +};
> +
> +struct samsung_res_ops {
> +	int (*init_regulator)(struct exynos_pcie *ep);
> +	irqreturn_t (*pcie_irq_handler)(int irq, void *arg);
> +	void (*set_device_mode)(struct exynos_pcie *ep);
>  };
>  
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> @@ -74,6 +89,31 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
>  	return readl(base + reg);
>  }
>  
> +static int samsung_regulator_enable(struct exynos_pcie *ep)
> +{
> +	int ret;
> +
> +	if (ep->supplies_cnt == 0)
> +		return 0;
> +
> +	ret = regulator_bulk_enable(ep->supplies_cnt, ep->supplies);
> +
> +	return ret;

Unless you want a warning here, there's no need for "ret":

  return regulator_bulk_enable(ep->supplies_cnt, ep->supplies);

> +}
> +
> +static void samsung_regulator_disable(struct exynos_pcie *ep)
> +{
> +	struct device *dev = ep->pci.dev;
> +	int ret;
> +
> +	if (ep->supplies_cnt == 0)
> +		return;
> +
> +	ret = regulator_bulk_disable(ep->supplies_cnt, ep->supplies);
> +	if (ret)
> +		dev_warn(dev, "failed to disable regulators: %d\n", ret);
> +}
> +
>  static void exynos_pcie_sideband_dbi_w_mode(struct exynos_pcie *ep, bool on)
>  {
>  	u32 val;
> @@ -244,7 +284,26 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
>  	.init = exynos_pcie_host_init,
>  };
>  
> -static int exynos_add_pcie_port(struct exynos_pcie *ep,
> +static int exynos_init_regulator(struct exynos_pcie *ep)
> +{
> +	struct device *dev = ep->pci.dev;
> +	int ret = 0;
> +
> +	ep->supplies_cnt = 2;
> +
> +	ep->supplies = devm_kcalloc(dev, ep->supplies_cnt, sizeof(*ep->supplies), GFP_KERNEL);
> +	if (!ep->supplies)
> +		return -ENOMEM;
> +
> +	ep->supplies[0].supply = "vdd18";
> +	ep->supplies[1].supply = "vdd10";
> +
> +	ret = devm_regulator_bulk_get(dev, ep->supplies_cnt, ep->supplies);
> +
> +	return ret;

No need for ret.

> +}
> +
> +static int samsung_irq_init(struct exynos_pcie *ep,
>  				       struct platform_device *pdev)
>  {
>  	struct dw_pcie *pci = &ep->pci;
> @@ -256,22 +315,15 @@ static int exynos_add_pcie_port(struct exynos_pcie *ep,
>  	if (pp->irq < 0)
>  		return pp->irq;
>  
> -	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
> +	ret = devm_request_irq(dev, pp->irq, ep->pdata->res_ops->pcie_irq_handler,
>  			       IRQF_SHARED, "exynos-pcie", ep);
>  	if (ret) {
>  		dev_err(dev, "failed to request irq\n");
>  		return ret;
>  	}
>  
> -	pp->ops = &exynos_pcie_host_ops;
>  	pp->msi_irq[0] = -ENODEV;
>  
> -	ret = dw_pcie_host_init(pp);
> -	if (ret) {
> -		dev_err(dev, "failed to initialize host\n");
> -		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -282,6 +334,11 @@ static const struct dw_pcie_ops exynos_dw_pcie_ops = {
>  	.start_link = exynos_pcie_start_link,
>  };
>  
> +static const struct samsung_res_ops exynos_res_ops_data = {
> +	.init_regulator		= exynos_init_regulator,
> +	.pcie_irq_handler	= exynos_pcie_irq_handler,
> +};
> +
>  static int exynos_pcie_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -313,28 +370,46 @@ static int exynos_pcie_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return ret;
>  
> -	ep->supplies[0].supply = "vdd18";
> -	ep->supplies[1].supply = "vdd10";
> -	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ep->supplies),
> -				      ep->supplies);
> -	if (ret)
> -		return ret;
> +	if (pdata->res_ops && pdata->res_ops->init_regulator) {
> +		ret = ep->pdata->res_ops->init_regulator(ep);
> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	ret = samsung_regulator_enable(ep);
>  	if (ret)
>  		return ret;
>  
>  	platform_set_drvdata(pdev, ep);
>  
> -	ret = exynos_add_pcie_port(ep, pdev);
> -	if (ret < 0)
> -		goto fail_probe;
> +	if (pdata->res_ops && pdata->res_ops->set_device_mode)
> +		pdata->res_ops->set_device_mode(ep);
> +
> +	switch (ep->pdata->device_mode) {
> +	case DW_PCIE_RC_TYPE:
> +		ret = samsung_irq_init(ep, pdev);
> +		if (ret)
> +			goto fail_regulator;
> +
> +		ep->pci.pp.ops = pdata->host_ops;
> +
> +		ret = dw_pcie_host_init(&ep->pci.pp);
> +		if (ret < 0)
> +			goto fail_phy_init;
> +
> +		break;
> +	default:
> +		dev_err(dev, "invalid device type\n");
> +		ret = -EINVAL;
> +		goto fail_regulator;
> +	}
>  
>  	return 0;
>  
> -fail_probe:
> +fail_phy_init:
>  	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +fail_regulator:
> +	samsung_regulator_disable(ep);
>  
>  	return ret;
>  }
> @@ -343,21 +418,29 @@ static void exynos_pcie_remove(struct platform_device *pdev)
>  {
>  	struct exynos_pcie *ep = platform_get_drvdata(pdev);
>  
> +	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
> +		return;
>  	dw_pcie_host_deinit(&ep->pci.pp);
> -	exynos_pcie_assert_core_reset(ep);
> +	if (ep->pdata->soc_variant == EXYNOS_5433)
> +		exynos_pcie_assert_core_reset(ep);

I think it's a mistake to test for specific soc_variants.  Better to
test a *property* (or use a function pointer than can be SoC-specific)
because it's likely that several SoCs will share the same property.

>  	phy_power_off(ep->phy);
>  	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	samsung_regulator_disable(ep);
>  }
>  
>  static int exynos_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct exynos_pcie *ep = dev_get_drvdata(dev);
> +	struct dw_pcie *pci = &ep->pci;
>  
> -	exynos_pcie_assert_core_reset(ep);
> +	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	if (ep->pdata->soc_variant == EXYNOS_5433)
> +		exynos_pcie_assert_core_reset(ep);
>  	phy_power_off(ep->phy);
>  	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	samsung_regulator_disable(ep);
>  
>  	return 0;
>  }
> @@ -369,7 +452,10 @@ static int exynos_pcie_resume_noirq(struct device *dev)
>  	struct dw_pcie_rp *pp = &pci->pp;
>  	int ret;
>  
> -	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	if (ep->pdata->device_mode == DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	ret = samsung_regulator_enable(ep);
>  	if (ret)
>  		return ret;
>  
> @@ -389,6 +475,9 @@ static const struct samsung_pcie_pdata exynos_5433_pcie_rc_pdata = {
>  	.dwc_ops		= &exynos_dw_pcie_ops,
>  	.pci_ops		= &exynos_pci_ops,
>  	.host_ops		= &exynos_pcie_host_ops,
> +	.res_ops		= &exynos_res_ops_data,
> +	.soc_variant		= EXYNOS_5433,
> +	.device_mode		= DW_PCIE_RC_TYPE,
>  };
>  
>  static const struct of_device_id exynos_pcie_of_match[] = {
> -- 
> 2.49.0
> 

