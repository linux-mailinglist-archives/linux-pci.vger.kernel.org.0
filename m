Return-Path: <linux-pci+bounces-41781-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C5C74060
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3573229D8A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420233376AC;
	Thu, 20 Nov 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miNb9k44"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAA23376AA;
	Thu, 20 Nov 2025 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763642653; cv=none; b=nbdbiIR0mZL591W3dI/Oln+jiL608u5blX+/NUTdwErBs3rmKMdmKQrX1Mxp0KabrBX00t6urjEAWSd87dB7Y+tfcXD8Z7aUCymlgpx1IRxRwQQNSMQLTgS7TD7nac7t35Ht3uPu4wLO97QItoE5r5L45C2eY/UMrBZwfvvSvzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763642653; c=relaxed/simple;
	bh=k3vCYK9C/DvlsV96Opr7kY6W21EMPkaeEmOovXdACek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUrH8bPimAQQoP6ItF+5R7V2iePEbh+kT4yMo3+68ljyS7NqtuXllcYGJxg8hvqs+pWg3beaArd9M0AbLQa5WpA91pB3RLuODdVQmg4LjvHxtiVIwSHWDe4IZ3aVEWgtrXzzKWFA0664GI4Kj/rjnuaCaC4LhzRq1waD+FSMiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miNb9k44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7916BC4CEF1;
	Thu, 20 Nov 2025 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763642651;
	bh=k3vCYK9C/DvlsV96Opr7kY6W21EMPkaeEmOovXdACek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=miNb9k44ML3UmbX8Gj4qJLvm9uJV0/ajiySur4JOvsnGWJO0ft04uA3xtW1IisIpH
	 mf955Msj+jS5tDwgHaIpIEg2puj53/zMLsNyCVId3l6gvrNMC5Vj/fE872V6slA0N+
	 84GJrHOctAaUQ8LndvzNt99lF2rOpSfkEx1dZbCdNgyCm6LZBWUSEvm7Hsvr//8lTS
	 3lq0H2hYHvZVHm/fPeq5lIsRbD+SoRo+9i12IbgNTb9umOhM2w3r2tgk9QWU6VCR7j
	 JVLG1cT8YqXXse2r2Eydq7ajqgMUvOF2WUFcfRIAGS7Mb914y/9HIxHnRTt6WTMpjA
	 FFMOXAnMm9dPA==
Date: Thu, 20 Nov 2025 18:13:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com
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
Message-ID: <uijg47suvluvamftyxwc65kl34eo2eu2af2o5aia4nu45hanqc@grcr2bjgph2i>
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101206.1518-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251120101206.1518-1-zhangsenchuan@eswincomputing.com>

On Thu, Nov 20, 2025 at 06:12:06PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.
> 
> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  11 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c | 387 ++++++++++++++++++++++
>  3 files changed, 399 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..66568efb324f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -93,6 +93,17 @@ config PCIE_BT1
>  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>  	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>  
> +config PCIE_EIC7700
> +	bool "Eswin EIC7700 PCIe controller"

You can make it tristate as you've used builtin_platform_driver() which
guarantees that this driver won't be removed once loaded.

> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
> +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
> +	  enables support for the PCIe controller in the EIC7700 SoC to work in
> +	  host mode.
> +
>  config PCI_IMX6
>  	bool
>  
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7ae28f3b0fb3..04f751c49eba 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>  obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
>  obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
>  obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>  obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
> diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
> new file mode 100644
> index 000000000000..239fdbc501fe
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> @@ -0,0 +1,387 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN EIC7700 PCIe root complex driver
> + *
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
> + *
> + * Authors: Yu Ning <ningyu@eswincomputing.com>
> + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> + *          Yanghui Ou <ouyanghui@eswincomputing.com>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/reset.h>
> +#include <linux/types.h>
> +
> +#include "pcie-designware.h"
> +
> +/* ELBI registers */
> +#define PCIEELBI_CTRL0_OFFSET		0x0
> +#define PCIEELBI_STATUS0_OFFSET		0x100
> +
> +/* LTSSM register fields */
> +#define PCIEELBI_APP_LTSSM_ENABLE	BIT(5)
> +
> +/* APP_HOLD_PHY_RST register fields */
> +#define PCIEELBI_APP_HOLD_PHY_RST	BIT(6)
> +
> +/* PM_SEL_AUX_CLK register fields */
> +#define PCIEELBI_PM_SEL_AUX_CLK		BIT(16)
> +
> +/* DEV_TYPE register fields */
> +#define PCIEELBI_CTRL0_DEV_TYPE		GENMASK(3, 0)
> +
> +/* Vendor and device ID value */
> +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> +#define PCI_DEVICE_ID_ESWIN		0x2030
> +
> +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)
> +
> +static const char * const eic7700_pcie_rsts[] = {
> +	"pwr",
> +	"dbi",
> +};
> +
> +struct eic7700_pcie_data {
> +	bool msix_cap;
> +	bool no_suspport_L2;

support?

> +};
> +
> +struct eic7700_pcie_port {
> +	struct list_head list;
> +	struct reset_control *perst;
> +	int num_lanes;
> +};
> +
> +struct eic7700_pcie {
> +	struct dw_pcie pci;
> +	struct clk_bulk_data *clks;
> +	struct reset_control_bulk_data resets[EIC7700_NUM_RSTS];
> +	struct list_head ports;
> +	const struct eic7700_pcie_data *data;
> +	int num_clks;
> +};
> +
> +#define to_eic7700_pcie(x) dev_get_drvdata((x)->dev)
> +
> +static int eic7700_pcie_start_link(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	/* Enable LTSSM */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val |= PCIEELBI_APP_LTSSM_ENABLE;
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	return 0;
> +}
> +
> +static bool eic7700_pcie_link_up(struct dw_pcie *pci)
> +{
> +	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	return val & PCI_EXP_LNKSTA_DLLLA;
> +}
> +
> +static int eic7700_pcie_perst_deassert(struct eic7700_pcie_port *port,
> +				       struct eic7700_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to assert PERST#\n");
> +		return ret;
> +	}

Why assert is part of the deassert helper?

> +
> +	/* Ensure that PERST# has been asserted for at least 100 ms */
> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	ret = reset_control_deassert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert PERST#\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eic7700_pcie_parse_port(struct eic7700_pcie *pcie,
> +				   struct device_node *node)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct eic7700_pcie_port *port;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->perst = of_reset_control_get_exclusive(node, "perst");
> +	if (IS_ERR(port->perst)) {
> +		dev_err(dev, "Failed to get PERST# reset\n");
> +		return PTR_ERR(port->perst);
> +	}
> +
> +	/*
> +	 * TODO: Since the Root Port node is separated out by pcie devicetree,
> +	 * the DWC core initialization code can't parse the num-lanes attribute
> +	 * in the Root Port. Before entering the DWC core initialization code,
> +	 * the platform driver code parses the Root Port node. The EIC7700 only
> +	 * supports one Root Port node, and the num-lanes attribute is suitable
> +	 * for the case of one Root Rort.
> +	 */
> +	if (!of_property_read_u32(node, "num-lanes", &port->num_lanes))
> +		pcie->pci.num_lanes = port->num_lanes;
> +
> +	INIT_LIST_HEAD(&port->list);
> +	list_add_tail(&port->list, &pcie->ports);
> +
> +	return 0;
> +}
> +
> +static int eic7700_pcie_parse_ports(struct eic7700_pcie *pcie)
> +{
> +	struct eic7700_pcie_port *port, *tmp;
> +	struct device *dev = pcie->pci.dev;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = eic7700_pcie_parse_port(pcie, of_port);
> +		if (ret)
> +			goto err_port;
> +	}
> +
> +	return 0;
> +
> +err_port:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list)
> +		list_del(&port->list);
> +
> +	return ret;
> +}
> +
> +static void eic7700_pcie_hide_broken_msix_cap(struct dw_pcie *pci)
> +{
> +	u16 offset, val;
> +
> +	/*
> +	 * Hardware doesn't support MSI-X but it advertises MSI-X capability,
> +	 * to avoid this problem, the MSI-X capability in the PCIe capabilities
> +	 * linked-list needs to be disabled. Since the PCI Express capability
> +	 * structure's next pointer points to the MSI-X capability, and the
> +	 * MSI-X capability's next pointer is null (00H), so only the PCI
> +	 * Express capability structure's next pointer needs to be set 00H.
> +	 */
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readl_dbi(pci, offset);
> +	val &= ~PCI_CAP_LIST_NEXT_MASK;
> +	dw_pcie_writel_dbi(pci, offset, val);

I hate to enforce dependency for your series, but this is properly handled here:
https://lore.kernel.org/linux-pci/20251109-remove_cap-v1-2-2208f46f4dc2@oss.qualcomm.com

> +}
> +
> +static int eic7700_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> +	struct eic7700_pcie_port *port;
> +	u8 msi_cap;
> +	u32 val;
> +	int ret;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "Failed to get pcie clocks\n");
> +
> +	ret = reset_control_bulk_deassert(EIC7700_NUM_RSTS, pcie->resets);

