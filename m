Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00E2B4EBC
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 19:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387689AbgKPR71 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:59:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2108 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbgKPR70 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:59:26 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CZcHN4tVpz67DQk;
        Tue, 17 Nov 2020 01:57:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 18:59:24 +0100
Received: from localhost (10.52.125.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 16 Nov
 2020 17:59:23 +0000
Date:   Mon, 16 Nov 2020 17:59:16 +0000
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
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Message-ID: <20201116175916.000008bc@Huawei.com>
In-Reply-To: <20201111054356.793390-2-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.36]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:48 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Vishal Verma <vishal.l.verma@intel.com>
> 
> Add an acpi_cxl module to coordinate the ACPI portions of the CXL
> (Compute eXpress Link) interconnect. This driver binds to ACPI0017
> objects in the ACPI tree, and coordinates access to the resources
> provided by the ACPI CEDT (CXL Early Discovery Table).

I think the qemu series notes that this ACPI0017 is just a proposal at
this stage. Please make sure that's highlighted here as well unless
that status is out of date.

> 
> It also coordinates operations of the root port _OSC object to notify
> platform firmware that the OS has native support for the CXL
> capabilities of endpoints.
> 
> Note: the actbl1.h changes are speculative. The expectation is that they
> will arrive through the ACPICA tree in due time.
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/Kconfig       |   1 +
>  drivers/Makefile      |   1 +
>  drivers/cxl/Kconfig   |  30 +++++++++++
>  drivers/cxl/Makefile  |   5 ++
>  drivers/cxl/acpi.c    | 119 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.h    |  15 ++++++
>  include/acpi/actbl1.h |  52 ++++++++++++++++++
>  7 files changed, 223 insertions(+)
>  create mode 100644 drivers/cxl/Kconfig
>  create mode 100644 drivers/cxl/Makefile
>  create mode 100644 drivers/cxl/acpi.c
>  create mode 100644 drivers/cxl/acpi.h
> 
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
> index c0cd1b9075e3..5dad349de73b 100644
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
> index 000000000000..dd724bd364df
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	help
> +	  CXL is a bus that is electrically compatible with PCI-E, but layers
> +	  three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem). The
> +	  CXL.cache protocol allows devices to hold cachelines locally, the
> +	  CXL.mem protocol allows devices to be fully coherent memory targets, the
> +	  CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support for
> +	  the configuration and management of devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_BUS_PROVIDER
> +	tristate
> +
> +config CXL_ACPI
> +	tristate "CXL Platform Support"
> +	depends on ACPI
> +	default CXL_BUS
> +	select CXL_BUS_PROVIDER
> +	help
> +	  CXL Platform Support is a prerequisite for any CXL device driver that
> +	  wants to claim ownership of the component register space. By default
> +	  platform firmware assumes Linux is unaware of CXL capabilities and
> +	  requires explicit opt-in. This platform component also mediates
> +	  resources described by the CEDT (CXL Early Discovery Table)
> +
> +	  Say 'y' to enable CXL (Compute Express Link) drivers.
> +endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> new file mode 100644
> index 000000000000..d38cd34a2582
> --- /dev/null
> +++ b/drivers/cxl/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> +
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> +cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> new file mode 100644
> index 000000000000..26e4f73838a7
> --- /dev/null
> +++ b/drivers/cxl/acpi.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright(c) 2020 Intel Corporation. All rights reserved.
> + */
> +#include <linux/list_sort.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/sysfs.h>
> +#include <linux/list.h>
> +#include <linux/acpi.h>
> +#include <linux/sort.h>
> +#include <linux/pci.h>
> +#include "acpi.h"
> +
> +static void acpi_cxl_desc_init(struct acpi_cxl_desc *acpi_desc, struct device *dev)
> +{
> +	dev_set_drvdata(dev, acpi_desc);

No need to have this wrapper + it hides the fact you are not just initialsing
the acpi_desc structure.

> +	acpi_desc->dev = dev;
> +}
> +
> +static void acpi_cedt_put_table(void *table)
> +{
> +	acpi_put_table(table);
> +}
> +
> +static int acpi_cxl_add(struct acpi_device *adev)
> +{
> +	struct acpi_cxl_desc *acpi_desc;
> +	struct device *dev = &adev->dev;
> +	struct acpi_table_header *tbl;
> +	acpi_status status = AE_OK;

Set below, so don't do it here.

> +	acpi_size sz;
> +	int rc = 0;

Set in paths in which it's used so don't do it here.

> +
> +	status = acpi_get_table(ACPI_SIG_CEDT, 0, &tbl);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to find CEDT at startup\n");
> +		return 0;
> +	}
> +
> +	rc = devm_add_action_or_reset(dev, acpi_cedt_put_table, tbl);
> +	if (rc)
> +		return rc;

blank line here preferred for readability (do something, then check errors as
block)

> +	sz = tbl->length;
> +	dev_info(dev, "found CEDT at startup: %lld bytes\n", sz);
> +
> +	acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
> +	if (!acpi_desc)
> +		return -ENOMEM;

blank line here slightly helps readability.

