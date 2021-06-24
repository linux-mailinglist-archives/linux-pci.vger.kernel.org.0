Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEC13B24CD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhFXCSU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 22:18:20 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:49506 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXCSU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 22:18:20 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jun 2021 22:18:19 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 96C05952;
        Thu, 24 Jun 2021 10:08:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [192.168.31.83] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P30156T139873822422784S1624500535775272_;
        Thu, 24 Jun 2021 10:08:57 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f132f8cb1721e988cfef0819e2f2ee60>
X-RL-SENDER: xxm@rock-chips.com
X-SENDER: xxm@rock-chips.com
X-LOGIN-NAME: xxm@rock-chips.com
X-FST-TO: shawn.lin@rock-chips.com
X-RCPT-COUNT: 13
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v9 2/2] PCI: rockchip: Add Rockchip RK356X host controller
 driver
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, pali@kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Johan Jonker <jbx6244@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        kernel test robot <lkp@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20210506023448.169146-1-xxm@rock-chips.com>
 <20210506023544.169196-1-xxm@rock-chips.com>
 <20210623143333.GA15104@lpieralisi>
From:   xxm <xxm@rock-chips.com>
Message-ID: <46b3f277-2bde-321d-b616-3f3b41259e4d@rock-chips.com>
Date:   Thu, 24 Jun 2021 10:08:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210623143333.GA15104@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi，

