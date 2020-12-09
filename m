Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544C72D48B2
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 19:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgLISOf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 13:14:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41460 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgLISOf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 13:14:35 -0500
Received: by mail-ot1-f68.google.com with SMTP id x13so2273362oto.8;
        Wed, 09 Dec 2020 10:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=shz10PV+PB92iWJUY8+K6i6CI6QnwIpDcxPTjprZB8Y=;
        b=C+VDjUb/M81bbsRRRU2Qf1FccVDCKm4DesbpFbZWDI+eBArOggLXrk7VfwLTdfw914
         OmdcPqIR/7UjDtNQEmrC5UdddYM3Ky5UXa9Qytu0NUW/or6//oT6Bh/LqFcrG992uCQr
         Fg2ntgA7VGUJ0aCNdaOPCPdCTxN7A+hnjsxJmoZVNS++2YzvLIgEEPYaoXEs3Lbh4snr
         FhVDxYibT1XLAQ7UzDSZYQKDLJBf5xaUOow/5c7GESWdh05s+KZQ/9RvYUwuwOhRAYuV
         KryKafKjwR9vzqZc0EXbhNewSpu862SCJHjk0TXN3FiR62G+wou91DEbivMPiTvTcgEs
         Adzw==
X-Gm-Message-State: AOAM530lGufkRLmw3rmYCrMa6NK17NTtqwFn1t52c82AEui8pvwPSRmn
        XvcOP6x615Rtlh0y5YC+9xdRjdaNwA==
X-Google-Smtp-Source: ABdhPJyABe0afy07Ir+uphS/d5JLM1mL4j/H7f1tWE/zLGOwCutx63SR9x0Bxi15+vXddWfKVN1t7w==
X-Received: by 2002:a9d:1b6f:: with SMTP id l102mr2770522otl.322.1607537632884;
        Wed, 09 Dec 2020 10:13:52 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o82sm443832oih.5.2020.12.09.10.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:13:51 -0800 (PST)
Received: (nullmailer pid 703058 invoked by uid 1000);
        Wed, 09 Dec 2020 18:13:50 -0000
