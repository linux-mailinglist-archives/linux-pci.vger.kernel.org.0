Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61D2AF2C7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 14:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgKKN6n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 08:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKKN6B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 08:58:01 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01B7C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 05:58:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b8so2647146wrn.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 05:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQxC580B2FGMz7fwoWGS/qV6OQLc0KLPED3qOpuBky8=;
        b=OIo6GpxukW3iK2MLSyvALt9frkeXd0ZXiyBWhhzmAxpU0yk9P7jOnHruqZKBQccZFO
         pi2tyWBjPtyBjL5dZIjocD5ciZf7y4jaSEPp7AQg7jVQhBrcZUkooG6dMykqfIKrnwAm
         cmTpHvTYivjJDMqffwVQNg3EIBx4N6ItwiIASsWC7oJFIABzF84mUeLhNduPpkE/B5fD
         zU74Wu3AXxpByDpPLbPJvtqj5iCgSkmn2qtMTKJ496VYWlXJFryVRfSUhAyN/CXGuD78
         QJiksGLXHFV1oaOcVmLLsBMjUdF+nYRlOKoiB/1ocK79gkEdbrKkmG95wo2oynjwhkmg
         RIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQxC580B2FGMz7fwoWGS/qV6OQLc0KLPED3qOpuBky8=;
        b=FcYRuhZ8EeTFC1SEYx8huT2j9FQGDEglpBDXvnsDNaPlGh5Wq5I1tTX4Yo7jwJ5/2D
         kAsNiutnOKqZsAgEg+DyVWC8dC4p8qOSv/doe40CVBopC6WEc9gfTtdSMwxQXgKjQnzV
         g8M4Z2LWJ/XM0h4K4F2fXcsaihdlBkRdr5tKG3IREN4FvBbLzHoEr5HXDEjrq/KaMir1
         FJFRaAT6JPlzp77hLy537EermyBXczSb128KkH3ieVF3OdcqXzECLV3G6QYrZEmIgAH1
         7gel+kYyZLQjZovIu9xzzr3+o5JPgiNHvKOkBE8hBMW+UXSuIcsSukRpB96arPbjWyhW
         cLTw==
X-Gm-Message-State: AOAM53184uMhfYsv9DrtqsIsDy6SbGTG3BKumEPeJ1M7nabzSkRIgbrX
        MTqvI7tHeRLIAVjPBLKxlwcP9w==
X-Google-Smtp-Source: ABdhPJz8B46qAy3mH7K7M4xppHiXb//CHwuj/RA8IyjLL/yHeGrjXZ21yZsM7l6s4djLyiLVXJ69Cg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr13899007wrm.259.1605103079627;
        Wed, 11 Nov 2020 05:57:59 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b14sm2550433wrq.47.2020.11.11.05.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:57:58 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:57:40 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, catalin.marinas@arm.com,
        will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
        Jonathan.Cameron@huawei.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, felix.kuehling@amd.com,
        zhangfei.gao@linaro.org, jgg@ziepe.ca, xuzaibo@huawei.com,
        fenghua.yu@intel.com, hch@infradead.org
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
Message-ID: <20201111135740.GA2622074@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c840d771-188d-9ee5-d117-e4b91d29b329@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Baolu,

Thanks for the review. I'm only now reworking this and realized I've never
sent a reply, sorry about that.

On Wed, May 20, 2020 at 02:42:21PM +0800, Lu Baolu wrote:
> Hi Jean,
> 
> On 2020/5/20 1:54, Jean-Philippe Brucker wrote:
> > Some systems allow devices to handle I/O Page Faults in the core mm. For
> > example systems implementing the PCIe PRI extension or Arm SMMU stall
> > model. Infrastructure for reporting these recoverable page faults was
> > added to the IOMMU core by commit 0c830e6b3282 ("iommu: Introduce device
> > fault report API"). Add a page fault handler for host SVA.
> > 
> > IOMMU driver can now instantiate several fault workqueues and link them
> > to IOPF-capable devices. Drivers can choose between a single global
> > workqueue, one per IOMMU device, one per low-level fault queue, one per
> > domain, etc.
> > 
> > When it receives a fault event, supposedly in an IRQ handler, the IOMMU
> > driver reports the fault using iommu_report_device_fault(), which calls
> > the registered handler. The page fault handler then calls the mm fault
> > handler, and reports either success or failure with iommu_page_response().
> > When the handler succeeded, the IOMMU retries the access.
> > 
> > The iopf_param pointer could be embedded into iommu_fault_param. But
> > putting iopf_param into the iommu_param structure allows us not to care
> > about ordering between calls to iopf_queue_add_device() and
> > iommu_register_device_fault_handler().
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[...]
> > +static enum iommu_page_response_code
> > +iopf_handle_single(struct iopf_fault *iopf)
> > +{
> > +	vm_fault_t ret;
> > +	struct mm_struct *mm;
> > +	struct vm_area_struct *vma;
> > +	unsigned int access_flags = 0;
> > +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> > +	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> > +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> > +
> > +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> > +		return status;
> > +
> > +	mm = iommu_sva_find(prm->pasid);
> > +	if (IS_ERR_OR_NULL(mm))
> > +		return status;
> > +
> > +	down_read(&mm->mmap_sem);
> > +
> > +	vma = find_extend_vma(mm, prm->addr);
> > +	if (!vma)
> > +		/* Unmapped area */
> > +		goto out_put_mm;
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> > +		access_flags |= VM_READ;
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> > +		access_flags |= VM_WRITE;
> > +		fault_flags |= FAULT_FLAG_WRITE;
> > +	}
> > +
> > +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> > +		access_flags |= VM_EXEC;
> > +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> > +	}
> > +
> > +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> > +		fault_flags |= FAULT_FLAG_USER;
> > +
> > +	if (access_flags & ~vma->vm_flags)
> > +		/* Access fault */
> > +		goto out_put_mm;
> > +
> > +	ret = handle_mm_fault(vma, prm->addr, fault_flags);
> > +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> 
> Do you mind telling why it's IOMMU_PAGE_RESP_INVALID but not
> IOMMU_PAGE_RESP_FAILURE?

PAGE_RESP_FAILURE maps to PRI Response code "Response Failure" which
indicates a catastrophic error and causes the function to disable PRI.
Instead PAGE_RESP_INVALID maps to PRI Response code "Invalid request",
which tells the function that the address is invalid and there is no point
retrying this particular access.

Thanks,
Jean
