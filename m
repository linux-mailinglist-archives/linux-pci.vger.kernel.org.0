Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E699F2AFD6B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 03:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKLBbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 20:31:22 -0500
Received: from mga01.intel.com ([192.55.52.88]:20332 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgKKXLo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 18:11:44 -0500
IronPort-SDR: NOdPkS69RhW3uBgKhpoBk+RD/skb9oOWtDQ/ThhW8Qj8rgju5E9CbaTmg+6fFDJ0Qi78ZEo2ds
 9K7lXPW0AXTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="188220518"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="188220518"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 15:11:44 -0800
IronPort-SDR: 2SigUd3RC6BHd0NrZjhiVcNkd4/T5ldcTrknfGqqjnYMA+dH0hh6VxbwKoY75rW1jfqAHhP1bp
 TkxPMdnvvBtw==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="541993746"
Received: from lmwang8-mobl.ccr.corp.intel.com (HELO [10.254.209.85]) ([10.254.209.85])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 15:11:39 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org, joro@8bytes.org,
        catalin.marinas@arm.com, will@kernel.org, robin.murphy@arm.com,
        kevin.tian@intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        felix.kuehling@amd.com, zhangfei.gao@linaro.org, jgg@ziepe.ca,
        xuzaibo@huawei.com, fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
 <20201111135740.GA2622074@myrica>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <8e630294-8199-68e3-d55a-68e6484d953a@linux.intel.com>
Date:   Thu, 12 Nov 2020 07:11:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20201111135740.GA2622074@myrica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jean,

On 2020/11/11 21:57, Jean-Philippe Brucker wrote:
> Hi Baolu,
> 
> Thanks for the review. I'm only now reworking this and realized I've never
> sent a reply, sorry about that.
> 
> On Wed, May 20, 2020 at 02:42:21PM +0800, Lu Baolu wrote:
>> Hi Jean,
>>
>> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
>>> Some systems allow devices to handle I/O Page Faults in the core mm. For
>>> example systems implementing the PCIe PRI extension or Arm SMMU stall
>>> model. Infrastructure for reporting these recoverable page faults was
>>> added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
>>> fault report API"). Add a page fault handler for host SVA.
>>>
>>> IOMMU driver can now instantiate several fault workqueues and link them
>>> to IOPF-capable devices. Drivers can choose between a single global
>>> workqueue, one per IOMMU device, one per low-level fault queue, one per
>>> domain, etc.
>>>
>>> When it receives a fault event, supposedly in an IRQ handler, the IOMMU
>>> driver reports the fault using iommu_report_device_fault(), which calls
>>> the registered handler. The page fault handler then calls the mm fault
>>> handler, and reports either success or failure with iommu_page_response().
>>> When the handler succeeded, the IOMMU retries the access.
>>>
>>> The iopf_param pointer could be embedded into iommu_fault_param. But
>>> putting iopf_param into the iommu_param structure allows us not to care
>>> about ordering between calls to iopf_queue_add_device() and
>>> iommu_register_device_fault_handler().
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> [...]
>>> +static enum iommu_page_response_code
>>> +iopf_handle_single(struct iopf_fault *iopf)
>>> +{
>>> +	vm_fault_t ret;
>>> +	struct mm_struct *mm;
>>> +	struct vm_area_struct *vma;
>>> +	unsigned int access_flags = 0;
>>> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
>>> +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
>>> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
>>> +
>>> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
>>> +		return status;
>>> +
>>> +	mm = iommu_sva_find(prm->pasid);
>>> +	if (IS_ERR_OR_NULL(mm))
>>> +		return status;
>>> +
>>> +	down_read(&mm->mmap_sem);
>>> +
>>> +	vma = find_extend_vma(mm, prm->addr);
>>> +	if (!vma)
>>> +		/* Unmapped area */
>>> +		goto out_put_mm;
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
>>> +		access_flags |= VM_READ;
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
>>> +		access_flags |= VM_WRITE;
>>> +		fault_flags |= FAULT_FLAG_WRITE;
>>> +	}
>>> +
>>> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
>>> +		access_flags |= VM_EXEC;
>>> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
>>> +	}
>>> +
>>> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
>>> +		fault_flags |= FAULT_FLAG_USER;
>>> +
>>> +	if (access_flags & ~vma->vm_flags)
>>> +		/* Access fault */
>>> +		goto out_put_mm;
>>> +
>>> +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
>>> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
>>
>> Do you mind telling why it's IOMMU_PAGE_RESP_INVALID but not
>> IOMMU_PAGE_RESP_FAILURE?
> 
> PAGE_RESP_FAILURE maps to PRI Response code "Response Failure" which
> indicates a catastrophic error and causes the function to disable PRI.
> Instead PAGE_RESP_INVALID maps to PRI Response code "Invalid request",
> which tells the function that the address is invalid and there is no point
> retrying this particular access.

Thanks for the explanation. I am also working on converting Intel VT-d
to use this framework (and the sva helpers). So far so good.

Best regards,
baolu
