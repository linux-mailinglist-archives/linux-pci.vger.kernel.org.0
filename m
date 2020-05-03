Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0AE1C2A2F
	for <lists+linux-pci@lfdr.de>; Sun,  3 May 2020 07:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgECFtP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 May 2020 01:49:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:25059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgECFtO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 May 2020 01:49:14 -0400
IronPort-SDR: +SkLfn8PIhiu18YWSo6bWT1puRGjMx+GW8nSlDMOF7LVtv4naObjIc3c/EKeNzSaPTerhWW31y
 gCeheGt/QIyg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2020 22:49:06 -0700
IronPort-SDR: 09Ev28KlQk1t03MgZyCk+L2yH6mbjMDbQsjrQYKpYhcQU1YlJ+eXBT8FdHJ1zVQenSkbLLiTQk
 WJp8wgsqaW6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,346,1583222400"; 
   d="scan'208";a="250351384"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.41]) ([10.255.29.41])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2020 22:49:01 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 04/25] iommu: Add a page fault handler
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-5-jean-philippe@linaro.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9a8ec004-0a9c-d772-8e7a-f839002a40b5@linux.intel.com>
Date:   Sun, 3 May 2020 13:49:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
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
> v5->v6: Simplify flush. As we're not flushing in the mm exit path
>    anymore, we can mandate that IOMMU drivers flush their low-level queue
>    themselves before calling iopf_queue_flush_dev(). No need to register
>    a flush callback anymore.
> ---
>   drivers/iommu/Kconfig      |   3 +
>   drivers/iommu/Makefile     |   1 +
>   include/linux/iommu.h      |  51 +++++
>   drivers/iommu/io-pgfault.c | 383 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 438 insertions(+)
>   create mode 100644 drivers/iommu/io-pgfault.c
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
> +	list_for_each_entry_safe(iopf, next, &group->faults, head) {
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

The iopf is freed,but not removed from the list. This will cause wild
pointer in code.

> +	}
> +
> +	iopf_complete_group(group->dev, &group->last_fault, status);
> +	kfree(group);
> +}
> +

[...]

> +/**
> + * iopf_queue_flush_dev - Ensure that all queued faults have been processed
> + * @dev: the endpoint whose faults need to be flushed.
> + * @pasid: the PASID affected by this flush
> + *
> + * The IOMMU driver calls this before releasing a PASID, to ensure that all
> + * pending faults for this PASID have been handled, and won't hit the address
> + * space of the next process that uses this PASID. The driver must make sure
> + * that no new fault is added to the queue. In particular it must flush its
> + * low-level queue before calling this function.
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_flush_dev(struct device *dev, int pasid)
> +{
> +	int ret = 0;
> +	struct iopf_device_param *iopf_param;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (!param)
> +		return -ENODEV;
> +
> +	mutex_lock(&param->lock);
> +	iopf_param = param->iopf_param;
> +	if (iopf_param)
> +		flush_workqueue(iopf_param->queue->wq);

There may be other pasid iopf in the workqueue. Flush all tasks in
the workqueue will hurt other pasids. I might lose any context.

> +	else
> +		ret = -ENODEV;
> +	mutex_unlock(&param->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
> +
> +/**
> + * iopf_queue_discard_partial - Remove all pending partial fault
> + * @queue: the queue whose partial faults need to be discarded
> + *
> + * When the hardware queue overflows, last page faults in a group may have been
> + * lost and the IOMMU driver calls this to discard all partial faults. The
> + * driver shouldn't be adding new faults to this queue concurrently.
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_discard_partial(struct iopf_queue *queue)
> +{
> +	struct iopf_fault *iopf, *next;
> +	struct iopf_device_param *iopf_param;
> +
> +	if (!queue)
> +		return -EINVAL;
> +
> +	mutex_lock(&queue->lock);
> +	list_for_each_entry(iopf_param, &queue->devices, queue_list) {
> +		list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
> +			kfree(iopf);

iopf is freed but not removed from the list.

> +	}
> +	mutex_unlock(&queue->lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_discard_partial);
> +
> +/**
> + * iopf_queue_add_device - Add producer to the fault queue
> + * @queue: IOPF queue
> + * @dev: device to add
> + *
> + * Return: 0 on success and <0 on error.
> + */
> +int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
> +{
> +	int ret = -EBUSY;
> +	struct iopf_device_param *iopf_param;
> +	struct dev_iommu *param = dev->iommu;
> +
> +	if (!param)
> +		return -ENODEV;
> +
> +	iopf_param = kzalloc(sizeof(*iopf_param), GFP_KERNEL);
> +	if (!iopf_param)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&iopf_param->partial);
> +	iopf_param->queue = queue;
> +	iopf_param->dev = dev;
> +
> +	mutex_lock(&queue->lock);
> +	mutex_lock(&param->lock);
> +	if (!param->iopf_param) {
> +		list_add(&iopf_param->queue_list, &queue->devices);
> +		param->iopf_param = iopf_param;
> +		ret = 0;
> +	}
> +	mutex_unlock(&param->lock);
> +	mutex_unlock(&queue->lock);
> +
> +	if (ret)
> +		kfree(iopf_param);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_add_device);
> +
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
> +	list_for_each_entry_safe(iopf, next, &iopf_param->partial, head)
> +		kfree(iopf);

The same here.

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
> +	kfree(queue);
> +}
> +EXPORT_SYMBOL_GPL(iopf_queue_free);
> 

Best regards,
baolu
