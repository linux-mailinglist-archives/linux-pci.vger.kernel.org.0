Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436E2459497
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240267AbhKVSUp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:20:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4149 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhKVSUp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 13:20:45 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hyb7q00zQz6830n;
        Tue, 23 Nov 2021 02:16:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 22 Nov 2021 19:17:36 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 18:17:36 +0000
Date:   Mon, 22 Nov 2021 18:17:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 22/23] cxl/mem: Introduce cxl_mem driver
Message-ID: <20211122181734.00003c90@Huawei.com>
In-Reply-To: <20211120000250.1663391-23-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-23-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:49 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Add a driver that is capable of determining whether a device is in a
> CXL.mem routed part of the topology.
> 
> This driver allows a higher level driver - such as one controlling CXL
> regions, which is itself a set of CXL devices - to easily determine if
> the CXL devices are CXL.mem capable by checking if the driver has bound.
> CXL memory device services may also be provided by this driver though
> none are needed as of yet. cxl_mem also plays the part of registering
> itself as an endpoint port, which is a required step to enumerate the
> device's HDM decoder resources.
> 
> Even though cxl_mem driver is the only consumer of the new
> cxl_scan_ports() introduced in cxl_core, because that functionality has
> PCIe specificity it is kept out of this driver.
> 
> As part of this patch, find_dport_by_dev() is promoted to the cxl_core's
> set of APIs for use by the new driver.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
Main thing in here is the mysterious private data. I'd drop
that until we have patches that set it in the same series.




...

> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index acfa212eea21..cab3aabd5abc 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -8,6 +8,7 @@
>  #include <linux/idr.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
> +#include <pci.h>
>  #include "core.h"
>  
>  /**
> @@ -436,7 +437,7 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
>  
>  static struct cxl_port *cxl_port_alloc(struct device *uport,
>  				       resource_size_t component_reg_phys,
> -				       struct cxl_port *parent_port)
> +				       struct cxl_port *parent_port, void *data)
>  {
>  	struct cxl_port *port;
>  	struct device *dev;
> @@ -465,6 +466,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  
>  	port->uport = uport;
>  	port->component_reg_phys = component_reg_phys;
> +	port->data = data;
>  	ida_init(&port->decoder_ida);
>  	INIT_LIST_HEAD(&port->dports);
>  
> @@ -485,16 +487,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>   * @uport: "physical" device implementing this upstream port
>   * @component_reg_phys: (optional) for configurable cxl_port instances
>   * @parent_port: next hop up in the CXL memory decode hierarchy
> + * @data: opaque data to be used by the port driver
>   */
>  struct cxl_port *devm_cxl_add_port(struct device *uport,
>  				   resource_size_t component_reg_phys,
> -				   struct cxl_port *parent_port)
> +				   struct cxl_port *parent_port, void *data)
>  {
>  	struct device *dev, *host;
>  	struct cxl_port *port;
>  	int rc;
>  
> -	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
> +	port = cxl_port_alloc(uport, component_reg_phys, parent_port, data);
>  	if (IS_ERR(port))
>  		return port;
>  
> @@ -531,6 +534,113 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
>  


...

> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> new file mode 100644
> index 000000000000..818e30571e4d
> --- /dev/null
> +++ b/drivers/cxl/core/pci.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <cxl.h>
> +#include <pci.h>
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core pci
> + *
> + * Compute Express Link protocols are layered on top of PCIe. CXL core provides
> + * a set of helpers for CXL interactions which occur via PCIe.
> + */
> +
> +/**
> + * find_parent_cxl_port() - Finds parent port through PCIe mechanisms
> + * @pdev: PCIe USP or DSP to find an upstream port for
> + *
> + * Once all CXL ports are enumerated, there is no need to reference the PCIe
> + * parallel universe as all downstream ports are contained in a linked list, and
> + * all upstream ports are accessible via pointer. During the enumeration, it is
> + * very convenient to be able to peak up one level in the hierarchy without
> + * needing the established relationship between data structures so that the
> + * parenting can be done as the ports/dports are created.
> + *
> + * A reference is kept to the found port.
> + */
> +struct cxl_port *find_parent_cxl_port(struct pci_dev *pdev)
> +{
> +	struct device *parent_dev, *gparent_dev;
> +
> +	/* Parent is either a downstream port, or root port */
> +	parent_dev = get_device(pdev->dev.parent);
> +
> +	if (is_cxl_switch_usp(&pdev->dev)) {
> +		if (dev_WARN_ONCE(&pdev->dev,

maybe put the condition var in a local variable to reduce the indent and get something
more readable?

> +				  pci_pcie_type(pdev) !=
> +						  PCI_EXP_TYPE_DOWNSTREAM &&
> +					  pci_pcie_type(pdev) !=
> +						  PCI_EXP_TYPE_ROOT_PORT,
> +				  "Parent not downstream\n"))
> +			goto err;
> +
> +		/*
> +		 * Grandparent is either an upstream port or a platform device that has
> +		 * been added as a cxl_port already.
> +		 */
> +		gparent_dev = get_device(parent_dev->parent);
> +		put_device(parent_dev);
> +
> +		return to_cxl_port(gparent_dev);
> +	} else if (is_cxl_switch_dsp(&pdev->dev)) {
> +		if (dev_WARN_ONCE(&pdev->dev,
> +				  pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM,
> +				  "Parent not upstream"))
> +			goto err;
> +		return to_cxl_port(parent_dev);
> +	}
> +
> +err:
> +	dev_WARN(&pdev->dev, "Invalid topology\n");
> +	put_device(parent_dev);
> +	return NULL;
> +}
> +

...

> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f8354241c5a3..3bda806f4244 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -296,6 +296,7 @@ struct cxl_port {
>   * @port: reference to cxl_port that contains this downstream port
>   * @list: node for a cxl_port's list of cxl_dport instances
>   * @root_port_link: node for global list of root ports
> + * @data: Opaque data passed by other drivers, used by port driver

Is this used yet? possible leave introducing this until we need it
as not obvious here what it will be for.

>   */
>  struct cxl_dport {
>  	struct device *dport;
> @@ -304,16 +305,20 @@ struct cxl_dport {
>  	struct cxl_port *port;
>  	struct list_head list;
>  	struct list_head root_port_link;
> +	void *data;
>  };
>  
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct cxl_port *devm_cxl_add_port(struct device *uport,
>  				   resource_size_t component_reg_phys,
> -				   struct cxl_port *parent_port);
> +				   struct cxl_port *parent_port, void *data);
> +void cxl_scan_ports(struct cxl_dport *root_port);

...

> +
> +static int create_endpoint(struct device *dev, struct cxl_port *parent,
> +			   struct cxl_dport *dport)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_endpoint_dvsec_info *info = cxlds->info;
> +	struct cxl_port *endpoint;
> +	int rc;
> +
> +	endpoint =
> +		devm_cxl_add_port(dev, cxlds->component_reg_phys, parent, info);

I'd just have that on one line, or break it somewhere in the parameter list.
Right now it just looks odd and saves maybe 4 characters in line length.

> +	if (IS_ERR(endpoint))
> +		return PTR_ERR(endpoint);
> +
> +	rc = sysfs_create_link(&cxlmd->dev.kobj, &dport->dport->kobj,
> +			       "root_port");

Not obvious to me what this link is for.  Maybe needs a docs update
somewhere?

> +	if (rc) {
> +		device_del(&endpoint->dev);
> +		return rc;
> +	}
> +	dev_dbg(dev, "add: %s\n", dev_name(&endpoint->dev));
> +
> +	return devm_add_action_or_reset(dev, remove_endpoint, cxlmd);
> +}
> +
> +static int cxl_mem_probe(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_port *hostbridge, *parent_port;
> +	struct walk_ctx ctx = { NULL, false };

Perhaps use c99 style to show what is being initialized inside the walk ctx.
Will make it more obvious these are the right values.

> +	struct cxl_dport *dport;
> +	int rc;
> +
> +	rc = wait_for_media(cxlmd);
> +	if (rc) {
> +		dev_err(dev, "Media not active (%d)\n", rc);
> +		return rc;
> +	}
> +
> +	walk_to_root_port(dev, &ctx);
> +
> +	/*
> +	 * Couldn't find a CXL capable root port. This may happen even with a
> +	 * CXL capable topology if cxl_acpi hasn't completed yet. A rescan will
> +	 * occur.
> +	 */
> +	if (!ctx.root_port)
> +		return -ENODEV;
> +
> +	hostbridge = ctx.root_port->port;
> +	device_lock(&hostbridge->dev);
> +
> +	/* hostbridge has no port driver, the topology isn't enabled yet */
> +	if (!hostbridge->dev.driver) {
> +		device_unlock(&hostbridge->dev);
> +		return -ENODEV;
> +	}
> +
> +	/* No switch + found root port means we're done */
> +	if (!ctx.has_switch) {
> +		parent_port = to_cxl_port(&hostbridge->dev);
> +		dport = ctx.root_port;
> +		goto out;
> +	}
> +
> +	/* Walk down from the root port and add all switches */
> +	cxl_scan_ports(ctx.root_port);
> +
> +	/* If parent is a dport the endpoint is good to go. */
> +	parent_port = to_cxl_port(dev->parent->parent);
> +	dport = cxl_find_dport_by_dev(parent_port, dev->parent);
> +	if (!dport) {
> +		rc = -ENODEV;
> +		goto err_out;
> +	}
> +
> +out:
> +	rc = create_endpoint(dev, parent_port, dport);
> +	if (rc)
> +		goto err_out;
> +
> +	cxlmd->root_port = ctx.root_port;
> +
> +err_out:
> +	device_unlock(&hostbridge->dev);
> +	return rc;
> +}
> +

> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 2a48cd65bf59..3fd0909522f2 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -15,6 +15,7 @@
>  
>  /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>  #define CXL_DVSEC_PCIE_DEVICE					0
> +

Noise that shouldn't be in this patch.

>  #define   CXL_DVSEC_PCIE_DEVICE_CAP_OFFSET			0xA
>  #define     CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE			BIT(2)
>  #define     CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK		GENMASK(5, 4)
> @@ -64,4 +65,7 @@ enum cxl_regloc_type {
>  	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
>  			   (map)->block_offset))
>  
> +bool is_cxl_switch_usp(struct device *dev);
> +bool is_cxl_switch_dsp(struct device *dev);
> +
>  #endif /* __CXL_PCI_H__ */


