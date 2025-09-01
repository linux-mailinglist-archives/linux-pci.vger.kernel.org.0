Return-Path: <linux-pci+bounces-35239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAA4B3DA1C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722EB18972C5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 06:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE661258EDE;
	Mon,  1 Sep 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOwyaaSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9030118EB0;
	Mon,  1 Sep 2025 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756708851; cv=none; b=u2RevPf+JyGBX3j0fg1TGg70Juo1gHYgJIwDfC0XTBnRsK80pl/i+7fs2tBZkTrxVFAbK2/r1UXcVCYuEVbD44V82zzglUbrDgmjjJJ37WXzdXmLREBgO4mOTXzl55Vj2U6QwsgeAa8wUZ7KRF7U1AToFStpcsVWqCx2KkWAmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756708851; c=relaxed/simple;
	bh=HLIJ/88I9oikGh1FbjwJdvkrDB8odi9uvvX3GgGjNo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZhd8lWTabDrcubwGSOH8L7ReRZJZUh0E1FlQi3LXHMeFgLMtv3R1+2OkYSCNoNGtqBoUW+JqJCMYmfUD7wHp4gmMAWtJNhbFenUOOmr/emvyvvWhHaxh2UO/GB7OLMXMu3U9GYMdFP5rD/4hphnw1ksvZ7j0eFI3TKN3jk6ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOwyaaSM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98226C4CEF0;
	Mon,  1 Sep 2025 06:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756708851;
	bh=HLIJ/88I9oikGh1FbjwJdvkrDB8odi9uvvX3GgGjNo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOwyaaSMlmfXR1L4T/1YVaGcgMcTtHeTcXst7BofxQGKDyNy+YsUx/P8uNddQML/+
	 TCYD8ouRMGHvN3B0tO9d/jKMkm8RZTz91zxvwN2WSoL6KH9LW8Atxxo1rCrVDOc5xF
	 z/RDi00Zv+SQADyIQ7fc+u0zhvjPJ69pZm1Y1/n1kBY3YRpMZQk3BLa/RMYQDaHxiP
	 hqSuhaFCzG5l7cVPg3JyHPyK1aiWs7RUqpierP8CMsEv90uBCm1jB6t8ykdDUrTuz0
	 LiFKnarRun3XL1UZaNU3uvCHDMKoAJFrpXPkIYtwJjC5GoVcbijAX4Nk3bG+BizPfn
	 XTSeLuAafz8uw==
Date: Mon, 1 Sep 2025 12:10:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: zhangsenchuan@eswincomputing.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	p.zabel@pengutronix.de, johan+linaro@kernel.org, quic_schintav@quicinc.com, 
	shradha.t@samsung.com, cassel@kernel.org, thippeswamy.havalige@amd.com, 
	mayank.rana@oss.qualcomm.com, inochiama@gmail.com, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com
