Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B46114006
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 12:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfLELXA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 06:23:00 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59334 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfLELXA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Dec 2019 06:23:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xB5BMrKQ053740;
        Thu, 5 Dec 2019 05:22:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1575544973;
        bh=3tVpuY2xuEGxVRJ+a9CQUdis1aK6W2KNOKi7xSgqDdc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=abjl8yzb5LqIPVNDpTbRX3lozxyJwu2kOPjF7QaJ91AH0NL1Cp8i2NNK+L1L80rE0
         5W6XlFaUse0N5i9+8gw5kukbV3alC/4s86GnQ+85eTRWKMRGZpF3tX82WhvRWAh4pV
         HU2L3yMUI5C0tfVKP7jGgJK1xN+dYhAEonBFswvU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xB5BMruZ044010
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Dec 2019 05:22:53 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Dec
 2019 05:22:53 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Dec 2019 05:22:52 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xB5BMoFl032458;
        Thu, 5 Dec 2019 05:22:51 -0600
Subject: Re: [PATCH v3 1/2] PCI: cadence: Refactor driver to use as a core
 library
To:     Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
References: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
 <1572349512-7776-2-git-send-email-tjoseph@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d86efb5d-6524-216e-fb61-701cc5211137@ti.com>
Date:   Thu, 5 Dec 2019 16:54:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1572349512-7776-2-git-send-email-tjoseph@cadence.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tom,

On 29/10/19 5:15 pm, Tom Joseph wrote:
> Cadence PCIe host and endpoint IP may be embedded into a variety of
> SoCs/platforms. Let's extract the platform related APIs/Structures in the
> current driver to a separate file (pcie-cadence-plat.c), such that the
> common functionality can be used by future platforms.
> 
> Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> ---
>   drivers/pci/controller/Kconfig             |  31 +++--
>   drivers/pci/controller/Makefile            |   1 +
>   drivers/pci/controller/pcie-cadence-ep.c   |  96 +---------------
>   drivers/pci/controller/pcie-cadence-host.c |  95 ++--------------
>   drivers/pci/controller/pcie-cadence-plat.c | 174 +++++++++++++++++++++++++++++
>   drivers/pci/controller/pcie-cadence.h      |  77 +++++++++++++
>   6 files changed, 287 insertions(+), 187 deletions(-)
>   create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
>
.
.
<snip>
.
.> diff --git a/drivers/pci/controller/pcie-cadence-ep.c 
b/drivers/pci/controller/pcie-cadence-ep.c
> index def7820..1c173da 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -17,35 +17,6 @@
>   #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
>   #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
>   
> -/**
> - * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
> - * @pcie: Cadence PCIe controller
> - * @max_regions: maximum number of regions supported by hardware
> - * @ob_region_map: bitmask of mapped outbound regions
> - * @ob_addr: base addresses in the AXI bus where the outbound regions start
> - * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
> - *		   dedicated outbound regions is mapped.
> - * @irq_cpu_addr: base address in the CPU space where a write access triggers
> - *		  the sending of a memory write (MSI) / normal message (legacy
> - *		  IRQ) TLP through the PCIe bus.
> - * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
> - *		  dedicated outbound region.
> - * @irq_pci_fn: the latest PCI function that has updated the mapping of
> - *		the MSI/legacy IRQ dedicated outbound region.
> - * @irq_pending: bitmask of asserted legacy IRQs.
> - */
> -struct cdns_pcie_ep {
> -	struct cdns_pcie		pcie;
> -	u32				max_regions;
> -	unsigned long			ob_region_map;
> -	phys_addr_t			*ob_addr;
> -	phys_addr_t			irq_phys_addr;
> -	void __iomem			*irq_cpu_addr;
> -	u64				irq_pci_addr;
> -	u8				irq_pci_fn;
> -	u8				irq_pending;
> -};
> -
>   static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
>   				     struct pci_epf_header *hdr)
>   {
> @@ -424,28 +395,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>   	.get_features	= cdns_pcie_ep_get_features,
>   };
>   
> -static const struct of_device_id cdns_pcie_ep_of_match[] = {
> -	{ .compatible = "cdns,cdns-pcie-ep" },
> -
> -	{ },
> -};
>   
> -static int cdns_pcie_ep_probe(struct platform_device *pdev)
> +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>   {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = ep->pcie.dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>   	struct device_node *np = dev->of_node;
> -	struct cdns_pcie_ep *ep;
> -	struct cdns_pcie *pcie;
> -	struct pci_epc *epc;
> +	struct cdns_pcie *pcie = &ep->pcie;
>   	struct resource *res;
> +	struct pci_epc *epc;
>   	int ret;
> -	int phy_count;
> -
> -	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> -	if (!ep)
> -		return -ENOMEM;
>   
> -	pcie = &ep->pcie;
>   	pcie->is_rc = false;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> @@ -474,19 +434,6 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>   	if (!ep->ob_addr)
>   		return -ENOMEM;
>   
> -	ret = cdns_pcie_init_phy(dev, pcie);
> -	if (ret) {
> -		dev_err(dev, "failed to init phy\n");
> -		return ret;
> -	}
> -	platform_set_drvdata(pdev, pcie);
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> -		goto err_get_sync;
> -	}
> -
>   	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
>   	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
>   
> @@ -528,38 +475,5 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>    err_init:
>   	pm_runtime_put_sync(dev);

