Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1E4213909E
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAMMCy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 07:02:54 -0500
Received: from foss.arm.com ([217.140.110.172]:38470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgAMMCx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 07:02:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6A9B13D5;
        Mon, 13 Jan 2020 04:02:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23CB73F6C4;
        Mon, 13 Jan 2020 04:02:52 -0800 (PST)
Date:   Mon, 13 Jan 2020 12:02:50 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv9 10/12] PCI: mobiveil: Add PCIe Gen4 RC driver for NXP
 Layerscape SoCs
Message-ID: <20200113120249.GO42593@e119886-lin.cambridge.arm.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-11-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191120034451.30102-11-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 20, 2019 at 03:46:23AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This PCIe controller is based on the Mobiveil GPEX IP, which is
> compatible with the PCI Express™ Base Specification, Revision 4.0.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
> ---
>  drivers/pci/controller/mobiveil/Kconfig       |  10 +
>  drivers/pci/controller/mobiveil/Makefile      |   1 +
>  .../mobiveil/pcie-layerscape-gen4.c           | 274 ++++++++++++++++++
>  .../pci/controller/mobiveil/pcie-mobiveil.h   |  16 +-
>  4 files changed, 299 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> 
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> index 64343c07bfed..c823be8dab1c 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -21,4 +21,14 @@ config PCIE_MOBIVEIL_PLAT
>  	  Soft IP. It has up to 8 outbound and inbound windows
>  	  for address translation and it is a PCIe Gen4 IP.
>  
> +config PCIE_LAYERSCAPE_GEN4
> +	bool "Freescale Layerscape PCIe Gen4 controller"
> +	depends on PCI
> +	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_MOBIVEIL_HOST
> +	help
> +	  Say Y here if you want PCIe Gen4 controller support on
> +	  Layerscape SoCs. The PCIe controller can work in RC or
> +	  EP mode according to RCW[HOST_AGT_PEX] setting.

I think you can remove the last sentence - it doesn't give any value
to users of KConfig.