Date:   Wed, 9 Dec 2020 12:13:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v3 2/2] PCI: keembay: Add support for Intel Keem Bay
Message-ID: <20201209181350.GB660537@robh.at.kernel.org>
References: <20201202073156.5187-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202073156.5187-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 02, 2020 at 03:31:56PM +0800, Wan Ahmad Zainie wrote:
> Add driver for Intel Keem Bay SoC PCIe controller. This controller
> is based on DesignWare PCIe core.
> 
> In root complex mode, only internal reference clock is possible for
> Keem Bay A0. For Keem Bay B0, external reference clock can be used
> and will be the default configuration. Currently, keembay_pcie_of_data
> structure has one member. It will be expanded later to handle this
> difference.
> 
> Endpoint mode link initialization is handled by the boot firmware.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  24 ++
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-keembay.c | 500 ++++++++++++++++++++++
>  3 files changed, 525 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-keembay.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index bc049865f8e0..2aab8f9872c7 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -219,6 +219,30 @@ config PCIE_INTEL_GW
>  	  The PCIe controller uses the DesignWare core plus Intel-specific
>  	  hardware wrappers.
>  
> +config PCIE_KEEMBAY
> +	bool
> +
> +config PCIE_KEEMBAY_HOST
> +	bool "Intel Keem Bay PCIe controller - Host mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	select PCIE_DW_HOST
> +	select PCIE_KEEMBAY
> +	help
> +	  Say Y here to enable support for the PCIe controller in Keem Bay
> +	  to work in host mode. This uses the DesignWare core.
> +
> +config PCIE_KEEMBAY_EP
> +	bool "Intel Keem Bay PCIe controller - Endpoint mode"
> +	depends on ARCH_KEEMBAY || COMPILE_TEST
> +	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	select PCIE_KEEMBAY
> +	help
> +	  Say Y here to enable support for the PCIe controller in Keem Bay
> +	  to work in endpoint mode. This uses the DesignWare core.
> +
>  config PCIE_KIRIN
>  	depends on OF && (ARM64 || COMPILE_TEST)
>  	bool "HiSilicon Kirin series SoCs PCIe controllers"
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a751553fa0db..95da2c62c426 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
>  obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
> +obj-$(CONFIG_PCIE_KEEMBAY) += pcie-keembay.o
>  obj-$(CONFIG_PCIE_KIRIN) += pcie-kirin.o
>  obj-$(CONFIG_PCIE_HISI_STB) += pcie-histb.o
>  obj-$(CONFIG_PCI_MESON) += pci-meson.o
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> new file mode 100644
> index 000000000000..71978c8bf8c6
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -0,0 +1,500 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * PCIe controller driver for Intel Keem Bay
> + * Copyright (C) 2020 Intel Corporation
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +
> +#include "pcie-designware.h"
> +
> +/* PCIE_REGS_APB_SLV Registers */
> +#define PCIE_REGS_PCIE_CFG		0x0004
> +#define  PCIE_DEVICE_TYPE		BIT(8)
> +#define  PCIE_RSTN			BIT(0)
> +#define PCIE_REGS_PCIE_APP_CNTRL	0x0008
> +#define  APP_LTSSM_ENABLE		BIT(0)
> +
> +#define PCIE_REGS_PCIE_INTR_ENABLE	0x0018
> +#define  LBC_CII_EVENT_EN		BIT(18)
> +#define PCIE_REGS_PCIE_INTR_FLAGS	0x001c
> +#define PCIE_REGS_PCIE_ERR_INTR_ENABLE	0x0020
> +#define  LINK_REQ_RST_EN		BIT(15)
> +#define PCIE_REGS_PCIE_ERR_INTR_FLAGS	0x0024
> +#define PCIE_REGS_INTERRUPT_ENABLE	0x0028
> +#define  MSI_CTRL_INT_EN		BIT(8)
> +#define  EDMA_INT_EN			GENMASK(7, 0)
> +#define PCIE_REGS_INTERRUPT_STATUS	0x002c
> +#define  MSI_CTRL_INT			BIT(8)
> +
> +#define PCIE_REGS_PCIE_SII_PM_STATE	0x00b0
> +#define  SMLH_LINK_UP			BIT(19)
> +#define  RDLH_LINK_UP			BIT(8)
> +#define  PCIE_REGS_PCIE_SII_LINK_UP	(SMLH_LINK_UP | RDLH_LINK_UP)
> +#define PCIE_REGS_PCIE_PHY_CNTL		0x0164
> +#define  PHY0_SRAM_BYPASS		BIT(8)
> +#define PCIE_REGS_PCIE_PHY_STAT		0x0168
> +#define  PHY0_MPLLA_STATE		BIT(1)
> +#define PCIE_REGS_LJPLL_STA		0x016c
> +#define  LJPLL_LOCK			BIT(0)
> +#define PCIE_REGS_LJPLL_CNTRL_0		0x0170
> +#define  LJPLL_EN			BIT(29)
> +#define  LJPLL_FOUT_EN			GENMASK(24, 21)
> +#define PCIE_REGS_LJPLL_CNTRL_2		0x0178
> +#define  LJPLL_REF_DIV			GENMASK(17, 12)
> +#define  LJPLL_FB_DIV			GENMASK(11, 0)
> +#define PCIE_REGS_LJPLL_CNTRL_3		0x017c
> +#define  LJPLL_POST_DIV3A		GENMASK(24, 22)
> +#define  LJPLL_POST_DIV2A		GENMASK(18, 16)
> +
> +#define PCIE_REGS_MEM_ACCESS_IRQ_ENABLE	0x0184
> +#define  MEM_ACCESS_IRQ_ENABLE		GENMASK(31, 0)
> +
> +#define PERST_DELAY_US		1000
> +#define AUX_CLK_RATE_HZ		24000000
> +
> +struct keembay_pcie {
> +	struct dw_pcie		pci;
> +	void __iomem		*apb_base;
> +	enum dw_pcie_device_mode mode;
> +
> +	struct clk		*clk_master;
> +	struct clk		*clk_aux;
> +	struct gpio_desc	*reset;
> +};
> +
> +struct keembay_pcie_of_data {
> +	enum dw_pcie_device_mode mode;
> +};
> +
> +static inline u32 keembay_pcie_readl(struct keembay_pcie *pcie, u32 offset)
> +{
> +	return readl(pcie->apb_base + offset);
> +}
> +
> +static inline void keembay_pcie_writel(struct keembay_pcie *pcie, u32 offset,
> +				       u32 value)
> +{
> +	writel(value, pcie->apb_base + offset);
> +}