I think this is being called too early.

> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert resets\n");
> +		return ret;
> +	}
> +
> +	/* Configure Root Port type */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_CTRL0_DEV_TYPE;
> +	val |= FIELD_PREP(PCIEELBI_CTRL0_DEV_TYPE, PCI_EXP_TYPE_ROOT_PORT);
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	list_for_each_entry(port, &pcie->ports, list) {
> +		ret = eic7700_pcie_perst_deassert(port, pcie);
> +		if (ret)
> +			goto err_perst;
> +	}
> +
> +	/* Configure app_hold_phy_rst */
> +	val = readl_relaxed(pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +	val &= ~PCIEELBI_APP_HOLD_PHY_RST;
> +	writel_relaxed(val, pci->elbi_base + PCIEELBI_CTRL0_OFFSET);
> +
> +	/* The maximum waiting time for the clock switch lock is 20ms */
> +	ret = readl_poll_timeout(pci->elbi_base + PCIEELBI_STATUS0_OFFSET,
> +				 val, !(val & PCIEELBI_PM_SEL_AUX_CLK), 1000,
> +				 20000);
> +	if (ret) {
> +		dev_err(pci->dev, "Timeout waiting for PM_SEL_AUX_CLK ready\n");
> +		goto err_phy_init;
> +	}

You seem to be configuring the PHY reset and Aux clock, which should come before
deasserting PERST# IMO. PERST# deassertion indicates that the power and clock
are stable and the endpoint can start its operation. I don't know the impact of
these configurations, but it is safe to do them earlier.

> +
> +	/*
> +	 * Configure ESWIN VID:DID for Root Port as the default values are
> +	 * invalid.
> +	 */
> +	dw_pcie_writew_dbi(pci, PCI_VENDOR_ID, PCI_VENDOR_ID_ESWIN);
> +	dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, PCI_DEVICE_ID_ESWIN);
> +
> +	/* Configure support 32 MSI vectors */
> +	msi_cap = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
> +	val = dw_pcie_readw_dbi(pci, msi_cap + PCI_MSI_FLAGS);
> +	val &= ~PCI_MSI_FLAGS_QMASK;
> +	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, 5);
> +	dw_pcie_writew_dbi(pci, msi_cap + PCI_MSI_FLAGS, val);

So this configures the MSI for Root Port. But are you sure that the internal MSI
controller could receive MSI from the Root Port?

Take a look: https://lore.kernel.org/linux-pci/20251109-remove_cap-v1-3-2208f46f4dc2@oss.qualcomm.com

> +
> +	/* Configure disable MSI-X cap */
> +	if (!pcie->data->msix_cap)
> +		eic7700_pcie_hide_broken_msix_cap(pci);
> +
> +	return 0;
> +
> +err_phy_init:
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +err_perst:
> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> +
> +	return ret;
> +}
> +
> +static void eic7700_pcie_host_deinit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eic7700_pcie *pcie = to_eic7700_pcie(pci);
> +	struct eic7700_pcie_port *port;
> +
> +	list_for_each_entry(port, &pcie->ports, list)
> +		reset_control_assert(port->perst);
> +	reset_control_bulk_assert(EIC7700_NUM_RSTS, pcie->resets);
> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +}
> +
> +static const struct dw_pcie_host_ops eic7700_pcie_host_ops = {
> +	.init = eic7700_pcie_host_init,
> +	.deinit = eic7700_pcie_host_deinit,
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = eic7700_pcie_start_link,
> +	.link_up = eic7700_pcie_link_up,
> +};
> +
> +static int eic7700_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct eic7700_pcie_data *data;
> +	struct eic7700_pcie_port *port, *tmp;
> +	struct device *dev = &pdev->dev;
> +	struct eic7700_pcie *pcie;
> +	struct dw_pcie *pci;
> +	int ret, i;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -EINVAL, "OF data missing\n");

-ENODATA

> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&pcie->ports);
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +	pci->pp.ops = &eic7700_pcie_host_ops;
> +	pcie->data = data;
> +	pci->no_suspport_L2 = pcie->data->no_suspport_L2;
> +
> +	for (i = 0; i < EIC7700_NUM_RSTS; i++)
> +		pcie->resets[i].id = eic7700_pcie_rsts[i];
> +
> +	ret = devm_reset_control_bulk_get_exclusive(dev, EIC7700_NUM_RSTS,
> +						    pcie->resets);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get resets\n");
> +
> +	ret = eic7700_pcie_parse_ports(pcie);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to parse Root Port: %d\n", ret);
> +
> +	platform_set_drvdata(pdev, pcie);
> +

You need to set the runtime PM status for the controller:

	pm_runtime_no_callbacks(dev);
	devm_pm_runtime_enable(dev);
	ret = pm_runtime_get_sync(dev);
	if (ret < 0)
		goto err_pm_runtime_put;

> +	ret = dw_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto err_init;
> +	}
> +
> +	return 0;
> +
> +err_init:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		list_del(&port->list);
> +		reset_control_put(port->perst);
> +	}
> +
> +	return ret;
> +}
> +
> +static int eic7700_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> +
> +	return dw_pcie_suspend_noirq(&pcie->pci);
> +}
> +
> +static int eic7700_pcie_resume_noirq(struct device *dev)
> +{
> +	struct eic7700_pcie *pcie = dev_get_drvdata(dev);
> +
> +	return dw_pcie_resume_noirq(&pcie->pci);
> +}
> +
> +static const struct dev_pm_ops eic7700_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eic7700_pcie_suspend_noirq,
> +				  eic7700_pcie_resume_noirq)
> +};
> +
> +static const struct eic7700_pcie_data eic7700_data = {
> +	.msix_cap = false,
> +	.no_suspport_L2 = true,
> +};
> +
> +static const struct of_device_id eic7700_pcie_of_match[] = {
> +	{ .compatible = "eswin,eic7700-pcie", .data = &eic7700_data },
> +	{},
> +};
> +
> +static struct platform_driver eic7700_pcie_driver = {
> +	.probe = eic7700_pcie_probe,
> +	.driver = {
> +		.name = "eic7700-pcie",
> +		.of_match_table = eic7700_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &eic7700_pcie_pm_ops,

Use:
		.probe_type = PROBE_PREFER_ASYNCHRONOUS,

to speed up the controller probe.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

