Return-Path: <linux-pci+bounces-35189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB5AB3D0E7
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 06:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D179B17FF3D
	for <lists+linux-pci@lfdr.de>; Sun, 31 Aug 2025 04:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C14202F65;
	Sun, 31 Aug 2025 04:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wyz8HRrC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225A26ACB;
	Sun, 31 Aug 2025 04:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756615518; cv=none; b=qUKDYgwVbKmX5YUmvtnQt9L6aEvA0kE4309B+QDnCi5yGFZs186IhPNpC1AEZDgzl8d0b/B/eOaE9uo1yfcsWBfgOXtslkOt6CCeG7RYg8AcwFyzPtMLzZ+11UvDCxvhe3kJz3CbQ9RXbcbfno6ByiesyE8al/YrCymEvoSN8PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756615518; c=relaxed/simple;
	bh=13DoiqS+hEeo3dzAq9zHOQntn0SH5PUF3J6lERbzZk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8dPYRvMt1lUeMiKFcArNP7F07DcCOFod36pgFbCteOFKEzyeaQHbSYHGuj4te5AGdHe4kCtoeOdEHguBsGVf8M1kSDeusSy1Cdok8RAXrXRZFmGnT5lkfrAbZlSD/0PHLbcGXN7ggpKr+7ElGe+8G0xLqt/GmC+du2c/eNrBXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wyz8HRrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C918C4CEED;
	Sun, 31 Aug 2025 04:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756615516;
	bh=13DoiqS+hEeo3dzAq9zHOQntn0SH5PUF3J6lERbzZk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wyz8HRrC2dZKmcv4CBJTsuOq64UVCQp6R4K3aBzyriTF6Aen8UPsKPAG/q1ds+5pl
	 ti1M6a/ew7xDLXJSp61zF/tX3Cs4tZrSUb1Ubns95mGZrl/cTq+MwBrQ28JQloc6uh
	 0TwQejdaoQzbRAa3oqW4V92sAB8JK967ipYZ7AuaRZxZC3AZymCjFx1wye6Rl8GVUV
	 4KzcpB3gcgPU01eFV3XfHCBJ05pZdBvsjJO7Pd84t7wIz6VRXMVYaVlz90SAX5MCL+
	 3Qw3xsmg1sKvShCbzeMouSd9VduuYiM5eA2Ql0l41Cr7Yu1mvH+E7Hu8gFnsFN8hPm
	 Qe2o2gtXbwnQQ==
Date: Sun, 31 Aug 2025 10:15:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de, bwawrzyn@cisco.com, 
	bhelgaas@google.com, unicorn_wang@outlook.com, conor+dt@kernel.org, 
	18255117159@163.com, inochiama@gmail.com, kishon@kernel.org, krzk+dt@kernel.org, 
	lpieralisi@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com, robh@kernel.org, 
	s-vadapalli@ti.com, tglx@linutronix.de, thomas.richard@bootlin.com, 
	sycamoremoon376@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, sophgo@lists.linux.dev, 
	rabenda.cn@gmail.com, chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, 
	fengchun.li@sophgo.com
Subject: Re: [PATCH 3/5] PCI: sg2042: Add Sophgo SG2042 PCIe driver
Message-ID: <xfu33ans5jaivwcadv6pjontvu5b4n42jjjtvqiqfhqxieoimg@2yaz75zsj7vf>
References: <cover.1756344464.git.unicorn_wang@outlook.com>
 <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1df25b33f0ea90a81c34c18cadedd38526a30f01.1756344464.git.unicorn_wang@outlook.com>

On Thu, Aug 28, 2025 at 10:17:40AM GMT, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add support for PCIe controller in SG2042 SoC. The controller
> uses the Cadence PCIe core programmed by pcie-cadence*.c. The
> PCIe controller will work in host mode only.
> 

Supported data rate, lanes etc...

> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pci/controller/cadence/Kconfig       |  12 ++
>  drivers/pci/controller/cadence/Makefile      |   1 +
>  drivers/pci/controller/cadence/pcie-sg2042.c | 134 +++++++++++++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pcie-sg2042.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 666e16b6367f..b1f1941d5208 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -42,6 +42,17 @@ config PCIE_CADENCE_PLAT_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_SG2042

PCIE_SG2042_HOST

> +	bool "Sophgo SG2042 PCIe controller (host mode)"

Since this driver doesn't implement irqchip, you should make it tristate and as
a module.

> +	depends on ARCH_SOPHGO || COMPILE_TEST
> +	depends on OF

	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)