I'd prefer to get rid of these pointless wrappers. Also, if ordering WRT 
to DMA is not needed, use _relaxed variants.

> +
> +static void keembay_ep_reset_assert(struct keembay_pcie *pcie)
> +{
> +	gpiod_set_value_cansleep(pcie->reset, 1);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void keembay_ep_reset_deassert(struct keembay_pcie *pcie)
> +{
> +	msleep(100);
> +
> +	gpiod_set_value_cansleep(pcie->reset, 0);
> +	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
> +}
> +
> +static void keembay_pcie_ltssm_enable(struct keembay_pcie *pcie, bool enable)
> +{
> +	u32 val;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_APP_CNTRL);
> +	if (enable)
> +		val |= APP_LTSSM_ENABLE;
> +	else
> +		val &= ~APP_LTSSM_ENABLE;
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_APP_CNTRL, val);

If this is the only bit in this register, do you really need RMW?

> +}
> +
> +static int keembay_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +	u32 val;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_SII_PM_STATE);
> +
> +	return (val & PCIE_REGS_PCIE_SII_LINK_UP) == PCIE_REGS_PCIE_SII_LINK_UP;
> +}
> +
> +static int keembay_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +	u32 val;
> +	int ret;
> +
> +	if (pcie->mode == DW_PCIE_EP_TYPE)
> +		return 0;
> +
> +	keembay_pcie_ltssm_enable(pcie, false);
> +
> +	ret = readl_poll_timeout(pcie->apb_base + PCIE_REGS_PCIE_PHY_STAT,
> +				 val, val & PHY0_MPLLA_STATE, 20,
> +				 500 * USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(pci->dev, "MPLLA is not locked\n");
> +		return ret;
> +	}
> +
> +	keembay_pcie_ltssm_enable(pcie, true);
> +
> +	return 0;
> +}
> +
> +static void keembay_pcie_stop_link(struct dw_pcie *pci)
> +{
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +
> +	keembay_pcie_ltssm_enable(pcie, false);
> +}
> +
> +static const struct dw_pcie_ops keembay_pcie_ops = {
> +	.link_up	= keembay_pcie_link_up,
> +	.start_link	= keembay_pcie_start_link,
> +	.stop_link	= keembay_pcie_stop_link,
> +};
> +
> +static inline struct clk *keembay_pcie_probe_clock(struct device *dev,
> +						   const char *id, u64 rate)
> +{
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get(dev, id);
> +	if (IS_ERR(clk))
> +		return clk;
> +
> +	if (rate) {
> +		ret = clk_set_rate(clk, rate);
> +		if (ret)
> +			return ERR_PTR(ret);
> +	}
> +
> +	ret = clk_prepare_enable(clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ret = devm_add_action_or_reset(dev,
> +				       (void(*)(void *))clk_disable_unprepare,
> +				       clk);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return clk;
> +}
> +
> +static int keembay_pcie_probe_clocks(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	pcie->clk_master = keembay_pcie_probe_clock(dev, "master", 0);
> +	if (IS_ERR(pcie->clk_master))
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk_master),
> +				     "Failed to enable master clock");
> +
> +	pcie->clk_aux = keembay_pcie_probe_clock(dev, "aux", AUX_CLK_RATE_HZ);
> +	if (IS_ERR(pcie->clk_aux))
> +		return dev_err_probe(dev, PTR_ERR(pcie->clk_aux),
> +				     "Failed to enable auxiliary clock");
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize the internal PCIe PLL in Host mode.
> + * See the following sections in Keem Bay data book,
> + * (1) 6.4.6.1 PCIe Subsystem Example Initialization,
> + * (2) 6.8 PCIe Low Jitter PLL for Ref Clk Generation.
> + */
> +static int keembay_pcie_pll_init(struct keembay_pcie *pcie)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	u32 val;
> +	int ret;
> +
> +	val = FIELD_PREP(LJPLL_REF_DIV, 0) | FIELD_PREP(LJPLL_FB_DIV, 0x32);
> +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_2, val);
> +
> +	val = FIELD_PREP(LJPLL_POST_DIV3A, 0x2) |
> +		FIELD_PREP(LJPLL_POST_DIV2A, 0x2);
> +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_3, val);
> +
> +	val = FIELD_PREP(LJPLL_EN, 0x1) | FIELD_PREP(LJPLL_FOUT_EN, 0xc);
> +	keembay_pcie_writel(pcie, PCIE_REGS_LJPLL_CNTRL_0, val);
> +
> +	ret = readl_poll_timeout(pcie->apb_base + PCIE_REGS_LJPLL_STA,
> +				 val, val & LJPLL_LOCK, 20,
> +				 500 * USEC_PER_MSEC);
> +	if (ret)
> +		dev_err(pci->dev, "Low jitter PLL is not locked\n");
> +
> +	return ret;
> +}
> +
> +static irqreturn_t keembay_pcie_irq_handler(int irq, void *arg)
> +{
> +	struct keembay_pcie *pcie = arg;
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	u32 val, mask, status;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_STATUS);
> +	mask = keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> +
> +	status = val & mask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & MSI_CTRL_INT)
> +		dw_handle_msi_irq(pp);
> +
> +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_STATUS, status);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int keembay_pcie_setup_irq(struct keembay_pcie *pcie)
> +{
> +
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int irq, ret;
> +
> +	irq = platform_get_irq_byname(pdev, "pcie");
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, keembay_pcie_irq_handler,
> +			       IRQF_SHARED | IRQF_NO_THREAD, "pcie", pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to request IRQ: %d\n", ret);
> +		return ret;
> +	}
> +

