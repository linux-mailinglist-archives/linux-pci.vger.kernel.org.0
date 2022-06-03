Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179F253CCE4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jun 2022 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbiFCQDY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jun 2022 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243289AbiFCQDX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jun 2022 12:03:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCB237A8C;
        Fri,  3 Jun 2022 09:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33E97B82377;
        Fri,  3 Jun 2022 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCA5C385B8;
        Fri,  3 Jun 2022 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654272197;
        bh=X+gtikoTV3x5ZuoenBZRiZ6/37w7C6/UpQLUCYsRzHw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qZTPYnGSqMz4VS++3Dms+o9kf2dh8fXQ1TsQUqmjtolfaJd9hl76bvDDu0I+UeFRi
         rxd8yOXTsKkzVJKFO9QN9iHh+5P+jSOKEovRUjqseKmJfAyK95pmqMSoCFZQ/Fd81O
         fFABlCuTn9yP1BQLWGf6NVWClCInovMBBknLQODm+qgWjCsn0ANzx5NwVvTgCTXgC6
         xMs+Ua3pxfKUSFQFZtZRw7BN7rAD213+54eDyI0bVVvSvkEwgwqrZqqrdzzteLY6f1
         7dL6I+kz8dMLve45abTCYHG9RmUWMxvm6L+iP5SQd9ijPHc0LxPA2kZA9BeVOTpIKp
         JpFfpRQqBeMGQ==
Date:   Fri, 3 Jun 2022 11:03:14 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "kw@linux.com" <kw@linux.com>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Dongjin Yang <dj76.yang@samsung.com>
Subject: Re: [PATCH v2 3/5] PCI: axis: Add ARTPEC-8 PCIe controller driver
Message-ID: <20220603160314.GA76545@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603023452epcms2p22b81cfd1ee4866d5a6663c089ded6eac@epcms2p2>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the subject, why do you tag this "axis"?  There's an existing
pcie-artpec6.c that uses the driver name ""artpec6-pcie" and the
subject line tag "artpec6".

This adds pcie-artpec8.c with driver name "artpec8-pcie", so the
obvious choice would be "artpec8".

I assume you evaluated the possibility of extending artpec6 to support
artpec8 in addition to the artpec6 and artpec7 it already supports?

On Fri, Jun 03, 2022 at 11:34:52AM +0900, Wangseok Lee wrote:
> Add support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications.
> This is based on arm64 and support GEN4 & 2lane.
> This PCIe controller is based on DesignWare Hardware core
> and uses DesignWare core functions to implement the driver.

Add blank lines between paragraphs.

Wrap lines to fill 75 columns.

> changes since v1 :
> improvement review comment of Krzysztof on driver code.
> -debug messages for probe or other functions.
> -Inconsistent coding style (different indentation in structure members).
> -Inconsistent code (artpec8_pcie_get_subsystem_resources() gets device
>   from pdev and from pci so you have two same pointers;
>   or artpec8_pcie_get_ep_mem_resources() stores dev 
>   as local variable but uses instead pdev->dev).
> -Not using devm_platform_ioremap_resource().
> -Printing messages in interrupt handlers.
> -Several local/static structures or array are not const.

Thanks for the "changes since v1" notes.  You can put them below the
"---" since there's no need for them in the permanent git commit log:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v5.18#n675

> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>

Why is there no signoff from Jaeho Cho <jaeho79.cho@samsung.com>?

> ---
>  drivers/pci/controller/dwc/Kconfig        |  31 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-artpec8.c | 864 ++++++++++++++++++++++++++++++
>  3 files changed, 896 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-artpec8.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3ab..4aa6da8 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -222,6 +222,37 @@ config PCIE_ARTPEC6_EP
>  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>  	  endpoint mode. This uses the DesignWare core.
>  
> +config PCIE_ARTPEC8
> +	bool "Axis ARTPEC-8 PCIe controller"
> +
> +config PCIE_ARTPEC8_HOST
> +	bool "Axis ARTPEC-8 PCIe controller Host Mode"
> +	depends on ARCH_ARTPEC
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCI_EPF_TEST
> +	select PCIE_DW_HOST
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in host mode.
> +	  This PCIe controller is based on DesignWare Hardware core.
> +	  And uses DesignWare core functions to implement the driver.

Add blank line between paragraphs or rewrap as a single paragraph.

s/Hardware/hardware/

The last two sentences should be combined since the latter has no
verb:

  This PCIe controller is based on the DesignWare hardware core and
  uses DesignWare core functions to implement the driver.