Subject: Re: [PATCH v2 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
Message-ID: <jghozurjqyhmtunivotitgs67h6xo4sb46qcycnbbwyvjcm4ek@vgq75olazmoi>
References: <20250829082021.49-1-zhangsenchuan@eswincomputing.com>
 <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829082405.1203-1-zhangsenchuan@eswincomputing.com>

On Fri, Aug 29, 2025 at 04:24:05PM GMT, zhangsenchuan@eswincomputing.com wrote:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller.
> The controller is based on the DesignWare PCIe core.
> 

Add more info about the controller: DWC IP revision, data rate, lanes etc...

> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Senchuan Zhang<zhangsenchuan@eswincomputing.com>
> ---
>  drivers/pci/controller/dwc/Kconfig        |  12 +
>  drivers/pci/controller/dwc/Makefile       |   1 +
>  drivers/pci/controller/dwc/pcie-eic7700.c | 350 ++++++++++++++++++++++
>  3 files changed, 363 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index ff6b6d9e18ec..1c4063107a8a 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -492,4 +492,16 @@ config PCIE_VISCONTI_HOST
>  	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
>  	  This driver supports TMPV7708 SoC.
> 
> +config PCIE_EIC7700
> +	tristate "ESWIN PCIe host controller"
> +	depends on PCI_MSI
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	select PCIE_DW_HOST
> +	help
> +	  Enables support for the PCIe controller in the Eswin SoC
> +	  The PCI controller on Eswin is based on DesignWare hardware
> +	  It is a high-speed hardware bus standard used to connect
> +	  processors with external devices.

No need to explain what PCIe bus is.

> Say Y here if you want
> +	  PCIe controller support for the ESWIN.
> +
>  endmenu
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 6919d27798d1..0717fe73a2a9 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_PCIE_UNIPHIER) += pcie-uniphier.o
>  obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  obj-$(CONFIG_PCIE_VISCONTI_HOST) += pcie-visconti.o
>  obj-$(CONFIG_PCIE_RCAR_GEN4) += pcie-rcar-gen4.o
> +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
> 
>  # The following drivers are for devices that use the generic ACPI
>  # pci_root.c driver but don't support standard ECAM config access.
> diff --git a/drivers/pci/controller/dwc/pcie-eic7700.c b/drivers/pci/controller/dwc/pcie-eic7700.c
> new file mode 100644
> index 000000000000..bf942154d971
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c
> @@ -0,0 +1,350 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ESWIN PCIe root complex driver
> + *
> + * Copyright 2025, Beijing ESWIN Computing Technology Co., Ltd.
> + *
> + * Authors: Yu Ning <ningyu@eswincomputing.com>
> + *          Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> + */
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/reset.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-designware.h"
> +
> +struct eswin_pcie {
> +	struct dw_pcie pci;
> +	void __iomem *mgmt_base;
> +	struct clk_bulk_data *clks;
> +	struct reset_control *powerup_rst;
> +	struct reset_control *cfg_rst;
> +	struct reset_control *perst;
> +
> +	int num_clks;
> +};
> +
> +#define PCIE_PM_SEL_AUX_CLK BIT(16)
> +#define PCIEMGMT_APP_LTSSM_ENABLE BIT(5)
> +
> +#define PCIEMGMT_CTRL0_OFFSET 0x0
> +#define PCIEMGMT_STATUS0_OFFSET 0x100
> +
> +#define PCIE_TYPE_DEV_VEND_ID 0x0
> +#define PCIE_DSP_PF0_MSI_CAP 0x50
> +#define PCIE_NEXT_CAP_PTR 0x70
> +#define DEVICE_CONTROL_DEVICE_STATUS 0x78
> +
> +#define PCIE_MSI_MULTIPLE_MSG_32 (0x5 << 17)
> +#define PCIE_MSI_MULTIPLE_MSG_MASK (0x7 << 17)
> +
> +#define PCIEMGMT_LINKUP_STATE_VALIDATE ((0x11 << 2) | 0x3)
> +#define PCIEMGMT_LINKUP_STATE_MASK 0xff
> +
> +static int eswin_pcie_start_link(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	/* Enable LTSSM */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val |= PCIEMGMT_APP_LTSSM_ENABLE;
> +	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	return 0;
> +}
> +
> +static bool eswin_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +
> +	return ((val & PCIEMGMT_LINKUP_STATE_MASK) ==
> +		     PCIEMGMT_LINKUP_STATE_VALIDATE);
> +}
> +
> +static int eswin_pcie_power_on(struct eswin_pcie *pcie)
> +{
> +	int ret = 0;

Don't initialize ret.

> +
> +	/* pciet_cfg_rstn */
> +	ret = reset_control_deassert(pcie->cfg_rst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "cfg signal is invalid");
> +		return ret;
> +	}
> +
> +	/* pciet_powerup_rstn */
> +	ret = reset_control_deassert(pcie->powerup_rst);
> +	if (ret) {
> +		dev_err(pcie->pci.dev, "powerup signal is invalid");
> +		goto err_deassert_powerup;
> +	}
> +
> +	return ret;

	return 0;

> +
> +err_deassert_powerup:
> +	reset_control_assert(pcie->cfg_rst);
> +
> +	return ret;
> +}
> +
> +static void eswin_pcie_power_off(struct eswin_pcie *eswin_pcie)
> +{
> +	reset_control_assert(eswin_pcie->powerup_rst);
> +	reset_control_assert(eswin_pcie->cfg_rst);
> +}
> +
> +static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = dev_get_drvdata(pci->dev);
> +	int ret;
> +	u32 val;
> +	u32 retries;
> +
> +	/* Fetch clocks */

Drop the comment.

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

Can you add bitfield definition for the mask?

> +	writel_relaxed(val | 0x4, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);

Also for 0x4.

> +
> +	ret = reset_control_assert(pcie->perst);
> +	if (ret) {
> +		dev_err(pci->dev, "perst assert signal is invalid");

'Failed to assert PERST#'

> +		goto err_perst;
> +	}
> +	msleep(100);
> +	ret = reset_control_deassert(pcie->perst);
> +	if (ret) {
> +		dev_err(pci->dev, "perst deassert signal is invalid");

'Failed to deassert PERST#'

> +		goto err_perst;
> +	}
> +
> +	/* app_hold_phy_rst */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~(0x40);

Add definition here and everywhere.

