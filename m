Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E7638F35D
	for <lists+linux-pci@lfdr.de>; Mon, 24 May 2021 20:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhEXTAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 May 2021 15:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232709AbhEXTAJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 May 2021 15:00:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87D6613F5;
        Mon, 24 May 2021 18:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621882721;
        bh=Pl0AdeltIl3jwAdA5YdZicHdoQ8EH20Li4EGL1xadNU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qoGmyp+9cP7/ACsoBCogxfiJSrWjcPbSIzEhMtG2hSkCTaMDEL7qi+c9R1BQbhBWr
         Ia+BkQqpMojrzsNBx1D1TQ9EGGK9B+AvHaECkKvgKSUEE8/euJi1XPaqabtXeuk9cX
         28vj/Yl7/nekpAlClDussT0A6tXaWDmbHgsLBEXcwxmAU3ZKYLnLjSwlY+XMvStPuQ
         JB/yMIc+k+n4zW9wuE91Z0QOs8GZlhG5m1+yC95uag5oXF6styFbpawvzl7LtWpBre
         CE8f83SL8YiU/Equ92LbVMXTnGM0rrLCCOWjQRzq5hZzSmG2y5gTPaFo0Oi74QYCdd
         ik0xxfVwxfbMg==
Date:   Mon, 24 May 2021 13:58:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 2/3] PCI: Visconti: Add Toshiba Visconti PCIe host
 controller driver
Message-ID: <20210524185839.GA1102116@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524063004.132043-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Kishon for cpu_addr_fixup() question]

Please make the subject "PCI: visconti: Add ..." since the driver
names are usually lower-case.  When referring to the hardware itself,
use "Visconti", of course.

On Mon, May 24, 2021 at 03:30:03PM +0900, Nobuhiro Iwamatsu wrote:
> Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe
> controller is based of Synopsys DesignWare PCIe core.
> 
> This patch does not yet use the clock framework to control the clock.
> This will be replaced in the future.
> 
> v2 -> v3:
>   - Update subject.
>   - Wrap description in 75 columns.
>   - Change config name to PCIE_VISCONTI_HOST.
>   - Update Kconfig text.
>   - Drop blank lines.
>   - Adjusted to 80 columns.
>   - Drop inline from functions for register access.
>   - Changed function name from visconti_pcie_check_link_status to
>     visconti_pcie_link_up.
>   - Update to using dw_pcie_host_init().
>   - Reorder these in the order of use in visconti_pcie_establish_link.
>   - Rewrite visconti_pcie_host_init() without dw_pcie_setup_rc().
>   - Change function name from  visconti_device_turnon() to
>     visconti_pcie_power_on().
>   - Unify formats such as dev_err().
>   - Drop error label in visconti_add_pcie_port().
> 
> v1 -> v2:
>   - Fix typo in commit message.
>   - Drop "depends on OF && HAS_IOMEM" from Kconfig.
>   - Stop using the pointer of struct dw_pcie.
>   - Use _relaxed variant.
>   - Drop dw_pcie_wait_for_link.
>   - Drop dbi resource processing.
>   - Drop MSI IRQ initialization processing.

Thanks for the changelog.  Please move it after the "---" line for
future versions.  That way it won't appear in the commit log when this
is merged.  The notes about v1->v2, v2->v3, etc are useful during
review, but not after this is merged.

> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/pci/controller/dwc/Kconfig         |   9 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-visconti.c | 369 +++++++++++++++++++++
>  3 files changed, 379 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 423d35872ce4..7c3dcb86fcad 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -286,6 +286,15 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>  
> +config PCIE_VISCONTI_HOST
> +	bool "Toshiba Visconti PCIe controllers"
> +	depends on ARCH_VISCONTI || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> +	  This driver supports TMPV7708 SoC.
> +
>  config PCIE_UNIPHIER
>  	bool "Socionext UniPhier PCIe host controllers"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index eca805c1a023..0b569d54deb3 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) += pci-meson.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> +obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> new file mode 100644
> index 000000000000..b764334f32e6
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -0,0 +1,369 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DWC PCIe RC driver for Toshiba Visconti ARM SoC
> + *
> + * Copyright (C) 2021 Toshiba Electronic Device & Storage Corporation
> + * Copyright (C) 2021 TOSHIBA CORPORATION
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/interrupt.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/of_platform.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +#include "../../pci.h"
> +
> +struct visconti_pcie {
> +	struct dw_pcie pci;
> +	void __iomem *ulreg_base;
> +	void __iomem *smu_base;
> +	void __iomem *mpu_base;
> +	struct clk *refclk;
> +	struct clk *sysclk;
> +	struct clk *auxclk;
> +};
> +
> +#define PCIE_UL_REG_S_PCIE_MODE		0x00F4
> +#define  PCIE_UL_REG_S_PCIE_MODE_EP	0x00
> +#define  PCIE_UL_REG_S_PCIE_MODE_RC	0x04
> +
> +#define PCIE_UL_REG_S_PERSTN_CTRL	0x00F8
> +#define  PCIE_UL_IOM_PCIE_PERSTN_I_EN	BIT(3)
> +#define  PCIE_UL_DIRECT_PERSTN_EN	BIT(2)
> +#define  PCIE_UL_PERSTN_OUT		BIT(1)
> +#define  PCIE_UL_DIRECT_PERSTN		BIT(0)
> +#define  PCIE_UL_REG_S_PERSTN_CTRL_INIT	(PCIE_UL_IOM_PCIE_PERSTN_I_EN | \
> +					 PCIE_UL_DIRECT_PERSTN_EN | \
> +					 PCIE_UL_DIRECT_PERSTN)
> +
> +#define PCIE_UL_REG_S_PHY_INIT_02	0x0104
> +#define  PCIE_UL_PHY0_SRAM_EXT_LD_DONE	BIT(0)
> +
> +#define PCIE_UL_REG_S_PHY_INIT_03	0x0108
> +#define  PCIE_UL_PHY0_SRAM_INIT_DONE	BIT(0)
> +
> +#define PCIE_UL_REG_S_INT_EVENT_MASK1	0x0138
> +#define  PCIE_UL_CFG_PME_INT		BIT(0)
> +#define  PCIE_UL_CFG_LINK_EQ_REQ_INT	BIT(1)
> +#define  PCIE_UL_EDMA_INT0		BIT(2)
> +#define  PCIE_UL_EDMA_INT1		BIT(3)
> +#define  PCIE_UL_EDMA_INT2		BIT(4)
> +#define  PCIE_UL_EDMA_INT3		BIT(5)
> +#define  PCIE_UL_S_INT_EVENT_MASK1_ALL  (PCIE_UL_CFG_PME_INT | \
> +					 PCIE_UL_CFG_LINK_EQ_REQ_INT | \
> +					 PCIE_UL_EDMA_INT0 | \
> +					 PCIE_UL_EDMA_INT1 | \
> +					 PCIE_UL_EDMA_INT2 | \
> +					 PCIE_UL_EDMA_INT3)
> +
> +#define PCIE_UL_REG_S_SB_MON		0x0198
> +#define PCIE_UL_REG_S_SIG_MON		0x019C
> +#define  PCIE_UL_CORE_RST_N_MON		BIT(0)
> +
> +#define PCIE_UL_REG_V_SII_DBG_00	0x0844
> +#define PCIE_UL_REG_V_SII_GEN_CTRL_01	0x0860
> +#define  PCIE_UL_APP_LTSSM_ENABLE	BIT(0)
> +
> +#define PCIE_UL_REG_V_PHY_ST_00		0x0864
> +#define  PCIE_UL_SMLH_LINK_UP		BIT(0)
> +
> +#define PCIE_UL_REG_V_PHY_ST_02		0x0868
> +#define  PCIE_UL_S_DETECT_ACT		0x01
> +#define  PCIE_UL_S_L0			0x11
> +
> +#define PISMU_CKON_PCIE			0x0038
> +#define  PISMU_CKON_PCIE_AUX_CLK	BIT(1)
> +#define  PISMU_CKON_PCIE_MSTR_ACLK	BIT(0)
> +
> +#define PISMU_RSOFF_PCIE		0x0538
> +#define  PISMU_RSOFF_PCIE_ULREG_RST_N	BIT(1)
> +#define  PISMU_RSOFF_PCIE_PWR_UP_RST_N	BIT(0)
> +
> +#define PCIE_MPU_REG_MP_EN		0x0
> +#define  MPU_MP_EN_DISABLE		BIT(0)
> +
> +#define PCIE_BUS_OFFSET			0x40000000
> +
> +/* Access registers in PCIe ulreg */
> +static void visconti_ulreg_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->ulreg_base + reg);
> +}
> +
> +static u32 visconti_ulreg_readl(struct visconti_pcie *pcie, u32 reg)
> +{
> +	return readl_relaxed(pcie->ulreg_base + reg);
> +}
> +
> +/* Access registers in PCIe smu */
> +static void visconti_smu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->smu_base + reg);
> +}
> +
> +/* Access registers in PCIe mpu */
> +static void visconti_mpu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->mpu_base + reg);
> +}
> +
> +static u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)
> +{
> +	return readl_relaxed(pcie->mpu_base + reg);
> +}
> +
> +static int visconti_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> +	void __iomem *addr = pcie->ulreg_base;
> +	int ret;
> +	u32 val;
> +
> +	/* wait for linkup of phy link layer */
> +	ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_00,
> +					 val, (val & PCIE_UL_SMLH_LINK_UP),
> +					 90000, 100000);
> +	if (ret)
> +		return 0;
> +
> +	/* wait for linkup of data link layer */
> +	ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_02,
> +					 val, (val & PCIE_UL_S_DETECT_ACT),
> +					 90000, 100000);
> +	if (ret)
> +		return 0;
> +
> +	/* wait for LTSSM Status */
> +	ret = readl_relaxed_poll_timeout(addr + PCIE_UL_REG_V_PHY_ST_02,
> +					 val, (val & PCIE_UL_S_L0),
> +					 90000, 100000);
> +	if (ret)
> +		return 0;
> +	return 1;
> +}
> +
> +static int visconti_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_APP_LTSSM_ENABLE,
> +			      PCIE_UL_REG_V_SII_GEN_CTRL_01);
> +
> +	if (dw_pcie_link_up(pci)) {
> +		u32 val;
> +
> +		val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
> +		visconti_mpu_writel(pcie, val & ~MPU_MP_EN_DISABLE,
> +				    PCIE_MPU_REG_MP_EN);
> +		visconti_ulreg_writel(pcie, PCIE_UL_S_INT_EVENT_MASK1_ALL,
> +				      PCIE_UL_REG_S_INT_EVENT_MASK1);
> +	}
> +
> +	return 0;
> +}
> +
> +static void visconti_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> +	u32 val;
> +
> +	val = visconti_ulreg_readl(pcie, PCIE_UL_REG_V_SII_GEN_CTRL_01);
> +	val &= ~PCIE_UL_APP_LTSSM_ENABLE;
> +	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_V_SII_GEN_CTRL_01);
> +
> +	val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
> +	visconti_mpu_writel(pcie, val | MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
> +}
> +
> +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
> +{
> +	return pci_addr - PCIE_BUS_OFFSET;

This is called from __dw_pcie_prog_outbound_atu() as:

  cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);