> +config PCIE_ARTPEC8_EP
> +	bool "Axis ARTPEC-8 PCIe controller Endpoint Mode"
> +	depends on ARCH_ARTPEC
> +	depends on PCI_ENDPOINT
> +	depends on PCI_ENDPOINT_CONFIGFS
> +	select PCI_EPF_TEST
> +	select PCIE_DW_EP
> +	select PCIE_ARTPEC8
> +	help
> +	  Say 'Y' here to enable support for the PCIe controller in the
> +	  ARTPEC-8 SoC to work in endpoint mode.
> +	  This PCIe controller is based on DesignWare Hardware core.
> +	  And uses DesignWare core functions to implement the driver.

Same.

>  config PCIE_ROCKCHIP_DW_HOST
>  	bool "Rockchip DesignWare PCIe controller"
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 8ba7b67..b361022 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -25,6 +25,7 @@ obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
>  obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> +obj-$(CONFIG_PCIE_ARTPEC8) += pcie-artpec8.o
>  
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-artpec8.c b/drivers/pci/controller/dwc/pcie-artpec8.c
> new file mode 100644
> index 0000000..d9ae9bf
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-artpec8.c
> @@ -0,0 +1,864 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe controller driver for Axis ARTPEC-8 SoC
> + *
> + * Copyright (C) 2019 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Author: Jaeho Cho <jaeho79.cho@samsung.com>
> + * This file is based on driver/pci/controller/dwc/pci-exynos.c
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/phy/phy.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_artpec8_pcie(x)	dev_get_drvdata((x)->dev)
> +
> +/* Gen3 Control Register */
> +#define PCIE_GEN3_RELATED_OFF		0x890
> +/* Disables equilzation feature */

s/equilzation/equalization/

Comment is probably unnecessary, since the name is so descriptive.

> +#define PCIE_GEN3_EQUALIZATION_DISABLE	(0x1 << 16)
> +#define PCIE_GEN3_EQ_PHASE_2_3		(0x1 << 9)
> +#define PCIE_GEN3_RXEQ_PH01_EN		(0x1 << 12)
> +#define PCIE_GEN3_RXEQ_RGRDLESS_RXTS	(0x1 << 13)
> +
> +#define FAST_LINK_MODE			(7)
> +
> +/* PCIe ELBI registers */
> +#define PCIE_IRQ0_STS			0x000
> +#define PCIE_IRQ1_STS			0x004
> +#define PCIE_IRQ2_STS			0x008
> +#define PCIE_IRQ5_STS			0x00C
> +#define PCIE_IRQ0_EN			0x010
> +#define PCIE_IRQ1_EN			0x014
> +#define PCIE_IRQ2_EN			0x018
> +#define PCIE_IRQ5_EN			0x01C
> +#define IRQ_MSI_ENABLE			BIT(20)
> +#define PCIE_APP_LTSSM_ENABLE		0x054
> +#define PCIE_ELBI_LTSSM_ENABLE		0x1
> +#define PCIE_ELBI_CXPL_DEBUG_00_31	0x2C8
> +#define PCIE_ELBI_CXPL_DEBUG_32_63	0x2CC
> +#define PCIE_ELBI_SMLH_LINK_UP		BIT(4)
> +#define PCIE_ARTPEC8_DEVICE_TYPE	0x080
> +#define DEVICE_TYPE_EP			0x0
> +#define DEVICE_TYPE_LEG_EP		0x1
> +#define DEVICE_TYPE_RC			0x4
> +#define PCIE_ELBI_SLV_AWMISC		0x828
> +#define PCIE_ELBI_SLV_ARMISC		0x820
> +#define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
> +#define LTSSM_STATE_MASK		0x3f

The previous hex constants used upper-case; this uses lower-case.
Pick one and stick with it.

This seems like a mix of register offsets and definitions of bits
within registers.  It's confusing to mentally sort these out.  Is
there any way to make this more obvious?  Some drivers, e.g.,
pcie-artpec6.c, use "BIT(x)" and "GENMASK(x,y)" for bits within
registers.

> +#define LTSSM_STATE_L0			0x11
> +
> +/* FSYS SYSREG Offsets */

The list below seems to inclue more than just register offsets.

