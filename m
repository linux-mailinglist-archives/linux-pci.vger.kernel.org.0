Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B88355AA6
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347042AbhDFRrM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:47:12 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2773 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235624AbhDFRrM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:47:12 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFFCl5kFhz686RW;
        Wed,  7 Apr 2021 01:40:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 19:47:01 +0200
Received: from localhost (10.47.87.56) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 6 Apr 2021
 18:47:01 +0100
Date:   Tue, 6 Apr 2021 17:38:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ben.widawsky@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/8] cxl/mem: Move some definitions to mem.h
Message-ID: <20210406173845.00000bec@Huawei.com>
In-Reply-To: <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728744762.2474040.11009693084215696415.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.56]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Apr 2021 07:30:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for sharing cxl.h with other generic CXL consumers,
> move / consolidate some of the memory device specifics to mem.h.
> 
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Hi Dan,

Would be good to see something in this patch description saying
why you chose to have mem.h rather than push the defines down
into mem.c (which from the current code + patch set looks like
the more logical thing to do).

As a side note, docs for struct cxl_mem need a fix as they cover
enabled_commands which at somepoint got shortened to enabled_cmds

Jonathan

> ---
>  drivers/cxl/cxl.h |   57 ------------------------------------
>  drivers/cxl/mem.c |   25 +---------------
>  drivers/cxl/mem.h |   85 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 81 deletions(-)
>  create mode 100644 drivers/cxl/mem.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6f14838c2d25..2e3bdacb32e7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -34,62 +34,5 @@
>  #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
>  #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
>  
> -/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> -#define CXLMDEV_STATUS_OFFSET 0x0
> -#define   CXLMDEV_DEV_FATAL BIT(0)
> -#define   CXLMDEV_FW_HALT BIT(1)
> -#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> -#define     CXLMDEV_MS_NOT_READY 0
> -#define     CXLMDEV_MS_READY 1
> -#define     CXLMDEV_MS_ERROR 2
> -#define     CXLMDEV_MS_DISABLED 3
> -#define CXLMDEV_READY(status)                                                  \
> -	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
> -	 CXLMDEV_MS_READY)
> -#define   CXLMDEV_MBOX_IF_READY BIT(4)
> -#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> -#define     CXLMDEV_RESET_NEEDED_NOT 0
> -#define     CXLMDEV_RESET_NEEDED_COLD 1
> -#define     CXLMDEV_RESET_NEEDED_WARM 2
> -#define     CXLMDEV_RESET_NEEDED_HOT 3
> -#define     CXLMDEV_RESET_NEEDED_CXL 4
> -#define CXLMDEV_RESET_NEEDED(status)                                           \
> -	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
> -	 CXLMDEV_RESET_NEEDED_NOT)
> -
> -struct cxl_memdev;
> -/**
> - * struct cxl_mem - A CXL memory device
> - * @pdev: The PCI device associated with this CXL device.
> - * @regs: IO mappings to the device's MMIO
> - * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> - * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> - * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> - * @payload_size: Size of space for payload
> - *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> - * @mbox_mutex: Mutex to synchronize mailbox access.
> - * @firmware_version: Firmware version for the memory device.
> - * @enabled_commands: Hardware commands found enabled in CEL.
> - * @pmem_range: Persistent memory capacity information.
> - * @ram_range: Volatile memory capacity information.
> - */
> -struct cxl_mem {
> -	struct pci_dev *pdev;
> -	void __iomem *regs;
> -	struct cxl_memdev *cxlmd;
> -
> -	void __iomem *status_regs;
> -	void __iomem *mbox_regs;
> -	void __iomem *memdev_regs;
> -
> -	size_t payload_size;
> -	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> -	char firmware_version[0x10];
> -	unsigned long *enabled_cmds;
> -
> -	struct range pmem_range;
> -	struct range ram_range;
> -};
> -
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 244cb7d89678..45871ef65152 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -12,6 +12,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include "pci.h"
>  #include "cxl.h"
> +#include "mem.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -29,12 +30,6 @@
>   *  - Handle and manage error conditions.
>   */
>  
> -/*
> - * An entire PCI topology full of devices should be enough for any
> - * config
> - */
> -#define CXL_MEM_MAX_DEVS 65536
> -
>  #define cxl_doorbell_busy(cxlm)                                                \
>  	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>  	 CXLDEV_MBOX_CTRL_DOORBELL)
> @@ -91,24 +86,6 @@ struct mbox_cmd {
>  #define CXL_MBOX_SUCCESS 0
>  };
>  
> -/**
> - * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
> - * @dev: driver core device object
> - * @cdev: char dev core object for ioctl operations
> - * @cxlm: pointer to the parent device driver data
> - * @ops_active: active user of @cxlm in ops handlers
> - * @ops_dead: completion when all @cxlm ops users have exited
> - * @id: id number of this memdev instance.
> - */
> -struct cxl_memdev {
> -	struct device dev;
> -	struct cdev cdev;
> -	struct cxl_mem *cxlm;
> -	struct percpu_ref ops_active;
> -	struct completion ops_dead;
> -	int id;
> -};
> -

