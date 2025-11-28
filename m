Return-Path: <linux-pci+bounces-42267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DE7C9267C
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 16:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39CF534AF7B
	for <lists+linux-pci@lfdr.de>; Fri, 28 Nov 2025 15:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34132E745;
	Fri, 28 Nov 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7kgq84Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1FB27F16C;
	Fri, 28 Nov 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764342446; cv=none; b=ZiGZIrl1rOIFqAlqECMMOrxNFy0D67xT1yTfUW1eH1IhQscQGZjOftkvv/YQLAFJx1Bu129Etb8zr5nXQOQsMIq7Oyj3zdZofRDejE6t266ygS/HvBrxcH4rqh4KeWC85VG82TTJkjsjJKMVFhz3q/bTONqlgbVTcwdGOFjj9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764342446; c=relaxed/simple;
	bh=GrbE07r2E073o3pD0gBlXX3rA7I9NgkjmY0FvJaiPbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeYl+8bgyQs0UuDCTyycThaoMCbBf9+awhDuJtIeRgKeyNtEFH0cGbcuRDqJlAkLLzjhdfokeVY+mbClopJde1rmX3zs8NchNGXPWLCbbW7OFc6ZmUHxrz+mc7A3GzARX17foN5JdvDwHqXc0lIihQUiAC5jVWYXTLBpx1u3ZcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7kgq84Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965EBC4CEF1;
	Fri, 28 Nov 2025 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764342446;
	bh=GrbE07r2E073o3pD0gBlXX3rA7I9NgkjmY0FvJaiPbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7kgq84YXr6/d3ixxfg1FImVbo8sZV4VvRRhuNvKPKdzSyqvjcy+e1YQiRsBZazAP
	 HXcyoAVp3N8Dw6KziDzCxYnPyn/BPkdcq7ZtgeGqz8cTdgf2N6jSZSeKw0p2crRsF0
	 zpRAarLchO9c/NlejFh5i2hY9eNgBx24igpAMnoVuW9x0adROSxrPHCmPvuUXu4Br2
	 yYZ6QqGzIDe3B3UA8p03viWYzs7MWaPlOaTEXkHBx6U9arF7vW7rbZXnjnMIwg2ZIy
	 FW8x4bM1plC38avzbRnKp30ykcFp8ox03wm+Tllv+sY2puzhRTCkoD4iLgv5D+TlGL
	 a1t+qlM6VeWng==
Date: Fri, 28 Nov 2025 20:37:07 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, 
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, 
	mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, 
	thippeswamy.havalige@amd.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, 
	Frank.li@nxp.com
