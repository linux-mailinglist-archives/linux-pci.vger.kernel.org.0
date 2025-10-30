Return-Path: <linux-pci+bounces-39873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E734C22B28
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AF43A40D0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA63D3328F7;
	Thu, 30 Oct 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCIsl/eS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A933711D;
	Thu, 30 Oct 2025 23:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761866517; cv=none; b=bOu7ErcjbJ47OmokUWhyBBb7XWE/SxOyYZQ3P59E3h1abUPShJKfbuacuZb/jGFqeKWNqtBe7lUI4MftX/daOLLXYkIb2vlhdtGrCZMu+nls3z2HvvNIIZ4Y3IluwftNPCxwKHyJHJ1PWd3vOWAP6p1yESfO7uh6MllVgK+AMoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761866517; c=relaxed/simple;
	bh=/rp/ubawNd5SVser7ZjxZ6b5BNO+EY12E0k+TbAyPLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dg52PICT3J48AjEsCFRfMfvCHzChO4qtlHbHlF105MyWCLZis/wUdLMiDKOav5DxrwCuNseUuUbMyHoCqskSyKWnoxnZ0c0beJAjmGe22eVeChtLxa8eoEstxSoNzFfQwcD9MasbqRQRQYE09YT1K9AyhEbj0jOr2uegdYnclts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCIsl/eS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09D8C4CEF1;
	Thu, 30 Oct 2025 23:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761866517;
	bh=/rp/ubawNd5SVser7ZjxZ6b5BNO+EY12E0k+TbAyPLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KCIsl/eSxxSyFEaE2YxpIn3cJf5Hm5Kl0Zdm9XqB9RjEo1l2w3/qSrZZ3ZeMUOPiq
	 2/ay8rzb/365zDTQg5fGF1CbeHn54vk/NebhkcE86H5nblkOZdoEjNqHXZNZi48RaL
	 NaKnwoBpAba6uxmYaTr+E66WYmkSQPwr6zVjPl9q1HFV57QN9zultMQ5PbeCg7qUZz
	 5+6JmZNaoIzGFcT79P0J+cSguJn0wOynq4UnF8uNPHc5/IL2MjoHE1TuLrm2d7V/xG
	 hPK2MSXPIZb1EAND2TsiXdL635VlQDO84oTuAso4gVpgCyykLCm8BW/GqD0z54d8K1
	 AME9spocr58SQ==
Date: Thu, 30 Oct 2025 18:21:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, mani@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, p.zabel@pengutronix.de, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christian.bruel@foss.st.com, mayank.rana@oss.qualcomm.com,
	shradha.t@samsung.com, krishna.chundru@oss.qualcomm.com,
	thippeswamy.havalige@amd.com, inochiama@gmail.com,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, ouyanghui@eswincomputing.com
Subject: Re: [PATCH v4 2/2] PCI: EIC7700: Add Eswin PCIe host controller
 driver
Message-ID: <20251030232155.GA1632897@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030083143.1341-1-zhangsenchuan@eswincomputing.com>

Nit: if you run "git log --oneline drivers/pci/controller/", you'll
notice that the driver tags ("EIC7700" here) are all lower-case.
Same for the DT bindings.

On Thu, Oct 30, 2025 at 04:31:42PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTX and MSI
> interrupts.

s/INTX/INTx/ to match spec usage.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -93,6 +93,17 @@ config PCIE_BT1
>  	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>  	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>  
> +config PCIE_EIC7700
> +	bool "Eswin PCIe controller"

I think this should mention EIC7700.

> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support for the Eswin.
> +	  The PCIe controller on Eswin is based on DesignWare hardware,
> +	  enables support for the PCIe controller in the Eswin SoC to
> +	  work in host mode.

Mention EIC7700 here also.

> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> @@ -0,0 +1,462 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN PCIe root complex driver

Probably here also.

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
> +/* PCIe top csr registers */
> +#define PCIEMGMT_CTRL0_OFFSET		0x0
> +#define PCIEMGMT_STATUS0_OFFSET		0x100
> +
> +/* LTSSM register fields */
> +#define PCIEMGMT_APP_LTSSM_ENABLE	BIT(5)
> +
> +/* APP_HOLD_PHY_RST register fields */
> +#define PCIEMGMT_APP_HOLD_PHY_RST	BIT(6)
> +
> +/* PM_SEL_AUX_CLK register fields */
> +#define PCIEMGMT_PM_SEL_AUX_CLK		BIT(16)
> +
> +/* ROOT_PORT register fields */
> +#define PCIEMGMT_CTRL0_ROOT_PORT_MASK	GENMASK(3, 0)

Looks like this is actually a "device type" field, not a "root port"
field, since you OR in the PCI_EXP_TYPE_ROOT_PORT device type below.

Maybe you could name it simply "PCIEMGMT_CTRL0_DEV_TYPE" or similar?

> +/* Vendor and device id value */

s/id/ID/

