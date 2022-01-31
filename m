Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEC4A4AED
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 16:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379878AbiAaPtB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 10:49:01 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4568 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379829AbiAaPs7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 10:48:59 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnXSn6S1Sz67xX7;
        Mon, 31 Jan 2022 23:45:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 16:48:56 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 15:48:55 +0000
Date:   Mon, 31 Jan 2022 15:48:48 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 15/40] cxl: Prove CXL locking
Message-ID: <20220131154848.00006615@Huawei.com>
In-Reply-To: <164298419875.3018233.7880727408723281411.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298419875.3018233.7880727408723281411.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:29:58 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> When CONFIG_PROVE_LOCKING is enabled the 'struct device' definition gets
> an additional mutex that is not clobbered by
> lockdep_set_novalidate_class() like the typical device_lock(). This
> allows for local annotation of subsystem locks with mutex_lock_nested()
> per the subsystem's object/lock hierarchy. For CXL, this primarily needs
> the ability to lock ports by depth and child objects of ports by their
> parent parent-port lock.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

This infrastructure is nice.

A few comments inline - mostly requests for a few comments to make
life easier when reading this in future.  Also, I'd slightly prefer
this as 2 patches so the trivial nvdimm / Kconfig.debug stuff is separate
from the patch actually introducing support for this in CXL.

Anyhow, all trivial stuff so as far as I'm concerned.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  drivers/cxl/acpi.c       |   10 +++---
>  drivers/cxl/core/pmem.c  |    4 +-
>  drivers/cxl/core/port.c  |   43 ++++++++++++++++++++-------
>  drivers/cxl/cxl.h        |   74 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pmem.c       |   12 ++++---
>  drivers/nvdimm/nd-core.h |    2 +
>  lib/Kconfig.debug        |   23 ++++++++++++++
>  7 files changed, 143 insertions(+), 25 deletions(-)
> 


> @@ -712,15 +725,23 @@ static int cxl_bus_match(struct device *dev, struct device_driver *drv)
>  
>  static int cxl_bus_probe(struct device *dev)
>  {
> -	return to_cxl_drv(dev->driver)->probe(dev);
> +	int rc;
> +
> +	cxl_nested_lock(dev);

I guess it is 'fairly' obvious why this call is here (I assume because the device
lock is already held), but maybe worth a comment?

> +	rc = to_cxl_drv(dev->driver)->probe(dev);
> +	cxl_nested_unlock(dev);
> +
> +	return rc;
>  }
>  
>  static void cxl_bus_remove(struct device *dev)
>  {
>  	struct cxl_driver *cxl_drv = to_cxl_drv(dev->driver);
>  
> +	cxl_nested_lock(dev);
>  	if (cxl_drv->remove)
>  		cxl_drv->remove(dev);
> +	cxl_nested_unlock(dev);
>  }
>  
>  struct bus_type cxl_bus_type = {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c1dc53492773..569cbe7f23d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -285,6 +285,7 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  	return port->uport == port->dev.parent;
>  }
>  
> +bool is_cxl_port(struct device *dev);
>  struct cxl_port *to_cxl_port(struct device *dev);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
> @@ -295,6 +296,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> +bool is_cxl_decoder(struct device *dev);
>  struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  					   unsigned int nr_targets);
>  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> @@ -347,4 +349,76 @@ struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
>  #ifndef __mock
>  #define __mock static
>  #endif
> +
> +#ifdef CONFIG_PROVE_CXL_LOCKING
> +enum cxl_lock_class {
> +	CXL_ANON_LOCK,
> +	CXL_NVDIMM_LOCK,
> +	CXL_NVDIMM_BRIDGE_LOCK,
> +	CXL_PORT_LOCK,

As you are going to increment off the end of this perhaps a comment
here so that no one thinks "I'll just add another entry after CXL_PORT_LOCK"

> +};
> +
> +static inline void cxl_nested_lock(struct device *dev)
> +{
> +	if (is_cxl_port(dev)) {
> +		struct cxl_port *port = to_cxl_port(dev);
> +
> +		mutex_lock_nested(&dev->lockdep_mutex,
> +				  CXL_PORT_LOCK + port->depth);
> +	} else if (is_cxl_decoder(dev)) {
> +		struct cxl_port *port = to_cxl_port(dev->parent);
> +
> +		mutex_lock_nested(&dev->lockdep_mutex,
> +				  CXL_PORT_LOCK + port->depth + 1);

Perhaps a comment on why port->dev + 1 is a safe choice?
Not immediately obvious to me and I'm too lazy to figure it out :)

> +	} else if (is_cxl_nvdimm_bridge(dev))
> +		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_BRIDGE_LOCK);
> +	else if (is_cxl_nvdimm(dev))
> +		mutex_lock_nested(&dev->lockdep_mutex, CXL_NVDIMM_LOCK);
> +	else
> +		mutex_lock_nested(&dev->lockdep_mutex, CXL_ANON_LOCK);
> +}
> +
> +static inline void cxl_nested_unlock(struct device *dev)
> +{
> +	mutex_unlock(&dev->lockdep_mutex);
> +}
> +
> +static inline void cxl_device_lock(struct device *dev)
> +{
> +	/*
> +	 * For double lock errors the lockup will happen before lockdep
> +	 * warns at cxl_nested_lock(), so assert explicitly.
> +	 */
> +	lockdep_assert_not_held(&dev->lockdep_mutex);
> +
> +	device_lock(dev);
> +	cxl_nested_lock(dev);
> +}
> +
> +static inline void cxl_device_unlock(struct device *dev)
> +{
> +	cxl_nested_unlock(dev);
> +	device_unlock(dev);
> +}
> +#else
> +static inline void cxl_nested_lock(struct device *dev)
> +{
> +}
> +
> +static inline void cxl_nested_unlock(struct device *dev)
> +{
> +}
> +
> +static inline void cxl_device_lock(struct device *dev)
> +{
> +	device_lock(dev);
> +}
> +
> +static inline void cxl_device_unlock(struct device *dev)
> +{
> +	device_unlock(dev);
> +}
> +#endif
> +
> +

One blank line only.

>  #endif /* __CXL_H__ */
...
> diff --git a/drivers/nvdimm/nd-core.h b/drivers/nvdimm/nd-core.h
> index a11850dd475d..2650a852eeaf 100644
> --- a/drivers/nvdimm/nd-core.h
> +++ b/drivers/nvdimm/nd-core.h
> @@ -185,7 +185,7 @@ static inline void devm_nsio_disable(struct device *dev,
>  }
>  #endif
>  
> -#ifdef CONFIG_PROVE_LOCKING
> +#ifdef CONFIG_PROVE_NVDIMM_LOCKING
>  extern struct class *nd_class;
>  
>  enum {
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ef7ce18b4f5..ea9291723d06 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1509,6 +1509,29 @@ config CSD_LOCK_WAIT_DEBUG
>  	  include the IPI handler function currently executing (if any)
>  	  and relevant stack traces.
>  
> +choice
> +	prompt "Lock debugging: prove subsystem device_lock() correctness"
> +	depends on PROVE_LOCKING
> +	help
> +	  For subsystems that have instrumented their usage of the device_lock()
> +	  with nested annotations, enable lock dependency checking. The locking
> +	  hierarchy 'subclass' identifiers are not compatible across
> +	  sub-systems, so only one can be enabled at a time.
> +
> +config PROVE_NVDIMM_LOCKING
> +	bool "NVDIMM"
> +	depends on LIBNVDIMM
> +	help
> +	  Enable lockdep to validate nd_device_lock() usage.

I would slightly have preferred a first patch that pulled out the NVDIMM parts
and a second that introduced it for CXL.

> +
> +config PROVE_CXL_LOCKING
> +	bool "CXL"
> +	depends on CXL_BUS
> +	help
> +	  Enable lockdep to validate cxl_device_lock() usage.
> +
> +endchoice
> +
>  endmenu # lock debugging
>  
>  config TRACE_IRQFLAGS
> 

