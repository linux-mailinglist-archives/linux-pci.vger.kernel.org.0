Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10939219E65
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 12:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgGIKy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 06:54:28 -0400
Received: from foss.arm.com ([217.140.110.172]:50478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGIKy2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 06:54:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732B51FB;
        Thu,  9 Jul 2020 03:54:26 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA5ED3F887;
        Thu,  9 Jul 2020 03:54:24 -0700 (PDT)
Date:   Thu, 9 Jul 2020 11:54:18 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     kishon@ti.com, robh@kernel.org, bhelgaas@google.com,
        m-karicheri2@ti.com, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, shawn.guo@linaro.org,
        songxiaowei@hisilicon.com, svarbanov@mm-sol.com, agross@kernel.org,
        bjorn.andersson@linaro.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: convert to
 devm_platform_ioremap_resource_byname()
Message-ID: <20200709105418.GA19638@e121166-lin.cambridge.arm.com>
References: <20200528161510.31935-1-zhengdejin5@gmail.com>
 <20200708164013.5076-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708164013.5076-1-zhengdejin5@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 12:40:13AM +0800, Dejin Zheng wrote:
> Use devm_platform_ioremap_resource_byname() to simplify codes.
> it contains platform_get_resource_byname() and devm_ioremap_resource().
> 
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> Reviewed-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v1 -> v2:
> 	- rebase to pci/dwc branch
> 	- add Gustavo and Rob's Reviewed tag
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c         | 11 ++++-------
>  drivers/pci/controller/dwc/pci-keystone.c       |  7 +++----
>  drivers/pci/controller/dwc/pcie-artpec6.c       | 12 ++++--------
>  .../pci/controller/dwc/pcie-designware-plat.c   |  3 +--
>  drivers/pci/controller/dwc/pcie-histb.c         |  7 ++-----
>  drivers/pci/controller/dwc/pcie-intel-gw.c      |  7 ++-----
>  drivers/pci/controller/dwc/pcie-kirin.c         | 17 ++++++-----------
>  drivers/pci/controller/dwc/pcie-qcom.c          |  6 ++----
>  drivers/pci/controller/dwc/pcie-uniphier.c      |  3 +--
>  9 files changed, 25 insertions(+), 48 deletions(-)

Applied to pci/dwc, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 6184ebc9392d..e5d0c7ac09b9 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -593,13 +593,12 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics");
> -	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "ep_dbics");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ep_dbics2");
> -	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 =
> +		devm_platform_ioremap_resource_byname(pdev, "ep_dbics2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
>  
> @@ -626,7 +625,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	struct dw_pcie *pci = dra7xx->pci;
>  	struct pcie_port *pp = &pci->pp;
>  	struct device *dev = pci->dev;
> -	struct resource *res;
>  
>  	pp->irq = platform_get_irq(pdev, 1);
>  	if (pp->irq < 0) {
> @@ -638,8 +636,7 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
>  	if (ret < 0)
>  		return ret;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc_dbics");
> -	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "rc_dbics");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 790679fdfa48..5ffc3b40c4f6 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1228,8 +1228,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	if (!pci)
>  		return -ENOMEM;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
> +	ks_pcie->va_app_base =
> +		devm_platform_ioremap_resource_byname(pdev, "app");
>  	if (IS_ERR(ks_pcie->va_app_base))
>  		return PTR_ERR(ks_pcie->va_app_base);
>  
> @@ -1323,8 +1323,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	if (pci->version >= 0x480A) {
> -		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "atu");
> -		atu_base = devm_ioremap_resource(dev, res);
> +		atu_base = devm_platform_ioremap_resource_byname(pdev, "atu");
>  		if (IS_ERR(atu_base)) {
>  			ret = PTR_ERR(atu_base);
>  			goto err_get_sync;
> diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
> index 28d5a1095200..7d2cfa288b01 100644
> --- a/drivers/pci/controller/dwc/pcie-artpec6.c
> +++ b/drivers/pci/controller/dwc/pcie-artpec6.c
> @@ -455,8 +455,7 @@ static int artpec6_add_pcie_ep(struct artpec6_pcie *artpec6_pcie,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
>  
> @@ -481,8 +480,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct artpec6_pcie *artpec6_pcie;
> -	struct resource *dbi_base;
> -	struct resource *phy_base;
>  	int ret;
>  	const struct of_device_id *match;
>  	const struct artpec_pcie_of_data *data;
> @@ -512,13 +509,12 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
>  	artpec6_pcie->variant = variant;
>  	artpec6_pcie->mode = mode;
>  
> -	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pci->dbi_base = devm_ioremap_resource(dev, dbi_base);
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> -	phy_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	artpec6_pcie->phy_base = devm_ioremap_resource(dev, phy_base);
> +	artpec6_pcie->phy_base =
> +		devm_platform_ioremap_resource_byname(pdev, "phy");
>  	if (IS_ERR(artpec6_pcie->phy_base))
>  		return PTR_ERR(artpec6_pcie->phy_base);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
> index 73646b677aff..712456f6ce36 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-plat.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
> @@ -153,8 +153,7 @@ static int dw_plat_add_pcie_ep(struct dw_plat_pcie *dw_plat_pcie,
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi2");
> -	pci->dbi_base2 = devm_ioremap_resource(dev, res);
> +	pci->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
>  	if (IS_ERR(pci->dbi_base2))
>  		return PTR_ERR(pci->dbi_base2);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
> index 811b5c6d62ea..6d3524c39a9b 100644
> --- a/drivers/pci/controller/dwc/pcie-histb.c
> +++ b/drivers/pci/controller/dwc/pcie-histb.c
> @@ -304,7 +304,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  	struct histb_pcie *hipcie;
>  	struct dw_pcie *pci;
>  	struct pcie_port *pp;
> -	struct resource *res;
>  	struct device_node *np = pdev->dev.of_node;
>  	struct device *dev = &pdev->dev;
>  	enum of_gpio_flags of_flags;
> @@ -324,15 +323,13 @@ static int histb_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "control");
> -	hipcie->ctrl = devm_ioremap_resource(dev, res);
> +	hipcie->ctrl = devm_platform_ioremap_resource_byname(pdev, "control");
>  	if (IS_ERR(hipcie->ctrl)) {
>  		dev_err(dev, "cannot get control reg base\n");
>  		return PTR_ERR(hipcie->ctrl);
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rc-dbi");
> -	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "rc-dbi");
>  	if (IS_ERR(pci->dbi_base)) {
>  		dev_err(dev, "cannot get rc-dbi base\n");
>  		return PTR_ERR(pci->dbi_base);
> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
> index 2d8dbb318087..c3b3a1d162b5 100644
> --- a/drivers/pci/controller/dwc/pcie-intel-gw.c
> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
> @@ -253,11 +253,9 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>  	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
>  	struct dw_pcie *pci = &lpp->pci;
>  	struct device *dev = pci->dev;
> -	struct resource *res;
>  	int ret;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	pci->dbi_base = devm_ioremap_resource(dev, res);
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(pci->dbi_base))
>  		return PTR_ERR(pci->dbi_base);
>  
> @@ -291,8 +289,7 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
>  	ret = of_pci_get_max_link_speed(dev->of_node);
>  	lpp->link_gen = ret < 0 ? 0 : ret;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
> -	lpp->app_base = devm_ioremap_resource(dev, res);
> +	lpp->app_base = devm_platform_ioremap_resource_byname(pdev, "app");
>  	if (IS_ERR(lpp->app_base))
>  		return PTR_ERR(lpp->app_base);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index c19617a912bd..e5e765038686 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -147,23 +147,18 @@ static long kirin_pcie_get_clk(struct kirin_pcie *kirin_pcie,
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  				    struct platform_device *pdev)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct resource *apb;
> -	struct resource *phy;
> -	struct resource *dbi;
> -
> -	apb = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb");
> -	kirin_pcie->apb_base = devm_ioremap_resource(dev, apb);
> +	kirin_pcie->apb_base =
> +		devm_platform_ioremap_resource_byname(pdev, "apb");
>  	if (IS_ERR(kirin_pcie->apb_base))
>  		return PTR_ERR(kirin_pcie->apb_base);
>  
> -	phy = platform_get_resource_byname(pdev, IORESOURCE_MEM, "phy");
> -	kirin_pcie->phy_base = devm_ioremap_resource(dev, phy);
> +	kirin_pcie->phy_base =
> +		devm_platform_ioremap_resource_byname(pdev, "phy");
>  	if (IS_ERR(kirin_pcie->phy_base))
>  		return PTR_ERR(kirin_pcie->phy_base);
>  
> -	dbi = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
> -	kirin_pcie->pci->dbi_base = devm_ioremap_resource(dev, dbi);
> +	kirin_pcie->pci->dbi_base =
> +		devm_platform_ioremap_resource_byname(pdev, "dbi");
>  	if (IS_ERR(kirin_pcie->pci->dbi_base))
>  		return PTR_ERR(kirin_pcie->pci->dbi_base);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 73d4eed26f65..b79f7878c993 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1405,8 +1405,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	if (pcie->gen < 0)
>  		pcie->gen = 2;
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "parf");
> -	pcie->parf = devm_ioremap_resource(dev, res);
> +	pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
>  	if (IS_ERR(pcie->parf)) {
>  		ret = PTR_ERR(pcie->parf);
>  		goto err_pm_runtime_put;
> @@ -1419,8 +1418,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> -	pcie->elbi = devm_ioremap_resource(dev, res);
> +	pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
>  	if (IS_ERR(pcie->elbi)) {
>  		ret = PTR_ERR(pcie->elbi);
>  		goto err_pm_runtime_put;
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index a5401a0b1e58..3a7f403b57b8 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -416,8 +416,7 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->pci.dbi_base))
>  		return PTR_ERR(priv->pci.dbi_base);
>  
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "link");
> -	priv->base = devm_ioremap_resource(dev, res);
> +	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
>  
> -- 
> 2.25.0
> 
