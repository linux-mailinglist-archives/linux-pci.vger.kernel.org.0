Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA927DEBC1
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2019 14:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbfJUMNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Oct 2019 08:13:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:44422 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfJUMNo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Oct 2019 08:13:44 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9LCDaJN049847;
        Mon, 21 Oct 2019 07:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571660016;
        bh=t/jzw0ndkipNlpYMCFYStSeBG/mqSjcLVdKlPHXyoNE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U7eE/w/LSThiPni7eXdKEi/VIuKwfdI/anDA4eIr1kva7nf5r/zPePckvH+QKURj/
         zBFE/Lr2viUjVRpBCVMhjsFlaoii/ZhmJSG8tmAF1+AML8scoKMSlD6aCyUWx3MWJa
         4yCmmaFKTpwRZCbKUBzxNLVBeEMJDf5OXsfuEOiw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9LCDa5F121686
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Oct 2019 07:13:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 21
 Oct 2019 07:13:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 21 Oct 2019 07:13:35 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9LCDIGJ052849;
        Mon, 21 Oct 2019 07:13:19 -0500
Subject: Re: [PATCH v2] PCI: cadence: Refactor driver to use as a core library
To:     Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
References: <1571252912-7354-1-git-send-email-tjoseph@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3d1290b7-dce2-3dd6-3857-b4373f98700a@ti.com>
Date:   Mon, 21 Oct 2019 17:42:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1571252912-7354-1-git-send-email-tjoseph@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tom,

On 17/10/19 12:38 AM, Tom Joseph wrote:
> All the platform related APIs/Structures in the driver is extracted
>  out to a separate file (pcie-cadence-plat.c). This enables the
>  driver to be used as a core library, which could now be used by
>  other platform drivers. Testing done using simulation environment.

Bjorn has given a list of guidelines to follow while posting the patch. Please
see if you meet all of them for the change log.

