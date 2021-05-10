Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49186379273
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhEJPVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:21:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3048 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbhEJPUf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 11:20:35 -0400
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff4Ds44Gtz70gDT;
        Mon, 10 May 2021 23:08:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 17:19:26 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 16:19:26 +0100
Date:   Mon, 10 May 2021 16:17:44 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 3/8] cxl/core: Rename bus.c to core.c
Message-ID: <20210510161744.00007404@Huawei.com>
In-Reply-To: <162042789118.1202325.17252779312531377335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
        <162042789118.1202325.17252779312531377335.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.16]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 May 2021 15:51:31 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for more generic shared functionality across endpoint
> consumers of core cxl resources, and platform-firmware producers of
> those resources, rename bus.c to core.c. In addition to the central
> rendezvous for interleave coordination, the core will also define common
> routines like CXL register block mapping.
> 
> Acked-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/driver-api/cxl/memory-devices.rst |    6 ++---
>  drivers/cxl/Makefile                            |    4 ++-
>  drivers/cxl/bus.c                               |   29 ----------------------
>  drivers/cxl/core.c                              |   30 +++++++++++++++++++++++
>  4 files changed, 35 insertions(+), 34 deletions(-)
>  delete mode 100644 drivers/cxl/bus.c
>  create mode 100644 drivers/cxl/core.c
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 1bad466f9167..71495ed77069 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -28,10 +28,10 @@ CXL Memory Device
>  .. kernel-doc:: drivers/cxl/mem.c
>     :internal:
>  
> -CXL Bus
> +CXL Core
>  -------
> -.. kernel-doc:: drivers/cxl/bus.c
> -   :doc: cxl bus
> +.. kernel-doc:: drivers/cxl/core.c
> +   :doc: cxl core
>  
>  External Interfaces
>  ===================
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index a314a1891f4d..3808e39dd31f 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_CXL_BUS) += cxl_bus.o
> +obj-$(CONFIG_CXL_BUS) += cxl_core.o
>  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> -cxl_bus-y := bus.o
> +cxl_core-y := core.o
>  cxl_mem-y := mem.o
> diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
> deleted file mode 100644
> index 58f74796d525..000000000000
> --- a/drivers/cxl/bus.c
> +++ /dev/null
> @@ -1,29 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/device.h>
> -#include <linux/module.h>
> -
> -/**
> - * DOC: cxl bus
> - *
> - * The CXL bus provides namespace for control devices and a rendezvous
> - * point for cross-device interleave coordination.
> - */
> -struct bus_type cxl_bus_type = {
> -	.name = "cxl",
> -};
> -EXPORT_SYMBOL_GPL(cxl_bus_type);
> -
> -static __init int cxl_bus_init(void)
> -{
> -	return bus_register(&cxl_bus_type);
> -}
> -
> -static void cxl_bus_exit(void)
> -{
> -	bus_unregister(&cxl_bus_type);
> -}
> -
> -module_init(cxl_bus_init);
> -module_exit(cxl_bus_exit);
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> new file mode 100644
> index 000000000000..7f8d2034038a
> --- /dev/null
> +++ b/drivers/cxl/core.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +/**
> + * DOC: cxl core
> + *
> + * The CXL core provides a sysfs hierarchy for control devices and a rendezvous
> + * point for cross-device interleave coordination through cxl ports.
> + */
> +
> +struct bus_type cxl_bus_type = {
> +	.name = "cxl",
> +};
> +EXPORT_SYMBOL_GPL(cxl_bus_type);
> +
> +static __init int cxl_core_init(void)
> +{
> +	return bus_register(&cxl_bus_type);
> +}
> +
> +static void cxl_core_exit(void)
> +{
> +	bus_unregister(&cxl_bus_type);
> +}
> +
> +module_init(cxl_core_init);
> +module_exit(cxl_core_exit);
> +MODULE_LICENSE("GPL v2");
> 

