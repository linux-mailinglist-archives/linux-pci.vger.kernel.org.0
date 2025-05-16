Return-Path: <linux-pci+bounces-27858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11541AB9C71
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1863A21C6B
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7F923814C;
	Fri, 16 May 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV2zDf1p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B464D1D6DBB;
	Fri, 16 May 2025 12:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399407; cv=none; b=o4xbAMZUt1tavN0qHtJVxNImMS5sERnQcCtpOTY4/TRz7ei1Nz4I5DK+o1jh6ucMNf9kIpZi4yj6SYO0WuFb0OVDgSl+igHr5dmJJuq41JWDPdOPT+gMXhXxiMP16KpNYEwyAlXAXCnNnVmWTV0Eao9viF5vMy+3Md0XpTNMvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399407; c=relaxed/simple;
	bh=v9ZtJ8sJxsnL3ffqP6T+9LtiIYre38Xi4HFD/kzTykg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dQZfqpGG+ASA4FO1MBN5OroiedScgIMxXy3EN+4twX7yrkMd3VDtBNVPqqSXYZb4dHkyR8xBlUWlXFMQ7tzQrlU963gnlx/TB7pSbUU8Y3Lb//Jv4XZxBPsbkX74N2S/yCchfg0n/l3/M2gZCOvHfzUPXZj55btcftKdN0IUWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV2zDf1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D3FC4CEE4;
	Fri, 16 May 2025 12:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747399407;
	bh=v9ZtJ8sJxsnL3ffqP6T+9LtiIYre38Xi4HFD/kzTykg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iV2zDf1p4zllck22Zyzc34VFgPiNWbrGRc9ruxfDURChy5fODW5acePJSSWQfK49q
	 89ITyj86UdAHJSAinL2vBwqG4GM7xVqVhS5CfblUewNS455B0uAYq5cT0G+UYJ3T7S
	 3jVdFWLkpociLR5o2yQGrHGaHBe/NwiEofI8RiqaEjvKtz5L7l+pRmmnzAEZBLicgn
	 glPTILsBgA63Jo8EiOcoHEBtL12UhSAJR3BwZmEYWFH4sISq3fCscahiakVXLmJm6G
	 ktlwFv4DAFJ8679PKZM65HwfHtkzAcm7Ok7pW3sv+an9RSI45i1plfO5zvAh0deYsI
	 6YndbL96JMeow==
Message-ID: <b5b39790-2559-41eb-9805-8eed1683d34e@kernel.org>
Date: Fri, 16 May 2025 14:43:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PCI: eic7700: Add Eswin eic7700 PCIe host
 controller driver
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com,
 lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.or,
 linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
 johan+linaro@kernel.org, quic_schintav@quicinc.com, shradha.t@samsung.com,
 cassel@kernel.org, thippeswamy.havalige@amd.com
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com
References: <20250516094057.1300-1-zhangsenchuan@eswincomputing.com>
 <20250516094315.179-1-zhangsenchuan@eswincomputing.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250516094315.179-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/05/2025 11:43, zhangsenchuan@eswincomputing.com wrote:

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/syscon.h>

Where do you use it?

> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/resource.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/reset.h>
> +#include <linux/gpio/consumer.h>

That's mess. Clean up your patches before sending from such trivial
mistakes.

> +#include <linux/property.h>

Most of these headers look like unused.

