Return-Path: <linux-pci+bounces-36786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D8DB96D6A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 18:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F51E19C375B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 16:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A007327A33;
	Tue, 23 Sep 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ieh7IMNu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DB72E5B1B;
	Tue, 23 Sep 2025 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645176; cv=none; b=cX9lLbktUVydV8POOCxQ4Rvn3L7+WvlmJeCFyhDuggDw8CNMWM3khZh9d3KfDeii+nG1Sa61yhg0SXOivcpoOXgQq23fnsrBrQFx/PDW/DdV5Y8ExnxVVpsZKW30WIKO6dn/WYmd71Nn7PsX1l8K7NdGSLifzPnSxIM4gv24rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645176; c=relaxed/simple;
	bh=nXg/n5hpWCZLMQ+84dFs6XsSa3daE8FI7ZQaMSHDtw4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dl8wf+/SNZ2i4Zxdyeips5Sz/zKy4QJxznp73lvsXOISxldmk6j1wCNNNM20cIlSFc7bucTZjNllMimpe6Fy988xNc9LbgQvd+E8sYnSSqR9NleObla+wMQuGWHWY0lklhW3lpGagqucmtwHDL85kJgRLecNv8Yk7CBS22JKLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ieh7IMNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB33C4CEF5;
	Tue, 23 Sep 2025 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758645175;
	bh=nXg/n5hpWCZLMQ+84dFs6XsSa3daE8FI7ZQaMSHDtw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Ieh7IMNuWw1otot5GgD04hmcV4NCpwDR/tGMiwk4kPz2q60eWO87q4IJicdsVGqiA
	 6JWmmkE36Y1PyI+XCZC67Q+XaJyAMXFU4K+0iVRZCHybewZwE/VqapHTWzmdX56NcE
	 XoPM/nlaFTgFztZth9FMt+2h+p1x5/sLhh/+zN4D9MvIQAHDPd06pbc+Mua2CLNjtK
	 bPlyyBqNHE4pJ3MUVE1txmF8EEjnHGBal4TplCcZaqLbJhVqQJL5L3YQvtEzdc8nIZ
	 RGVZMZdCeN/grQU5bxQCtFeyBFhOdruEsA64RWW83IGdy2+MYM8CpXmZv7iOWfJrDW
	 IeqfTl1qQgENA==
Date: Tue, 23 Sep 2025 11:32:54 -0500
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
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
	Yanghui Ou <ouyanghui@eswincomputing.com>
Subject: Re: [PATCH v3 2/2] PCI: EIC7700: Add Eswin PCIe host controller
 driver
Message-ID: <20250923163254.GA2042659@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923121228.1255-1-zhangsenchuan@eswincomputing.com>

On Tue, Sep 23, 2025 at 08:12:27PM +0800, zhangsenchuan@eswincomputing.com wrote:
> Add driver for the Eswin EIC7700 PCIe host controller,the controller is
> based on the DesignWare PCIe core, IP revision 6.00a The PCIe Gen.3
> controller supports a data rate of 8 GT/s and 4 channels, support INTX
> and MSI interrupts.

s/host controller,the controller is/host controller, which is/

Add period at end of first sentence.

> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -375,6 +375,17 @@ config PCI_EXYNOS
>  	  hardware and therefore the driver re-uses the DesignWare core
>  	  functions to implement the driver.
>  
> +config PCIE_EIC7700
> +	bool "ESWIN PCIe controller"
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support for the ESWIN.
> +	  The PCIe controller on Eswin is based on DesignWare hardware,
> +	  enables support for the PCIe controller in the Eswin SoC to
> +	  work in host mode.

Alphabetize by vendor name so the kconfig menus stay sorted:

  Baikal-T1 PCIe controller
  ESWIN PCIe controller
  Freescale i.MX6/7/8 PCIe controller (host mode)

> +++ b/drivers/pci/controller/dwc/pcie-eic7700.c

> +/* Vendor and device id value */
> +#define VENDOR_ID_VALUE			0x1fe1
> +#define DEVICE_ID_VALUE			0x2030

Use something like this to match definitions in
include/linux/pci_ids.h, where this might eventually be moved if used
in other drivers:

  #define PCI_VENDOR_ID_ESWIN            0x1fe1

