Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEFA1BEE17
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 04:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgD3CLP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Apr 2020 22:11:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33848 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD3CLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Apr 2020 22:11:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id 72so3638908otu.1;
        Wed, 29 Apr 2020 19:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8atXDTM+kZEG9bKQWWT4/ck8Qma1MdFZyATPeXfgXQM=;
        b=QH6Y+cUKF5jYr1CiegFLZlU30ffXgUD65hDXI+bDw0N/gMqYfwFhdPui+pyiIcLH70
         67eW+U5idrxjlSkZP7wjDEwjGNnAztcdZui9vLh/KXEJaY5h/liXAfNCB0Cu7U7iBWf2
         EgTmyXsBvDwZ7db9SrCUUU9u4zeKkgvpFua2U6POahFqV9TW0EeeBBnnANWRf5hnhZh7
         zVejGUs3jCByYDzxiTCUzrJZijuZxHKBHveR/Lda8AtMnSiEpyV4Fcuec5STfrOBGFZM
         +zu9uyHydhKam4GedgI29n9HcIs3kCvhcKZMGgPWYU+QLXoSt8N9OV3weZbqXfVevM8W
         fL3w==
X-Gm-Message-State: AGi0PubCr0CZRXCW3RoqpJpUcgVYO/Iop1EPywwZkLH3Mad+uTnch44f
        uS+Za0fnPAVaFXUnmsOVOw==
X-Google-Smtp-Source: APiQypJPjzmN0140lNpgr5dXH1iBTsEil7DeAIy0h1obwMw8VvswRx/BtIaknoXP/Ly3twYbTeFdlA==
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr782166otp.216.1588212674051;
        Wed, 29 Apr 2020 19:11:14 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u9sm877314otq.54.2020.04.29.19.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 19:11:13 -0700 (PDT)
Received: (nullmailer pid 14983 invoked by uid 1000);
        Thu, 30 Apr 2020 02:11:12 -0000
