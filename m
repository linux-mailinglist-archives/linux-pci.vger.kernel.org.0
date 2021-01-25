Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DB302C12
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jan 2021 20:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbhAYT4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jan 2021 14:56:09 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:44680 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbhAYTzj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jan 2021 14:55:39 -0500
Received: by mail-ot1-f52.google.com with SMTP id e70so13935052ote.11;
        Mon, 25 Jan 2021 11:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H4sBEFTFyEtc5gSe3qSN8W3/M/wtiha96viuj0aKfhU=;
        b=O4a1pN21wAmWu/sEh7giJ2Yl6zfqfKkOb2zd8g3LKBX3Z0y4f2KWope8mvnhhNAQ/J
         T5ikPdCgxUsBpGLmmojNum9QBVn8Cur7OVtYkFXQJp7oYL/hQl4ufrII0kbtuMS+T5js
         bB4B/18KpCRmAasObbEwUvKH/3xvD+FSVlTJScwLCF5PFgALURfhVJHsKTL9wv/+NUk3
         RVDSnCKIfNJIy0L5uMIo2xG9630uhseJK7LQnscPRipM9TiJ3sBwkCL5bekJYF/QNizk
         J2wN1hQcx9S+Ey3gvyqHGg2wU3VZs2dFRXE2Hghb9YOFHlNnkMMNIKW6tFRINSrXYw4q
         PEdg==
X-Gm-Message-State: AOAM533Jnt8taYkYXQ7Cej8t0f638HyhXWjKLt7ndDEtJ66l+hc8OiEo
        T68Fs76oMYWXXxhL1z88NVo5zFDDKg==
X-Google-Smtp-Source: ABdhPJxtlP8j8XN9d3IXUvNT9sMSxh9H25v8Rc8H+jt8HI/F9t5EmVKjPp/0Qlym6+S4HQiIW4jB8w==
X-Received: by 2002:a9d:39c8:: with SMTP id y66mr1592815otb.68.1611604496844;
        Mon, 25 Jan 2021 11:54:56 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g195sm2094056oib.10.2021.01.25.11.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:54:55 -0800 (PST)
Received: (nullmailer pid 863445 invoked by uid 1000);
        Mon, 25 Jan 2021 19:54:54 -0000
