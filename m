Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E92355AAE
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347088AbhDFRrV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 6 Apr 2021 13:47:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2777 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347058AbhDFRrQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:47:16 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFFCq5K06z686vg;
        Wed,  7 Apr 2021 01:40:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:47:05 +0200
Received: from localhost (10.47.87.56) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 18:47:05 +0100
Date:   Tue, 6 Apr 2021 18:44:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ben.widawsky@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/8] cxl/port: Introduce cxl_port objects
Message-ID: <20210406184458.000061c0@Huawei.com>
In-Reply-To: <161728748083.2474040.753623311074560290.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
        <161728748083.2474040.753623311074560290.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.47.87.56]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Apr 2021 07:31:20 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Once the cxl_root is established then other ports in the hierarchy can
> be attached. The cxl_port object, unlike cxl_root that is associated
> with host bridges, is associated with PCIE Root Ports or PCIE Switch
> Ports. Add cxl_port instances for all PCIE Root Ports in an ACPI0016
> host bridge. The cxl_port instances for PCIE Switch Ports are not
> included here as those are to be modeled as another service device
> registered on the pcie_port_bus_type.

Good to give a bit of description of what port2 represents vs port1.

> 
> A sample sysfs topology for a single-host-bridge with
> single-PCIE/CXL-root-port:
> 
> /sys/bus/cxl/devices/root0
> ├── address_space0
> │   ├── devtype
> │   ├── end
> │   ├── start
> │   ├── supports_ram
> │   ├── supports_type2
> │   ├── supports_type3
> │   └── uevent
> ├── address_space1
> │   ├── devtype
> │   ├── end
> │   ├── start
> │   ├── supports_pmem
> │   ├── supports_type2
> │   ├── supports_type3
> │   └── uevent
> ├── devtype
> ├── port1
> │   ├── devtype
> │   ├── host -> ../../../../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
> │   ├── port2
> │   │   ├── devtype
> │   │   ├── host -> ../../../../../pci0000:34/0000:34:00.0
> │   │   ├── subsystem -> ../../../../../../bus/cxl
> │   │   ├── target_id
> │   │   └── uevent
> │   ├── subsystem -> ../../../../../bus/cxl
> │   ├── target_id
> │   └── uevent
> ├── subsystem -> ../../../../bus/cxl
> ├── target_id
> └── uevent
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c |   99 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core.c |  121 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h  |    5 ++
>  3 files changed, 224 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d54c2d5de730..bc2a35ae880b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -5,18 +5,117 @@
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
> +#include <linux/pci.h>
>  #include "cxl.h"
>  
> +static int match_ACPI0016(struct device *dev, const void *host)
> +{
> +	struct acpi_device *adev = to_acpi_device(dev);
> +	const char *hid = acpi_device_hid(adev);
> +
> +	return strcmp(hid, "ACPI0016") == 0;
> +}
> +
> +struct cxl_walk_context {
> +	struct device *dev;
> +	struct pci_bus *root;
> +	struct cxl_port *port;
> +	int error;
> +	int count;
> +};
> +
> +static int match_add_root_ports(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_walk_context *ctx = data;
> +	struct pci_bus *root_bus = ctx->root;
> +	struct cxl_port *port = ctx->port;
> +	int type = pci_pcie_type(pdev);
> +	struct device *dev = ctx->dev;
> +	resource_size_t cxl_regs_phys;
> +	int target_id = ctx->count;
> +
> +	if (pdev->bus != root_bus)
> +		return 0;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
> +	if (type != PCI_EXP_TYPE_ROOT_PORT)
> +		return 0;
> +
> +	ctx->count++;
> +
> +	/* TODO walk DVSEC to find component register base */
> +	cxl_regs_phys = -1;
> +
> +	port = devm_cxl_add_port(dev, port, &pdev->dev, target_id,
> +				 cxl_regs_phys);
> +	if (IS_ERR(port)) {
> +		ctx->error = PTR_ERR(port);
> +		return ctx->error;
> +	}
> +
> +	dev_dbg(dev, "%s: register: %s\n", dev_name(&pdev->dev),
> +		dev_name(&port->dev));
> +
> +	return 0;
> +}
> +
> +/*
> + * A host bridge may contain one or more root ports.  Register each port
> + * as a child of the cxl_root.
> + */
> +static int cxl_acpi_register_ports(struct device *dev, struct acpi_device *root,
> +				   struct cxl_port *port, int idx)
> +{
> +	struct acpi_pci_root *pci_root = acpi_pci_find_root(root->handle);
> +	struct cxl_walk_context ctx;
> +
> +	if (!pci_root)
> +		return -ENXIO;
> +
> +	/* TODO: fold in CEDT.CHBS retrieval */
> +	port = devm_cxl_add_port(dev, port, &root->dev, idx, ~0ULL);
> +	if (IS_ERR(port))
> +		return PTR_ERR(port);
> +	dev_dbg(dev, "%s: register: %s\n", dev_name(&root->dev),
> +		dev_name(&port->dev));
> +
> +	ctx = (struct cxl_walk_context) {
> +		.dev = dev,
> +		.root = pci_root->bus,
> +		.port = port,
> +	};
> +	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
> +
> +	if (ctx.count == 0)
> +		return -ENODEV;
> +	return ctx.error;
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	struct acpi_device *adev = ACPI_COMPANION(dev);
> +	struct device *bridge = NULL;
>  	struct cxl_root *cxl_root;
> +	int rc, i = 0;
>  
>  	cxl_root = devm_cxl_add_root(dev, NULL, 0);
>  	if (IS_ERR(cxl_root))
>  		return PTR_ERR(cxl_root);
>  	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));
>  
> +	while (true) {
> +		bridge = bus_find_device(adev->dev.bus, bridge, dev,
> +					 match_ACPI0016);
> +		if (!bridge)
> +			break;
> +
> +		rc = cxl_acpi_register_ports(dev, to_acpi_device(bridge),
> +					     &cxl_root->port, i++);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 46c3b2588d2f..65cd704581bc 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -148,6 +148,15 @@ static void cxl_root_release(struct device *dev)
>  	kfree(cxl_root);
>  }
>  
> +static void cxl_port_release(struct device *dev)
> +{
> +	struct cxl_port *port = to_cxl_port(dev);
> +
> +	ida_free(&cxl_port_ida, port->id);
> +	put_device(port->port_host);
> +	kfree(port);
> +}
> +
>  static ssize_t target_id_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
> @@ -178,6 +187,12 @@ static const struct device_type cxl_root_type = {
>  	.groups = cxl_port_attribute_groups,
>  };
>  
> +static const struct device_type cxl_port_type = {
> +	.name = "cxl_port",
> +	.release = cxl_port_release,
> +	.groups = cxl_port_attribute_groups,
> +};
> +
>  struct cxl_root *to_cxl_root(struct device *dev)
>  {
>  	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
> @@ -188,7 +203,9 @@ struct cxl_root *to_cxl_root(struct device *dev)
>  
>  struct cxl_port *to_cxl_port(struct device *dev)
>  {
> -	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
> +	if (dev_WARN_ONCE(dev,
> +			  dev->type != &cxl_root_type &&
> +			  dev->type != &cxl_port_type,
>  			  "not a cxl_port device\n"))
>  		return NULL;
>  	return container_of(dev, struct cxl_port, dev);
> @@ -360,6 +377,108 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
>  }
>  EXPORT_SYMBOL_GPL(devm_cxl_add_root);
>  
> +static void cxl_unlink_port(void *_port)
> +{
> +	struct cxl_port *port = _port;
> +
> +	sysfs_remove_link(&port->dev.kobj, "host");
> +}
> +
> +static int devm_cxl_link_port(struct device *dev, struct cxl_port *port)
> +{
> +	int rc;
> +
> +	rc = sysfs_create_link(&port->dev.kobj, &port->port_host->kobj, "host");
> +	if (rc)
> +		return rc;
> +	return devm_add_action_or_reset(dev, cxl_unlink_port, port);
> +}
> +
> +static struct cxl_port *cxl_port_alloc(struct cxl_port *parent_port,
> +				       struct device *port_dev, int target_id,
> +				       resource_size_t component_regs_phys)
> +{
> +	struct cxl_port *port;
> +	struct device *dev;
> +	int rc;
> +
> +	if (!port_dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
> +	if (!port)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
> +	if (rc < 0)
> +		goto err;
> +
> +	port->id = rc;
> +	port->target_id = target_id;
> +	port->port_host = get_device(port_dev);
> +	port->component_regs_phys = component_regs_phys;
> +
> +	dev = &port->dev;
> +	device_initialize(dev);
> +	device_set_pm_not_required(dev);
> +	dev->parent = &parent_port->dev;
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_port_type;
> +
> +	return port;
> +
> +err:
> +	kfree(port);
> +	return ERR_PTR(rc);
> +}
> +
> +/**
> + * devm_cxl_add_port() - add a cxl_port to the topology
> + * @host: devm context / discovery agent
> + * @parent_port: immediate ancestor towards cxl_root
> + * @port_host: PCI or platform-firmware device hosting this port
> + * @target_id: ordinal id relative to other siblings under @parent_port
> + * @component_regs_phys: CXL component register base address
> + */
> +struct cxl_port *devm_cxl_add_port(struct device *host,
> +				   struct cxl_port *parent_port,
> +				   struct device *port_host, int target_id,
> +				   resource_size_t component_regs_phys)
> +{
> +	struct cxl_port *port;
> +	struct device *dev;
> +	int rc;
> +
> +	port = cxl_port_alloc(parent_port, port_host, target_id,
> +			      component_regs_phys);
> +	if (IS_ERR(port))
> +		return port;
> +
> +	dev = &port->dev;
> +	rc = dev_set_name(dev, "port%d", port->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	rc = devm_add_action_or_reset(host, unregister_dev, dev);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	rc = devm_cxl_link_port(host, port);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return port;
> +
> +err:
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> +
>  /*
>   * cxl_setup_device_regs() - Detect CXL Device register blocks
>   * @dev: Host device of the @base mapping
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 559f8343fee4..0211f44c95a2 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -134,5 +134,10 @@ struct cxl_address_space_dev *to_cxl_address_space(struct device *dev);
>  struct cxl_root *devm_cxl_add_root(struct device *parent,
>  				   struct cxl_address_space *cxl_space,
>  				   int nr_spaces);
> +struct cxl_port *devm_cxl_add_port(struct device *host,
> +				   struct cxl_port *parent_port,
> +				   struct device *port_host, int target_id,
> +				   resource_size_t component_regs_phys);
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> 

