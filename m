Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42167267619
	for <lists+linux-pci@lfdr.de>; Sat, 12 Sep 2020 00:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgIKWo4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 18:44:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:41214 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgIKWos (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 18:44:48 -0400
Received: by mail-il1-f195.google.com with SMTP id f82so5752247ilh.8;
        Fri, 11 Sep 2020 15:44:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4jiB/XTahwuWd4PXj6sXHMVk/uWwjXJGUx211B6gRCU=;
        b=Ys+TIfZBrERuD+MANlb094BLOK2OVpipVEI13WpbcRlo3i2ryntMd+JayFgdtM13ec
         JWgDxXn98vPxZIvqXCYvgcr/hk+bqWRaGYt9pwvQGuz2XZsThPZo2wNY60syVBu884yE
         dQbownqUfuNHtRJt0rJve8UJMj6QXksjgUs0l9joYYqRX+wkQv6N9rGHOf0buQ/VEL8U
         Trk1PV9n0TI8EFpivbgs15o2fKjxpq64AiZFodCW8kJlLiHvtMBHki1M6TEN+CG7N1Jd
         IXFrA5RIpQM0fYUrKWoPcP0P9QupIXGhESS4Xei88Vc8pUQNkLLjR/DsbC/nxVxCV5cG
         Cfkw==
X-Gm-Message-State: AOAM533fz6sOUqpHm1MqgMcFDd2pruv/0SlQ2f65oaSIcQYcKvjBLGPn
        UfK2aPDaRH7QA12DYZOUPQ==
X-Google-Smtp-Source: ABdhPJzJLwx224dddNcYGmXdXOazTaRsZDbbaO4HQaJo+1oc3cdSA/tAGjsbro2jqeJZ8XcdODfgpw==
X-Received: by 2002:a92:8b52:: with SMTP id i79mr3771080ild.177.1599864284361;
        Fri, 11 Sep 2020 15:44:44 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id r5sm2031600ilc.2.2020.09.11.15.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:44:43 -0700 (PDT)
Received: (nullmailer pid 2958198 invoked by uid 1000);
        Fri, 11 Sep 2020 22:44:34 -0000
Date:   Fri, 11 Sep 2020 16:44:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>
Subject: Re: [v2,2/3] PCI: mediatek: Add new generation controller support
Message-ID: <20200911224434.GA2905744@bogus>
References: <20200910034536.30860-1-jianjun.wang@mediatek.com>
 <20200910034536.30860-3-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910034536.30860-3-jianjun.wang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 10, 2020 at 11:45:35AM +0800, Jianjun Wang wrote:
> MediaTek's PCIe host controller has three generation HWs, the new
> generation HW is an individual bridge, it supoorts Gen3 speed and
> up to 256 MSI interrupt numbers for multi-function devices.
> 
> Add support for new Gen3 controller which can be found on MT8192.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/pci/controller/Kconfig              |   14 +
>  drivers/pci/controller/Makefile             |    1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c | 1076 +++++++++++++++++++
>  3 files changed, 1091 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-mediatek-gen3.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index f18c3725ef80..83daa772595b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -239,6 +239,20 @@ config PCIE_MEDIATEK
>  	  Say Y here if you want to enable PCIe controller support on
>  	  MediaTek SoCs.
>  
> +config PCIE_MEDIATEK_GEN3
> +	tristate "MediaTek GEN3 PCIe controller"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on OF
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	help
> +	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
> +	  This PCIe controller provides the capable of Gen3, Gen2 and
> +	  Gen1 speed, and support up to 256 MSI interrupt numbers for
> +	  multi-function devices.
> +
> +	  Say Y here if you want to enable Gen3 PCIe controller support on
> +	  MediaTek SoCs.
> +
>  config PCIE_TANGO_SMP8759
>  	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
>  	depends on ARCH_TANGO && PCI_MSI && OF
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index bcdbf49ab1e4..9c1b96777597 100644
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
> index 000000000000..f8c8bdf88d33
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -0,0 +1,1076 @@
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
> +#include <linux/irq.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_clk.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
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
> +#define PCIE_CFG_HEADER(devfn, bus) \
> +	(PCIE_CFG_DEVFN(devfn) | PCIE_CFG_BUS(bus))
> +
> +#define PCIE_CFG_HEADER_FORCE_BE(devfn, bus, bytes) \
> +	(PCIE_CFG_HEADER(devfn, bus) | PCIE_CFG_BYTE_EN(bytes) \
> +	 | PCIE_CFG_FORCE_BYTE_EN)
> +
> +#define PCIE_RST_CTRL_REG		0x148
> +#define PCIE_MAC_RSTB			BIT(0)
> +#define PCIE_PHY_RSTB			BIT(1)
> +#define PCIE_BRG_RSTB			BIT(2)
> +#define PCIE_PE_RSTB			BIT(3)
> +
> +#define PCIE_MISC_STATUS_REG		0x14C
> +#define PCIE_LTR_MSG_RECEIVED		BIT(0)
> +#define PCIE_PCIE_MSG_RECEIVED		BIT(1)
> +
> +#define PCIE_LTSSM_STATUS_REG		0x150
> +#define PCIE_LTSSM_STATE_MASK		GENMASK(28, 24)
> +#define PCIE_LTSSM_STATE(val)		((val & PCIE_LTSSM_STATE_MASK) >> 24)
> +#define PCIE_LTSSM_STATE_L0		0x10
> +#define PCIE_LTSSM_STATE_L1_IDLE	0x13
> +#define PCIE_LTSSM_STATE_L2_IDLE	0x14
> +
> +#define PCIE_LINK_STATUS_REG		0x154
> +#define PCIE_PORT_LINKUP		BIT(8)
> +
> +#define PCIE_MSI_SET_NUM		8
> +#define PCIE_MSI_IRQS_PER_SET		32
> +#define PCIE_MSI_IRQS_NUM \
> +	(PCIE_MSI_IRQS_PER_SET * (PCIE_MSI_SET_NUM))
> +
> +#define PCIE_INT_ENABLE_REG		0x180
> +#define PCIE_MSI_MASK			GENMASK(PCIE_MSI_SET_NUM + 8 - 1, 8)
> +#define PCIE_MSI_SHIFT			8
> +#define PCIE_INTX_SHIFT			24
> +#define PCIE_INTX_MASK			GENMASK(27, 24)
> +#define PCIE_MSG_MASK			BIT(28)
> +#define PCIE_AER_MASK			BIT(29)
> +#define PCIE_PM_MASK			BIT(30)
> +
> +#define PCIE_INT_STATUS_REG		0x184
> +#define PCIE_MSI_SET_ENABLE_REG		0x190
> +
> +#define PCIE_LOW_POWER_CTRL_REG		0x194
> +#define PCIE_DIS_LOWPWR_MASK		GENMASK(3, 0)
> +#define PCIE_DIS_L0S_MASK		BIT(0)
> +#define PCIE_DIS_L1_MASK		BIT(1)
> +#define PCIE_DIS_L11_MASK		BIT(2)
> +#define PCIE_DIS_L12_MASK		BIT(3)
> +#define PCIE_FORCE_DIS_LOWPWR		GENMASK(11, 8)
> +#define PCIE_FORCE_DIS_L0S		BIT(8)
> +#define PCIE_FORCE_DIS_L1		BIT(9)
> +#define PCIE_FORCE_DIS_L11		BIT(10)
> +#define PCIE_FORCE_DIS_L12		BIT(11)
> +
> +#define PCIE_ICMD_PM_REG		0x198
> +#define PCIE_TURN_OFF_LINK		BIT(4)
> +
> +#define PCIE_MSI_ADDR_BASE_REG		0xc00
> +#define PCIE_MSI_SET_OFFSET		0x10
> +#define PCIE_MSI_STATUS_OFFSET		0x04
> +#define PCIE_MSI_ENABLE_OFFSET		0x08
> +
> +#define PCIE_TRANS_TABLE_BASE_REG	0x800
> +#define PCIE_ATR_SRC_ADDR_MSB_OFFSET	0x4
> +#define PCIE_ATR_TRSL_ADDR_LSB_OFFSET	0x8
> +#define PCIE_ATR_TRSL_ADDR_MSB_OFFSET	0xc
> +#define PCIE_ATR_TRSL_PARAM_OFFSET	0x10
> +#define PCIE_ATR_TLB_SET_OFFSET		0x20
> +
> +#define PCIE_MAX_TRANS_TABLES		8
> +#define ATR_EN				BIT(0)
> +#define ATR_SIZE(size)			((((size) - 1) << 1) & GENMASK(6, 1))
> +#define ATR_ID(id)			(id & GENMASK(3, 0))
> +#define ATR_PARAM(param)		(((param) << 16) & GENMASK(27, 16))
> +
> +/**
> + * struct mtk_pcie_msi - MSI information for each set
> + * @base: IO mapped register base
> + * @hwirq: Hardware interrupt number
> + * @irq: MSI set Interrupt number
> + * @index: MSI set number
> + * @msg_addr: MSI message address
> + * @domain: IRQ domain
> + */
> +struct mtk_pcie_msi {
> +	void __iomem *base;
> +	int hwirq;
> +	int irq;
> +	int index;
> +	phys_addr_t msg_addr;
> +	struct irq_domain *domain;
> +};
> +
> +/**
> + * struct mtk_pcie_port - PCIe port information
> + * @dev: PCIe device
> + * @base: IO mapped register base
> + * @reg_base: Physical register base
> + * @mac_reset: mac reset control
> + * @phy_reset: phy reset control
> + * @phy: PHY controller block
> + * @clks: PCIe clocks
> + * @num_clks: PCIe clocks count for this port
> + * @is_suspended: device suspend state
> + * @irq: PCIe controller interrupt number
> + * @intx_domain: legacy INTx IRQ domain
> + * @msi_domain: MSI IRQ domain
> + * @msi_top_domain: MSI IRQ top domain
> + * @msi_info: MSI sets information
> + * @lock: lock protecting IRQ bit map
> + * @msi_irq_in_use: bit map for assigned MSI IRQ
> + */
> +struct mtk_pcie_port {
> +	struct device *dev;
> +	void __iomem *base;
> +	phys_addr_t reg_base;
> +	struct reset_control *mac_reset;
> +	struct reset_control *phy_reset;
> +	struct phy *phy;
> +	struct clk **clks;
> +	int num_clks;
> +	bool is_suspended;
> +
> +	int irq;
> +	struct irq_domain *intx_domain;
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *msi_top_domain;
> +	struct mtk_pcie_msi **msi_info;
> +	struct mutex lock;
> +	DECLARE_BITMAP(msi_irq_in_use, PCIE_MSI_IRQS_NUM);
> +};
> +
> +static int mtk_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 *val)
> +{
> +	struct mtk_pcie_port *port = bus->sysdata;
> +	int bytes;
> +
> +	bytes = ((1 << size) - 1) << (where & 0x3);
> +	writel(PCIE_CFG_HEADER_FORCE_BE(devfn, bus->number, bytes),
> +	       port->base + PCIE_CFGNUM_REG);
> +
> +	*val = readl(port->base + PCIE_CFG_OFFSET_ADDR + (where & ~0x3));
> +
> +	if (size <= 2)
> +		*val = (*val >> (8 * (where & 0x3))) & ((1 << (size * 8)) - 1);
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int mtk_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				     int where, int size, u32 val)
> +{
> +	struct mtk_pcie_port *port = bus->sysdata;
> +	int bytes;
> +
> +	bytes = ((1 << size) - 1) << (where & 0x3);
> +	writel(PCIE_CFG_HEADER_FORCE_BE(devfn, bus->number, bytes),
> +	       port->base + PCIE_CFGNUM_REG);
> +
> +	if (size <= 2)
> +		val = (val & ((1 << (size * 8)) - 1)) << ((where & 0x3) * 8);
> +
> +	writel(val, port->base + PCIE_CFG_OFFSET_ADDR + (where & ~0x3));
> +
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops mtk_pcie_ops = {
> +	.read  = mtk_pcie_config_read,
> +	.write = mtk_pcie_config_write,
> +};
> +
> +static void mtk_pcie_set_trans_window(void __iomem *reg,
> +				      resource_size_t cpu_addr,
> +				      resource_size_t pci_addr, size_t size)
> +{
> +	writel(lower_32_bits(cpu_addr) | ATR_SIZE(fls(size) - 1) | ATR_EN, reg);
> +	writel(upper_32_bits(cpu_addr), reg + PCIE_ATR_SRC_ADDR_MSB_OFFSET);
> +	writel(lower_32_bits(pci_addr), reg + PCIE_ATR_TRSL_ADDR_LSB_OFFSET);
> +	writel(upper_32_bits(pci_addr), reg + PCIE_ATR_TRSL_ADDR_MSB_OFFSET);
> +	writel(ATR_ID(0) | ATR_PARAM(0), reg + PCIE_ATR_TRSL_PARAM_OFFSET);
> +}
> +
> +static int mtk_pcie_set_trans_table(void __iomem *reg,
> +				    resource_size_t cpu_addr,
> +				    resource_size_t pci_addr, size_t size,
> +				    int num)
> +{
> +	void __iomem *table_base;
> +
> +	if (num > PCIE_MAX_TRANS_TABLES)
> +		return -ENODEV;
> +
> +	table_base = reg + num * PCIE_ATR_TLB_SET_OFFSET;
> +	mtk_pcie_set_trans_window(table_base, cpu_addr, pci_addr, size);
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
> +{
> +	struct resource_entry *entry;
> +	struct pci_host_bridge *host = pci_host_bridge_from_priv(port);
> +	u32 val;
> +	int err = 0, table_index = 0;
> +
> +	/* Set as RC mode */
> +	val = readl(port->base + PCIE_SETTING_REG);
> +	val |= PCIE_RC_MODE;
> +	writel(val, port->base + PCIE_SETTING_REG);
> +
> +	/* Set class code */
> +	val = readl(port->base + PCIE_PCI_IDS_1);
> +	val &= ~GENMASK(31, 8);
> +	val |= PCI_CLASS(PCI_CLASS_BRIDGE_PCI << 8);
> +	writel(val, port->base + PCIE_PCI_IDS_1);
> +
> +	/* Assert all reset signals */
> +	val = readl(port->base + PCIE_RST_CTRL_REG);
> +	val |= PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB | PCIE_PE_RSTB;
> +	writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	/* De-assert reset signals*/
> +	val &= ~(PCIE_MAC_RSTB | PCIE_PHY_RSTB | PCIE_BRG_RSTB);
> +	writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	usleep_range(100 * 1000, 120 * 1000);

Seems like a long delay...

> +
> +	/* De-assert pe reset*/
> +	val &= ~PCIE_PE_RSTB;
> +	writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	/* Check if the link is up or not */
> +	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_REG, val,
> +			!!(val & PCIE_PORT_LINKUP), 20,
> +			50 * USEC_PER_MSEC);
> +	if (err)
> +		return err;
> +
> +	/* Set PCIe translation windows */
> +	resource_list_for_each_entry(entry, &host->windows) {
> +		unsigned long type = resource_type(entry->res);
> +		struct resource *res = NULL;
> +		resource_size_t cpu_addr;
> +		resource_size_t pci_addr;
> +
> +		if (!(type & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			continue;
> +
> +		res = entry->res;
> +		cpu_addr = res->start;
> +		pci_addr = res->start - entry->offset;
> +		mtk_pcie_set_trans_table(port->base + PCIE_TRANS_TABLE_BASE_REG,
> +					 cpu_addr, pci_addr, resource_size(res),
> +					 table_index);
> +
> +		dev_dbg(port->dev, "Set %s trans window[%d]: cpu_addr = %#llx, pci_addr = %#llx, size = %#llx\n",
> +			(!!(type & IORESOURCE_MEM) ? "MEM" : "IO"), table_index,
> +			cpu_addr, pci_addr, resource_size(res));
> +
> +		table_index++;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline struct mtk_pcie_msi *mtk_get_msi_info(struct mtk_pcie_port *port,
> +					     unsigned int hwirq)
> +{
> +	return port->msi_info[hwirq / PCIE_MSI_IRQS_PER_SET];
> +}
> +
> +static int mtk_pcie_set_affinity(struct irq_data *data,
> +				 const struct cpumask *mask, bool force)
> +{
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int ret;
> +
> +	ret = irq_set_affinity_hint(port->irq, mask);
> +	if (ret)
> +		return ret;
> +
> +	irq_data_update_effective_affinity(data, mask);
> +
> +	return 0;
> +}
> +
> +static void mtk_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct mtk_pcie_msi *msi_info;
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +
> +	msi_info = mtk_get_msi_info(port, data->hwirq);
> +
> +	msg->address_hi = 0;
> +	msg->address_lo = lower_32_bits(msi_info->msg_addr);
> +
> +	msg->data = data->hwirq;
> +	dev_dbg(port->dev, "msi#%#lx address_hi %#x address_lo %#x data %d\n",
> +		data->hwirq, msg->address_hi, msg->address_lo, msg->data);
> +}
> +
> +static void mtk_msi_irq_ack(struct irq_data *data)
> +{
> +	struct mtk_pcie_msi *msi_info;
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int hwirq;
> +
> +	msi_info = mtk_get_msi_info(port, data->hwirq);
> +
> +	hwirq =	data->hwirq % PCIE_MSI_IRQS_PER_SET;
> +
> +	writel(1 << hwirq, msi_info->base + PCIE_MSI_STATUS_OFFSET);
> +}
> +
> +static void mtk_msi_irq_mask(struct irq_data *data)
> +{
> +	struct mtk_pcie_msi *msi_info;
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int val;
> +
> +	msi_info = mtk_get_msi_info(port, data->hwirq);
> +	val = readl(msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +	val &= ~(1 << data->hwirq);
> +	writel(val, msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +
> +	pci_msi_mask_irq(data);
> +}
> +
> +static void mtk_msi_irq_unmask(struct irq_data *data)
> +{
> +	struct mtk_pcie_msi *msi_info;
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int val;
> +
> +	msi_info = mtk_get_msi_info(port, data->hwirq);
> +	val = readl(msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +	val |= (1 << data->hwirq);
> +	writel(val, msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +
> +	pci_msi_unmask_irq(data);
> +}
> +
> +static struct irq_chip mtk_msi_irq_chip = {
> +	.irq_ack		= mtk_msi_irq_ack,
> +	.irq_compose_msi_msg	= mtk_compose_msi_msg,
> +	.irq_mask		= mtk_msi_irq_mask,
> +	.irq_unmask		= mtk_msi_irq_unmask,
> +	.irq_set_affinity	= mtk_pcie_set_affinity,
> +	.name			= "PCIe",
> +};
> +
> +static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
> +					      msi_alloc_info_t *arg)
> +{
> +	struct msi_desc *entry = arg->desc;
> +	struct mtk_pcie_port *port = info->chip_data;
> +	int hwirq;
> +
> +	mutex_lock(&port->lock);
> +
> +	hwirq = bitmap_find_free_region(port->msi_irq_in_use, PCIE_MSI_IRQS_NUM,
> +			order_base_2(entry->nvec_used));
> +	if (hwirq < 0) {
> +		mutex_unlock(&port->lock);
> +		return -ENOSPC;
> +	}
> +
> +	mutex_unlock(&port->lock);
> +
> +	return hwirq;
> +}
> +
> +static void mtk_pcie_msi_free(struct irq_domain *domain,
> +			      struct msi_domain_info *info, unsigned int virq)
> +{
> +	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +
> +	mutex_lock(&port->lock);
> +
> +	bitmap_clear(port->msi_irq_in_use, data->hwirq, 1);
> +
> +	mutex_unlock(&port->lock);
> +}
> +
> +static struct msi_domain_ops mtk_msi_domain_ops = {
> +	.get_hwirq	= mtk_pcie_msi_get_hwirq,
> +	.msi_free	= mtk_pcie_msi_free,
> +};
> +
> +static struct msi_domain_info mtk_msi_domain_info = {
> +	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_PCI_MSIX |
> +			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_MULTI_PCI_MSI),
> +	.chip		= &mtk_msi_irq_chip,
> +	.ops		= &mtk_msi_domain_ops,
> +	.handler	= handle_edge_irq,
> +	.handler_name	= "MSI",
> +};
> +
> +static void mtk_msi_top_irq_ack(struct irq_data *data)
> +{
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int msi_irq = data->hwirq + PCIE_MSI_SHIFT;
> +
> +	writel(1 << msi_irq, port->base + PCIE_INT_STATUS_REG);
> +}
> +
> +static struct irq_chip mtk_msi_top_irq_chip = {
> +	.irq_ack	= mtk_msi_top_irq_ack,
> +	.name		= "PCIe",
> +};
> +
> +static void mtk_pcie_msi_handler(struct irq_desc *desc)
> +{
> +	struct mtk_pcie_msi *msi_info = irq_desc_get_handler_data(desc);
> +	struct irq_chip *irqchip = irq_desc_get_chip(desc);
> +	unsigned long msi_enable, msi_status;
> +	u32 virq, bit, hwirq;
> +
> +	raw_spin_lock(&desc->lock);

This seems a bit odd. I think you should be using chained_irq_enter/exit 
here.

> +
> +	msi_enable = readl(msi_info->base + PCIE_MSI_ENABLE_OFFSET);
> +	while ((msi_status = readl(msi_info->base + PCIE_MSI_STATUS_OFFSET))) {
> +		msi_status &= msi_enable;
> +		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
> +			hwirq = bit + msi_info->index * PCIE_MSI_IRQS_PER_SET;
> +			virq = irq_find_mapping(msi_info->domain, hwirq);
> +			generic_handle_irq(virq);
> +		}
> +	}
> +
> +	irqchip->irq_ack(&desc->irq_data);
> +
> +	raw_spin_unlock(&desc->lock);
> +}
> +
> +static int mtk_msi_top_domain_map(struct irq_domain *domain,
> +				    unsigned int virq, irq_hw_number_t hwirq)
> +{
> +	struct mtk_pcie_port *port = domain->host_data;
> +	struct mtk_pcie_msi *msi_info = port->msi_info[hwirq];
> +
> +	irq_domain_set_info(domain, virq, hwirq,
> +			    &mtk_msi_top_irq_chip, domain->host_data,
> +			    mtk_pcie_msi_handler, msi_info, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops mtk_msi_top_domain_ops = {
> +	.map = mtk_msi_top_domain_map,
> +};
> +
> +static void mtk_intx_ack(struct irq_data *data)
> +{
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int hwirq;
> +
> +	hwirq = data->hwirq + PCIE_INTX_SHIFT;
> +	writel(1 << hwirq, port->base + PCIE_INT_STATUS_REG);
> +}
> +
> +static void mtk_intx_mask(struct irq_data *data)
> +{
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int val;
> +
> +	val = readl(port->base + PCIE_INT_ENABLE_REG);
> +	val &= ~(1 << (data->hwirq + PCIE_INTX_SHIFT));
> +	writel(val, port->base + PCIE_INT_ENABLE_REG);
> +}
> +
> +static void mtk_intx_unmask(struct irq_data *data)
> +{
> +	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(data);
> +	int val, hwirq;
> +
> +	/**
> +	 * As an emulated level irq, this interrupt status will be remained
> +	 * until receive the corresponding message of de-assert, hence that
> +	 * the status can only be cleared at this point.
> +	 */
> +	hwirq = data->hwirq + PCIE_INTX_SHIFT;
> +	writel(1 << hwirq, port->base + PCIE_INT_STATUS_REG);
> +
> +	val = readl(port->base + PCIE_INT_ENABLE_REG);
> +	val |= 1 << (data->hwirq + PCIE_INTX_SHIFT);
> +	writel(val, port->base + PCIE_INT_ENABLE_REG);
> +}
> +
> +static struct irq_chip mtk_intx_irq_chip = {
> +	.irq_ack		= mtk_intx_ack,
> +	.irq_mask		= mtk_intx_mask,
> +	.irq_unmask		= mtk_intx_unmask,
> +	.irq_set_affinity	= mtk_pcie_set_affinity,
> +	.name			= "PCIe",
> +};
> +
> +static int mtk_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +			     irq_hw_number_t hwirq)
> +{
> +	irq_set_chip_and_handler_name(irq, &mtk_intx_irq_chip, handle_level_irq,
> +				      "INTx");
> +	irq_set_chip_data(irq, domain->host_data);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops intx_domain_ops = {
> +	.map = mtk_pcie_intx_map,
> +};
> +
> +static int mtk_pcie_init_irq_domains(struct mtk_pcie_port *port,
> +				     struct device_node *node)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *intc_node;
> +	struct fwnode_handle *fwnode = of_node_to_fwnode(node);
> +	struct mtk_pcie_msi *msi_info;
> +	struct msi_domain_info *info;
> +	int i, val, ret;
> +
> +	/* Setup INTx */
> +	intc_node = of_get_child_by_name(node, "interrupt-controller");
> +	if (!intc_node) {
> +		dev_notice(dev, "Missing PCIe Intc node\n");
> +		return -ENODEV;
> +	}
> +
> +	port->intx_domain = irq_domain_add_linear(intc_node, PCI_NUM_INTX,
> +						  &intx_domain_ops, port);
> +	if (!port->intx_domain) {
> +		dev_notice(dev, "failed to get INTx IRQ domain\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Setup MSI */
> +	mutex_init(&port->lock);
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
> +	info->chip_data = port;
> +
> +	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
> +	if (!port->msi_domain) {
> +		dev_info(dev, "failed to create msi domain\n");
> +		ret = -ENODEV;
> +		goto err_msi_domain;
> +	}
> +
> +	/* Enable MSI and setup pcie domains */
> +	port->msi_top_domain = irq_domain_add_hierarchy(NULL, 0, 0, node,
> +							&mtk_msi_top_domain_ops,
> +							port);
> +	if (!port->msi_top_domain) {
> +		dev_info(dev, "failed to create msi top domain\n");
> +		ret = -ENODEV;
> +		goto err_msi_top_domain;
> +	}
> +
> +	port->msi_info = devm_kzalloc(dev, PCIE_MSI_SET_NUM, GFP_KERNEL);
> +	if (!port->msi_info) {
> +		ret = -ENOMEM;
> +		goto err_msi_info;
> +	}
> +
> +	for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
> +		int offset = i * PCIE_MSI_SET_OFFSET;
> +
> +		msi_info = devm_kzalloc(dev, sizeof(*msi_info), GFP_KERNEL);
> +		if (!msi_info) {
> +			ret = -ENOMEM;
> +			goto err_msi_set;
> +		}
> +
> +		msi_info->base = port->base + PCIE_MSI_ADDR_BASE_REG + offset;
> +		msi_info->msg_addr = port->reg_base + PCIE_MSI_ADDR_BASE_REG +
> +				     offset;
> +
> +		writel(lower_32_bits(msi_info->msg_addr), msi_info->base);
> +
> +		msi_info->hwirq = i;
> +		msi_info->index = i;
> +		msi_info->domain = port->msi_domain;
> +
> +		port->msi_info[i] = msi_info;
> +
> +		/* Alloc irq for each msi set */
> +		msi_info->irq = irq_create_mapping(port->msi_top_domain, i);
> +		if (msi_info->irq < 0) {
> +			dev_info(dev, "allocate msi top irq failed\n");
> +			ret = -ENOSPC;
> +			goto err_msi_set;
> +		}
> +
> +		val = readl(port->base + PCIE_INT_ENABLE_REG);
> +		val |= (1 << (i + PCIE_MSI_SHIFT));
> +		writel(val, port->base + PCIE_INT_ENABLE_REG);
> +
> +		val = readl(port->base + PCIE_MSI_SET_ENABLE_REG);
> +		val |= (1 << i);
> +		writel(val, port->base + PCIE_MSI_SET_ENABLE_REG);
> +	}
> +
> +	return 0;
> +
> +err_msi_set:
> +	while (--i >= 0) {
> +		msi_info = port->msi_info[i];
> +		irq_dispose_mapping(msi_info->irq);
> +	}
> +err_msi_info:
> +	irq_domain_remove(port->msi_top_domain);
> +err_msi_top_domain:
> +	irq_domain_remove(port->msi_domain);
> +err_msi_domain:
> +	irq_domain_remove(port->intx_domain);
> +
> +	return ret;
> +}
> +
> +static void mtk_pcie_irq_teardown(struct mtk_pcie_port *port)
> +{
> +	struct mtk_pcie_msi *msi_info;
> +	int i;
> +
> +	irq_set_chained_handler_and_data(port->irq, NULL, NULL);
> +
> +	if (port->intx_domain)
> +		irq_domain_remove(port->intx_domain);
> +
> +	if (port->msi_domain)
> +		irq_domain_remove(port->msi_domain);
> +
> +	if (port->msi_top_domain) {
> +		for (i = 0; i < PCIE_MSI_SET_NUM; i++) {
> +			msi_info = port->msi_info[i];
> +			irq_dispose_mapping(msi_info->irq);
> +		}
> +
> +		irq_domain_remove(port->msi_top_domain);
> +	}
> +
> +	irq_dispose_mapping(port->irq);
> +}
> +
> +static void mtk_pcie_irq_handler(struct irq_desc *desc)
> +{
> +	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *irqchip = irq_desc_get_chip(desc);
> +	unsigned long status;
> +	u32 virq;
> +	u32 irq_bit = PCIE_INTX_SHIFT;
> +
> +	chained_irq_enter(irqchip, desc);
> +
> +	status = readl(port->base + PCIE_INT_STATUS_REG);
> +	if (status & PCIE_INTX_MASK) {
> +		for_each_set_bit_from(irq_bit, &status, PCI_NUM_INTX +
> +				      PCIE_INTX_SHIFT) {
> +			virq = irq_find_mapping(port->intx_domain,
> +						irq_bit - PCIE_INTX_SHIFT);
> +			generic_handle_irq(virq);
> +		}
> +	}
> +
> +	if (status & PCIE_MSI_MASK) {
> +		irq_bit = PCIE_MSI_SHIFT;
> +		for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
> +				      PCIE_MSI_SHIFT) {
> +			virq = irq_find_mapping(port->msi_top_domain,
> +						irq_bit - PCIE_MSI_SHIFT);
> +			generic_handle_irq(virq);
> +		}
> +	}
> +
> +	chained_irq_exit(irqchip, desc);
> +}
> +
> +static int mtk_pcie_setup_irq(struct mtk_pcie_port *port,
> +			      struct device_node *node)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int err;
> +
> +	err = mtk_pcie_init_irq_domains(port, node);
> +	if (err) {
> +		dev_notice(dev, "failed to init PCIe IRQ domain\n");
> +		return err;
> +	}
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0)
> +		return port->irq;
> +
> +	irq_set_chained_handler_and_data(port->irq, mtk_pcie_irq_handler, port);
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_clk_init(struct mtk_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct device_node *np = dev->of_node;
> +	int i;
> +
> +	port->num_clks = of_clk_get_parent_count(np);
> +	if (port->num_clks == 0) {
> +		dev_notice(dev, "pcie clock is not found\n");
> +		return -EINVAL;
> +	}
> +
> +	port->clks = devm_kzalloc(dev, port->num_clks, GFP_KERNEL);
> +	if (!port->clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < port->num_clks; i++) {
> +		struct clk      *clk;
> +		int             ret;
> +
> +		clk = of_clk_get(np, i);

Use the bulk clk APIs.

> +		if (IS_ERR(clk)) {
> +			while (--i >= 0)
> +				clk_put(port->clks[i]);
> +			return PTR_ERR(clk);
> +		}
> +
> +		ret = clk_prepare_enable(clk);
> +		if (ret < 0) {
> +			while (--i >= 0) {
> +				clk_disable_unprepare(port->clks[i]);
> +				clk_put(port->clks[i]);
> +			}
> +			clk_put(clk);
> +
> +			return ret;
> +		}
> +
> +		port->clks[i] = clk;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_disable_clk(struct mtk_pcie_port *port)
> +{
> +	int i;
> +
> +	if (port->num_clks == 0)
> +		return 0;
> +
> +	for (i = 0; i < port->num_clks; i++) {
> +		clk_disable_unprepare(port->clks[i]);
> +		clk_put(port->clks[i]);
> +	}

Use the bulk clk APIs.

> +
> +	port->num_clks = 0;
> +
> +	return 0;
> +}
> +
> +static int mtk_pcie_power_up(struct mtk_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	int err;
> +
> +	port->phy_reset = devm_reset_control_get_optional(dev, "phy-rst");
> +	if (PTR_ERR(port->phy_reset) == -EPROBE_DEFER)
> +		return PTR_ERR(port->phy_reset);
> +
> +	reset_control_deassert(port->phy_reset);
> +
> +	/* phy power on and enable pipe clock */
> +	port->phy = devm_phy_optional_get(dev, "pcie-phy");
> +	if (IS_ERR(port->phy))
> +		port->phy = NULL;

Optional get already returns NULL if the device isn't in DT. Any other 
error should be an error and you return.

> +
> +	err = phy_init(port->phy);
> +	if (err) {
> +		dev_notice(dev, "failed to initialize pcie phy\n");
> +		return -ENODEV;
> +	}
> +
> +	err = phy_power_on(port->phy);
> +	if (err) {
> +		dev_notice(dev, "failed to power on pcie phy\n");
> +		goto err_phy_on;
> +	}
> +
> +	port->mac_reset = devm_reset_control_get_optional(dev, "mac-rst");
> +	if (PTR_ERR(port->mac_reset) == -EPROBE_DEFER)
> +		return PTR_ERR(port->mac_reset);
> +
> +	reset_control_deassert(port->mac_reset);
> +
> +	/* mac power on and enable transaction layer clocks */
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
> +
> +	err = mtk_pcie_clk_init(port);
> +	if (err) {
> +		dev_notice(dev, "clock init failed\n");
> +		goto err_clk_init;
> +	}
> +
> +	return 0;
> +
> +err_clk_init:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	reset_control_assert(port->mac_reset);
> +	phy_power_off(port->phy);
> +err_phy_on:
> +	phy_exit(port->phy);
> +	reset_control_assert(port->phy_reset);
> +
> +	return -EBUSY;
> +}
> +
> +static void mtk_pcie_power_down(struct mtk_pcie_port *port)
> +{
> +	phy_power_off(port->phy);
> +	phy_exit(port->phy);
> +
> +	mtk_pcie_disable_clk(port);
> +
> +	pm_runtime_put_sync(port->dev);
> +	pm_runtime_disable(port->dev);
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
> +	if (IS_ERR(port->base)) {
> +		dev_notice(dev, "failed to map register base\n");
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
> +		dev_notice(dev, "PCIe link down\n");
> +		goto err_setup;
> +	}
> +
> +	err = mtk_pcie_setup_irq(port, dev->of_node);
> +	if (err)
> +		goto err_setup;
> +
> +	dev_info(dev, "PCIe link up success!\n");
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
> +	host->dev.parent = port->dev;

You can drop this now. The core sets it.

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
> +	pci_stop_root_bus(host->bus);
> +	pci_remove_root_bus(host->bus);

There's supposed to be a lock around this. See other cases.

> +
> +	mtk_pcie_irq_teardown(port);
> +	mtk_pcie_power_down(port);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mtk_pcie_turn_off_link(struct mtk_pcie_port *port)
> +{
> +	int val;
> +
> +	val = readl(port->base + PCIE_ICMD_PM_REG);
> +	val |= PCIE_TURN_OFF_LINK;
> +	writel(val, port->base + PCIE_ICMD_PM_REG);
> +
> +	/* Check the link is L2 */
> +	return readl_poll_timeout(port->base + PCIE_LTSSM_STATUS_REG, val,
> +				  (PCIE_LTSSM_STATE(val) ==
> +				   PCIE_LTSSM_STATE_L2_IDLE), 20,
> +				   50 * USEC_PER_MSEC);
> +}
> +
> +static int __maybe_unused mtk_pcie_suspend_noirq(struct device *dev)

Why do you need the noirq variant?

> +{
> +	struct mtk_pcie_port *port = dev_get_drvdata(dev);
> +	int i, err, val;
> +
> +	if (port->is_suspended)
> +		return 0;
> +
> +	/* Trigger link to L2 state */
> +	err = mtk_pcie_turn_off_link(port);
> +	if (err) {
> +		dev_notice(port->dev, "can not enter L2 state\n");
> +		goto power_off;
> +	}
> +
> +	/* Pull down the PERST# pin */
> +	val = readl(port->base + PCIE_RST_CTRL_REG);
> +	val |= PCIE_PE_RSTB;
> +	writel(val, port->base + PCIE_RST_CTRL_REG);
> +
> +	dev_info(port->dev, "enter L2 state success");
> +
> +power_off:
> +	phy_power_off(port->phy);
> +
> +	for (i = 0; i < port->num_clks; i++)
> +		clk_disable_unprepare(port->clks[i]);
> +
> +	pm_runtime_put_sync(port->dev);

Normally, clock control would be within the pm-runtime hooks. What 
pm-runtime control are you doing?

> +
> +	port->is_suspended = true;
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mtk_pcie_resume_noirq(struct device *dev)
> +{
> +	struct mtk_pcie_port *port = dev_get_drvdata(dev);
> +	int i, err;
> +
> +	if (!port->is_suspended)
> +		return 0;
> +
> +	phy_power_on(port->phy);
> +
> +	pm_runtime_get_sync(port->dev);
> +
> +	for (i = 0; i < port->num_clks; i++) {
> +		err = clk_prepare_enable(port->clks[i]);
> +		if (err < 0) {
> +			while (--i >= 0)
> +				clk_disable_unprepare(port->clks[i]);
> +			return err;
> +		}
> +	}
> +
> +	err = mtk_pcie_startup_port(port);
> +	if (err) {
> +		dev_notice(port->dev, "resume failed\n");
> +		return err;
> +	}
> +
> +	port->is_suspended = false;
> +
> +	dev_info(port->dev, "resume done\n");
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops mtk_pcie_pm_ops = {
> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_pcie_suspend_noirq,
> +				      mtk_pcie_resume_noirq)
> +};
> +
> +static const struct of_device_id mtk_pcie_of_match[] = {
> +	{ .compatible = "mediatek,gen3-pcie" },
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
> +		.suppress_bind_attrs = true,

Why? You support being a module, so this should be dropped.

> +		.pm = &mtk_pcie_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(mtk_pcie_driver);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.25.1