> +#include "pcie-designware.h"
> +#include <linux/pm_runtime.h>
> +struct eswin_pcie {
> +	struct dw_pcie pci;
> +	void __iomem *mgmt_base;
> +	struct gpio_desc *reset;
> +	struct clk *pcie_aux;
> +	struct clk *pcie_cfg;
> +	struct clk *pcie_cr;
> +	struct clk *pcie_aclk;
> +	struct reset_control *powerup_rst;
> +	struct reset_control *cfg_rst;
> +	struct reset_control *perst;
> +};
> +
> +#define PCIE_PM_SEL_AUX_CLK BIT(16)
> +#define PCIEMGMT_APP_HOLD_PHY_RST BIT(6)
> +#define PCIEMGMT_APP_LTSSM_ENABLE BIT(5)
> +#define PCIEMGMT_DEVICE_TYPE_MASK 0xf
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
> +static void eswin_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	/* Bring down link, so bootloader gets clean state in case of reboot */
> +	reset_control_assert(pcie->perst);
> +}
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
> +	return 0;
> +}
> +
> +static int eswin_pcie_link_up(struct dw_pcie *pci)
> +{
> +	struct device *dev = pci->dev;
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	u32 val;
> +
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +	if ((val & PCIEMGMT_LINKUP_STATE_MASK) ==
> +	    PCIEMGMT_LINKUP_STATE_VALIDATE)
> +		return 1;
> +	else
> +		return 0;
> +}
> +
> +static int eswin_pcie_clk_enable(struct eswin_pcie *pcie)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(pcie->pcie_cr);
> +	if (ret) {
> +		pr_err("PCIe: failed to enable cr clk: %d\n", ret);

No, your driver must use everywhere dev_, not pr_.

> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->pcie_aclk);
> +	if (ret) {
> +		pr_err("PCIe: failed to enable aclk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->pcie_cfg);
> +	if (ret) {
> +		pr_err("PCIe: failed to enable cfg_clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(pcie->pcie_aux);
> +	if (ret) {
> +		pr_err("PCIe: failed to enable aux_clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_clk_disable(struct eswin_pcie *eswin_pcie)
> +{
> +	clk_disable_unprepare(eswin_pcie->pcie_aux);
> +	clk_disable_unprepare(eswin_pcie->pcie_cfg);
> +	clk_disable_unprepare(eswin_pcie->pcie_cr);
> +	clk_disable_unprepare(eswin_pcie->pcie_aclk);
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_power_on(struct eswin_pcie *pcie)
> +{
> +	int ret = 0;
> +
> +	/* pciet_cfg_rstn */
> +	ret = reset_control_reset(pcie->cfg_rst);
> +	WARN_ON(ret != 0);

No, handle the error instead.

> +
> +	/* pciet_powerup_rstn */
> +	ret = reset_control_reset(pcie->powerup_rst);
> +	WARN_ON(ret != 0);

No, handle the error instead.

> +
> +	return ret;
> +}
> +
> +static int eswin_pcie_power_off(struct eswin_pcie *eswin_pcie)
> +{
> +	reset_control_assert(eswin_pcie->perst);
> +
> +	reset_control_assert(eswin_pcie->powerup_rst);
> +
> +	reset_control_assert(eswin_pcie->cfg_rst);
> +
> +	return 0;
> +}
> +
> +static int eswin_evb_socket_power_on(struct device *dev)
> +{
> +	int err_desc = 0;
> +	struct gpio_desc *gpio;
> +
> +	gpio = devm_gpiod_get(dev, "pci-socket", GPIOD_OUT_LOW);

Undocumented ABI. Looks not correct either - see PCI controller bindings.


> +	err_desc = IS_ERR(gpio);
> +
> +	if (err_desc) {
> +		pr_debug("No power control gpio found, maybe not needed\n");
> +		return 0;
> +	}
> +
> +	gpiod_set_value(gpio, 1);
> +
> +	return err_desc;
> +}
> +
> +static int eswin_pcie_host_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct eswin_pcie *pcie = dev_get_drvdata(pci->dev);
> +	int ret;
> +	u32 val;
> +
> +	/* pciet_aux_clken, pcie_cfg_clken */
> +	ret = eswin_pcie_clk_enable(pcie);
> +	if (ret)
> +		return ret;
> +
> +	ret = eswin_pcie_power_on(pcie);
> +	if (ret)
> +		return ret;
> +
> +	/* set device type : rc */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= 0xfffffff0;
> +	writel_relaxed(val | 0x4, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	ret = reset_control_assert(pcie->perst);
> +	WARN_ON(ret != 0);
> +
> +	eswin_evb_socket_power_on(pcie->pci.dev);
> +	msleep(100);
> +	ret = reset_control_deassert(pcie->perst);
> +	WARN_ON(ret != 0);
> +
> +	/* app_hold_phy_rst */
> +	val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +	val &= ~(0x40);
> +	writel_relaxed(val, pcie->mgmt_base + PCIEMGMT_CTRL0_OFFSET);
> +
> +	/* wait pm_sel_aux_clk to 0 */
> +	for (ret = 50; ret > 0; ret--) {
> +		val = readl_relaxed(pcie->mgmt_base + PCIEMGMT_STATUS0_OFFSET);
> +		if (!(val & PCIE_PM_SEL_AUX_CLK))
> +			break;
> +		msleep(2);
> +	}
> +
> +	if (!ret) {
> +		dev_info(pcie->pci.dev, "No clock exist.\n");
> +		eswin_pcie_power_off(pcie);
> +		eswin_pcie_clk_disable(pcie);
> +		return -ENODEV;
> +	}
> +
> +	/* config eswin vendor id and win2030 device id */
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
> +
> +	/*  config support 32 msi vectors */
> +	val = dw_pcie_readl_dbi(pci, PCIE_DSP_PF0_MSI_CAP);
> +	val &= ~PCIE_MSI_MULTIPLE_MSG_MASK;
> +	val |= PCIE_MSI_MULTIPLE_MSG_32;
> +	dw_pcie_writel_dbi(pci, PCIE_DSP_PF0_MSI_CAP, val);
> +
> +	/* disable msix cap */
> +	val = dw_pcie_readl_dbi(pci, PCIE_NEXT_CAP_PTR);
> +	val &= 0xffff00ff;
> +	dw_pcie_writel_dbi(pci, PCIE_NEXT_CAP_PTR, val);
> +
> +	return 0;
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
> +static int __exit eswin_pcie_remove(struct platform_device *pdev)

Remove goes after probe

> +{
> +	struct eswin_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&pcie->pci.pp);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	eswin_pcie_power_off(pcie);
> +	eswin_pcie_clk_disable(pcie);
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci;
> +	struct eswin_pcie *pcie;
> +	int err;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +	pci = &pcie->pci;
> +	pci->dev = dev;
> +	pci->ops = &dw_pcie_ops;
> +	pci->pp.ops = &eswin_pcie_host_ops;
> +
> +	/* SiFive specific region: mgmt */
> +	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> +	if (IS_ERR(pcie->mgmt_base))
> +		return PTR_ERR(pcie->mgmt_base);
> +
> +	/* Fetch clocks */
> +	pcie->pcie_aux = devm_clk_get(dev, "pcie_aux_clk");
> +	if (IS_ERR(pcie->pcie_aux)) {
> +		return dev_err_probe(
> +			dev, PTR_ERR(pcie->pcie_aux),
> +			"pcie_aux clock source missing or invalid\n");

Messed alignment. This applies eveywhere.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

> +	}
> +
> +	pcie->pcie_cfg = devm_clk_get(dev, "pcie_cfg_clk");
> +	if (IS_ERR(pcie->pcie_cfg)) {
> +		return dev_err_probe(
> +			dev, PTR_ERR(pcie->pcie_cfg),
> +			"pcie_cfg_clk clock source missing or invalid\n");
> +	}
> +
> +	pcie->pcie_cr = devm_clk_get(dev, "pcie_cr_clk");
> +	if (IS_ERR(pcie->pcie_cr)) {
> +		return dev_err_probe(
> +			dev, PTR_ERR(pcie->pcie_cr),
> +			"pcie_cr_clk clock source missing or invalid\n");
> +	}
> +
> +	pcie->pcie_aclk = devm_clk_get(dev, "pcie_aclk");
> +
> +	if (IS_ERR(pcie->pcie_aclk)) {
> +		return dev_err_probe(
> +			dev, PTR_ERR(pcie->pcie_aclk),
> +			"pcie_aclk clock source missing or invalid\n");
> +	}
> +
> +	/* Fetch reset */
> +	pcie->powerup_rst =
> +		devm_reset_control_get_optional(&pdev->dev, "pcie_powerup");
> +	if (IS_ERR_OR_NULL(pcie->powerup_rst))
> +		dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
> +			      "unable to get powerup reset\n");
> +
> +	pcie->cfg_rst = devm_reset_control_get_optional(&pdev->dev, "pcie_cfg");
> +	if (IS_ERR_OR_NULL(pcie->cfg_rst))
> +		dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
> +			      "unable to get cfg reset\n");
> +
> +	pcie->perst = devm_reset_control_get_optional(&pdev->dev, "pcie_pwren");
> +	if (IS_ERR_OR_NULL(pcie->perst))
> +		dev_err_probe(dev, PTR_ERR(pcie->perst),
> +			      "unable to get perst\n");
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	err = pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", err);
> +		goto pm_runtime_put;
> +	}
> +
> +	return dw_pcie_host_init(&pci->pp);

Missing cleanup of runtime PM

> +
> +pm_runtime_put:
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
> +	return err;
> +}
> +
> +static const struct of_device_id eswin_pcie_of_match[] = {
> +	{
> +		.compatible = "eswin,eic7700-pcie",
> +	},
> +	{},
> +};
> +
> +static int eswin_pcie_suspend(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "suspend %s\n", __func__);

Drop

> +	if (!pm_runtime_status_suspended(dev))
> +		eswin_pcie_clk_disable(pcie);
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_resume(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "resume %s\n", __func__);

Drop

> +	if (!pm_runtime_status_suspended(dev))
> +		eswin_pcie_clk_enable(pcie);
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_runtime_suspend(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "runtime suspend %s\n", __func__);

Drop

> +	return eswin_pcie_clk_disable(pcie);
> +}
> +
> +static int eswin_pcie_runtime_resume(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +
> +	dev_dbg(dev, "runtime resume %s\n", __func__);

Drop

> +	return eswin_pcie_clk_enable(pcie);
> +}
> +
> +static const struct dev_pm_ops eswin_pcie_pm_ops = {
> +	RUNTIME_PM_OPS(eswin_pcie_runtime_suspend, eswin_pcie_runtime_resume,
> +		       NULL)
> +		NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)
> +};
> +
> +static struct platform_driver eswin_pcie_driver = {
> +	.driver = {
> +			.name = "eic7700-pcie",
> +			.of_match_table = eswin_pcie_of_match,
> +			.suppress_bind_attrs = true,
> +			.pm = &eswin_pcie_pm_ops,
> +	},
> +	.probe = eswin_pcie_probe,
> +	.remove = __exit_p(eswin_pcie_remove),

exit and suppress bind attrs feels wrong. Unnecessary and odd, although
maybe this is something common in PCI?

> +	.shutdown = eswin_pcie_shutdown,
> +};
> +
> +module_platform_driver(eswin_pcie_driver);
> +
> +MODULE_DEVICE_TABLE(of, eswin_pcie_of_match);
> +MODULE_DESCRIPTION("PCIe host controller driver for eic7700 SoCs");
> +MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
> +MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.25.1
> 


Best regards,
Krzysztof

