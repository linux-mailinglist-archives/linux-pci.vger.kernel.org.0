Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CB2147964
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2020 09:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbgAXI1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jan 2020 03:27:11 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33623 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAXI1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jan 2020 03:27:11 -0500
X-Originating-IP: 88.190.179.123
Received: from localhost (unknown [88.190.179.123])
        (Authenticated sender: repk@triplefau.lt)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 7DE94240014;
        Fri, 24 Jan 2020 08:27:05 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:35:29 +0100
From:   Remi Pommarel <repk@triplefau.lt>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 7/7] PCI: amlogic: Use AXG PCIE
Message-ID: <20200124083529.GX1803@voidbox>
References: <20200123232943.10229-1-repk@triplefau.lt>
 <20200123232943.10229-8-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123232943.10229-8-repk@triplefau.lt>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing Reviewed/Acked-by from v5

On Fri, Jan 24, 2020 at 12:29:43AM +0100, Remi Pommarel wrote:
> Now that PCIE PHY has been introduced for AXG, the whole has_shared_phy
> logic can be mutualized between AXG and G12A platforms.
> 
> This new PHY makes use of the shared MIPI/PCIE analog PHY found on AXG
> platforms, which need to be used in order to have reliable PCIE
> communications.
> 
> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 116 +++++--------------------
>  1 file changed, 22 insertions(+), 94 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 3772b02a5c55..3715dceca1bf 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -66,7 +66,6 @@
>  #define PORT_CLK_RATE			100000000UL
>  #define MAX_PAYLOAD_SIZE		256
>  #define MAX_READ_REQ_SIZE		256
> -#define MESON_PCIE_PHY_POWERUP		0x1c
>  #define PCIE_RESET_DELAY		500
>  #define PCIE_SHARED_RESET		1
>  #define PCIE_NORMAL_RESET		0
> @@ -81,26 +80,19 @@ enum pcie_data_rate {
>  struct meson_pcie_mem_res {
>  	void __iomem *elbi_base;
>  	void __iomem *cfg_base;
> -	void __iomem *phy_base;
>  };
>  
>  struct meson_pcie_clk_res {
>  	struct clk *clk;
> -	struct clk *mipi_gate;
>  	struct clk *port_clk;
>  	struct clk *general_clk;
>  };
>  
>  struct meson_pcie_rc_reset {
> -	struct reset_control *phy;
>  	struct reset_control *port;
>  	struct reset_control *apb;
>  };
>  
> -struct meson_pcie_param {
> -	bool has_shared_phy;
> -};
> -
>  struct meson_pcie {
>  	struct dw_pcie pci;
>  	struct meson_pcie_mem_res mem_res;
> @@ -108,7 +100,6 @@ struct meson_pcie {
>  	struct meson_pcie_rc_reset mrst;
>  	struct gpio_desc *reset_gpio;
>  	struct phy *phy;
> -	const struct meson_pcie_param *param;
>  };
>  
>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
> @@ -130,13 +121,6 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>  
> -	if (!mp->param->has_shared_phy) {
> -		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> -		if (IS_ERR(mrst->phy))
> -			return PTR_ERR(mrst->phy);
> -		reset_control_deassert(mrst->phy);
> -	}
> -
>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>  	if (IS_ERR(mrst->port))
>  		return PTR_ERR(mrst->port);
> @@ -162,22 +146,6 @@ static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
>  	return devm_ioremap_resource(dev, res);
>  }
>  
> -static void __iomem *meson_pcie_get_mem_shared(struct platform_device *pdev,
> -					       struct meson_pcie *mp,
> -					       const char *id)
> -{
> -	struct device *dev = mp->pci.dev;
> -	struct resource *res;
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
> -	if (!res) {
> -		dev_err(dev, "No REG resource %s\n", id);
> -		return ERR_PTR(-ENXIO);
> -	}
> -
> -	return devm_ioremap(dev, res->start, resource_size(res));
> -}
> -
>  static int meson_pcie_get_mems(struct platform_device *pdev,
>  			       struct meson_pcie *mp)
>  {
> @@ -189,14 +157,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>  	if (IS_ERR(mp->mem_res.cfg_base))
>  		return PTR_ERR(mp->mem_res.cfg_base);
>  
> -	/* Meson AXG SoC has two PCI controllers use same phy register */
> -	if (!mp->param->has_shared_phy) {
> -		mp->mem_res.phy_base =
> -			meson_pcie_get_mem_shared(pdev, mp, "phy");
> -		if (IS_ERR(mp->mem_res.phy_base))
> -			return PTR_ERR(mp->mem_res.phy_base);
> -	}
> -
>  	return 0;
>  }
>  
> @@ -204,37 +164,33 @@ static int meson_pcie_power_on(struct meson_pcie *mp)
>  {
>  	int ret = 0;
>  
> -	if (mp->param->has_shared_phy) {
> -		ret = phy_init(mp->phy);
> -		if (ret)
> -			return ret;
> +	ret = phy_init(mp->phy);
> +	if (ret)
> +		return ret;
>  
> -		ret = phy_power_on(mp->phy);
> -		if (ret) {
> -			phy_exit(mp->phy);
> -			return ret;
> -		}
> -	} else
> -		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> +	ret = phy_power_on(mp->phy);
> +	if (ret) {
> +		phy_exit(mp->phy);
> +		return ret;
> +	}
>  
>  	return 0;
>  }
>  
> +static void meson_pcie_power_off(struct meson_pcie *mp)
> +{
> +	phy_power_off(mp->phy);
> +	phy_exit(mp->phy);
> +}
> +
>  static int meson_pcie_reset(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>  	int ret = 0;
>  
> -	if (mp->param->has_shared_phy) {
> -		ret = phy_reset(mp->phy);
> -		if (ret)
> -			return ret;
> -	} else {
> -		reset_control_assert(mrst->phy);
> -		udelay(PCIE_RESET_DELAY);
> -		reset_control_deassert(mrst->phy);
> -		udelay(PCIE_RESET_DELAY);
> -	}
> +	ret = phy_reset(mp->phy);
> +	if (ret)
> +		return ret;
>  
>  	reset_control_assert(mrst->port);
>  	reset_control_assert(mrst->apb);
> @@ -286,12 +242,6 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  	if (IS_ERR(res->port_clk))
>  		return PTR_ERR(res->port_clk);
>  
> -	if (!mp->param->has_shared_phy) {
> -		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> -		if (IS_ERR(res->mipi_gate))
> -			return PTR_ERR(res->mipi_gate);
> -	}
> -
>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
>  	if (IS_ERR(res->general_clk))
>  		return PTR_ERR(res->general_clk);
> @@ -562,7 +512,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  
>  static int meson_pcie_probe(struct platform_device *pdev)
>  {
> -	const struct meson_pcie_param *match_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct meson_pcie *mp;
> @@ -576,17 +525,10 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> -	match_data = of_device_get_match_data(dev);
> -	if (!match_data) {
> -		dev_err(dev, "failed to get match data\n");
> -		return -ENODEV;
> -	}
> -	mp->param = match_data;
> -
> -	if (mp->param->has_shared_phy) {
> -		mp->phy = devm_phy_get(dev, "pcie");
> -		if (IS_ERR(mp->phy))
> -			return PTR_ERR(mp->phy);
> +	mp->phy = devm_phy_get(dev, "pcie");
> +	if (IS_ERR(mp->phy)) {
> +		dev_err(dev, "get phy failed, %ld\n", PTR_ERR(mp->phy));
> +		return PTR_ERR(mp->phy);
>  	}
>  
>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> @@ -636,30 +578,16 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_phy:
> -	if (mp->param->has_shared_phy) {
> -		phy_power_off(mp->phy);
> -		phy_exit(mp->phy);
> -	}
> -
> +	meson_pcie_power_off(mp);
>  	return ret;
>  }
>  
> -static struct meson_pcie_param meson_pcie_axg_param = {
> -	.has_shared_phy = false,
> -};
> -
> -static struct meson_pcie_param meson_pcie_g12a_param = {
> -	.has_shared_phy = true,
> -};
> -
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> -		.data = &meson_pcie_axg_param,
>  	},
>  	{
>  		.compatible = "amlogic,g12a-pcie",
> -		.data = &meson_pcie_g12a_param,
>  	},
>  	{},
>  };

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