> +	irq = platform_get_irq_byname(pdev, "pcie_ev");
> +	if (irq < 0)
> +		return irq;
> +
> +	irq = platform_get_irq_byname(pdev, "pcie_err");
> +	if (irq < 0)
> +		return irq;
> +
> +	if (pcie->mode == DW_PCIE_EP_TYPE) {
> +		irq = platform_get_irq_byname(pdev, "pcie_mem_access");
> +		if (irq < 0)
> +			return irq;
> +	}

This is all dead code as you don't do anything with the irqs.

> +
> +	return 0;
> +}
> +
> +static void keembay_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct keembay_pcie *pcie = dev_get_drvdata(pci->dev);
> +	u32 val;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_ENABLE,
> +			    val | EDMA_INT_EN);

So you leave any other interrupts enabled which might already be 
enabled? Better to initialize to known state.

> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_INTR_ENABLE);
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_INTR_ENABLE,
> +			    val | LBC_CII_EVENT_EN);
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_ERR_INTR_ENABLE);
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_ERR_INTR_ENABLE,
> +			    val | LINK_REQ_RST_EN);
> +
> +	keembay_pcie_writel(pcie, PCIE_REGS_MEM_ACCESS_IRQ_ENABLE,
> +			    MEM_ACCESS_IRQ_ENABLE);
> +}
> +
> +static int keembay_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				     enum pci_epc_irq_type type,
> +				     u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		/* Legacy interrupts are not supported in Keem Bay */
> +		dev_err(pci->dev, "Legacy IRQ is not supported\n");
> +		return -EINVAL;
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "Unknown IRQ type %d\n", type);
> +		return -EINVAL;
> +	}

Doesn't the lack of a 'return' give a warning?

