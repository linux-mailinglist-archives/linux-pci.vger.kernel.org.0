Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBDA2F65F2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 17:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbhANQ3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 11:29:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2345 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANQ3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 11:29:44 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DGqPf5XMQz67ZHx;
        Fri, 15 Jan 2021 00:23:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 14 Jan 2021 17:29:02 +0100
Received: from localhost (10.47.30.252) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Thu, 14 Jan
 2021 16:29:01 +0000
Date:   Thu, 14 Jan 2021 16:28:22 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 08/16] cxl/mem: Register CXL memX devices
Message-ID: <20210114162822.00002797@Huawei.com>
In-Reply-To: <20210111225121.820014-9-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.30.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Jan 2021 14:51:12 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Create the /sys/bus/cxl hierarchy to enumerate memory devices
> (per-endpoint control devices), memory address space devices (platform
> address ranges with interleaving, performance, and persistence
> attributes), and memory regions (active provisioned memory from an
> address space device that is in use as System RAM or delegated to
> libnvdimm as Persistent Memory regions).
> 
> For now, only the per-endpoint control devices are registered on the
> 'cxl' bus.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Don't hide the driver core change inside a patch doing other stuff.
(it is a nice change though!)

Otherwise, just a request for units in the sysfs ABI docs.

Jonathan


> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  26 +++
>  Documentation/cxl/memory-devices.rst    |   3 +
>  drivers/base/core.c                     |  14 ++
>  drivers/cxl/Makefile                    |   2 +
>  drivers/cxl/bus.c                       |  54 +++++
>  drivers/cxl/bus.h                       |   8 +
>  drivers/cxl/cxl.h                       |   3 +
>  drivers/cxl/mem.c                       | 282 +++++++++++++++++++++++-
>  include/linux/device.h                  |   1 +
>  9 files changed, 392 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
>  create mode 100644 drivers/cxl/bus.c
>  create mode 100644 drivers/cxl/bus.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> new file mode 100644
> index 000000000000..fe7b87eba988
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -0,0 +1,26 @@
> +What:		/sys/bus/cxl/devices/memX/firmware_version
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "FW Revision" string as reported by the Identify
> +		Memory Device Output Payload in the CXL-2.0
> +		specification.
> +
> +What:		/sys/bus/cxl/devices/memX/ram/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Volatile Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.

Nice to see the format /units of these described in this doc as well as the spec.
Section number etc also good if you can add it to these docs.

> +
> +What:		/sys/bus/cxl/devices/memX/pmem/size
> +Date:		December, 2020
> +KernelVersion:	v5.12
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) "Persistent Only Capacity" as reported by the
> +		Identify Memory Device Output Payload in the CXL-2.0
> +		specification.
> diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
> index 134c9b6b4ff4..5f723c25382b 100644
> --- a/Documentation/cxl/memory-devices.rst
> +++ b/Documentation/cxl/memory-devices.rst
> @@ -37,3 +37,6 @@ External Interfaces
>  
>  .. kernel-doc:: drivers/cxl/acpi.c
>     :export:
> +
> +.. kernel-doc:: drivers/cxl/bus.c
> +   :export:
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 25e08e5f40bd..33432a4cbe23 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3179,6 +3179,20 @@ struct device *get_device(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(get_device);
>  
> +/**
> + * get_live_device() - increment reference count for device iff !dead
> + * @dev: device.
> + *
> + * Forward the call to get_device() if the device is still alive. If
> + * this is called with the device_lock() held then the device is
> + * guaranteed to not die until the device_lock() is dropped.
> + */

I like the idea of a nice generic wrapper for this but definitely not
deep inside a patch doing something else.

> +struct device *get_live_device(struct device *dev)
> +{
> +	return dev && !dev->p->dead ? get_device(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(get_live_device);
> +
...

