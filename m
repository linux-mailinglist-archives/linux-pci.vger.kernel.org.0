Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F21E122E8B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 15:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfLQOXT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 09:23:19 -0500
Received: from foss.arm.com ([217.140.110.172]:38682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfLQOXT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 09:23:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B47681FB;
        Tue, 17 Dec 2019 06:23:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 033D53F719;
        Tue, 17 Dec 2019 06:23:16 -0800 (PST)
Date:   Tue, 17 Dec 2019 14:23:15 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 11/13] PCI: j721e: Add TI J721E PCIe driver
Message-ID: <20191217142314.GA8074@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-12-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-12-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:45PM +0530, Kishon Vijay Abraham I wrote:
> Add support for PCIe controller in J721E SoC. The controller uses the
> Cadence PCIe core programmed by pcie-cadence*.c. The PCIe controller
> will work in both host mode and device mode.
> Some of the features of the controller are:
>   *) Supports both RC mode and EP mode
>   *) Supports MSI and MSI-X support
>   *) Supports upto GEN3 speed mode
>   *) Supports SR-IOV capability
>   *) Ability to route all transactions via SMMU (support will be added
>      in a later patch).
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/Kconfig     |  23 ++
>  drivers/pci/controller/cadence/Makefile    |   1 +
>  drivers/pci/controller/cadence/pci-j721e.c | 430 +++++++++++++++++++++
>  3 files changed, 454 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pci-j721e.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index b76b3cf55ce5..5d30564190e1 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,4 +42,27 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCI_J721E
> +	bool
> +
> +config PCI_J721E_HOST
> +	bool "TI J721E PCIe platform host controller"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCI_J721E
> +	help
> +	  Say Y here if you want to support the TI J721E PCIe platform
> +	  controller in host mode. TI J721E PCIe controller uses Cadence PCIe
> +	  core.
> +
> +config PCI_J721E_EP
> +	bool "TI J721E PCIe platform endpoint controller"
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE_EP
> +	select PCI_J721E
> +	help
> +	  Say Y here if you want to support the TI J721E PCIe platform
> +	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
> +	  core.
>  endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 232a3f20876a..9bac5fb2f13d 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -3,3 +3,4 @@ obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
> +obj-$(CONFIG_PCI_J721E) += pci-j721e.o

Why pci-j721e and not pcie-j721e? Especially given that many of the structures
in the file use pcie (e.g. j721e_pcie_ep_data)


> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> new file mode 100644
> index 000000000000..9ffb7e88c739
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -0,0 +1,430 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * pci-j721e - PCIe controller driver for TI's J721E SoCs
> + *
> + * Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + * Author: Kishon Vijay Abraham I <kishon@ti.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/io.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +
> +#include "../../pci.h"
> +#include "pcie-cadence.h"
> +
> +#define J721E_PCIE_USER_CMD_STATUS	0x4
> +#define LINK_TRAINING_ENABLE		BIT(0)
> +
> +#define J721E_PCIE_USER_LINKSTATUS	0x14
> +#define LINK_STATUS			GENMASK(1, 0)
> +
> +enum link_status {
> +	NO_RECIEVERS_DETECTED,
> +	LINK_TRAINING_IN_PROGRESS,
> +	LINK_UP_DL_IN_PROGRESS,
> +	LINK_UP_DL_COMPLETED,
> +};
> +
> +#define J721E_MODE_RC			BIT(7)
> +#define LANE_COUNT_MASK			BIT(8)
> +#define LANE_COUNT(n)			((n) << 8)
> +
> +#define GENERATION_SEL_MASK		GENMASK(1, 0)
> +
> +#define MAX_LANES			2
> +
> +struct j721e_pcie {
> +	struct device		*dev;
> +	struct device_node	*node;
> +	u32			mode;
> +	u32			num_lanes;
> +	struct cdns_pcie	*cdns_pcie;
> +	void __iomem		*user_cfg_base;
> +};
> +
> +enum j721e_pcie_mode {
> +	PCI_MODE_RC,
> +	PCI_MODE_EP,
> +};
> +
> +struct j721e_pcie_data {
> +	enum j721e_pcie_mode	mode;
> +};
> +
> +static inline u32 j721e_pcie_user_readl(struct j721e_pcie *pcie, u32 offset)
> +{
> +	return readl(pcie->user_cfg_base + offset);
> +}
> +
> +static inline void j721e_pcie_user_writel(struct j721e_pcie *pcie, u32 offset,
> +					  u32 value)
> +{
> +	writel(value, pcie->user_cfg_base + offset);
> +}
> +
> +static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie, bool start)
> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
> +	if (start)
> +		reg |= LINK_TRAINING_ENABLE;
> +	else
> +		reg &= ~LINK_TRAINING_ENABLE;
> +	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
> +
> +	return 0;
> +}
> +
> +static bool j721e_pcie_is_link_up(struct cdns_pcie *cdns_pcie)
> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_LINKSTATUS);
> +	reg &= LINK_STATUS;
> +	if (reg == LINK_UP_DL_COMPLETED)
> +		return true;
> +
> +	return false;
> +}
> +
> +static const struct cdns_pcie_ops j721e_ops_ops = {
> +	.read = cdns_pcie_read32,
> +	.write = cdns_pcie_write32,
> +	.start_link = j721e_pcie_start_link,
> +	.is_link_up = j721e_pcie_is_link_up,
> +};
> +
> +static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon)
> +{
> +	struct device *dev = pcie->dev;
> +	u32 mask = J721E_MODE_RC;
> +	u32 mode = pcie->mode;
> +	u32 val = 0;
> +	int ret = 0;
> +
> +	if (mode == PCI_MODE_RC)
> +		val = J721E_MODE_RC;
> +
> +	ret = regmap_update_bits(syscon, 0, mask, val);
> +	if (ret)
> +		dev_err(dev, "failed to set pcie mode\n");
> +
> +	return ret;
> +}
> +
> +static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
> +				     struct regmap *syscon)
> +{
> +	struct device *dev = pcie->dev;
> +	struct device_node *np = dev->of_node;
> +	int link_speed;
> +	u32 val = 0;
> +	int ret;
> +
> +	link_speed = of_pci_get_max_link_speed(np);
> +	if (link_speed < 2)
> +		link_speed = 2;
> +
> +	val = link_speed - 1;
> +	ret = regmap_update_bits(syscon, 0, GENERATION_SEL_MASK, val);
> +	if (ret)
> +		dev_err(dev, "failed to set link speed\n");
> +
> +	return ret;
> +}
> +
> +static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
> +				     struct regmap *syscon)
> +{
> +	struct device *dev = pcie->dev;
> +	u32 lanes = pcie->num_lanes;
> +	u32 val = 0;
> +	int ret;
> +
> +	val = LANE_COUNT(lanes - 1);
> +	ret = regmap_update_bits(syscon, 0, LANE_COUNT_MASK, val);
> +	if (ret)
> +		dev_err(dev, "failed to set link count\n");
> +
> +	return ret;
> +}
> +
> +static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct device_node *node = dev->of_node;
> +	struct regmap *syscon;
> +	int ret;
> +
> +	syscon = syscon_regmap_lookup_by_phandle(node, "ti,syscon-pcie-ctrl");
> +	if (IS_ERR(syscon)) {
> +		dev_err(dev, "Unable to get ti,syscon-pcie-ctrl regmap\n");
> +		return PTR_ERR(syscon);
> +	}
> +
> +	ret = j721e_pcie_set_mode(pcie, syscon);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set pci mode\n");
> +		return ret;
> +	}
> +
> +	ret = j721e_pcie_set_link_speed(pcie, syscon);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set link speed\n");
> +		return ret;
> +	}
> +
> +	ret = j721e_pcie_set_lane_count(pcie, syscon);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to set num-lanes\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 *value)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> +	unsigned int busn = bus->number;
> +
> +	if (busn == rc->bus_range->start)
> +		return pci_generic_config_read32(bus, devfn, where, size,
> +						 value);
> +
> +	return pci_generic_config_read(bus, devfn, where, size, value);
> +}
> +
> +static int cdns_ti_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				     int where, int size, u32 value)
> +{
> +	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
> +	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> +	unsigned int busn = bus->number;
> +
> +	if (busn == rc->bus_range->start)
> +		return pci_generic_config_write32(bus, devfn, where, size,
> +						  value);
> +
> +	return pci_generic_config_write(bus, devfn, where, size, value);
> +}
> +
> +static struct pci_ops cdns_ti_pcie_host_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= cdns_ti_pcie_config_read,
> +	.write		= cdns_ti_pcie_config_write,
> +};
> +
> +static const struct j721e_pcie_data j721e_pcie_rc_data = {
> +	.mode = PCI_MODE_RC,
> +};
> +
> +static const struct j721e_pcie_data j721e_pcie_ep_data = {
> +	.mode = PCI_MODE_EP,
> +};
> +
> +static const struct of_device_id of_j721e_pcie_match[] = {
> +	{
> +		.compatible = "ti,j721e-pcie-host",
> +		.data = &j721e_pcie_rc_data,
> +	},
> +	{
> +		.compatible = "ti,j721e-pcie-ep",
> +		.data = &j721e_pcie_ep_data,
> +	},
> +	{},
> +};
> +
> +static int j721e_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	const struct of_device_id *match;
> +	struct pci_host_bridge *bridge;
> +	struct j721e_pcie_data *data;
> +	struct cdns_pcie *cdns_pcie;
> +	struct j721e_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	struct cdns_pcie_ep *ep;
> +	struct gpio_desc *gpiod;
> +	struct resource *res;
> +	void __iomem *base;
> +	u32 num_lanes;
> +	u32 mode;
> +	int ret;
> +
> +	match = of_match_device(of_match_ptr(of_j721e_pcie_match), dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data = (struct j721e_pcie_data *)match->data;

I think you can use of_device_get_match_data(dev) here instead.


> +	mode = (u32)data->mode;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->dev = dev;
> +	pcie->node = node;
> +	pcie->mode = mode;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "user_cfg");
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	pcie->user_cfg_base = base;
> +
> +	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> +	if (ret || num_lanes > MAX_LANES)
> +		num_lanes = 1;
> +	pcie->num_lanes = num_lanes;
> +
> +	dev_set_drvdata(dev, pcie);
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;