https://lore.kernel.org/linux-pci/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com/
> 
> Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> ---
>  drivers/pci/controller/Kconfig             |  28 +++++
>  drivers/pci/controller/Makefile            |   1 +
>  drivers/pci/controller/pcie-cadence-ep.c   |  96 +---------------
>  drivers/pci/controller/pcie-cadence-host.c |  96 ++--------------
>  drivers/pci/controller/pcie-cadence-plat.c | 174 +++++++++++++++++++++++++++++
>  drivers/pci/controller/pcie-cadence.h      |  82 ++++++++++++++
>  6 files changed, 297 insertions(+), 180 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index fe9f9f1..cafbed0 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -48,6 +48,34 @@ config PCIE_CADENCE_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_CADENCE_PLAT
> +	bool
> +
> +config PCIE_CADENCE_PLAT_HOST
> +	bool "Cadence PCIe platform host controller"
> +	depends on OF
> +	depends on PCI
> +	select IRQ_DOMAIN
> +	select PCIE_CADENCE
> +	select PCIE_CADENCE_HOST
> +	select PCIE_CADENCE_PLAT
> +	help
> +	  Say Y here if you want to support the Cadence PCIe platform controller in
> +	  host mode. This PCIe controller may be embedded into many different
> +	  vendors SoCs.
> +
> +config PCIE_CADENCE_PLAT_EP
> +	bool "Cadence PCIe platform endpoint controller"
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE
> +	select PCIE_CADENCE_EP
> +	select PCIE_CADENCE_PLAT
> +	help
> +	  Say Y here if you want to support the Cadence PCIe  platform controller in
> +	  endpoint mode. This PCIe controller may be embedded into many
> +	  different vendors SoCs.
> +
>  endmenu
>  
>  config PCIE_XILINX_NWL
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index d56a507..676a41e 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
>  obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
>  obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
> +obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
>  obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
>  obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
>  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
> index def7820..1c173da 100644
> --- a/drivers/pci/controller/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/pcie-cadence-ep.c
> @@ -17,35 +17,6 @@
>  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
>  #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
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
>  static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
>  				     struct pci_epf_header *hdr)
>  {
> @@ -424,28 +395,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>  	.get_features	= cdns_pcie_ep_get_features,
>  };
>  
> -static const struct of_device_id cdns_pcie_ep_of_match[] = {
> -	{ .compatible = "cdns,cdns-pcie-ep" },
> -
> -	{ },
> -};
>  
> -static int cdns_pcie_ep_probe(struct platform_device *pdev)
> +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = ep->pcie.dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
> -	struct cdns_pcie_ep *ep;
> -	struct cdns_pcie *pcie;
> -	struct pci_epc *epc;
> +	struct cdns_pcie *pcie = &ep->pcie;
>  	struct resource *res;
> +	struct pci_epc *epc;
>  	int ret;
> -	int phy_count;
> -
> -	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> -	if (!ep)
> -		return -ENOMEM;
>  
> -	pcie = &ep->pcie;
>  	pcie->is_rc = false;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
> @@ -474,19 +434,6 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  	if (!ep->ob_addr)
>  		return -ENOMEM;
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
>  	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
>  
> @@ -528,38 +475,5 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>   err_init:
>  	pm_runtime_put_sync(dev);
>  
> - err_get_sync:
> -	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(pcie);
> -	phy_count = pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(pcie->link[phy_count]);
> -
>  	return ret;
>  }
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
> index 97e2510..5081908 100644
> --- a/drivers/pci/controller/pcie-cadence-host.c
> +++ b/drivers/pci/controller/pcie-cadence-host.c
> @@ -11,33 +11,6 @@
>  
>  #include "pcie-cadence.h"
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
>  static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
>  				      int where)
>  {
> @@ -92,11 +65,6 @@ static struct pci_ops cdns_pcie_host_ops = {
>  	.write		= pci_generic_config_write,
>  };
>  
> -static const struct of_device_id cdns_pcie_host_of_match[] = {
> -	{ .compatible = "cdns,cdns-pcie-host" },
> -
> -	{ },
> -};
>  
>  static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  {
> @@ -136,10 +104,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
>  static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  {
>  	struct cdns_pcie *pcie = &rc->pcie;
> -	struct resource *cfg_res = rc->cfg_res;
>  	struct resource *mem_res = pcie->mem_res;
>  	struct resource *bus_range = rc->bus_range;
> -	struct device *dev = rc->dev;
> +	struct resource *cfg_res = rc->cfg_res;
> +	struct device *dev = pcie->dev;
>  	struct device_node *np = dev->of_node;
>  	struct of_pci_range_parser parser;
>  	struct of_pci_range range;
> @@ -233,27 +201,22 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return err;
>  }
>  
> -static int cdns_pcie_host_probe(struct platform_device *pdev)
> +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = rc->pcie.dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
>  	struct list_head resources;
> -	struct cdns_pcie_rc *rc;
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
> -	int phy_count;
>  
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
> +	bridge = pci_host_bridge_from_priv(rc);
>  	if (!bridge)
>  		return -ENOMEM;
>  
> -	rc = pci_host_bridge_priv(bridge);
> -	rc->dev = dev;
> -
>  	pcie = &rc->pcie;
> -	pcie->is_rc = true;

is_rc can be left in host_setup.
>  
>  	rc->max_regions = 32;
>  	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
> @@ -287,21 +250,8 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  		dev_err(dev, "missing \"mem\"\n");
>  		return -EINVAL;
>  	}
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
>  	ret = cdns_pcie_host_init(dev, &resources, rc);
>  	if (ret)
> @@ -326,37 +276,5 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>   err_init:
>  	pm_runtime_put_sync(dev);
>  
> - err_get_sync:
> -	pm_runtime_disable(dev);
> -	cdns_pcie_disable_phy(pcie);
> -	phy_count = pcie->phy_count;
> -	while (phy_count--)
> -		device_link_del(pcie->link[phy_count]);
> -
>  	return ret;
>  }
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
> index ae6bf2a..62e9dcd 100644
> --- a/drivers/pci/controller/pcie-cadence.h
> +++ b/drivers/pci/controller/pcie-cadence.h
> @@ -190,6 +190,8 @@ enum cdns_pcie_rp_bar {
>  	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
>  #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
>  
> +struct cdns_pcie;
> +
>  enum cdns_pcie_msg_code {
>  	MSG_CODE_ASSERT_INTA	= 0x20,
>  	MSG_CODE_ASSERT_INTB	= 0x21,
> @@ -221,6 +223,11 @@ enum cdns_pcie_msg_routing {
>  	MSG_ROUTING_GATHER,
>  };
>  
> +
> +struct cdns_pcie_common_ops {
> +	int	(*cdns_start_link)(struct cdns_pcie *pcie, bool start);
> +	bool	(*cdns_is_link_up)(struct cdns_pcie *pcie);
> +};

This structure is defined here and not used anywhere. You could create a new
patch to add this structure and use it in cadence core.

Thanks
Kishon
