Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997711E792C
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgE2JTE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 05:19:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgE2JTD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 05:19:03 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 033A1F48536489043E95;
        Fri, 29 May 2020 17:18:58 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.213) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 17:18:40 +0800
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <fenghua.yu@intel.com>, <kevin.tian@intel.com>,
        <jacob.jun.pan@linux.intel.com>, <jgg@ziepe.ca>,
        <catalin.marinas@arm.com>, <joro@8bytes.org>,
        <robin.murphy@arm.com>, <hch@infradead.org>,
        <zhangfei.gao@linaro.org>, <Jonathan.Cameron@huawei.com>,
        <felix.kuehling@amd.com>, <xuzaibo@huawei.com>, <will@kernel.org>,
        <christian.koenig@amd.com>, <baolu.lu@linux.intel.com>,
        Wang Haibin <wanghaibin.wang@huawei.com>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <422e84da-9ccb-5452-8cbf-f472d2ad16b5@huawei.com>
Date:   Fri, 29 May 2020 17:18:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200519175502.2504091-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.213]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> Some systems allow devices to handle I/O Page Faults in the core mm. For
> example systems implementing the PCIe PRI extension or Arm SMMU stall
> model. Infrastructure for reporting these recoverable page faults was
> added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
> fault report API"). Add a page fault handler for host SVA.
> 
> IOMMU driver can now instantiate several fault workqueues and link them
> to IOPF-capable devices. Drivers can choose between a single global
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
> v6->v7: Fix leak in iopf_queue_discard_partial()
> ---
>  drivers/iommu/Kconfig      |   4 +
>  drivers/iommu/Makefile     |   1 +
>  include/linux/iommu.h      |  51 +++++
>  drivers/iommu/io-pgfault.c | 459 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 515 insertions(+)
>  create mode 100644 drivers/iommu/io-pgfault.c
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index d9fa5b410015..15e9dc4e503c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -107,6 +107,10 @@ config IOMMU_SVA
>  	bool
>  	select IOASID
>  
> +config IOMMU_PAGE_FAULT
> +	bool
> +	select IOMMU_SVA
> +
>  config FSL_PAMU
>  	bool "Freescale IOMMU support"
>  	depends on PCI
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 40c800dd4e3e..bf5cb4ee8409 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
>  obj-$(CONFIG_IOMMU_DEBUGFS) += iommu-debugfs.o
>  obj-$(CONFIG_IOMMU_DMA) += dma-iommu.o
> +obj-$(CONFIG_IOMMU_PAGE_FAULT) += io-pgfault.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE) += io-pgtable.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index b62525747bd9..a462157c855b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -46,6 +46,7 @@ struct iommu_domain;
>  struct notifier_block;
>  struct iommu_sva;
>  struct iommu_fault_event;
> +struct iopf_queue;
>  
>  /* iommu fault flags */
>  #define IOMMU_FAULT_READ	0x0
> @@ -347,6 +348,7 @@ struct iommu_fault_param {
>   * struct dev_iommu - Collection of per-device IOMMU data
>   *
>   * @fault_param: IOMMU detected device fault reporting data
> + * @iopf_param:	 I/O Page Fault queue and data
>   * @fwspec:	 IOMMU fwspec data
>   * @priv:	 IOMMU Driver private data
>   *
> @@ -356,6 +358,7 @@ struct iommu_fault_param {
>  struct dev_iommu {
>  	struct mutex lock;
>  	struct iommu_fault_param	*fault_param;
> +	struct iopf_device_param	*iopf_param;
>  	struct iommu_fwspec		*fwspec;
>  	void				*priv;
>  };

[...]

>  #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> new file mode 100644
> index 000000000000..1f61c1bc05da
> --- /dev/null
> +++ b/drivers/iommu/io-pgfault.c
> @@ -0,0 +1,459 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handle device page faults
> + *
> + * Copyright (C) 2020 ARM Ltd.
> + */
> +
> +#include <linux/iommu.h>
> +#include <linux/list.h>
> +#include <linux/sched/mm.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#include "iommu-sva.h"
> +
> +/**
> + * struct iopf_queue - IO Page Fault queue
> + * @wq: the fault workqueue
> + * @devices: devices attached to this queue
> + * @lock: protects the device list
> + */
> +struct iopf_queue {
> +	struct workqueue_struct		*wq;
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
> + */
> +struct iopf_device_param {
> +	struct device			*dev;
> +	struct iopf_queue		*queue;
> +	struct list_head		queue_list;
> +	struct list_head		partial;
> +};
> +
> +struct iopf_fault {
> +	struct iommu_fault		fault;
> +	struct list_head		list;
> +};
> +
> +struct iopf_group {
> +	struct iopf_fault		last_fault;
> +	struct list_head		faults;
> +	struct work_struct		work;
> +	struct device			*dev;
> +};
> +
>
[...]

> +
> +static void iopf_handle_group(struct work_struct *work)
> +{
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf, *next;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
> +
> +	group = container_of(work, struct iopf_group, work);
> +
> +	list_for_each_entry_safe(iopf, next, &group->faults, list) {
> +		/*
> +		 * For the moment, errors are sticky: don't handle subsequent
> +		 * faults in the group if there is an error.
> +		 */
> +		if (status == IOMMU_PAGE_RESP_SUCCESS)
> +			status = iopf_handle_single(iopf);
> +
> +		if (!(iopf->fault.prm.flags &
> +		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> +			kfree(iopf);
> +	}
> +
> +	iopf_complete_group(group->dev, &group->last_fault, status);
> +	kfree(group);
> +}
> +
> +/**
> + * iommu_queue_iopf - IO Page Fault handler
> + * @evt: fault event
> + * @cookie: struct device, passed to iommu_register_device_fault_handler.
> + *
> + * Add a fault to the device workqueue, to be handled by mm.
> + *
> + * This module doesn't handle PCI PASID Stop Marker; IOMMU drivers must discard
> + * them before reporting faults. A PASID Stop Marker (LRW = 0b100) doesn't
> + * expect a response. It may be generated when disabling a PASID (issuing a
> + * PASID stop request) by some PCI devices.
> + *
> + * The PASID stop request is issued by the device driver before unbind(). Once
> + * it completes, no page request is generated for this PASID anymore and
> + * outstanding ones have been pushed to the IOMMU (as per PCIe 4.0r1.0 - 6.20.1
> + * and 10.4.1.2 - Managing PASID TLP Prefix Usage). Some PCI devices will wait
> + * for all outstanding page requests to come back with a response before
> + * completing the PASID stop request. Others do not wait for page responses, and
> + * instead issue this Stop Marker that tells us when the PASID can be
> + * reallocated.
> + *
> + * It is safe to discard the Stop Marker because it is an optimization.
> + * a. Page requests, which are posted requests, have been flushed to the IOMMU
> + *    when the stop request completes.
> + * b. We flush all fault queues on unbind() before freeing the PASID.
> + *
> + * So even though the Stop Marker might be issued by the device *after* the stop
> + * request completes, outstanding faults will have been dealt with by the time
> + * we free the PASID.
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> +{
> +	int ret;
> +	struct iopf_group *group;
> +	struct iopf_fault *iopf, *next;
> +	struct iopf_device_param *iopf_param;
> +
> +	struct device *dev = cookie;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	lockdep_assert_held(&param->lock);
> +
> +	if (fault->type != IOMMU_FAULT_PAGE_REQ)
> +		/* Not a recoverable page fault */
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * As long as we're holding param->lock, the queue can't be unlinked
> +	 * from the device and therefore cannot disappear.
> +	 */
> +	iopf_param = param->iopf_param;
> +	if (!iopf_param)
> +		return -ENODEV;
> +
> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
> +		iopf = kzalloc(sizeof(*iopf), GFP_KERNEL);
> +		if (!iopf)
> +			return -ENOMEM;
> +
> +		iopf->fault = *fault;
> +
> +		/* Non-last request of a group. Postpone until the last one */
> +		list_add(&iopf->list, &iopf_param->partial);
> +
> +		return 0;
> +	}
> +
> +	group = kzalloc(sizeof(*group), GFP_KERNEL);
> +	if (!group) {
> +		/*
> +		 * The caller will send a response to the hardware. But we do
> +		 * need to clean up before leaving, otherwise partial faults
> +		 * will be stuck.
> +		 */
> +		ret = -ENOMEM;
> +		goto cleanup_partial;
> +	}
> +
> +	group->dev = dev;
> +	group->last_fault.fault = *fault;
> +	INIT_LIST_HEAD(&group->faults);
> +	list_add(&group->last_fault.list, &group->faults);
> +	INIT_WORK(&group->work, iopf_handle_group);
> +
> +	/* See if we have partial faults for this group */
> +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
> +		if (iopf->fault.prm.grpid == fault->prm.grpid)
> +			/* Insert *before* the last fault */
> +			list_move(&iopf->list, &group->faults);
> +	}
> +
> +	queue_work(iopf_param->queue->wq, &group->work);
> +	return 0;
> +
> +cleanup_partial:
> +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list) {
> +		if (iopf->fault.prm.grpid == fault->prm.grpid) {
> +			list_del(&iopf->list);
> +			kfree(iopf);
> +		}
> +	}
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_queue_iopf);

[...]

> +/**
> + * iopf_queue_remove_device - Remove producer from fault queue
> + * @queue: IOPF queue
> + * @dev: device to remove
> + *
> + * Caller makes sure that no more faults are reported for this device.
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> +{
> +	int ret = 0;
> +	struct iopf_fault *iopf, *next;
> +	struct iopf_device_param *iopf_param;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (!param || !queue)
> +		return -EINVAL;
> +
> +	mutex_lock(&queue->lock);
> +	mutex_lock(&param->lock);
> +	iopf_param = param->iopf_param;
> +	if (iopf_param && iopf_param->queue == queue) {
> +		list_del(&iopf_param->queue_list);
> +		param->iopf_param = NULL;
> +	} else {
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&param->lock);
> +	mutex_unlock(&queue->lock);
> +	if (ret)
> +		return ret;
> +
> +	/* Just in case some faults are still stuck */
> +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, list)
> +		kfree(iopf);
> +
> +	kfree(iopf_param);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_remove_device);
> +
> +/**
> + * iopf_queue_alloc - Allocate and initialize a fault queue
> + * @name: a unique string identifying the queue (for workqueue)
> + *
> + * Return: the queue on success and NULL on error.
> + */
> +struct iopf_queue *iopf_queue_alloc(const char *name)
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
> +	if (!queue->wq) {
> +		kfree(queue);
> +		return NULL;
> +	}
> +
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

Do we need to free iopf_group(s) here in case the work queue of the group(s) are not
scheduled yet? If that occurs, we might leak memory here.

If the caller can ensure that would never occur or I miss something, please ignore
my noise. :)

> +	kfree(queue);
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_free);
> 

-- 
Thanks,
Xiang

