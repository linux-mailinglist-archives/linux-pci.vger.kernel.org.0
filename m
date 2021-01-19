Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67D42FC0FE
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391966AbhASU27 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 15:28:59 -0500
Received: from foss.arm.com ([217.140.110.172]:49382 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391943AbhASU2w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 15:28:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77BA7D6E;
        Tue, 19 Jan 2021 12:28:04 -0800 (PST)
Received: from [10.57.39.58] (unknown [10.57.39.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CF0C3F719;
        Tue, 19 Jan 2021 12:28:03 -0800 (PST)
Subject: Re: [PATCH 3/3] PCI: rockchip: add DesignWare based PCIe controller
To:     Simon Xue <xxm@rock-chips.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-rockchip@lists.infradead.org
References: <20210118091739.247040-1-xxm@rock-chips.com>
 <20210118091739.247040-3-xxm@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <70e62c12-807b-e673-6ae9-85699f5b3eb4@arm.com>
Date:   Tue, 19 Jan 2021 20:28:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118091739.247040-3-xxm@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021-01-18 09:17, Simon Xue wrote:
> pcie-dw-rockchip is based on DWC IP. But pcie-rockchip-host
> is another IP which is only used for RK3399. So all the following
> non-RK3399 SoCs should use this driver.
> 
> Signed-off-by: Simon Xue <xxm@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>   drivers/pci/controller/Kconfig                |   4 +-
>   drivers/pci/controller/dwc/Kconfig            |   9 +
>   drivers/pci/controller/dwc/Makefile           |   1 +
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 454 ++++++++++++++++++
>   4 files changed, 466 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..48a7d62f97f3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -219,7 +219,7 @@ config PCIE_ROCKCHIP_HOST
>   	help
>   	  Say Y here if you want internal PCI support on Rockchip SoC.
>   	  There is 1 internal PCIe port available to support GEN2 with
> -	  4 slots.
> +	  4 slots. Only for RK3399.
>   
>   config PCIE_ROCKCHIP_EP
>   	bool "Rockchip PCIe endpoint controller"
> @@ -231,7 +231,7 @@ config PCIE_ROCKCHIP_EP
>   	help
>   	  Say Y here if you want to support Rockchip PCIe controller in
>   	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
> -	  available to support GEN2 with 4 slots.
> +	  available to support GEN2 with 4 slots. Only for RK3399.
>   
>   config PCIE_MEDIATEK
>   	tristate "MediaTek PCIe controller"
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 22c5529e9a65..110733d0c241 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -214,6 +214,15 @@ config PCIE_ARTPEC6_EP
>   	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>   	  endpoint mode. This uses the DesignWare core.
>   
> +config PCIE_DW_ROCKCHIP_HOST
> +	bool "Rockchip DesignWare PCIe controller"
> +	select PCIE_DW
> +	select PCIE_DW_HOST
> +	depends on ARCH_ROCKCHIP
> +	depends on OF
> +	help
> +	  Enables support for the DW PCIe controller in the Rockchip SoC.
> +
>   config PCIE_INTEL_GW
>   	bool "Intel Gateway PCIe host controller support"
>   	depends on OF && (X86 || COMPILE_TEST)
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a751553fa0db..9c7048d2be17 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>   obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>   obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>   obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> +obj-$(CONFIG_PCIE_DW_ROCKCHIP_HOST) += pcie-dw-rockchip.o
>   obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>   obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>   obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> new file mode 100644
> index 000000000000..5997fbc675d3
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -0,0 +1,454 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Rockchip SoCs
> + *
> + * Copyright (C) 2021 Rockchip Electronics Co., Ltd.
> + *		http://www.rock-chips.com
> + *
> + * Author: Simon Xue <xxm@rock-chips.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>

I believe you're meant to include linux/gpio/consumer.h rather than any 
other GPIO-related header.

> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-designware.h"
> +
> +/*
> + * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
> + * mask for the lower 16 bits.  This allows atomic updates
> + * of the register without locking.
> + */
> +#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
> +#define HIWORD_UPDATE_BIT(val)	HIWORD_UPDATE(val, val)
> +
> +#define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
> +
> +#define PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
> +#define PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
> +#define PCIE_SMLH_LINKUP		BIT(16)
> +#define PCIE_RDLH_LINKUP		BIT(17)
> +#define PCIE_L0S_ENTRY			0x11
> +#define PCIE_CLIENT_GENERAL_CONTROL	0x0
> +#define PCIE_CLIENT_GENERAL_DEBUG	0x104
> +#define PCIE_CLIENT_HOT_RESET_CTRL      0x180
> +#define PCIE_CLIENT_LTSSM_STATUS	0x300
> +#define PCIE_CLIENT_DBG_FIFO_MODE_CON	0x310
> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0 0x320
> +#define PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1 0x324
> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0 0x328
> +#define PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1 0x32c
> +#define PCIE_CLIENT_DBG_FIFO_STATUS	0x350
> +#define PCIE_CLIENT_DBG_TRANSITION_DATA	0xffff0000
> +#define PCIE_CLIENT_DBF_EN		0xffff0003
> +#define PCIE_LTSSM_ENABLE_ENHANCE       BIT(4)
> +
> +struct reset_bulk_data	{
> +	const char *id;
> +	struct reset_control *rst;
> +};
> +
> +struct rockchip_pcie {
> +	struct dw_pcie			*pci;
> +	void __iomem			*dbi_base;
> +	void __iomem			*apb_base;
> +	struct phy			*phy;
> +	struct clk_bulk_data		*clks;
> +	unsigned int			clk_cnt;
> +	struct reset_bulk_data		*rsts;
> +	struct gpio_desc		*rst_gpio;
> +	struct pcie_port		pp;
> +	struct regulator                *vpcie3v3;
> +};
> +
> +static inline int rockchip_pcie_readl_apb(struct rockchip_pcie *rockchip,
> +					  u32 reg)
> +{
> +	return readl(rockchip->apb_base + reg);
> +}
> +
> +static inline void rockchip_pcie_writel_apb(struct rockchip_pcie *rockchip,
> +					    u32 reg, u32 val)
> +{
> +	writel(val, rockchip->apb_base + reg);
> +}
> +
> +static inline void rockchip_pcie_set_mode(struct rockchip_pcie *rockchip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
> +				 PCIE_CLIENT_RC_MODE);
> +}
> +
> +static inline void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_GENERAL_CONTROL,
> +				 PCIE_CLIENT_ENABLE_LTSSM);
> +}
> +
> +static int rockchip_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
> +
> +	if ((val & (PCIE_RDLH_LINKUP | PCIE_SMLH_LINKUP)) == 0x30000 &&
> +	    (val & GENMASK(5, 0)) == PCIE_L0S_ENTRY)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void rockchip_pcie_establish_link(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	if (dw_pcie_link_up(pci)) {
> +		dev_err(pci->dev, "link already up\n");
> +		return;
> +	}
> +
> +	/* Reset device */
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 0);
> +	msleep(100);
> +	gpiod_set_value_cansleep(rockchip->rst_gpio, 1);
> +
> +	rockchip_pcie_enable_ltssm(rockchip);
> +}
> +
> +static void rockchip_pcie_enable_debug(struct rockchip_pcie *rockchip)
> +{
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D0,
> +			   PCIE_CLIENT_DBG_TRANSITION_DATA);
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_PTN_HIT_D1,
> +			   PCIE_CLIENT_DBG_TRANSITION_DATA);
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D0,
> +			   PCIE_CLIENT_DBG_TRANSITION_DATA);
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_TRN_HIT_D1,
> +			   PCIE_CLIENT_DBG_TRANSITION_DATA);
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_DBG_FIFO_MODE_CON,
> +			   PCIE_CLIENT_DBF_EN);
> +}
> +
> +static void rockchip_pcie_debug_dump(struct rockchip_pcie *rockchip)
> +{
> +	u32 loop;
> +	struct dw_pcie *pci = rockchip->pci;
> +
> +	dev_dbg(pci->dev, "ltssm = 0x%x\n",
> +		 rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS));
> +	for (loop = 0; loop < 64; loop++)
> +		dev_dbg(pci->dev, "fifo_status = 0x%x\n",
> +			 rockchip_pcie_readl_apb(rockchip,
> +						 PCIE_CLIENT_DBG_FIFO_STATUS));
> +}
> +
> +static int rockchip_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	dw_pcie_setup_rc(pp);
> +
> +	rockchip_pcie_enable_debug(rockchip);
> +
> +	rockchip_pcie_establish_link(pci);
> +	dw_pcie_wait_for_link(pci);
> +
> +	rockchip_pcie_debug_dump(rockchip);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
> +	.host_init = rockchip_pcie_host_init,
> +};
> +
> +static int rockchip_add_pcie_port(struct rockchip_pcie *rockchip)
> +{
> +	int ret;
> +	struct dw_pcie *pci = rockchip->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = pci->dev;
> +
> +	pp->ops = &rockchip_pcie_host_ops;
> +
> +	if (device_property_read_bool(dev, "msi-map"))
> +		pp->msi_ext = 1;

As per patch #1, I don't think this is necessary.

> +
> +	rockchip_pcie_set_mode(rockchip);
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static void rockchip_pcie_clk_deinit(struct rockchip_pcie *rockchip)
> +{
> +	clk_bulk_disable(rockchip->clk_cnt, rockchip->clks);
> +	clk_bulk_unprepare(rockchip->clk_cnt, rockchip->clks);

There's a clk_bulk_disable_unprepare() helper, you know ;)

> +}
> +
> +static int rockchip_pcie_clk_init(struct rockchip_pcie *rockchip)
> +{
> +	struct device *dev = rockchip->pci->dev;
> +	struct property *prop;
> +	const char *name;
> +	int i = 0, ret, count;
> +
> +	count = of_property_count_strings(dev->of_node, "clock-names");
> +	if (count < 1)
> +		return -ENODEV;
> +
> +	rockchip->clks = devm_kcalloc(dev, count,
> +				     sizeof(struct clk_bulk_data),
> +				     GFP_KERNEL);
> +	if (!rockchip->clks)
> +		return -ENOMEM;
> +
> +	rockchip->clk_cnt = count;
> +
> +	of_property_for_each_string(dev->of_node, "clock-names",
> +				    prop, name) {
> +		rockchip->clks[i].id = name;
> +		if (!rockchip->clks[i].id)
> +			return -ENOMEM;
> +		i++;
> +	}

of_clk_bulk_get_all() has existed for a while; no need to open-code it.

> +
> +	ret = devm_clk_bulk_get(dev, count, rockchip->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_prepare(count, rockchip->clks);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_bulk_enable(count, rockchip->clks);
> +	if (ret) {
> +		clk_bulk_unprepare(count, rockchip->clks);
> +		return ret;
> +	}

Similarly, clk_bulk_prepare_enable() also exists.

> +	return 0;
> +}
> +
> +static int rockchip_pcie_resource_get(struct platform_device *pdev,
> +				      struct rockchip_pcie *rockchip)
> +{
> +	struct resource *dbi_base;
> +	struct resource *apb_base;
> +
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"pcie-dbi");
> +	if (!dbi_base)
> +		return -ENODEV;
> +
> +	rockchip->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
> +	if (IS_ERR(rockchip->dbi_base))
> +		return PTR_ERR(rockchip->dbi_base);

It still has a ridiculously impractical name that I detest, but if I 
don't mention devm_platform_ioremap_resource_byname() I'm sure somebody 
else would come along and suggest it.

> +	rockchip->pci->dbi_base = rockchip->dbi_base;
> +
> +	apb_base = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						"pcie-apb");
> +	if (!apb_base)
> +		return -ENODEV;
> +
> +	rockchip->apb_base = devm_ioremap_resource(&pdev->dev, apb_base);
> +	if (IS_ERR(rockchip->apb_base))
> +		return PTR_ERR(rockchip->apb_base);
> +
> +	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(rockchip->rst_gpio))
> +		return PTR_ERR(rockchip->rst_gpio);
> +
> +	return 0;
> +}
> +
> +static int rockchip_pcie_phy_init(struct rockchip_pcie *rockchip)
> +{
> +	int ret;
> +	struct device *dev = rockchip->pci->dev;
> +
> +	rockchip->phy = devm_phy_get(dev, "pcie-phy");
> +	if (IS_ERR(rockchip->phy)) {
> +		if (PTR_ERR(rockchip->phy) != -EPROBE_DEFER)
> +			dev_info(dev, "missing phy\n");
> +		return PTR_ERR(rockchip->phy);

Use dev_err_probe() for this pattern now.

> +	}
> +
> +	ret = phy_init(rockchip->phy);
> +	if (ret < 0)
> +		return ret;
> +
> +	phy_power_on(rockchip->phy);
> +
> +	return 0;
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
> +	struct device *dev = rockchip->pci->dev;
> +	struct property *prop;
> +	const char *name;
> +	int ret, count, i = 0;
> +
> +	count = of_property_count_strings(dev->of_node, "reset-names");
> +	if (count < 1)
> +		return -ENODEV;
> +
> +	rockchip->rsts = devm_kcalloc(dev, count,
> +				     sizeof(struct reset_bulk_data),
> +				     GFP_KERNEL);
> +	if (!rockchip->rsts)
> +		return -ENOMEM;
> +
> +	of_property_for_each_string(dev->of_node, "reset-names",
> +				    prop, name) {
> +		rockchip->rsts[i].id = name;
> +		if (!rockchip->rsts[i].id)
> +			return -ENOMEM;
> +		i++;
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		rockchip->rsts[i].rst = devm_reset_control_get_exclusive(dev,
> +						rockchip->rsts[i].id);
> +		if (IS_ERR(rockchip->rsts[i].rst)) {
> +			dev_err(dev, "failed to get %s\n",
> +				rockchip->clks[i].id);
> +			return PTR_ERR(rockchip->rsts[i].rst);
> +		}
> +	}
> +
> +	for (i = 0; i < count; i++) {
> +		ret = reset_control_deassert(rockchip->rsts[i].rst);
> +		if (ret) {
> +			dev_err(dev, "failed to release %s\n",
> +				rockchip->rsts[i].id);
> +			return ret;
> +		}
> +	}

Does the hardware require that the resets are deasserted in the specific 
order of "whatever happens to be in the DT", or could you do this much 
more simply with the reset_control_array APIs?

Robin.

> +
> +	return 0;
> +}
> +
> +static void rockchip_pcie_fast_link_setup(struct rockchip_pcie *rockchip)
> +{
> +	u32 val;
> +
> +	/* LTSSM EN ctrl mode */
> +	val = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL);
> +	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_HOT_RESET_CTRL, val);
> +}
> +
> +
> +static const struct of_device_id rockchip_pcie_of_match[] = {
> +	{ .compatible = "rockchip,rk3568-pcie", },
> +	{ /* sentinel */ },
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.link_up = rockchip_pcie_link_up,
> +};
> +
> +static int rockchip_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_pcie *rockchip;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	rockchip = devm_kzalloc(dev, sizeof(*rockchip), GFP_KERNEL);
> +	if (!rockchip)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +
> +	rockchip->pci = pci;
> +
> +	ret = rockchip_pcie_resource_get(pdev, rockchip);
> +	if (ret)
> +		return ret;
> +
> +	/* DON'T MOVE ME: must be enable before phy init */
> +	rockchip->vpcie3v3 = devm_regulator_get_optional(dev, "vpcie3v3");
> +	if (IS_ERR(rockchip->vpcie3v3)) {
> +		if (PTR_ERR(rockchip->vpcie3v3) != -ENODEV)
> +			return PTR_ERR(rockchip->vpcie3v3);
> +		dev_info(dev, "no vpcie3v3 regulator found\n");
> +	}
> +
> +	if (!IS_ERR(rockchip->vpcie3v3)) {
> +		ret = regulator_enable(rockchip->vpcie3v3);
> +		if (ret) {
> +			dev_err(pci->dev, "fail to enable vpcie3v3 regulator\n");
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
> +	rockchip_pcie_fast_link_setup(rockchip);
> +
> +	platform_set_drvdata(pdev, rockchip);
> +
> +	ret = rockchip_add_pcie_port(rockchip);
> +	if (ret)
> +		goto deinit_clk;
> +
> +	return 0;
> +
> +deinit_clk:
> +	rockchip_pcie_clk_deinit(rockchip);
> +deinit_phy:
> +	rockchip_pcie_phy_deinit(rockchip);
> +disable_regulator:
> +	if (!IS_ERR(rockchip->vpcie3v3))
> +		regulator_disable(rockchip->vpcie3v3);
> +
> +	return ret;
> +}
> +
> +MODULE_DEVICE_TABLE(of, rockchip_pcie_of_match);
> +
> +static struct platform_driver rockchip_pcie_driver = {
> +	.driver = {
> +		.name	= "rk-pcie",
> +		.of_match_table = rockchip_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe = rockchip_pcie_probe,
> +};
> +
> +builtin_platform_driver(rockchip_pcie_driver);
> 
