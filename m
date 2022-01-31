Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378CF4A4DC2
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 19:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239877AbiAaSL2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 13:11:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4580 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiAaSL1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 13:11:27 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jnbc94hBmz67yV6;
        Tue,  1 Feb 2022 02:06:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 19:11:25 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 18:11:24 +0000
Date:   Mon, 31 Jan 2022 18:11:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        "Ben Widawsky" <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v4 24/40] cxl/port: Add a driver for 'struct cxl_port'
 objects
Message-ID: <20220131181118.00002471@Huawei.com>
In-Reply-To: <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298424635.3018233.9356036382052246767.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Wed, 26 Jan 2022 12:16:52 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> The need for a CXL port driver and a dedicated cxl_bus_type is driven by
> a need to simultaneously support 2 independent physical memory decode
> domains (cache coherent CXL.mem and uncached PCI.mmio) that also
> intersect at a single PCIe device node. A CXL Port is a device that
> advertises a  CXL Component Register block with an "HDM Decoder
> Capability Structure".
> 
> >From Documentation/driver-api/cxl/memory-devices.rst:  
> 
>     Similar to how a RAID driver takes disk objects and assembles them into
>     a new logical device, the CXL subsystem is tasked to take PCIe and ACPI
>     objects and assemble them into a CXL.mem decode topology. The need for
>     runtime configuration of the CXL.mem topology is also similar to RAID in
>     that different environments with the same hardware configuration may
>     decide to assemble the topology in contrasting ways. One may choose
>     performance (RAID0) striping memory across multiple Host Bridges and
>     endpoints while another may opt for fault tolerance and disable any
>     striping in the CXL.mem topology.
> 
> The port driver identifies whether an endpoint Memory Expander is
> connected to a CXL topology. If an active (bound to the 'cxl_port'
> driver) CXL Port is not found at every PCIe Switch Upstream port and an
> active "root" CXL Port then the device is just a plain PCIe endpoint
> only capable of participating in PCI.mmio and DMA cycles, not CXL.mem
> coherent interleave sets.
> 
> The 'cxl_port' driver lets the CXL subsystem leverage driver-core
> infrastructure for setup and teardown of register resources and
> communicating device activation status to userspace. The cxl_bus_type
> can rendezvous the async arrival of platform level CXL resources (via
> the 'cxl_acpi' driver) with the asynchronous enumeration of Memory
> Expander endpoints, while also implementing a hierarchical locking model
> independent of the associated 'struct pci_dev' locking model. The
> locking for dport and decoder enumeration is now handled in the core
> rather than callers.
> 
> For now the port driver only enumerates and registers CXL resources
> (downstream port metadata and decoder resources) later it will be used
> to take action on its decoders in response to CXL.mem region
> provisioning requests.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: add theory of operation document, move enumeration infra to core]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nice docs. A few comments inline

All trivial though, so

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



...

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2b09d04d3568..682e7cdbcc9c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -40,6 +40,11 @@ static int cxl_device_id(struct device *dev)

...

>  
> +/*
> + * Since root-level CXL dports cannot be enumerated by PCI they are not
> + * enumerated by the common port driver that acquires the port lock over
> + * dport add/remove. Instead, root dports are manually added by a
> + * platform driver and cond_port_lock() is used to take the missing port
> + * lock in that case.
> + */
> +static void cond_port_lock(struct cxl_port *port)

Could the naming here make it clear what the condition is?
cxl_port_lock_if_root(), or something like that?

> +{
> +	if (is_cxl_root(port))
> +		cxl_device_lock(&port->dev);
> +}
> +
> +static void cond_port_unlock(struct cxl_port *port)
> +{
> +	if (is_cxl_root(port))
> +		cxl_device_unlock(&port->dev);
> +}
> +
>  static void cxl_dport_remove(void *data)
>  {
>  	struct cxl_dport *dport = data;
>  	struct cxl_port *port = dport->port;
>  
> -	cxl_device_lock(&port->dev);
> +	cond_port_lock(port);
>  	list_del_init(&dport->list);
> -	cxl_device_unlock(&port->dev);
> +	cond_port_unlock(port);
>  	put_device(dport->dport);
>  }
>  
> @@ -588,7 +615,9 @@ struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
>  
> +	cond_port_lock(port);
>  	rc = add_dport(port, dport);
> +	cond_port_unlock(port);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> @@ -887,6 +916,7 @@ static int cxl_bus_probe(struct device *dev)
>  	rc = to_cxl_drv(dev->driver)->probe(dev);
>  	cxl_nested_unlock(dev);
>  
> +	dev_dbg(dev, "probe: %d\n", rc);

This feels a little bit odd to see in this patch. 
I'd be tempted to drop it.


>  	return rc;
>  }
>  

>  
>  #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
>  #define CXL_MODALIAS_FMT "cxl:t%d"
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 103636fda198..47640f19e899 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #ifndef __CXL_PCI_H__
>  #define __CXL_PCI_H__
> +#include <linux/pci.h>

Why in this patch?

>  #include "cxl.h"
>  
>  #define CXL_MEMORY_PROGIF	0x10


> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 3045d7cba0db..3e2a529875ea 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -26,6 +26,12 @@ obj-m += cxl_pmem.o
>  cxl_pmem-y := $(CXL_SRC)/pmem.o
>  cxl_pmem-y += config_check.o
>  
> +obj-m += cxl_port.o
> +
> +cxl_port-y := $(CXL_SRC)/port.o
> +cxl_port-y += config_check.o
> +

trivial but one blank line seems like enough.

> +
>  obj-m += cxl_core.o
>  
>  cxl_core-y := $(CXL_CORE_SRC)/port.o