> +	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	/*
> +	 * It takes at least 20ms to wait for the pcie
> +	 * status register to be 0.

Make use of 80 columns for comments.

> +	 */
> +	retries = 30;
> +	do {
> +		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +		if (!(val & PCIE_PM_SEL_AUX_CLK))
> +			break;
> +		usleep_range(1000, 1100);
> +		retries--;
> +	} while (retries);
> +
> +	if (!retries) {
> +		dev_err(pci->dev, "No clock exist.\n");

What does this error mean exactly? "No clock exist" is not a valid error. Error
has something to do with PCIE_PM_SEL_AUX_CLK, no?

> +		ret = -ENODEV;

-ETIMEDOUT?

> +		goto err_clock;
> +	}
> +
> +	/* config eswin vendor id and eic7700 device id */
> +	dw_pcie_writel_dbi(pci, PCIE_TYPE_DEV_VEND_ID, 0x20301fe1);

Does it need to be configured all the time?

> +
> +	/* lane fix config, real driver NOT need, default x4 */

What do you mean by 'readl driver NOT need'?

> +	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
> +	val &= 0xffffff80;
> +	val |= 0x44;
> +	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
> +
> +	val = dw_pcie_readl_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS);
> +	val &= ~(0x7 << 5);
> +	val |= (0x2 << 5);
> +	dw_pcie_writel_dbi(pci, DEVICE_CONTROL_DEVICE_STATUS, val);
> +
> +	/*  config support 32 msi vectors */
> +	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
> +	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
> +	val |= PCIE_MSI_MULTIPLE_MSG_32;
> +	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
> +
> +	/* disable msix cap */

Why? Hw doesn't support MSI-X but it advertises MSI-X capability?

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

Use reverse Xmas order for all local variables in this driver.

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

So the DWC glue wrapper belongs to SiFive?

> +	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> +	if (IS_ERR(pcie->mgmt_base))
> +		return dev_err_probe(dev, PTR_ERR(pcie->mgmt_base),
> +				     "failed to map mgmt memory\n");
> +
> +	/* Fetch reset */

Drop the comment.

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
> +	if (IS_ERR_OR_NULL(pcie->perst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->perst),
> +				     "unable to get perst reset\n");

All 3 resets are optional? Even the ones you were using to power on the
controller?

> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);

So by this time controller is powered on? I don't think so, as
eswin_pcie_power_on() is called from host_init() callback. If I'm right, then
these should be moved below dw_pcie_host_init().

> +	ret = pm_runtime_get_sync(dev);

Why do you need get_sync? Are you depending on any parent to power on any
resource?

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

	return 0;

> +
> +err_host_init:
> +	pm_runtime_put_sync(dev);
> +err_get_sync:
> +	pm_runtime_disable(dev);
> +	return ret;
> +}
> +
> +static void eswin_pcie_remove(struct platform_device *pdev)
> +{
> +	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&pcie->pci.pp);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	reset_control_assert(pcie->perst);
> +	eswin_pcie_power_off(pcie);
> +}
> +
> +static void eswin_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	/* Bring down link, so bootloader gets clean state in case of reboot */

Asserting PERST# won't bring down the device. It just provides indication that
the device might get powered off and it needs to be prepared for that.

Also, I don't get what you mean by 'bootloder'. Is it the host system bootloader
or device? Usually, shutdown callback is needed to power off the device when the
host powers down/reboots so that the device will be reset to a clean state.

> +	reset_control_assert(pcie->perst);
> +}
> +
> +static int eswin_pcie_suspend(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	reset_control_assert(pcie->perst);
> +	eswin_pcie_power_off(pcie);

So you want to power off the device even if it intends to be in D0? Like NVMe.

> +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_resume(struct device *dev)
> +{
> +	int ret;
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	ret = eswin_pcie_host_init(&pcie->pci.pp);
> +	if (ret < 0) {

if (ret)

> +		dev_err(dev, "Failed to init host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pcie->pci.pp);
> +	eswin_pcie_start_link(&pcie->pci);
> +	dw_pcie_wait_for_link(&pcie->pci);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops eswin_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
> +};
> +
> +static const struct of_device_id eswin_pcie_of_match[] = {
> +	{ .compatible = "eswin,eic7700-pcie" },
> +	{},
> +};
> +
> +static struct platform_driver eswin_pcie_driver = {
> +	.driver = {
> +		.name = "eic7700-pcie",
> +		.of_match_table = eswin_pcie_of_match,
> +		.suppress_bind_attrs = true,
> +		.pm = &eswin_pcie_pm_ops,
> +	},
> +	.probe = eswin_pcie_probe,
> +	.remove = eswin_pcie_remove,

Since this controller implements irqchip using the DWC core driver, it is not
safe to remove it during runtime.

> +	.shutdown = eswin_pcie_shutdown,
> +};
> +
> +module_platform_driver(eswin_pcie_driver);

builtin_platform_driver()

> +
> +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);

Move it below eswin_pcie_of_match[].

> +MODULE_DESCRIPTION("PCIe host controller driver for eic7700 SoCs");

EIC7700?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