Subject: Re: [PATCH v6 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
Message-ID: <xkfoddg6n3fr26maq4a647y36tbigjpivsz2n3tqfmxi3wmwo3@fhajg6zgl2wv>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101206.1518-1-zhangsenchuan@eswincomputing.com>
 <uijg47suvluvamftyxwc65kl34eo2eu2af2o5aia4nu45hanqc@grcr2bjgph2i>
 <63945b54.9c7.19ac016ce19.Coremail.zhangsenchuan@eswincomputing.com>
 <vuguabbekf7fhippxgyedi25qctnhsuzdxscgc7andlpt2euyz@obhdxmcyssp3>
 <3fb8b957.b81.19ac991e9f5.Coremail.zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fb8b957.b81.19ac991e9f5.Coremail.zhangsenchuan@eswincomputing.com>

On Fri, Nov 28, 2025 at 04:26:14PM +0800, zhangsenchuan wrote:
> 
> 
> 
> > -----Original Messages-----
> > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > Send time:Wednesday, 26/11/2025 21:14:54
> > To: zhangsenchuan <zhangsenchuan@eswincomputing.com>
> > Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, Frank.li@nxp.com
> > Subject: Re: [PATCH v6 2/3] PCI: eic7700: Add Eswin PCIe host controller driver
> > 
> > On Wed, Nov 26, 2025 at 08:15:11PM +0800, zhangsenchuan wrote:
> > > 
> > > 
> > > 
> > > > -----Original Messages-----
> > > > From: "Manivannan Sadhasivam" <mani@kernel.org>
> > > > Send time:Thursday, 20/11/2025 20:43:47
> > > > To: zhangsenchuan@eswincomputing.com
> > > > Cc: bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com, gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com, shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com, inochiama@gmail.com, ningyu@eswincomputing.com, linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com, Frank.li@nxp.com
> > > > Subject: Re: [PATCH v6 2/3] PCI: eic7700: Add Eswin PCIe host controller driver
> > > > 
> > > > On Thu, Nov 20, 2025 at 06:12:06PM +0800, zhangsenchuan@eswincomputing.com wrote:
> > > > > From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > 
> > > > > Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> > > > > the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> > > > > supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> > > > > interrupts.
> > > > > 
> > > > > Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> > > > > Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> > > > > Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > ---
> > > > >  drivers/pci/controller/dwc/Kconfig        |  11 +
> > > > >  drivers/pci/controller/dwc/Makefile       |   1 +
> > > > >  drivers/pci/controller/dwc/pcie-eic7700.c | 387 ++++++++++++++++++++++
> > > > >  3 files changed, 399 insertions(+)
> > > > >  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > > index 349d4657393c..66568efb324f 100644
> > > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > > @@ -93,6 +93,17 @@ config PCIE_BT1
> > > > >  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
> > > > >  	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
> > > > >  
> > > > > +config PCIE_EIC7700
> > > > > +	bool "Eswin EIC7700 PCIe controller"
> > > > 
> > > > You can make it tristate as you've used builtin_platform_driver() which
> > > > guarantees that this driver won't be removed once loaded.
> > > 
> > > Okey, thanks
> > > 
> > > > 
> > > > > +	depends on ARCH_ESWIN || COMPILE_TEST
> > > > > +	depends on PCI_MSI
> > > > > +	select PCIE_DW_HOST
> > > > > +	help
> > > > > +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
> > > > > +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
> > > > > +	  enables support for the PCIe controller in the EIC7700 SoC to work in
> > > > > +	  host mode.
> > > > > +
> > > > >  config PCI_IMX6
> > > > >  	bool
> > > > >  
> > > > > diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> > > > > index 7ae28f3b0fb3..04f751c49eba 100644
> > > > > --- a/drivers/pci/controller/dwc/Makefile
> > > > > +++ b/drivers/pci/controller/dwc/Makefile
> > > > > @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> > > > >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
> > > > >  obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
> > > > >  obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> > > > > +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
> > > > >  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
> > > > >  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> > > > >  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
> > > > > new file mode 100644
> > > > > index 000000000000..239fdbc501fe
> > > > > --- /dev/null
> > > > > +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> > > > > @@ -0,0 +1,387 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * ESWIN EIC7700 PCIe root complex driver
> > > > > + *
> > > > > + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
> > > > > + *
> > > > > + * Authors: Yu Ning <ningyu@eswincomputing.com>
> > > > > + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> > > > > + *          Yanghui Ou <ouyanghui@eswincomputing.com>
> > > > > + */
> > > > > +
> > > > > +#include <linux/interrupt.h>
> > > > > +#include <linux/iopoll.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/pci.h>
> > > > > +#include <linux/platform_device.h>
> > > > > +#include <linux/resource.h>
> > > > > +#include <linux/reset.h>
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +#include "pcie-designware.h"
> > > > > +
> > > > > +/* ELBI registers */
> > > > > +#define PCIEELBI_CTRL0_OFFSET		0x0
> > > > > +#define PCIEELBI_STATUS0_OFFSET		0x100
> > > > > +
> > > > > +/* LTSSM register fields */
> > > > > +#define PCIEELBI_APP_LTSSM_ENABLE	BIT(5)
> > > > > +
> > > > > +/* APP_HOLD_PHY_RST register fields */
> > > > > +#define PCIEELBI_APP_HOLD_PHY_RST	BIT(6)
> > > > > +
> > > > > +/* PM_SEL_AUX_CLK register fields */
> > > > > +#define PCIEELBI_PM_SEL_AUX_CLK		BIT(16)
> > > > > +
> > > > > +/* DEV_TYPE register fields */
> > > > > +#define PCIEELBI_CTRL0_DEV_TYPE		GENMASK(3, 0)
> > > > > +
> > > > > +/* Vendor and device ID value */
> > > > > +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> > > > > +#define PCI_DEVICE_ID_ESWIN		0x2030
> > > > > +
> > > > > +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)
> > > > > +
> > > > > +static const char * const eic7700_pcie_rsts[] = {
> > > > > +	"pwr",
> > > > > +	"dbi",
> > > > > +};
> > > > > +
> > > > > +struct eic7700_pcie_data {
> > > > > +	bool msix_cap;
> > > > > +	bool no_suspport_L2;
> > > > 
> > > > support?
> > > 
> > > Okey, spelling mistake:)
> > > 
> > > mani, by the way, our controller cannot broadcast PME_Turn_Off. Previously,
> > > i skip broadcast PME_Turn_Off in our controller code. Frank suggested that 
> > > set the flag bit to skip in the public code. At present, do you think it's 
> > > okay for me to add no_support_L2?
> > > 
> > 
> > This sounds weird. As per the spec r6.0, sec 5.2, "L2/L3 Ready transition
> > protocol support is required." So this means the controller has to support
> > PME_Turn_Off broadcast. Are you saying that your controller is not spec
> > compliant? and the link can only enter L3 (power off) abruptly?
> 
> Hi, Mani
> 
> Clarification
> After confirmation with the hardware team, L2/L3 low-power link state is not 
> supported, and cannot be controlled to enter L2/L3 through trigger 
> PME_turn_off/PME_To-Ack handshake, because this function is not implemented in 
> hardware, nor is the Vmain/Vaux power domain implemented to implement L2/L3 
> low-power wake-up mechanism.
> 

