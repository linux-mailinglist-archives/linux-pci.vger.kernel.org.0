Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0B627668
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 08:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbiKNHby (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 02:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235943AbiKNHbu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 02:31:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F343C183B4;
        Sun, 13 Nov 2022 23:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89D0660EDF;
        Mon, 14 Nov 2022 07:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6F82C433C1;
        Mon, 14 Nov 2022 07:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668411106;
        bh=loqbLEWs2SC0871IhUm1qJyPW7lvwxMZIqmzxjlhBPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGsysVBwha2z2P1kr13j7+GDZ73cEATPyZUfF3JBg0kSLfh5JFwkCPrghxJ5svBFl
         SBLi9fpv7e9P3sg1AbX1akR7Lz7i8XCVBaQ14prjg33jyxh78a1jTHnGvZfNQwOpnG
         f9wgcGcConk42MIdavhm2SDIjHRihCIOSVKrLfl/EjjFC+1gjwQzlRWQY58ya+htNP
         dEjMiC0751MMMGlywmgson2TUrXJ9Ulsq56DuPtBOedStuDQv2R/qaOG/YCs7i4VKy
         86Qck/Mvcre4+Xh63W1shkAQSML97HcbD36W0cfu4mksTlDSMQ3Bls2otfJvO0kU+K
         +wOQeFlHpyV0A==
Date:   Mon, 14 Nov 2022 13:01:35 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Rob Herring <robh+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        caihuoqing <caihuoqing@baidu.com>, Vinod Koul <vkoul@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 20/20] PCI: dwc: Add Baikal-T1 PCIe controller support
Message-ID: <20221114073135.GH3869@thinkpad>
References: <20221113191301.5526-1-Sergey.Semin@baikalelectronics.ru>
 <20221113191301.5526-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221113191301.5526-21-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Nov 13, 2022 at 10:13:01PM +0300, Serge Semin wrote:
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
> 
> Changelog v4:
> - Drop PCIBIOS_* macros usage. (@Rob)
> - Add "static const" to the dw_pcie_ops and dw_pcie_host_ops structure
>   instances. (@Bjorn)
> - Rename bt1_pcie_dw_ops to bt1_pcie_ops. (@Bjorn)
> - Rename bt1_pcie_ops to bt1_pci_ops. (@Bjorn)
> - Use start_link/stop_link suffixes in the corresponding callbacks.
>   (@Bjorn)
> - Change the get_res() method suffix to being get_resources(). (@Bjorn)
> - Change *_{add,del}_dw_port() method to *_{add,del}_port(). (@Bjorn)
> - Drop dma_coerce_mask_and_coherent() applied to the PCI host bridge
>   kernel device instance. (@Bjorn)
> - Add the comment above the dma_set_mask_and_coherent() method usage
>   regarding the controller eDMA feature. (@Bjorn)
> - Fix the comment above the core reset controls assertion. (@Bjorn)
> - Replace delays and timeout numeric literals with macros. (@Bjorn)
> 
> Changelog v6:
> - Move the DMA-mask setup to the eDMA driver. (@Robin)
> 
> Changelog v7:
> - Replace if-then-dev_err_probe-return statement with just
> return-dev_err_probe one.
> ---
>  drivers/pci/controller/dwc/Kconfig    |   9 +
>  drivers/pci/controller/dwc/Makefile   |   1 +
>  drivers/pci/controller/dwc/pcie-bt1.c | 643 ++++++++++++++++++++++++++
>  3 files changed, 653 insertions(+)
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

Wondering why cannot this be "PCIE_BAIKAL"? Are you sure that this same driver
cannot be reused for other Baikal SoCs in future?

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
> index 000000000000..3346770e6654
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-bt1.c
> @@ -0,0 +1,643 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 BAIKAL ELECTRONICS, JSC

2022?

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
> +/* PCIe bus setup delays and timeouts */
> +#define BT1_PCIE_RST_DELAY_MS			100
> +#define BT1_PCIE_RUN_DELAY_US			100
> +#define BT1_PCIE_REQ_DELAY_US			1
> +#define BT1_PCIE_REQ_TIMEOUT_US			1000
> +#define BT1_PCIE_LNK_DELAY_US			1000
> +#define BT1_PCIE_LNK_TIMEOUT_US			1000000
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
> +		return -EINVAL;
> +
> +	*val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;

