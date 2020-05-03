Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C221C2A32
	for <lists+linux-pci@lfdr.de>; Sun,  3 May 2020 07:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgECFyn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 May 2020 01:54:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:23246 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgECFyn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 May 2020 01:54:43 -0400
IronPort-SDR: IfPa9NEZNMHZZOFDZYxzDCfi4NHjMpTkPWaqFnltpUiApIs94CwKwAmv/ZQjGmUNs8w0qVPrQC
 UEs61A738YZw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2020 22:54:42 -0700
IronPort-SDR: +m3RPXc/Y0Y2CJLTk7XvK3Pu9JreO+a4GkC6jhpJ8BxzkiBUrrsa0mDhQLO4R2+ooT2MnggdJ9
 /V775V/cq/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,346,1583222400"; 
   d="scan'208";a="250352199"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.41]) ([10.255.29.41])
  by fmsmga008.fm.intel.com with ESMTP; 02 May 2020 22:54:37 -0700
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v6 05/25] iommu/iopf: Handle mm faults
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-6-jean-philippe@linaro.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <9fc0e4cc-1242-bf96-5328-cc9039dcc9b6@linux.intel.com>
Date:   Sun, 3 May 2020 13:54:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430143424.2787566-6-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/4/30 22:34, Jean-Philippe Brucker wrote:
> When a recoverable page fault is handled by the fault workqueue, find the
> associated mm and call handle_mm_fault.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v5->v6: select CONFIG_IOMMU_SVA
> ---
>   drivers/iommu/Kconfig      |  1 +
>   drivers/iommu/io-pgfault.c | 79 +++++++++++++++++++++++++++++++++++++-
>   2 files changed, 78 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 4f33e489f0726..1e64ee6592e16 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -109,6 +109,7 @@ config IOMMU_SVA
>   
>   config IOMMU_PAGE_FAULT
>   	bool
> +	select IOMMU_SVA

It would be better to move this to the previous patch.

>   
>   config FSL_PAMU
>   	bool "Freescale IOMMU support"
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 38732e97faac1..09a71dc4de20a 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -7,9 +7,12 @@
>   
>   #include <linux/iommu.h>
>   #include <linux/list.h>
> +#include <linux/sched/mm.h>
>   #include <linux/slab.h>
>   #include <linux/workqueue.h>
>   
> +#include "iommu-sva.h"
> +
>   /**
>    * struct iopf_queue - IO Page Fault queue
>    * @wq: the fault workqueue
> @@ -68,8 +71,57 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>   static enum iommu_page_response_code
>   iopf_handle_single(struct iopf_fault *iopf)
>   {
> -	/* TODO */
> -	return -ENODEV;
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = iommu_sva_find(prm->pasid);
> +	if (IS_ERR_OR_NULL(mm))
> +		return status;
> +
> +	down_read(&mm->mmap_sem);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> +		IOMMU_PAGE_RESP_SUCCESS;
> +
> +out_put_mm:
> +	up_read(&mm->mmap_sem);
> +	mmput(mm);
> +
> +	return status;
>   }
>   
>   static void iopf_handle_group(struct work_struct *work)
> @@ -104,6 +156,29 @@ static void iopf_handle_group(struct work_struct *work)
>    *
>    * Add a fault to the device workqueue, to be handled by mm.
>    *
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
>    * Return: 0 on success and <0 on error.
>    */
>   int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> 

The same for the comments.

Best regards,
baolu
