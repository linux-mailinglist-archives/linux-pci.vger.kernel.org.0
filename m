Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F4B459086
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 15:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238607AbhKVOu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 09:50:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4127 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238634AbhKVOu4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 09:50:56 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyVQN18Hpz6H8Xh;
        Mon, 22 Nov 2021 22:43:56 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 15:47:47 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 14:47:46 +0000
Date:   Mon, 22 Nov 2021 14:47:45 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 01/23] cxl: Rename CXL_MEM to CXL_PCI
Message-ID: <20211122144745.00000dc9@Huawei.com>
In-Reply-To: <20211120000250.1663391-2-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:28 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
> Rename mem to pci"). In preparation for adding an ancillary driver for
> cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
> rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
> that new driver to manage CXL.mem endpoint operations.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Makes sense to me, particularly as it brings it inline with the file name.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes since RFCv2:
> - Reword commit message (Dan)
> - Reword Kconfig description (Dan)
> ---
>  drivers/cxl/Kconfig  | 23 ++++++++++++-----------
>  drivers/cxl/Makefile |  2 +-
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67c91378f2dd..ef05e96f8f97 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -13,25 +13,26 @@ menuconfig CXL_BUS
>  
>  if CXL_BUS
>  
> -config CXL_MEM
> -	tristate "CXL.mem: Memory Devices"
> +config CXL_PCI
> +	tristate "PCI manageability"
>  	default CXL_BUS
>  	help
> -	  The CXL.mem protocol allows a device to act as a provider of
> -	  "System RAM" and/or "Persistent Memory" that is fully coherent
> -	  as if the memory was attached to the typical CPU memory
> -	  controller.
> +	  The CXL specification defines a "CXL memory device" sub-class in the
> +	  PCI "memory controller" base class of devices. Device's identified by
> +	  this class code provide support for volatile and / or persistent
> +	  memory to be mapped into the system address map (Host-managed Device
> +	  Memory (HDM)).
>  
> -	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> -	  configuration and management primarily via the mailbox interface. See
> -	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
> -	  details.
> +	  Say 'y/m' to enable a driver that will attach to CXL memory expander
> +	  devices enumerated by the memory device class code for configuration
> +	  and management primarily via the mailbox interface. See Chapter 2.3
> +	  Type 3 CXL Device in the CXL 2.0 specification for more details.
>  
>  	  If unsure say 'm'.
>  
>  config CXL_MEM_RAW_COMMANDS
>  	bool "RAW Command Interface for Memory Devices"
> -	depends on CXL_MEM
> +	depends on CXL_PCI
>  	help
>  	  Enable CXL RAW command interface.
>  
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d1aaabc940f3..cf07ae6cea17 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += core/
> -obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> +obj-$(CONFIG_CXL_PCI) += cxl_pci.o
>  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>  obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
>  

