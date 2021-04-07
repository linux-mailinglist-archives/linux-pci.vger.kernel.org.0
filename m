Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79952356E84
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 16:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhDGO1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 10:27:48 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40458 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbhDGO1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 10:27:46 -0400
Received: by mail-ot1-f47.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so18213591otb.7;
        Wed, 07 Apr 2021 07:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GeyrD5ghfz4rzn7ICuiBNSSZHeofCDW3BjhxNR9ViTE=;
        b=NSgwBiqo1+9tv59G/V/DQM4Yf5az2h6MSk8Flc/THBUSO2SejYgLJbqqmugeEQ73nL
         reOga5rcLvODc+6e4lZsJD/SKNAX9LAYvFX5Lwla9GLbMnkaV3PQgJ4WDN3M6D67S3e8
         CMJcOlgIavdz3DPC97bl7qnDKMHnId4J4xA3NGu6wjuvo7YAR4dq51AvN8BNCng0EOHn
         CkReYKvp3zdkv0+sSsYSTtX8K5Ujm8ZASZES7sKbhRe2Z6bHZaYGwj1Ef5Y3IMUTdrdr
         j1EODUcUQ6vmGM2VHHCn1LJFHld4TpTYP3GvdceWyyTzOL0qyDAS3uVzYNwzaie1BryE
         O26w==
X-Gm-Message-State: AOAM533vL6sR//0zz2rHQMq5MX78RO67Wf/LflEBdTJ2Z1mWt6g+zYNJ
        KLYndAiRZS5ch3uhcxCVMZHL5zjkxw==
X-Google-Smtp-Source: ABdhPJyNKFMEFwJcnUzq1wQa6V2Kn3g3Xv6gOY+oidexIMAeVtgMTVYEtcZQ108oAoR/oweS6lVxBQ==
X-Received: by 2002:a05:6830:1b69:: with SMTP id d9mr3294582ote.165.1617805656864;
        Wed, 07 Apr 2021 07:27:36 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r15sm5556966ote.27.2021.04.07.07.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 07:27:35 -0700 (PDT)
Received: (nullmailer pid 3696080 invoked by uid 1000);
        Wed, 07 Apr 2021 14:27:34 -0000
Date:   Wed, 7 Apr 2021 09:27:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: dwc: Visoconti: PCIe RC controller driver
Message-ID: <20210407142734.GA3606952@robh.at.kernel.org>
References: <20210407031839.386088-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210407031839.386088-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407031839.386088-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 07, 2021 at 12:18:38PM +0900, Nobuhiro Iwamatsu wrote:
> Add support to PCIe RC controller on Toshiba Visconti ARM SoCs.
> PCIe controller is based of Synopsys DesignWare PCIe core.
> 
> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  drivers/pci/controller/dwc/Kconfig         |  10 +
>  drivers/pci/controller/dwc/Makefile        |   1 +
>  drivers/pci/controller/dwc/pcie-visconti.c | 358 +++++++++++++++++++++
>  3 files changed, 369 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-visconti.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index b9aaa84452c4..ae125d7cf375 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -286,6 +286,16 @@ config PCIE_TEGRA194_EP
>  	  in order to enable device-specific features PCIE_TEGRA194_EP must be
>  	  selected. This uses the DesignWare core.
>  
> +config PCIE_VISCONTI
> +	bool "Toshiba VISCONTI PCIe controllers"
> +	depends on ARCH_VISCONTI || COMPILE_TEST
> +	depends on OF && HAS_IOMEM

Is this line really needed? Seems we have a mixture on other drivers.

> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> +	  This driver supports TMPV77xx.
> +
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
> index 000000000000..e24f83df41b8
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -0,0 +1,358 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DWC PCIe RC driver for Toshiba Visconti ARM SoC
> + *
> + * Copyright (C) 2019, 2020 Toshiba Electronic Device & Storage Corporation
> + * Copyright (C) 2020, TOSHIBA CORPORATION
> + *
> + * Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> + *
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
> +	struct dw_pcie *pci;

