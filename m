Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7314A6146
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 17:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiBAQWA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 11:22:00 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4605 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240905AbiBAQWA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 11:22:00 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp97M5LBzz67NZn;
        Wed,  2 Feb 2022 00:17:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 17:21:58 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 16:21:57 +0000
Date:   Tue, 1 Feb 2022 16:21:55 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        kernel test robot <lkp@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 04/14] cxl/region: Introduce a cxl_region driver
Message-ID: <20220201161939.00005ccf@Huawei.com>
In-Reply-To: <20220128002707.391076-5-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-5-ben.widawsky@intel.com>
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

On Thu, 27 Jan 2022 16:26:57 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The cxl_region driver is responsible for managing the HDM decoder
> programming in the CXL topology. Once a region is created it must be
> configured and bound to the driver in order to activate it.
> 
> The following is a sample of how such controls might work:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
> echo 2 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/interleave
> echo $((256<<20)) > /sys/bus/cxl/devices/decoder0.0/region0.0:0/size
> echo mem0 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target0
> echo mem1 > /sys/bus/cxl/devices/decoder0.0/region0.0:0/target1
> echo region0.0:0 > /sys/bus/cxl/drivers/cxl_region/bind
> 
> In order to handle the eventual rise in failure modes of binding a
> region, a new trace event is created to help track these failures for
> debug and reconfiguration paths in userspace.
> 
> Reported-by: kernel test robot <lkp@intel.com> (v2)
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

A few minor comments inline.

Thanks,

Jonathan

