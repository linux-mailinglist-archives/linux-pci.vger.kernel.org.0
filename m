Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59540B3B2D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 15:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfIPNUz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 09:20:55 -0400
Received: from foss.arm.com ([217.140.110.172]:44724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733043AbfIPNUz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Sep 2019 09:20:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF5D337;
        Mon, 16 Sep 2019 06:20:54 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A792B3F67D;
        Mon, 16 Sep 2019 06:20:53 -0700 (PDT)
Date:   Mon, 16 Sep 2019 14:20:51 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, yue.wang@Amlogic.com, maz@kernel.org,
        repk@triplefau.lt, nick@khadas.com, gouwa@khadas.com
Subject: Re: [PATCH v2 3/6] PCI: amlogic: meson: Add support for G12A
Message-ID: <20190916132051.GP9720@e119886-lin.cambridge.arm.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
 <20190916125022.10754-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916125022.10754-4-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 16, 2019 at 02:50:19PM +0200, Neil Armstrong wrote:
> Add support for the Amlogic G12A SoC using a separate shared PHY.
> 
> This adds support for fetching a PHY phandle and call the PHY init,
> reset and power on/off calls instead of writing in the PHY register or
> toggling the PHY reset line.
> 
> The MIPI clock and the PHY memory resource are only required for the
> Amlogic AXG SoC PCIe PHY setup, thus these elements are ignored for
> the Amlogic G12A having a separate shared PHY.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 128 ++++++++++++++++++++-----
>  1 file changed, 105 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index ab79990798f8..3772b02a5c55 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -16,6 +16,7 @@
>  #include <linux/reset.h>
>  #include <linux/resource.h>
>  #include <linux/types.h>
> +#include <linux/phy/phy.h>
>  
>  #include "pcie-designware.h"
>  
> @@ -96,12 +97,18 @@ struct meson_pcie_rc_reset {
>  	struct reset_control *apb;
>  };
>  
> +struct meson_pcie_param {
> +	bool has_shared_phy;
> +};
> +
>  struct meson_pcie {
>  	struct dw_pcie pci;
>  	struct meson_pcie_mem_res mem_res;
>  	struct meson_pcie_clk_res clk_res;
>  	struct meson_pcie_rc_reset mrst;
>  	struct gpio_desc *reset_gpio;
> +	struct phy *phy;
> +	const struct meson_pcie_param *param;
>  };
>  
>  static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
> @@ -123,10 +130,12 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
>  
> -	mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> -	if (IS_ERR(mrst->phy))
> -		return PTR_ERR(mrst->phy);
> -	reset_control_deassert(mrst->phy);
> +	if (!mp->param->has_shared_phy) {
> +		mrst->phy = meson_pcie_get_reset(mp, "phy", PCIE_SHARED_RESET);
> +		if (IS_ERR(mrst->phy))
> +			return PTR_ERR(mrst->phy);
> +		reset_control_deassert(mrst->phy);
> +	}
>  
>  	mrst->port = meson_pcie_get_reset(mp, "port", PCIE_NORMAL_RESET);
>  	if (IS_ERR(mrst->port))
> @@ -180,27 +189,52 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>  	if (IS_ERR(mp->mem_res.cfg_base))
>  		return PTR_ERR(mp->mem_res.cfg_base);
>  
> -	/* Meson SoC has two PCI controllers use same phy register*/
> -	mp->mem_res.phy_base = meson_pcie_get_mem_shared(pdev, mp, "phy");
> -	if (IS_ERR(mp->mem_res.phy_base))
> -		return PTR_ERR(mp->mem_res.phy_base);
> +	/* Meson AXG SoC has two PCI controllers use same phy register */
> +	if (!mp->param->has_shared_phy) {
> +		mp->mem_res.phy_base =
> +			meson_pcie_get_mem_shared(pdev, mp, "phy");
> +		if (IS_ERR(mp->mem_res.phy_base))
> +			return PTR_ERR(mp->mem_res.phy_base);
> +	}
>  
>  	return 0;
>  }
>  
> -static void meson_pcie_power_on(struct meson_pcie *mp)
> +static int meson_pcie_power_on(struct meson_pcie *mp)
>  {
> -	writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> +	int ret = 0;
> +
> +	if (mp->param->has_shared_phy) {
> +		ret = phy_init(mp->phy);
> +		if (ret)
> +			return ret;
> +
> +		ret = phy_power_on(mp->phy);
> +		if (ret) {
> +			phy_exit(mp->phy);
> +			return ret;
> +		}
> +	} else
> +		writel(MESON_PCIE_PHY_POWERUP, mp->mem_res.phy_base);
> +
> +	return 0;
>  }
>  
> -static void meson_pcie_reset(struct meson_pcie *mp)
> +static int meson_pcie_reset(struct meson_pcie *mp)
>  {
>  	struct meson_pcie_rc_reset *mrst = &mp->mrst;
> -
> -	reset_control_assert(mrst->phy);
> -	udelay(PCIE_RESET_DELAY);
> -	reset_control_deassert(mrst->phy);
> -	udelay(PCIE_RESET_DELAY);
> +	int ret = 0;
> +
> +	if (mp->param->has_shared_phy) {
> +		ret = phy_reset(mp->phy);
> +		if (ret)
> +			return ret;
> +	} else {
> +		reset_control_assert(mrst->phy);
> +		udelay(PCIE_RESET_DELAY);
> +		reset_control_deassert(mrst->phy);
> +		udelay(PCIE_RESET_DELAY);
> +	}
>  
>  	reset_control_assert(mrst->port);
>  	reset_control_assert(mrst->apb);
> @@ -208,6 +242,8 @@ static void meson_pcie_reset(struct meson_pcie *mp)
>  	reset_control_deassert(mrst->port);
>  	reset_control_deassert(mrst->apb);
>  	udelay(PCIE_RESET_DELAY);
> +
> +	return 0;
>  }
>  
>  static inline struct clk *meson_pcie_probe_clock(struct device *dev,
> @@ -250,9 +286,11 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
>  	if (IS_ERR(res->port_clk))
>  		return PTR_ERR(res->port_clk);
>  
> -	res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> -	if (IS_ERR(res->mipi_gate))
> -		return PTR_ERR(res->mipi_gate);
> +	if (!mp->param->has_shared_phy) {
> +		res->mipi_gate = meson_pcie_probe_clock(dev, "mipi", 0);
> +		if (IS_ERR(res->mipi_gate))
> +			return PTR_ERR(res->mipi_gate);
> +	}
>  
>  	res->general_clk = meson_pcie_probe_clock(dev, "general", 0);
>  	if (IS_ERR(res->general_clk))
> @@ -524,6 +562,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
>  
>  static int meson_pcie_probe(struct platform_device *pdev)
>  {
> +	const struct meson_pcie_param *match_data;
>  	struct device *dev = &pdev->dev;
>  	struct dw_pcie *pci;
>  	struct meson_pcie *mp;
> @@ -537,6 +576,19 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	pci->dev = dev;
>  	pci->ops = &dw_pcie_ops;
>  
> +	match_data = of_device_get_match_data(dev);
> +	if (!match_data) {
> +		dev_err(dev, "failed to get match data\n");
> +		return -ENODEV;
> +	}
> +	mp->param = match_data;
> +
> +	if (mp->param->has_shared_phy) {
> +		mp->phy = devm_phy_get(dev, "pcie");
> +		if (IS_ERR(mp->phy))
> +			return PTR_ERR(mp->phy);
> +	}
> +
>  	mp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(mp->reset_gpio)) {
>  		dev_err(dev, "get reset gpio failed\n");
> @@ -555,13 +607,22 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	meson_pcie_power_on(mp);
> -	meson_pcie_reset(mp);
> +	ret = meson_pcie_power_on(mp);
> +	if (ret) {
> +		dev_err(dev, "phy power on failed, %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = meson_pcie_reset(mp);
> +	if (ret) {
> +		dev_err(dev, "reset failed, %d\n", ret);
> +		goto err_phy;
> +	}
>  
>  	ret = meson_pcie_probe_clocks(mp);
>  	if (ret) {
>  		dev_err(dev, "init clock resources failed, %d\n", ret);
> -		return ret;
> +		goto err_phy;
>  	}
>  
>  	platform_set_drvdata(pdev, mp);
> @@ -569,15 +630,36 @@ static int meson_pcie_probe(struct platform_device *pdev)
>  	ret = meson_add_pcie_port(mp, pdev);
>  	if (ret < 0) {
>  		dev_err(dev, "Add PCIe port failed, %d\n", ret);
> -		return ret;
> +		goto err_phy;
>  	}
>  
>  	return 0;
> +
> +err_phy:
> +	if (mp->param->has_shared_phy) {
> +		phy_power_off(mp->phy);
> +		phy_exit(mp->phy);
> +	}

Interestingly for AXG, if the probe fails we don't seem to do the opposite
of MESON_PCIE_PHY_POWERUP. Though I can see this is a pre-existing issue that
has little impact and probably rarely gets hit, so:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>

However it would be *super really nice* to write a meson_pcie_power_off that
mirrors meson_pcie_power_on that you could call here instead.

Thanks,

Andrew Murray 

> +
> +	return ret;
>  }
>  
> +static struct meson_pcie_param meson_pcie_axg_param = {
> +	.has_shared_phy = false,
> +};
> +
> +static struct meson_pcie_param meson_pcie_g12a_param = {
> +	.has_shared_phy = true,
> +};
> +
>  static const struct of_device_id meson_pcie_of_match[] = {
>  	{
>  		.compatible = "amlogic,axg-pcie",
> +		.data = &meson_pcie_axg_param,
> +	},
> +	{
> +		.compatible = "amlogic,g12a-pcie",
> +		.data = &meson_pcie_g12a_param,
>  	},
>  	{},
>  };
> -- 
> 2.22.0
> 
