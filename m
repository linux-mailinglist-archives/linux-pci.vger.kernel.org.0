Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE3347D7E
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 17:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbhCXQRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 12:17:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234669AbhCXQRX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 12:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A986561878;
        Wed, 24 Mar 2021 16:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616602643;
        bh=ZfQfwnRrFQEw2lg7pL8kZK71afKfEVHk9YK12q8Pq3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kxNts/LJiaGY+S8UMeWsggEZzqhmutWnW+fnYJm8J0IqzPZ5BGa2uls2tEug/CP+R
         6uoIPuXbU+RT6OAeDWcdTHzlTSUjS5y2Mbu7y8muKCxqTVw0PnUkUUYE18LOj+CXps
         lxn9O7KHZ9AH2rnw66qDYAXe0kBVQntM8l8HhVhhjFHWcFFhUchOPVSBe1JwvsLz+g
         ezaM2rf0+ADcukvne72BHyOUPgY3QNFemXPVEmsBbPVXLRgPz/ERxu3UUfbk+2fkoO
         UI2Yxgfg7om8D6C+eKPKJnX7Ok8WtFt1SS7dPKB6L0BiAq28k4p1skrhlRKS9H6JOU
         Nq7Xois4VF8kg==
Date:   Wed, 24 Mar 2021 11:17:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Simon Xue <xxm@rock-chips.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v5 2/2] PCI: rockchip: Add DesignWare based PCIe
 controller
Message-ID: <20210324161721.GA612661@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222071828.30120-1-xxm@rock-chips.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 22, 2021 at 03:18:28PM +0800, Simon Xue wrote:
> Add driver for DesignWare based PCIe controller found on RK356X.
> The already existed driver pcie-rockchip-host is only used for
> Rockchip designed IP found on RK3399.

> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	/* Reset device */
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	msleep(100);

Maybe a spec reference for the 100ms delay so we can match this up
with other places and make sure we aren't repeating delays because we
don't know what they are?

> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +	rockchip_pcie_enable_ltssm(rockchip);
> +
> +	return 0;
> +}

> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci.dev;
> +	int ret;
> +
> +	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	rockchip->clk_cnt = ret;
> +
> +	ret = clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

This is the same as

  return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);

> +}

> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci.dev;
> +	int ret;
> +
> +	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(rockchip->rst))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +				     "failed to get reset lines\n");
> +
> +	ret = reset_control_deassert(rockchip->rst);
> +
> +	return ret;

  return reset_control_deassert(rockchip->rst);

and drop "ret".

> +}

> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie *rockchip;
> +	struct pcie_port *pp;
> +	int ret;
> +
> +	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
> +	if (!rockchip)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, rockchip);
> +
> +	rockchip->pci.dev = dev;
> +	rockchip->pci.ops = &dw_pcie_ops;
> +
> +	pp = &rockchip->pci.pp;
> +	pp->ops = &rockchip_pcie_host_ops;
> +
> +	ret = rockchip_pcie_resource_get(pdev, rockchip);
> +	if (ret)
> +		return ret;
> +
> +	/* DON'T MOVE ME: must be enable before PHY init */
> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(rockchip->vpcie3v3))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +				     "failed to get vpcie3v3 regulator\n");
> +
> +	if (rockchip->vpcie3v3) {

This assumes devm_regulator_get_optional() returns a valid regulator,
IS_ERR, or NULL.  I can't easily tell whether it can actually return
NULL.  The regulator_get_optional() comment says it returns either a
regulator or IS_ERR; it doesn't mention NULL.

The other callers in drivers/pci (imx6_pcie_probe(),
histb_pcie_probe(), tegra_pcie_get_slot_regulators()) all explicitly
set the result to NULL in case of error.  They should all do it the
same way.

> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret) {
> +			dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> +			return ret;
> +		}
> +	}
> +
> +	ret = rockchip_pcie_phy_init(rockchip);
> +	if (ret)
> +		goto disable_regulator;
> +
> +	ret = rockchip_pcie_reset_control_release(rockchip);
> +	if (ret)
> +		goto deinit_phy;
> +
> +	ret = rockchip_pcie_clk_init(rockchip);
> +	if (ret)
> +		goto deinit_phy;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret)
> +		goto deinit_clk;
> +
> +	return 0;
> +
> +deinit_clk:
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +deinit_phy:
> +	rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +	if (rockchip->vpcie3v3)
> +		regulator_disable(rockchip->vpcie3v3);
> +
> +	return ret;
> +}
> +
> +MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);

I don't think this is necessary, is it?  I don't see MODULE_DEVICE_TABLE
being used except for modular drivers.

There are a couple other builtin drivers (mobiveil, microchip) that
use it, but I think those are mistakes.

> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +	{ .compatible = "rockchip,rk3568-pcie", },
> +	{},
> +};
> +
> +static struct platform_driver rockchip_pcie_driver = {
> +	.driver = {
> +		.name	= "rockchip-dw-pcie",
> +		.of_match_table = rockchip_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = rockchip_pcie_probe,
> +};
> +

Drop the blank line.

> +builtin_platform_driver(rockchip_pcie_driver);
