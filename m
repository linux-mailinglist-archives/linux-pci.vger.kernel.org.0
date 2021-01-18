Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77892FA693
	for <lists+linux-pci@lfdr.de>; Mon, 18 Jan 2021 17:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406070AbhARQoh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Jan 2021 11:44:37 -0500
Received: from foss.arm.com ([217.140.110.172]:39328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405722AbhARQoX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Jan 2021 11:44:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD9D431B;
        Mon, 18 Jan 2021 08:43:36 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98E643F68F;
        Mon, 18 Jan 2021 08:43:35 -0800 (PST)
Date:   Mon, 18 Jan 2021 16:43:29 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     daire.mcnamara@microchip.com
Cc:     bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, cyril.jean@microchip.com,
        ben.dooks@codethink.co.uk
Subject: Re: [PATCH v19 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20210118164329.GA16417@e121166-lin.cambridge.arm.com>
References: <20201224094500.19149-1-daire.mcnamara@microchip.com>
 <20201224094500.19149-4-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224094500.19149-4-daire.mcnamara@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 24, 2020 at 09:44:59AM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/Kconfig               |   10 +
>  drivers/pci/controller/Makefile              |    1 +
>  drivers/pci/controller/pcie-microchip-host.c | 1119 ++++++++++++++++++
>  3 files changed, 1130 insertions(+)
>  create mode 100644 drivers/pci/controller/pcie-microchip-host.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..bca2f8949510 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -298,6 +298,16 @@ config PCI_LOONGSON
>  	  Say Y here if you want to enable PCI controller support on
>  	  Loongson systems.
>  
> +config PCIE_MICROCHIP_HOST
> +	bool "Microchip AXI PCIe host bridge support"
> +	depends on PCI_MSI && OF
> +	select PCI_MSI_IRQ_DOMAIN
> +	select GENERIC_MSI_IRQ_DOMAIN
> +	select PCI_HOST_COMMON
> +	help
> +	  Say Y here if you want kernel to support the Microchip AXI PCIe
> +	  Host Bridge driver.
> +
>  config PCIE_HISI_ERR
>  	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
>  	bool "HiSilicon HIP PCIe controller error handling driver"
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index 04c6edc285c5..b85fcd574ff6 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
>  obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
>  obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
>  obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
> +obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
>  obj-$(CONFIG_VMD) += vmd.o
>  obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
>  obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> new file mode 100644
> index 000000000000..a4f40017d034
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -0,0 +1,1119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Microchip AXI PCIe Bridge host controller driver
> + *
> + * Copyright (c) 2018 - 2020 Microchip Corporation. All rights reserved.
> + *
> + * Author: Daire McNamara <daire.mcnamara@microchip.com>
> + *
> + * Based on:
> + *	pcie-rcar.c
> + *	pcie-xilinx.c
> + *	pcie-altera.c

Nit: Don't think that's useful information and it can also become stale
so remove these files references.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/platform_device.h>
> +
> +#include "../pci.h"
> +
> +/* Number of MSI IRQs */
> +#define MC_NUM_MSI_IRQS				32
> +#define MC_NUM_MSI_IRQS_CODED			5
> +
> +/* PCIe Bridge Phy and Controller Phy offsets */
> +#define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> +#define MC_PCIE1_CTRL_ADDR			0x0000a000u
> +
> +#define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
> +#define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
> +
> +/* PCIe Controller Phy Regs */
> +#define SEC_ERROR_CNT				0x20
> +#define DED_ERROR_CNT				0x24
> +#define SEC_ERROR_INT				0x28
> +#define  SEC_ERROR_INT_TX_RAM_SEC_ERR_INT	GENMASK(3, 0)
> +#define  SEC_ERROR_INT_RX_RAM_SEC_ERR_INT	GENMASK(7, 4)
> +#define  SEC_ERROR_INT_PCIE2AXI_RAM_SEC_ERR_INT	GENMASK(11, 8)
> +#define  SEC_ERROR_INT_AXI2PCIE_RAM_SEC_ERR_INT	GENMASK(15, 12)
> +#define  NUM_SEC_ERROR_INTS			(4)
> +#define SEC_ERROR_INT_MASK			0x2c
> +#define DED_ERROR_INT				0x30
> +#define  DED_ERROR_INT_TX_RAM_DED_ERR_INT	GENMASK(3, 0)
> +#define  DED_ERROR_INT_RX_RAM_DED_ERR_INT	GENMASK(7, 4)
> +#define  DED_ERROR_INT_PCIE2AXI_RAM_DED_ERR_INT	GENMASK(11, 8)
> +#define  DED_ERROR_INT_AXI2PCIE_RAM_DED_ERR_INT	GENMASK(15, 12)
> +#define  NUM_DED_ERROR_INTS			(4)
> +#define DED_ERROR_INT_MASK			0x34
> +#define ECC_CONTROL				0x38
> +#define  ECC_CONTROL_TX_RAM_INJ_ERROR_0		BIT(0)
> +#define  ECC_CONTROL_TX_RAM_INJ_ERROR_1		BIT(1)
> +#define  ECC_CONTROL_TX_RAM_INJ_ERROR_2		BIT(2)
> +#define  ECC_CONTROL_TX_RAM_INJ_ERROR_3		BIT(3)
> +#define  ECC_CONTROL_RX_RAM_INJ_ERROR_0		BIT(4)
> +#define  ECC_CONTROL_RX_RAM_INJ_ERROR_1		BIT(5)
> +#define  ECC_CONTROL_RX_RAM_INJ_ERROR_2		BIT(6)
> +#define  ECC_CONTROL_RX_RAM_INJ_ERROR_3		BIT(7)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_0	BIT(8)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_1	BIT(9)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_2	BIT(10)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_INJ_ERROR_3	BIT(11)
> +#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_0	BIT(12)
> +#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_1	BIT(13)
> +#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_2	BIT(14)
> +#define  ECC_CONTROL_AXI2PCIE_RAM_INJ_ERROR_3	BIT(15)
> +#define  ECC_CONTROL_TX_RAM_ECC_BYPASS		BIT(24)
> +#define  ECC_CONTROL_RX_RAM_ECC_BYPASS		BIT(25)
> +#define  ECC_CONTROL_PCIE2AXI_RAM_ECC_BYPASS	BIT(26)
> +#define  ECC_CONTROL_AXI2PCIE_RAM_ECC_BYPASS	BIT(27)

Are these used at all ?

> +#define LTSSM_STATE				0x5c
> +#define  LTSSM_L0_STATE				0x10

Ditto

Please make sure you define what's needed.

> +#define PCIE_EVENT_INT				0x14c
> +#define  PCIE_EVENT_INT_L2_EXIT_INT		BIT(0)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT		BIT(1)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT		BIT(2)
> +#define  PCIE_EVENT_INT_MASK			GENMASK(2, 0)
> +#define  PCIE_EVENT_INT_L2_EXIT_INT_MASK	BIT(16)
> +#define  PCIE_EVENT_INT_HOTRST_EXIT_INT_MASK	BIT(17)
> +#define  PCIE_EVENT_INT_DLUP_EXIT_INT_MASK	BIT(18)
> +#define  PCIE_EVENT_INT_ENB_MASK		GENMASK(18, 16)
> +#define  PCIE_EVENT_INT_ENB_SHIFT		16
> +#define  NUM_PCIE_EVENTS			(3)
> +
> +/* PCIe Bridge Phy Regs */
> +#define PCIE_PCI_IDS_DW1			0x9c
> +
> +/* PCIe Config space MSI capability structure */
> +#define MC_MSI_CAP_CTRL_OFFSET			0xe0u
> +#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
> +#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
> +
> +#define IMASK_LOCAL				0x180
> +#define  DMA_END_ENGINE_0_MASK			0x00000000u
> +#define  DMA_END_ENGINE_0_SHIFT			0
> +#define  DMA_END_ENGINE_1_MASK			0x00000000u
> +#define  DMA_END_ENGINE_1_SHIFT			1
> +#define  DMA_ERROR_ENGINE_0_MASK		0x00000100u
> +#define  DMA_ERROR_ENGINE_0_SHIFT		8
> +#define  DMA_ERROR_ENGINE_1_MASK		0x00000200u
> +#define  DMA_ERROR_ENGINE_1_SHIFT		9
> +#define  A_ATR_EVT_POST_ERR_MASK		0x00010000u
> +#define  A_ATR_EVT_POST_ERR_SHIFT		16
> +#define  A_ATR_EVT_FETCH_ERR_MASK		0x00020000u
> +#define  A_ATR_EVT_FETCH_ERR_SHIFT		17
> +#define  A_ATR_EVT_DISCARD_ERR_MASK		0x00040000u
> +#define  A_ATR_EVT_DISCARD_ERR_SHIFT		18
> +#define  A_ATR_EVT_DOORBELL_MASK		0x00000000u
> +#define  A_ATR_EVT_DOORBELL_SHIFT		19
> +#define  P_ATR_EVT_POST_ERR_MASK		0x00100000u
> +#define  P_ATR_EVT_POST_ERR_SHIFT		20
> +#define  P_ATR_EVT_FETCH_ERR_MASK		0x00200000u
> +#define  P_ATR_EVT_FETCH_ERR_SHIFT		21
> +#define  P_ATR_EVT_DISCARD_ERR_MASK		0x00400000u
> +#define  P_ATR_EVT_DISCARD_ERR_SHIFT		22
> +#define  P_ATR_EVT_DOORBELL_MASK		0x00000000u
> +#define  P_ATR_EVT_DOORBELL_SHIFT		23
> +#define  PM_MSI_INT_INTA_MASK			0x01000000u
> +#define  PM_MSI_INT_INTA_SHIFT			24
> +#define  PM_MSI_INT_INTB_MASK			0x02000000u
> +#define  PM_MSI_INT_INTB_SHIFT			25
> +#define  PM_MSI_INT_INTC_MASK			0x04000000u
> +#define  PM_MSI_INT_INTC_SHIFT			26
> +#define  PM_MSI_INT_INTD_MASK			0x08000000u
> +#define  PM_MSI_INT_INTD_SHIFT			27
> +#define  PM_MSI_INT_INTX_MASK			0x0f000000u
> +#define  PM_MSI_INT_INTX_SHIFT			24
> +#define  PM_MSI_INT_MSI_MASK			0x10000000u
> +#define  PM_MSI_INT_MSI_SHIFT			28
> +#define  PM_MSI_INT_AER_EVT_MASK		0x20000000u
> +#define  PM_MSI_INT_AER_EVT_SHIFT		29
> +#define  PM_MSI_INT_EVENTS_MASK			0x40000000u
> +#define  PM_MSI_INT_EVENTS_SHIFT		30
> +#define  PM_MSI_INT_SYS_ERR_MASK		0x80000000u
> +#define  PM_MSI_INT_SYS_ERR_SHIFT		31
> +#define  NUM_LOCAL_EVENTS			15
> +#define ISTATUS_LOCAL				0x184
> +#define IMASK_HOST				0x188
> +#define ISTATUS_HOST				0x18c
> +#define MSI_ADDR				0x190
> +#define ISTATUS_MSI				0x194
> +
> +/* PCIe Master table init defines */
> +#define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> +#define  ATR0_PCIE_ATR_SIZE			0x25
> +#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
> +#define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
> +#define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
> +#define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
> +#define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
> +
> +/* PCIe AXI slave table init defines */
> +#define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> +#define  ATR_SIZE_SHIFT				1
> +#define  ATR_IMPL_ENABLE			1
> +#define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
> +#define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
> +#define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
> +#define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> +#define  PCIE_TX_RX_INTERFACE			0x00000000u
> +#define  PCIE_CONFIG_INTERFACE			0x00000001u
> +
> +#define ATR_ENTRY_SIZE				32
> +
> +#define EVENT_PCIE_L2_EXIT			0
> +#define EVENT_PCIE_HOTRST_EXIT			1
> +#define EVENT_PCIE_DLUP_EXIT			2
> +#define EVENT_SEC_TX_RAM_SEC_ERR		3
> +#define EVENT_SEC_RX_RAM_SEC_ERR		4
> +#define EVENT_SEC_AXI2PCIE_RAM_SEC_ERR		5
> +#define EVENT_SEC_PCIE2AXI_RAM_SEC_ERR		6
> +#define EVENT_DED_TX_RAM_DED_ERR		7
> +#define EVENT_DED_RX_RAM_DED_ERR		8
> +#define EVENT_DED_AXI2PCIE_RAM_DED_ERR		9
> +#define EVENT_DED_PCIE2AXI_RAM_DED_ERR		10
> +#define EVENT_LOCAL_DMA_END_ENGINE_0		11
> +#define EVENT_LOCAL_DMA_END_ENGINE_1		12
> +#define EVENT_LOCAL_DMA_ERROR_ENGINE_0		13
> +#define EVENT_LOCAL_DMA_ERROR_ENGINE_1		14
> +#define EVENT_LOCAL_A_ATR_EVT_POST_ERR		15
> +#define EVENT_LOCAL_A_ATR_EVT_FETCH_ERR		16
> +#define EVENT_LOCAL_A_ATR_EVT_DISCARD_ERR	17
> +#define EVENT_LOCAL_A_ATR_EVT_DOORBELL		18
> +#define EVENT_LOCAL_P_ATR_EVT_POST_ERR		19
> +#define EVENT_LOCAL_P_ATR_EVT_FETCH_ERR		20
> +#define EVENT_LOCAL_P_ATR_EVT_DISCARD_ERR	21
> +#define EVENT_LOCAL_P_ATR_EVT_DOORBELL		22
> +#define EVENT_LOCAL_PM_MSI_INT_INTX		23
> +#define EVENT_LOCAL_PM_MSI_INT_MSI		24
> +#define EVENT_LOCAL_PM_MSI_INT_AER_EVT		25
> +#define EVENT_LOCAL_PM_MSI_INT_EVENTS		26
> +#define EVENT_LOCAL_PM_MSI_INT_SYS_ERR		27
> +#define NUM_EVENTS				28
> +
> +#define PCIE_EVENT_CAUSE(x, s)	\
> +	[EVENT_PCIE_ ## x] = { __stringify(x), s }
> +
> +#define SEC_ERROR_CAUSE(x, s) \
> +	[EVENT_SEC_ ## x] = { __stringify(x), s }
> +
> +#define DED_ERROR_CAUSE(x, s) \
> +	[EVENT_DED_ ## x] = { __stringify(x), s }
> +
> +#define LOCAL_EVENT_CAUSE(x, s) \
> +	[EVENT_LOCAL_ ## x] = { __stringify(x), s }
> +
> +#define PCIE_EVENT(x) \
> +	.base = MC_PCIE_CTRL_ADDR, \
> +	.offset = PCIE_EVENT_INT, \
> +	.mask_offset = PCIE_EVENT_INT, \
> +	.mask_high = 1, \
> +	.mask = PCIE_EVENT_INT_ ## x ## _INT, \
> +	.enb_mask = PCIE_EVENT_INT_ENB_MASK
> +
> +#define SEC_EVENT(x) \
> +	.base = MC_PCIE_CTRL_ADDR, \
> +	.offset = SEC_ERROR_INT, \
> +	.mask_offset = SEC_ERROR_INT_MASK, \
> +	.mask = SEC_ERROR_INT_ ## x ## _INT, \
> +	.mask_high = 1, \
> +	.enb_mask = 0
> +
> +#define DED_EVENT(x) \
> +	.base = MC_PCIE_CTRL_ADDR, \
> +	.offset = DED_ERROR_INT, \
> +	.mask_offset = DED_ERROR_INT_MASK, \
> +	.mask_high = 1, \
> +	.mask = DED_ERROR_INT_ ## x ## _INT, \
> +	.enb_mask = 0
> +
> +#define LOCAL_EVENT(x) \
> +	.base = MC_PCIE_BRIDGE_ADDR, \
> +	.offset = ISTATUS_LOCAL, \
> +	.mask_offset = IMASK_LOCAL, \
> +	.mask_high = 0, \
> +	.mask = x ## _MASK, \
> +	.enb_mask = 0
> +
> +#define PCIE_EVENT_TO_EVENT_MAP(x) \
> +	{ PCIE_EVENT_INT_ ## x ## _INT, EVENT_PCIE_ ## x }
> +
> +#define SEC_ERROR_TO_EVENT_MAP(x) \
> +	{ SEC_ERROR_INT_ ## x ## _INT, EVENT_SEC_ ## x }
> +
> +#define DED_ERROR_TO_EVENT_MAP(x) \
> +	{ DED_ERROR_INT_ ## x ## _INT, EVENT_DED_ ## x }
> +
> +#define LOCAL_STATUS_TO_EVENT_MAP(x) \
> +	{ x ## _MASK, EVENT_LOCAL_ ## x }
> +
> +struct event_map {
> +	u32 reg_mask;
> +	u32 event_bit;
> +};
> +
> +struct mc_msi {
> +	struct mutex lock;		/* Protect used bitmap */
> +	struct irq_domain *msi_domain;
> +	struct irq_domain *dev_domain;
> +	u32 num_vectors;
> +	u64 vector_phy;
> +	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +};
> +
> +struct mc_port {
> +	void __iomem *axi_base_addr;
> +	struct device *dev;
> +	struct irq_domain *intx_domain;
> +	struct irq_domain *event_domain;
> +	raw_spinlock_t lock;
> +	struct mc_msi msi;
> +};
> +
> +struct cause {
> +	const char *sym;
> +	const char *str;
> +};
> +
> +static const struct cause event_cause[NUM_EVENTS] = {
> +	PCIE_EVENT_CAUSE(L2_EXIT, "L2 exit event"),
> +	PCIE_EVENT_CAUSE(HOTRST_EXIT, "Hot reset exit event"),
> +	PCIE_EVENT_CAUSE(DLUP_EXIT, "DLUP exit event"),
> +	SEC_ERROR_CAUSE(TX_RAM_SEC_ERR,  "sec error in tx buffer"),
> +	SEC_ERROR_CAUSE(RX_RAM_SEC_ERR,  "sec error in rx buffer"),
> +	SEC_ERROR_CAUSE(PCIE2AXI_RAM_SEC_ERR,  "sec error in pcie2axi buffer"),
> +	SEC_ERROR_CAUSE(AXI2PCIE_RAM_SEC_ERR,  "sec error in axi2pcie buffer"),
> +	DED_ERROR_CAUSE(TX_RAM_DED_ERR,  "ded error in tx buffer"),
> +	DED_ERROR_CAUSE(RX_RAM_DED_ERR,  "ded error in rx buffer"),
> +	DED_ERROR_CAUSE(PCIE2AXI_RAM_DED_ERR,  "ded error in pcie2axi buffer"),
> +	DED_ERROR_CAUSE(AXI2PCIE_RAM_DED_ERR,  "ded error in axi2pcie buffer"),
> +	LOCAL_EVENT_CAUSE(DMA_ERROR_ENGINE_0, "dma engine 0 error"),
> +	LOCAL_EVENT_CAUSE(DMA_ERROR_ENGINE_1, "dma engine 1 error"),
> +	LOCAL_EVENT_CAUSE(A_ATR_EVT_POST_ERR, "axi write request error"),
> +	LOCAL_EVENT_CAUSE(A_ATR_EVT_FETCH_ERR, "axi read request error"),
> +	LOCAL_EVENT_CAUSE(A_ATR_EVT_DISCARD_ERR, "axi read timeout"),
> +	LOCAL_EVENT_CAUSE(P_ATR_EVT_POST_ERR, "pcie write request error"),
> +	LOCAL_EVENT_CAUSE(P_ATR_EVT_FETCH_ERR, "pcie read request error"),
> +	LOCAL_EVENT_CAUSE(P_ATR_EVT_DISCARD_ERR, "pcie read timeout"),
> +	LOCAL_EVENT_CAUSE(PM_MSI_INT_AER_EVT, "aer event"),
> +	LOCAL_EVENT_CAUSE(PM_MSI_INT_EVENTS, "pm/ltr/hotplug event"),
> +	LOCAL_EVENT_CAUSE(PM_MSI_INT_SYS_ERR, "system error"),
> +};
> +
> +struct event_map pcie_event_to_event[] = {
> +	PCIE_EVENT_TO_EVENT_MAP(L2_EXIT),
> +	PCIE_EVENT_TO_EVENT_MAP(HOTRST_EXIT),
> +	PCIE_EVENT_TO_EVENT_MAP(DLUP_EXIT)
> +};
> +
> +struct event_map sec_error_to_event[] = {
> +	SEC_ERROR_TO_EVENT_MAP(TX_RAM_SEC_ERR),
> +	SEC_ERROR_TO_EVENT_MAP(RX_RAM_SEC_ERR),
> +	SEC_ERROR_TO_EVENT_MAP(PCIE2AXI_RAM_SEC_ERR),
> +	SEC_ERROR_TO_EVENT_MAP(AXI2PCIE_RAM_SEC_ERR)
> +};
> +
> +struct event_map ded_error_to_event[] = {
> +	DED_ERROR_TO_EVENT_MAP(TX_RAM_DED_ERR),
> +	DED_ERROR_TO_EVENT_MAP(RX_RAM_DED_ERR),
> +	DED_ERROR_TO_EVENT_MAP(PCIE2AXI_RAM_DED_ERR),
> +	DED_ERROR_TO_EVENT_MAP(AXI2PCIE_RAM_DED_ERR)
> +};
> +
> +struct event_map local_status_to_event[] = {
> +	LOCAL_STATUS_TO_EVENT_MAP(DMA_END_ENGINE_0),
> +	LOCAL_STATUS_TO_EVENT_MAP(DMA_END_ENGINE_1),
> +	LOCAL_STATUS_TO_EVENT_MAP(DMA_ERROR_ENGINE_0),
> +	LOCAL_STATUS_TO_EVENT_MAP(DMA_ERROR_ENGINE_1),
> +	LOCAL_STATUS_TO_EVENT_MAP(A_ATR_EVT_POST_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(A_ATR_EVT_FETCH_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(A_ATR_EVT_DISCARD_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(A_ATR_EVT_DOORBELL),
> +	LOCAL_STATUS_TO_EVENT_MAP(P_ATR_EVT_POST_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(P_ATR_EVT_FETCH_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(P_ATR_EVT_DISCARD_ERR),
> +	LOCAL_STATUS_TO_EVENT_MAP(P_ATR_EVT_DOORBELL),
> +	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_INTX),
> +	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_MSI),
> +	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_AER_EVT),
> +	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_EVENTS),
> +	LOCAL_STATUS_TO_EVENT_MAP(PM_MSI_INT_SYS_ERR),
> +};
> +
> +struct {
> +	u32 base;
> +	u32 offset;
> +	u32 mask;
> +	u32 shift;
> +	u32 enb_mask;
> +	u32 mask_high;
> +	u32 mask_offset;
> +} event_descs[] = {
> +	{ PCIE_EVENT(L2_EXIT) },
> +	{ PCIE_EVENT(HOTRST_EXIT) },
> +	{ PCIE_EVENT(DLUP_EXIT) },
> +	{ SEC_EVENT(TX_RAM_SEC_ERR) },
> +	{ SEC_EVENT(RX_RAM_SEC_ERR) },
> +	{ SEC_EVENT(PCIE2AXI_RAM_SEC_ERR) },
> +	{ SEC_EVENT(AXI2PCIE_RAM_SEC_ERR) },
> +	{ DED_EVENT(TX_RAM_DED_ERR) },
> +	{ DED_EVENT(RX_RAM_DED_ERR) },
> +	{ DED_EVENT(PCIE2AXI_RAM_DED_ERR) },
> +	{ DED_EVENT(AXI2PCIE_RAM_DED_ERR) },
> +	{ LOCAL_EVENT(DMA_END_ENGINE_0) },
> +	{ LOCAL_EVENT(DMA_END_ENGINE_1) },
> +	{ LOCAL_EVENT(DMA_ERROR_ENGINE_0) },
> +	{ LOCAL_EVENT(DMA_ERROR_ENGINE_1) },
> +	{ LOCAL_EVENT(A_ATR_EVT_POST_ERR) },
> +	{ LOCAL_EVENT(A_ATR_EVT_FETCH_ERR) },
> +	{ LOCAL_EVENT(A_ATR_EVT_DISCARD_ERR) },
> +	{ LOCAL_EVENT(A_ATR_EVT_DOORBELL) },
> +	{ LOCAL_EVENT(P_ATR_EVT_POST_ERR) },
> +	{ LOCAL_EVENT(P_ATR_EVT_FETCH_ERR) },
> +	{ LOCAL_EVENT(P_ATR_EVT_DISCARD_ERR) },
> +	{ LOCAL_EVENT(P_ATR_EVT_DOORBELL) },
> +	{ LOCAL_EVENT(PM_MSI_INT_INTX) },
> +	{ LOCAL_EVENT(PM_MSI_INT_MSI) },
> +	{ LOCAL_EVENT(PM_MSI_INT_AER_EVT) },
> +	{ LOCAL_EVENT(PM_MSI_INT_EVENTS) },
> +	{ LOCAL_EVENT(PM_MSI_INT_SYS_ERR) }
> +};
> +
> +static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
> +
> +static void mc_pcie_enable_msi(struct mc_port *port, void __iomem *base)
> +{
> +	struct mc_msi *msi = &port->msi;
> +	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> +	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
> +
> +	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
> +	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
> +	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> +	msg_ctrl |= MC_MSI_Q_SIZE;
> +	msg_ctrl |= PCI_MSI_FLAGS_64BIT;

Pretty sure you can write in a more compact way.

[...]

> +static const struct pci_ecam_ops mc_ecam_ops = {
> +	.bus_shift = 20,

Not needed, see commit e7708f5b10e2

Can you respin promptly please so that we can merge it ?

Thanks,
Lorenzo

> +	.init = mc_platform_init,
> +	.pci_ops = {
> +		.map_bus = pci_ecam_map_bus,
> +		.read = pci_generic_config_read,
> +		.write = pci_generic_config_write,
> +	}
> +};
> +
> +static const struct of_device_id mc_pcie_of_match[] = {
> +	{
> +		.compatible = "microchip,pcie-host-1.0",
> +		.data = &mc_ecam_ops,
> +	},
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, mc_pcie_of_match)
> +
> +static struct platform_driver mc_pcie_driver = {
> +	.probe = pci_host_common_probe,
> +	.driver = {
> +		.name = "microchip-pcie",
> +		.of_match_table = mc_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +
> +builtin_platform_driver(mc_pcie_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Microchip PCIe host controller driver");
> +MODULE_AUTHOR("Daire McNamara <daire.mcnamara@microchip.com>");
> -- 
> 2.25.1
> 