在 2021/6/23 22:33, Lorenzo Pieralisi 写道:
> [+Pali]
>
> On Thu, May 06, 2021 at 10:35:44AM +0800, Simon Xue wrote:
>> Add a driver for the DesignWare-based PCIe controller found on
>> RK356X. The existing pcie-rockchip-host driver is only used for
>> the Rockchip-designed IP found on RK3399.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com>
>> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> I will remove this tag - it does not make sense on a patch adding
> a new driver.
>
> [...]
>
>> +static int rockchip_pcie_start_link(struct dw_pcie *pci)
>> +{
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +
>> +	/* Reset device */
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
>> +
>> +	rockchip_pcie_enable_ltssm(rockchip);
>> +
>> +	/*
>> +	 * PCIe requires the refclk to be stable for 100µs prior to releasing
>> +	 * PERST. See table 2-4 in section 2.6.2 AC Specifications of the PCI
>> +	 * Express Card Electromechanical Specification, 1.1. However, we don't
>> +	 * know if the refclk is coming from RC's PHY or external OSC. If it's
>> +	 * from RC, so enabling LTSSM is the just right place to release #PERST.
>> +	 * We need more extra time as before, rather than setting just
>> +	 * 100us as we don't know how long should the device need to reset.
>> +	 */
>> +	msleep(100);
> Any rationale behind the time chosen ?
We found some device need about 30ms, so 100ms here just leave more room 
for other devices.
> Ongoing discussion:
>
> https://lore.kernel.org/linux-pci/20210531090540.2663171-1-luca@lucaceresoli.net
>
> Lorenzo
>
>> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_host_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
>> +	u32 val;
>> +
>> +	/* LTSSM enable control mode */
>> +	val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
>> +	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
>> +	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
>> +
>> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
>> +				 PCIE_CLIENT_GENERAL_CONTROL);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
>> +	.host_init = rockchip_pcie_host_init,
>> +};
>> +
>> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->pci.dev;
>> +	int ret;
>> +
>> +	ret = devm_clk_bulk_get_all(dev, &rockchip->clks);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	rockchip->clk_cnt = ret;
>> +
>> +	return clk_bulk_prepare_enable(rockchip->clk_cnt, rockchip->clks);
>> +}
>> +
>> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
>> +				      struct rockchip_pcie *rockchip)
>> +{
>> +	rockchip->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
>> +	if (IS_ERR(rockchip->apb_base))
>> +		return PTR_ERR(rockchip->apb_base);
>> +
>> +	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
>> +						     GPIOD_OUT_HIGH);
>> +	if (IS_ERR(rockchip->rst_gpio))
>> +		return PTR_ERR(rockchip->rst_gpio);
>> +
>> +	return 0;
>> +}
>> +
>> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->pci.dev;
>> +	int ret;
>> +
>> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
>> +	if (IS_ERR(rockchip->phy))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->phy),
>> +				     "missing PHY\n");
>> +
>> +	ret = phy_init(rockchip->phy);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = phy_power_on(rockchip->phy);
>> +	if (ret)
>> +		phy_exit(rockchip->phy);
>> +
>> +	return ret;
>> +}
>> +
>> +static void rockchip_pcie_phy_deinit(struct rockchip_pcie *rockchip)
>> +{
>> +	phy_exit(rockchip->phy);
>> +	phy_power_off(rockchip->phy);
>> +}
>> +
>> +static int rockchip_pcie_reset_control_release(struct rockchip_pcie *rockchip)
>> +{
>> +	struct device *dev = rockchip->pci.dev;
>> +
>> +	rockchip->rst = devm_reset_control_array_get_exclusive(dev);
>> +	if (IS_ERR(rockchip->rst))
>> +		return dev_err_probe(dev, PTR_ERR(rockchip->rst),
>> +				     "failed to get reset lines\n");
>> +
>> +	return reset_control_deassert(rockchip->rst);
>> +}
>> +
>> +static const struct dw_pcie_ops dw_pcie_ops = {
>> +	.link_up = rockchip_pcie_link_up,
>> +	.start_link = rockchip_pcie_start_link,
>> +};
>> +
>> +static int rockchip_pcie_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct rockchip_pcie *rockchip;
>> +	struct pcie_port *pp;
>> +	int ret;
>> +
>> +	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
>> +	if (!rockchip)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, rockchip);
>> +
>> +	rockchip->pci.dev = dev;
>> +	rockchip->pci.ops = &dw_pcie_ops;
>> +
>> +	pp = &rockchip->pci.pp;
>> +	pp->ops = &rockchip_pcie_host_ops;
>> +
>> +	ret = rockchip_pcie_resource_get(pdev, rockchip);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* DON'T MOVE ME: must be enable before PHY init */
>> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
>> +	if (IS_ERR(rockchip->vpcie3v3))
>> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
>> +			return dev_err_probe(dev, PTR_ERR(rockchip->vpcie3v3),
>> +					"failed to get vpcie3v3 regulator\n");
>> +
>> +	ret = regulator_enable(rockchip->vpcie3v3);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable vpcie3v3 regulator\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = rockchip_pcie_phy_init(rockchip);
>> +	if (ret)
>> +		goto disable_regulator;
>> +
>> +	ret = rockchip_pcie_reset_control_release(rockchip);
>> +	if (ret)
>> +		goto deinit_phy;
>> +
>> +	ret = rockchip_pcie_clk_init(rockchip);
>> +	if (ret)
>> +		goto deinit_phy;
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	clk_bulk_disable_unprepare(rockchip->clk_cnt, rockchip->clks);
>> +deinit_phy:
>> +	rockchip_pcie_phy_deinit(rockchip);
>> +disable_regulator:
>> +	regulator_disable(rockchip->vpcie3v3);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct of_device_id rockchip_pcie_of_match[] = {
>> +	{ .compatible = "rockchip,rk3568-pcie", },
>> +	{},
>> +};
>> +
>> +static struct platform_driver rockchip_pcie_driver = {
>> +	.driver = {
>> +		.name	= "rockchip-dw-pcie",
>> +		.of_match_table = rockchip_pcie_of_match,
>> +		.suppress_bind_attrs = true,
>> +	},
>> +	.probe = rockchip_pcie_probe,
>> +};
>> +builtin_platform_driver(rockchip_pcie_driver);
>> -- 
>> 2.25.1
>>
>>
>>
>
>


