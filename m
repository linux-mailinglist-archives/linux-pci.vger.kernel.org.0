Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5E561B21
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 15:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbiF3NRe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 09:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234805AbiF3NR3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 09:17:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BE922B2E;
        Thu, 30 Jun 2022 06:17:27 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYf2F0lw5z6H7sm;
        Thu, 30 Jun 2022 21:15:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 15:17:24 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 14:17:23 +0100
Date:   Thu, 30 Jun 2022 14:17:21 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 34/46] cxl/region: Add region creation support
Message-ID: <20220630141721.00005dce@Huawei.com>
In-Reply-To: <20220624041950.559155-9-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-9-dan.j.williams@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 21:19:38 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <bwidawsk@kernel.org>
> 
> CXL 2.0 allows for dynamic provisioning of new memory regions (system
> physical address resources like "System RAM" and "Persistent Memory").
> Whereas DDR and PMEM resources are conveyed statically at boot, CXL
> allows for assembling and instantiating new regions from the available
> capacity of CXL memory expanders in the system.
> 
> Sysfs with an "echo $region_name > $create_region_attribute" interface
> is chosen as the mechanism to initiate the provisioning process. This
> was chosen over ioctl() and netlink() to keep the configuration
> interface entirely in a pseudo-fs interface, and it was chosen over
> configfs since, aside from this one creation event, the interface is
> read-mostly. I.e. configfs supports cases where an object is designed to
> be provisioned each boot, like an iSCSI storage target, and CXL region
> creation is mostly for PMEM regions which are created usually once
> per-lifetime of a server instance.
> 
> Recall that the major change that CXL brings over previous
> persistent memory architectures is the ability to dynamically define new
> regions.  Compare that to drivers like 'nfit' where the region
> configuration is statically defined by platform firmware.
> 
> Regions are created as a child of a root decoder that encompasses an
> address space with constraints. When created through sysfs, the root
> decoder is explicit. When created from an LSA's region structure a root
> decoder will possibly need to be inferred by the driver.
> 
> Upon region creation through sysfs, a vacant region is created with a
> unique name. Regions have a number of attributes that must be configured
> before the region can be bound to the driver where HDM decoder program
> is completed.
> 
> An example of creating a new region:
> 
> - Allocate a new region name:
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)
> 
> - Create a new region by name:
> while
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_pmem_region)

Perhaps it is worth calling out the region ID allocator is shared
with nvdimms and other usecases.  I'm not really sure what the advantage
in doing that is, but it doesn't do any real harm.

> ! echo $region > /sys/bus/cxl/devices/decoder0.0/create_pmem_region
> do true; done
> 
> - Region now exists in sysfs:
> stat -t /sys/bus/cxl/devices/decoder0.0/$region
> 
> - Delete the region, and name:
> echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
> 
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> [djbw: simplify locking, reword changelog]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  25 +++
>  .../driver-api/cxl/memory-devices.rst         |  11 +
>  drivers/cxl/Kconfig                           |   5 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/core.h                       |  12 ++
>  drivers/cxl/core/port.c                       |  39 +++-
>  drivers/cxl/core/region.c                     | 199 ++++++++++++++++++
>  drivers/cxl/cxl.h                             |  18 ++
>  tools/testing/cxl/Kbuild                      |   1 +
>  9 files changed, 308 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/cxl/core/region.c
> 

...


> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 472ec9cb1018..ebe6197fb9b8 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -9,6 +9,18 @@ extern const struct device_type cxl_nvdimm_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +#ifdef CONFIG_CXL_REGION
> +extern struct device_attribute dev_attr_create_pmem_region;
> +extern struct device_attribute dev_attr_delete_region;
> +/*
> + * Note must be used at the end of an attribute list, since it
> + * terminates the list in the CONFIG_CXL_REGION=n case.

That's rather ugly.  Maybe just push the ifdef down into the c file
where we will be shortening the list and it should be obvious what is
going on without needing the comment?  Much as I don't like ifdef
magic in the c files, it sometimes ends up cleaner.

> + */
> +#define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
> +#else
> +#define CXL_REGION_ATTR(x) NULL
> +#endif
> +
>  struct cxl_send_command;
>  struct cxl_mem_query_commands;
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2e56903399c2..c9207ebc3f32 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/memregion.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
>  #include <linux/device.h>
> @@ -300,11 +301,35 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_cap_type2.attr,
>  	&dev_attr_cap_type3.attr,
>  	&dev_attr_target_list.attr,
> +	CXL_REGION_ATTR(create_pmem_region),
> +	CXL_REGION_ATTR(delete_region),
>  	NULL,
>  };

>  
>  static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
> @@ -387,6 +412,7 @@ static void cxl_root_decoder_release(struct device *dev)
>  {
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
>  
> +	memregion_free(atomic_read(&cxlrd->region_id));
>  	__cxl_decoder_release(&cxlrd->cxlsd.cxld);
>  	kfree(cxlrd);
>  }
> @@ -1415,6 +1441,7 @@ static struct lock_class_key cxl_decoder_key;
>  static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  					     unsigned int nr_targets)
>  {
> +	struct cxl_root_decoder *cxlrd = NULL;
>  	struct cxl_decoder *cxld;
>  	struct device *dev;
>  	void *alloc;
> @@ -1425,16 +1452,20 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  
>  	if (nr_targets) {
>  		struct cxl_switch_decoder *cxlsd;
> -		struct cxl_root_decoder *cxlrd;
>  
>  		if (is_cxl_root(port)) {
>  			alloc = kzalloc(struct_size(cxlrd, cxlsd.target,
>  						    nr_targets),
>  					GFP_KERNEL);
>  			cxlrd = alloc;
> -			if (cxlrd)
> +			if (cxlrd) {
>  				cxlsd = &cxlrd->cxlsd;
> -			else
> +				atomic_set(&cxlrd->region_id, -1);
> +				rc = memregion_alloc(GFP_KERNEL);
> +				if (rc < 0)
> +					goto err;

Leaving region_id set to -1 seems interesting for ever
recovering from this error.  Perhaps a comment on how the magic
value is used.

> +				atomic_set(&cxlrd->region_id, rc);
> +			} else
>  				cxlsd = NULL;
>  		} else {
>  			alloc = kzalloc(struct_size(cxlsd, target, nr_targets),
> @@ -1490,6 +1521,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  
>  	return cxld;
>  err:
> +	if (cxlrd && atomic_read(&cxlrd->region_id) >= 0)
> +		memregion_free(atomic_read(&cxlrd->region_id));
>  	kfree(alloc);
>  	return ERR_PTR(rc);
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> new file mode 100644
> index 000000000000..f2a0ead20ca7
> --- /dev/null
> +++ b/drivers/cxl/core/region.c
> @@ -0,0 +1,199 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/memregion.h>
> +#include <linux/genalloc.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core region
> + *
> + * CXL Regions represent mapped memory capacity in system physical address
> + * space. Whereas the CXL Root Decoders identify the bounds of potential CXL
> + * Memory ranges, Regions represent the active mapped capacity by the HDM
> + * Decoder Capability structures throughout the Host Bridges, Switches, and
> + * Endpoints in the topology.
> + */
> +
> +static struct cxl_region *to_cxl_region(struct device *dev);
> +
> +static void cxl_region_release(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +	memregion_free(cxlr->id);
> +	kfree(cxlr);
> +}
> +
> +static const struct device_type cxl_region_type = {
> +	.name = "cxl_region",
> +	.release = cxl_region_release,
> +};
> +
> +bool is_cxl_region(struct device *dev)
> +{
> +	return dev->type == &cxl_region_type;
> +}
> +EXPORT_SYMBOL_NS_GPL(is_cxl_region, CXL);
> +
> +static struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> +			  "not a cxl_region device\n"))
> +		return NULL;
> +
> +	return container_of(dev, struct cxl_region, dev);
> +}
> +
> +static void unregister_region(void *dev)
> +{
> +	device_unregister(dev);
> +}
> +
> +static struct lock_class_key cxl_region_key;
> +
> +static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
> +{
> +	struct cxl_region *cxlr;
> +	struct device *dev;
> +
> +	cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
> +	if (!cxlr) {
> +		memregion_free(id);

That's a bit nasty as it gives the function side effects. Perhaps some
comments in the callers of this to highlight that memregion will either be freed
in here or handled over to the device.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	dev = &cxlr->dev;
> +	device_initialize(dev);
> +	lockdep_set_class(&dev->mutex, &cxl_region_key);
> +	dev->parent = &cxlrd->cxlsd.cxld.dev;
> +	device_set_pm_not_required(dev);
> +	dev->bus = &cxl_bus_type;
> +	dev->type = &cxl_region_type;
> +	cxlr->id = id;
> +
> +	return cxlr;
> +}
> +
> +/**
> + * devm_cxl_add_region - Adds a region to a decoder
> + * @cxlrd: root decoder
> + * @id: memregion id to create
> + * @mode: mode for the endpoint decoders of this region

Missing docs for type

> + *
> + * This is the second step of region initialization. Regions exist within an
> + * address space which is mapped by a @cxlrd.
> + *
> + * Return: 0 if the region was added to the @cxlrd, else returns negative error
> + * code. The region will be named "regionZ" where Z is the unique region number.
> + */
> +static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
> +					      int id,
> +					      enum cxl_decoder_mode mode,
> +					      enum cxl_decoder_type type)
> +{
> +	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> +	struct cxl_region *cxlr;
> +	struct device *dev;
> +	int rc;
> +
> +	cxlr = cxl_region_alloc(cxlrd, id);
> +	if (IS_ERR(cxlr))
> +		return cxlr;
> +	cxlr->mode = mode;
> +	cxlr->type = type;
> +
> +	dev = &cxlr->dev;
> +	rc = dev_set_name(dev, "region%d", id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	rc = devm_add_action_or_reset(port->uport, unregister_region, cxlr);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	dev_dbg(port->uport, "%s: created %s\n",
> +		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> +	return cxlr;
> +
> +err:
> +	put_device(dev);
> +	return ERR_PTR(rc);
> +}
> +

> +static ssize_t create_pmem_region_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
> +	struct cxl_region *cxlr;
> +	unsigned int id, rc;
> +
> +	rc = sscanf(buf, "region%u\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	rc = memregion_alloc(GFP_KERNEL);
> +	if (rc < 0)
> +		return rc;
> +
> +	if (atomic_cmpxchg(&cxlrd->region_id, id, rc) != id) {
> +		memregion_free(rc);
> +		return -EBUSY;
> +	}
> +
> +	cxlr = devm_cxl_add_region(cxlrd, id, CXL_DECODER_PMEM,
> +				   CXL_DECODER_EXPANDER);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +DEVICE_ATTR_RW(create_pmem_region);
> +
> +static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,

Perhaps rename cxld here to make it clear it's a root decoder only.

> +						  const char *name)
> +{
> +	struct device *region_dev;
> +
> +	region_dev = device_find_child_by_name(&cxld->dev, name);
> +	if (!region_dev)
> +		return ERR_PTR(-ENODEV);
> +
> +	return to_cxl_region(region_dev);
> +}
> +
> +static ssize_t delete_region_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t len)
> +{
> +	struct cxl_port *port = to_cxl_port(dev->parent);
> +	struct cxl_decoder *cxld = to_cxl_decoder(dev);
As above, given it's the root decoder can we name it to make that
obvious?

> +	struct cxl_region *cxlr;
> +
> +	cxlr = cxl_find_region_by_name(cxld, buf);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	devm_release_action(port->uport, unregister_region, cxlr);
> +	put_device(&cxlr->dev);
> +
> +	return len;
> +}
> +DEVICE_ATTR_WO(delete_region);