so I think the parameter here should be *cpu_addr*, not pci_addr.

dra7xx and artpec6 also call it "pci_addr", which is at best
confusing.

I'm also confused about exactly what .cpu_addr_fixup() does.  Is it
applying an offset that cannot be deduced from the DT description?  If
so, *should* this offset be described in DT?

> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
> +	.link_up = visconti_pcie_link_up,
> +	.start_link = visconti_pcie_start_link,
> +	.stop_link = visconti_pcie_stop_link,
> +};
> +
> +static int visconti_pcie_power_on(struct visconti_pcie *pcie)
> +{
> +	void __iomem *addr;
> +	int err;
> +	u32 val;
> +
> +	visconti_smu_writel(pcie,
> +			    PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
> +			    PISMU_CKON_PCIE);
> +	ndelay(250);
> +
> +	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_ULREG_RST_N,
> +			    PISMU_RSOFF_PCIE);
> +	visconti_ulreg_writel(pcie, PCIE_UL_REG_S_PCIE_MODE_RC,
> +			      PCIE_UL_REG_S_PCIE_MODE);
> +
> +	val = PCIE_UL_REG_S_PERSTN_CTRL_INIT;
> +	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> +	udelay(100);
> +
> +	val |= PCIE_UL_PERSTN_OUT;
> +	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> +	udelay(100);
> +
> +	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_PWR_UP_RST_N,
> +			    PISMU_RSOFF_PCIE);
> +
> +	addr = pcie->ulreg_base + PCIE_UL_REG_S_PHY_INIT_03;
> +	err = readl_relaxed_poll_timeout(addr, val,
> +					 (val & PCIE_UL_PHY0_SRAM_INIT_DONE),
> +					 100, 1000);
> +	if (err)
> +		return err;
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_PHY0_SRAM_EXT_LD_DONE,
> +			      PCIE_UL_REG_S_PHY_INIT_02);
> +
> +	addr = pcie->ulreg_base + PCIE_UL_REG_S_SIG_MON;
> +	return readl_relaxed_poll_timeout(addr, val,
> +					  (val & PCIE_UL_CORE_RST_N_MON), 100,
> +					  1000);
> +}
> +
> +static int visconti_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> +
> +	return visconti_pcie_power_on(pcie);

