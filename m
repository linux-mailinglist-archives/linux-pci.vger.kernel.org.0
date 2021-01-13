Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448342F4B7A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 13:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbhAMMk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jan 2021 07:40:57 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38487 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbhAMMk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jan 2021 07:40:57 -0500
Received: by mail-oi1-f174.google.com with SMTP id x13so1924928oic.5;
        Wed, 13 Jan 2021 04:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wrftjWGDDgoG0KhD8U3/hd/ULEYIjOtZB8goRQqzdCs=;
        b=JQuqHzbrqa9WgsVrQciBsIX9OV951sRmc+nsUIi3ywgnzYlVehlVy7FFlE+ldl1lKY
         ltCHX9wkQIXRsKVbnL+p0qqGXHNx2E7/A9zB41jCab0Cv8WRbj3FVOeFoOThF5IfhkpV
         D6IQzXqaVwCsh7rpO8YNth6ob/BvCd9OgXKCVPeglBq0ENAGneYUtQN5zYAsyMB23mPZ
         +G7BTwXBE4wFrLwmDVOAZSvmO+VNUw60xJr+YErOgRedWTZj0zOxPk7PnwlU0xbW9mz6
         mYwisle7oRimoebpAcoG576T7WnKmKnlfGbjICFc2qQ/nsSaZS17P3tgcDAgP+4lDOe9
         kvLg==
X-Gm-Message-State: AOAM532LT3vZyEbyZsYBJRfJ20vPu2+/ikkX+5g5rQNt10RGwbHFGb6X
        yIWnmnge6LNOORohoS0V1EB3i775GQRsEsqfe4A=
X-Google-Smtp-Source: ABdhPJw13BcxY6VWRUbuIxSKDChx/Zck2ok1szTNO1QFozmw2Bo8hMHfYO/UhsZvBNaiz/P/0NRhkIBqQvuT82X50Kg=
X-Received: by 2002:aca:d6c8:: with SMTP id n191mr966165oig.69.1610541615332;
 Wed, 13 Jan 2021 04:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com> <20210111225121.820014-3-ben.widawsky@intel.com>
In-Reply-To: <20210111225121.820014-3-ben.widawsky@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jan 2021 13:40:01 +0100
Message-ID: <CAJZ5v0h56q2+1U2DpMoAX-7vxs32hz+SRE_02mucoMY1tiUFiw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     Ben Widawsky <ben.widawsky@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 1:29 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> From: Vishal Verma <vishal.l.verma@intel.com>
>
> Add an acpi_cxl module to coordinate the ACPI portions of the CXL
> (Compute eXpress Link) interconnect. This driver binds to ACPI0017
> objects in the ACPI tree, and coordinates access to the resources
> provided by the ACPI CEDT (CXL Early Discovery Table).
>
> It also coordinates operations of the root port _OSC object to notify
> platform firmware that the OS has native support for the CXL
> capabilities of endpoints.

This doesn't happen here, but in the next patch.

> Note: the actbl1.h changes are speculative. The expectation is that they
> will arrive through the ACPICA tree in due time.

So why don't you put them into a separate patch and drop it from the
series when not necessary any more?

> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/Kconfig       |  1 +
>  drivers/Makefile      |  1 +
>  drivers/cxl/Kconfig   | 36 ++++++++++++++++
>  drivers/cxl/Makefile  |  5 +++
>  drivers/cxl/acpi.c    | 97 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/acpi.h    | 15 +++++++
>  include/acpi/actbl1.h | 50 ++++++++++++++++++++++
>  7 files changed, 205 insertions(+)
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
> index fd11b9ac4cc3..678ea810410f 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_NVM)             += lightnvm/
>  obj-y                          += base/ block/ misc/ mfd/ nfc/
>  obj-$(CONFIG_LIBNVDIMM)                += nvdimm/
>  obj-$(CONFIG_DAX)              += dax/
> +obj-$(CONFIG_CXL_BUS)          += cxl/
>  obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
>  obj-$(CONFIG_NUBUS)            += nubus/
>  obj-y                          += macintosh/
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..68da926ba5b1
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +       tristate "CXL (Compute Express Link) Devices Support"
> +       help
> +         CXL is a bus that is electrically compatible with PCI-E, but layers
> +         three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem).
> +         The CXL.cache protocol allows devices to hold cachelines locally, the
> +         CXL.mem protocol allows devices to be fully coherent memory targets,
> +         the CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support
> +         for the configuration and management of devices supporting these
> +         protocols.
> +
> +if CXL_BUS
> +
> +config CXL_BUS_PROVIDER
> +       tristate
> +
> +config CXL_ACPI
> +       tristate "CXL ACPI: Platform Support"
> +       depends on ACPI
> +       default CXL_BUS
> +       select CXL_BUS_PROVIDER
> +       help
> +         Say 'y/m' to enable a driver (named "cxl_acpi.ko" when built
> +         as a module) that will enable support for CXL.mem endpoint
> +         devices. In general, CXL Platform Support is a prerequisite
> +         for any CXL device driver that wants to claim ownership of a
> +         component register space. By default platform firmware assumes
> +         Linux is unaware of CXL capabilities and requires explicit
> +         opt-in. This platform component also mediates resources
> +         described by the CEDT (CXL Early Discovery Table).  See
> +         Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL 2.0
> +         specification.
> +
> +         If unsure say 'm'

