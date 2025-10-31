Return-Path: <linux-pci+bounces-39909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AF5C24158
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 10:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A601895CEA
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A83330337;
	Fri, 31 Oct 2025 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9rVWi1a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70D52D9797;
	Fri, 31 Oct 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902126; cv=none; b=EZDqx6TQ8EbkfVPSaOOUTY8urweFYJJjkiY711aOEsuf68JlSW1c6psWvfx2qW5clSNKLml1KHqzZ/aIqkYNWuXDJNEdvMUVcEyJXq87kKE3mE4Ff63ZaNWjGuRuTU1BX0b9K3QS9pzTVeXa+2jTEU2ec6q/QG2Qad0uGBdf6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902126; c=relaxed/simple;
	bh=+hmMqtoS8YbRZ+0/PuP4BlhVpZ7H+6atpy+BXzuiMhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkJZIqSgwof6HlT2fLWzKycsZZTI0SR+AuYExzee3DGEzxjrhGoxybsK1o4lyDMbBh3I5rLusv94A+rZWR3kLB9b5Ovy5fLD7kLe1DozGdJIlfPI9HSrUHI//2VQiCVMduEmL1YwR/q+JsXekgvna4+IlvrlM9OfSoJgaY+bsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9rVWi1a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C2C4CEE7;
	Fri, 31 Oct 2025 09:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761902125;
	bh=+hmMqtoS8YbRZ+0/PuP4BlhVpZ7H+6atpy+BXzuiMhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9rVWi1aOcXKT6iG7hp8rKGUMJmEM5EOGDuxfdfO65dIB6Wys667ubMuXgQBafZ1o
	 x+RDjipU3+2tCWKTmtsiqknd4AGQoKIPwgUwXJD5IZUik5e2UEVb0VpqOzJokEPYag
	 rfq8HesPnFvtcb0zq19f3OW5TLqxEqz0UJPsv80DYVsp1er2ERtM9zTKG6/pBGw7GN
	 r7Ybn73WqaJgIyYJk7vZlljXAi/xxlndOCU//QegACX8jb3zMOXtVR/JvK6ck2/kfQ
	 apo8OyBdOI6aDtgnvSRcSoPIlidq6kXaeNpTKFUtTlr+4g3UBw+TNV1hUrXkkFM3g2
	 TFtCgXIRpfAQQ==
Date: Fri, 31 Oct 2025 14:45:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, helgaas@kernel.org, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/10] PCI: sky1: Add PCIe host support for CIX Sky1
Message-ID: <aoxdmg4mxa7j575vzjw66uo5i6ibvfkgkrqhy6bhwpie7v4rk7@yj5fmhplivxp>
References: <20251020042857.706786-1-hans.zhang@cixtech.com>
 <20251020042857.706786-8-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020042857.706786-8-hans.zhang@cixtech.com>