> +#define FSYS_PCIE_CON			0x424
> +#define PCIE_PERSTN			BIT(5)
> +#define FSYS_PCIE_DBI_ADDR_CON		0x428
> +#define FSYS_PCIE_DBI_ADDR_OVR_CDM	0x00
> +#define FSYS_PCIE_DBI_ADDR_OVR_SHADOW	0x12
> +#define FSYS_PCIE_DBI_ADDR_OVR_ATU	0x36
> +
> +/* PMU SYSCON Offsets */
> +#define PMU_SYSCON_PCIE_ISOLATION	0x3200
> +
> +/* BUS P/S SYSCON Offsets */
> +#define BUS_SYSCON_BUS_PATH_ENABLE	0x0
> +
> +int artpec8_pcie_dbi_addr_con[] = {
> +	FSYS_PCIE_DBI_ADDR_CON
> +};
> +
> +struct artpec8_pcie {
> +	struct dw_pcie			*pci;
> +	struct clk			*pipe_clk;
> +	struct clk			*dbi_clk;
> +	struct clk			*mstr_clk;
> +	struct clk			*slv_clk;
> +	const struct artpec8_pcie_pdata	*pdata;
> +	void __iomem			*elbi_base;
> +	struct regmap			*sysreg;
> +	struct regmap			*pmu_syscon;
> +	struct regmap			*bus_s_syscon;
> +	struct regmap			*bus_p_syscon;
> +	enum dw_pcie_device_mode	mode;
> +	int				link_id;
> +	/* For Generic PHY Framework */

Superfluous comment.

> +	struct phy			*phy;
> +};
> +
> +struct artpec8_pcie_res_ops {
> +	int (*get_mem_resources)(struct platform_device *pdev,
> +				 struct artpec8_pcie *artpec8_ctrl);
> +	int (*get_clk_resources)(struct platform_device *pdev,
> +				 struct artpec8_pcie *artpec8_ctrl);
> +	int (*init_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
> +	void (*deinit_clk_resources)(struct artpec8_pcie *artpec8_ctrl);
> +};
> +
> +struct artpec8_pcie_pdata {
> +	const struct dw_pcie_ops		*dwc_ops;
> +	const struct dw_pcie_host_ops			*host_ops;

Fix indentation to match surrounding code.

> +	const struct artpec8_pcie_res_ops	*res_ops;
> +	enum dw_pcie_device_mode		mode;
> +};
> +
> +enum artpec8_pcie_isolation {
> +	PCIE_CLEAR_ISOLATION = 0,
> +	PCIE_SET_ISOLATION = 1
> +};
> +
> +enum artpec8_pcie_reg_bit {
> +	PCIE_REG_BIT_LOW = 0,
> +	PCIE_REG_BIT_HIGH = 1
> +};
> +
> +static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val);
> +static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size);
> +static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg);

Can you reorder the function definitions to avoid the need for these
forward declarations?

