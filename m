Return-Path: <linux-pci+bounces-34085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D9B2722D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Aug 2025 00:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC3DA27F2A
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 22:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CFC283FF9;
	Thu, 14 Aug 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9x2wuff"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869EC283FF7;
	Thu, 14 Aug 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755211574; cv=none; b=ofO/sGch4bcMUHZG8eHdiGiTUiGyqA6znJC53HC8X0iwn3lmOIzwtRDYmVER0eyUblbNUNel6sl7FH+xxWxLo1ahRFQ+x0yoLIOJCEiBjBh4hZUPW9AVKp9068Rq7hCjqvJ1P+N/6ZAZdFOnOIsdMR9UV8HxSvbEff/To/GJzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755211574; c=relaxed/simple;
	bh=LO5dO58y+JUHnj8YM/c/NikBjdgMnHNzYEEzoDa0azo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UaLhwX8pvE2V7oO6UnTfafB79iUIrLidm5cir0INjOHX9FlszLZb8j743hjYY7r1LC+lalxILAVgpHIKWcmw06y+YVWQ8kwOlt8z4Gy/4M9+LiNTNDYG3ubuVNuMDTSyAIjs0ndH6E/v9soySASr1XXXVZ7yBoWFlEeJZtaIQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9x2wuff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2042C4CEED;
	Thu, 14 Aug 2025 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755211574;
	bh=LO5dO58y+JUHnj8YM/c/NikBjdgMnHNzYEEzoDa0azo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=D9x2wuffRFXgnoWlF6QJYXxbPmAvIU1k19RHkS/gY5yx0NxbieqG4FNXWoUBnZxR/
	 K/3Uz33OEU8KilsMnmm5jLT0s4No58t5YssNFaw20lOqtSSyCNbYco9Zif0licMEya
	 YznjjgcPv0NTd50ZZbRea7BbK5bNKkUOPSXSqvTPtI/w2G0ZRB9FgMHZheWLuonGEC
	 uExL9xpszcOuulEb5fx2k6y7OuatmY/x6lvXbUdK3pU1CcQocFWYEcf/JdS2WDDmC9
	 ph1UyiiaGRhmW6MlxYq+/7d43pMFhNiSNUFQuCbFd3AHdd0YTtkp3UmP7KMp8kckPe
	 Y6Hh568L67pXg==
Date: Thu, 14 Aug 2025 17:46:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mpillai@cadence.com,
	fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/13] PCI: sky1: Add PCIe host support for CIX Sky1
Message-ID: <20250814224612.GA352494@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-11-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:28PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Add driver for the CIX Sky1 SoC PCIe Gen4 16 GT/s controller based
> on the Cadence PCIe core.
> 
> Supports MSI/MSI-x via GICv3, Single Virtual Channel, Single Function.

> +config PCI_SKY1_HOST
> +	tristate "CIX SKY1 PCIe controller (host mode)"
> +	depends on OF
> +	select PCIE_CADENCE_HOST
> +	select PCI_ECAM
> +	help
> +	  Say Y here if you want to support the CIX SKY1 PCIe platform
> +	  controller in host mode. CIX SKY1 PCIe controller uses Cadence HPA(High
> +	  Performance Architecture IP[Second generation of cadence PCIe IP])
> +
> +	  This driver requires Cadence PCIe core infrastructure (PCIE_CADENCE_HOST)
> +	  and hardware platform adaptation layer to function.

Reorder so this menu entry appears in alphabetical order by vendor.

Add space in "HPA(..".

Add space in "IP[Second ..."

s/cadence PCIe IP/Cadence PCIe IP/

Rewrap so help text fits in 80 columns when displayed by menuconfig.

> +++ b/drivers/pci/controller/cadence/Makefile
> +++ b/drivers/pci/controller/cadence/pci-sky1.c
> @@ -0,0 +1,294 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller driver for CIX's sky1 SoCs
> + *
> + * Author: Hans Zhang <hans.zhang@cixtech.com>
> + */