Why move this stuff? As far as I could tell, at the end of this patch set this
is still only used within mem.c.

>  static int cxl_mem_major;
>  static DEFINE_IDA(cxl_memdev_ida);
>  static struct dentry *cxl_debugfs;
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> new file mode 100644
> index 000000000000..daa9aba0e218
> --- /dev/null
> +++ b/drivers/cxl/mem.h
> @@ -0,0 +1,85 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020-2021 Intel Corporation. */
> +#ifndef __CXL_MEM_H__
> +#define __CXL_MEM_H__
> +
> +/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> +#define CXLMDEV_STATUS_OFFSET 0x0
> +#define   CXLMDEV_DEV_FATAL BIT(0)
> +#define   CXLMDEV_FW_HALT BIT(1)
> +#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
> +#define     CXLMDEV_MS_NOT_READY 0
> +#define     CXLMDEV_MS_READY 1
> +#define     CXLMDEV_MS_ERROR 2
> +#define     CXLMDEV_MS_DISABLED 3
> +#define CXLMDEV_READY(status)                                                  \
> +	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
> +	 CXLMDEV_MS_READY)
> +#define   CXLMDEV_MBOX_IF_READY BIT(4)
> +#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
> +#define     CXLMDEV_RESET_NEEDED_NOT 0
> +#define     CXLMDEV_RESET_NEEDED_COLD 1
> +#define     CXLMDEV_RESET_NEEDED_WARM 2
> +#define     CXLMDEV_RESET_NEEDED_HOT 3
> +#define     CXLMDEV_RESET_NEEDED_CXL 4
> +#define CXLMDEV_RESET_NEEDED(status)                                           \
> +	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
> +	 CXLMDEV_RESET_NEEDED_NOT)
> +
> +/*
> + * An entire PCI topology full of devices should be enough for any
> + * config
> + */
> +#define CXL_MEM_MAX_DEVS 65536
> +
> +/**
> + * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
> + * @dev: driver core device object
> + * @cdev: char dev core object for ioctl operations
> + * @cxlm: pointer to the parent device driver data
> + * @ops_active: active user of @cxlm in ops handlers
> + * @ops_dead: completion when all @cxlm ops users have exited
> + * @id: id number of this memdev instance.
> + */
> +struct cxl_memdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_mem *cxlm;
> +	struct percpu_ref ops_active;
> +	struct completion ops_dead;
> +	int id;
> +};
> +
> +/**
> + * struct cxl_mem - A CXL memory device
> + * @pdev: The PCI device associated with this CXL device.
> + * @regs: IO mappings to the device's MMIO
> + * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
> + * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
> + * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
> + * @payload_size: Size of space for payload
> + *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
> + * @mbox_mutex: Mutex to synchronize mailbox access.
> + * @firmware_version: Firmware version for the memory device.
> + * @enabled_commands: Hardware commands found enabled in CEL.

@enabled_cmds:

> + * @pmem_range: Persistent memory capacity information.
> + * @ram_range: Volatile memory capacity information.
> + */
> +struct cxl_mem {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +	struct cxl_memdev *cxlmd;
> +
> +	void __iomem *status_regs;
> +	void __iomem *mbox_regs;
> +	void __iomem *memdev_regs;
> +
> +	size_t payload_size;
> +	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> +	char firmware_version[0x10];
> +	unsigned long *enabled_cmds;
> +
> +	struct range pmem_range;
> +	struct range ram_range;
> +};
> +#endif /* __CXL_MEM_H__ */
> 

