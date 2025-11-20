Return-Path: <linux-pci+bounces-41788-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3311DC74376
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D405F35F5E5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807551D63C2;
	Thu, 20 Nov 2025 13:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Yoi1UCE7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3272.qiye.163.com (mail-m3272.qiye.163.com [220.197.32.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F12A311C19;
	Thu, 20 Nov 2025 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644796; cv=none; b=J1o+HS4OqF6Xb0QxOaXFVwSnozpRMtW4jUxlSIVhYgASGf6gHb6wq+VXHuuGisgGQC2giqehRZ7fM8NEIXEsfJleQTnNRV9+u4OdLSDZj3MGSafCjtfsfcWZmccjxaIqXBBoxUPJk4GZrBAdPw/Hd+Pf/+wa3lgyIEXdogoTGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644796; c=relaxed/simple;
	bh=iUMbLAPrjP480ydUowJ7bKUOwZN9eVa8czUdcsi3HtM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a68PEkdNxXev80smsBamC8TLBLERpuWhwgcW0N84q3hrY8n76CEdAQoWWynnfTN4k+Egv5oK9mXboexQ2PoDm8bLBpbOnoi4wK5GZCmF7IkUmWp5Fa16mmBf8WEy+C0v6sQAeM7EFsmO2h6XcwY01OQbAF/vIhDMZhiRrcimDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Yoi1UCE7; arc=none smtp.client-ip=220.197.32.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2a4cf8468;
	Thu, 20 Nov 2025 21:19:42 +0800 (GMT+08:00)
Message-ID: <d3cb2c6b-5f96-4e2e-9f72-97643e607faa@rock-chips.com>
Date: Thu, 20 Nov 2025 21:19:40 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, ningyu@eswincomputing.com,
 linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com,
 ouyanghui@eswincomputing.com, Frank.li@nxp.com
Subject: Re: [PATCH v6 2/3] PCI: eic7700: Add Eswin PCIe host controller
 driver
To: zhangsenchuan@eswincomputing.com, bhelgaas@google.com, mani@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, robh@kernel.org, p.zabel@pengutronix.de,
 jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, christian.bruel@foss.st.com,
 mayank.rana@oss.qualcomm.com, shradha.t@samsung.com,
 krishna.chundru@oss.qualcomm.com, thippeswamy.havalige@amd.com,
 inochiama@gmail.com
References: <20251120101018.1477-1-zhangsenchuan@eswincomputing.com>
 <20251120101206.1518-1-zhangsenchuan@eswincomputing.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251120101206.1518-1-zhangsenchuan@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aa16bb58209cckunm5b2ab42e18634d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxpKHVZCSEwYHR0aH0gfQ0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Yoi1UCE74Oj2XUIVkBqL1mLqRC6jzIjKOSIitHHdP0xgmlHg4fKCu4JkG4lc6BDLe3tUFoQJ9XsvvSjyKcQRnB/QjkSIhAfybPFGvEjk2xQM6xNn2ruJo7vgHN64VJBPu7QTZG6XQ7kQ1eU2sVaszp5eQVF0qWiYb7ZgNEwdpeM=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=7vui1XoQ19GQrPp1R5SZ2ruvrERMeSpaAjE3J0dNNnI=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/20 星期四 18:12, zhangsenchuan@eswincomputing.com 写道:
> From: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> 
> Add driver for the Eswin EIC7700 PCIe host controller, which is based on
> the DesignWare PCIe core, IP revision 6.00a. The PCIe Gen.3 controller
> supports a data rate of 8 GT/s and 4 channels, support INTx and MSI
> interrupts.
> 

Don't need any stuff regarding to PHY in the driver?

> Signed-off-by: Yu Ning <ningyu@eswincomputing.com>
> Signed-off-by: Yanghui Ou <ouyanghui@eswincomputing.com>
> Signed-off-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
> ---
>   drivers/pci/controller/dwc/Kconfig        |  11 +
>   drivers/pci/controller/dwc/Makefile       |   1 +
>   drivers/pci/controller/dwc/pcie-eic7700.c | 387 ++++++++++++++++++++++
>   3 files changed, 399 insertions(+)
>   create mode 100644 drivers/pci/controller/dwc/pcie-eic7700.c
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 349d4657393c..66568efb324f 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -93,6 +93,17 @@ config PCIE_BT1
>   	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
>   	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
>   
> +config PCIE_EIC7700
> +	bool "Eswin EIC7700 PCIe controller"
> +	depends on ARCH_ESWIN || COMPILE_TEST
> +	depends on PCI_MSI
> +	select PCIE_DW_HOST
> +	help
> +	  Say Y here if you want PCIe controller support for the Eswin EIC7700.
> +	  The PCIe controller on EIC7700 is based on DesignWare hardware,
> +	  enables support for the PCIe controller in the EIC7700 SoC to work in
> +	  host mode.
> +
>   config PCI_IMX6
>   	bool
>   
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7ae28f3b0fb3..04f751c49eba 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>   obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>   obj-$(CONFIG_PCIE_AMD_MDB) += pcie-amd-mdb.o
>   obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
> +obj-$(CONFIG_PCIE_EIC7700) += pcie-eic7700.o
>   obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>   obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>   obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
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

It would be better to be moved to pci_ids.h ?

> +
> +#define EIC7700_NUM_RSTS		ARRAY_SIZE(eic7700_pcie_rsts)

If using devm_reset_control_array_get_exclusive, you don't need this
at all.

> +
> +static const char * const eic7700_pcie_rsts[] = {
> +	"pwr",
> +	"dbi",
> +};
> +

Ditto.

> +struct eic7700_pcie_data {
> +	bool msix_cap;
> +	bool no_suspport_L2;
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

dw_pcie_readl_dbi()?

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

dw_pcie_get_resources() knows it.

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
> +	},
> +};
> +builtin_platform_driver(eic7700_pcie_driver);
> +
> +MODULE_DESCRIPTION("Eswin EIC7700 PCIe host controller driver");
> +MODULE_AUTHOR("Yu Ning <ningyu@eswincomputing.com>");
> +MODULE_AUTHOR("Senchuan Zhang <zhangsenchuan@eswincomputing.com>");
> +MODULE_AUTHOR("Yanghui Ou <ouyanghui@eswincomputing.com>");
> +MODULE_LICENSE("GPL");


