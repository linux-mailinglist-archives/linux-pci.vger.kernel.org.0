Return-Path: <linux-pci+bounces-22054-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A43A403BA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA973BA26E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DDD252909;
	Fri, 21 Feb 2025 23:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebzXRD7f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529D8204694;
	Fri, 21 Feb 2025 23:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181800; cv=none; b=WNeNMBjHd/0XChyFhPQRsfn7hNECt56FiPRB7vGNxmeWsArfOkdI1G4B+oSAGs4UAsJSgwv2Tbf364wlIR1xAplaIciTJcs+tmd0DBOu7+Yq0ahMcHpJOZdLYtkjhcIJvl7UadZXK3DIvsk4xKZsnE/tAH56mjtGCnrKjuxQaoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181800; c=relaxed/simple;
	bh=7nyMY4mFAeqXaY4AyfMQMXfQBWFBvvYOoJjP9MhKH6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=F+BY5lnvXAPasNk62OnB8yfxPCZ0yjxE7YimP/B/W1N21vBOV/eReDZAzpzT0SqMJYkRuLlmpqjg/sEwKW2DWwuru6zTvWxSDwFfn0vPW+Y4DWiHIqQrqJo/8XSfcOcbHTNfkPtSx+wpVlkESk1o3NB6L0A99Cu6KkEW5R03724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebzXRD7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5E9C4CED6;
	Fri, 21 Feb 2025 23:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740181799;
	bh=7nyMY4mFAeqXaY4AyfMQMXfQBWFBvvYOoJjP9MhKH6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ebzXRD7fV/Ixvgj7XqgttlHaThg3WUGKW8yUnOnyCWMx2md84LfMFxeaxPr5BKc12
	 FGB2wrsPt3Uwg65UNNG/nb95tdPXbew7VdMIhM00g1Dn0pDeuAiSr1aUFI1d0z8gbq
	 iWILf7txi/VGSlSsYX1hNot9bKuVUnL/W/cEyw/fIKp9P3f95HELNiew7T3Y4vhMtV
	 r0D98tM4UbWejYZIvR2VB+SrrRySlhP1f/iFaKnMFmoyBeMSq5Du6WuwgHvQcT15Rm
	 HIkLrKamIw0mDTxFcbe4I1DWWPYkR9yY2S8zwwwQ8mM6DcSDpKkpc5NSCq2xYowVTT
	 nb2P3yw3NxN5Q==
Date: Fri, 21 Feb 2025 17:49:58 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Niklas Cassel <cassel@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <20250221234958.GA372914@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221013758.370936-3-inochiama@gmail.com>

On Fri, Feb 21, 2025 at 09:37:56AM +0800, Inochi Amaoto wrote:
> Add support for DesignWare-based PCIe controller in SG2044 SoC.

> @@ -341,6 +341,16 @@ config PCIE_ROCKCHIP_DW_EP
>  	  Enables support for the DesignWare PCIe controller in the
>  	  Rockchip SoC (except RK3399) to work in endpoint mode.
>  
> +config PCIE_SOPHGO_DW
> +	bool "SOPHGO DesignWare PCIe controller"

What's the canonical styling of "SOPHGO"?  I see "Sophgo" in the
subject line and in Chen Wang's SG2042 series.  Pick the official
styling and use it consistently.

Reorder this so the menuconfig menu items remain alphabetically
sorted.

> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on PCI_MSI
> +	depends on OF
> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the DesignWare PCIe controller in the
> +	  SOPHGO SoC.
> +
>  config PCI_EXYNOS
>  	tristate "Samsung Exynos PCIe controller"
>  	depends on ARCH_EXYNOS || COMPILE_TEST

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe host controller driver for Sophgo SoCs.

Looks too generic, since Chen Wang's series says Sophgo SG2042 SoC is
Cadence-based, so this driver apparently doesn't cover all Sophgo
SoCs.

> + *

Spurious blank line.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +
> +#include "pcie-designware.h"
> +
> +#define to_sophgo_pcie(x)		dev_get_drvdata((x)->dev)
> +
> +#define PCIE_INT_SIGNAL			0xc48
> +#define PCIE_INT_EN			0xca0
> +
> +#define PCIE_SIGNAL_INTX_SHIFT		5
> +#define PCIE_INT_EN_INTX_SHIFT		1

Define masks with GENMASK() and get rid of the _SHIFT #defines.

> +#define PCIE_INT_EN_INT_SII		BIT(0)
> +#define PCIE_INT_EN_INT_INTA		BIT(1)
> +#define PCIE_INT_EN_INT_INTB		BIT(2)
> +#define PCIE_INT_EN_INT_INTC		BIT(3)
> +#define PCIE_INT_EN_INT_INTD		BIT(4)

These are unused, drop them.

> +#define PCIE_INT_EN_INT_MSI		BIT(5)
> +
> +struct sophgo_pcie {
> +	struct dw_pcie pci;
> +	void __iomem *app_base;
> +	struct clk_bulk_data *clks;
> +	unsigned int clk_cnt;
> +	struct reset_control *rst;
> +	struct irq_domain *irq_domain;

Indent the member names to align vertically as most other drivers do.

> +};
> +
> +static int sophgo_pcie_readl_app(struct sophgo_pcie *sophgo, u32 reg)
> +{
> +	return readl_relaxed(sophgo->app_base + reg);
> +}
> +
> +static void sophgo_pcie_writel_app(struct sophgo_pcie *sophgo, u32 val, u32 reg)
> +{
> +	writel_relaxed(val, sophgo->app_base + reg);
> +}
> +
> +static void sophgo_pcie_intx_handler(struct irq_desc *desc)
> +{
> +	struct dw_pcie_rp *pp = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long hwirq = PCIE_SIGNAL_INTX_SHIFT;
> +	unsigned long reg;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	reg = sophgo_pcie_readl_app(sophgo, PCIE_INT_SIGNAL);
> +
> +	for_each_set_bit_from(hwirq, &reg, PCI_NUM_INTX + PCIE_SIGNAL_INTX_SHIFT)

Use FIELD_GET() here and iterate through PCI_NUM_INTX.  Then you don't
need for_each_set_bit_from() and shouldn't need PCIE_SIGNAL_INTX_SHIFT
here and below.

> +		generic_handle_domain_irq(sophgo->irq_domain,
> +					  hwirq - PCIE_SIGNAL_INTX_SHIFT);
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static void sophgo_intx_mask(struct irq_data *d)
> +{
> +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> +	val &= ~BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);

FIELD_PREP().

> +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +};
> +
> +static void sophgo_intx_unmask(struct irq_data *d)
> +{
> +	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct sophgo_pcie *sophgo = to_sophgo_pcie(pci);
> +	unsigned long flags;
> +	u32 val;
> +
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
> +	val = sophgo_pcie_readl_app(sophgo, PCIE_INT_EN);
> +	val |= BIT(d->hwirq + PCIE_INT_EN_INTX_SHIFT);

Ditto.

> +	sophgo_pcie_writel_app(sophgo, val, PCIE_INT_EN);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
> +};
> +
> +static void sophgo_intx_eoi(struct irq_data *d)
> +{
> +}
> +
> +static struct irq_chip sophgo_intx_irq_chip = {
> +	.name			= "INTx",
> +	.irq_mask		= sophgo_intx_mask,
> +	.irq_unmask		= sophgo_intx_unmask,
> +	.irq_eoi		= sophgo_intx_eoi,

Name these ending with the irq_chip field names, e.g.,
sophgo_intx_irq_mask(), to make them easier to find with grep.

Bjorn

