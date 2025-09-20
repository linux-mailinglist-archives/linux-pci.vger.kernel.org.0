Return-Path: <linux-pci+bounces-36553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122DB8BFD8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 07:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF727BAB24
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 05:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7092222C0;
	Sat, 20 Sep 2025 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaWLM/Mf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D78886323;
	Sat, 20 Sep 2025 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758346394; cv=none; b=FgLIP2X+yJys6ZAAw9AKlhR9upbWSf/tjU4vAoj1OKKPVw+TSMEY/rh3eeKWrdoMA7/LgL9Et15gVWf50MUxO2ShPmbRtZk5UsUoox3wKQYC2lyip+M6GOJvAYA3YQAI/IWcvTSXtCh8o/A/YFOJYIoDAr2QC1UaFL1BQi6q4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758346394; c=relaxed/simple;
	bh=fnzQXtC139YowhOJTTinUSSVAH8Hr6oG5OCTUMAZhpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbtefWY7qIasq1Tlkw2+f5iWcURQH0NW8d8fr+TGgNq/7anj1G9d9dJQWvEVSr8FH+NctFtsS1w0a/TTJtc9jrSxF04rbfTLm+B2oTRwWUclDzUWjJLUyDgQzt0BJAaqVW3Fr3IyCRNaBfI/Hm8sMeC/WscWC+ARfRdpaVAfDCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaWLM/Mf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6994FC4CEEB;
	Sat, 20 Sep 2025 05:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758346392;
	bh=fnzQXtC139YowhOJTTinUSSVAH8Hr6oG5OCTUMAZhpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaWLM/MfjK4ysxRlU6oAbE9YvGcUztMaBIyy5tEfd7GNKyhxclRL/BFfpVJbVsWPA
	 1ypWUj9A6PYp0+Rj+cqHiwSie5iDT/iyWFtx7+2kG558hkV7eq1bQunYEcplgBMAU+
	 U7meeuwMTc4RDhKUoE1mJU+p2cIfSMmQ7Xk6al7nXaOfjFcfQFQZroNagBkCBC9xgJ
	 SkCuGaRu0PQdl4Am34BzCGjjdcMGwXI8UJQgQ20Qqdc2LToBYACulESiQW4f3jhrOC
	 Kv//lZ9bVQUmtKDoLQEeTmMBV011Mwv1S6DpwJ9zqgQvJ7b12jGAEv6G7toWWIeSP0
	 z6zw9YOEYardA==
Date: Sat, 20 Sep 2025 11:03:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	kishon@kernel.org, dlan@gentoo.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, p.zabel@pengutronix.de, tglx@linutronix.de, 
	johan+linaro@kernel.org, thippeswamy.havalige@amd.com, namcao@linutronix.de, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, inochiama@gmail.com, 
	quic_schintav@quicinc.com, fan.ni@samsung.com, devicetree@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] PCI: spacemit: introduce SpacemiT PCIe host driver
Message-ID: <tekzfatnk55sjq7plm5wnmi36qa25k3hzctr2afjzuzytqhsxt@ngsfeeakpwrv>
References: <20250813184701.2444372-1-elder@riscstar.com>
 <20250813184701.2444372-6-elder@riscstar.com>
 <sptrmspkmqrwsh2iv4rmha45vsoz5ks7vhcdp3dytsxyabn6qn@mmk7z6tf5wcv>
 <21ad322f-5abe-4a97-9373-d027b846ee8c@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <21ad322f-5abe-4a97-9373-d027b846ee8c@riscstar.com>

