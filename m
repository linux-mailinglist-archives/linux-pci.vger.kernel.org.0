Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1824A5C80
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238234AbiBAMpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 07:45:15 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4597 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238185AbiBAMpL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 07:45:11 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp4Px1hqDz67pKH;
        Tue,  1 Feb 2022 20:44:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 13:45:09 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 12:45:08 +0000
Date:   Tue, 1 Feb 2022 12:45:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 33/40] cxl/mem: Add the cxl_mem driver
Message-ID: <20220201124506.000031e2@Huawei.com>
In-Reply-To: <164316691403.3437657.5374419213236572727.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298429450.3018233.13269591903486669825.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164316691403.3437657.5374419213236572727.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jan 2022 19:16:05 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> At this point the subsystem can enumerate all CXL ports (CXL.mem decode
> resources in upstream switch ports and host bridges) in a system. The
> last mile is connecting those ports to endpoints.
> 
> The cxl_mem driver connects an endpoint device to the platform CXL.mem
> protoctol decode-topology. At ->probe() time it walks its
> device-topology-ancestry and adds a CXL Port object at every Upstream
> Port hop until it gets to CXL root. The CXL root object is only present
> after a platform firmware driver registers platform CXL resources. For
> ACPI based platform this is managed by the ACPI0017 device and the
> cxl_acpi driver.
> 
> The ports are registered such that disabling a given port automatically
> unregisters all descendant ports, and the chain can only be registered
> after the root is established.
> 
> Given ACPI device scanning may run asynchronously compared to PCI device
> scanning the root driver is tasked with rescanning the bus after the
> root successfully probes.
> 
> Conversely if any ports in a chain between the root and an endpoint
> becomes disconnected it subsequently triggers the endpoint to
> unregister. Given lock depenedencies the endpoint unregistration happens
> in a workqueue asynchronously. If userspace cares about synchronizing
> delayed work after port events the /sys/bus/cxl/flush attribute is
> available for that purpose.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: clarify changelog, rework hotplug support]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

A few comments inline.

Jonathan

> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7bd53dc691ec..df6691d0a6d0 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -314,7 +314,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc < 0)
>  		return rc;
>  
> -	return 0;
> +	/* In case PCI is scanned before ACPI re-trigger memdev attach */
> +	return cxl_bus_rescan();
>  }
>  
>  static const struct acpi_device_id cxl_acpi_ids[] = {
> @@ -335,3 +336,4 @@ module_platform_driver(cxl_acpi_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);
> +MODULE_SOFTDEP("pre: cxl_port");
I think a comment on 'why' would be useful for the SOFTDEP.

They are rare enough that it might surprise people.

> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1a50c0fc399c..efbaa851929d 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -6,6 +6,7 @@
>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> +extern const struct device_type cxl_memdev_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index b2773664e407..ee0156419d06 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -155,13 +155,19 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static const struct device_type cxl_memdev_type = {
> +const struct device_type cxl_memdev_type = {

Currently this is only exposed for type checking and you also have is_cxl_memdev for
that so seems a bit unnecessary.

>  	.name = "cxl_memdev",
>  	.release = cxl_memdev_release,
>  	.devnode = cxl_memdev_devnode,
>  	.groups = cxl_memdev_attribute_groups,
>  };
>  
> +bool is_cxl_memdev(struct device *dev)
> +{
> +	return dev->type == &cxl_memdev_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
> +
>  /**
>   * set_exclusive_cxl_commands() - atomically disable user cxl commands
>   * @cxlds: The device state to operate on
> @@ -213,6 +219,15 @@ static void cxl_memdev_unregister(void *_cxlmd)
>  	put_device(dev);
>  }
>  
> +static void detach_memdev(struct work_struct *work)
> +{
> +	struct cxl_memdev *cxlmd;
> +
> +	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
> +	device_release_driver(&cxlmd->dev);
> +	put_device(&cxlmd->dev);
> +}
> +
>  static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  					   const struct file_operations *fops)
>  {
> @@ -237,6 +252,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
>  	dev->type = &cxl_memdev_type;
>  	device_set_pm_not_required(dev);
> +	INIT_WORK(&cxlmd->detach_work, detach_memdev);
>  
>  	cdev = &cxlmd->cdev;
>  	cdev_init(cdev, fops);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index b61957636907..75a66540a795 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/workqueue.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -46,6 +47,8 @@ static int cxl_device_id(struct device *dev)
>  			return CXL_DEVICE_ROOT;
>  		return CXL_DEVICE_PORT;
>  	}
> +	if (dev->type == &cxl_memdev_type)

is_cxl_memdev() ?
Having dong that, is there any need to expose cxl_memdev_type?

> +		return CXL_DEVICE_MEMORY_EXPANDER;
>  	return 0;
>  }
>  
> @@ -320,8 +323,10 @@ static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port = _port;
>  
> -	if (!is_cxl_root(port))
> +	if (!is_cxl_root(port)) {
>  		device_lock_assert(port->dev.parent);
> +		port->uport = NULL;
> +	}
>  
>  	device_unregister(&port->dev);
>  }

...

> +static void delete_endpoint(void *data)
> +{
> +	struct cxl_memdev *cxlmd = data;
> +	struct cxl_port *endpoint = dev_get_drvdata(&cxlmd->dev);
> +	struct cxl_port *parent_port;
> +	struct device *parent;
> +
> +	parent_port = cxl_mem_find_port(cxlmd);
> +	if (!parent_port)
> +		return;
> +	parent = &parent_port->dev;
> +
> +	cxl_device_lock(parent);
> +	if (parent->driver && endpoint->uport) {
> +		devm_release_action(parent, cxl_unlink_uport, endpoint);
> +		devm_release_action(parent, unregister_port, endpoint);
> +	}
> +	cxl_device_unlock(parent);
> +	put_device(parent);
> +	put_device(&endpoint->dev);
> +}
> +
> +int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	struct device *dev = &cxlmd->dev;
> +
> +	get_device(&endpoint->dev);
> +	dev_set_drvdata(dev, endpoint);

That's a little nasty if it's just to provide
a second parameter to delete_endpoint, but I guess nothing else was using the drvdata..

> +	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);

...


> +static BUS_ATTR_WO(flush);
> +
>  static __init int cxl_core_init(void)
>  {
>  	int rc;
> @@ -1329,12 +1395,27 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		return rc;
>  
> +	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
> +	if (!cxl_bus_wq) {
> +		rc = -ENOMEM;
> +		goto err_wq;
> +	}
> +
>  	rc = bus_register(&cxl_bus_type);
>  	if (rc)
> -		goto err;
> +		goto err_bus;
> +
> +	rc = bus_create_file(&cxl_bus_type, &bus_attr_flush);

Can't we add this as part of the bus_type?  Always good to avoid
dynamic sysfs file creation if we possibly can.

> +	if (rc)
> +		goto err_flush;
> +
>  	return 0;
>  
> -err:
> +err_flush:
> +	bus_unregister(&cxl_bus_type);
> +err_bus:
> +	destroy_workqueue(cxl_bus_wq);
> +err_wq:
>  	cxl_memdev_exit();
>  	cxl_mbox_exit();
>  	return rc;
> @@ -1342,7 +1423,9 @@ static __init int cxl_core_init(void)
>  
>  static void cxl_core_exit(void)
>  {
> +	bus_remove_file(&cxl_bus_type, &bus_attr_flush);
>  	bus_unregister(&cxl_bus_type);
> +	destroy_workqueue(cxl_bus_wq);
>  	cxl_memdev_exit();
>  	cxl_mbox_exit();
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b71d40b68ccd..0bbe394f2f26 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -323,6 +323,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  struct cxl_port *find_cxl_root(struct device *dev);
>  int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
>  int cxl_bus_rescan(void);
> +struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);

Should be in previous patch where the function is defined.

> +bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>  

> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 0ba0cf8dcdbc..7ba0edb4a1ab 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -35,11 +35,14 @@
>   * @cdev: char dev core object for ioctl operations
>   * @cxlds: The device state backing this device
>   * @id: id number of this memdev instance.
> + * @detach_work: active memdev lost a port in its ancestry
> + * @component_reg_phys: register base of component registers

?

>   */
>  struct cxl_memdev {
>  	struct device dev;
>  	struct cdev cdev;
>  	struct cxl_dev_state *cxlds;
> +	struct work_struct detach_work;
>  	int id;
>  };
>  
> @@ -48,6 +51,12 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
>  	return container_of(dev, struct cxl_memdev, dev);
>  }
>  
> +bool is_cxl_memdev(struct device *dev);
> +static inline bool is_cxl_endpoint(struct cxl_port *port)
> +{
> +	return is_cxl_memdev(port->uport);
> +}
> +
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
>  
>  /**
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..27f9dd0d55b6
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "cxlmem.h"
> +#include "cxlpci.h"
> +
> +/**
> + * DOC: cxl mem
> + *
> + * CXL memory endpoint devices and switches are CXL capable devices that are
> + * participating in CXL.mem protocol. Their functionality builds on top of the
> + * CXL.io protocol that allows enumerating and configuring components via
> + * standard PCI mechanisms.
> + *
> + * The cxl_mem driver owns kicking off the enumeration of this CXL.mem
> + * capability. With the detection of a CXL capable endpoint, the driver will
> + * walk up to find the platform specific port it is connected to, and determine
> + * if there are intervening switches in the path. If there are switches, a
> + * secondary action to enumerate those (implemented in cxl_core).

action is to

> Finally the
> + * cxl_mem driver will add the device it is bound to as a CXL port for use in
> + * higher level operations.
> + */

...


> +
> +/**
> + * cxl_dvsec_decode_init() - Setup HDM decoding for the endpoint
> + * @cxlds: Device state
> + *
> + * Additionally, enables global HDM decoding. Warning: don't call this outside
> + * of probe. Once probe is complete, the port driver owns all access to the HDM
> + * decoder registers.
> + *
> + * Returns: false if DVSEC Ranges are being used instead of HDM decoders;
> + *	    otherwise returns true.

It feels like some of the paths below could reflect other problems
rather than an intention to use ranges.  Maybe this nees to have separate
error handling from detection of range register usage?

> + */
> +__mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
> +	struct cxl_register_map map;
> +	struct cxl_component_reg_map *cmap = &map.component_map;
> +	bool global_enable, do_hdm_init = false;
> +	void __iomem *crb;
> +	u32 global_ctrl;
> +
> +	/* map hdm decoder */
> +	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (!crb) {
> +		dev_dbg(cxlds->dev, "Failed to map component registers\n");
> +		return false;
> +	}
> +
> +	cxl_probe_component_regs(cxlds->dev, crb, cmap);
> +	if (!cmap->hdm_decoder.valid) {
> +		dev_dbg(cxlds->dev, "Invalid HDM decoder registers\n");
> +		goto out;
> +	}
> +
> +	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
> +			    CXL_HDM_DECODER_CTRL_OFFSET);
> +	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
> +	if (!global_enable && info->ranges) {
> +		dev_dbg(cxlds->dev, "DVSEC regions\n");

Perhaps worth adding a little more description to that.
Perhaps

"DVSEC ranges already programmed and HDM decoders not enabled."

> +		goto out;
> +	}
> +
> +	do_hdm_init = true;
> +
> +	/*
> +	 * Turn on global enable now since DVSEC ranges aren't being used and
> +	 * we'll eventually want the decoder enabled. This also prevents special
> +	 * casing in the port driver since this only applies to endpoints.

Possibly worth saying why it isn't worth turning this off again in the remove
path...

> +	 */
> +	if (!global_enable) {
> +		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
> +		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
> +		       crb + cmap->hdm_decoder.offset +
> +			       CXL_HDM_DECODER_CTRL_OFFSET);
> +	}
> +
> +out:
> +	iounmap(crb);
> +	return do_hdm_init;
> +}
> +

> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
> +MODULE_SOFTDEP("pre: cxl_port");

As above, a 'why' comment for the softdep would be a good to have.

> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ae94a537eccc..27ab7f8d122e 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -25,16 +25,27 @@
>   * PCIe topology.
>   */
>  
> +static void schedule_detach(void *cxlmd)
> +{
> +	schedule_cxl_memdev_detach(cxlmd);
> +}
> +
>  static int cxl_port_probe(struct device *dev)
>  {
>  	struct cxl_port *port = to_cxl_port(dev);
>  	struct cxl_hdm *cxlhdm;
>  	int rc;
>  
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> +
> +		get_device(&cxlmd->dev);
> +		return devm_add_action_or_reset(dev, schedule_detach, cxlmd);
> +	}
> +
>  	rc = devm_cxl_port_enumerate_dports(port);
>  	if (rc < 0)
>  		return rc;
> -

Reasonable to drop this, but not in this patch.


>  	if (rc == 1)
>  		return devm_cxl_add_passthrough_decoder(port);
>  