> +	acpi_cxl_desc_init(acpi_desc, &adev->dev);
> +
> +	acpi_desc->acpi_header = *tbl;
> +
> +	return 0;
> +}
> +
> +static int acpi_cxl_remove(struct acpi_device *adev)
> +{
> +	return 0;

Don't think empty remove is needed.


> +}
> +
> +static const struct acpi_device_id acpi_cxl_ids[] = {
> +	{ "ACPI0017", 0 },
> +	{ "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_cxl_ids);
> +
> +static struct acpi_driver acpi_cxl_driver = {
> +	.name = KBUILD_MODNAME,
> +	.ids = acpi_cxl_ids,
> +	.ops = {
> +		.add = acpi_cxl_add,
> +		.remove = acpi_cxl_remove,
> +	},
> +};
> +
> +/*
> + * If/when CXL support is defined by other platform firmware the kernel
> + * will need a mechanism to select between the platform specific version
> + * of this routine, until then, hard-code ACPI assumptions
> + */
> +int cxl_bus_prepared(struct pci_dev *pdev)
> +{
> +	struct acpi_device *adev;
> +	struct pci_dev *root_port;
> +	struct device *root;
> +
> +	root_port = pcie_find_root_port(pdev);
> +	if (!root_port)
> +		return -ENXIO;
> +
> +	root = root_port->dev.parent;
> +	if (!root)
> +		return -ENXIO;
> +
> +	adev = ACPI_COMPANION(root);
> +	if (!adev)
> +		return -ENXIO;
> +
> +	/* TODO: OSC enabling */
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_bus_prepared);
> +
> +static __init int acpi_cxl_init(void)
> +{
> +	return acpi_bus_register_driver(&acpi_cxl_driver);
> +}
> +
> +static __exit void acpi_cxl_exit(void)
> +{
> +	acpi_bus_unregister_driver(&acpi_cxl_driver);
> +}
> +
> +module_init(acpi_cxl_init);
> +module_exit(acpi_cxl_exit);
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Intel Corporation");
> diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
> new file mode 100644
> index 000000000000..011505475cc6
> --- /dev/null
> +++ b/drivers/cxl/acpi.h
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +
> +#ifndef __CXL_ACPI_H__
> +#define __CXL_ACPI_H__
> +#include <linux/acpi.h>
> +
> +struct acpi_cxl_desc {
> +	struct acpi_table_header acpi_header;
> +	struct device *dev;
> +};
> +
> +int cxl_bus_prepared(struct pci_dev *pci_dev);
> +
> +#endif	/* __CXL_ACPI_H__ */
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 43549547ed3e..70f745f526e3 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -28,6 +28,7 @@
>  #define ACPI_SIG_BERT           "BERT"	/* Boot Error Record Table */
>  #define ACPI_SIG_BGRT           "BGRT"	/* Boot Graphics Resource Table */
>  #define ACPI_SIG_BOOT           "BOOT"	/* Simple Boot Flag Table */
> +#define ACPI_SIG_CEDT           "CEDT"	/* CXL Early Discovery Table */
>  #define ACPI_SIG_CPEP           "CPEP"	/* Corrected Platform Error Polling table */
>  #define ACPI_SIG_CSRT           "CSRT"	/* Core System Resource Table */
>  #define ACPI_SIG_DBG2           "DBG2"	/* Debug Port table type 2 */
> @@ -1624,6 +1625,57 @@ struct acpi_ibft_target {
>  	u16 reverse_chap_secret_offset;
>  };
>  
> +/*******************************************************************************
> + *
> + * CEDT - CXL Early Discovery Table (ACPI 6.4)
> + *        Version 1
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_cedt {
> +	struct acpi_table_header header;	/* Common ACPI table header */
> +	u32 reserved;
> +};
> +
> +/* Values for CEDT structure types */
> +
> +enum acpi_cedt_type {
> +	ACPI_CEDT_TYPE_HOST_BRIDGE = 0, /* CHBS - CXL Host Bridge Structure */
> +	ACPI_CEDT_TYPE_CFMWS = 1, 	/* CFMWS - CXL Fixed Memory Window Structure */

This isn't in the 2.0 spec, so I guess also part of some proposed changes.

> +};
> +
> +struct acpi_cedt_structure {
> +	u8 type;
> +	u8 reserved;
> +	u16 length;
> +};
> +
> +/*
> + * CEDT Structures, correspond to Type in struct acpi_cedt_structure
> + */
> +
> +/* 0: CXL Host Bridge Structure */
> +
> +struct acpi_cedt_chbs {
> +	struct acpi_cedt_structure header;
> +	u32 uid;
> +	u32 version;
> +	u32 reserved1;
> +	u64 base;
> +	u32 length;
> +	u32 reserved2;
> +};
> +
> +/* Values for version field above */
> +
> +#define ACPI_CEDT_CHBS_VERSION_CXL11    (0)
> +#define ACPI_CEDT_CHBS_VERSION_CXL20    (1)
> +
> +/* Values for length field above */
> +
> +#define ACPI_CEDT_CHBS_LENGTH_CXL11     (0x2000)
> +#define ACPI_CEDT_CHBS_LENGTH_CXL20     (0x10000)
> +
>  /* Reset to default packing */
>  
>  #pragma pack()