Date:   Mon, 25 Jan 2021 13:54:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, maz@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com
Subject: Re: [v7,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
Message-ID: <20210125195454.GA831088@robh.at.kernel.org>
References: <20210113114001.5804-1-jianjun.wang@mediatek.com>
 <20210113114001.5804-4-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113114001.5804-4-jianjun.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 13, 2021 at 07:39:57PM +0800, Jianjun Wang wrote:
> MediaTek's PCIe host controller has three generation HWs, the new
> generation HW is an individual bridge, it supports Gen3 speed and
> compatible with Gen2, Gen1 speed.
> 
> Add support for new Gen3 controller which can be found on MT8192.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/Kconfig              |  13 +
>  drivers/pci/controller/Makefile             |   1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 463 ++++++++++++++++++++
>  3 files changed, 477 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..b242b17025b3 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -242,6 +242,19 @@ config PCIE_MEDIATEK
>  	  Say Y here if you want to enable PCIe controller support on
>  	  MediaTek SoCs.
>  
> +config PCIE_MEDIATEK_GEN3
> +	tristate "MediaTek Gen3 PCIe controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> +	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
> +	  and support up to 256 MSI interrupt numbers for
> +	  multi-function devices.
> +
> +	  Say Y here if you want to enable Gen3 PCIe controller support on
> +	  MediaTek SoCs.
> +
>  config PCIE_TANGO_SMP8759
>  	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
>  	depends on ARCH_TANGO && PCI_MSI && OF
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 04c6edc285c5..df5d77d72a9d 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -27,6 +27,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
> +obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie-mediatek-gen3.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> new file mode 100644
> index 000000000000..c00ea7c167de
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -0,0 +1,463 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MediaTek PCIe host controller driver.
> + *
> + * Copyright (c) 2020 MediaTek Inc.
> + * Author: Jianjun Wang <jianjun.wang@mediatek.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>

> +#include <linux/of_address.h>
> +#include <linux/of_clk.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>

I don't think these 4 are needed.

> +#include <linux/pci.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +
> +#include "../pci.h"
> +
> +#define PCIE_SETTING_REG		0x80
> +#define PCIE_PCI_IDS_1			0x9c
> +#define PCI_CLASS(class)		(class << 8)
> +#define PCIE_RC_MODE			BIT(0)
> +
> +#define PCIE_CFGNUM_REG			0x140
> +#define PCIE_CFG_DEVFN(devfn)		((devfn) & GENMASK(7, 0))
> +#define PCIE_CFG_BUS(bus)		(((bus) << 8) & GENMASK(15, 8))
> +#define PCIE_CFG_BYTE_EN(bytes)		(((bytes) << 16) & GENMASK(19, 16))
> +#define PCIE_CFG_FORCE_BYTE_EN		BIT(20)
> +#define PCIE_CFG_OFFSET_ADDR		0x1000
> +#define PCIE_CFG_HEADER(bus, devfn) \
> +	(PCIE_CFG_BUS(bus) | PCIE_CFG_DEVFN(devfn))
> +
> +#define PCIE_RST_CTRL_REG		0x148
> +#define PCIE_MAC_RSTB			BIT(0)
> +#define PCIE_PHY_RSTB			BIT(1)
> +#define PCIE_BRG_RSTB			BIT(2)
> +#define PCIE_PE_RSTB			BIT(3)
> +
> +#define PCIE_LTSSM_STATUS_REG		0x150
> +
> +#define PCIE_LINK_STATUS_REG		0x154
> +#define PCIE_PORT_LINKUP		BIT(8)
> +
> +#define PCIE_TRANS_TABLE_BASE_REG	0x800
> +#define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
> +#define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
> +#define PCIE_ATR_TRSL_ADDR_MSB_OFFSET	0xc
> +#define PCIE_ATR_TRSL_PARAM_OFFSET	0x10
> +#define PCIE_ATR_TLB_SET_OFFSET		0x20
> +
> +#define PCIE_MAX_TRANS_TABLES		8
> +#define PCIE_ATR_EN			BIT(0)
> +#define PCIE_ATR_SIZE(size) \
> +	(((((size) - 1) << 1) & GENMASK(6, 1)) | PCIE_ATR_EN)
> +#define PCIE_ATR_ID(id)			((id) & GENMASK(3, 0))
> +#define PCIE_ATR_TYPE_MEM		PCIE_ATR_ID(0)
> +#define PCIE_ATR_TYPE_IO		PCIE_ATR_ID(1)
> +#define PCIE_ATR_TLP_TYPE(type)		(((type) << 16) & GENMASK(18, 16))
> +#define PCIE_ATR_TLP_TYPE_MEM		PCIE_ATR_TLP_TYPE(0)
> +#define PCIE_ATR_TLP_TYPE_IO		PCIE_ATR_TLP_TYPE(2)
> +
> +/**
> + * struct mtk_pcie_port - PCIe port information
> + * @dev: pointer to PCIe device
> + * @base: IO mapped register base
> + * @reg_base: Physical register base
> + * @mac_reset: mac reset control
> + * @phy_reset: phy reset control
> + * @phy: PHY controller block
> + * @clks: PCIe clocks
> + * @num_clks: PCIe clocks count for this port
> + */
> +struct mtk_pcie_port {
> +	struct device *dev;
> +	void __iomem *base;
> +	phys_addr_t reg_base;
> +	struct reset_control *mac_reset;
> +	struct reset_control *phy_reset;
> +	struct phy *phy;
> +	struct clk_bulk_data *clks;
> +	int num_clks;
> +};
> +
> +/**
> + * mtk_pcie_config_tlp_header
> + * @bus: PCI bus to query
> + * @devfn: device/function number
> + * @where: offset in config space
> + * @size: data size in TLP header
> + *
> + * Set byte enable field and device information in configuration TLP header.
> + */
> +static void mtk_pcie_config_tlp_header(struct pci_bus *bus, unsigned int devfn,
> +					int where, int size)
> +{
> +	struct mtk_pcie_port *port = bus->sysdata;
> +	int bytes;
> +	u32 val;
> +
> +	bytes = (GENMASK(size - 1, 0) & 0xf) << (where & 0x3);
> +
> +	val = PCIE_CFG_FORCE_BYTE_EN | PCIE_CFG_BYTE_EN(bytes) |
> +	      PCIE_CFG_HEADER(bus->number, devfn);
> +
> +	writel_relaxed(val, port->base + PCIE_CFGNUM_REG);
> +}
> +
> +static void __iomem *mtk_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> +				      int where)
> +{
> +	struct mtk_pcie_port *port = bus->sysdata;
> +
> +	return port->base + PCIE_CFG_OFFSET_ADDR + where;
> +}
> +
> +static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				int where, int size, u32 *val)
> +{
> +	mtk_pcie_config_tlp_header(bus, devfn, where, size);

This can move to mtk_pcie_map_bus. And if that's the only caller, you 
might as well just merge mtk_pcie_config_tlp_header into 
mtk_pcie_map_bus.

> +
> +	return pci_generic_config_read32(bus, devfn, where, size, val);
> +}
> +
> +static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				 int where, int size, u32 val)
> +{
> +	mtk_pcie_config_tlp_header(bus, devfn, where, size);
> +
> +	if (size <= 2)
> +		val <<= (where & 0x3) * 8;
> +
> +	return pci_generic_config_write32(bus, devfn, where, 4, val);
> +}
> +
> +static struct pci_ops mtk_pcie_ops = {
> +	.map_bus = mtk_pcie_map_bus,
> +	.read  = mtk_pcie_config_read,
> +	.write = mtk_pcie_config_write,
> +};
> +
> +static int mtk_pcie_set_trans_table(struct mtk_pcie_port *port,
> +				    resource_size_t cpu_addr,
> +				    resource_size_t pci_addr,
> +				    resource_size_t size,
> +				    unsigned long type, int num)
> +{
> +	void __iomem *table;
> +	u32 val;
> +
> +	if (num >= PCIE_MAX_TRANS_TABLES) {
> +		dev_err(port->dev, "not enough translate table[%d] for addr: %#llx, limited to [%d]\n",
> +			num, (unsigned long long) cpu_addr,
> +			PCIE_MAX_TRANS_TABLES);
> +		return -ENODEV;
> +	}
> +
> +	table = port->base + PCIE_TRANS_TABLE_BASE_REG +
> +		num * PCIE_ATR_TLB_SET_OFFSET;
> +
> +	writel_relaxed(lower_32_bits(cpu_addr) | PCIE_ATR_SIZE(fls(size) - 1),
> +		       table);
> +	writel_relaxed(upper_32_bits(cpu_addr),
> +		       table + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
> +	writel_relaxed(lower_32_bits(pci_addr),
> +		       table + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
> +	writel_relaxed(upper_32_bits(pci_addr),
> +		       table + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
> +
> +	if (type == IORESOURCE_IO)
> +		val = PCIE_ATR_TYPE_IO | PCIE_ATR_TLP_TYPE_IO;
> +	else
> +		val = PCIE_ATR_TYPE_MEM | PCIE_ATR_TLP_TYPE_MEM;
> +
> +	writel_relaxed(val, table + PCIE_ATR_TRSL_PARAM_OFFSET);
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> +{
> +	struct resource_entry *entry;
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
> +	unsigned int table_index = 0;
> +	int err;
> +	u32 val;
> +
> +	/* Set as RC mode */
> +	val = readl_relaxed(port->base + PCIE_SETTING_REG);
> +	val |= PCIE_RC_MODE;
> +	writel_relaxed(val, port->base + PCIE_SETTING_REG);
> +
> +	/* Set class code */
> +	val = readl_relaxed(port->base + PCIE_PCI_IDS_1);
> +	val &= ~GENMASK(31, 8);
> +	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
> +	writel_relaxed(val, port->base + PCIE_PCI_IDS_1);
> +
> +	/* Assert all reset signals */
> +	val = readl_relaxed(port->base + PCIE_RST_CTRL_REG);
> +	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	/* De-assert reset signals */
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	/* Delay 100ms to wait the reference clocks become stable */
> +	msleep(100);
> +
> +	/* De-assert PERST# signal */
> +	val &= ~PCIE_PE_RSTB;
> +	writel_relaxed(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	/* Check if the link is up or not */
> +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> +				 !!(val & PCIE_PORT_LINKUP), 20,
> +				 50 * USEC_PER_MSEC);
> +	if (err) {
> +		val = readl_relaxed(port->base + PCIE_LTSSM_STATUS_REG);
> +		dev_err(port->dev, "PCIe link down, ltssm reg val: %#x\n", val);
> +		return err;
> +	}
> +
> +	/* Set PCIe translation windows */
> +	resource_list_for_each_entry(entry, &host->windows) {
> +		struct resource *res = entry->res;
> +		unsigned long type = resource_type(res);
> +		resource_size_t cpu_addr;
> +		resource_size_t pci_addr;
> +		resource_size_t size;
> +		const char *range_type;
> +
> +		if (type == IORESOURCE_IO) {
> +			cpu_addr = pci_pio_to_address(res->start);
> +			range_type = "IO";
> +		} else if (type == IORESOURCE_MEM) {
> +			cpu_addr = res->start;
> +			range_type = "MEM";
> +		} else {
> +			continue;
> +		}
> +
> +		pci_addr = res->start - entry->offset;
> +		size = resource_size(res);
> +		err = mtk_pcie_set_trans_table(port, cpu_addr, pci_addr, size,
> +					       type, table_index);
> +		if (err)
> +			return err;
> +
> +		dev_dbg(port->dev, "set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
> +			range_type, table_index, (unsigned long long) cpu_addr,
> +			(unsigned long long) pci_addr,
> +			(unsigned long long) size);
> +
> +		table_index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_clk_init(struct mtk_pcie_port *port)
> +{
> +	int ret;
> +
> +	port->num_clks = devm_clk_bulk_get_all(port->dev, &port->clks);
> +	if (port->num_clks < 0) {
> +		dev_err(port->dev, "failed to get PCIe clock\n");
> +		return port->num_clks;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(port->num_clks, port->clks);
> +	if (ret) {
> +		dev_err(port->dev, "failed to enable PCIe clocks\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_power_up(struct mtk_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	int err;
> +
> +	port->phy_reset = devm_reset_control_get_optional_exclusive(dev, "phy");
> +	if (IS_ERR(port->phy_reset))
> +		return PTR_ERR(port->phy_reset);
> +
> +	/* PHY power on and enable pipe clock */
> +	port->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(port->phy))
> +		return PTR_ERR(port->phy);
> +
> +	reset_control_deassert(port->phy_reset);
> +
> +	err = phy_init(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to initialize PCIe phy\n");
> +		goto err_phy_init;
> +	}
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_err(dev, "failed to power on PCIe phy\n");
> +		goto err_phy_on;
> +	}
> +
> +	port->mac_reset = devm_reset_control_get_optional_exclusive(dev, "mac");
> +	if (IS_ERR(port->mac_reset)) {
> +		err = PTR_ERR(port->mac_reset);
> +		goto err_mac_rst;
> +	}
> +
> +	reset_control_deassert(port->mac_reset);
> +
> +	/* MAC power on and enable transaction layer clocks */
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	err = mtk_pcie_clk_init(port);
> +	if (err) {
> +		dev_err(dev, "clock init failed\n");
> +		goto err_clk_init;
> +	}
> +
> +	return 0;
> +
> +err_clk_init:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	reset_control_assert(port->mac_reset);
> +err_mac_rst:
> +	phy_power_off(port->phy);
> +err_phy_on:
> +	phy_exit(port->phy);
> +err_phy_init:
> +	reset_control_assert(port->phy_reset);
> +
> +	return err;
> +}
> +
> +static void mtk_pcie_power_down(struct mtk_pcie_port *port)
> +{
> +	clk_bulk_disable_unprepare(port->num_clks, port->clks);
> +
> +	pm_runtime_put_sync(port->dev);
> +	pm_runtime_disable(port->dev);
> +	reset_control_assert(port->mac_reset);
> +
> +	phy_power_off(port->phy);
> +	phy_exit(port->phy);
> +	reset_control_assert(port->phy_reset);
> +}
> +
> +static int mtk_pcie_setup(struct mtk_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *regs;
> +	int err;
> +
> +	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
> +	port->base = devm_ioremap_resource(dev, regs);

Use devm_platform_ioremap_resource_byname()

> +	if (IS_ERR(port->base)) {
> +		dev_err(dev, "failed to map register base\n");
> +		return PTR_ERR(port->base);
> +	}
> +
> +	port->reg_base = regs->start;
> +
> +	/* Don't touch the hardware registers before power up */
> +	err = mtk_pcie_power_up(port);
> +	if (err)
> +		return err;
> +
> +	/* Try link up */
> +	err = mtk_pcie_startup_port(port);
> +	if (err) {
> +		dev_err(dev, "PCIe startup failed\n");
> +		goto err_setup;
> +	}
> +
> +	dev_info(dev, "PCIe link up success!\n");

Do you really need this, there's lots printed by PCI in the successful 
case.

> +
> +	return 0;
> +
> +err_setup:
> +	mtk_pcie_power_down(port);
> +
> +	return err;
> +}
> +
> +static int mtk_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_pcie_port *port;
> +	struct pci_host_bridge *host;
> +	int err;
> +
> +	host = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> +	if (!host)
> +		return -ENOMEM;
> +
> +	port = pci_host_bridge_priv(host);
> +
> +	port->dev = dev;
> +	platform_set_drvdata(pdev, port);
> +
> +	err = mtk_pcie_setup(port);
> +	if (err)
> +		return err;
> +
> +	host->ops = &mtk_pcie_ops;
> +	host->sysdata = port;
> +
> +	err = pci_host_probe(host);
> +	if (err) {
> +		mtk_pcie_power_down(port);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_remove(struct platform_device *pdev)
> +{
> +	struct mtk_pcie_port *port = platform_get_drvdata(pdev);
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
> +
> +	pci_lock_rescan_remove();
> +	pci_stop_root_bus(host->bus);
> +	pci_remove_root_bus(host->bus);
> +	pci_unlock_rescan_remove();
> +
> +	mtk_pcie_power_down(port);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_pcie_of_match[] = {
> +	{ .compatible = "mediatek,mt8192-pcie" },
> +	{},
> +};
> +
> +static struct platform_driver mtk_pcie_driver = {
> +	.probe = mtk_pcie_probe,
> +	.remove = mtk_pcie_remove,
> +	.driver = {
> +		.name = "mtk-pcie",
> +		.of_match_table = mtk_pcie_of_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_pcie_driver);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
> 