> +#define PCI_VENDOR_ID_ESWIN		0x1fe1
> +#define PCI_DEVICE_ID_ESWIN		0x2030
> +
> +struct eswin_pcie_data {

Generally speaking the prefix for structs and functions matches the
driver filename, i.e., "eic7700" in this case.

  $ git grep "^struct .*_pcie {" drivers/pci/controller/dwc
  drivers/pci/controller/dwc/pci-dra7xx.c:struct dra7xx_pcie {
  drivers/pci/controller/dwc/pci-exynos.c:struct exynos_pcie {
  drivers/pci/controller/dwc/pci-imx6.c:struct imx_pcie {
  drivers/pci/controller/dwc/pci-keystone.c:struct keystone_pcie {
  ...

> +static int eswin_pcie_perst_deassert(struct eswin_pcie_port *port,
> +				     struct eswin_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to assert PERST#");
> +		return ret;
> +	}
> +
> +	/* Ensure that PERST has been asserted for at least 100 ms */

s/PERST/PERST#/

> +	msleep(PCIE_T_PVPERL_MS);
> +
> +	ret = reset_control_deassert(port->perst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "Failed to deassert PERST#");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_parse_port(struct eswin_pcie *pcie,
> +				 struct device_node *node)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct eswin_pcie_port *port;
> +
> +	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return -ENOMEM;
> +
> +	port->perst = of_reset_control_get(node, "perst");
> +	if (IS_ERR(port->perst)) {
> +		dev_err(dev, "Failed to get perst reset\n");

s/perst/PERST#/ to match spec usage and messages above.

> +static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = to_eswin_pcie(pci);
> +	struct eswin_pcie_port *port;
> +	u8 msi_cap;
> +	u32 val;
> +	int ret;
> +
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "Failed to get pcie clocks\n");
> +
> +	ret = eswin_pcie_deassert(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* Configure root port type */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~PCIEMGMT_CTRL0_ROOT_PORT_MASK;
> +	writel_relaxed(val | PCI_EXP_TYPE_ROOT_PORT,
> +		       pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);

Use FIELD_PREP() here to remove the assumption that
PCIEMGMT_CTRL0_ROOT_PORT_MASK is in the low-order bits.

> +static void eswin_pcie_host_exit(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = to_eswin_pcie(pci);
> +	struct eswin_pcie_port *port;
> +
> +	/*
> +	 * For controllers with active devices, resources are retained and
> +	 * cannot be turned off, like NVMEe.

s/NVMEe/NVMe/

I'm a little skeptical about having behavior here that depends on
specific kinds of downstream devices.

Maybe there's some general requirement that these resources need to be
retained if the link is up, and there's no need to mention NVMe
specifically?  I don't see similar code in other drivers, though.

> +	 */
> +	if (!dw_pcie_link_up(&pcie->pci)) {
> +		list_for_each_entry(port, &pcie->ports, list)
> +			reset_control_assert(port->perst);
> +		eswin_pcie_assert(pcie);
> +		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +	}
> +}
> +
> +static void eswin_pcie_pme_turn_off(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	/*
> +	 * Hardware doesn't support enter the D3code and L2/L3 states, send
> +	 * PME_TURN_OFF message, which will then cause Vmain to be removed and
> +	 * controller stop working.
> +	 */
> +	dev_info(pci->dev, "Can't send PME_TURN_OFF message\n");

s/PME_TURN_OFF/PME_Turn_Off/ to match spec usage.

> +}
> +
> +static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
> +	.init = eswin_pcie_host_init,
> +	.deinit = eswin_pcie_host_exit,

Please include "deinit" in this function name so it's connected to the
.deinit structure member.

> +static int eswin_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct eswin_pcie_data *data;
> +	struct eswin_pcie_port *port, *tmp;
> +	struct device *dev = &pdev->dev;
> +	struct eswin_pcie *pcie;
> +	struct dw_pcie *pci;
> +	int ret;
> +
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return dev_err_probe(dev, -EINVAL, "OF data missing\n");
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
> +	pci->pp.ops = &eswin_pcie_host_ops;
> +	pcie->msix_cap = data->msix_cap;

I'm not sure there's really any value in copying msix_cap, since
data->msix_cap is a read-only item anyway.

For example, pcie-qcom.c has a per-SoC struct qcom_pcie_cfg, and it
just saves the qcom_pcie_cfg pointer in struct qcom_pcie:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?id=v6.17#n286

> +static int eswin_pcie_resume_noirq(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = dw_pcie_resume_noirq(&pcie->pci);

Add blank line here.

> +	/*
> +	 * If the downstream device is not inserted, linkup will TIMEDOUT. At
> +	 * this time, when the resume function return, -ETIMEDOUT shouldn't be
> +	 * returned, which will raise "PM: failed to resume noirq: error -110".
> +	 * Only log message "Ignore errors, the link may come up later".
> +	 */
> +	if (ret == -ETIMEDOUT && !pcie->linked_up) {
> +		dev_info(dev, "Ignore errors, the link may come up later\n");
> +		return 0;
> +	}
> +
> +	return ret;
> +}

> +MODULE_DESCRIPTION("PCIe host controller driver for EIC7700 SoCs");

Include vendor ("Eswin") in the description.  You can use this to see
the typical style:

  $ git grep MODULE_DESCRIPTION drivers/pci/controller/

