Return-Path: <linux-pci+bounces-35457-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B22B4420E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8641C174D6A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 16:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591FA2D3731;
	Thu,  4 Sep 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSCMmZex"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD062C21D8;
	Thu,  4 Sep 2025 16:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001702; cv=none; b=fLvCRG2QVJVmAhsuvE6XBj9Z3qiTZG3i7h7q+N9N8tOOHFpb4/2+ogy9+2VrSKDZJ2ehvm4T7ISG2QtjfrUyYtx0TvMmTu6+cphUZOQmPM468K87q7oxcjipR68OcAQ+yEfP+cQtXWLeaCuszFGQI/bzAbDLb0EJ0vkQFnVxizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001702; c=relaxed/simple;
	bh=j/h9kq4nhFbaFX5wXh7GT4njNgD0lqzfJ3Jo/r2pfxM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lPg4eOjWS739Qla3hWuOvNJGSxNkRSeu7MApKzDXfaagkrSZYfKHrQVMUFLY7KjuJohVMJGWxaHFrk5rubTOs7xcpPSw0DDjzaMKQ9RrunJ3B0UZz0wq0mPqDRBfcW+y+fwW3vsM2GEyKDsVKp/7dS4Gl/EhFSqWi1P3YaKElik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSCMmZex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893ECC4CEF0;
	Thu,  4 Sep 2025 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001701;
	bh=j/h9kq4nhFbaFX5wXh7GT4njNgD0lqzfJ3Jo/r2pfxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FSCMmZexlnQFzSQ6QvHrfaxOk9aXbg5BeYwz2y+pvlloLC7g+XzmMTI1/vqyyeP4C
	 eeR/a9EG++Vo2g39abRPCfvHqnRmbgQDJR+b4peazBqn0KiIogFbLrse28xTSyA4q+
	 fvYoXo7YFCtZM8GU6JRGhDncIIZqnt5uxbZ2yNoE7ZSah9iYndF6LaMcckpSERQrBw
	 kQfJM68Kf1oEia5MGerO4z0zuyRPrVwwVP/miHIy1XSjbarU1kPtmdhYpEiplBNdL6
	 G0U9nQXtvO8KMvQs3QbNArNQQIiRWtYCqDIlQ1LqHYVqlZbec6A8mbQjjI2oIMU706
	 k540sqLMjHO4Q==
Date: Thu, 4 Sep 2025 11:01:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	p.zabel@pengutronix.de, johan+linaro@kernel.org,
	quic_schintav@quicinc.com, shradha.t@samsung.com, cassel@kernel.org,
	thippeswamy.havalige@amd.com, mayank.rana@oss.qualcomm.com,
	inochiama@gmail.com, ningyu@eswincomputing.com,
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
Message-ID: <20250904160140.GA1263976@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>

On Fri, Aug 29, 2025 at 04:24:05PM +0800, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller.
> The controller is based on the DesignWare PCIe core.

Wrap to fill 75 columns.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -492,4 +492,16 @@ config PCIE_VISCONTI_HOST
>  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>  	  This driver supports TMPV7708 SoC.
> 
> +config PCIE_EIC7700
> +	tristate "ESWIN PCIe host controller"

Should say "ESWIN PCIe controller" to match other entries.

> +	depends on PCI_MSI
> +	depends on ARCH_ESWIN || COMPILE_TEST

Reorder these to match other entries, i.e.,

	depends on ARCH_ESWIN || COMPILE_TEST
	depends on PCI_MSI

> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the PCIe controller in the Eswin SoC
> +	  The PCI controller on Eswin is based on DesignWare hardware
> +	  It is a high-speed hardware bus standard used to connect
> +	  processors with external devices. Say Y here if you want
> +	  PCIe controller support for the ESWIN.

Alphabetize so the menuconfig entries remain sorted by vendor.

> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>

Usually people sort these alphabetically.

> +#define PCIE_PM_SEL_AUX_CLK BIT(16)
> +#define PCIEMGMT_APP_LTSSM_ENABLE BIT(5)

Put these under the offset of the register that contains them so we
can tell the connections.

> +#define PCIEMGMT_CTRL0_OFFSET 0x0
> +#define PCIEMGMT_STATUS0_OFFSET 0x100
> +
> +#define PCIE_TYPE_DEV_VEND_ID 0x0

This looks like PCI_VENDOR_ID; use that instead.

> +#define PCIE_DSP_PF0_MSI_CAP 0x50
> +#define PCIE_NEXT_CAP_PTR 0x70

These look like fixed offsets in config space that should be
discovered by the usual method of traversing the capability lists,
e.g., dw_pcie_find_capability().

> +#define DEVICE_CONTROL_DEVICE_STATUS 0x78

I don't think you need this at all (see below).  But if you do, the
use below should include PCI_EXP_DEVCTL (e.g., as an offset from the
start of the PCIe Capability) so grep can find it.

> +#define PCIE_MSI_MULTIPLE_MSG_32 (0x5 << 17)
> +#define PCIE_MSI_MULTIPLE_MSG_MASK (0x7 << 17)

Use PCI_MSI_FLAGS_QMASK instead.

> +#define PCIEMGMT_LINKUP_STATE_VALIDATE ((0x11 << 2) | 0x3)
> +#define PCIEMGMT_LINKUP_STATE_MASK 0xff

Line up all the values of these #defines.