On Mon, Oct 20, 2025 at 12:28:54PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
> on the Cadence PCIe core.
> 
> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  drivers/pci/controller/cadence/Kconfig    |  15 ++
>  drivers/pci/controller/cadence/Makefile   |   1 +
>  drivers/pci/controller/cadence/pci-sky1.c | 233 ++++++++++++++++++++++
>  3 files changed, 249 insertions(+)
>  create mode 100644 drivers/pci/controller/cadence/pci-sky1.c
> 
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 0b96499ae354..ceff65934e5f 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -51,6 +51,21 @@ config PCIE_SG2042_HOST
>  	  controller in host mode. Sophgo SG2042 PCIe controller uses Cadence
>  	  PCIe core.
>  
> +config PCI_SKY1_HOST
> +	tristate "CIX SKY1 PCIe controller (host mode)"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCI_ECAM
> +	help
> +	  Say Y here if you want to support the CIX SKY1 PCIe platform
> +	  controller in host mode. CIX SKY1 PCIe controller uses Cadence
> +	  HPA (High Performance Architecture IP [Second generation of
> +	  Cadence PCIe IP])
> +
> +	  This driver requires Cadence PCIe core infrastructure
> +	  (PCIE_CADENCE_HOST) and hardware platform adaptation layer
> +	  to function.
> +
>  config PCI_J721E
>  	tristate
>  	select PCIE_CADENCE_HOST if PCI_J721E_HOST != n
> diff --git a/drivers/pci/controller/cadence/Makefile b/drivers/pci/controller/cadence/Makefile
> index 30189045a166..b8ec1cecfaa8 100644
> --- a/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep-mod.o
>  obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_J721E) += pci-j721e.o
>  obj-$(CONFIG_PCIE_SG2042_HOST) += pcie-sg2042.o
> +obj-$(CONFIG_PCI_SKY1_HOST) += pci-sky1.o
> diff --git a/drivers/pci/controller/cadence/pci-sky1.c b/drivers/pci/controller/cadence/pci-sky1.c
> new file mode 100644
> index 000000000000..4b0388394db3
> --- /dev/null
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller driver for CIX's sky1 SoCs
> + *
> + * Copyright 2025 Cix Technology Group Co., Ltd.
> + * Author: Hans Zhang <hans.zhang@cixtech.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ecam.h>
> +#include <linux/pci_ids.h>
> +
> +#include "pcie-cadence.h"
> +#include "pcie-cadence-host-common.h"
> +
> +#define STRAP_REG(n)			((n) * 0x04)
> +#define STATUS_REG(n)			((n) * 0x04)
> +#define LINK_TRAINING_ENABLE		BIT(0)
> +#define LINK_COMPLETE			BIT(0)
> +
> +#define SKY1_IP_REG_BANK		0x1000
> +#define SKY1_IP_CFG_CTRL_REG_BANK	0x4c00
> +#define SKY1_IP_AXI_MASTER_COMMON	0xf000
> +#define SKY1_AXI_SLAVE			0x9000
> +#define SKY1_AXI_MASTER			0xb000
> +#define SKY1_AXI_HLS_REGISTERS		0xc000
> +#define SKY1_AXI_RAS_REGISTERS		0xe000
> +#define SKY1_DTI_REGISTERS		0xd000
> +
> +#define IP_REG_I_DBG_STS_0		0x420
> +
> +struct sky1_pcie {
> +	struct cdns_pcie *cdns_pcie;
> +	struct cdns_pcie_rc *cdns_pcie_rc;
> +
> +	struct resource *cfg_res;
> +	struct resource *msg_res;
> +	struct pci_config_window *cfg;
> +	void __iomem *strap_base;
> +	void __iomem *status_base;
> +	void __iomem *reg_base;
> +	void __iomem *cfg_base;
> +	void __iomem *msg_base;
> +};
> +
> +static int sky1_pcie_resource_get(struct platform_device *pdev,
> +				  struct sky1_pcie *pcie)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *base;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "reg");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find \"reg\" registers\n");
> +	pcie->reg_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res)
> +		return dev_err_probe(dev, ENXIO, "unable to get \"cfg\" resource\n");

s/ENXIO/ENODEV

> +	pcie->cfg_res = res;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_strap");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find \"rcsu_strap\" registers\n");
> +	pcie->strap_base = base;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "rcsu_status");
> +	if (IS_ERR(base))
> +		return dev_err_probe(dev, PTR_ERR(base),
> +				     "unable to find \"rcsu_status\" registers\n");
> +	pcie->status_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
> +	if (!res)
> +		return dev_err_probe(dev, ENXIO, "unable to get \"msg\" resource\n");

s/ENXIO/ENODEV