Why can't you use the _relaxed variants?

> +	if (size == 4) {
> +		return 0;
> +	} else if (size == 2) {
> +		*val &= 0xffff;
> +		return 0;
> +	} else if (size == 1) {
> +		*val &= 0xff;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +

[...]

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

What is PM core here? By first look I thought you are referring to Linux PM
core framework.

> +	ret = regmap_read_poll_timeout(btpci->sys_regs, BT1_CCU_PCIE_RSTC, val,
> +				       !(val & BT1_CCU_PCIE_REQ_PHY_RST),
> +				       BT1_PCIE_REQ_DELAY_US, BT1_PCIE_REQ_TIMEOUT_US);
> +	if (ret) {
> +		dev_err(dev, "Timed out waiting for PM to stop PHY resetting\n");

With relation to my above comment, this log might be confusing.

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
> +				       !(val & BT1_CCU_PCIE_REQ_CORE_RST),
> +				       BT1_PCIE_REQ_DELAY_US, BT1_PCIE_REQ_TIMEOUT_US);
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
> +	usleep_range(BT1_PCIE_RUN_DELAY_US, BT1_PCIE_RUN_DELAY_US + 100);
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
> +	ret = bt1_pcie_get_resources(btpci);
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
> +static const struct dw_pcie_host_ops bt1_pcie_host_ops = {
> +	.host_init = bt1_pcie_host_init,
> +	.host_deinit = bt1_pcie_host_deinit,
> +};
> +
> +static struct bt1_pcie *bt1_pcie_create_data(struct platform_device *pdev)
> +{

Since this function is called only from probe, it is better to move it there
itself. It is common for drivers to allocate platform resource in the probe
itself.

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
> +static int bt1_pcie_add_port(struct bt1_pcie *btpci)
> +{

This also can be moved to probe.

> +	struct device *dev = &btpci->pdev->dev;
> +	int ret;
> +
> +	btpci->dw.version = DW_PCIE_VER_460A;
> +	btpci->dw.dev = dev;
> +	btpci->dw.ops = &bt1_pcie_ops;
> +
> +	btpci->dw.pp.num_vectors = MAX_MSI_IRQS;
> +	btpci->dw.pp.ops = &bt1_pcie_host_ops;
> +
> +	dw_pcie_cap_set(&btpci->dw, REQ_RES);
> +
> +	ret = dw_pcie_host_init(&btpci->dw.pp);
> +
> +	return dev_err_probe(dev, ret, "Failed to initialize DWC PCIe host\n");
> +}
> +
> +static void bt1_pcie_del_port(struct bt1_pcie *btpci)
> +{
> +	dw_pcie_host_deinit(&btpci->dw.pp);
> +}
> +
> +static int bt1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci;
> +
> +	btpci = bt1_pcie_create_data(pdev);
> +	if (IS_ERR(btpci))
> +		return PTR_ERR(btpci);
> +
> +	return bt1_pcie_add_port(btpci);
> +}
> +
> +static int bt1_pcie_remove(struct platform_device *pdev)
> +{
> +	struct bt1_pcie *btpci = platform_get_drvdata(pdev);
> +
> +	bt1_pcie_del_port(btpci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id bt1_pcie_of_match[] = {
> +	{ .compatible = "baikal,bt1-pcie" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, bt1_pcie_of_match);
> +
> +static struct platform_driver bt1_pcie_driver = {
> +	.probe = bt1_pcie_probe,
> +	.remove = bt1_pcie_remove,
> +	.driver = {
> +		.name	= "bt1-pcie",
> +		.of_match_table = bt1_pcie_of_match,

You might also want to add PROBE_ASYNCHRONOUS flag to allow parallel probing of
drivers while the dwc core waits for PHY link to be up in dw_pcie_wait_for_link().

Thanks,
Mani 

> +	},
> +};
> +module_platform_driver(bt1_pcie_driver);
> +
> +MODULE_AUTHOR("Serge Semin <Sergey.Semin@baikalelectronics.ru>");
> +MODULE_DESCRIPTION("Baikal-T1 PCIe driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.38.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
