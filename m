Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C84E54CF6F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 19:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349948AbiFORK5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 13:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349887AbiFORKu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 13:10:50 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415E37A13;
        Wed, 15 Jun 2022 10:10:48 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id r5so13369461iod.5;
        Wed, 15 Jun 2022 10:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LSMrIvoPN+854qp96YH8sUaYH9zPSlVgWpGoTeLPlSw=;
        b=hXKXnLw/FhUZx3KcM7TYy5z2Npeg19abPpbscXR0umKDixBsRjp74OSZ+sRc6ib+OM
         LPqfAuzHMn1RTJ9aFyzbKbUHHf2zBObnQp8qHPCrxkPcMolaw0JrD2E2bEVG4T25Xxdr
         UqcbGQa4D6eV5ZJHxcnRMEx2rbsAyVhf7y+i8GxDABQFAqobsIuvY3nMGQqazEJbtXAU
         h3EPRD72q/9XANK6vBPaw8ISsk6UyflWfR/bMLFOvRgsxrH19/SQTv4dQByTq7PVCeCH
         CMzwdKJZxI10fkXWrmWoEwbioxli/7XCf4ugLy0emuED7wrfRvLHcKNUxjKZv4e5yFC7
         CkbA==
X-Gm-Message-State: AJIora8v9DWgVuvHXEuc0NVM4hY8baWV96JKdMFFLMOXjjFnIXSrg1BG
        p2PXiiLnXOf5halXOlRfrw==
X-Google-Smtp-Source: AGRyM1tW+BItGNdTqvyeabbmrADzjzHtrRUbBmKbZ3cIxeKXSJP24bxkZaMxtIYhN6D8hcCcwVP27A==
X-Received: by 2002:a05:6638:2609:b0:333:f39a:ae02 with SMTP id m9-20020a056638260900b00333f39aae02mr433178jat.156.1655313047501;
        Wed, 15 Jun 2022 10:10:47 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c11-20020a0290cb000000b0032e3b9e3d38sm6398275jag.126.2022.06.15.10.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:10:47 -0700 (PDT)
Received: (nullmailer pid 1461507 invoked by uid 1000);
        Wed, 15 Jun 2022 17:10:45 -0000
Date:   Wed, 15 Jun 2022 11:10:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/17] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20220615171045.GD1413880-robh@kernel.org>
References: <20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru>
 <20220610085706.15741-18-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610085706.15741-18-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 11:57:05AM +0300, Serge Semin wrote:
> Baikal-T1 SoC is equipped with DWC PCIe v4.60a host controller. It can be
> trained to work up to Gen.3 speed over up to x4 lanes. The host controller
> is attached to the DW PCIe 3.0 PCS via the PIPE-4 interface, which in its
> turn is connected to the DWC 10G PHY. The whole system is supposed to be
> fed up with four clock sources: DBI peripheral clock, AXI application
> clocks and external PHY/core reference clock generating the 100MHz signal.
> In addition to that the platform provide a way to reset each part of the
> controller: sticky/non-sticky bits, host controller core, PIPE interface,
> PCS/PHY and Hot/Power reset signal. The driver also provides a way to
> handle the GPIO-based PERST# signal.
> 
> Note due to the Baikal-T1 MMIO peculiarity we have to implement the DBI
> interface accessors which make sure the IO operations are dword-aligned.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> Changelog v2:
> - Rename 'syscon' property to 'baikal,bt1-syscon'.
> 
> Changelog v3:
> - Use the clocks/resets handlers defined in the DW PCIe core descriptor.
>   (@Rob)
> - Redefine PCI host bridge config space accessors with the generic
>   pci_generic_config_read32() and pci_generic_config_write32() methods.
>   (@Rob)
> ---
>  drivers/pci/controller/dwc/Kconfig    |   9 +
>  drivers/pci/controller/dwc/Makefile   |   1 +
>  drivers/pci/controller/dwc/pcie-bt1.c | 649 ++++++++++++++++++++++++++
>  3 files changed, 659 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-bt1.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3abf0f19..771b8b146623 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -222,6 +222,15 @@ config PCIE_ARTPEC6_EP
>  	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
>  	  endpoint mode. This uses the DesignWare core.
>  
> +config PCIE_BT1
> +	tristate "Baikal-T1 PCIe controller"
> +	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> +	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> +
>  config PCIE_ROCKCHIP_DW_HOST
>  	bool "Rockchip DesignWare PCIe controller"
>  	select PCIE_DW
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 8ba7b67f5e50..bf5c311875a1 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> +obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> diff --git a/drivers/pci/controller/dwc/pcie-bt1.c b/drivers/pci/controller/dwc/pcie-bt1.c
> new file mode 100644
> index 000000000000..03f035743b78
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC
> + *
> + * Authors:
> + *   Vadim Vlasov <Vadim.Vlasov@baikalelectronics.ru>
> + *   Serge Semin <Sergey.Semin@baikalelectronics.ru>
> + *
> + * Baikal-T1 PCIe controller driver
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +/* Baikal-T1 System CCU control registers */
> +#define BT1_CCU_PCIE_CLKC			0x140
> +#define BT1_CCU_PCIE_REQ_PCS_CLK		BIT(16)
> +#define BT1_CCU_PCIE_REQ_MAC_CLK		BIT(17)
> +#define BT1_CCU_PCIE_REQ_PIPE_CLK		BIT(18)
> +
> +#define BT1_CCU_PCIE_RSTC			0x144
> +#define BT1_CCU_PCIE_REQ_LINK_RST		BIT(13)
> +#define BT1_CCU_PCIE_REQ_SMLH_RST		BIT(14)
> +#define BT1_CCU_PCIE_REQ_PHY_RST		BIT(16)
> +#define BT1_CCU_PCIE_REQ_CORE_RST		BIT(24)
> +#define BT1_CCU_PCIE_REQ_STICKY_RST		BIT(26)
> +#define BT1_CCU_PCIE_REQ_NSTICKY_RST		BIT(27)
> +
> +#define BT1_CCU_PCIE_PMSC			0x148
> +#define BT1_CCU_PCIE_LTSSM_STATE_MASK		GENMASK(5, 0)
> +#define BT1_CCU_PCIE_LTSSM_DET_QUIET		0x00
> +#define BT1_CCU_PCIE_LTSSM_DET_ACT		0x01
> +#define BT1_CCU_PCIE_LTSSM_POLL_ACT		0x02
> +#define BT1_CCU_PCIE_LTSSM_POLL_COMP		0x03
> +#define BT1_CCU_PCIE_LTSSM_POLL_CONF		0x04
> +#define BT1_CCU_PCIE_LTSSM_PRE_DET_QUIET	0x05
> +#define BT1_CCU_PCIE_LTSSM_DET_WAIT		0x06
> +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_START	0x07
> +#define BT1_CCU_PCIE_LTSSM_CFG_LNKWD_ACEPT	0x08
> +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_WAIT	0x09
> +#define BT1_CCU_PCIE_LTSSM_CFG_LNNUM_ACEPT	0x0a
> +#define BT1_CCU_PCIE_LTSSM_CFG_COMPLETE		0x0b
> +#define BT1_CCU_PCIE_LTSSM_CFG_IDLE		0x0c
> +#define BT1_CCU_PCIE_LTSSM_RCVR_LOCK		0x0d
> +#define BT1_CCU_PCIE_LTSSM_RCVR_SPEED		0x0e
> +#define BT1_CCU_PCIE_LTSSM_RCVR_RCVRCFG		0x0f
> +#define BT1_CCU_PCIE_LTSSM_RCVR_IDLE		0x10
> +#define BT1_CCU_PCIE_LTSSM_L0			0x11
> +#define BT1_CCU_PCIE_LTSSM_L0S			0x12
> +#define BT1_CCU_PCIE_LTSSM_L123_SEND_IDLE	0x13
> +#define BT1_CCU_PCIE_LTSSM_L1_IDLE		0x14
> +#define BT1_CCU_PCIE_LTSSM_L2_IDLE		0x15
> +#define BT1_CCU_PCIE_LTSSM_L2_WAKE		0x16
> +#define BT1_CCU_PCIE_LTSSM_DIS_ENTRY		0x17
> +#define BT1_CCU_PCIE_LTSSM_DIS_IDLE		0x18
> +#define BT1_CCU_PCIE_LTSSM_DISABLE		0x19
> +#define BT1_CCU_PCIE_LTSSM_LPBK_ENTRY		0x1a
> +#define BT1_CCU_PCIE_LTSSM_LPBK_ACTIVE		0x1b
> +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT		0x1c
> +#define BT1_CCU_PCIE_LTSSM_LPBK_EXIT_TOUT	0x1d
> +#define BT1_CCU_PCIE_LTSSM_HOT_RST_ENTRY	0x1e
> +#define BT1_CCU_PCIE_LTSSM_HOT_RST		0x1f
> +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ0		0x20
> +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ1		0x21
> +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ2		0x22
> +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ3		0x23
> +#define BT1_CCU_PCIE_SMLH_LINKUP		BIT(6)
> +#define BT1_CCU_PCIE_RDLH_LINKUP		BIT(7)
> +#define BT1_CCU_PCIE_PM_LINKSTATE_L0S		BIT(8)
> +#define BT1_CCU_PCIE_PM_LINKSTATE_L1		BIT(9)
> +#define BT1_CCU_PCIE_PM_LINKSTATE_L2		BIT(10)
> +#define BT1_CCU_PCIE_L1_PENDING			BIT(12)
> +#define BT1_CCU_PCIE_REQ_EXIT_L1		BIT(14)
> +#define BT1_CCU_PCIE_LTSSM_RCVR_EQ		BIT(15)
> +#define BT1_CCU_PCIE_PM_DSTAT_MASK		GENMASK(18, 16)
> +#define BT1_CCU_PCIE_PM_PME_EN			BIT(20)
> +#define BT1_CCU_PCIE_PM_PME_STATUS		BIT(21)
> +#define BT1_CCU_PCIE_AUX_PM_EN			BIT(22)
> +#define BT1_CCU_PCIE_AUX_PWR_DET		BIT(23)
> +#define BT1_CCU_PCIE_WAKE_DET			BIT(24)
> +#define BT1_CCU_PCIE_TURNOFF_REQ		BIT(30)
> +#define BT1_CCU_PCIE_TURNOFF_ACK		BIT(31)
> +
> +#define BT1_CCU_PCIE_GENC			0x14c
> +#define BT1_CCU_PCIE_LTSSM_EN			BIT(1)
> +#define BT1_CCU_PCIE_DBI2_MODE			BIT(2)
> +#define BT1_CCU_PCIE_MGMT_EN			BIT(3)
> +#define BT1_CCU_PCIE_RXLANE_FLIP_EN		BIT(16)
> +#define BT1_CCU_PCIE_TXLANE_FLIP_EN		BIT(17)
> +#define BT1_CCU_PCIE_SLV_XFER_PEND		BIT(24)
> +#define BT1_CCU_PCIE_RCV_XFER_PEND		BIT(25)
> +#define BT1_CCU_PCIE_DBI_XFER_PEND		BIT(26)
> +#define BT1_CCU_PCIE_DMA_XFER_PEND		BIT(27)
> +
> +#define BT1_CCU_PCIE_LTSSM_LINKUP(_pmsc) \
> +({ \
> +	int __state = FIELD_GET(BT1_CCU_PCIE_LTSSM_STATE_MASK, _pmsc); \
> +	__state >= BT1_CCU_PCIE_LTSSM_L0 && __state <= BT1_CCU_PCIE_LTSSM_L2_WAKE; \
> +})
> +
> +/* Baikal-T1 PCIe specific control registers */
> +#define BT1_PCIE_AXI2MGM_LANENUM		0xd04
> +#define BT1_PCIE_AXI2MGM_LANESEL_MASK		GENMASK(3, 0)
> +
> +#define BT1_PCIE_AXI2MGM_ADDRCTL		0xd08
> +#define BT1_PCIE_AXI2MGM_PHYREG_ADDR_MASK	GENMASK(20, 0)
> +#define BT1_PCIE_AXI2MGM_READ_FLAG		BIT(29)
> +#define BT1_PCIE_AXI2MGM_DONE			BIT(30)
> +#define BT1_PCIE_AXI2MGM_BUSY			BIT(31)
> +
> +#define BT1_PCIE_AXI2MGM_WRITEDATA		0xd0c
> +#define BT1_PCIE_AXI2MGM_WDATA			GENMASK(15, 0)
> +
> +#define BT1_PCIE_AXI2MGM_READDATA		0xd10
> +#define BT1_PCIE_AXI2MGM_RDATA			GENMASK(15, 0)
> +
> +/* Generic Baikal-T1 PCIe interface resources */
> +#define BT1_PCIE_NUM_APP_CLKS			ARRAY_SIZE(bt1_pcie_app_clks)
> +#define BT1_PCIE_NUM_CORE_CLKS			ARRAY_SIZE(bt1_pcie_core_clks)
> +#define BT1_PCIE_NUM_APP_RSTS			ARRAY_SIZE(bt1_pcie_app_rsts)
> +#define BT1_PCIE_NUM_CORE_RSTS			ARRAY_SIZE(bt1_pcie_core_rsts)
> +
> +static const enum dw_pcie_app_clk bt1_pcie_app_clks[] = {
> +	DW_PCIE_DBI_CLK, DW_PCIE_MSTR_CLK, DW_PCIE_SLV_CLK,
> +};
> +
> +static const enum dw_pcie_core_clk bt1_pcie_core_clks[] = {
> +	DW_PCIE_REF_CLK,
> +};
> +
> +static const enum dw_pcie_app_rst bt1_pcie_app_rsts[] = {
> +	DW_PCIE_MSTR_RST, DW_PCIE_SLV_RST,
> +};
> +
> +static const enum dw_pcie_core_rst bt1_pcie_core_rsts[] = {
> +	DW_PCIE_NON_STICKY_RST, DW_PCIE_STICKY_RST, DW_PCIE_CORE_RST,
> +	DW_PCIE_PIPE_RST, DW_PCIE_PHY_RST, DW_PCIE_HOT_RST, DW_PCIE_PWR_RST,
> +};
> +
> +struct bt1_pcie {
> +	struct dw_pcie dw;
> +	struct platform_device *pdev;
> +	struct regmap *sys_regs;
> +};
> +#define to_bt1_pcie(_dw) container_of(_dw, struct bt1_pcie, dw)
> +
> +/*
> + * Baikal-T1 MMIO space must be read/written by the dword-aligned
> + * instructions. Note the methods are optimized to have the dword operations
> + * performed with minimum overhead as the most frequently used ones.
> + */
> +static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
> +{
> +	unsigned int ofs = (uintptr_t)addr & 0x3;
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;

This isn't for PCI config space accessors, don't use PCIBIOS_*. We 
really want to get rid of those.

You are in control of all the accesses, so the error conditions should 
never happen, don't need to be checked, and don't need to be returned.

> +
> +	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
> +	if (size == 4) {
> +		return PCIBIOS_SUCCESSFUL;
> +	} else if (size == 2) {
> +		*val &= 0xffff;
> +		return PCIBIOS_SUCCESSFUL;
> +	} else if (size == 1) {
> +		*val &= 0xff;
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return PCIBIOS_BAD_REGISTER_NUMBER;
> +}
> +
> +static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
> +{
> +	unsigned int ofs = (uintptr_t)addr & 0x3;
> +	u32 tmp, mask;
> +
> +	if (!IS_ALIGNED((uintptr_t)addr, size))
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	if (size == 4) {
> +		writel(val, addr);
> +		return PCIBIOS_SUCCESSFUL;
> +	} else if (size == 2 || size == 1) {
> +		mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
> +		tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
> +		tmp |= (val & mask) << ofs * BITS_PER_BYTE;
> +		writel(tmp, addr - ofs);
> +		return PCIBIOS_SUCCESSFUL;
> +	}
> +
> +	return PCIBIOS_BAD_REGISTER_NUMBER;
> +}
> +
> +static u32 bt1_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +			     size_t size)
> +{
> +	int ret;
> +	u32 val;
> +
> +	ret = bt1_pcie_read_mmio(base + reg, size, &val);
> +	if (ret != PCIBIOS_SUCCESSFUL) {
> +		dev_err(pci->dev, "Read DBI address failed\n");
> +		return ~0U;
> +	}
> +
> +	return val;
> +}
> +
> +static void bt1_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +			       size_t size, u32 val)
> +{
> +	int ret;
> +
> +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		dev_err(pci->dev, "Write DBI address failed\n");
> +}
> +
> +static void bt1_pcie_write_dbi2(struct dw_pcie *pci, void __iomem *base, u32 reg,
> +				size_t size, u32 val)
> +{
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +	int ret;
> +
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_DBI2_MODE, BT1_CCU_PCIE_DBI2_MODE);
> +
> +	ret = bt1_pcie_write_mmio(base + reg, size, val);
> +	if (ret != PCIBIOS_SUCCESSFUL)
> +		dev_err(pci->dev, "Write DBI2 address failed\n");
> +
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_DBI2_MODE, 0);
> +}
> +
> +static int bt1_pcie_start_ltssm(struct dw_pcie *pci)
> +{
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Enable LTSSM and make sure it was able to establish both PHY and
> +	 * data links. This procedure shall work fine to reach 2.5 GT/s speed.
> +	 */
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, BT1_CCU_PCIE_LTSSM_EN);
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       (val & BT1_CCU_PCIE_SMLH_LINKUP),
> +				       1000, 1000000);
> +	if (ret) {
> +		dev_err(pci->dev, "LTSSM failed to set PHY link up\n");
> +		return ret;
> +	}
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       (val & BT1_CCU_PCIE_RDLH_LINKUP),
> +				       1000, 1000000);
> +	if (ret) {
> +		dev_err(pci->dev, "LTSSM failed to set data link up\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * Activate direct speed change after the link is established in an
> +	 * attempt to reach a higher bus performance (up to Gen.3 - 8.0 GT/s).
> +	 * This is required at least to get 8.0 GT/s speed.
> +	 */
> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> +	val |= PORT_LOGIC_SPEED_CHANGE;
> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_PMSC, val,
> +				       BT1_CCU_PCIE_LTSSM_LINKUP(val),
> +				       1000, 1000000);
> +	if (ret)
> +		dev_err(pci->dev, "LTSSM failed to get into L0 state\n");
> +
> +	return ret;
> +}
> +
> +static void bt1_pcie_stop_ltssm(struct dw_pcie *pci)
> +{
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> +}
> +
> +struct dw_pcie_ops bt1_pcie_dw_ops = {
> +	.read_dbi = bt1_pcie_read_dbi,
> +	.write_dbi = bt1_pcie_write_dbi,
> +	.write_dbi2 = bt1_pcie_write_dbi2,
> +	.start_link = bt1_pcie_start_ltssm,
> +	.stop_link = bt1_pcie_stop_ltssm,
> +};
> +
> +static struct pci_ops bt1_pcie_ops = {
> +	.map_bus = dw_pcie_own_conf_map_bus,
> +	.read = pci_generic_config_read32,
> +	.write = pci_generic_config_write32,
> +};
> +
> +static int bt1_pcie_get_res(struct bt1_pcie *btpci)
> +{
> +	struct device *dev = btpci->dw.dev;
> +	int i, ret;
> +
> +	/* DBI access is supposed to be performed by the dword-aligned IOs */
> +	btpci->dw.pp.bridge->ops = &bt1_pcie_ops;
> +
> +	/* AXI-interface is configured with 64-bit address bus width */
> +	ret = dma_coerce_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> +					   DMA_BIT_MASK(64));
> +	if (ret) {
> +		ret = dma_set_mask_and_coherent(&btpci->dw.pp.bridge->dev,
> +						DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* These CSRs are in MMIO so we won't check the regmap-methods status */
> +	btpci->sys_regs =
> +		syscon_regmap_lookup_by_phandle(dev->of_node, "baikal,bt1-syscon");
> +	if (IS_ERR(btpci->sys_regs))
> +		return dev_err_probe(dev, PTR_ERR(btpci->sys_regs),
> +				     "Failed to get syscon\n");
> +
> +	/* Make sure all the required resources have been specified */
> +	for (i = 0; i < BT1_PCIE_NUM_APP_CLKS; i++) {
> +		if (!btpci->dw.app_clks[bt1_pcie_app_clks[i]].clk) {
> +			dev_err(dev, "App clocks set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_CORE_CLKS; i++) {
> +		if (!btpci->dw.core_clks[bt1_pcie_core_clks[i]].clk) {
> +			dev_err(dev, "Core clocks set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_APP_RSTS; i++) {
> +		if (!btpci->dw.app_rsts[bt1_pcie_app_rsts[i]].rstc) {
> +			dev_err(dev, "App resets set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	for (i = 0; i < BT1_PCIE_NUM_CORE_RSTS; i++) {
> +		if (!btpci->dw.core_rsts[bt1_pcie_core_rsts[i]].rstc) {
> +			dev_err(dev, "Core resets set is incomplete\n");
> +			return -ENOENT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void bt1_pcie_full_stop_bus(struct bt1_pcie *btpci, bool init)
> +{
> +	struct device *dev = btpci->dw.dev;
> +	struct dw_pcie *pci = &btpci->dw;
> +	int ret;
> +
> +	/* Disable LTSSM for sure */
> +	regmap_update_bits(btpci->sys_regs, BT1_CCU_PCIE_GENC,
> +			   BT1_CCU_PCIE_LTSSM_EN, 0);
> +
> +	/*
> +	 * Application reset controls are trigger-based so de-assert the core
> +	 * resets only.
> +	 */
> +	ret = reset_control_bulk_assert(DW_PCIE_NUM_CORE_RSTS, pci->core_rsts);
> +	if (ret)
> +		dev_err(dev, "Failed to assert core resets\n");
> +
> +	/*
> +	 * Clocks are disabled by default at least in accordance with the clk
> +	 * enable counter value on init stage.
> +	 */
> +	if (!init) {
> +		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +
> +		clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +	}
> +
> +	/* The peripheral devices are unavailable anyway so reset them too */
> +	gpiod_set_value_cansleep(pci->pe_rst, 1);
> +
> +	/* Make sure the reset is settled */
> +	usleep_range(1, 10);
> +}
> +
> +/*
> + * Implements the cold reset procedure in accordance with the reference manual
> + * and available PM signals.
> + */
> +static int bt1_pcie_cold_start_bus(struct bt1_pcie *btpci)
> +{
> +	struct device *dev = btpci->dw.dev;
> +	struct dw_pcie *pci = &btpci->dw;
> +	u32 val;
> +	int ret;
> +
> +	/* First get out of the Power/Hot reset state */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PHY reset\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert hot reset\n");
> +		goto err_assert_pwr_rst;
> +	}
> +
> +	/* Wait for the PM-core to stop requesting the PHY reset */
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> +				       !(val & BT1_CCU_PCIE_REQ_PHY_RST), 1, 1000);
> +	if (ret) {
> +		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");
> +		goto err_assert_hot_rst;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PHY reset\n");
> +		goto err_assert_hot_rst;
> +	}
> +
> +	/* Clocks can be now enabled, but the ref one is crucial at this stage */
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable app clocks\n");
> +		goto err_assert_phy_rst;
> +	}
> +
> +	ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable ref clocks\n");
> +		goto err_disable_app_clk;
> +	}
> +
> +	/* Wait for the PM to stop requesting the controller core reset */
> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> +				       !(val & BT1_CCU_PCIE_REQ_CORE_RST), 1, 1000);
> +	if (ret) {
> +		dev_err(dev, "Timed out waiting for PM to stop core resetting\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	/* PCS-PIPE interface and controller core can be now activated */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert PIPE reset\n");
> +		goto err_disable_core_clk;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert core reset\n");
> +		goto err_assert_pipe_rst;
> +	}
> +
> +	/* It's recommended to reset the core and application logic together */
> +	ret = reset_control_bulk_reset(DW_PCIE_NUM_APP_RSTS, pci->app_rsts);
> +	if (ret) {
> +		dev_err(dev, "Failed to reset app domain\n");
> +		goto err_assert_core_rst;
> +	}
> +
> +	/* Sticky/Non-sticky CSR flags can be now unreset too */
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert sticky reset\n");
> +		goto err_assert_core_rst;
> +	}
> +
> +	ret = reset_control_deassert(pci->core_rsts[DW_PCIE_NON_STICKY_RST].rstc);
> +	if (ret) {
> +		dev_err(dev, "Failed to deassert non-sticky reset\n");
> +		goto err_assert_sticky_rst;
> +	}
> +
> +	/* Activate the PCIe bus peripheral devices */
> +	gpiod_set_value_cansleep(pci->pe_rst, 0);
> +
> +	/* Make sure the state is settled (LTSSM is still disabled though) */
> +	usleep_range(1, 10);
> +
> +	return 0;
> +
> +err_assert_sticky_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_STICKY_RST].rstc);
> +
> +err_assert_core_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_CORE_RST].rstc);
> +
> +err_assert_pipe_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PIPE_RST].rstc);
> +
> +err_disable_core_clk:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, pci->core_clks);
> +
> +err_disable_app_clk:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_APP_CLKS, pci->app_clks);
> +
> +err_assert_phy_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PHY_RST].rstc);
> +
> +err_assert_hot_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_HOT_RST].rstc);
> +
> +err_assert_pwr_rst:
> +	reset_control_assert(pci->core_rsts[DW_PCIE_PWR_RST].rstc);
> +
> +	return ret;
> +}
> +
> +static int bt1_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +	int ret;
> +
> +	ret = bt1_pcie_get_res(btpci);
> +	if (ret)
> +		return ret;
> +
> +	bt1_pcie_full_stop_bus(btpci, true);
> +
> +	return bt1_pcie_cold_start_bus(btpci);
> +}
> +
> +static void bt1_pcie_host_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct bt1_pcie *btpci = to_bt1_pcie(pci);
> +
> +	bt1_pcie_full_stop_bus(btpci, false);
> +}
> +
> +struct dw_pcie_host_ops bt1_pcie_host_ops = {
> +	.host_init = bt1_pcie_host_init,
> +	.host_deinit = bt1_pcie_host_deinit,
> +};
> +
> +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci;
> +
> +	btpci = devm_kzalloc(&pdev->dev, sizeof(*btpci), GFP_KERNEL);
> +	if (!btpci)
> +		return ERR_PTR(-ENOMEM);
> +
> +	btpci->pdev = pdev;
> +
> +	platform_set_drvdata(pdev, btpci);
> +
> +	return btpci;
> +}
> +
> +static int bt1_pcie_add_dw_port(struct bt1_pcie *btpci)
> +{
> +	struct device *dev = &btpci->pdev->dev;
> +	int ret;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));

Didn't you do this elsewhere...

Rob