Missing full stop.

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
> index 000000000000..0f1ba9b3f1ed
> --- /dev/null
> +++ b/drivers/cxl/acpi.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/platform_device.h>
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
> +/*
> + * If/when CXL support is defined by other platform firmware the kernel
> + * will need a mechanism to select between the platform specific version
> + * of this routine, until then, hard-code ACPI assumptions
> + */
> +int cxl_bus_acquire(struct pci_dev *pdev)
> +{
> +       struct acpi_device *adev;
> +       struct pci_dev *root_port;
> +       struct device *root;
> +
> +       root_port = pcie_find_root_port(pdev);
> +       if (!root_port)
> +               return -ENXIO;
> +
> +       root = root_port->dev.parent;
> +       if (!root)
> +               return -ENXIO;
> +
> +       adev = ACPI_COMPANION(root);
> +       if (!adev)
> +               return -ENXIO;
> +
> +       /* TODO: OSC enabling */
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(cxl_bus_acquire);

I would move the addition of cxl_bus_acquire() entirely to the next
patch, it looks quite confusing to me as is.

> +
> +static void acpi_cedt_put_table(void *table)
> +{
> +       acpi_put_table(table);
> +}
> +
> +static int cxl_acpi_probe(struct platform_device *pdev)
> +{
> +       struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +       struct cxl_acpi_desc *acpi_desc;
> +       struct device *dev = &adev->dev;
> +       struct acpi_table_header *tbl;
> +       acpi_status status;
> +       acpi_size sz;
> +       int rc;
> +
> +       status = acpi_get_table(ACPI_SIG_CEDT, 0, &tbl);
> +       if (ACPI_FAILURE(status)) {
> +               dev_err(dev, "failed to find CEDT at startup\n");
> +               return 0;
> +       }
> +
> +       rc = devm_add_action_or_reset(dev, acpi_cedt_put_table, tbl);
> +       if (rc)
> +               return rc;
> +
> +       sz = tbl->length;
> +       dev_info(dev, "found CEDT at startup: %lld bytes\n", sz);
> +
> +       acpi_desc = devm_kzalloc(dev, sizeof(*acpi_desc), GFP_KERNEL);
> +       if (!acpi_desc)
> +               return -ENOMEM;
> +
> +       dev_set_drvdata(&adev->dev, acpi_desc);
> +       acpi_desc->dev = &adev->dev;
> +       acpi_desc->acpi_header = *tbl;
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id cxl_acpi_ids[] = {
> +       { "ACPI0017", 0 },
> +       { "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
> +
> +static struct platform_driver cxl_acpi_driver = {
> +       .probe = cxl_acpi_probe,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .acpi_match_table = cxl_acpi_ids,
> +       },
> +};
> +
> +module_platform_driver(cxl_acpi_driver);
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
> new file mode 100644
> index 000000000000..d638f8886ab7
> --- /dev/null
> +++ b/drivers/cxl/acpi.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +
> +#ifndef __CXL_ACPI_H__
> +#define __CXL_ACPI_H__
> +#include <linux/acpi.h>
> +
> +struct cxl_acpi_desc {
> +       struct acpi_table_header acpi_header;
> +       struct device *dev;
> +};
> +
> +int cxl_bus_acquire(struct pci_dev *pci_dev);

And so this should go to the next patch too IMV.

> +
> +#endif /* __CXL_ACPI_H__ */
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 43549547ed3e..f3a0303984c8 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -28,6 +28,7 @@
>  #define ACPI_SIG_BERT           "BERT" /* Boot Error Record Table */
>  #define ACPI_SIG_BGRT           "BGRT" /* Boot Graphics Resource Table */
>  #define ACPI_SIG_BOOT           "BOOT" /* Simple Boot Flag Table */
> +#define ACPI_SIG_CEDT           "CEDT" /* CXL Early Discovery Table */
>  #define ACPI_SIG_CPEP           "CPEP" /* Corrected Platform Error Polling table */
>  #define ACPI_SIG_CSRT           "CSRT" /* Core System Resource Table */
>  #define ACPI_SIG_DBG2           "DBG2" /* Debug Port table type 2 */
> @@ -1624,6 +1625,55 @@ struct acpi_ibft_target {
>         u16 reverse_chap_secret_offset;
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
> +       struct acpi_table_header header;        /* Common ACPI table header */
> +       u32 reserved;
> +};
> +
> +/* Values for CEDT structure types */
> +
> +enum acpi_cedt_type {
> +       ACPI_CEDT_TYPE_HOST_BRIDGE = 0, /* CHBS - CXL Host Bridge Structure */
> +};
> +
> +struct acpi_cedt_structure {
> +       u8 type;
> +       u8 reserved;
> +       u16 length;
> +};
> +
> +/*
> + * CEDT Structures, correspond to Type in struct acpi_cedt_structure
> + */
> +
> +/* 0: CXL Host Bridge Structure */
> +
> +struct acpi_cedt_chbs {
> +       struct acpi_cedt_structure header;
> +       u32 uid;
> +       u32 version;
> +       u32 reserved1;
> +       u64 base;
> +       u64 length;
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
> --
> 2.30.0
>