> +/* Disable MSI-X cap register fields */
> +#define PCIE_MSIX_DISABLE_MASK		GENMASK(15, 8)

I think this value has nothing to do with MSI-X; it's just the "Next
Capability Pointer" in the capability header, i.e., the
PCI_CAP_LIST_NEXT_MASK added here:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=37d1ade89606

That commit is queued but not merged, so you can't use it yet.  If
this driver is merged after v6.17, you can switch to using it.

> +static int eswin_pcie_parse_ports(struct eswin_pcie *pcie)
> +{
> +	struct device *dev = pcie->pci.dev;
> +	struct eswin_pcie_port *port, *tmp;
> +	int ret;
> +
> +	for_each_available_child_of_node_scoped(dev->of_node, of_port) {
> +		ret = eswin_pcie_parse_port(pcie, of_port);
> +		if (ret)
> +			goto err_port;
> +	}
> +
> +	return ret;

"ret" is potentially uninitialized here, but you never get here if
eswin_pcie_parse_port() fails, so I think you should "return 0"
directly instead.

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
> +
> +	pcie->mgmt_base = devm_platform_ioremap_resource_byname(pdev, "mgmt");
> +	if (IS_ERR(pcie->mgmt_base))
> +		return dev_err_probe(dev, PTR_ERR(pcie->mgmt_base),
> +				     "Failed to map mgmt registers\n");
> +
> +	pcie->powerup_rst = devm_reset_control_get(&pdev->dev, "powerup");
> +	if (IS_ERR(pcie->powerup_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->powerup_rst),
> +				     "Failed to get powerup reset\n");
> +
> +	pcie->cfg_rst = devm_reset_control_get(&pdev->dev, "cfg");
> +	if (IS_ERR(pcie->cfg_rst))
> +		return dev_err_probe(dev, PTR_ERR(pcie->cfg_rst),
> +				     "Failed to get cfg reset\n");
> +
> +	ret = eswin_pcie_parse_ports(pcie);
> +	if (ret)
> +		dev_err_probe(pci->dev, ret,
> +			      "Failed to parse Root Port: %d\n", ret);
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	ret = dw_pcie_host_init(&pci->pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize host\n");
> +		goto err_init;
> +	}
> +
> +	return ret;

Can "return 0" here since we know the value.

> +err_init:
> +	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
> +		list_del(&port->list);
> +		reset_control_put(port->perst);
> +	}
> +	return ret;
> +}
> +
> +static int eswin_pcie_suspend(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	struct eswin_pcie_port *port;
> +
> +	/*
> +	 * For controllers with active devices, resources are retained and
> +	 * cannot be turned off.
> +	 */
> +	if (!dw_pcie_link_up(&pcie->pci)) {
> +		list_for_each_entry(port, &pcie->ports, list)
> +			reset_control_assert(port->perst);
> +		eswin_pcie_assert(pcie);
> +		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> +		pcie->suspended = true;

I'm a little dubious about this since none of the other drivers check
dw_pcie_link_up().

It also seems a little bit racy since dw_pcie_link_up() can always
change after it's called.

And tracking pcie->suspended is also unusual if not unique.

Should dw_pcie_suspend_noirq() and dw_pcie_resume_noirq() be used
here?

> +	}
> +
> +	return 0;
> +}
> +
> +static int eswin_pcie_resume(struct device *dev)
> +{
> +	struct eswin_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!pcie->suspended)
> +		return 0;
> +
> +	ret = eswin_pcie_host_init(&pcie->pci.pp);
> +	if (ret) {
> +		dev_err(dev, "Failed to init host: %d\n", ret);
> +		return ret;
> +	}
> +
> +	dw_pcie_setup_rc(&pcie->pci.pp);
> +	eswin_pcie_start_link(&pcie->pci);
> +	dw_pcie_wait_for_link(&pcie->pci);
> +
> +	pcie->suspended = false;
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops eswin_pcie_pm_ops = {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(eswin_pcie_suspend, eswin_pcie_resume)

Suggest adding "_noirq" to the end of these function names since this
sets .suspend_noirq, .resume_noirq, etc.  Also will match other drivers.

