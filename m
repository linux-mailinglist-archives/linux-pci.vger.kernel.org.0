Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B416B80F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 04:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBYDaM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 22:30:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:53602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726962AbgBYDaM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 22:30:12 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 02584258198649C5C4A1;
        Tue, 25 Feb 2020 11:30:09 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 25 Feb 2020
 11:30:05 +0800
Subject: Re: [PATCH v4 03/26] iommu: Add a page fault handler
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-4-jean-philippe@linaro.org>
CC:     <mark.rutland@arm.com>, <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        <catalin.marinas@arm.com>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <zhangfei.gao@linaro.org>, <will@kernel.org>,
        <christian.koenig@amd.com>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <cb8b5a85-7f1a-8eb7-85bd-db2f553f066d@huawei.com>
Date:   Tue, 25 Feb 2020 11:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200224182401.353359-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2020/2/25 2:23, Jean-Philippe Brucker wrote:
> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>
> Some systems allow devices to handle I/O Page Faults in the core mm. For
> example systems implementing the PCI PRI extension or Arm SMMU stall
> model. Infrastructure for reporting these recoverable page faults was
> recently added to the IOMMU core. Add a page fault handler for host SVA.
>
> IOMMU driver can now instantiate several fault workqueues and link them to
> IOPF-capable devices. Drivers can choose between a single global
> workqueue, one per IOMMU device, one per low-level fault queue, one per
> domain, etc.
>
> When it receives a fault event, supposedly in an IRQ handler, the IOMMU
> driver reports the fault using iommu_report_device_fault(), which calls
> the registered handler. The page fault handler then calls the mm fault
> handler, and reports either success or failure with iommu_page_response().
> When the handler succeeded, the IOMMU retries the access.
>
> The iopf_param pointer could be embedded into iommu_fault_param. But
> putting iopf_param into the iommu_param structure allows us not to care
> about ordering between calls to iopf_queue_add_device() and
> iommu_register_device_fault_handler().
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/iommu/Kconfig      |   4 +
>   drivers/iommu/Makefile     |   1 +
>   drivers/iommu/io-pgfault.c | 451 +++++++++++++++++++++++++++++++++++++
>   include/linux/iommu.h      |  59 +++++
>   4 files changed, 515 insertions(+)
>   create mode 100644 drivers/iommu/io-pgfault.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index acca20e2da2f..e4a42e1708b4 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -109,6 +109,10 @@ config IOMMU_SVA
>   	select IOMMU_API
>   	select MMU_NOTIFIER
>   
> +config IOMMU_PAGE_FAULT
> +	bool
> +	select IOMMU_API
> +
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
>   	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 40c800dd4e3e..bf5cb4ee8409 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>   obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>   obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>   obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
> +obj-$(CONFIG_IOMMU_PAGE_FAULT) += io-pgfault.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>   obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> new file mode 100644
> index 000000000000..76e153c59fe3
> --- /dev/null
> +++ b/drivers/iommu/io-pgfault.c
> @@ -0,0 +1,451 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handle device page faults
> + *
> + * Copyright (C) 2018 ARM Ltd.
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +/**
> + * struct iopf_queue - IO Page Fault queue
> + * @wq: the fault workqueue
> + * @flush: low-level flush callback
> + * @flush_arg: flush() argument
> + * @devices: devices attached to this queue
> + * @lock: protects the device list
> + */
> +struct iopf_queue {
> +	struct workqueue_struct		*wq;
> +	iopf_queue_flush_t		flush;
> +	void				*flush_arg;
> +	struct list_head		devices;
> +	struct mutex			lock;
> +};
> +
> +/**
> + * struct iopf_device_param - IO Page Fault data attached to a device
> + * @dev: the device that owns this param
> + * @queue: IOPF queue
> + * @queue_list: index into queue->devices
> + * @partial: faults that are part of a Page Request Group for which the last
> + *           request hasn't been submitted yet.
> + * @busy: the param is being used
> + * @wq_head: signal a change to @busy
> + */
> +struct iopf_device_param {
> +	struct device			*dev;
> +	struct iopf_queue		*queue;
> +	struct list_head		queue_list;
> +	struct list_head		partial;
> +	bool				busy;
> +	wait_queue_head_t		wq_head;
> +};
> +
> +struct iopf_fault {
> +	struct iommu_fault		fault;
> +	struct list_head		head;
> +};
> +
> +struct iopf_group {
> +	struct iopf_fault		last_fault;
> +	struct list_head		faults;
> +	struct work_struct		work;
> +	struct device			*dev;
> +};
> +
[...]
> +
> +/**
> + * iopf_queue_alloc - Allocate and initialize a fault queue
> + * @name: a unique string identifying the queue (for workqueue)
> + * @flush: a callback that flushes the low-level queue
> + * @cookie: driver-private data passed to the flush callback
> + *
> + * The callback is called before the workqueue is flushed. The IOMMU driver must
> + * commit all faults that are pending in its low-level queues at the time of the
> + * call, into the IOPF queue (with iommu_report_device_fault). The callback
> + * takes a device pointer as argument, hinting what endpoint is causing the
> + * flush. When the device is NULL, all faults should be committed.
> + *
> + * Return: the queue on success and NULL on error.
> + */
> +struct iopf_queue *
> +iopf_queue_alloc(const char *name, iopf_queue_flush_t flush, void *cookie)
> +{
> +	struct iopf_queue *queue;
> +
> +	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
> +	if (!queue)
> +		return NULL;
> +
> +	/*
> +	 * The WQ is unordered because the low-level handler enqueues faults by
> +	 * group. PRI requests within a group have to be ordered, but once
> +	 * that's dealt with, the high-level function can handle groups out of
> +	 * order.
> +	 */
> +	queue->wq = alloc_workqueue("iopf_queue/%s", WQ_UNBOUND, 0, name);
Should this workqueue use 'WQ_HIGHPRI | WQ_UNBOUND' or some flags like 
this to decrease the unexpected
latency of I/O PageFault here? Or maybe, workqueue will show an 
uncontrolled latency, even in a busy system.

Cheers,
Zaibo

.
> +	if (!queue->wq) {
> +		kfree(queue);
> +		return NULL;
> +	}
> +
> +	queue->flush = flush;
> +	queue->flush_arg = cookie;
> +	INIT_LIST_HEAD(&queue->devices);
> +	mutex_init(&queue->lock);
> +
> +	return queue;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_alloc);
> +
> +/**
> + * iopf_queue_free - Free IOPF queue
> + * @queue: queue to free
> + *
> + * Counterpart to iopf_queue_alloc(). The driver must not be queuing faults or
> + * adding/removing devices on this queue anymore.
> + */
> +void iopf_queue_free(struct iopf_queue *queue)
> +{
> +	struct iopf_device_param *iopf_param, *next;
> +
> +	if (!queue)
> +		return;
> +
> +	list_for_each_entry_safe(iopf_param, next, &queue->devices, queue_list)
> +		iopf_queue_remove_device(queue, iopf_param->dev);
> +
> +	destroy_workqueue(queue->wq);
> +	kfree(queue);
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_free);
[...]