> ---
> Changes since v2:
> - Add CONFIG_CXL_REGION
> - Check ways/granularity in sanitize
> ---
>  .../driver-api/cxl/memory-devices.rst         |   3 +
>  drivers/cxl/Kconfig                           |   4 +
>  drivers/cxl/Makefile                          |   2 +
>  drivers/cxl/core/core.h                       |   1 +
>  drivers/cxl/core/port.c                       |  17 +-
>  drivers/cxl/core/region.c                     |  25 +-
>  drivers/cxl/cxl.h                             |  31 ++
>  drivers/cxl/region.c                          | 349 ++++++++++++++++++
>  drivers/cxl/region.h                          |   4 +
>  9 files changed, 431 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/cxl/region.c
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 66ddc58a21b1..8cb4dece5b17 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -364,6 +364,9 @@ CXL Core
>  
>  CXL Regions
>  -----------
> +.. kernel-doc:: drivers/cxl/region.c
> +   :doc: cxl region
> +
>  .. kernel-doc:: drivers/cxl/region.h
>     :identifiers:
>  
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index b88ab956bb7c..742847503c16 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -98,4 +98,8 @@ config CXL_PORT
>  	default CXL_BUS
>  	tristate
>  
> +config CXL_REGION
> +	default CXL_PORT
> +	tristate
> +
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index ce267ef11d93..02a4776e7ab9 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -5,9 +5,11 @@ obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  obj-$(CONFIG_CXL_PORT) += cxl_port.o
> +obj-$(CONFIG_CXL_REGION) += cxl_region.o
>  
>  cxl_mem-y := mem.o
>  cxl_pci-y := pci.o
>  cxl_acpi-y := acpi.o
>  cxl_pmem-y := pmem.o
>  cxl_port-y := port.o
> +cxl_region-y := region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 35fd08d560e2..b8a154da34df 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -7,6 +7,7 @@
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
>  extern const struct device_type cxl_memdev_type;
> +extern const struct device_type cxl_region_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0826208b2bdf..0847e6ce19ef 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -9,6 +9,7 @@
>  #include <linux/idr.h>
>  #include <cxlmem.h>
>  #include <cxlpci.h>
> +#include <region.h>
>  #include <cxl.h>
>  #include "core.h"
>  
> @@ -49,6 +50,8 @@ static int cxl_device_id(struct device *dev)
>  	}
>  	if (dev->type == &cxl_memdev_type)
>  		return CXL_DEVICE_MEMORY_EXPANDER;
> +	if (dev->type == &cxl_region_type)
> +		return CXL_DEVICE_REGION;
>  	return 0;
>  }
>  
> @@ -1425,13 +1428,23 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
>  
>  static int cxl_bus_probe(struct device *dev)
>  {
> -	int rc;
> +	int id = cxl_device_id(dev);
> +	int rc = -ENODEV;
>  
>  	cxl_nested_lock(dev);
> -	rc = to_cxl_drv(dev->driver)->probe(dev);
> +	if (id == CXL_DEVICE_REGION) {
> +		/* Regions cannot bind until parameters are set */
> +		struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +		if (is_cxl_region_configured(cxlr))
> +			rc = to_cxl_drv(dev->driver)->probe(dev);
> +	} else {
> +		rc = to_cxl_drv(dev->driver)->probe(dev);
> +	}
>  	cxl_nested_unlock(dev);
>  
>  	dev_dbg(dev, "probe: %d\n", rc);
> +

Shouldn't be in this patch.

>  	return rc;
>  }
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3b48e0469fc7..784e4ba25128 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -12,6 +12,8 @@
>  #include <cxl.h>
>  #include "core.h"
>  
> +#include "core.h"
> +
>  /**
>   * DOC: cxl core region
>   *
> @@ -26,10 +28,27 @@ static const struct attribute_group region_interleave_group;
>  
>  static bool is_region_active(struct cxl_region *cxlr)
>  {
> -	/* TODO: Regions can't be activated yet. */
> -	return false;
> +	return cxlr->active;
>  }
>  
> +/*
> + * Most sanity checking is left up to region binding. This does the most basic
> + * check to determine whether or not the core should try probing the driver.
> + */
> +bool is_cxl_region_configured(const struct cxl_region *cxlr)
> +{
> +	/* zero sized regions aren't a thing. */
> +	if (cxlr->config.size <= 0)
> +		return false;
> +
> +	/* all regions have at least 1 target */
> +	if (!cxlr->config.targets[0])
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(is_cxl_region_configured);
> +
>  static void remove_target(struct cxl_region *cxlr, int target)
>  {
>  	struct cxl_memdev *cxlmd;
> @@ -316,7 +335,7 @@ static const struct attribute_group *region_groups[] = {
>  
>  static void cxl_region_release(struct device *dev);
>  
> -static const struct device_type cxl_region_type = {
> +const struct device_type cxl_region_type = {
>  	.name = "cxl_region",
>  	.release = cxl_region_release,
>  	.groups = region_groups
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b9f0099c1f39..d1a8ca19c9ea 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -81,6 +81,31 @@ static inline int cxl_to_interleave_ways(u8 eniw)
>  	}
>  }
>  
> +static inline bool cxl_is_interleave_ways_valid(int iw)
> +{
> +	switch (iw) {
> +		case 0 ... 4:
> +		case 6:
> +		case 8:
> +		case 12:
> +		case 16:
> +			return true;
> +		default:
> +			return false;
> +	}
> +
> +	unreachable();

Why does this need marking?

> +}
> +
> +static inline bool cxl_is_interleave_granularity_valid(int ig)
> +{
> +	if (!is_power_of_2(ig))
> +		return false;
> +
> +	/* 16K is the max */
> +	return ((ig >> 15) == 0);
> +}
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -199,6 +224,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_MASK  GENMASK(5, 0)
>  
> +#define cxl_is_pmem_t3(flags)                                                  \
> +	(((flags) & (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM)) ==             \
> +	 (CXL_DECODER_F_TYPE3 | CXL_DECODER_F_PMEM))
> +
>  enum cxl_decoder_type {
>         CXL_DECODER_ACCELERATOR = 2,
>         CXL_DECODER_EXPANDER = 3,
> @@ -357,6 +386,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  				     resource_size_t component_reg_phys);
>  struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  					const struct device *dev);
> +struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);

Doesn't seem to be in this patch or indeed anywhere in the series.


>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> @@ -404,6 +434,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
>  #define CXL_DEVICE_PORT			3
>  #define CXL_DEVICE_ROOT			4
>  #define CXL_DEVICE_MEMORY_EXPANDER	5
> +#define CXL_DEVICE_REGION		6
>  
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> new file mode 100644
> index 000000000000..cc41939a2f0a
> --- /dev/null
> +++ b/drivers/cxl/region.c
> @@ -0,0 +1,349 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/platform_device.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include "cxlmem.h"
> +#include "region.h"
> +#include "cxl.h"
> +
> +/**
> + * DOC: cxl region
> + *
> + * This module implements a region driver that is capable of programming CXL
> + * hardware to setup regions.
> + *
> + * A CXL region encompasses a chunk of host physical address space that may be
> + * consumed by a single device (x1 interleave aka linear) or across multiple
> + * devices (xN interleaved). The region driver has the following
> + * responsibilities:
> + *
> + * * Walk topology to obtain decoder resources for region configuration.
> + * * Program decoder resources based on region configuration.
> + * * Bridge CXL regions to LIBNVDIMM
> + * * Initiates reading and configuring LSA regions
> + * * Enumerates regions created by BIOS (typically volatile)
> + */
> +
> +#define region_ways(region) ((region)->config.interleave_ways)
> +#define region_granularity(region) ((region)->config.interleave_granularity)

If you drop the 'config' level of the structure as I think Dan suggested
then I don't think these macros will be justified vs
region->interleave_xxx  They are a bit borderline now for whether they
help or hinder readability!

> +
> +static struct cxl_decoder *rootd_from_region(struct cxl_region *cxlr)
> +{
> +	struct device *d = cxlr->dev.parent;
> +
> +	if (WARN_ONCE(!is_root_decoder(d),
> +		      "Corrupt topology for root region\n"))
> +		return NULL;
> +
> +	return to_cxl_decoder(d);
> +}
> +
> +static struct cxl_port *get_hostbridge(const struct cxl_memdev *ep)
> +{
> +	struct cxl_port *port = ep->port;
> +
> +	while (!is_cxl_root(port)) {
> +		port = to_cxl_port(port->dev.parent);
> +		if (port->depth == 1)
> +			return port;
> +	}
> +
> +	BUG();

Add a comment on why. For anyone hitting this they are in a weird
state, so give them a hint!

> +	return NULL;
> +}
> +
> +static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
> +{
> +	struct cxl_port *hostbridge = get_hostbridge(endpoint);
> +
> +	if (hostbridge)
> +		return to_cxl_port(hostbridge->dev.parent);
> +
> +	return NULL;
> +}
> +
> +/**
> + * sanitize_region() - Check is region is reasonably configured
> + * @cxlr: The region to check
> + *
> + * Determination as to whether or not a region can possibly be configured is
> + * described in CXL Memory Device SW Guide. In order to implement the algorithms

Lines are a tiny bit long given no loss of readability in bringing them under
80 chars.

> + * described there, certain more basic configuration parameters must first need
> + * to be validated. That is accomplished by this function.
> + *
> + * Returns 0 if the region is reasonably configured, else returns a negative
> + * error code.
> + */
> +static int sanitize_region(const struct cxl_region *cxlr)
> +{
> +	const int ig = region_granularity(cxlr);
> +	const int iw = region_ways(cxlr);
> +	int i;
> +
> +	if (dev_WARN_ONCE(&cxlr->dev, !is_cxl_region_configured(cxlr),
> +			  "unconfigured regions can't be probed (race?)\n")) {
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Interleave attributes should be caught by later math, but it's
> +	 * easiest to find those issues here, now.
> +	 */
> +	if (!cxl_is_interleave_ways_valid(iw)) {
> +		dev_dbg(&cxlr->dev, "Invalid number of ways\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!cxl_is_interleave_granularity_valid(ig)) {
> +		dev_dbg(&cxlr->dev, "Invalid interleave granularity\n");
> +		return -ENXIO;
> +	}
> +
> +	if (cxlr->config.size % (SZ_256M * iw)) {
> +		dev_dbg(&cxlr->dev, "Invalid size. Must be multiple of %uM\n",
> +			256 * iw);
> +		return -ENXIO;
> +	}
> +
> +	for (i = 0; i < iw; i++) {
> +		if (!cxlr->config.targets[i]) {
> +			dev_dbg(&cxlr->dev, "Missing memory device target%u",
> +				i);
> +			return -ENXIO;
> +		}
> +		if (!cxlr->config.targets[i]->dev.driver) {
> +			dev_dbg(&cxlr->dev, "%s isn't CXL.mem capable\n",
> +				dev_name(&cxlr->config.targets[i]->dev));
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * allocate_address_space() - Gets address space for the region.
> + * @cxlr: The region that will consume the address space
> + */
> +static int allocate_address_space(struct cxl_region *cxlr)
> +{
> +	/* TODO */
> +	return 0;
> +}
> +
> +/**
> + * find_cdat_dsmas() - Find a valid DSMAS for the region
> + * @cxlr: The region
> + */
> +static bool find_cdat_dsmas(const struct cxl_region *cxlr)
> +{
> +	return true;
> +}
> +
> +/**
> + * qtg_match() - Does this root decoder have desirable QTG for the endpoint
> + * @rootd: The root decoder for the region
> + * @endpoint: Endpoint whose QTG is being compared
> + *
> + * Prior to calling this function, the caller should verify that all endpoints
> + * in the region have the same QTG ID.
> + *
> + * Returns true if the QTG ID of the root decoder matches the endpoint
> + */
> +static bool qtg_match(const struct cxl_decoder *rootd,
> +		      const struct cxl_memdev *endpoint)
> +{
> +	/* TODO: */
> +	return true;
> +}
> +
> +/**
> + * region_xhb_config_valid() - determine cross host bridge validity
> + * @cxlr: The region being programmed
> + * @rootd: The root decoder to check against
> + *
> + * The algorithm is outlined in 2.13.14 "Verify XHB configuration sequence" of
> + * the CXL Memory Device SW Guide (Rev1p0).
> + *
> + * Returns true if the configuration is valid.
> + */
> +static bool region_xhb_config_valid(const struct cxl_region *cxlr,
> +				    const struct cxl_decoder *rootd)
> +{
> +	/* TODO: */
> +	return true;
> +}
> +
> +/**
> + * region_hb_rp_config_valid() - determine root port ordering is correct
> + * @cxlr: Region to validate
> + * @rootd: root decoder for this @cxlr
> + *
> + * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
> + * sequence" of the CXL Memory Device SW Guide (Rev1p0).
> + *
> + * Returns true if the configuration is valid.
> + */
> +static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
> +				      const struct cxl_decoder *rootd)
> +{
> +	/* TODO: */
> +	return true;
> +}
> +
> +/**
> + * rootd_contains() - determine if this region can exist in the root decoder
> + * @rootd: root decoder that potentially decodes to this region
> + * @cxlr: region to be routed by the @rootd
> + */
> +static bool rootd_contains(const struct cxl_region *cxlr,
> +			   const struct cxl_decoder *rootd)
> +{
> +	/* TODO: */
> +	return true;
> +}
> +
> +static bool rootd_valid(const struct cxl_region *cxlr,
> +			const struct cxl_decoder *rootd)
> +{
> +	const struct cxl_memdev *endpoint = cxlr->config.targets[0];
> +
> +	if (!qtg_match(rootd, endpoint))
> +		return false;
> +
> +	if (!cxl_is_pmem_t3(rootd->flags))
> +		return false;
> +
> +	if (!region_xhb_config_valid(cxlr, rootd))
> +		return false;
> +
> +	if (!region_hb_rp_config_valid(cxlr, rootd))
> +		return false;
> +
> +	if (!rootd_contains(cxlr, rootd))
> +		return false;
> +
> +	return true;
> +}
> +
> +struct rootd_context {
> +	const struct cxl_region *cxlr;
> +	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +	int count;
> +};
> +
> +static int rootd_match(struct device *dev, void *data)
> +{
> +	struct rootd_context *ctx = (struct rootd_context *)data;

Shouldn't need to cast from a void * to another pointer type.

> +	const struct cxl_region *cxlr = ctx->cxlr;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	return !!rootd_valid(cxlr, to_cxl_decoder(dev));

Extreme given rootd_valid returns a bool...


> +}
> +
> +/*
> + * This is a roughly equivalent implementation to "Figure 45 - High-level
> + * sequence: Finding CFMWS for region" from the CXL Memory Device SW Guide
> + * Rev1p0.
> + */
> +static struct cxl_decoder *find_rootd(const struct cxl_region *cxlr,
> +				      const struct cxl_port *root)
> +{
> +	struct rootd_context ctx;
> +	struct device *ret;
> +
> +	ctx.cxlr = cxlr;
> +
> +	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);

Why do you need a cast? 

> +	if (ret)
> +		return to_cxl_decoder(ret);
> +
> +	return NULL;
> +}


> +static int cxl_region_probe(struct device *dev)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_port *root_port;
> +	struct cxl_decoder *rootd, *ours;
> +	int ret;
> +
> +	device_lock_assert(&cxlr->dev);
> +
> +	if (cxlr->active)
> +		return 0;
> +
> +	if (uuid_is_null(&cxlr->config.uuid))
> +		uuid_gen(&cxlr->config.uuid);
> +
> +	/* TODO: What about volatile, and LSA generated regions? */
> +
> +	ret = sanitize_region(cxlr);
> +	if (ret)
> +		return ret;
> +
> +	ret = allocate_address_space(cxlr);
> +	if (ret)
> +		return ret;
> +
> +	if (!find_cdat_dsmas(cxlr))
> +		return -ENXIO;
> +
> +	rootd = rootd_from_region(cxlr);
> +	if (!rootd) {
> +		dev_err(dev, "Couldn't find root decoder\n");
> +		return -ENXIO;
> +	}
> +
> +	if (!rootd_valid(cxlr, rootd)) {
> +		dev_err(dev, "Picked invalid rootd\n");
> +		return -ENXIO;
> +	}
> +
> +	root_port = get_root_decoder(cxlr->config.targets[0]);
> +	ours = find_rootd(cxlr, root_port);
> +	if (ours != rootd)
> +		dev_dbg(dev, "Picked different rootd %s %s\n",
> +			dev_name(&rootd->dev), dev_name(&ours->dev));

Good to add a comment here on why it is fine to continue after
what the dbg statement and check makes sound like a bad thing!

> +	if (ours)
> +		put_device(&ours->dev);
> +
> +	ret = collect_ep_decoders(cxlr);
> +	if (ret)
> +		return ret;
> +
> +	ret = bind_region(cxlr);
> +	if (!ret) {
> +		cxlr->active = true;
> +		dev_info(dev, "Bound");

Looks like left over debug info...

> +	}
> +
> +	return ret;
> +}
> +
> +static struct cxl_driver cxl_region_driver = {
> +	.name = "cxl_region",
> +	.probe = cxl_region_probe,
> +	.id = CXL_DEVICE_REGION,
> +};
> +module_cxl_driver(cxl_region_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> +MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