This means we'll call pm_runtime_put - are you sure you want to do that?

Thanks,

Andrew Murray


> +	}
> +
> +	ret = j721e_pcie_ctrl_init(pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	switch (mode) {
> +	case PCI_MODE_RC:
> +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)) {
> +			ret = -ENODEV;
> +			goto err_get_sync;
> +		}
> +
> +		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +		if (!bridge) {
> +			ret = -ENOMEM;
> +			goto err_get_sync;
> +		}
> +
> +		bridge->ops = &cdns_ti_pcie_host_ops;
> +		rc = pci_host_bridge_priv(bridge);
> +
> +		cdns_pcie = &rc->pcie;
> +		cdns_pcie->dev = dev;
> +		cdns_pcie->ops = &j721e_ops_ops;
> +		pcie->cdns_pcie = cdns_pcie;
> +
> +		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +		if (IS_ERR(gpiod)) {
> +			ret = PTR_ERR(gpiod);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to get reset GPIO\n");
> +			goto err_get_sync;
> +		}
> +
> +		ret = cdns_pcie_init_phy(dev, cdns_pcie);
> +		if (ret) {
> +			dev_err(dev, "Failed to init phy\n");
> +			goto err_get_sync;
> +		}
> +
> +		/*
> +		 * "Power Sequencing and Reset Signal Timings" table in
> +		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
> +		 * indicates PERST# should be deasserted after minimum of 100us
> +		 * once REFCLK is stable. The REFCLK to the connector in RC
> +		 * mode is selected while enabling the PHY. So deassert PERST#
> +		 * after 100 us.
> +		 */
> +		if (gpiod) {
> +			usleep_range(100, 200);
> +			gpiod_set_value_cansleep(gpiod, 1);
> +		}
> +
> +		ret = cdns_pcie_host_setup(rc);
> +		if (ret < 0)
> +			goto err_pcie_setup;
> +
> +		break;
> +	case PCI_MODE_EP:
> +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP)) {
> +			ret = -ENODEV;
> +			goto err_get_sync;
> +		}
> +
> +		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +		if (!ep) {
> +			ret = -ENOMEM;
> +			goto err_get_sync;
> +		}
> +
> +		cdns_pcie = &ep->pcie;
> +		cdns_pcie->dev = dev;
> +		cdns_pcie->ops = &j721e_ops_ops;
> +		pcie->cdns_pcie = cdns_pcie;
> +
> +		ret = cdns_pcie_init_phy(dev, cdns_pcie);
> +		if (ret) {
> +			dev_err(dev, "Failed to init phy\n");
> +			goto err_get_sync;
> +		}
> +
> +		ret = cdns_pcie_ep_setup(ep);
> +		if (ret < 0)
> +			goto err_pcie_setup;
> +
> +		break;
> +	default:
> +		dev_err(dev, "INVALID device type %d\n", mode);
> +	}
> +
> +	return 0;
> +
> +err_pcie_setup:
> +	cdns_pcie_disable_phy(cdns_pcie);
> +
> +err_get_sync:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static int j721e_pcie_remove(struct platform_device *pdev)
> +{
> +	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
> +	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
> +	struct device *dev = &pdev->dev;
> +
> +	cdns_pcie_disable_phy(cdns_pcie);
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +	of_platform_depopulate(dev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver j721e_pcie_driver = {
> +	.probe  = j721e_pcie_probe,
> +	.remove = j721e_pcie_remove,
> +	.driver = {
> +		.name	= "j721e-pcie",
> +		.of_match_table = of_j721e_pcie_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(j721e_pcie_driver);
> -- 
> 2.17.1
> 