> +	pcie->msg_res = res;
> +	pcie->msg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(pcie->msg_base)) {
> +		return dev_err_probe(dev, PTR_ERR(pcie->msg_base),
> +				     "unable to ioremap msg resource\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 val;
> +
> +	val = readl(pcie->strap_base + STRAP_REG(1));
> +	val |= LINK_TRAINING_ENABLE;
> +	writel(val, pcie->strap_base + STRAP_REG(1));
> +
> +	return 0;
> +}
> +
> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +	u32 val;
> +
> +	val = readl(pcie->strap_base + STRAP_REG(1));
> +	val &= ~LINK_TRAINING_ENABLE;
> +	writel(val, pcie->strap_base + STRAP_REG(1));
> +}
> +
> +static bool sky1_pcie_link_up(struct cdns_pcie *cdns_pcie)
> +{
> +	u32 val;
> +
> +	val = cdns_pcie_hpa_readl(cdns_pcie, REG_BANK_IP_REG,
> +				  IP_REG_I_DBG_STS_0);
> +	return val & LINK_COMPLETE;
> +}
> +
> +static const struct cdns_pcie_ops sky1_pcie_ops = {
> +	.start_link = sky1_pcie_start_link,
> +	.stop_link = sky1_pcie_stop_link,
> +	.link_up = sky1_pcie_link_up,
> +};
> +
> +static int sky1_pcie_probe(struct platform_device *pdev)
> +{
> +	struct cdns_plat_pcie_of_data *reg_off;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie *cdns_pcie;
> +	struct resource_entry *bus;
> +	struct cdns_pcie_rc *rc;
> +	struct sky1_pcie *pcie;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	ret = sky1_pcie_resource_get(pdev, pcie);
> +	if (ret < 0)
> +		return ret;
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
> +				    &pci_generic_ecam_ops);
> +	if (IS_ERR(pcie->cfg))
> +		return PTR_ERR(pcie->cfg);
> +
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	rc = pci_host_bridge_priv(bridge);
> +	rc->ecam_supported = 1;
> +	rc->cfg_base = pcie->cfg->win;
> +	rc->cfg_res = &pcie->cfg->res;
> +
> +	cdns_pcie = &rc->pcie;
> +	cdns_pcie->dev = dev;
> +	cdns_pcie->ops = &sky1_pcie_ops;
> +	cdns_pcie->reg_base = pcie->reg_base;
> +	cdns_pcie->msg_res = pcie->msg_res;
> +	cdns_pcie->is_rc = 1;
> +
> +	reg_off = devm_kzalloc(dev, sizeof(*reg_off), GFP_KERNEL);
> +	if (!reg_off)
> +		return -ENOMEM;
> +
> +	reg_off->ip_reg_bank_offset = SKY1_IP_REG_BANK;
> +	reg_off->ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK;
> +	reg_off->axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON;
> +	reg_off->axi_slave_offset = SKY1_AXI_SLAVE;
> +	reg_off->axi_master_offset = SKY1_AXI_MASTER;
> +	reg_off->axi_hls_offset = SKY1_AXI_HLS_REGISTERS;
> +	reg_off->axi_ras_offset = SKY1_AXI_RAS_REGISTERS;
> +	reg_off->axi_dti_offset = SKY1_DTI_REGISTERS;
> +	cdns_pcie->cdns_pcie_reg_offsets = reg_off;
> +
> +	pcie->cdns_pcie = cdns_pcie;
> +	pcie->cdns_pcie_rc = rc;
> +	pcie->cfg_base = rc->cfg_base;
> +	bridge->sysdata = pcie->cfg;
> +
> +	rc->vendor_id = PCI_VENDOR_ID_CIX;
> +	rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
> +	rc->no_inbound_map = 1;
> +
> +	dev_set_drvdata(dev, pcie);
> +
> +	ret = cdns_pcie_hpa_host_setup(rc);
> +	if (ret < 0) {
> +		pci_ecam_free(pcie->cfg);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id of_sky1_pcie_match[] = {
> +	{ .compatible = "cix,sky1-pcie-host", },
> +	{},
> +};

Missing MODULE_DEVICE_TABLE(). Your driver is not going to be auto loaded.

> +
> +static void sky1_pcie_remove(struct platform_device *pdev)
> +{
> +	struct sky1_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	pci_ecam_free(pcie->cfg);
> +}
> +
> +static struct platform_driver sky1_pcie_driver = {
> +	.probe  = sky1_pcie_probe,
> +	.remove = sky1_pcie_remove,
> +	.driver = {
> +		.name = "sky1-pcie",
> +		.of_match_table = of_sky1_pcie_match,

Use .probe_type = PROBE_PREFER_ASYNCHRONOUS.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

