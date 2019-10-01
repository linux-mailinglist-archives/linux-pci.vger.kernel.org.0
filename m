Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46205C3231
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 13:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfJALQM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 07:16:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46796 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 07:16:11 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x91BG362092103;
        Tue, 1 Oct 2019 06:16:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569928563;
        bh=xj+DS1yydlYyagADhn9JrSZy8o8s7GOJDwL0x7UJZkE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lfMqis4j1Aab2InpaXBrG516LNvIukgUOTy9yT7dKZbq5rWdVs0Uhisqc9ElrQxQy
         VlDZsT8tfiG4l8OoISWXQ7EdfLWpY2BeCPNzGt480syk6evXjebzN8j4hGMKdWSlyU
         Cio66wf5HEnF7lX4ANODOgCzNaMmH2H7s3VeDrdI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x91BG3Eg115405
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Oct 2019 06:16:03 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 1 Oct
 2019 06:16:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 1 Oct 2019 06:15:53 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x91BG1bT094851;
        Tue, 1 Oct 2019 06:16:01 -0500
Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core library.
To:     Tom Joseph <tjoseph@cadence.com>, <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>
References: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <03a8af4b-96bb-48b6-a79b-7db3a2ee59d0@ti.com>
Date:   Tue, 1 Oct 2019 16:45:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tom,

On 30/09/19 10:12 PM, Tom Joseph wrote:
> All the platform related APIs/Structures in the driver has been extracted
>  out to a separate file (pcie-cadence-plat.c). This will enable the
>  driver to be used as a core library, which could be used by other
>  platform drivers.Testing was done using simulation environment.
> 
> Signed-off-by: Tom Joseph <tjoseph@cadence.com>
> ---
>  drivers/pci/controller/Kconfig             |  35 +++++++
>  drivers/pci/controller/Makefile            |   1 +
>  drivers/pci/controller/pcie-cadence-ep.c   |  78 ++-------------
>  drivers/pci/controller/pcie-cadence-host.c |  77 +++------------
>  drivers/pci/controller/pcie-cadence-plat.c | 154 +++++++++++++++++++++++++++++
>  drivers/pci/controller/pcie-cadence.h      |  69 +++++++++++++
>  6 files changed, 278 insertions(+), 136 deletions(-)
>  create mode 100644 drivers/pci/controller/pcie-cadence-plat.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index fe9f9f1..c175b21 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig

Please create a new directory for cadence, so that it gets easier to add driver
support for new platforms using Cadence IP.
> @@ -48,6 +48,41 @@ config PCIE_CADENCE_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_CADENCE_PLAT
> +	bool "Cadence PCIe endpoint controller"

"Cadence PCIe endpoint platform controller".. however remove the string as this
doesn't have to be visible to the user.
> +	depends on OF
> +	depends on PCI_ENDPOINT
> +	select PCIE_CADENCE
> +	help
> +	  Say Y here if you want to support the Cadence PCIe  controller in
> +	  endpoint mode. This PCIe controller may be embedded into many
> +	  different vendors SoCs.
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
> index def7820..617a71f 100644
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
> @@ -396,6 +367,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  		cfg |= BIT(epf->func_no);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
>  
> +	if (pcie->ops->cdns_start_link)
> +		return  pcie->ops->cdns_start_link(pcie, true);
> +

Please add only the refactoring code in this patch. Additional features should
be added as a separate patch.
>  	return 0;
>  }
>  
> @@ -424,30 +398,18 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
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
> +	struct device *dev = ep->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
> -	struct cdns_pcie_ep *ep;
> -	struct cdns_pcie *pcie;
> +	struct cdns_pcie *pcie = &ep->pcie;

Though the coding style has moved away from inverse XMAS tree declarations, but
I would prefer that wherever possible.
>  	struct pci_epc *epc;
>  	struct resource *res;
>  	int ret;
>  	int phy_count;
>  
> -	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> -	if (!ep)
> -		return -ENOMEM;
> -
> -	pcie = &ep->pcie;
> -	pcie->is_rc = false;

