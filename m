Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2392B67E1
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 15:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbgKQOtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 09:49:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2117 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbgKQOts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 09:49:48 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb81K08n6z67D2G;
        Tue, 17 Nov 2020 22:47:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 15:49:44 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 14:49:43 +0000
Date:   Tue, 17 Nov 2020 14:49:35 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Message-ID: <20201117144935.00006dee@Huawei.com>
In-Reply-To: <20201111054356.793390-4-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-4-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:50 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL.mem protocol allows a device to act as a provider of "System
> RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> was attached to the typical CPU memory controller.
> 
> The memory range exported by the device may optionally be described by
> the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> provision persistent memory capacity from one, or more, CXL.mem devices.
> 
> A pre-requisite for Linux-managed memory-capacity provisioning is this
> cxl_mem driver that can speak the "type-3 mailbox" protocol.
> 
> For now just land the driver boiler-plate and fill it in with
> functionality in subsequent commits.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

I've tried to avoid repeats, so mostly this is me moaning about naming!

Jonathan

> ---
>  drivers/cxl/Kconfig  | 20 +++++++++++
>  drivers/cxl/Makefile |  2 ++
>  drivers/cxl/mem.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.h    | 15 ++++++++
>  4 files changed, 119 insertions(+)
>  create mode 100644 drivers/cxl/mem.c
>  create mode 100644 drivers/cxl/pci.h
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index dd724bd364df..15548f5c77ff 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -27,4 +27,24 @@ config CXL_ACPI
>  	  resources described by the CEDT (CXL Early Discovery Table)
>  
>  	  Say 'y' to enable CXL (Compute Express Link) drivers.
> +
> +config CXL_MEM
> +        tristate "CXL.mem Device Support"
> +        depends on PCI && CXL_BUS_PROVIDER != n
> +        default m if CXL_BUS_PROVIDER
> +        help
> +          The CXL.mem protocol allows a device to act as a provider of
> +          "System RAM" and/or "Persistent Memory" that is fully coherent
> +          as if the memory was attached to the typical CPU memory
> +          controller.
> +
> +          Say 'y/m' to enable a driver named "cxl_mem.ko" that will attach
> +          to CXL.mem devices for configuration, provisioning, and health
> +          monitoring, the so called "type-3 mailbox". Note, this driver
> +          is required for dynamic provisioning of CXL.mem attached
> +          memory, a pre-requisite for persistent memory support, but
> +          devices that provide volatile memory may be fully described by
> +          existing platform firmware memory enumeration.
> +
> +          If unsure say 'n'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d38cd34a2582..97fdffb00f2d 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
>  cxl_acpi-y := acpi.o
> +cxl_mem-y := mem.o
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..aa7d881fa47b
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include "acpi.h"
> +#include "pci.h"
> +
> +struct cxl_mem {
> +	void __iomem *regs;
> +};
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
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);

This is good generic code and wouldn't cause much backport effort (even if needed
to bring in a local copy), so perhaps make it a generic function and move to
core PCI code?

Mind you I guess that can happen the 'second' time someone wants to find a DVSEC.

> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cxl_mem *cxlm;
> +	int rc, regloc;
> +
> +	rc = cxl_bus_prepared(pdev);
> +	if (rc != 0) {
> +		dev_err(dev, "failed to acquire interface\n");
> +		return rc;
> +	}
> +
> +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> +	if (!regloc) {
> +		dev_err(dev, "register location dvsec not found\n");
> +		return -ENXIO;
> +	}
> +
> +	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> +	if (!cxlm)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void cxl_mem_remove(struct pci_dev *pdev)
> +{
> +}

I'd bring this in only when needed in later patch.

> +
> +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> +	/* PCI class code for CXL.mem Type-3 Devices */
> +	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
> +	{ /* terminate list */ },
> +};
> +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> +
> +static struct pci_driver cxl_mem_driver = {
> +	.name			= KBUILD_MODNAME,
> +	.id_table		= cxl_mem_pci_tbl,
> +	.probe			= cxl_mem_probe,
> +	.remove			= cxl_mem_remove,
> +};
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Intel Corporation");
> +module_pci_driver(cxl_mem_driver);
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> new file mode 100644
> index 000000000000..beb03921e6da
> --- /dev/null
> +++ b/drivers/cxl/pci.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +#ifndef __CXL_PCI_H__
> +#define __CXL_PCI_H__
> +
> +#define PCI_CLASS_MEMORY_CXL	0x050210
> +
> +#define PCI_EXT_CAP_ID_DVSEC	0x23
> +#define PCI_DVSEC_VENDOR_CXL	0x1E98

Hmm. The magic question of what to call a vendor ID that isn't a vendor
ID but just a magic number that talks like a duck and quacks like a duck
(for anyone wondering what I'm talking about, there is a nice bit of legal
boilerplate on this in the CXL spec)

This name is definitely not accurate however.

PCI_UNIQUE_VALUE_CXL maybe?  It is used for other things than DVSEC (VDMs etc),
though possibly this is the only software visible use.


> +#define PCI_DVSEC_VENDOR_OFFSET	0x4
> +#define PCI_DVSEC_ID_OFFSET	0x8

Put a line break here perhaps and maybe a spec reference to where to find
the various DVSEC IDs.

> +#define PCI_DVSEC_ID_CXL	0x0

That's definitely a confusing name as well.

PCI_DEVSEC_ID_CXL_DEVICE maybe?


> +#define PCI_DVSEC_ID_CXL_REGLOC	0x8
> +
> +#endif /* __CXL_PCI_H__ */