Ok, thanks for checking.

> Our PCIe only implements L0s/L1/L1.1 low-power mode. if want to put PCIe into 
> a more energy-efficient state, only power down PCIe. Although the PCIe Spec 
> requires the implementation of L2/L3 ready state, it is regrettable that we
> have not been able to match the protocol requirements at this point. We will
> gradually improve more features required by the Spec in future products.
> 
> Regarding the handling of skipping PME_Turn_Off broadcast, should I add a 
> flag bit to skip it in Synopsys public code or register a callback function 
> to skip it in our platform driver? Which approach is better? I'd like to hear
> your suggestions. Thanks!
> 

I'd prefer a flag, like, 'struct dw_pcie::no_pme_handshake'.

> Kind regards,
> Senchuan Zhang
> 
> > 
> > > > > +static void eic7700_pcie_hide_broken_msix_cap(struct dw_pcie *pci)
> > > > > +{
> > > > > +	u16 offset, val;
> > > > > +
> > > > > +	/*
> > > > > +	 * Hardware doesn't support MSI-X but it advertises MSI-X capability,
> > > > > +	 * to avoid this problem, the MSI-X capability in the PCIe capabilities
> > > > > +	 * linked-list needs to be disabled. Since the PCI Express capability
> > > > > +	 * structure's next pointer points to the MSI-X capability, and the
> > > > > +	 * MSI-X capability's next pointer is null (00H), so only the PCI
> > > > > +	 * Express capability structure's next pointer needs to be set 00H.
> > > > > +	 */
> > > > > +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > > > +	val = dw_pcie_readl_dbi(pci, offset);
> > > > > +	val &= ~PCI_CAP_LIST_NEXT_MASK;
> > > > > +	dw_pcie_writel_dbi(pci, offset, val);
> > > > 
> > > > I hate to enforce dependency for your series, but this is properly handled here:
> > > > https://lore.kernel.org/linux-pci/20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com
> > > 
> > > Okey, then I can rely on this patch to solve the problem of the missing MSI-X. 
> > > Thank you for the reminder.
> > > 
> > > > 
> > > > > +}
> > > > > +
> > > > > +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > +{
> > > > > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> > > > > +	struct eic7700_pcie_port *port;
> > > > > +	u8 msi_cap;
> > > > > +	u32 val;
> > > > > +	int ret;
> > > > > +
> > > > > +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> > > > > +	if (pcie->num_clks < 0)
> > > > > +		return dev_err_probe(pci->dev, pcie->num_clks,
> > > > > +				     "Failed to get pcie clocks\n");
> > > > > +
> > > > > +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);
> > > > 
> > > > I think this is being called too early.
> > > 
> > > Before accessing the register. I need to deassert, otherwise, there will
> > > be problems with register access.
> > > 
> > > > 
> > > > > +	if (ret) {
> > > > > +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	/* Configure Root Port type */
> > > > > +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > > > +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
> > > > > +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
> > > > > +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > > > +
> > > > > +	list_for_each_entry(port, &pcie->ports, list) {
> > > > > +		ret = eic7700_pcie_perst_deassert(port, pcie);
> > > > > +		if (ret)
> > > > > +			goto err_perst;
> > > > > +	}
> > > > > +
> > > > > +	/* Configure app_hold_phy_rst */
> > > > > +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > > > +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
> > > > > +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> > > > > +
> > > > > +	/* The maximum waiting time for the clock switch lock is 20ms */
> > > > > +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET,
> > > > > +				 val, !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
> > > > > +				 20000);
> > > > > +	if (ret) {
> > > > > +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> > > > > +		goto err_phy_init;
> > > > > +	}
> > > > 
> > > > You seem to be configuring the PHY reset and Aux clock, which should come before
> > > > deasserting PERST# IMO. PERST# deassertion indicates that the power and clock
> > > > are stable and the endpoint can start its operation. I don't know the impact of
> > > > these configurations, but it is safe to do them earlier.
> > > 
> > > I think your understanding is correct. Unfortunately, in our hardware design, we 
> > > need to deassert perst first before we can operate the configuration of the phy.
> > > 
> > 
> > Sorry, I don't understand how it is possible, unless this reset is not PERST#.
> > PERST# is just an indication to the component and has no relation with the
> > controller.
> 
> After confirmation with the hardware team, Clarification as follows:
> 
> The power and reference clk of phy for our product PCIe are provided by the power
> module and reference clock crystal oscillator on the board, and the power and 
> reference clk of phy for the remote EP are also provided by the power and reference
> clock crystal oscillator on the board through slots, using PCIe common reference 
> clock mode. 
>    
> PERST# is sent to the local PCIe through the configuration register inside our 
> chip, and this PERST# is also sent to the remote EP through the slot. Therefore,
> in order to deassert PERST#, we first need our system to boot and configure it
> through software, hen app_hold_phy_rst can be configured through software, the 
> entire chip is already in a stable state, including the stability of power and 
> reference clock.
> 
> Both our PCIe controller and phy require PERST# as the primary reset source, 
> the configuration of app_hold_phy_rst is controlled by the controller to control
> the state of phy through the pipe_raneX_powerdown signal in the pipe interface. 
> Therefore, it is necessary to first deassert PERST# release controller and phy's 
> Perst_n before configuring app_hold_phy_rst to allow the controller to control 
> the pipe_raneX_powerdown signal.
> 

It looks crazy (using PERST# for both controller and the endpoint). Anyway, you
should include this information in the comment above
reset_control_bulk_deassert().

- Mani

-- 
மணிவண்ணன் சதாசிவம்