is_rc declaration could be left here.
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
>  	pcie->reg_base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(pcie->reg_base)) {
> @@ -537,29 +499,3 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
>  
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

You've left pm_runtime_enable() in pcie-cadence-ep.c but moved
pm_runtime_disable() to pcie-cadence-plat.c. Both should be in the same file.
I'd prefer those are handled in platform driver. Same is applicable for PHYs too.
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
> index 97e2510..55c2085 100644
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
> @@ -233,27 +201,23 @@ static int cdns_pcie_host_init(struct device *dev,
>  	return err;
>  }
>  
> -static int cdns_pcie_host_probe(struct platform_device *pdev)
> +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
> -	struct device *dev = &pdev->dev;
> +	struct device *dev = rc->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	struct pci_host_bridge *bridge;
>  	struct list_head resources;
> -	struct cdns_pcie_rc *rc;
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
>  	int phy_count;
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
>  
>  	rc->max_regions = 32;
>  	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
> @@ -303,6 +267,14 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  		goto err_get_sync;
>  	}
>  
> +	if (pcie->ops->cdns_start_link) {
> +		ret =  pcie->ops->cdns_start_link(pcie, true);
> +		if (ret) {
> +			dev_err(dev, "Failed to start link\n");
> +			return ret;
> +		}
> +	}

Add this as a separate patch.
> +
>  	ret = cdns_pcie_host_init(dev, &resources, rc);
>  	if (ret)
>  		goto err_init;
> @@ -335,28 +307,3 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
>  
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
> index 0000000..274615d
> --- /dev/null
> +++ b/drivers/pci/controller/pcie-cadence-plat.c
> @@ -0,0 +1,154 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2019 Cadence
> +// Cadence PCIe platform  driver.
> +// Author: Tom Joseph <tjoseph@cadence.com>
> +
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
> + * @regmap: pointer to PCIe device
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
> +int cdns_plat_pcie_link_control(struct cdns_pcie *pcie, bool start)
> +{
> +	pr_debug(" %s called\n", __func__);
> +	return 0;
> +}
> +
> +bool cdns_plat_pcie_link_status(struct cdns_pcie *pcie)
> +{
> +	pr_debug(" %s called\n", __func__);
> +	return 0;
> +}
> +
> +static const struct cdns_pcie_common_ops cdns_pcie_common_ops = {
> +	.cdns_start_link = cdns_plat_pcie_link_control,
> +	.cdns_is_link_up = cdns_plat_pcie_link_status,
> +};

Add these ops as a different patch.
> +
> +static int cdns_plat_pcie_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cdns_plat_pcie *cdns_plat_pcie;
> +	const struct of_device_id *match;
> +	const struct cdns_plat_pcie_of_data *data;
> +	struct pci_host_bridge *bridge;
> +	struct cdns_pcie_rc *rc;
> +	struct cdns_pcie_ep *ep;
> +	int ret;
> +	bool is_rc;

I'd prefer reverse XMAS tree declarations in any new functions.
> +
> +	match = of_match_device(cdns_plat_pcie_of_match, dev);
> +	if (!match)
> +		return -EINVAL;
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
> +		rc->dev = dev;
> +		rc->pcie.ops = &cdns_pcie_common_ops;
> +		cdns_plat_pcie->pcie = &rc->pcie;
> +		cdns_plat_pcie->is_rc = is_rc;
> +
> +		ret = cdns_pcie_host_setup(rc);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
> +			return -ENODEV;
> +
> +		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
> +		if (!ep)
> +			return -ENOMEM;
> +		ep->dev = dev;
> +		ep->pcie.ops = &cdns_pcie_common_ops;
> +		cdns_plat_pcie->pcie = &ep->pcie;
> +		cdns_plat_pcie->is_rc = is_rc;
> +
> +		ret = cdns_pcie_ep_setup(ep);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
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
I'd prefer you can add a different compatible for Cadence platform and leave
"cdns,cdns-pcie-host" for the IP.

Thanks
Kishon