This bears very little resemblance to the .host_init() functions of
other dwc-based drivers.  It'd be nice if they were more consistent.
But if there are real hardware differences causing these driver
differences, that's ok.  I see a couple (meson, kirin) that call a
*power_on() function from *_pcie_probe().  

> +}
> +
> +static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
> +	.host_init = visconti_pcie_host_init,
> +};
> +
> +static int visconti_get_resources(struct platform_device *pdev,
> +				  struct visconti_pcie *pcie)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	pcie->ulreg_base = devm_platform_ioremap_resource_byname(pdev, "ulreg");
> +	if (IS_ERR(pcie->ulreg_base))
> +		return PTR_ERR(pcie->ulreg_base);
> +
> +	pcie->smu_base = devm_platform_ioremap_resource_byname(pdev, "smu");
> +	if (IS_ERR(pcie->smu_base))
> +		return PTR_ERR(pcie->smu_base);
> +
> +	pcie->mpu_base = devm_platform_ioremap_resource_byname(pdev, "mpu");
> +	if (IS_ERR(pcie->mpu_base))
> +		return PTR_ERR(pcie->mpu_base);
> +
> +	pcie->refclk = devm_clk_get(dev, "pcie_refclk");
> +	if (IS_ERR(pcie->refclk)) {
> +		dev_err(dev, "Failed to get refclk clock: %ld\n",
> +			PTR_ERR(pcie->refclk));
> +		return PTR_ERR(pcie->refclk);
> +	}
> +
> +	pcie->sysclk = devm_clk_get(dev, "sysclk");
> +	if (IS_ERR(pcie->sysclk)) {
> +		dev_err(dev, "Failed to get sysclk clock: %ld\n",
> +			PTR_ERR(pcie->sysclk));
> +		return PTR_ERR(pcie->sysclk);
> +	}
> +
> +	pcie->auxclk = devm_clk_get(dev, "auxclk");
> +	if (IS_ERR(pcie->auxclk)) {
> +		dev_err(dev, "Failed to get auxclk clock: %ld\n",
> +			PTR_ERR(pcie->auxclk));
> +		return PTR_ERR(pcie->auxclk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int
> +visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (pp->irq < 0) {
> +		dev_err(dev, "Interrupt intr is missing");
> +		return pp->irq;
> +	}

Looks like most drivers use "pp->irq = platform_get_irq(pdev, 0);"
Is there a reason for this to be different?

> +	pp->ops = &visconti_pcie_host_ops;
> +
> +	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> +	if (pci->link_gen < 0 || pci->link_gen > 3) {
> +		pci->link_gen = 3;
> +		dev_dbg(dev, "Applied default link speed\n");
> +	}
> +
> +	dev_dbg(dev, "Link speed Gen %d", pci->link_gen);
> +
> +	return dw_pcie_host_init(pp);
> +}
> +
> +static int visconti_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct visconti_pcie *pcie;
> +	struct pcie_port *pp;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +	if (ret)
> +		return ret;

Somewhat unusual in PCIe controller drivers.  Is there something
unusual about the Visconti hardware?

Also looks a little suspicious since the sequence is:

  visconti_pcie_probe
    dma_set_mask_and_coherent(DMA_BIT_MASK(36))
    visconti_add_pcie_port
      dw_pcie_host_init
        if (pci_msi_enabled())
          dma_set_mask(DMA_BIT_MASK(32))

so dw_pcie_host_init() will override part of what we're setting here.

> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pp = &pci->pp;
> +	pp->num_vectors = MAX_MSI_IRQS;

Is this necessary?  I can't tell that this driver even implements MSI
support.  It looks like tegra194 is the only other driver that sets
num_vectors itself.

> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +
> +	ret = visconti_get_resources(pdev, pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	return visconti_add_pcie_port(pcie, pdev);
> +}
> +
> +static const struct of_device_id visconti_pcie_match[] = {
> +	{ .compatible = "toshiba,visconti-pcie" },
> +	{},
> +};
> +
> +static struct platform_driver visconti_pcie_driver = {
> +	.probe = visconti_pcie_probe,
> +	.driver = {
> +		.name = "visconti-pcie",
> +		.of_match_table = visconti_pcie_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(visconti_pcie_driver);
> -- 
> 2.31.1
> 