> +}
> +
> +static const struct pci_epc_features keembay_pcie_epc_features = {
> +	.linkup_notifier	= false,
> +	.msi_capable		= true,
> +	.msix_capable		= true,
> +	.reserved_bar		= BIT(BAR_1) | BIT(BAR_3) | BIT(BAR_5),
> +	.bar_fixed_64bit	= BIT(BAR_0) | BIT(BAR_2) | BIT(BAR_4),
> +	.align			= SZ_16K,
> +};
> +
> +static const struct pci_epc_features *
> +keembay_pcie_get_features(struct dw_pcie_ep *ep)
> +{
> +	return &keembay_pcie_epc_features;
> +}
> +
> +static const struct dw_pcie_ep_ops keembay_pcie_ep_ops = {
> +	.ep_init	= keembay_pcie_ep_init,
> +	.raise_irq	= keembay_pcie_ep_raise_irq,
> +	.get_features	= keembay_pcie_get_features,
> +};
> +
> +static const struct dw_pcie_host_ops keembay_pcie_host_ops = {
> +};
> +
> +static int keembay_pcie_add_pcie_port(struct keembay_pcie *pcie,
> +				      struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = &pcie->pci;
> +	struct pcie_port *pp = &pci->pp;
> +	struct device *dev = &pdev->dev;
> +	u32 val;
> +	int ret;
> +
> +	pp->ops = &keembay_pcie_host_ops;
> +	pp->msi_irq = -ENODEV;
> +
> +	pcie->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(pcie->reset))
> +		return PTR_ERR(pcie->reset);
> +
> +	ret = keembay_pcie_probe_clocks(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_PHY_CNTL);
> +	val |= PHY0_SRAM_BYPASS;
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_PHY_CNTL, val);
> +
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_CFG, PCIE_DEVICE_TYPE);
> +
> +	ret = keembay_pcie_pll_init(pcie);
> +	if (ret)
> +		return ret;
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_PCIE_CFG);
> +	keembay_pcie_writel(pcie, PCIE_REGS_PCIE_CFG, val | PCIE_RSTN);
> +
> +	keembay_ep_reset_deassert(pcie);
> +
> +	ret = dw_pcie_host_init(pp);
> +	if (ret) {
> +		keembay_ep_reset_assert(pcie);
> +		dev_err(dev, "Failed to initialize host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	val = keembay_pcie_readl(pcie, PCIE_REGS_INTERRUPT_ENABLE);
> +	if (IS_ENABLED(CONFIG_PCI_MSI))
> +		val |= MSI_CTRL_INT_EN;
> +	keembay_pcie_writel(pcie, PCIE_REGS_INTERRUPT_ENABLE, val);
> +
> +	return 0;
> +}
> +
> +static int keembay_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct keembay_pcie_of_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct keembay_pcie *pcie;
> +	struct dw_pcie *pci;
> +	enum dw_pcie_device_mode mode;
> +	int ret;
> +
> +	data = device_get_match_data(dev);
> +	if (!data)
> +		return -ENODEV;
> +
> +	mode = (enum dw_pcie_device_mode)data->mode;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &keembay_pcie_ops;
> +
> +	pcie->mode = mode;
> +
> +	pcie->apb_base = devm_platform_ioremap_resource_byname(pdev, "apb");
> +	if (IS_ERR(pcie->apb_base))
> +		return PTR_ERR(pcie->apb_base);
> +
> +	ret = keembay_pcie_setup_irq(pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	switch (pcie->mode) {
> +	case DW_PCIE_RC_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_HOST))
> +			return -ENODEV;
> +
> +		return keembay_pcie_add_pcie_port(pcie, pdev);
> +	case DW_PCIE_EP_TYPE:
> +		if (!IS_ENABLED(CONFIG_PCIE_KEEMBAY_EP))
> +			return -ENODEV;
> +
> +		pci->ep.ops = &keembay_pcie_ep_ops;
> +		return dw_pcie_ep_init(&pci->ep);
> +	default:
> +		dev_err(dev, "Invalid device type %d\n", pcie->mode);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct keembay_pcie_of_data keembay_pcie_rc_of_data = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static const struct keembay_pcie_of_data keembay_pcie_ep_of_data = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
> +static const struct of_device_id keembay_pcie_of_match[] = {
> +	{
> +		.compatible = "intel,keembay-pcie",
> +		.data = &keembay_pcie_rc_of_data,
> +	},
> +	{
> +		.compatible = "intel,keembay-pcie-ep",
> +		.data = &keembay_pcie_ep_of_data,
> +	},
> +	{}
> +};
> +
> +static struct platform_driver keembay_pcie_driver = {
> +	.driver = {
> +		.name = "keembay-pcie",
> +		.of_match_table = keembay_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +	.probe  = keembay_pcie_probe,
> +};
> +builtin_platform_driver(keembay_pcie_driver);
> -- 
> 2.17.1
> 