Date:   Wed, 29 Apr 2020 21:11:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/14] PCI: j721e: Add TI J721E PCIe driver
Message-ID: <20200430021112.GB6344@bogus>
References: <20200417125753.13021-1-kishon@ti.com>
 <20200417125753.13021-13-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417125753.13021-13-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 17, 2020 at 06:27:51PM +0530, Kishon Vijay Abraham I wrote:
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
>  drivers/pci/controller/cadence/Kconfig        |  23 +
>  drivers/pci/controller/cadence/Makefile       |   1 +
>  drivers/pci/controller/cadence/pci-j721e.c    | 500 ++++++++++++++++++
>  .../controller/cadence/pcie-cadence-host.c    |   4 +-
>  drivers/pci/controller/cadence/pcie-cadence.h |   8 +
>  5 files changed, 534 insertions(+), 2 deletions(-)
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
> diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> new file mode 100644
> index 000000000000..eee619c6ffae
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pci-j721e.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * pci-j721e - PCIe controller driver for TI's J721E SoCs
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
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
> +#define ENABLE_REG_SYS_2	0x108
> +#define STATUS_REG_SYS_2	0x508
> +#define STATUS_CLR_REG_SYS_2	0x708
> +#define LINK_DOWN		BIT(1)
> +
> +#define J721E_PCIE_USER_CMD_STATUS	0x4
> +#define LINK_TRAINING_ENABLE		BIT(0)
> +
> +#define J721E_PCIE_USER_LINKSTATUS	0x14
> +#define LINK_STATUS			GENMASK(1, 0)
> +
> +enum link_status {
> +	NO_RECEIVERS_DETECTED,
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
> +	void __iomem		*intd_cfg_base;
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
> +static inline u32 j721e_pcie_intd_readl(struct j721e_pcie *pcie, u32 offset)
> +{
> +	return readl(pcie->intd_cfg_base + offset);
> +}
> +
> +static inline void j721e_pcie_intd_writel(struct j721e_pcie *pcie, u32 offset,
> +					  u32 value)
> +{
> +	writel(value, pcie->intd_cfg_base + offset);
> +}
> +
> +static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
> +{
> +	struct j721e_pcie *pcie = priv;
> +	struct device *dev = pcie->dev;
> +	u32 reg;
> +
> +	reg = j721e_pcie_intd_readl(pcie, STATUS_REG_SYS_2);
> +	if (!(reg & LINK_DOWN))
> +		return IRQ_NONE;
> +
> +	dev_err(dev, "LINK DOWN!\n");
> +
> +	j721e_pcie_intd_writel(pcie, STATUS_CLR_REG_SYS_2, LINK_DOWN);
> +	return IRQ_HANDLED;
> +}
> +
> +static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
> +{
> +	u32 reg;
> +
> +	reg = j721e_pcie_intd_readl(pcie, ENABLE_REG_SYS_2);
> +	reg |= LINK_DOWN;
> +	j721e_pcie_intd_writel(pcie, ENABLE_REG_SYS_2, reg);
> +}
> +
> +static int j721e_pcie_start_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
> +	reg |= LINK_TRAINING_ENABLE;
> +	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
> +
> +	return 0;
> +}
> +
> +static void j721e_pcie_stop_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct j721e_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 reg;
> +
> +	reg = j721e_pcie_user_readl(pcie, J721E_PCIE_USER_CMD_STATUS);
> +	reg &= ~LINK_TRAINING_ENABLE;
> +	j721e_pcie_user_writel(pcie, J721E_PCIE_USER_CMD_STATUS, reg);
> +}
> +
> +static bool j721e_pcie_link_up(struct cdns_pcie *cdns_pcie)
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
> +	.read = cdns_platform_pcie_read32,
> +	.write = cdns_platform_pcie_write32,
> +	.start_link = j721e_pcie_start_link,
> +	.stop_link = j721e_pcie_stop_link,
> +	.link_up = j721e_pcie_link_up,
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
> +	int irq;
> +
> +	match = of_match_device(of_match_ptr(of_j721e_pcie_match), dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data = (struct j721e_pcie_data *)match->data;

Use of_device_get_match_data()

> +	mode = (u32)data->mode;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pcie->dev = dev;
> +	pcie->node = node;

The dev has the node, why do you need it twice?

> +	pcie->mode = mode;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intd_cfg");
> +	base = devm_ioremap_resource(dev, res);

devm_platform_ioremap_resource_byname()

> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	pcie->intd_cfg_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "user_cfg");
> +	base = devm_ioremap_resource(dev, res);

devm_platform_ioremap_resource_byname

> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +	pcie->user_cfg_base = base;
> +
> +	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
> +	if (ret || num_lanes > MAX_LANES)
> +		num_lanes = 1;
> +	pcie->num_lanes = num_lanes;
> +
> +	irq = platform_get_irq_byname(pdev, "link_state");
> +	if (irq < 0)
> +		return irq;
> +
> +	dev_set_drvdata(dev, pcie);
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	ret = j721e_pcie_ctrl_init(pcie);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +
> +	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler,
> +			       IRQF_SHARED, "j721e-pcie-link_state-irq", pcie);

Really shared?

> +	if (ret < 0) {
> +		dev_err(dev, "failed to request link state IRQ %d\n", irq);
> +		goto err_get_sync;
> +	}
> +
> +	j721e_pcie_config_link_irq(pcie);
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

I don't see a populate. Is this supposed to be here?

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
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index c7dc7be0da40..d7cc7ea4fba3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -11,8 +11,8 @@
>  
>  #include "pcie-cadence.h"
>  
> -static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> -				      int where)
> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>  	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index ea850290a602..f349f5828a58 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -488,11 +488,19 @@ static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>  
>  #ifdef CONFIG_PCIE_CADENCE_HOST
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where);
>  #else
>  static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	return 0;
>  }
> +
> +static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				      int where)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #ifdef CONFIG_PCIE_CADENCE_EP
> -- 
> 2.17.1
> 