> +	depends on PCI_MSI
> +	select PCIE_CADENCE_HOST
> +	help
> +	  Say Y here if you want to support the Sophgo SG2042 PCIe platform
> +	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
> +	  PCIe core.
> +
>  config PCI_J721E
>  	tristate
>  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> @@ -67,4 +78,5 @@ config PCI_J721E_EP
>  	  Say Y here if you want to support the TI J721E PCIe platform
>  	  controller in endpoint mode. TI J721E PCIe controller uses Cadence PCIe
>  	  core.
> +
>  endmenu
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 9bac5fb2f13d..4df4456d9539 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
> +obj-$(CONFIG_PCIE_SG2042) += pcie-sg2042.o
> diff --git a/drivers/pci/controller/cadence/pcie-sg2042.c b/drivers/pci/controller/cadence/pcie-sg2042.c
> new file mode 100644
> index 000000000000..fe434dc2967e
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pcie-sg2042.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pcie-sg2042 - PCIe controller driver for Sophgo SG2042 SoC
> + *
> + * Copyright (C) 2025 Sophgo Technology Inc.
> + * Copyright (C) 2025 Chen Wang <unicorn_wang@outlook.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "pcie-cadence.h"
> +
> +/*
> + * SG2042 only support 4-byte aligned access, so for the rootbus (i.e. to read
> + * the Root Port itself, read32 is required. For non-rootbus (i.e. to read
> + * the PCIe peripheral registers, supports 1/2/4 byte aligned access, so
> + * directly using read should be fine.
> + *
> + * The same is true for write.
> + */
> +static int sg2042_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +				   int where, int size, u32 *value)
> +{
> +	if (pci_is_root_bus(bus))
> +		return pci_generic_config_read32(bus, devfn, where, size,
> +						 value);
> +
> +	return pci_generic_config_read(bus, devfn, where, size, value);
> +}
> +
> +static int sg2042_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +				    int where, int size, u32 value)
> +{
> +	if (pci_is_root_bus(bus))
> +		return pci_generic_config_write32(bus, devfn, where, size,
> +						  value);
> +
> +	return pci_generic_config_write(bus, devfn, where, size, value);
> +}
> +
> +static struct pci_ops sg2042_pcie_host_ops = {
> +	.map_bus	= cdns_pci_map_bus,
> +	.read		= sg2042_pcie_config_read,
> +	.write		= sg2042_pcie_config_write,
> +};
> +
> +static int sg2042_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *pcie;
> +	struct cdns_pcie_rc *rc;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge) {
> +		dev_err(dev, "Failed to alloc host bridge!\n");

Use dev_err_probe() here and below.

> +		return -ENOMEM;
> +	}
> +
> +	bridge->ops = &sg2042_pcie_host_ops;
> +
> +	rc = pci_host_bridge_priv(bridge);
> +	pcie = &rc->pcie;

You are setting drvdata only below.

> +	pcie->dev = dev;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	pm_runtime_enable(dev);
> +
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed\n");
> +		goto err_get_sync;
> +	}
> +

Why do you need pm_runtime_get_sync()? DT binding doesn't provide a
power-domain, so you just need:

	pm_runtime_set_active()
        pm_runtime_no_callbacks()
        devm_pm_runtime_enable()

> +	ret = cdns_pcie_init_phy(dev, pcie);
> +	if (ret) {
> +		dev_err(dev, "Failed to init phy!\n");
> +		goto err_get_sync;
> +	}
> +
> +	ret = cdns_pcie_host_setup(rc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup host!\n");
> +		goto err_host_setup;
> +	}
> +
> +	return 0;
> +
> +err_host_setup:
> +	cdns_pcie_disable_phy(pcie);
> +
> +err_get_sync:
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);
> +
> +	return ret;
> +}
> +
> +static void sg2042_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct cdns_pcie *pcie = platform_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +
> +	cdns_pcie_disable_phy(pcie);
> +
> +	pm_runtime_put(dev);
> +	pm_runtime_disable(dev);

You don't need these as per my above suggestion.

> +}
> +
> +static const struct of_device_id sg2042_pcie_of_match[] = {
> +	{ .compatible = "sophgo,sg2042-pcie-host" },
> +	{},
> +};
> +
> +static struct platform_driver sg2042_pcie_driver = {
> +	.driver = {
> +		.name		= "sg2042-pcie",
> +		.of_match_table	= sg2042_pcie_of_match,
> +		.pm		= &cdns_pcie_pm_ops,
> +	},
> +	.probe		= sg2042_pcie_probe,

Why no remove()?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

