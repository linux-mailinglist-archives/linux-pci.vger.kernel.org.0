Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC94E003F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388135AbfJVJE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 05:04:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:22363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387695AbfJVJE3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 05:04:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 02:04:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="227631057"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 22 Oct 2019 02:04:26 -0700
Received: from [10.226.39.21] (unknown [10.226.39.21])
        by linux.intel.com (Postfix) with ESMTP id C5B0C58029D;
        Tue, 22 Oct 2019 02:04:22 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        hch@infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
References: <cover.1571638827.git.eswara.kota@linux.intel.com>
 <c46ba3f4187fe53807948b4f10996b89a75c492c.1571638827.git.eswara.kota@linux.intel.com>
 <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <661f7e9c-a79f-bea6-08d8-4df54f500019@linux.intel.com>
Date:   Tue, 22 Oct 2019 17:04:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021130339.GP47056@e119886-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andrew Murray,

On 10/21/2019 9:03 PM, Andrew Murray wrote:
> On Mon, Oct 21, 2019 at 02:39:19PM +0800, Dilip Kota wrote:
>> Add support to PCIe RC controller on Intel Gateway SoCs.
>> PCIe controller is based of Synopsys DesignWare pci core.
>>
>> Intel PCIe driver requires Upconfig support, fast training
>> sequence configuration and link speed change. So adding the
>> respective helper functions in the pcie DesignWare framework.
>> It also programs hardware autonomous speed during speed
>> configuration so defining it in pci_regs.h.
>>
>> Changes on v4:
>> 	Rename the driver naming and description to
>> 	 "PCIe RC controller on Intel Gateway SoCs".
>> 	Use PCIe core register macros defined in pci_regs.h
>> 	 and remove respective local definitions.
>> 	Remove pcie core interrupt handling.
>> 	Move pcie link control speed change, upconfig and FTS.
>> 	configuration functions to DesignWare framework.
>> 	Use of_pci_get_max_link_speed().
>> 	Mark dependency on X86 and COMPILE_TEST in Kconfig.
>> 	Remove lanes and add n_fts variables in intel_pcie_port structure.
>> 	Rename rst_interval variable to rst_intrvl in intel_pcie_port structure.
>> 	Remove intel_pcie_mem_iatu() as it is already perfomed in dw_setup_rc()
>> 	Move sysfs attributes specific code to separate patch.
>> 	Remove redundant error handling.
>> 	Reduce LoCs by doing variable initializations while declaration itself.
>> 	Add extra line after closing parenthesis.
>> 	Move intel_pcie_ep_rst_init() out of get_resources()
>>
>> changes on v3:
>> 	Rename PCIe app logic registers with PCIE_APP prefix.
>> 	PCIE_IOP_CTRL configuration is not required. Remove respective code.
>> 	Remove wrapper functions for clk enable/disable APIs.
>> 	Use platform_get_resource_byname() instead of
>> 	  devm_platform_ioremap_resource() to be similar with DWC framework.
>> 	Rename phy name to "pciephy".
>> 	Modify debug message in msi_init() callback to be more specific.
>> 	Remove map_irq() callback.
>> 	Enable the INTx interrupts at the time of PCIe initialization.
>> 	Reduce memory fragmentation by using variable "struct dw_pcie pci"
>> 	  instead of allocating memory.
>> 	Reduce the delay to 100us during enpoint initialization
>> 	  intel_pcie_ep_rst_init().
>> 	Call  dw_pcie_host_deinit() during remove() instead of directly
>> 	  calling PCIe core APIs.
>> 	Rename "intel,rst-interval" to "reset-assert-ms".
>> 	Remove unused APP logic Interrupt bit macro definitions.
>>   	Use dwc framework's dw_pcie_setup_rc() for PCIe host specific
>> 	 configuration instead of redefining the same functionality in
>> 	 the driver.
>> 	Move the whole DT parsing specific code to intel_pcie_get_resources()
>>
>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>> ---
>>   drivers/pci/controller/dwc/Kconfig           |  10 +
>>   drivers/pci/controller/dwc/Makefile          |   1 +
>>   drivers/pci/controller/dwc/pcie-designware.c |  34 ++
>>   drivers/pci/controller/dwc/pcie-designware.h |  12 +
>>   drivers/pci/controller/dwc/pcie-intel-gw.c   | 590 +++++++++++++++++++++++++++
>>   include/uapi/linux/pci_regs.h                |   1 +
>>   6 files changed, 648 insertions(+)
>>   create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>>
>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>> index 0ba988b5b5bc..b33ed1cc873d 100644
>> --- a/drivers/pci/controller/dwc/Kconfig
>> +++ b/drivers/pci/controller/dwc/Kconfig
>> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>>   	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>   	  selected.
>>   
>> +config PCIE_INTEL_GW
>> +        bool "Intel Gateway PCIe host controller support"
>> +	depends on OF && (X86 || COMPILE_TEST)
>> +	select PCIE_DW_HOST
>> +	help
>> +          Say 'Y' here to enable support for PCIe Host controller driver.
> This sentence is very generic, we don't even say what controller driver.
>
>> +	  The PCIe controller on Intel Gateway SoCs is based on the Synopsys
>> +	  DesignWare pcie core and therefore uses the DesignWare core
>> +	  functions for the driver implementation.
> Thanks for changing the driver name, though the description hasn't really
> changed since the last revision. In particular, Christoph's feedback mentioned
> that it would be useful to describe where this IP block may be used - is there
> any reason why we can't make this more useful for users?
I will add more information.
>
>> +
>>   config PCI_EXYNOS
>>   	bool "Samsung Exynos PCIe controller"
>>   	depends on SOC_EXYNOS5440 || COMPILE_TEST
>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>> index b30336181d46..99db83cd2f35 100644
>> --- a/drivers/pci/controller/dwc/Makefile
>> +++ b/drivers/pci/controller/dwc/Makefile
>> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>   obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>>   obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>   obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>> +obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>   obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>   obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>> index 820488dfeaed..4c391bfd681a 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.c
>> +++ b/drivers/pci/controller/dwc/pcie-designware.c
>> @@ -474,6 +474,40 @@ int dw_pcie_link_up(struct dw_pcie *pci)
>>   		(!(val & PCIE_PORT_DEBUG1_LINK_IN_TRAINING)));
>>   }
>>   
>> +
>> +void dw_pcie_upconfig_setup(struct dw_pcie *pci)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
>> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL,
>> +			   val | PORT_MLTI_UPCFG_SUPPORT);
>> +}
>> +
>> +void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> +
>> +	if (enable)
>> +		val |= PORT_LOGIC_SPEED_CHANGE;
>> +	else
>> +		val &= ~PORT_LOGIC_SPEED_CHANGE;
>> +
>> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>> +}
> It's always great to see code move from specific drivers to parent drivers
> as it helps reduce duplication of code.
>
> Though I notice that imx6_pcie_establish_link (pci-imx6.c) and
> dw_pcie_setup_rc (pcie-designware-host.c) also does this. Rather than have
> duplicated code, I think it makes sense to adopt those users to this new
> code.
>
> In any case, the above function isn't used here. Can you add it in any
> patch that does use it please?
In the earlier patch version this function is being called in 
intel_pcie_rc_setup().
After noticing this operation is being performed in dw_pcie_setup_rc(), 
i removed the dw_pcie_link_speed_change() function call, but missed to 
move the function definition to sysfs attribute patch as it is not being 
called here.

