Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FB13795FB
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 19:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbhEJRdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 13:33:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3055 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhEJRcm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 13:32:42 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ff7Dn4n29z6wjkV;
        Tue, 11 May 2021 01:23:21 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 10 May 2021 19:31:35 +0200
Received: from localhost (10.52.123.16) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 10 May
 2021 18:31:34 +0100
Date:   Mon, 10 May 2021 18:29:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] cxl: Rename mem to pci
Message-ID: <20210510182952.00006e49@Huawei.com>
In-Reply-To: <20210504185731.1058813-1-ben.widawsky@intel.com>
References: <20210504185731.1058813-1-ben.widawsky@intel.com>
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

On Tue, 4 May 2021 11:57:31 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> In preparation for introducing a new driver for the CXL.mem / HDM
> decoder (Host-managed Device Memory) capabilities of a CXL memory
> expander, rename mem.c to pci.c so that mem.c is available for this new
> driver.
> 
> CXL capabilities exist in a parallel domain to PCIe. CXL devices are
> enumerable and controllable via "legacy" PCIe mechanisms; however, their
> CXL capabilities are a superset of PCIe. For example, a CXL device may
> be connected to a non-CXL capable PCIe root port, and therefore will not
> be able to participate in CXL.mem or CXL.cache operations, but can still
> be accessed through PCIe mechanisms for CXL.io operations.
> 
> To date, all existing drivers/cxl/ functionality is in support of the
> PCIe-only based mechanisms, and due to the aforementioned distinction it
> makes sense to move to a new file.
> 
> The result of the change is that a systems administrator may load only
> the cxl_pci module and gain access to such operations as, firmware
> update, offline provisioning of devices, and error collection. In
> addition to freeing up the file name for another purpose, there are two
> primary reasons this is useful,
>     1. Acting upon devices which don't have full CXL capabilities. This
>        may happen for instance if the CXL device is connected in a CXL
>        unaware part of the platform topology.
>     2. Userspace-first provisioning for devices without kernel driver
>        interference. This may be useful when provisioning a new device
>        in a specific manner that might otherwise be blocked or prevented
>        by the real CXL mem driver.

The reasons here sound rather speculative to me.   Just arguing that it
makes sense from a layering point of view feels like a simpler justification,
but I'd bring this as a first patch in the series that adds the driver
that sits alongside it (as then the reasoning is self evident).

This is also going to be fun given everyone is touching the same files :)
Maybe git will cope....

Jonathan

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/driver-api/cxl/memory-devices.rst |  6 +++---
>  drivers/cxl/Kconfig                             | 13 ++++---------
>  drivers/cxl/Makefile                            |  4 ++--
>  drivers/cxl/{mem.c => pci.c}                    |  9 ++++-----
>  4 files changed, 13 insertions(+), 19 deletions(-)
>  rename drivers/cxl/{mem.c => pci.c} (99%)
> 
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index 1bad466f9167..3876ee5fea53 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -22,10 +22,10 @@ This section covers the driver infrastructure for a CXL memory device.
>  CXL Memory Device
>  -----------------
>  
> -.. kernel-doc:: drivers/cxl/mem.c
> -   :doc: cxl mem
> +.. kernel-doc:: drivers/cxl/pci.c
> +   :doc: cxl pci
>  
> -.. kernel-doc:: drivers/cxl/mem.c
> +.. kernel-doc:: drivers/cxl/pci.c
>     :internal:
>  
>  CXL Bus
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 97dc4d751651..5483ba92b6da 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -21,15 +21,10 @@ config CXL_MEM
>  	  as if the memory was attached to the typical CPU memory
>  	  controller.
>  
> -	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
> -	  a module) that will attach to CXL.mem devices for
> -	  configuration, provisioning, and health monitoring. This
> -	  driver is required for dynamic provisioning of CXL.mem
> -	  attached memory which is a prerequisite for persistent memory
> -	  support. Typically volatile memory is mapped by platform
> -	  firmware and included in the platform memory map, but in some
> -	  cases the OS is responsible for mapping that memory. See
> -	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
> +	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> +	  configuration and management primarily via the mailbox interface. See
> +	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
> +	  details.
>  
>  	  If unsure say 'm'.
>  
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index a314a1891f4d..22a0ca59ab1b 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_bus.o
> -obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> +obj-$(CONFIG_CXL_MEM) += cxl_pci.o
>  
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
>  cxl_bus-y := bus.o
> -cxl_mem-y := mem.o
> +cxl_pci-y := pci.o
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/pci.c
> similarity index 99%
> rename from drivers/cxl/mem.c
> rename to drivers/cxl/pci.c
> index 2acc6173da36..48fb3f56fc8f 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/pci.c
> @@ -15,10 +15,11 @@
>  #include "cxl.h"
>  
>  /**
> - * DOC: cxl mem
> + * DOC: cxl pci
>   *
> - * This implements a CXL memory device ("type-3") as it is defined by the
> - * Compute Express Link specification.
> + * This implements the PCI exclusive functionality for a CXL device as it is
> + * defined by the Compute Express Link specification. CXL devices may surface
> + * certain functionality even if it isn't CXL enabled.
>   *
>   * The driver has several responsibilities, mainly:
>   *  - Create the memX device and register on the CXL bus.
> @@ -26,8 +27,6 @@
>   *  - Probe the device attributes to establish sysfs interface.
>   *  - Provide an IOCTL interface to userspace to communicate with the device for
>   *    things like firmware update.
> - *  - Support management of interleave sets.
> - *  - Handle and manage error conditions.
>   */
>  
>  /*

