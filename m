Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FCD1708F9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2020 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgBZTeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Feb 2020 14:34:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:6427 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727238AbgBZTea (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Feb 2020 14:34:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 11:34:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,489,1574150400"; 
   d="scan'208";a="231514911"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 11:34:29 -0800
Date:   Wed, 26 Feb 2020 11:39:59 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 06/26] iommu/sva: Register page fault handler
Message-ID: <20200226113959.62621098@jacob-builder>
In-Reply-To: <20200224182401.353359-7-jean-philippe@linaro.org>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
        <20200224182401.353359-7-jean-philippe@linaro.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 24 Feb 2020 19:23:41 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> 
> When enabling SVA, register the fault handler. Device driver will
> register an I/O page fault queue before or after calling
> iommu_sva_enable. The fault queue must be flushed before any io_mm is
> freed, to make sure that its PASID isn't used in any fault queue, and
> can be reallocated. Add iopf_queue_flush() calls in a few strategic
> locations.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/Kconfig     |  1 +
>  drivers/iommu/iommu-sva.c | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index e4a42e1708b4..211684e785ea 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -106,6 +106,7 @@ config IOMMU_DMA
>  config IOMMU_SVA
>  	bool
>  	select IOASID
> +	select IOMMU_PAGE_FAULT
>  	select IOMMU_API
>  	select MMU_NOTIFIER
>  
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index bfd0c477f290..494ca0824e4b 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -366,6 +366,8 @@ static void io_mm_release(struct mmu_notifier
> *mn, struct mm_struct *mm) dev_WARN(dev, "possible leak of PASID %u",
>  				 io_mm->pasid);
>  
> +		iopf_queue_flush_dev(dev, io_mm->pasid);
> +
>  		/* unbind() frees the bond, we just detach it */
>  		io_mm_detach_locked(bond);
>  	}
> @@ -442,11 +444,20 @@ static void iommu_sva_unbind_locked(struct
> iommu_bond *bond) 
>  void iommu_sva_unbind_generic(struct iommu_sva *handle)
>  {
> +	int pasid;
>  	struct iommu_param *param = handle->dev->iommu_param;
>  
>  	if (WARN_ON(!param))
>  		return;
>  
> +	/*
> +	 * Caller stopped the device from issuing PASIDs, now make
> sure they are
> +	 * out of the fault queue.
> +	 */
> +	pasid = iommu_sva_get_pasid_generic(handle);
> +	if (pasid != IOMMU_PASID_INVALID)
> +		iopf_queue_flush_dev(handle->dev, pasid);
> +
I have an ordering concern.
The caller can only stop the device issuing page request but there will
be in-flight request inside the IOMMU. If we flush here before clearing
the PASID context, there might be new request coming in before the
detach.
How about detach first then flush? Then anything come after the detach
would be faults. Flush will be clean.

>  	mutex_lock(&param->sva_lock);
>  	mutex_lock(&iommu_sva_lock);
>  	iommu_sva_unbind_locked(to_iommu_bond(handle));
> @@ -484,6 +495,10 @@ int iommu_sva_enable(struct device *dev, struct
> iommu_sva_param *sva_param) goto err_unlock;
>  	}
>  
> +	ret = iommu_register_device_fault_handler(dev,
> iommu_queue_iopf, dev);
> +	if (ret)
> +		goto err_unlock;
> +
>  	dev->iommu_param->sva_param = new_param;
>  	mutex_unlock(&param->sva_lock);
>  	return 0;
> @@ -521,6 +536,7 @@ int iommu_sva_disable(struct device *dev)
>  		goto out_unlock;
>  	}
>  
> +	iommu_unregister_device_fault_handler(dev);
>  	kfree(param->sva_param);
>  	param->sva_param = NULL;
>  out_unlock:

[Jacob Pan]
