Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73036F2D2
	for <lists+linux-pci@lfdr.de>; Fri, 30 Apr 2021 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhD2XL3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Apr 2021 19:11:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhD2XL3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Apr 2021 19:11:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4FB961445;
        Thu, 29 Apr 2021 23:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619737842;
        bh=MysNyOtbY1Vxq8fQpmBmTz4JwQokSuV2eiYUrv0I21c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oNswTqy6LKch4xQH+Zbvlc3vUBYKuHnn+gfrl3IVmBpc7fPMAqIKV35b2WHLFkWjQ
         b6F+qsH93dSzKtOd6wDnXMJVGNlKaEUEUWeRNxKDFr8Foi5fqIjXvWvos+4fzBdnpQ
         27gY1upYYGbZ+dyuuTFiE2rrp8UZvbQcP3wec0sQTGBDtjMGnqZsj9WmCEvBclvqAY
         7OdS2+NerAznY1WIyWgnRUZkxal8Dx/B7wCMv45hOO+FWU+Cewrr1aVlhwE7hW6iCU
         mHdSOGu3+zKwS2dOq1QnaqUWfYDQcLMt0gz3IVQSDZZrKXqU6rgVd1ZMSUm8VKIO4I
         IM3NYbvXDv5hw==
Date:   Thu, 29 Apr 2021 18:10:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] PCI: dwc: Visconti: PCIe RC controller driver
Message-ID: <20210429231040.GA589969@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419063513.1947003-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Please use something like this as the subject to match existing
convention:

  PCI: visconti: Add Toshiba Visconti PCIe host controller driver

(You can use "git log --oneline drivers/pci/controller/dwc" to learn
this.)

On Mon, Apr 19, 2021 at 03:35:12PM +0900, Nobuhiro Iwamatsu wrote:
> Add support to PCIe RC controller on Toshiba Visconti ARM SoCs. PCIe controller is based of Synopsys
> DesignWare PCIe core.
> 
> This patch does not yet use the clock framework to control the clock. This will be replaced in the
> future.

Wrap this text to fit nicely in 75 columns.

> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/pci/controller/dwc/Kconfig         |   9 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-visconti.c | 333 +++++++++++++++++++++
>  3 files changed, 343 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b9aaa84452c4..043c2c70d566 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -286,6 +286,15 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>  
> +config PCIE_VISCONTI

Consider using PCIE_VISCONTI_HOST in case you ever adapt this hardware
to work in endpoint mode.

> +	bool "Toshiba VISCONTI PCIe controllers"

s/VISCONTI/Visconti/ to match usage below.

> +	depends on ARCH_VISCONTI || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> +	  This driver supports TMPV77xx.

What is "TMPV77xx"?  A SoC?  A reference platform?

>  config PCIE_UNIPHIER
>  	bool "Socionext UniPhier PCIe host controllers"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index ba7c42f6df6f..46ac5d49dc75 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -20,6 +20,7 @@ obj-$(CONFIG_PCI_MESON) += pci-meson.o
>  obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> +obj-$(CONFIG_PCIE_VISCONTI) += pcie-visconti.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> new file mode 100644
> index 000000000000..a4739e7187f0
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -0,0 +1,333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DWC PCIe RC driver for Toshiba Visconti ARM SoC
> + *
> + * Copyright (C) 2019, 2020 Toshiba Electronic Device & Storage Corporation
> + * Copyright (C) 2020, TOSHIBA CORPORATION
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + *

Remove spurious blank line.

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
> +#define  PCIE_UL_S_INT_EVENT_MASK1_ALL  (PCIE_UL_CFG_PME_INT | PCIE_UL_CFG_LINK_EQ_REQ_INT | \
> +					 PCIE_UL_EDMA_INT0 | PCIE_UL_EDMA_INT1 | \
> +					 PCIE_UL_EDMA_INT2 | PCIE_UL_EDMA_INT3)
> +

Please wrap the code here and below so it fits nicely in 80 columns.

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
> +static inline void visconti_ulreg_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->ulreg_base + reg);
> +}
> +
> +/* Access registers in PCIe smu */
> +static inline void visconti_smu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->smu_base + reg);
> +}
> +
> +/* Access registers in PCIe mpu */
> +static inline void visconti_mpu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, pcie->mpu_base + reg);
> +}
> +
> +static inline u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)

Don't bother with "inline" above and the signature will fit better in
the line.  The compiler will inline these even if you don't specify
it.

> +{
> +	return readl_relaxed(pcie->mpu_base + reg);
> +}
> +
> +static int visconti_pcie_check_link_status(struct visconti_pcie *pcie)

"check_link_status" gives no hint about what the return value means.
This looks like it might be similar to what other drivers do in
*_pcie_link_up().

Can you hook things up so this generic code in dw_pcie_host_init()
works for you?

        if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
                ret = pci->ops->start_link(pci);
                if (ret)
                        goto err_free_msi;
        }

> +{
> +	int err;
> +	u32 val;
> +
> +	/* wait for linkup of phy link layer */
> +	err = readl_relaxed_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_00, val,
> +				 (val & PCIE_UL_SMLH_LINK_UP), 1000, 10000);
> +	if (err)
> +		return err;
> +
> +	/* wait for linkup of data link layer */
> +	err = readl_relaxed_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
> +				 (val & PCIE_UL_S_DETECT_ACT), 1000, 10000);
> +	if (err)
> +		return err;
> +
> +	/* wait for LTSSM Status */
> +	return readl_relaxed_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
> +				  (val & PCIE_UL_S_L0), 1000, 10000);
> +}
> +
> +static int visconti_pcie_establish_link(struct pcie_port *pp)
> +{
> +	int ret;
> +	u32 val;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);