put_sync shouldn't be there. Please fix the error handling.
>   
> - err_get_sync:
> -	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(pcie);
> -	phy_count = pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(pcie->link[phy_count]);
> -
>   	return ret;
>   }
> -
> -static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = pm_runtime_put_sync(dev);
> -	if (ret < 0)
> -		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> -
> -	pm_runtime_disable(dev);
> -
> -	cdns_pcie_disable_phy(pcie);
> -}
> -
> -static struct platform_driver cdns_pcie_ep_driver = {
> -	.driver = {
> -		.name = "cdns-pcie-ep",
> -		.of_match_table = cdns_pcie_ep_of_match,
> -		.pm	= &cdns_pcie_pm_ops,
> -	},
> -	.probe = cdns_pcie_ep_probe,
> -	.shutdown = cdns_pcie_ep_shutdown,
> -};
> -builtin_platform_driver(cdns_pcie_ep_driver);
> diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
> index 97e2510..8a42afd 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -11,33 +11,6 @@
>   
>   #include "pcie-cadence.h"
>   
> -/**
> - * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
> - * @pcie: Cadence PCIe controller
> - * @dev: pointer to PCIe device
> - * @cfg_res: start/end offsets in the physical system memory to map PCI
> - *           configuration space accesses
> - * @bus_range: first/last buses behind the PCIe host controller
> - * @cfg_base: IO mapped window to access the PCI configuration space of a
> - *            single function at a time
> - * @max_regions: maximum number of regions supported by the hardware
> - * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
> - *                translation (nbits sets into the "no BAR match" register)
> - * @vendor_id: PCI vendor ID
> - * @device_id: PCI device ID
> - */
> -struct cdns_pcie_rc {
> -	struct cdns_pcie	pcie;
> -	struct device		*dev;
> -	struct resource		*cfg_res;
> -	struct resource		*bus_range;
> -	void __iomem		*cfg_base;
> -	u32			max_regions;
> -	u32			no_bar_nbits;
> -	u16			vendor_id;
> -	u16			device_id;
> -};
> -
>   static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>   				      int where)
>   {
> @@ -92,11 +65,6 @@ static struct pci_ops cdns_pcie_host_ops = {
>   	.write		= pci_generic_config_write,
>   };
>   
> -static const struct of_device_id cdns_pcie_host_of_match[] = {
> -	{ .compatible = "cdns,cdns-pcie-host" },
> -
> -	{ },
> -};
>   
>   static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>   {
> @@ -136,10 +104,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>   static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>   {
>   	struct cdns_pcie *pcie = &rc->pcie;
> -	struct resource *cfg_res = rc->cfg_res;
>   	struct resource *mem_res = pcie->mem_res;
>   	struct resource *bus_range = rc->bus_range;
> -	struct device *dev = rc->dev;
> +	struct resource *cfg_res = rc->cfg_res;
> +	struct device *dev = pcie->dev;
>   	struct device_node *np = dev->of_node;
>   	struct of_pci_range_parser parser;
>   	struct of_pci_range range;
> @@ -233,25 +201,21 @@ static int cdns_pcie_host_init(struct device *dev,
>   	return err;
>   }
>   
> -static int cdns_pcie_host_probe(struct platform_device *pdev)
> +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>   {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = rc->pcie.dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>   	struct device_node *np = dev->of_node;
>   	struct pci_host_bridge *bridge;
>   	struct list_head resources;
> -	struct cdns_pcie_rc *rc;
>   	struct cdns_pcie *pcie;
>   	struct resource *res;
>   	int ret;
> -	int phy_count;
>   
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	bridge = pci_host_bridge_from_priv(rc);
>   	if (!bridge)
>   		return -ENOMEM;
>   
> -	rc = pci_host_bridge_priv(bridge);
> -	rc->dev = dev;
> -
>   	pcie = &rc->pcie;
>   	pcie->is_rc = true;
>   
> @@ -287,21 +251,8 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>   		dev_err(dev, "missing \"mem\"\n");
>   		return -EINVAL;
>   	}
> -	pcie->mem_res = res;
>   
> -	ret = cdns_pcie_init_phy(dev, pcie);
> -	if (ret) {
> -		dev_err(dev, "failed to init phy\n");
> -		return ret;
> -	}
> -	platform_set_drvdata(pdev, pcie);
> -
> -	pm_runtime_enable(dev);
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync() failed\n");
> -		goto err_get_sync;
> -	}
> +	pcie->mem_res = res;
>   
>   	ret = cdns_pcie_host_init(dev, &resources, rc);
>   	if (ret)
> @@ -326,37 +277,5 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>    err_init:
>   	pm_runtime_put_sync(dev);
>   
> - err_get_sync:
> -	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(pcie);
> -	phy_count = pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(pcie->link[phy_count]);
> -
>   	return ret;
>   }
> -
> -static void cdns_pcie_shutdown(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> -	int ret;
> -
> -	ret = pm_runtime_put_sync(dev);
> -	if (ret < 0)
> -		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> -
> -	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(pcie);
> -}
> -
> -static struct platform_driver cdns_pcie_host_driver = {
> -	.driver = {
> -		.name = "cdns-pcie-host",
> -		.of_match_table = cdns_pcie_host_of_match,
> -		.pm	= &cdns_pcie_pm_ops,
> -	},
> -	.probe = cdns_pcie_host_probe,
> -	.shutdown = cdns_pcie_shutdown,
> -};
> -builtin_platform_driver(cdns_pcie_host_driver);
> diff --git a/drivers/pci/controller/pcie-cadence-plat.c b/drivers/pci/controller/pcie-cadence-plat.c
> new file mode 100644
> index 0000000..f5c6bf6
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-cadence-plat.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCIe platform  driver.
> + *
> + * Copyright (c) 2019, Cadence Design Systems
> + * Author: Tom Joseph <tjoseph@cadence.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/of_address.h>
> +#include <linux/of_pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/of_device.h>
> +#include "pcie-cadence.h"
> +
> +/**
> + * struct cdns_plat_pcie - private data for this PCIe platform driver
> + * @pcie: Cadence PCIe controller
> + * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
> + *         if 0 it is in Endpoint mode.
> + */
> +struct cdns_plat_pcie {
> +	struct cdns_pcie        *pcie;
> +	bool is_rc;
> +};
> +
> +struct cdns_plat_pcie_of_data {
> +	bool is_rc;
> +};
> +
> +static const struct of_device_id cdns_plat_pcie_of_match[];
> +
> +static int cdns_plat_pcie_probe(struct platform_device *pdev)
> +{
> +	const struct cdns_plat_pcie_of_data *data;
> +	struct cdns_plat_pcie *cdns_plat_pcie;
> +	const struct of_device_id *match;
> +	struct device *dev = &pdev->dev;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie_ep *ep;
> +	struct cdns_pcie_rc *rc;
> +	int phy_count;
> +	bool is_rc;
> +	int ret;
> +
> +	match = of_match_device(cdns_plat_pcie_of_match, dev);
> +	if (!match)
> +		return -EINVAL;
> +
> +	data = (struct cdns_plat_pcie_of_data *)match->data;
> +	is_rc = data->is_rc;
> +
> +	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
> +	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
> +	if (!cdns_plat_pcie)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, cdns_plat_pcie);
> +	if (is_rc) {
> +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
> +			return -ENODEV;
> +
> +		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +		if (!bridge)
> +			return -ENOMEM;
> +
> +		rc = pci_host_bridge_priv(bridge);
> +		rc->pcie.dev = dev;
> +		cdns_plat_pcie->pcie = &rc->pcie;
> +		cdns_plat_pcie->is_rc = is_rc;
> +
> +		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		if (ret) {
> +			dev_err(dev, "failed to init phy\n");
> +			return ret;
> +		}
> +		pm_runtime_enable(dev);
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "pm_runtime_get_sync() failed\n");
> +			goto err_get_sync;
> +		}
> +
> +		ret = cdns_pcie_host_setup(rc);
> +		if (ret)
> +			goto err_init;
> +	} else {
> +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
> +			return -ENODEV;
> +
> +		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +		if (!ep)
> +			return -ENOMEM;
> +
> +		ep->pcie.dev = dev;
> +		cdns_plat_pcie->pcie = &ep->pcie;
> +		cdns_plat_pcie->is_rc = is_rc;
> +
> +		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
> +		if (ret) {
> +			dev_err(dev, "failed to init phy\n");
> +			return ret;
> +		}
> +
> +		pm_runtime_enable(dev);
> +		ret = pm_runtime_get_sync(dev);
> +		if (ret < 0) {
> +			dev_err(dev, "pm_runtime_get_sync() failed\n");
> +			goto err_get_sync;
> +		}
> +
> +		ret = cdns_pcie_ep_setup(ep);
> +		if (ret)
> +			goto err_init;
> +	}
> +
> + err_init:
> +	pm_runtime_put_sync(dev);
> +
> + err_get_sync:
> +	pm_runtime_disable(dev);
> +	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
> +	phy_count = cdns_plat_pcie->pcie->phy_count;
> +	while (phy_count--)
> +		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> +
> +	return 0;
> +}
> +
> +static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cdns_pcie *pcie = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_put_sync(dev);
> +	if (ret < 0)
> +		dev_dbg(dev, "pm_runtime_put_sync failed\n");
> +
> +	pm_runtime_disable(dev);
> +
> +	cdns_pcie_disable_phy(pcie);
> +}
> +
> +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
> +	.is_rc = true,
> +};
> +
> +static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
> +	.is_rc = false,
> +};
> +
> +static const struct of_device_id cdns_plat_pcie_of_match[] = {
> +	{
> +		.compatible = "cdns,cdns-pcie-host",
> +		.data = &cdns_plat_pcie_host_of_data,
> +	},
> +	{
> +		.compatible = "cdns,cdns-pcie-ep",
> +		.data = &cdns_plat_pcie_ep_of_data,
> +	},
> +	{},
> +};
> +
> +static struct platform_driver cdns_plat_pcie_driver = {
> +	.driver = {
> +		.name = "cdns-pcie",
> +		.of_match_table = cdns_plat_pcie_of_match,
> +		.pm	= &cdns_pcie_pm_ops,
> +	},
> +	.probe = cdns_plat_pcie_probe,
> +	.shutdown = cdns_plat_pcie_shutdown,
> +};
> +builtin_platform_driver(cdns_plat_pcie_driver);
> diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
> index ae6bf2a..c98e858 100644
> --- a/drivers/pci/controller/pcie-cadence.h
> +++ b/drivers/pci/controller/pcie-cadence.h
> @@ -190,6 +190,8 @@ enum cdns_pcie_rp_bar {
>   	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
>   #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
>   
> +struct cdns_pcie;
> +
>   enum cdns_pcie_msg_code {
>   	MSG_CODE_ASSERT_INTA	= 0x20,
>   	MSG_CODE_ASSERT_INTB	= 0x21,
> @@ -231,13 +233,71 @@ enum cdns_pcie_msg_routing {
>   struct cdns_pcie {
>   	void __iomem		*reg_base;
>   	struct resource		*mem_res;
> +	struct device		*dev;
>   	bool			is_rc;
>   	u8			bus;
>   	int			phy_count;
>   	struct phy		**phy;
>   	struct device_link	**link;
> +	const struct cdns_pcie_common_ops *ops;

Where is cdns_pcie_common_ops defined?

> +};
> +
> +/**
> + * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
> + * @pcie: Cadence PCIe controller
> + * @dev: pointer to PCIe device
> + * @cfg_res: start/end offsets in the physical system memory to map PCI
> + *           configuration space accesses
> + * @bus_range: first/last buses behind the PCIe host controller
> + * @cfg_base: IO mapped window to access the PCI configuration space of a
> + *            single function at a time
> + * @max_regions: maximum number of regions supported by the hardware
> + * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
> + *                translation (nbits sets into the "no BAR match" register)
> + * @vendor_id: PCI vendor ID
> + * @device_id: PCI device ID
> + */
> +struct cdns_pcie_rc {
> +	struct cdns_pcie	pcie;
> +	struct resource		*cfg_res;
> +	struct resource		*bus_range;
> +	void __iomem		*cfg_base;
> +	u32			max_regions;
> +	u32			no_bar_nbits;
> +	u16			vendor_id;
> +	u16			device_id;
>   };
>   
> +/**
> + * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
> + * @pcie: Cadence PCIe controller
> + * @max_regions: maximum number of regions supported by hardware
> + * @ob_region_map: bitmask of mapped outbound regions
> + * @ob_addr: base addresses in the AXI bus where the outbound regions start
> + * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
> + *		   dedicated outbound regions is mapped.
> + * @irq_cpu_addr: base address in the CPU space where a write access triggers
> + *		  the sending of a memory write (MSI) / normal message (legacy
> + *		  IRQ) TLP through the PCIe bus.
> + * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
> + *		  dedicated outbound region.
> + * @irq_pci_fn: the latest PCI function that has updated the mapping of
> + *		the MSI/legacy IRQ dedicated outbound region.
> + * @irq_pending: bitmask of asserted legacy IRQs.
> + */
> +struct cdns_pcie_ep {
> +	struct cdns_pcie	pcie;
> +	u32			max_regions;
> +	unsigned long		ob_region_map;
> +	phys_addr_t		*ob_addr;
> +	phys_addr_t		irq_phys_addr;
> +	void __iomem		*irq_cpu_addr;
> +	u64			irq_pci_addr;
> +	u8			irq_pci_fn;
> +	u8			irq_pending;
> +};
> +
> +
>   /* Register access */
>   static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>   {
> @@ -306,6 +366,23 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>   	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
>   }
>   
> +#ifdef CONFIG_PCIE_CADENCE_HOST
> +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> +#else
> +static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
> +{
> +	return 0;
> +}
> +#endif
> +
> +#ifdef CONFIG_PCIE_CADENCE_EP
> +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
> +#else
> +static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
> +{
> +	return 0;
> +}
> +#endif
>   void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
>   				   u32 r, bool is_io,
>   				   u64 cpu_addr, u64 pci_addr, size_t size);
> 