I will move it to the sysfs attribute patch.
Thanks for pointing it.
>
>> +
>> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
>> +{
>> +	u32 val;
>> +
>> +	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
>> +	val &= ~PORT_LOGIC_N_FTS;
>> +	val |= n_fts;
>> +	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
>> +}
> I notice that pcie-artpec6.c (artpec6_pcie_set_nfts) also writes the FTS
> and defines a bunch of macros to support this. It doesn't make sense to
> duplicate this there. Therefore I think we need to update pcie-artpec6.c
> to use this new function.
I think we can do in a separate patch after these changes get merged and 
keep this patch series for intel PCIe driver and required changes in 
PCIe DesignWare framework.
>
>> +
>>   static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
>>   {
>>   	u32 val;
>> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
>> index 5a18e94e52c8..3beac10e4a4c 100644
>> --- a/drivers/pci/controller/dwc/pcie-designware.h
>> +++ b/drivers/pci/controller/dwc/pcie-designware.h
>> @@ -30,7 +30,12 @@
>>   #define LINK_WAIT_IATU			9
>>   
>>   /* Synopsys-specific PCIe configuration registers */
>> +#define PCIE_PORT_AFR			0x70C
>> +#define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
>> +#define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
>> +
>>   #define PCIE_PORT_LINK_CONTROL		0x710
>> +#define PORT_LINK_DLL_LINK_EN		BIT(5)
>>   #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
>>   #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
>>   #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
>> @@ -46,6 +51,7 @@
>>   #define PCIE_PORT_DEBUG1_LINK_IN_TRAINING	BIT(29)
>>   
>>   #define PCIE_LINK_WIDTH_SPEED_CONTROL	0x80C
>> +#define PORT_LOGIC_N_FTS		GENMASK(7, 0)
>>   #define PORT_LOGIC_SPEED_CHANGE		BIT(17)
>>   #define PORT_LOGIC_LINK_WIDTH_MASK	GENMASK(12, 8)
>>   #define PORT_LOGIC_LINK_WIDTH(n)	FIELD_PREP(PORT_LOGIC_LINK_WIDTH_MASK, n)
>> @@ -60,6 +66,9 @@
>>   #define PCIE_MSI_INTR0_MASK		0x82C
>>   #define PCIE_MSI_INTR0_STATUS		0x830
>>   
>> +#define PCIE_PORT_MULTI_LANE_CTRL	0x8C0
>> +#define PORT_MLTI_UPCFG_SUPPORT		BIT(7)
>> +
>>   #define PCIE_ATU_VIEWPORT		0x900
>>   #define PCIE_ATU_REGION_INBOUND		BIT(31)
>>   #define PCIE_ATU_REGION_OUTBOUND	0
>> @@ -273,6 +282,9 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>>   u32 dw_pcie_read_atu(struct dw_pcie *pci, u32 reg, size_t size);
>>   void dw_pcie_write_atu(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
>>   int dw_pcie_link_up(struct dw_pcie *pci);
>> +void dw_pcie_upconfig_setup(struct dw_pcie *pci);
>> +void dw_pcie_link_speed_change(struct dw_pcie *pci, bool enable);
>> +void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
>>   int dw_pcie_wait_for_link(struct dw_pcie *pci);
>>   void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>>   			       int type, u64 cpu_addr, u64 pci_addr,
>> diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> new file mode 100644
>> index 000000000000..9142c70db808
>> --- /dev/null
>> +++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
>> @@ -0,0 +1,590 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe host controller driver for Intel Gateway SoCs
>> + *
>> + * Copyright (c) 2019 Intel Corporation.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_pci.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/pci_regs.h>
>> +#include <linux/phy/phy.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/reset.h>
>> +
>> +#include "../../pci.h"
> I expected this to be removed, is it needed now?

In the earlier patch you suggested to use "of_pci_get_max_link_speed()" 
instead of device_get_*.
And, pci.h is required for it.

>
>> +#include "pcie-designware.h"
>> +
>> +#define PCIE_CAP_OFST			0x70
>> +
>> +#define PORT_AFR_N_FTS_GEN12_DFT	(SZ_128 - 1)
>> +#define PORT_AFR_N_FTS_GEN3		180
>> +#define PORT_AFR_N_FTS_GEN4		196
>> +
>> +/* PCIe Application logic Registers */
>> +#define PCIE_APP_CCR			0x10
>> +#define PCIE_APP_CCR_LTSSM_ENABLE	BIT(0)
>> +
>> +#define PCIE_APP_MSG_CR			0x30
>> +#define PCIE_APP_MSG_XMT_PM_TURNOFF	BIT(0)
>> +
>> +#define PCIE_APP_PMC			0x44
>> +#define PCIE_APP_PMC_IN_L2		BIT(20)
>> +
>> +#define PCIE_APP_IRNEN			0xF4
>> +#define PCIE_APP_IRNCR			0xF8
>> +#define PCIE_APP_IRN_AER_REPORT		BIT(0)
>> +#define PCIE_APP_IRN_PME		BIT(2)
>> +#define PCIE_APP_IRN_RX_VDM_MSG		BIT(4)
>> +#define PCIE_APP_IRN_PM_TO_ACK		BIT(9)
>> +#define PCIE_APP_IRN_LINK_AUTO_BW_STAT	BIT(11)
>> +#define PCIE_APP_IRN_BW_MGT		BIT(12)
>> +#define PCIE_APP_IRN_MSG_LTR		BIT(18)
>> +#define PCIE_APP_IRN_SYS_ERR_RC		BIT(29)
>> +#define PCIE_APP_INTX_OFST		12
>> +
>> +#define PCIE_APP_IRN_INT \
>> +			(PCIE_APP_IRN_AER_REPORT | PCIE_APP_IRN_PME | \
>> +			PCIE_APP_IRN_RX_VDM_MSG | PCIE_APP_IRN_SYS_ERR_RC | \
>> +			PCIE_APP_IRN_PM_TO_ACK | PCIE_APP_IRN_MSG_LTR | \
>> +			PCIE_APP_IRN_BW_MGT | PCIE_APP_IRN_LINK_AUTO_BW_STAT | \
>> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTA) | \
>> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTB) | \
>> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTC) | \
>> +			(PCIE_APP_INTX_OFST + PCI_INTERRUPT_INTD))
>> +
>> +#define BUS_IATU_OFFS			SZ_256M
>> +#define RST_INTRVL_DFT_MS		100
>> +
>> +enum {
>> +	PCIE_LINK_SPEED_AUTO = 0,
>> +	PCIE_LINK_SPEED_GEN1,
>> +	PCIE_LINK_SPEED_GEN2,
>> +	PCIE_LINK_SPEED_GEN3,
>> +	PCIE_LINK_SPEED_GEN4,
>> +};
>> +
>> +struct intel_pcie_soc {
>> +	unsigned int pcie_ver;
>> +	unsigned int pcie_atu_offset;
>> +	u32 num_viewport;
>> +};
>> +
>> +struct intel_pcie_port {
>> +	struct dw_pcie		pci;
>> +	unsigned int		id; /* Physical RC Index */
>> +	void __iomem		*app_base;
>> +	struct gpio_desc	*reset_gpio;
>> +	u32			rst_intrvl;
>> +	u32			max_speed;
>> +	u32			link_gen;
>> +	u32			max_width;
>> +	u32			n_fts;
>> +	struct clk		*core_clk;
>> +	struct reset_control	*core_rst;
>> +	struct phy		*phy;
>> +};
>> +
>> +static void pcie_update_bits(void __iomem *base, u32 mask, u32 val, u32 ofs)
>> +{
>> +	u32 orig, tmp;
>> +
>> +	orig = readl(base + ofs);
>> +
>> +	tmp = (orig & ~mask) | (val & mask);
>> +
>> +	if (tmp != orig)
>> +		writel(tmp, base + ofs);
>> +}
>> +
>> +static inline u32 pcie_app_rd(struct intel_pcie_port *lpp, u32 ofs)
>> +{
>> +	return readl(lpp->app_base + ofs);
>> +}
>> +
>> +static inline void pcie_app_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
>> +{
>> +	writel(val, lpp->app_base + ofs);
>> +}
>> +
>> +static void pcie_app_wr_mask(struct intel_pcie_port *lpp,
>> +			     u32 mask, u32 val, u32 ofs)
>> +{
>> +	pcie_update_bits(lpp->app_base, mask, val, ofs);
>> +}
>> +
>> +static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
>> +{
>> +	return dw_pcie_readl_dbi(&lpp->pci, ofs);
>> +}
>> +
>> +static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 val, u32 ofs)
>> +{
>> +	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
>> +}
>> +
>> +static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp,
>> +				u32 mask, u32 val, u32 ofs)
>> +{
>> +	pcie_update_bits(lpp->pci.dbi_base, mask, val, ofs);
>> +}
>> +
>> +static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
>> +{
>> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE,
>> +			 PCIE_APP_CCR_LTSSM_ENABLE, PCIE_APP_CCR);
>> +}
>> +
>> +static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
>> +{
>> +	pcie_app_wr_mask(lpp, PCIE_APP_CCR_LTSSM_ENABLE, 0, PCIE_APP_CCR);
>> +}
>> +
>> +static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
>> +{
>> +	u32 val;
>> +
>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
>> +	lpp->max_speed = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +	lpp->max_width = FIELD_GET(PCI_EXP_LNKCAP_MLW, val);
>> +
>> +	val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>> +
>> +	val &= ~(PCI_EXP_LNKCTL_LD | PCI_EXP_LNKCTL_ASPMC);
>> +	val |= (PCI_EXP_LNKSTA_SLC << 16) | PCI_EXP_LNKCTL_CCC |
>> +	       PCI_EXP_LNKCTL_RCB;
>> +	pcie_rc_cfg_wr(lpp, val, PCIE_CAP_OFST + PCI_EXP_LNKCTL);
>> +}
>> +
>> +static void intel_pcie_max_speed_setup(struct intel_pcie_port *lpp)
>> +{
>> +	u32 reg, val;
>> +
>> +	reg = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
>> +	switch (lpp->link_gen) {
>> +	case PCIE_LINK_SPEED_GEN1:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_2_5GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN2:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_5_0GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN3:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_8_0GT;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN4:
>> +		reg &= ~PCI_EXP_LNKCTL2_TLS;
>> +		reg |= PCI_EXP_LNKCTL2_HASD|
>> +			PCI_EXP_LNKCTL2_TLS_16_0GT;
>> +		break;
>> +	default:
>> +		/* Use hardware capability */
>> +		val = pcie_rc_cfg_rd(lpp, PCIE_CAP_OFST + PCI_EXP_LNKCAP);
>> +		val = FIELD_GET(PCI_EXP_LNKCAP_SLS, val);
>> +		reg &= ~PCI_EXP_LNKCTL2_HASD;
>> +		reg |= val;
>> +		break;
>> +	}
>> +
>> +	pcie_rc_cfg_wr(lpp, reg, PCIE_CAP_OFST + PCI_EXP_LNKCTL2);
>> +	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
>> +}
>> +
>> +
>> +
> Lots of space here isn't needed.
i will remove it.
>
>> +static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
>> +{
>> +	u32 val, mask;
>> +
>> +	switch (lpp->max_speed) {
>> +	case PCIE_LINK_SPEED_GEN3:
>> +		lpp->n_fts = PORT_AFR_N_FTS_GEN3;
>> +		break;
>> +	case PCIE_LINK_SPEED_GEN4:
>> +		lpp->n_fts = PORT_AFR_N_FTS_GEN4;
>> +		break;
>> +	default:
>> +		lpp->n_fts = PORT_AFR_N_FTS_GEN12_DFT;
>> +		break;
>> +	}
>> +
>> +	mask = PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
>> +	val = FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
>> +	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
>> +	pcie_rc_cfg_wr_mask(lpp, mask, val, PCIE_PORT_AFR);
>> +
>> +	/* Port Link Control Register */
>> +	pcie_rc_cfg_wr_mask(lpp, PORT_LINK_DLL_LINK_EN,
>> +			    PORT_LINK_DLL_LINK_EN, PCIE_PORT_LINK_CONTROL);
>> +}
>> +
>> +static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
>> +{
>> +	intel_pcie_ltssm_disable(lpp);
>> +	intel_pcie_link_setup(lpp);
>> +	dw_pcie_setup_rc(&lpp->pci.pp);
>> +	dw_pcie_upconfig_setup(&lpp->pci);
>> +	intel_pcie_port_logic_setup(lpp);
>> +	intel_pcie_max_speed_setup(lpp);
>> +}
>> +
>> +static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
>> +{
>> +	struct device *dev = lpp->pci.dev;
>> +	int ret;
>> +
>> +	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
>> +	if (IS_ERR(lpp->reset_gpio)) {
>> +		ret = PTR_ERR(lpp->reset_gpio);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to request PCIe GPIO: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Make initial reset last for 100us */
>> +	usleep_range(100, 200);
>> +
>> +	return 0;
>> +}
>> +
>> +static void intel_pcie_core_rst_assert(struct intel_pcie_port *lpp)
>> +{
>> +	reset_control_assert(lpp->core_rst);
>> +}
>> +
>> +static void intel_pcie_core_rst_deassert(struct intel_pcie_port *lpp)
>> +{
>> +	/*
>> +	 * One micro-second delay to make sure the reset pulse
>> +	 * wide enough so that core reset is clean.
>> +	 */
>> +	udelay(1);
>> +	reset_control_deassert(lpp->core_rst);
>> +
>> +	/*
>> +	 * Some SoC core reset also reset PHY, more delay needed
>> +	 * to make sure the reset process is done.
>> +	 */
>> +	usleep_range(1000, 2000);
>> +}
>> +
>> +static void intel_pcie_device_rst_assert(struct intel_pcie_port *lpp)
>> +{
>> +	gpiod_set_value_cansleep(lpp->reset_gpio, 1);
>> +}
>> +
>> +static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
>> +{
>> +	msleep(lpp->rst_intrvl);
>> +	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
>> +}
>> +
>> +static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
>> +{
>> +	intel_pcie_device_rst_deassert(lpp);
>> +	intel_pcie_ltssm_enable(lpp);
>> +
>> +	return dw_pcie_wait_for_link(&lpp->pci);
>> +}
>> +
>> +static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
>> +{
>> +	pcie_app_wr(lpp, 0, PCIE_APP_IRNEN);
>> +	pcie_app_wr(lpp, PCIE_APP_IRN_INT,  PCIE_APP_IRNCR);
>> +}
>> +
>> +static int intel_pcie_get_resources(struct platform_device *pdev)
>> +{
>> +	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
>> +	struct dw_pcie *pci = &lpp->pci;
>> +	struct device *dev = pci->dev;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	ret = device_property_read_u32(dev, "linux,pci-domain", &lpp->id);
>> +	if (ret) {
>> +		dev_err(dev, "failed to get domain id, errno %d\n", ret);
>> +		return ret;
>> +	}
> Why is this a required property?
I marked it required property because lpp->id is being used during debug 
prints.
   -> sprintf(buf, "Port %2u Width x%u Speed %s GT/s\n", lpp->id,
  -> dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);

Hmmm.. I found, domain id can be traversed from pci_host_bridge 
structure after dw_pcie_host_init().
I will remove the code for getting the pci-domain here.

>
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dbi");
>> +
>> +	pci->dbi_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(pci->dbi_base))
>> +		return PTR_ERR(pci->dbi_base);
>> +
>> +	lpp->core_clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(lpp->core_clk)) {
>> +		ret = PTR_ERR(lpp->core_clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get clks: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	lpp->core_rst = devm_reset_control_get(dev, NULL);
>> +	if (IS_ERR(lpp->core_rst)) {
>> +		ret = PTR_ERR(lpp->core_rst);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "failed to get resets: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = device_property_match_string(dev, "device_type", "pci");
>> +	if (ret) {
>> +		dev_err(dev, "failed to find pci device type: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	if (device_property_read_u32(dev, "reset-assert-ms", &lpp->rst_intrvl))
>> +		lpp->rst_intrvl = RST_INTRVL_DFT_MS;
>> +
>> +	ret = of_pci_get_max_link_speed(dev->of_node);
>> +		lpp->link_gen = ret < 0 ? 0 : ret;
> I think the spacing may be a little off above.
Yes, typo error. I will correct it.
>
>> +
>> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
>> +
>> +	lpp->app_base = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(lpp->app_base))
>> +		return PTR_ERR(lpp->app_base);
>> +
>> +	lpp->phy = devm_phy_get(dev, "pcie");
>> +	if (IS_ERR(lpp->phy)) {
>> +		ret = PTR_ERR(lpp->phy);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(dev, "couldn't get pcie-phy: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
>> +{
>> +	phy_exit(lpp->phy);
>> +}
>> +
>> +static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
>> +{
>> +	u32 value;
>> +	int ret;
>> +
>> +	if (lpp->max_speed < PCIE_LINK_SPEED_GEN3)
>> +		return 0;
>> +
>> +	/* Send PME_TURN_OFF message */
>> +	pcie_app_wr_mask(lpp, PCIE_APP_MSG_XMT_PM_TURNOFF,
>> +			 PCIE_APP_MSG_XMT_PM_TURNOFF, PCIE_APP_MSG_CR);
>> +
>> +	/* Read PMC status and wait for falling into L2 link state */
>> +	ret = readl_poll_timeout(lpp->app_base + PCIE_APP_PMC, value,
>> +				 (value & PCIE_APP_PMC_IN_L2), 20,
>> +				 jiffies_to_usecs(5 * HZ));
>> +	if (ret)
>> +		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
>> +
>> +	return ret;
>> +}
>> +
>> +static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
>> +{
>> +	if (dw_pcie_link_up(&lpp->pci))
>> +		intel_pcie_wait_l2(lpp);
>> +
>> +	/* Put endpoint device in reset state */
>> +	intel_pcie_device_rst_assert(lpp);
>> +	pcie_rc_cfg_wr_mask(lpp, PCI_COMMAND_MEMORY, 0, PCI_COMMAND);
>> +}
>> +
>> +static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
>> +{
>> +	int ret;
>> +
>> +	intel_pcie_core_rst_assert(lpp);
>> +	intel_pcie_device_rst_assert(lpp);
>> +
>> +	ret = phy_init(lpp->phy);
>> +	if (ret)
>> +		return ret;
>> +
>> +	intel_pcie_core_rst_deassert(lpp);
>> +
>> +	ret = clk_prepare_enable(lpp->core_clk);
>> +	if (ret) {
>> +		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
>> +		goto clk_err;
>> +	}
>> +
>> +	intel_pcie_rc_setup(lpp);
>> +	ret = intel_pcie_app_logic_setup(lpp);
>> +	if (ret)
>> +		goto app_init_err;
>> +
>> +	/* Enable integrated interrupts */
>> +	pcie_app_wr_mask(lpp, PCIE_APP_IRN_INT, PCIE_APP_IRN_INT,
>> +			 PCIE_APP_IRNEN);
>> +	return 0;
>> +
>> +app_init_err:
>> +	clk_disable_unprepare(lpp->core_clk);
>> +clk_err:
>> +	intel_pcie_core_rst_assert(lpp);
>> +	intel_pcie_deinit_phy(lpp);
>> +
>> +	return ret;
>> +}
>> +
>> +static void __intel_pcie_remove(struct intel_pcie_port *lpp)
>> +{
>> +	intel_pcie_core_irq_disable(lpp);
>> +	intel_pcie_turn_off(lpp);
>> +	clk_disable_unprepare(lpp->core_clk);
>> +	intel_pcie_core_rst_assert(lpp);
>> +	intel_pcie_deinit_phy(lpp);
>> +}
>> +
>> +static int intel_pcie_remove(struct platform_device *pdev)
>> +{
>> +	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
>> +	struct pcie_port *pp = &lpp->pci.pp;
>> +
>> +	dw_pcie_host_deinit(pp);
>> +	__intel_pcie_remove(lpp);
>> +
>> +	return 0;
>> +}
>> +
>> +static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
>> +{
>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	intel_pcie_core_irq_disable(lpp);
>> +	ret = intel_pcie_wait_l2(lpp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	intel_pcie_deinit_phy(lpp);
>> +	clk_disable_unprepare(lpp->core_clk);
>> +	return ret;
>> +}
>> +
>> +static int __maybe_unused intel_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct intel_pcie_port *lpp = dev_get_drvdata(dev);
>> +
>> +	return intel_pcie_host_setup(lpp);
>> +}
>> +
>> +static int intel_pcie_rc_init(struct pcie_port *pp)
>> +{
>> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +	struct intel_pcie_port *lpp = dev_get_drvdata(pci->dev);
>> +
>> +	return intel_pcie_host_setup(lpp);
>> +}
>> +
>> +int intel_pcie_msi_init(struct pcie_port *pp)
>> +{
>> +	/* PCIe MSI/MSIx is handled by MSI in x86 processor */
>> +	return 0;
>> +}
>> +
>> +u64 intel_pcie_cpu_addr(struct dw_pcie *pcie, u64 cpu_addr)
>> +{
>> +	return cpu_addr + BUS_IATU_OFFS;
>> +}
>> +
>> +static const struct dw_pcie_ops intel_pcie_ops = {
>> +	.cpu_addr_fixup = intel_pcie_cpu_addr,
>> +};
>> +
>> +static const struct dw_pcie_host_ops intel_pcie_dw_ops = {
>> +	.host_init =		intel_pcie_rc_init,
>> +	.msi_host_init =	intel_pcie_msi_init,
>> +};
>> +
>> +static const struct intel_pcie_soc pcie_data = {
>> +	.pcie_ver =		0x520A,
>> +	.pcie_atu_offset =	0xC0000,
>> +	.num_viewport =		3,
>> +};
>> +
>> +static int intel_pcie_probe(struct platform_device *pdev)
>> +{
>> +	const struct intel_pcie_soc *data;
>> +	struct device *dev = &pdev->dev;
>> +	struct intel_pcie_port *lpp;
>> +	struct pcie_port *pp;
>> +	struct dw_pcie *pci;
>> +	int ret;
>> +
>> +	lpp = devm_kzalloc(dev, sizeof(*lpp), GFP_KERNEL);
>> +	if (!lpp)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, lpp);
>> +	pci = &lpp->pci;
>> +	pci->dev = dev;
>> +	pp = &pci->pp;
>> +
>> +	ret = intel_pcie_get_resources(pdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = intel_pcie_ep_rst_init(lpp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	data = device_get_match_data(dev);
>> +	pci->ops = &intel_pcie_ops;
>> +	pci->version = data->pcie_ver;
>> +	pci->atu_base = pci->dbi_base + data->pcie_atu_offset;
>> +	pp->ops = &intel_pcie_dw_ops;
>> +
>> +	ret = dw_pcie_host_init(pp);
>> +	if (ret) {
>> +		dev_err(dev, "cannot initialize host\n");
>> +		return ret;
>> +	}
>> +
>> +	/* Intel PCIe doesn't configure IO region, so configure
>> +	 * viewport to not to access IO region during register
>> +	 * read write operations.
>> +	 */
>> +	pci->num_viewport = data->num_viewport;
>> +	dev_info(dev, "Intel PCIe Root Complex Port %d init done\n", lpp->id);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct dev_pm_ops intel_pcie_pm_ops = {
>> +	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(intel_pcie_suspend_noirq,
>> +				      intel_pcie_resume_noirq)
>> +};
>> +
>> +static const struct of_device_id of_intel_pcie_match[] = {
>> +	{ .compatible = "intel,lgm-pcie", .data = &pcie_data },
>> +	{}
>> +};
>> +
>> +static struct platform_driver intel_pcie_driver = {
>> +	.probe = intel_pcie_probe,
>> +	.remove = intel_pcie_remove,
>> +	.driver = {
>> +		.name = "intel-gw-pcie",
>> +		.of_match_table = of_intel_pcie_match,
>> +		.pm = &intel_pcie_pm_ops,
>> +	},
>> +};
>> +builtin_platform_driver(intel_pcie_driver);
>> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
>> index 29d6e93fd15e..f6e7e402f879 100644
>> --- a/include/uapi/linux/pci_regs.h
>> +++ b/include/uapi/linux/pci_regs.h
>> @@ -673,6 +673,7 @@
>>   #define  PCI_EXP_LNKCTL2_TLS_8_0GT	0x0003 /* Supported Speed 8GT/s */
>>   #define  PCI_EXP_LNKCTL2_TLS_16_0GT	0x0004 /* Supported Speed 16GT/s */
>>   #define  PCI_EXP_LNKCTL2_TLS_32_0GT	0x0005 /* Supported Speed 32GT/s */
>> +#define  PCI_EXP_LNKCTL2_HASD		0x0200 /* Hw Autonomous Speed Disable */
> I think this should be 0x0020.
Yes, my miss, i will update.
Thanks for pointing it.

Thanks for reviewing and providing the inputs.
Regards,
Dilip
>
> Thanks,
>
> Andrew Murray
>
>>   #define PCI_EXP_LNKSTA2		50	/* Link Status 2 */
>>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	52	/* v2 endpoints with link end here */
>>   #define PCI_EXP_SLTCAP2		52	/* Slot Capabilities 2 */
>> -- 
>> 2.11.0
>>