On Fri, Sep 19, 2025 at 05:10:33PM -0500, Alex Elder wrote:
> On 9/15/25 3:09 AM, Manivannan Sadhasivam wrote:
> > On Wed, Aug 13, 2025 at 01:46:59PM GMT, Alex Elder wrote:
> > > Introduce a driver for the PCIe root complex found in the SpacemiT
> > > K1 SoC.  The hardware is derived from the Synopsys DesignWare PCIe IP.
> > > The driver supports three PCIe ports that operate at PCIe v2 transfer
> > > rates (5 GT/sec).  The first port uses a combo PHY, which may be
> > > configured for use for USB 3 instead.
> > > 
> > > Signed-off-by: Alex Elder <elder@riscstar.com>
> > > ---
> > >   drivers/pci/controller/dwc/Kconfig   |  10 +
> > >   drivers/pci/controller/dwc/Makefile  |   1 +
> > >   drivers/pci/controller/dwc/pcie-k1.c | 355 +++++++++++++++++++++++++++
> > >   3 files changed, 366 insertions(+)
> > >   create mode 100644 drivers/pci/controller/dwc/pcie-k1.c
> > > 
> > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > index ff6b6d9e18ecf..ca5782c041ce8 100644
> > > --- a/drivers/pci/controller/dwc/Kconfig
> > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > @@ -492,4 +492,14 @@ config PCIE_VISCONTI_HOST
> > >   	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
> > >   	  This driver supports TMPV7708 SoC.
> > > +config PCIE_K1
> > > +	bool "SpacemiT K1 host mode PCIe controller"
> > 
> > No need to make it bool, build it as a module. Only the PCI controller drivers
> > implementing irqchip need to be kept bool for irq disposal concerns.
> 
> OK.
> 
> > > +	depends on ARCH_SPACEMIT || COMPILE_TEST
> > > +	depends on PCI && OF && HAS_IOMEM
> > > +	select PCIE_DW_HOST
> > > +	default ARCH_SPACEMIT
> > > +	help
> > > +	  Enables support for the PCIe controller in the K1 SoC operating
> > > +	  in host mode.
> > 
> > Is the driver only applicable for K1 SoCs or other SoCs from spacemit? Even if
> > it is the former, I would suggest renaming to 'pcie-spacemit-k1.c'
> 
> Yes, I will do that.
> 
> > >   endmenu
> > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > index 6919d27798d13..62d9d4e7dd4d3 100644
> > > --- a/drivers/pci/controller/dwc/Makefile
> > > +++ b/drivers/pci/controller/dwc/Makefile
> > > @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
> > >   obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> > >   obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
> > >   obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> > > +obj-$(CONFIG_PCIE_K1) += pcie-k1.o
> > >   # The following drivers are for devices that use the generic ACPI
> > >   # pci_root.c driver but don't support standard ECAM config access.
> > > diff --git a/drivers/pci/controller/dwc/pcie-k1.c b/drivers/pci/controller/dwc/pcie-k1.c
> > > new file mode 100644
> > > index 0000000000000..e9b1df3428d16
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/dwc/pcie-k1.c
> > > @@ -0,0 +1,355 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * SpacemiT K1 PCIe host driver
> > > + *
> > > + * Copyright (C) 2025 by RISCstar Solutions Corporation.  All rights reserved.
> > > + * Copyright (c) 2023, spacemit Corporation.
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/bits.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > > +#include <linux/err.h>
> > > +#include <linux/gfp.h>
> > > +#include <linux/irq.h>
> > 
> > unused?
> 
> Yes, and there are a few others I can get rid of too.
> 
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/of.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/regmap.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/types.h>
> > > +
> > > +#include "pcie-designware.h"
> > > +
> > > +#define K1_PCIE_VENDOR_ID	0x201f
> > > +#define K1_PCIE_DEVICE_ID	0x0001
> > > +
> > > +/* Offsets and field definitions of link management registers */
> > > +
> > > +#define K1_PHY_AHB_IRQ_EN			0x0000
> > > +#define PCIE_INTERRUPT_EN		BIT(0)
> > > +
> > > +#define K1_PHY_AHB_LINK_STS			0x0004
> > > +#define SMLH_LINK_UP			BIT(1)
> > > +#define RDLH_LINK_UP			BIT(12)
> > > +
> > > +#define INTR_ENABLE				0x0014
> > > +#define MSI_CTRL_INT			BIT(11)
> > > +
> > > +/* Offsets and field definitions for PMU registers */
> > > +
> > > +#define PCIE_CLK_RESET_CONTROL			0x0000
> > > +#define LTSSM_EN			BIT(6)
> > > +#define PCIE_AUX_PWR_DET		BIT(9)
> > > +#define PCIE_RC_PERST			BIT(12)	/* 0: PERST# high; 1: low */
> > > +#define APP_HOLD_PHY_RST		BIT(30)
> > > +#define DEVICE_TYPE_RC			BIT(31)	/* 0: endpoint; 1: RC */
> > > +
> > > +#define PCIE_CONTROL_LOGIC			0x0004
> > > +#define PCIE_SOFT_RESET			BIT(0)
> > > +
> > > +struct k1_pcie {
> > > +	struct dw_pcie pci;
> > > +	void __iomem *link;
> > > +	struct regmap *pmu;
> > > +	u32 pmu_off;
> > > +	struct phy *phy;
> > > +	struct reset_control *global_reset;
> > > +};
> > > +
> > > +#define to_k1_pcie(dw_pcie)	dev_get_drvdata((dw_pcie)->dev)
> > > +
> > > +static int k1_pcie_toggle_soft_reset(struct k1_pcie *k1)
> > > +{
> > > +	u32 offset = k1->pmu_off + PCIE_CONTROL_LOGIC;
> > > +	const u32 mask = PCIE_SOFT_RESET;
> > > +	int ret;
> > > +
> > > +	ret = regmap_set_bits(k1->pmu, offset, mask);
> > 
> > For MMIO, it is OK to skip the error handling.
> 
> You mean even though the regmap API returns an error,
> it never will with MMIO?
> - regmap_mmio_read() and regmap_mmio_write() always
>   return 0 unless there's an error enabling its clock.
> 
> Sounds good, I'll simplify places that use this.
> 
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	mdelay(2);
> > 
> > If the previous write to the PMU got stuck in the CPU cache, there is no
> > guarantee that this delay of 2ms between write and clear will be enforced. So
> > you should do a dummy read after write to ensure that the previous write has
> > reached the PMU (or any device) and then clear the bits.
> 
> Wow, really?  I was aware of this being possible for I/O
> writes but it seems like something regmap might handle.
> 

API cannot handle this scenario since the callers do not necessarily need to
ensure that the write has reached the device all the time. It is only needed for
special cases where we need to wait for some hardware recommended time, before
triggering another write/read.

> I'll add a regmap_read() for the same offset and discard
> the result *before* the delay.  I'll do the same for this:
> 
>         mdelay(PCIE_T_PVPERL_MS);
> 
> > > +	return regmap_clear_bits(k1->pmu, offset, mask);
> > > +}
> > > +
> > > +/* Enable app clocks, deassert app resets */
> > > +static int k1_pcie_app_enable(struct k1_pcie *k1)
> > > +{
> > > +	struct dw_pcie *pci = &k1->pci;
> > > +	u32 clock_count;
> > > +	u32 reset_count;
> > > +	int ret;
> > > +
> > > +	clock_count = ARRAY_SIZE(pci->app_clks);
> > 
> > Just use ARRAY_SIZE() directly below.
> 
> OK.
> 
> > > +	ret = clk_bulk_prepare_enable(clock_count, pci->app_clks);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	reset_count = ARRAY_SIZE(pci->app_rsts);
> > 
> > Same here.
> 
> OK.
> 
> > > +	ret = reset_control_bulk_deassert(reset_count, pci->app_rsts);
> > > +	if (ret)
> > > +		goto err_disable_clks;
> > > +
> > > +	ret = reset_control_deassert(k1->global_reset);
> > > +	if (ret)
> > > +		goto err_assert_resets;
> > > +
> > > +	return 0;
> > > +
> > > +err_assert_resets:
> > > +	(void)reset_control_bulk_assert(reset_count, pci->app_rsts);
> > 
> > Why void cast? Here and in other places.
> 
> I put void casts when I'm ignoring a returned value.
> It's not necessary, but it reminds me that the function
> returns a value, and at some point I decided to ignore it.
> I can drop those if you find them offensive.
> 

Maybe it is my personal preference. To me, it is OK to ignore a return value for
APIs that do not have the __must_check attribute. So if the attribute is not
present and if there is a void cast to indicate that the return values are
ignored, I don't think anyone would make use of it in the future. So it just
adds noise IMO.

> If you're suggesting I should issue a warning here if
> an error is returned here, tell me that.
> 

Nah, it should be OK to ignore the return value of assert in the error path.

> > > +err_disable_clks:
> > > +	clk_bulk_disable_unprepare(clock_count, pci->app_clks);
> > > +
> > > +	return ret;
> > > +}
> > > +

[...]

> > > +static struct platform_driver k1_pcie_driver = {
> > > +	.probe	= k1_pcie_probe,
> > > +	.remove	= k1_pcie_remove,
> > > +	.driver = {
> > > +		.name			= "k1-dwc-pcie",
> > > +		.of_match_table		= k1_pcie_of_match_table,
> > > +		.suppress_bind_attrs	= true,
> > 
> > No need of this flag for the reason I mentioned in the Kcofig change.
> 
> Because this doesn't implement an irqchip?
> 

Yeah. When the PCI controller driver is not implementing an irqchip, it can
freely be unbinded/removed from the system. But you can find this suppress
attribute to be set in various drivers, because all of them would be
implementing INTx/MSI/MSI-X controller in the driver. So in that case, the
irqchip subsystem doesn't guarantee that removing the irqchip controller will
dispose all the IRQs requested by the clients (in this case, the PCI device
drivers).

I think it would be better if I write a guide under Documentation/PCI on
writing the PCI controller drivers and document all of these internal details.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