> +static int artpec8_pcie_get_subsystem_resources(struct platform_device *pdev,
> +					struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	/* External Local Bus interface(ELBI) Register */
> +	artpec8_ctrl->elbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");

Rewrap to fit in 80 columns.

> +	if (IS_ERR(artpec8_ctrl->elbi_base)) {
> +		dev_err(dev, "failed to map elbi_base\n");
> +		return PTR_ERR(artpec8_ctrl->elbi_base);
> +	}
> +
> +	/* fsys sysreg regmap handle */

All these comments are superfluous since they only repeat the lookup
arguments.

> +	artpec8_ctrl->sysreg =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,

The above two lines should fit on one line.

> +			"samsung,fsys-sysreg");
> +	if (IS_ERR(artpec8_ctrl->sysreg)) {
> +		dev_err(dev, "fsys sysreg regmap lookup failed.\n");
> +		return PTR_ERR(artpec8_ctrl->sysreg);
> +	}
> +
> +	/* pmu syscon regmap handle */
> +	artpec8_ctrl->pmu_syscon = syscon_regmap_lookup_by_phandle(dev->of_node,
> +			"samsung,syscon-phandle");
> +	if (IS_ERR(artpec8_ctrl->pmu_syscon)) {
> +		dev_err(dev, "pmu syscon regmap lookup failed.\n");
> +		return PTR_ERR(artpec8_ctrl->pmu_syscon);
> +	}
> +
> +	/* bus s syscon regmap handle */
> +	artpec8_ctrl->bus_s_syscon =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +			"samsung,syscon-bus-s-fsys");
> +	if (IS_ERR(artpec8_ctrl->bus_s_syscon)) {
> +		dev_err(dev, "bus_s_syscon regmap lookup failed.\n");
> +		return PTR_ERR(artpec8_ctrl->bus_s_syscon);
> +	}
> +
> +	/* bus p syscon regmap handle */
> +	artpec8_ctrl->bus_p_syscon =
> +		syscon_regmap_lookup_by_phandle(dev->of_node,
> +			"samsung,syscon-bus-p-fsys");
> +	if (IS_ERR(artpec8_ctrl->bus_p_syscon)) {
> +		dev_err(dev, "bus_p_syscon regmap lookup failed.\n");
> +		return PTR_ERR(artpec8_ctrl->bus_p_syscon);
> +	}
> +
> +	return 0;
> +}
> +
> +static int artpec8_pcie_get_rc_mem_resources(struct platform_device *pdev,
> +					     struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +
> +	/* Data Bus Interface(DBI) Register */
> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	return 0;
> +}
> +
> +static int artpec8_pcie_get_ep_mem_resources(struct platform_device *pdev,
> +					  struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct dw_pcie_ep *ep;
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +
> +	ep = &pci->ep;

Reorder the locals above:

  struct dw_pcie *pci = artpec8_ctrl->pci;
  struct device *dev = &pdev->dev;
  struct dw_pcie_ep *ep = &pci->ep;
  struct resource *res;

Then they're in the order you use them and you don't need the extra
"ep = &pci->ep".

> +	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "dbi");
> +	if (IS_ERR(pci->dbi_base)) {
> +		dev_err(dev, "failed to map ep_dbics\n");
> +		return -ENOMEM;
> +	}
> +
> +	pci->dbi_base2 = devm_platform_ioremap_resource_byname(pdev, "dbi2");
> +	if (IS_ERR(pci->dbi_base2)) {
> +		dev_err(dev, "failed to map ep_dbics2\n");
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;
> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);
> +
> +	return 0;
> +}
> +
> +static int artpec8_pcie_get_clk_resources(struct platform_device *pdev,
> +				       struct artpec8_pcie *artpec8_ctrl)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	artpec8_ctrl->pipe_clk = devm_clk_get(dev, "pipe_clk");
> +	if (IS_ERR(artpec8_ctrl->pipe_clk)) {
> +		dev_err(dev, "couldn't get pipe clock\n");
> +		return -EINVAL;
> +	}
> +
> +	artpec8_ctrl->dbi_clk = devm_clk_get(dev, "dbi_clk");
> +	if (IS_ERR(artpec8_ctrl->dbi_clk)) {
> +		dev_info(dev, "couldn't get dbi clk\n");
> +		return -EINVAL;
> +	}
> +
> +	artpec8_ctrl->slv_clk = devm_clk_get(dev, "slv_clk");
> +	if (IS_ERR(artpec8_ctrl->slv_clk)) {
> +		dev_err(dev, "couldn't get slave clock\n");
> +		return -EINVAL;
> +	}
> +
> +	artpec8_ctrl->mstr_clk = devm_clk_get(dev, "mstr_clk");
> +	if (IS_ERR(artpec8_ctrl->mstr_clk)) {
> +		dev_info(dev, "couldn't get master clk\n");

It'd be nice if the err/info messages matched the exact DT name:
"pipe_clk", "dbi_clk", slv_clk", etc.

Why are some of the above dev_err() and others dev_info() when you
return -EINVAL in all cases?

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int artpec8_pcie_init_clk_resources(struct artpec8_pcie *artpec8_ctrl)
> +{
> +	clk_prepare_enable(artpec8_ctrl->pipe_clk);
> +	clk_prepare_enable(artpec8_ctrl->dbi_clk);
> +	clk_prepare_enable(artpec8_ctrl->mstr_clk);
> +	clk_prepare_enable(artpec8_ctrl->slv_clk);
> +
> +	return 0;
> +}
> +
> +static void artpec8_pcie_deinit_clk_resources(struct artpec8_pcie *artpec8_ctrl)
> +{
> +	clk_disable_unprepare(artpec8_ctrl->slv_clk);
> +	clk_disable_unprepare(artpec8_ctrl->mstr_clk);
> +	clk_disable_unprepare(artpec8_ctrl->dbi_clk);
> +	clk_disable_unprepare(artpec8_ctrl->pipe_clk);
> +}
> +
> +static const struct artpec8_pcie_res_ops artpec8_pcie_rc_res_ops = {
> +	.get_mem_resources	= artpec8_pcie_get_rc_mem_resources,
> +	.get_clk_resources	= artpec8_pcie_get_clk_resources,
> +	.init_clk_resources	= artpec8_pcie_init_clk_resources,
> +	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
> +};
> +
> +static const struct artpec8_pcie_res_ops artpec8_pcie_ep_res_ops = {
> +	.get_mem_resources	= artpec8_pcie_get_ep_mem_resources,
> +	.get_clk_resources	= artpec8_pcie_get_clk_resources,
> +	.init_clk_resources	= artpec8_pcie_init_clk_resources,
> +	.deinit_clk_resources	= artpec8_pcie_deinit_clk_resources,
> +};
> +
> +static void artpec8_pcie_writel(void __iomem *base, u32 val, u32 reg)
> +{
> +	writel(val, base + reg);
> +}
> +
> +static u32 artpec8_pcie_readl(void __iomem *base, u32 reg)
> +{
> +	return readl(base + reg);
> +}
> +
> +static int artpec8_pcie_config_phy_power_isolation(struct dw_pcie *pci,
> +						enum artpec8_pcie_reg_bit val)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	int ret;
> +
> +	ret = regmap_write(artpec8_ctrl->pmu_syscon, PMU_SYSCON_PCIE_ISOLATION,
> +			   val);
> +
> +	return ret;

  return regmap_write(artpec8_ctrl->pmu_syscon, ...);

> +}
> +
> +static int artpec8_pcie_config_bus_enable(struct dw_pcie *pci,
> +						enum artpec8_pcie_reg_bit val)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	int ret;
> +
> +	ret = regmap_write(artpec8_ctrl->bus_p_syscon,
> +			   BUS_SYSCON_BUS_PATH_ENABLE, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(artpec8_ctrl->bus_s_syscon,
> +			   BUS_SYSCON_BUS_PATH_ENABLE, val);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

  return regmap_write(artpec8_ctrl->bus_s_syscon, ...);

> +}
> +
> +static int artpec8_pcie_config_isolation(struct dw_pcie *pci,
> +					 enum artpec8_pcie_isolation val)
> +{
> +	int ret;
> +	/* reg_val[0] : for phy power isolation */
> +	/* reg_val[1] : for bus enable */
> +	enum artpec8_pcie_reg_bit reg_val[2];
> +
> +	switch (val) {
> +	case PCIE_CLEAR_ISOLATION:
> +		reg_val[0] = PCIE_REG_BIT_LOW;
> +		reg_val[1] = PCIE_REG_BIT_HIGH;
> +		break;
> +	case PCIE_SET_ISOLATION:
> +		reg_val[0] = PCIE_REG_BIT_HIGH;
> +		reg_val[1] = PCIE_REG_BIT_LOW;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = artpec8_pcie_config_phy_power_isolation(pci, reg_val[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = artpec8_pcie_config_bus_enable(pci, reg_val[1]);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

  return artpec8_pcie_config_bus_enable(pci, ...);

> +}
> +
> +static int artpec8_pcie_config_perstn(struct dw_pcie *pci,
> +				      enum artpec8_pcie_reg_bit val)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	unsigned int bits;
> +	int ret;
> +
> +	if (val == PCIE_REG_BIT_HIGH)
> +		bits = PCIE_PERSTN;
> +	else
> +		bits = 0;
> +
> +	ret = regmap_update_bits(artpec8_ctrl->sysreg, FSYS_PCIE_CON,
> +				 PCIE_PERSTN, bits);
> +
> +	return ret;

  return regmap_update_bits(artpec8_ctrl->sysreg, ...):

> +}
> +
> +static void artpec8_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	u32 val;
> +
> +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> +				 PCIE_APP_LTSSM_ENABLE);
> +
> +	val &= ~PCIE_ELBI_LTSSM_ENABLE;
> +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> +			PCIE_APP_LTSSM_ENABLE);
> +}
> +
> +static int artpec8_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	u32 val;
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	/* Equalization disable */
> +	val = artpec8_pcie_read_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF,
> +				    4);
> +	artpec8_pcie_write_dbi(pci, pci->dbi_base, PCIE_GEN3_RELATED_OFF, 4,
> +			       val | PCIE_GEN3_EQUALIZATION_DISABLE);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +
> +	/* assert LTSSM enable */
> +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> +				 PCIE_APP_LTSSM_ENABLE);
> +
> +	val |= PCIE_ELBI_LTSSM_ENABLE;
> +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> +			PCIE_APP_LTSSM_ENABLE);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t artpec8_pcie_msi_irq_handler(int irq, void *arg)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = arg;
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	u32 val;
> +
> +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_STS);
> +
> +	if ((val & IRQ_MSI_ENABLE) == IRQ_MSI_ENABLE) {
> +		val &= IRQ_MSI_ENABLE;
> +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, val,
> +				    PCIE_IRQ2_STS);
> +		dw_handle_msi_irq(pp);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void artpec8_pcie_msi_init(struct artpec8_pcie *artpec8_ctrl)
> +{
> +	u32 val;
> +
> +	/* enable MSI interrupt */
> +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base, PCIE_IRQ2_EN);
> +	val |= IRQ_MSI_ENABLE;
> +	artpec8_pcie_writel(artpec8_ctrl->elbi_base, val, PCIE_IRQ2_EN);
> +}
> +
> +static void artpec8_pcie_enable_interrupts(struct artpec8_pcie *artpec8_ctrl)
> +{
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		artpec8_pcie_msi_init(artpec8_ctrl);
> +}
> +
> +static u32 artpec8_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	u32 val;
> +	bool is_atu = false;
> +
> +	if (base == pci->atu_base) {
> +		is_atu = true;
> +		base = pci->dbi_base;
> +		regmap_write(artpec8_ctrl->sysreg,
> +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +				FSYS_PCIE_DBI_ADDR_OVR_ATU);
> +	}
> +
> +	dw_pcie_read(base + reg, size, &val);
> +
> +	if (is_atu)
> +		regmap_write(artpec8_ctrl->sysreg,
> +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +				FSYS_PCIE_DBI_ADDR_OVR_CDM);
> +
> +	return val;
> +}
> +
> +static void artpec8_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size, u32 val)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	bool is_atu = false;
> +
> +	if (base == pci->atu_base) {
> +		is_atu = true;
> +		base = pci->dbi_base;
> +		regmap_write(artpec8_ctrl->sysreg,
> +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +				FSYS_PCIE_DBI_ADDR_OVR_ATU);
> +	}
> +
> +	dw_pcie_write(base + reg, size, val);
> +
> +	if (is_atu)
> +		regmap_write(artpec8_ctrl->sysreg,
> +			artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +				FSYS_PCIE_DBI_ADDR_OVR_CDM);
> +}
> +
> +static void artpec8_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base,
> +				    u32 reg, size_t size, u32 val)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +
> +	regmap_write(artpec8_ctrl->sysreg,
> +		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +			FSYS_PCIE_DBI_ADDR_OVR_SHADOW);
> +
> +	dw_pcie_write(base + reg, size, val);
> +
> +	regmap_write(artpec8_ctrl->sysreg,
> +		artpec8_pcie_dbi_addr_con[artpec8_ctrl->link_id],
> +			FSYS_PCIE_DBI_ADDR_OVR_CDM);
> +}
> +
> +static int artpec8_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 *val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> +
> +	if (PCI_SLOT(devfn)) {
> +		*val = ~0;

  PCI_SET_ERROR_RESPONSE(val);

> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +	}
> +
> +	*val = dw_pcie_read_dbi(pci, where, size);
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int artpec8_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 val)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
> +
> +	if (PCI_SLOT(devfn))
> +		return PCIBIOS_DEVICE_NOT_FOUND;
> +
> +	dw_pcie_write_dbi(pci, where, size, val);
> +	return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static struct pci_ops artpec8_pci_ops = {
> +	.read = artpec8_pcie_rd_own_conf,
> +	.write = artpec8_pcie_wr_own_conf,
> +};
> +
> +static int artpec8_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +	u32 val;
> +
> +	val = artpec8_pcie_readl(artpec8_ctrl->elbi_base,
> +			PCIE_ELBI_CXPL_DEBUG_00_31);
> +
> +	return (val & LTSSM_STATE_MASK) == LTSSM_STATE_L0;
> +}
> +
> +static int artpec8_pcie_host_init(struct pcie_port *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct artpec8_pcie *artpec8_ctrl = to_artpec8_pcie(pci);
> +
> +	pp->bridge->ops = &artpec8_pci_ops;
> +
> +	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
> +				(PCIE_GEN3_EQ_PHASE_2_3 |
> +				 PCIE_GEN3_RXEQ_PH01_EN |
> +				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
> +
> +	artpec8_pcie_enable_interrupts(artpec8_ctrl);
> +
> +	return 0;
> +}
> +
> +static const struct dw_pcie_host_ops artpec8_pcie_host_ops = {
> +	.host_init = artpec8_pcie_host_init,
> +};
> +
> +static u8 artpec8_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_ATU_VIEWPORT);
> +	pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
> +
> +	if (val == 0xffffffff)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static void artpec8_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	enum pci_barno bar;