> +static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = dev_get_drvdata(pci->dev);
> +	int ret;
> +	u32 val;
> +	u32 retries;
> +
> +	/* Fetch clocks */
> +	pcie->num_clks = devm_clk_bulk_get_all_enabled(pci->dev, &pcie->clks);
> +	if (pcie->num_clks < 0)
> +		return dev_err_probe(pci->dev, pcie->num_clks,
> +				     "failed to get pcie clocks\n");
> +
> +	ret = eswin_pcie_power_on(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* set device type : rc */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= 0xfffffff0;
> +	writel_relaxed(val | 0x4, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);

"rc" is not a device type (a Root Complex is not itself a PCI device
that appears in config space).  I think you're talking about a Root
Port, which is a PCIe device, so this should be
PCI_EXP_TYPE_ROOT_PORT.

> +	ret = reset_control_assert(pcie->perst);
> +	if (ret) {
> +		dev_err(pci->dev, "perst assert signal is invalid");
> +		goto err_perst;
> +	}
> +	msleep(100);

This sleep needs a comment (if it's specific to eic7700) or a standard
#define from drivers/pci/pci.h (if something from the PCIe spec).

> +	ret = reset_control_deassert(pcie->perst);
> +	if (ret) {
> +		dev_err(pci->dev, "perst deassert signal is invalid");
> +		goto err_perst;
> +	}
> +
> +	/* app_hold_phy_rst */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~(0x40);
> +	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	/*
> +	 * It takes at least 20ms to wait for the pcie
> +	 * status register to be 0.

s/pcie/PCIe/ (follow spec usage in comments, messages, etc)

> +	 */
> +	retries = 30;
> +	do {
> +		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +		if (!(val & PCIE_PM_SEL_AUX_CLK))
> +			break;
> +		usleep_range(1000, 1100);
> +		retries--;
> +	} while (retries);

This delay should also have a citation to eic7700 spec if it came from
there.  Suggest fsleep() instead of usleep_range().  The exact delay
doesn't look critical here.

> +	if (!retries) {
> +		dev_err(pci->dev, "No clock exist.\n");

Drop period at end of messages.

> +		ret = -ENODEV;
> +		goto err_clock;
> +	}
> +
> +	/* config eswin vendor id and eic7700 device id */
> +	dw_pcie_writel_dbi(pci, PCIE_TYPE_DEV_VEND_ID, 0x20301fe1);
> +
> +	/* lane fix config, real driver NOT need, default x4 */
> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	val &= 0xffffff80;
> +	val |= 0x44;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS);
> +	val &= ~(0x7 << 5);
> +	val |= (0x2 << 5);
> +	dw_pcie_writel_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS, val);

This sets MPS, which should be done by the PCI core, not by the
driver.

> +	/*  config support 32 msi vectors */

Use "MSI" and "MSI-X" in comments, etc to match spec usage.

> +	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
> +	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
> +	val |= PCIE_MSI_MULTIPLE_MSG_32;

Use FIELD_PREP() as in dw_pcie_ep_set_msi().

> +	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
> +
> +	/* disable msix cap */
> +	val = dw_pcie_readl_dbi(pci, PCIE_NEXT_CAP_PTR);
> +	val &= 0xffff00ff;
> +	dw_pcie_writel_dbi(pci, PCIE_NEXT_CAP_PTR, val);
> +
> +	return 0;
> +
> +err_clock:
> +	reset_control_assert(pcie->perst);
> +err_perst:
> +	eswin_pcie_power_off(pcie);
> +	return ret;
> +}
> +
> +static const struct dw_pcie_host_ops eswin_pcie_host_ops = {
> +	.init = eswin_pcie_host_init,
> +};
> +
> +static const struct dw_pcie_ops dw_pcie_ops = {
> +	.start_link = eswin_pcie_start_link,
> +	.link_up = eswin_pcie_link_up,
> +};
> +
> +static int eswin_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci;
> +	struct eswin_pcie *pcie;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +	pci->pp.ops = &eswin_pcie_host_ops;
> +
> +	/* SiFive specific region: mgmt */
> +	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> +	if (IS_ERR(pcie->mgmt_base))
> +		return dev_err_probe(dev, PTR_ERR(pcie->mgmt_base),
> +				     "failed to map mgmt memory\n");
> +
> +	/* Fetch reset */
> +	pcie->powerup_rst = devm_reset_control_get_optional(&pdev->dev,
> +							    "powerup");
> +	if (IS_ERR_OR_NULL(pcie->powerup_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
> +				     "unable to get powerup reset\n");
> +
> +	pcie->cfg_rst = devm_reset_control_get_optional(&pdev->dev, "cfg");
> +	if (IS_ERR_OR_NULL(pcie->cfg_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
> +				     "unable to get cfg reset\n");
> +
> +	pcie->perst = devm_reset_control_get_optional(&pdev->dev, "pwren");

Why is this not called "perst" in devicetree?

> +	if (IS_ERR_OR_NULL(pcie->perst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->perst),
> +				     "unable to get perst reset\n");
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
> +		goto err_get_sync;
> +	}
> +
> +	ret = dw_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize host: %d\n", ret);
> +		goto err_host_init;
> +	}
> +
> +	return ret;
> +
> +err_host_init:
> +	pm_runtime_put_sync(dev);
> +err_get_sync:
> +	pm_runtime_disable(dev);
> +	return ret;
> +}