>  endmenu
> diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
> index 9fb6d1c6504d..99d879de32d6 100644
> --- a/drivers/pci/controller/mobiveil/Makefile
> +++ b/drivers/pci/controller/mobiveil/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
>  obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
> +obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie-layerscape-gen4.o
> diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> new file mode 100644
> index 000000000000..6c0d3e2532db
> --- /dev/null
> +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c
> @@ -0,0 +1,274 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe Gen4 host controller driver for NXP Layerscape SoCs
> + *
> + * Copyright 2019 NXP
> + *
> + * Author: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pcie-mobiveil.h"
> +
> +/* LUT and PF control registers */
> +#define PCIE_LUT_OFF			0x80000
> +#define PCIE_PF_OFF			0xc0000
> +#define PCIE_PF_INT_STAT		0x18
> +#define PF_INT_STAT_PABRST		BIT(31)
> +
> +#define PCIE_PF_DBG			0x7fc
> +#define PF_DBG_LTSSM_MASK		0x3f
> +#define PF_DBG_LTSSM_L0			0x2d /* L0 state */
> +#define PF_DBG_WE			BIT(31)
> +#define PF_DBG_PABR			BIT(27)
> +
> +#define to_ls_pcie_g4(x)		platform_get_drvdata((x)->pdev)
> +
> +struct ls_pcie_g4 {
> +	struct mobiveil_pcie pci;
> +	struct delayed_work dwork;
> +	int irq;
> +};
> +
> +static inline u32 ls_pcie_g4_lut_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
> +}
> +
> +static inline void ls_pcie_g4_lut_writel(struct ls_pcie_g4 *pcie,
> +					 u32 off, u32 val)
> +{
> +	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_LUT_OFF + off);
> +}
> +
> +static inline u32 ls_pcie_g4_pf_readl(struct ls_pcie_g4 *pcie, u32 off)
> +{
> +	return ioread32(pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
> +}
> +
> +static inline void ls_pcie_g4_pf_writel(struct ls_pcie_g4 *pcie,
> +					u32 off, u32 val)
> +{
> +	iowrite32(val, pcie->pci.csr_axi_slave_base + PCIE_PF_OFF + off);
> +}
> +
> +static bool ls_pcie_g4_is_bridge(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +	u32 header_type;
> +
> +	header_type = mobiveil_csr_readb(mv_pci, PCI_HEADER_TYPE);
> +	header_type &= 0x7f;
> +
> +	return header_type == PCI_HEADER_TYPE_BRIDGE;
> +}
> +
> +static int ls_pcie_g4_link_up(struct mobiveil_pcie *pci)
> +{
> +	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(pci);
> +	u32 state;
> +
> +	state = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	state =	state & PF_DBG_LTSSM_MASK;
> +
> +	if (state == PF_DBG_LTSSM_L0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void ls_pcie_g4_disable_interrupt(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +
> +	mobiveil_csr_writel(mv_pci, 0, PAB_INTP_AMBA_MISC_ENB);
> +}
> +
> +static void ls_pcie_g4_enable_interrupt(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +	u32 val;
> +
> +	/* Clear the interrupt status */
> +	mobiveil_csr_writel(mv_pci, 0xffffffff, PAB_INTP_AMBA_MISC_STAT);
> +
> +	val = PAB_INTP_INTX_MASK | PAB_INTP_MSI | PAB_INTP_RESET |
> +	      PAB_INTP_PCIE_UE | PAB_INTP_IE_PMREDI | PAB_INTP_IE_EC;
> +	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_ENB);
> +}
> +
> +static void ls_pcie_g4_reinit_hw(struct ls_pcie_g4 *pcie)
> +{
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +	struct device *dev = &mv_pci->pdev->dev;
> +	u32 val, act_stat;
> +	int to = 100;
> +
> +	/* Poll for pab_csb_reset to set and PAB activity to clear */
> +	do {
> +		usleep_range(10, 15);
> +		val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_INT_STAT);
> +		act_stat = mobiveil_csr_readl(mv_pci, PAB_ACTIVITY_STAT);
> +	} while (((val & PF_INT_STAT_PABRST) == 0 || act_stat) && to--);
> +	if (to < 0) {
> +		dev_err(dev, "Poll PABRST&PABACT timeout\n");
> +		return;

If a timeout happens here - the caller has no idea this has happened
and yet the following work doesn't get done. Isn't this a problem?

> +	}
> +
> +	/* clear PEX_RESET bit in PEX_PF0_DBG register */
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val |= PF_DBG_WE;
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val |= PF_DBG_PABR;
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	val = ls_pcie_g4_pf_readl(pcie, PCIE_PF_DBG);
> +	val &= ~PF_DBG_WE;
> +	ls_pcie_g4_pf_writel(pcie, PCIE_PF_DBG, val);
> +
> +	mobiveil_host_init(mv_pci, true);

Can mobiveil_host_init fail?

> +
> +	to = 100;
> +	while (!ls_pcie_g4_link_up(mv_pci) && to--)
> +		usleep_range(200, 250);
> +	if (to < 0)
> +		dev_err(dev, "PCIe link training timeout\n");
> +}
> +
> +static irqreturn_t ls_pcie_g4_isr(int irq, void *dev_id)
> +{
> +	struct ls_pcie_g4 *pcie = (struct ls_pcie_g4 *)dev_id;
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +	u32 val;
> +
> +	val = mobiveil_csr_readl(mv_pci, PAB_INTP_AMBA_MISC_STAT);
> +	if (!val)
> +		return IRQ_NONE;
> +
> +	if (val & PAB_INTP_RESET) {

Can you explain why this is needed (perhaps also in the cover letter)?

> +		ls_pcie_g4_disable_interrupt(pcie);
> +		schedule_delayed_work(&pcie->dwork, msecs_to_jiffies(1));
> +	}
> +
> +	mobiveil_csr_writel(mv_pci, val, PAB_INTP_AMBA_MISC_STAT);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ls_pcie_g4_interrupt_init(struct mobiveil_pcie *mv_pci)
> +{
> +	struct ls_pcie_g4 *pcie = to_ls_pcie_g4(mv_pci);
> +	struct platform_device *pdev = mv_pci->pdev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pcie->irq = platform_get_irq_byname(pdev, "intr");
> +	if (pcie->irq < 0) {
> +		dev_err(dev, "Can't get 'intr' IRQ, errno = %d\n", pcie->irq);
> +		return pcie->irq;
> +	}
> +	ret = devm_request_irq(dev, pcie->irq, ls_pcie_g4_isr,
> +			       IRQF_SHARED, pdev->name, pcie);
> +	if (ret) {
> +		dev_err(dev, "Can't register PCIe IRQ, errno = %d\n", ret);
> +		return  ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ls_pcie_g4_reset(struct work_struct *work)
> +{
> +	struct delayed_work *dwork = container_of(work, struct delayed_work,
> +						  work);
> +	struct ls_pcie_g4 *pcie = container_of(dwork, struct ls_pcie_g4, dwork);
> +	struct mobiveil_pcie *mv_pci = &pcie->pci;
> +	u16 ctrl;
> +
> +	ctrl = mobiveil_csr_readw(mv_pci, PCI_BRIDGE_CONTROL);
> +	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
> +	mobiveil_csr_writew(mv_pci, ctrl, PCI_BRIDGE_CONTROL);
> +	ls_pcie_g4_reinit_hw(pcie);
> +	ls_pcie_g4_enable_interrupt(pcie);
> +}
> +
> +static struct mobiveil_rp_ops ls_pcie_g4_rp_ops = {
> +	.interrupt_init = ls_pcie_g4_interrupt_init,
> +};
> +
> +static const struct mobiveil_pab_ops ls_pcie_g4_pab_ops = {
> +	.link_up = ls_pcie_g4_link_up,
> +};
> +
> +static int __init ls_pcie_g4_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct mobiveil_pcie *mv_pci;
> +	struct ls_pcie_g4 *pcie;
> +	struct device_node *np = dev->of_node;
> +	int ret;
> +
> +	if (!of_parse_phandle(np, "msi-parent", 0)) {
> +		dev_err(dev, "Failed to find msi-parent\n");
> +		return -EINVAL;
> +	}
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	pcie = pci_host_bridge_priv(bridge);
> +	mv_pci = &pcie->pci;
> +
> +	mv_pci->pdev = pdev;
> +	mv_pci->ops = &ls_pcie_g4_pab_ops;
> +	mv_pci->rp.ops = &ls_pcie_g4_rp_ops;
> +	mv_pci->rp.bridge = bridge;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	INIT_DELAYED_WORK(&pcie->dwork, ls_pcie_g4_reset);
> +
> +	ret = mobiveil_pcie_host_probe(mv_pci);
> +	if (ret) {
> +		dev_err(dev, "Fail to probe\n");
> +		return  ret;
> +	}
> +
> +	if (!ls_pcie_g4_is_bridge(pcie))

Is this a check that could apply to all host bridge drivers and thus live
in mobiveil_pcie_host_probe?

> +		return -ENODEV;
> +
> +	ls_pcie_g4_enable_interrupt(pcie);

Is there an issue here in that we enable interrupts *after* telling the kernel
about our controller? (Same applies for bailing if the IP isn't a bridge).

Thanks,

Andrew Murray

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ls_pcie_g4_of_match[] = {
> +	{ .compatible = "fsl,lx2160a-pcie", },
> +	{ },
> +};
> +
> +static struct platform_driver ls_pcie_g4_driver = {
> +	.driver = {
> +		.name = "layerscape-pcie-gen4",
> +		.of_match_table = ls_pcie_g4_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver_probe(ls_pcie_g4_driver, ls_pcie_g4_probe);
> diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> index 750a7fd95bc1..c57a68d2bac4 100644
> --- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> +++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
> @@ -43,6 +43,8 @@
>  #define  PAGE_LO_MASK			0x3ff
>  #define  PAGE_SEL_OFFSET_SHIFT		10
>  
> +#define PAB_ACTIVITY_STAT		0x81c
> +
>  #define PAB_AXI_PIO_CTRL		0x0840
>  #define  APIO_EN_MASK			0xf
>  
> @@ -51,8 +53,18 @@
>  
>  #define PAB_INTP_AMBA_MISC_ENB		0x0b0c
>  #define PAB_INTP_AMBA_MISC_STAT		0x0b1c
> -#define  PAB_INTP_INTX_MASK		0x01e0
> -#define  PAB_INTP_MSI_MASK		0x8
> +#define  PAB_INTP_RESET			BIT(1)
> +#define  PAB_INTP_MSI			BIT(3)
> +#define  PAB_INTP_INTA			BIT(5)
> +#define  PAB_INTP_INTB			BIT(6)
> +#define  PAB_INTP_INTC			BIT(7)
> +#define  PAB_INTP_INTD			BIT(8)
> +#define  PAB_INTP_PCIE_UE		BIT(9)
> +#define  PAB_INTP_IE_PMREDI		BIT(29)
> +#define  PAB_INTP_IE_EC			BIT(30)
> +#define  PAB_INTP_MSI_MASK		PAB_INTP_MSI
> +#define  PAB_INTP_INTX_MASK		(PAB_INTP_INTA | PAB_INTP_INTB |\
> +					PAB_INTP_INTC | PAB_INTP_INTD)
>  
>  #define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
>  #define  WIN_ENABLE_SHIFT		0
> -- 
> 2.17.1
> 