Reorder these in the order of use (as you did below).

> +	visconti_ulreg_writel(pcie, PCIE_UL_APP_LTSSM_ENABLE, PCIE_UL_REG_V_SII_GEN_CTRL_01);
> +
> +	ret = visconti_pcie_check_link_status(pcie);
> +	if (ret < 0) {
> +		dev_info(pci->dev, "Link failure\n");
> +		return ret;
> +	}
> +
> +	val = visconti_mpu_readl(pcie, PCIE_MPU_REG_MP_EN);
> +	visconti_mpu_writel(pcie, val & ~MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_S_INT_EVENT_MASK1_ALL, PCIE_UL_REG_S_INT_EVENT_MASK1);
> +
> +	return 0;
> +}
> +
> +static int visconti_pcie_host_init(struct pcie_port *pp)
> +{
> +	dw_pcie_setup_rc(pp);
> +	return visconti_pcie_establish_link(pp);

This doesn't look like correct usage of the dwc infrastructure.  No
other *_pcie_host_init() functions call dw_pcie_setup_rc().  It'd be
nice if the dwc infrastructure had a little more of a user's guide.
In the meantime, try to copy the structure and style of existing
drivers.

> +}
> +
> +static const struct dw_pcie_host_ops visconti_pcie_host_ops = {
> +	.host_init = visconti_pcie_host_init,
> +};
> +
> +static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
> +{
> +	return pci_addr - PCIE_BUS_OFFSET;
> +}
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
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
> +		dev_err(dev, "Failed to get refclk clock: %ld\n", PTR_ERR(pcie->refclk));
> +		return PTR_ERR(pcie->refclk);
> +	}
> +
> +	pcie->sysclk = devm_clk_get(dev, "sysclk");
> +	if (IS_ERR(pcie->sysclk)) {
> +		dev_err(dev, "Failed to get sysclk clock: %ld\n", PTR_ERR(pcie->sysclk));
> +		return PTR_ERR(pcie->sysclk);
> +	}
> +
> +	pcie->auxclk = devm_clk_get(dev, "auxclk");
> +	if (IS_ERR(pcie->auxclk)) {
> +		dev_err(dev, "Failed to get auxclk clock: %ld\n", PTR_ERR(pcie->auxclk));
> +		return PTR_ERR(pcie->auxclk);
> +	}
> +
> +	return 0;
> +}
> +
> +static int visconti_device_turnon(struct visconti_pcie *pcie)

There are no other drivers with a *_turnon() function.  Can you copy
a name used in other drivers for similar functionality?  Maybe this
is similar to kirin_pcie_power_on(), meson_pcie_power_on(), etc?

> +{
> +	int err;
> +	u32 val;
> +
> +	visconti_smu_writel(pcie, PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
> +			    PISMU_CKON_PCIE);
> +	ndelay(250);
> +
> +	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_ULREG_RST_N, PISMU_RSOFF_PCIE);
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_REG_S_PCIE_MODE_RC, PCIE_UL_REG_S_PCIE_MODE);
> +
> +	val = PCIE_UL_IOM_PCIE_PERSTN_I_EN | PCIE_UL_DIRECT_PERSTN_EN | PCIE_UL_DIRECT_PERSTN;
> +	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> +	udelay(100);
> +
> +	val |= PCIE_UL_PERSTN_OUT;
> +	visconti_ulreg_writel(pcie, val, PCIE_UL_REG_S_PERSTN_CTRL);
> +	udelay(100);
> +
> +	visconti_smu_writel(pcie, PISMU_RSOFF_PCIE_PWR_UP_RST_N, PISMU_RSOFF_PCIE);
> +
> +	err = readl_relaxed_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_PHY_INIT_03, val,
> +				 (val & PCIE_UL_PHY0_SRAM_INIT_DONE), 100, 1000);
> +	if (err)
> +		return err;
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_PHY0_SRAM_EXT_LD_DONE, PCIE_UL_REG_S_PHY_INIT_02);
> +
> +	return readl_relaxed_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_SIG_MON, val,
> +				 (val & PCIE_UL_CORE_RST_N_MON), 100, 1000);
> +}
> +
> +static int visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (pp->irq < 0) {
> +		dev_err(dev, "interrupt intr is missing");

Make your error messages consistently capitalized (or consistently not
capitalized).

> +		return pp->irq;
> +	}
> +
> +	pp->ops = &visconti_pcie_host_ops;
> +
> +	pci->link_gen = of_pci_get_max_link_speed(pdev->dev.of_node);
> +	if (pci->link_gen < 0 || pci->link_gen > 3) {
> +		pci->link_gen = 3;
> +		dev_dbg(dev, "Applied default link speed\n");
> +	}
> +
> +	dev_dbg(dev, "link speed Gen %d", pci->link_gen);
> +
> +	ret = visconti_device_turnon(pcie);
> +	if (ret)
> +		goto error;

There's no cleanup, so just "return ret;" here and omit the "error:"
label.

> +	ret = dw_pcie_host_init(pp);
> +	if (ret)
> +		dev_err(dev, "Failed to initialize host\n");
> +
> +error:
> +	return ret;
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
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pp = &pci->pp;
> +	pp->num_vectors = MAX_MSI_IRQS;
> +
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
> 2.30.0.rc2
> 