Add blank line here and use usual multi-line comment style:

  /*
   * Currently PCIe EP core is not ...

> +	/* Currently PCIe EP core is not setting iatu_unroll_enabled
> +	 * so let's handle it here. We need to find proper place to
> +	 * initialize this so that it can be used as for other EP

  ... can be used for ...

> +	 * controllers as well.
> +	 */
> +	pci->iatu_unroll_enabled = artpec8_pcie_iatu_unroll_enabled(pci);
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +}
> +
> +static int artpec8_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				 enum pci_epc_irq_type type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_epc_features artpec8_pcie_epc_features = {
> +	.linkup_notifier = false,
> +	.msi_capable = true,
> +	.msix_capable = false,
> +};
> +
> +static const struct pci_epc_features*
> +artpec8_pcie_ep_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &artpec8_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops artpec8_dw_pcie_ep_ops = {
> +	.ep_init	= artpec8_pcie_ep_init,
> +	.raise_irq	= artpec8_pcie_raise_irq,
> +	.get_features	= artpec8_pcie_ep_get_features,
> +};
> +
> +static int __init artpec8_add_pcie_ep(struct artpec8_pcie *artpec8_ctrl,
> +		struct platform_device *pdev)
> +{
> +	int ret;
> +	struct dw_pcie_ep *ep;
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +
> +	ep = &pci->ep;

Reorder locals and initialize ep as above.

> +	ep->ops = &artpec8_dw_pcie_ep_ops;
> +
> +	dw_pcie_writel_dbi(pci, PCIE_GEN3_RELATED_OFF,
> +				(PCIE_GEN3_EQ_PHASE_2_3 |
> +				 PCIE_GEN3_RXEQ_PH01_EN |
> +				 PCIE_GEN3_RXEQ_RGRDLESS_RXTS));
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __init artpec8_add_pcie_port(struct artpec8_pcie *artpec8_ctrl,
> +					struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = artpec8_ctrl->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +	int irq_flags;
> +	int irq;

Reorder to be in order of use:

  struct dw_pcie *pci = artpec8_ctrl->pci;
  struct pcie_port *pp = &pci->pp;
  struct device *dev = &pdev->dev;
  int irq;
  int irq_flags;
  int ret;

> +
> +	if (IS_ENABLED(CONFIG_PCI_MSI)) {
> +		irq = platform_get_irq_byname(pdev, "intr");
> +		if (!irq)
> +			return -ENODEV;
> +
> +		irq_flags = IRQF_SHARED | IRQF_NO_THREAD;
> +
> +		ret = devm_request_irq(dev, irq, artpec8_pcie_msi_irq_handler,
> +				irq_flags, "artpec8-pcie", artpec8_ctrl);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Prevent core for messing with the IRQ, since it's muxed */

  Prevent core from ...

> +	pp->msi_irq = -ENODEV;
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

  return dw_pcie_host_init(pp);

> +}
> +
> +static const struct dw_pcie_ops artpec8_dw_pcie_ops = {
> +	.read_dbi	= artpec8_pcie_read_dbi,
> +	.write_dbi	= artpec8_pcie_write_dbi,
> +	.write_dbi2	= artpec8_pcie_write_dbi2,
> +	.start_link	= artpec8_pcie_start_link,
> +	.stop_link	= artpec8_pcie_stop_link,
> +	.link_up	= artpec8_pcie_link_up,
> +};
> +
> +static int artpec8_pcie_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct dw_pcie *pci;
> +	struct pcie_port *pp;
> +	struct artpec8_pcie *artpec8_ctrl;
> +	enum dw_pcie_device_mode mode;
> +	struct device *dev = &pdev->dev;
> +	const struct artpec8_pcie_pdata *pdata;
> +	struct device_node *np = dev->of_node;

Reorder in order of use.

> +	artpec8_ctrl = devm_kzalloc(dev, sizeof(*artpec8_ctrl), GFP_KERNEL);
> +	if (!artpec8_ctrl)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	pdata = (const struct artpec8_pcie_pdata *)

Unnecessary cast.

> +		of_device_get_match_data(dev);
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	mode = (enum dw_pcie_device_mode)pdata->mode;
> +
> +	artpec8_ctrl->pci = pci;
> +	artpec8_ctrl->pdata = pdata;
> +	artpec8_ctrl->mode = mode;
> +
> +	pci->dev = dev;
> +	pci->ops = pdata->dwc_ops;
> +	pci->dbi_base2 = NULL;
> +	pci->dbi_base = NULL;
> +	pp = &pci->pp;
> +	pp->ops = artpec8_ctrl->pdata->host_ops;
> +
> +	if (mode == DW_PCIE_RC_TYPE)
> +		artpec8_ctrl->link_id = of_alias_get_id(np, "pcierc");
> +	else
> +		artpec8_ctrl->link_id = of_alias_get_id(np, "pcieep");
> +
> +	ret = artpec8_pcie_get_subsystem_resources(pdev, artpec8_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	if (pdata->res_ops && pdata->res_ops->get_mem_resources) {
> +		ret = pdata->res_ops->get_mem_resources(pdev, artpec8_ctrl);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (pdata->res_ops && pdata->res_ops->get_clk_resources) {
> +		ret = pdata->res_ops->get_clk_resources(pdev, artpec8_ctrl);
> +		if (ret)
> +			return ret;
> +
> +		ret = pdata->res_ops->init_clk_resources(artpec8_ctrl);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, artpec8_ctrl);
> +
> +	ret = artpec8_pcie_config_isolation(pci, PCIE_CLEAR_ISOLATION);
> +	if (ret)
> +		return ret;
> +
> +	ret = artpec8_pcie_config_perstn(pci, PCIE_REG_BIT_HIGH);
> +	if (ret)
> +		return ret;
> +
> +	artpec8_ctrl->phy = devm_of_phy_get(dev, np, NULL);
> +	if (IS_ERR(artpec8_ctrl->phy))
> +		return PTR_ERR(artpec8_ctrl->phy);
> +
> +	phy_init(artpec8_ctrl->phy);
> +	phy_reset(artpec8_ctrl->phy);
> +
> +	switch (mode) {
> +	case DW_PCIE_RC_TYPE:
> +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_RC,
> +				PCIE_ARTPEC8_DEVICE_TYPE);
> +		ret = artpec8_add_pcie_port(artpec8_ctrl, pdev);
> +		if (ret < 0)

Are there positive return values that indicate success?  Most places
above you assume "ret != 0" means failure, so just curious why you
test "ret < 0" instead of just "ret".

> +			goto fail_probe;
> +		break;
> +	case DW_PCIE_EP_TYPE:
> +		artpec8_pcie_writel(artpec8_ctrl->elbi_base, DEVICE_TYPE_EP,
> +				PCIE_ARTPEC8_DEVICE_TYPE);
> +
> +		ret = artpec8_add_pcie_ep(artpec8_ctrl, pdev);
> +		if (ret < 0)

Same question.

> +			goto fail_probe;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto fail_probe;
> +	}
> +
> +	return 0;
> +
> +fail_probe:
> +	phy_exit(artpec8_ctrl->phy);
> +	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
> +		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
> +
> +	return ret;
> +}
> +
> +static int __exit artpec8_pcie_remove(struct platform_device *pdev)
> +{
> +	struct artpec8_pcie *artpec8_ctrl = platform_get_drvdata(pdev);
> +	const struct artpec8_pcie_pdata *pdata = artpec8_ctrl->pdata;
> +
> +	if (pdata->res_ops && pdata->res_ops->deinit_clk_resources)
> +		pdata->res_ops->deinit_clk_resources(artpec8_ctrl);
> +
> +	return 0;
> +}
> +
> +static const struct artpec8_pcie_pdata artpec8_pcie_rc_pdata = {
> +	.dwc_ops	= &artpec8_dw_pcie_ops,
> +	.host_ops	= &artpec8_pcie_host_ops,
> +	.res_ops	= &artpec8_pcie_rc_res_ops,
> +	.mode		= DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct artpec8_pcie_pdata artpec8_pcie_ep_pdata = {
> +	.dwc_ops	= &artpec8_dw_pcie_ops,
> +	.host_ops	= &artpec8_pcie_host_ops,
> +	.res_ops	= &artpec8_pcie_ep_res_ops,
> +	.mode		= DW_PCIE_EP_TYPE,
> +};
> +
> +static const struct of_device_id artpec8_pcie_of_match[] = {
> +	{
> +		.compatible = "axis,artpec8-pcie",
> +		.data = &artpec8_pcie_rc_pdata,
> +	},
> +	{
> +		.compatible = "axis,artpec8-pcie-ep",
> +		.data = &artpec8_pcie_ep_pdata,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, artpec8_pcie_of_match);
> +
> +static struct platform_driver artpec8_pcie_driver = {
> +	.probe	= artpec8_pcie_probe,
> +	.remove		= __exit_p(artpec8_pcie_remove),
> +	.driver = {
> +		.name	= "artpec8-pcie",
> +		.of_match_table = artpec8_pcie_of_match,
> +	},
> +};
> +
> +module_platform_driver(artpec8_pcie_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jaeho Cho <jaeho79.cho@samsung.com>");
> -- 
> 2.9.5
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy
