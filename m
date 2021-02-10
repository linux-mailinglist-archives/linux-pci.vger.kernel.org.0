Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874BA316B03
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 17:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhBJQTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 11:19:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2535 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbhBJQS5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Feb 2021 11:18:57 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbPs169hdz67m5W;
        Thu, 11 Feb 2021 00:11:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 17:18:09 +0100
Received: from localhost (10.47.67.2) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 10 Feb
 2021 16:18:07 +0000
Date:   Wed, 10 Feb 2021 16:17:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Jon Masters" <jcm@jonmasters.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/8] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210210161707.000073ab@Huawei.com>
In-Reply-To: <20210210000259.635748-2-ben.widawsky@intel.com>
References: <20210210000259.635748-1-ben.widawsky@intel.com>
        <20210210000259.635748-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.2]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 9 Feb 2021 16:02:52 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL.mem protocol allows a device to act as a provider of "System
> RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> was attached to the typical CPU memory controller.
> 
> With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> device interface and give the operating system control over "Host
> Managed Device Memory". See section 2.3 Type 3 CXL Device.
> 
> The memory range exported by the device may optionally be described by
> the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> provision persistent memory capacity from one, or more, CXL.mem devices.
> 
> A pre-requisite for Linux-managed memory-capacity provisioning is this
> cxl_mem driver that can speak the mailbox protocol defined in section
> 8.2.8.4 Mailbox Registers.
> 
> For now just land the initial driver boiler-plate and Documentation/
> infrastructure.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Acked-by: David Rientjes <rientjes@google.com> (v1)

A few trivial bits inline but nothing that I feel that strongly about.
It is probably a good idea to add a note about generic dvsec code
somewhere in this patch description (to avoid people raising it on
future versions!)

With the define of PCI_EXT_CAP_ID_DVSEC dropped (it's in the generic
header already).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/cxl/index.rst        | 12 ++++
>  .../driver-api/cxl/memory-devices.rst         | 29 +++++++++
>  Documentation/driver-api/index.rst            |  1 +
>  drivers/Kconfig                               |  1 +
>  drivers/Makefile                              |  1 +
>  drivers/cxl/Kconfig                           | 35 +++++++++++
>  drivers/cxl/Makefile                          |  4 ++
>  drivers/cxl/mem.c                             | 63 +++++++++++++++++++
>  drivers/cxl/pci.h                             | 18 ++++++
>  include/linux/pci_ids.h                       |  1 +
>  10 files changed, 165 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/index.rst
>  create mode 100644 Documentation/driver-api/cxl/memory-devices.rst
>  create mode 100644 drivers/cxl/Kconfig
>  create mode 100644 drivers/cxl/Makefile
>  create mode 100644 drivers/cxl/mem.c
>  create mode 100644 drivers/cxl/pci.h
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> new file mode 100644
> index 000000000000..036e49553542
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +====================
> +Compute Express Link
> +====================
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   memory-devices
> +
> +.. only::  subproject and html
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> new file mode 100644
> index 000000000000..43177e700d62
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -0,0 +1,29 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +===================================
> +Compute Express Link Memory Devices
> +===================================
> +
> +A Compute Express Link Memory Device is a CXL component that implements the
> +CXL.mem protocol. It contains some amount of volatile memory, persistent memory,
> +or both. It is enumerated as a PCI device for configuration and passing
> +messages over an MMIO mailbox. Its contribution to the System Physical
> +Address space is handled via HDM (Host Managed Device Memory) decoders
> +that optionally define a device's contribution to an interleaved address
> +range across multiple devices underneath a host-bridge or interleaved
> +across host-bridges.
> +
> +Driver Infrastructure
> +=====================
> +
> +This section covers the driver infrastructure for a CXL memory device.
> +
> +CXL Memory Device
> +-----------------
> +
> +.. kernel-doc:: drivers/cxl/mem.c
> +   :doc: cxl mem
> +
> +.. kernel-doc:: drivers/cxl/mem.c
> +   :internal:
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index 2456d0a97ed8..d246a18fd78f 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -35,6 +35,7 @@ available subsections can be seen below.
>     usb/index
>     firewire
>     pci/index
> +   cxl/index
>     spi
>     i2c
>     ipmb
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index dcecc9f6e33f..62c753a73651 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -6,6 +6,7 @@ menu "Device Drivers"
>  source "drivers/amba/Kconfig"
>  source "drivers/eisa/Kconfig"
>  source "drivers/pci/Kconfig"
> +source "drivers/cxl/Kconfig"
>  source "drivers/pcmcia/Kconfig"
>  source "drivers/rapidio/Kconfig"
>  
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fd11b9ac4cc3..678ea810410f 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_NVM)		+= lightnvm/
>  obj-y				+= base/ block/ misc/ mfd/ nfc/
>  obj-$(CONFIG_LIBNVDIMM)		+= nvdimm/
>  obj-$(CONFIG_DAX)		+= dax/
> +obj-$(CONFIG_CXL_BUS)		+= cxl/
>  obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
>  obj-$(CONFIG_NUBUS)		+= nubus/
>  obj-y				+= macintosh/
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..9e80b311e928
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	depends on PCI
> +	help
> +	  CXL is a bus that is electrically compatible with PCI Express, but
> +	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> +	  CXL.mem). The CXL.cache protocol allows devices to hold cachelines
> +	  locally, the CXL.mem protocol allows devices to be fully coherent
> +	  memory targets, the CXL.io protocol is equivalent to PCI Express.
> +	  Say 'y' to enable support for the configuration and management of
> +	  devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_MEM
> +	tristate "CXL.mem: Memory Devices"
> +	help
> +	  The CXL.mem protocol allows a device to act as a provider of
> +	  "System RAM" and/or "Persistent Memory" that is fully coherent
> +	  as if the memory was attached to the typical CPU memory
> +	  controller.
> +
> +	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
> +	  a module) that will attach to CXL.mem devices for
> +	  configuration, provisioning, and health monitoring. This
> +	  driver is required for dynamic provisioning of CXL.mem
> +	  attached memory which is a prerequisite for persistent memory
> +	  support. Typically volatile memory is mapped by platform
> +	  firmware and included in the platform memory map, but in some
> +	  cases the OS is responsible for mapping that memory. See
> +	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> +
> +	  If unsure say 'm'.
> +endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> new file mode 100644
> index 000000000000..4a30f7c3fc4a
> --- /dev/null
> +++ b/drivers/cxl/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +
> +cxl_mem-y := mem.o
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..99a6571508df
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include "pci.h"
> +
> +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 vendor, id;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;

Christopher Hellwig raised this in v1. 

https://lore.kernel.org/linux-pci/20201104201141.GA399378@bjorn-Precision-5520/

+CC Dave Jiang for update on that.

This wants to move towards a generic helper.  We can do the deduplication
later as Bjorn suggested.

> +}
> +
> +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	int regloc;
> +
> +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
> +	if (!regloc) {
> +		dev_err(dev, "register location dvsec not found\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> +	/* PCI class code for CXL.mem Type-3 Devices */
> +	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF, 0xffffff, 0 },

Having looked at this and thought 'thats a bit tricky to check'
I did a quick grep and seems the kernel is split between this approach
and people going with the mor readable c99 style initiators
	.class = .. etc

Personally I'd find the c99 approach easier to read. 

> +	{ /* terminate list */ },
> +};
> +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> +
> +static struct pci_driver cxl_mem_driver = {
> +	.name			= KBUILD_MODNAME,
> +	.id_table		= cxl_mem_pci_tbl,
> +	.probe			= cxl_mem_probe,
> +	.driver	= {
> +		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +};
> +
> +MODULE_LICENSE("GPL v2");
> +module_pci_driver(cxl_mem_driver);
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> new file mode 100644
> index 000000000000..f135b9f7bb21
> --- /dev/null
> +++ b/drivers/cxl/pci.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#ifndef __CXL_PCI_H__
> +#define __CXL_PCI_H__
> +
> +#define CXL_MEMORY_PROGIF	0x10
> +
> +/*
> + * See section 8.1 Configuration Space Registers in the CXL 2.0
> + * Specification
> + */
> +#define PCI_EXT_CAP_ID_DVSEC		0x23

This is already in include/uapi/linux/pci_regs.h

> +#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> +#define PCI_DVSEC_ID_CXL		0x0
> +
> +#define PCI_DVSEC_ID_CXL_REGLOC_OFFSET		0x8
> +
> +#endif /* __CXL_PCI_H__ */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d8156a5dbee8..766260a9b247 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -51,6 +51,7 @@
>  #define PCI_BASE_CLASS_MEMORY		0x05
>  #define PCI_CLASS_MEMORY_RAM		0x0500
>  #define PCI_CLASS_MEMORY_FLASH		0x0501
> +#define PCI_CLASS_MEMORY_CXL		0x0502
>  #define PCI_CLASS_MEMORY_OTHER		0x0580
>  
>  #define PCI_BASE_CLASS_BRIDGE		0x06

