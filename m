Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38C3B1C96
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFWOf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:35:58 -0400
Received: from foss.arm.com ([217.140.110.172]:36436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhFWOf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 10:35:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C4B6ED1;
        Wed, 23 Jun 2021 07:33:40 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DED2B3F718;
        Wed, 23 Jun 2021 07:33:38 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:33:33 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Simon Xue <xxm@rock-chips.com>, pali@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel test robot <lkp@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v9 2/2] PCI: rockchip: Add Rockchip RK356X host
 controller driver
Message-ID: <20210623143333.GA15104@lpieralisi>
References: <20210506023448.169146-1-xxm@rock-chips.com>
 <20210506023544.169196-1-xxm@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506023544.169196-1-xxm@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Pali]

On Thu, May 06, 2021 at 10:35:44AM +0800, Simon Xue wrote:
> Add a driver for the DesignWare-based PCIe controller found on
> RK356X. The existing pcie-rockchip-host driver is only used for
> the Rockchip-designed IP found on RK3399.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Reported-by: kernel test robot <lkp@intel.com>

I will remove this tag - it does not make sense on a patch adding
a new driver.

[...]

> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	/* Reset device */
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +
> +	rockchip_pcie_enable_ltssm(rockchip);
> +
> +	/*
> +	 * PCIe requires the refclk to be stable for 100�s prior to releasing
> +	 * PERST. See table 2-4 in section 2.6.2 AC Specifications of the PCI
> +	 * Express Card Electromechanical Specification, 1.1. However, we don't
> +	 * know if the refclk is coming from RC's PHY or external OSC. If it's
> +	 * from RC, so enabling LTSSM is the just right place to release #PERST.
> +	 * We need more extra time as before, rather than setting just
> +	 * 100us as we don't know how long should the device need to reset.
> +	 */
> +	msleep(100);

Any rationale behind the time chosen ?

Ongoing discussion:

https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net

Lorenzo

> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 val;
> +
> +	/* LTSSM enable control mode */
> +	val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
> +	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> +
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
> +				 PCIE_CLIENT_GENERAL_CONTROL);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> +	.host_init = rockchip_pcie_host_init,
> +};
> +
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
> +	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
> +}
> +
> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
> +				      struct rockchip_pcie *rockchip)
> +{
> +	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(rockchip->apb_base))
> +		return PTR_ERR(rockchip->apb_base);
> +
> +	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +	if (IS_ERR(rockchip->rst_gpio))
> +		return PTR_ERR(rockchip->rst_gpio);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci.dev;
> +	int ret;
> +
> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
> +				     "missing PHY\n");
> +
> +	ret = phy_init(rockchip->phy);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = phy_power_on(rockchip->phy);
> +	if (ret)
> +		phy_exit(rockchip->phy);
> +
> +	return ret;
> +}
> +
> +static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
> +{
> +	phy_exit(rockchip->phy);
> +	phy_power_off(rockchip->phy);
> +}
> +
> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci.dev;
> +
> +	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
> +	if (IS_ERR(rockchip->rst))
> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
> +				     "failed to get reset lines\n");
> +
> +	return reset_control_deassert(rockchip->rst);
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.link_up = rockchip_pcie_link_up,
> +	.start_link = rockchip_pcie_start_link,
> +};
> +
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
> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
> +					"failed to get vpcie3v3 regulator\n");
> +
> +	ret = regulator_enable(rockchip->vpcie3v3);
> +	if (ret) {
> +		dev_err(dev, "failed to enable vpcie3v3 regulator\n");
> +		return ret;
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
> +	if (!ret)
> +		return 0;
> +
> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
> +deinit_phy:
> +	rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +	regulator_disable(rockchip->vpcie3v3);
> +
> +	return ret;
> +}
> +
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
> +builtin_platform_driver(rockchip_pcie_driver);
> -- 
> 2.25.1
> 
> 
> 