The typical comment style, thank you :)

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
> +#define STRAP_REG(n) ((n) * 0x04)
> +#define STATUS_REG(n) ((n) * 0x04)
> +
> +#define RCSU_STRAP_REG 0x300
> +#define RCSU_STATUS_REG 0x400
> +
> +#define SKY1_IP_REG_BANK_OFFSET 0x1000
> +#define SKY1_IP_CFG_CTRL_REG_BANK_OFFSET 0x4c00
> +#define SKY1_IP_AXI_MASTER_COMMON_OFFSET 0xf000
> +#define SKY1_AXI_SLAVE_OFFSET 0x9000
> +#define SKY1_AXI_MASTER_OFFSET 0xb000
> +#define SKY1_AXI_HLS_REGISTERS_OFFSET 0xc000
> +#define SKY1_AXI_RAS_REGISTERS_OFFSET 0xe000
> +#define SKY1_DTI_REGISTERS_OFFSET 0xd000

Indent the values to line up.

Consider dropping "_OFFSET".

> +#define IP_REG_I_DBG_STS_0 0x420
> +
> +#define LINK_TRAINING_ENABLE BIT(0)
> +#define LINK_COMPLETE BIT(0)

Define next to the offset of the register that contains these.
Consider naming them to relate to the register.

> +enum cix_soc_type {
> +	CIX_SKY1,
> +};
> +
> +struct sky1_pcie_data {
> +	struct cdns_plat_pcie_of_data reg_off;

Weird name for this member.  cdns_plat_pcie_of_data contains more than
just offsets.

> +	enum cix_soc_type soc_type;
> +};
> +
> +struct sky1_pcie {
> +	struct device *dev;
> +	const struct sky1_pcie_data *data;
> +	struct cdns_pcie *cdns_pcie;

Typically first in the driver struct.  Also cdns_pcie already contains
a struct device *; do you need another?

> +	struct cdns_pcie_rc *cdns_pcie_rc;
> +
> +	struct resource *cfg_res;
> +	struct resource *msg_res;
> +	struct pci_config_window *cfg;
> +	void __iomem *rcsu_base;
> +	void __iomem *strap_base;
> +	void __iomem *status_base;
> +	void __iomem *reg_base;
> +	void __iomem *cfg_base;
> +	void __iomem *msg_base;
> +};
> +
> +static void sky1_pcie_clear_and_set_dword(void __iomem *addr, u32 clear,
> +					  u32 set)
> +{
> +	u32 val;
> +
> +	val = readl(addr);
> +	val &= ~clear;
> +	val |= set;
> +	writel(val, addr);

Nothing specific to sky1 here.  Find an existing interface or copy the
style of other drivers.  Surely other drivers do something similar,
but "git grep clear_and_set_dword drivers/pci/controller/" finds
nothing.

> +static int sky1_pcie_parse_mem(struct sky1_pcie *pcie)
> +{
> +	struct device *dev = pcie->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +	void __iomem *base;
> +	int ret = 0;
> +
> +	base = devm_platform_ioremap_resource_byname(pdev, "reg");
> +	if (IS_ERR(base)) {
> +		dev_err(dev, "Parse \"reg\" resource err\n");
> +		return PTR_ERR(base);
> +	}
> +	pcie->reg_base = base;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res) {
> +		dev_err(dev, "Parse \"cfg\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->cfg_res = res;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "rcsu");
> +	if (!res) {
> +		dev_err(dev, "Parse \"rcsu\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->rcsu_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!pcie->rcsu_base) {
> +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> +		return -ENOMEM;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "msg");
> +	if (!res) {
> +		dev_err(dev, "Parse \"msg\" resource err\n");
> +		return -ENXIO;
> +	}
> +	pcie->msg_res = res;
> +	pcie->msg_base = devm_ioremap(dev, res->start, resource_size(res));
> +	if (!pcie->msg_base) {
> +		dev_err(dev, "ioremap failed for resource %pR\n", res);
> +		return -ENOMEM;
> +	}
> +
> +	return ret;

"ret" is never used; remove it and just "return 0" here.

> +}
> +
> +static int sky1_pcie_parse_property(struct platform_device *pdev,
> +				    struct sky1_pcie *pcie)

Find a similar function in other drivers and copy the name.
"git grep parse_property drivers/pci/controller/" finds nothing.

> +{
> +	int ret = 0;
> +
> +	ret = sky1_pcie_parse_mem(pcie);
> +	if (ret < 0)
> +		return ret;
> +
> +	sky1_pcie_init_bases(pcie);
> +
> +	return ret;

Drop "ret" and return 0 here.

> +}
> +
> +static int sky1_pcie_start_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +
> +	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
> +				      0, LINK_TRAINING_ENABLE);
> +
> +	return 0;
> +}
> +
> +static void sky1_pcie_stop_link(struct cdns_pcie *cdns_pcie)
> +{
> +	struct sky1_pcie *pcie = dev_get_drvdata(cdns_pcie->dev);
> +
> +	sky1_pcie_clear_and_set_dword(pcie->strap_base + STRAP_REG(1),
> +				      LINK_TRAINING_ENABLE, 0);
> +}
> +
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
> +	const struct sky1_pcie_data *data;
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
> +	data = of_device_get_match_data(dev);
> +	if (!data)
> +		return -EINVAL;
> +
> +	pcie->data = data;
> +	pcie->dev = dev;
> +	dev_set_drvdata(dev, pcie);
> +
> +	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	if (!bridge)
> +		return -ENOMEM;
> +
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;

Maybe put this near the code that uses it instead of sticking the
unrelated sky1_pcie_parse_property() in the middle?

> +	ret = sky1_pcie_parse_property(pdev, pcie);
> +	if (ret < 0)
> +		return -ENXIO;
> +
> +	pcie->cfg = pci_ecam_create(dev, pcie->cfg_res, bus->res,
> +				    &pci_generic_ecam_ops);
> +	if (IS_ERR(pcie->cfg))
> +		return PTR_ERR(pcie->cfg);
> +
> +	bridge->ops = (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	rc = pci_host_bridge_priv(bridge);
> +	rc->ecam_support_flag = 1;
> +	rc->cfg_base = pcie->cfg->win;
> +	rc->cfg_res = &pcie->cfg->res;
> +
> +	cdns_pcie = &rc->pcie;
> +	cdns_pcie->dev = dev;
> +	cdns_pcie->ops = &sky1_pcie_ops;
> +	cdns_pcie->reg_base = pcie->reg_base;
> +	cdns_pcie->msg_res = pcie->msg_res;
> +	cdns_pcie->cdns_pcie_reg_offsets = &data->reg_off;
> +	cdns_pcie->is_rc = data->reg_off.is_rc;
> +
> +	pcie->cdns_pcie = cdns_pcie;
> +	pcie->cdns_pcie_rc = rc;
> +	pcie->cfg_base = rc->cfg_base;
> +	bridge->sysdata = pcie->cfg;
> +
> +	if (data->soc_type == CIX_SKY1) {
> +		rc->vendor_id = PCI_VENDOR_ID_CIX;
> +		rc->device_id = PCI_DEVICE_ID_CIX_SKY1;
> +		rc->no_inbound_flag = 1;
> +	}
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
> +static const struct sky1_pcie_data sky1_pcie_rc_data = {
> +	.reg_off = {
> +		.is_rc = true,
> +		.ip_reg_bank_offset = SKY1_IP_REG_BANK_OFFSET,
> +		.ip_cfg_ctrl_reg_offset = SKY1_IP_CFG_CTRL_REG_BANK_OFFSET,
> +		.axi_mstr_common_offset = SKY1_IP_AXI_MASTER_COMMON_OFFSET,
> +		.axi_slave_offset = SKY1_AXI_SLAVE_OFFSET,
> +		.axi_master_offset = SKY1_AXI_MASTER_OFFSET,
> +		.axi_hls_offset = SKY1_AXI_HLS_REGISTERS_OFFSET,
> +		.axi_ras_offset = SKY1_AXI_RAS_REGISTERS_OFFSET,
> +		.axi_dti_offset = SKY1_DTI_REGISTERS_OFFSET,
> +	},
> +	.soc_type = CIX_SKY1,
> +};
> +
> +static const struct of_device_id of_sky1_pcie_match[] = {
> +	{
> +		.compatible = "cix,sky1-pcie-host",
> +		.data = &sky1_pcie_rc_data,
> +	},
> +	{},
> +};
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
> +	},
> +};
> +module_platform_driver(sky1_pcie_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("PCIe controller driver for CIX's sky1 SoCs");
> +MODULE_AUTHOR("Hans Zhang <hans.zhang@cixtech.com>");
> -- 
> 2.49.0
> 

