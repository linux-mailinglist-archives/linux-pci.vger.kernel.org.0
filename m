Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C4C30E5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 12:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbfJAKHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 06:07:33 -0400
Received: from foss.arm.com ([217.140.110.172]:45526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfJAKHd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Oct 2019 06:07:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40A861000;
        Tue,  1 Oct 2019 03:07:31 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 809C73F739;
        Tue,  1 Oct 2019 03:07:30 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:07:28 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Tom Joseph <tjoseph@cadence.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Message-ID: <20191001100727.GJ42880@e119886-lin.cambridge.arm.com>
References: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Tom,

Thanks for the patch.

I'd suggest that you rename the subject of this series to "PCI: cadence: ..."
to be consistent with the existing commit history, e.g. git log 
--oneline drivers/pci/controller/pcie-cadence* - you'll also see that you
don't need a full stop at the end, and you ought to also change the tense
of the subject, e.g. Refactor driver to ...

See comments inline...

On Mon, Sep 30, 2019 at 05:42:48PM +0100, Tom Joseph wrote:
> All the platform related APIs/Structures in the driver has been extracted
>  out to a separate file (pcie-cadence-plat.c). This will enable the
>  driver to be used as a core library, which could be used by other
>  platform drivers.Testing was done using simulation environment.

Also change the tense for this description.

This patch appears to take the dwc approach of spliting itself into consise
parts, such that you can have a generic Cadence driver, yet also leave room
and share functionality with/for Cadence derivatives - this seems like a
sensible approach. Though, as you'll see in my comments below, because there
are no other platform drivers yet - we end up with unused code and confusing
Kconfig options.

Is there an immediate plan to add another Cadence based controller? - if so
I'd suggest that you include this patch in that patchset for this new
controller. Otherwise I'm happy with these changes once the Kconfig and unused
code are fixed.

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
> @@ -48,6 +48,41 @@ config PCIE_CADENCE_EP
>  	  endpoint mode. This PCIe controller may be embedded into many
>  	  different vendors SoCs.
>  
> +config PCIE_CADENCE_PLAT
> +	bool "Cadence PCIe endpoint controller"
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

I find this too confusing, if I navigate to Cadence PCIe controllers support
in menuconfig I see these options:

Cadence PCIe host controller
Cadence PCIe endpoint controller
Cadence PCIe endpoint controller (NEW)
Cadence PCIe platform host controller (NEW)
Cadence PCIe platform endpoint controller (NEW)

I don't think users need to care about the platform/library support, surely
all they care about is enabling the EP or host bridge controllers for their
hardware (and then rely on Kconfig to select what is needed).

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

The style of this comment block is consistent with the other cadence files in
the tree, however the cadence files aren't consistent with the other PCI
controller drivers (or probably much of the kernel). I don't have any objections
with this, but ideally we'd eventually move to this:

+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe platform driver.
+ *
+ * Copyright (c) 2019 Cadence
+ *
+ * Author: Tom Joseph <tjoseph@cadence.com>
+ */

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

regmap? A leftover from pcie-designware-plat.c?

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

Given that these above two functions are only called through the
cdns_pcie_common_ops abstraction, they should be declared static.

I also don't understand why they are here in *this* patch -
cdns_plat_pcie_link_status isn't called anywhere, and even though
cdns_plat_pcie_link_control is called it doesn't do anything (start
is always true which makes me wonder if you'll ever get a caller
that sets it to false).

I'd suggest removing these two functions (and related logic) until
there is a user. This also makes reviewing the patch easier. 

> +
> +static const struct cdns_pcie_common_ops cdns_pcie_common_ops = {
> +	.cdns_start_link = cdns_plat_pcie_link_control,
> +	.cdns_is_link_up = cdns_plat_pcie_link_status,
> +};
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
> +
> +	match = of_match_device(cdns_plat_pcie_of_match, dev);
> +	if (!match)
> +		return -EINVAL;

Add a new line here.

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
> index ae6bf2a..3df902a 100644
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
>  /**
>   * struct cdns_pcie - private data for Cadence PCIe controller drivers
>   * @reg_base: IO mapped register base
> @@ -236,8 +243,67 @@ struct cdns_pcie {
>  	int			phy_count;
>  	struct phy		**phy;
>  	struct device_link	**link;
> +	const struct cdns_pcie_common_ops *ops;
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
> +	struct device		*dev;
> +	struct resource		*cfg_res;
> +	struct resource		*bus_range;
> +	void __iomem		*cfg_base;
> +	u32			max_regions;
> +	u32			no_bar_nbits;
> +	u16			vendor_id;
> +	u16			device_id;
>  };
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
> +	struct device		*dev;
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
>  /* Register access */
>  static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
>  {
> @@ -306,6 +372,9 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
>  }
>  
> +int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> +int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
> +

What happens if a user only selects the host bridge, will you get a build
error relating to cdns_plat_pcie_probe not being able to find an
implementation of cdns_pcie_ep_setup?

Thanks,

Andrew Murray

>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
>  				   u32 r, bool is_io,
>  				   u64 cpu_addr, u64 pci_addr, size_t size);
> -- 
> 2.2.2
> 