Embed this rather than a pointer. 1 less alloc.

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
> +	writel(val, pcie->ulreg_base + reg);

Do these need ordering WRT DMA? If not, use _relaxed variant.

> +}
> +
> +/* Access registers in PCIe smu */
> +static inline void visconti_smu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel(val, pcie->smu_base + reg);
> +}
> +
> +/* Access registers in PCIe mpu */
> +static inline void visconti_mpu_writel(struct visconti_pcie *pcie, u32 val, u32 reg)
> +{
> +	writel(val, pcie->mpu_base + reg);
> +}
> +
> +static inline u32 visconti_mpu_readl(struct visconti_pcie *pcie, u32 reg)
> +{
> +	return readl(pcie->mpu_base + reg);
> +}
> +
> +static int visconti_pcie_check_link_status(struct visconti_pcie *pcie)
> +{
> +	int err;
> +	u32 val;
> +
> +	/* wait for linkup of phy link layer */
> +	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_00, val,
> +				 (val & PCIE_UL_SMLH_LINK_UP), 1000, 10000);
> +	if (err)
> +		return err;
> +
> +	/* wait for linkup of data link layer */
> +	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
> +				 (val & PCIE_UL_S_DETECT_ACT), 1000, 10000);
> +	if (err)
> +		return err;
> +
> +	/* wait for LTSSM Status */
> +	return readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_V_PHY_ST_02, val,
> +				  (val & PCIE_UL_S_L0), 1000, 10000);
> +}
> +
> +static int visconti_pcie_establish_link(struct pcie_port *pp)
> +{
> +	int ret;
> +	u32 val;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct visconti_pcie *pcie = dev_get_drvdata(pci->dev);
> +
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

Seems like all this should be a phy driver.

> +
> +	return 0;
> +}
> +
> +static int visconti_pcie_host_init(struct pcie_port *pp)
> +{
> +	int ret;
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	dw_pcie_setup_rc(pp);

> +	ret = visconti_pcie_establish_link(pp);
> +	if (ret < 0)
> +		return ret;
> +
> +	dw_pcie_wait_for_link(pci);

The DWC core code does link handling now.

> +
> +	return 0;
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
> +	pcie->pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pcie->pci->dbi_base))
> +		return PTR_ERR(pcie->pci->dbi_base);

The DWC core handles this now.

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
> +{
> +	int err;
> +	u32 val;
> +
> +	visconti_smu_writel(pcie, PISMU_CKON_PCIE_AUX_CLK | PISMU_CKON_PCIE_MSTR_ACLK,
> +			    PISMU_CKON_PCIE);

Clock control? Should be a clock provider then.

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
> +	err = readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_PHY_INIT_03, val,
> +				 (val & PCIE_UL_PHY0_SRAM_INIT_DONE), 100, 1000);
> +	if (err)
> +		return err;
> +
> +	visconti_ulreg_writel(pcie, PCIE_UL_PHY0_SRAM_EXT_LD_DONE, PCIE_UL_REG_S_PHY_INIT_02);
> +
> +	return readl_poll_timeout(pcie->ulreg_base + PCIE_UL_REG_S_SIG_MON, val,
> +				 (val & PCIE_UL_CORE_RST_N_MON), 100, 1000);
> +}
> +
> +static int visconti_add_pcie_port(struct visconti_pcie *pcie, struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	pp->irq = platform_get_irq_byname(pdev, "intr");
> +	if (pp->irq < 0) {
> +		dev_err(dev, "interrupt intr is missing");
> +		return pp->irq;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
> +		if (pp->msi_irq < 0) {
> +			dev_err(dev, "interrupt msi is missing");
> +			return pp->msi_irq;
> +		}
> +	}

DWC core handles this now.

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
> +
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
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pp = &pci->pp;
> +	pp->num_vectors = MAX_MSI_IRQS;
> +
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +	pcie->pci = pci;
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
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
