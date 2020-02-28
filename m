Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 871FB173A24
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgB1OoO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 09:44:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39291 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgB1OoO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 09:44:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so3229225wrn.6
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QMl+VBaGMao7gyBNUaUbW1tLbhMPTZJMdvofJak/bmM=;
        b=Eyk6vY0Af0pgRHDvnoOLJKEE9DaGoa+4z0NJ0t/WaE+0vf6ERLTI5+gCSTL4JKeEc7
         arJUIl26vcb7lA32WK3mE1Z9pObCrTyBu370u//nTiHn54Qsk9vtBAlncLuZo9K0V9Bo
         few19oXa3fshNwMeLE1X36r0Kl70yyi9UUOxcD7HXOQk57UJt7R/uONrD0jw5QwBKUEP
         XNLUCyENocPiBEBMYBsa65NNpXfx1bwVRSoKhuPD+Y1BFMRjqLFWjj7Bjg+11i79QgS1
         AuuGvqPiln8Z0uHDmfdS0ONpDj/sxIKSFG/mkvrKTjD2nZHB7B4UWE1XulydcVQDQVxM
         5WkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QMl+VBaGMao7gyBNUaUbW1tLbhMPTZJMdvofJak/bmM=;
        b=eMnXwzkx1wLoWHfu5E2sECVXfI3RIKOs1F5MWvilIJU8/U09SuRdE7uMSCxYjjkwnK
         20KrQYb80hU5S82QjM0lJvesin5dA+BWIDSi7kD6T74+NVc4C5RabRvSK5CVdRSRbgUV
         jlVPT2t3X5ovrGMegPbRhHgJ0M2XmDMM5zWfm8iCkVE4lTQgSWRxHBphaQOacx7z+4sW
         c3IGaj28pBRkwZvQYzZI3jREL9iF6/bqYYtiZxw4GER5iYU15TEZan/nY1KgkWWtHHvH
         scBZZgX1XeuRyLqyGpYi7cNbdlaKV+xUO+gy7fPnr3a5Upc9mwTJL8/A3wYvE3q2pBQc
         +RoQ==
X-Gm-Message-State: APjAAAU2eTHicEUHbrN93j3s+IZ2/4xL6yVWzxpbXcmQEdnpAl8n11Yb
        KbdEQw6uw+rTdPtR/a6QytEfCg==
X-Google-Smtp-Source: APXvYqw6DykiBE32SqEJ+HnRwk8TuEFmQqrz2Fb4Wvuo7oVY88B0FHH4nfUvdWL5pnDIWaqbqIxz+g==
X-Received: by 2002:adf:f648:: with SMTP id x8mr5477186wrp.198.1582901051368;
        Fri, 28 Feb 2020 06:44:11 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id o27sm13045012wro.27.2020.02.28.06.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:44:10 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:44:04 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 03/26] iommu: Add a page fault handler
Message-ID: <20200228144404.GD2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-4-jean-philippe@linaro.org>
 <20200226135933.000061a0@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226135933.000061a0@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 01:59:33PM +0000, Jonathan Cameron wrote:
> > +static int iopf_complete(struct device *dev, struct iopf_fault *iopf,
> > +			 enum iommu_page_response_code status)
> 
> This is called once per group.  Should name reflect that?

Ok

[...]
> > +/**
> > + * iommu_queue_iopf - IO Page Fault handler
> > + * @evt: fault event
> > + * @cookie: struct device, passed to iommu_register_device_fault_handler.
> > + *
> > + * Add a fault to the device workqueue, to be handled by mm.
> > + *
> > + * Return: 0 on success and <0 on error.
> > + */
> > +int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> > +{
> > +	int ret;
> > +	struct iopf_group *group;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +
> > +	struct device *dev = cookie;
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	if (WARN_ON(!mutex_is_locked(&param->lock)))
> > +		return -EINVAL;
> 
> Just curious...
> 
> Why do we always need a runtime check on this rather than say,
> using lockdep_assert_held or similar?

I probably didn't know about lockdep_assert at the time :)

> > +	/*
> > +	 * It is incredibly easy to find ourselves in a deadlock situation if
> > +	 * we're not careful, because we're taking the opposite path as
> > +	 * iommu_queue_iopf:
> > +	 *
> > +	 *   iopf_queue_flush_dev()   |  PRI queue handler
> > +	 *    lock(&param->lock)      |   iommu_queue_iopf()
> > +	 *     queue->flush()         |    lock(&param->lock)
> > +	 *      wait PRI queue empty  |
> > +	 *
> > +	 * So we can't hold the device param lock while flushing. Take a
> > +	 * reference to the device param instead, to prevent the queue from
> > +	 * going away.
> > +	 */
> > +	mutex_lock(&param->lock);
> > +	iopf_param = param->iopf_param;
> > +	if (iopf_param) {
> > +		queue = param->iopf_param->queue;
> > +		iopf_param->busy = true;
> 
> Describing this as taking a reference is not great...
> I'd change the comment to set a flag or something like that.
> 
> Is there any potential of multiple copies of this running against
> each other?  I've not totally gotten my head around when this
> might be called yet.

Yes it's allowed, this should be a refcount

[...]
> > +int iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
> > +{
> > +	int ret = -EINVAL;
> > +	struct iopf_fault *iopf, *next;
> > +	struct iopf_device_param *iopf_param;
> > +	struct iommu_param *param = dev->iommu_param;
> > +
> > +	if (!param || !queue)
> > +		return -EINVAL;
> > +
> > +	do {
> > +		mutex_lock(&queue->lock);
> > +		mutex_lock(&param->lock);
> > +		iopf_param = param->iopf_param;
> > +		if (iopf_param && iopf_param->queue == queue) {
> > +			if (iopf_param->busy) {
> > +				ret = -EBUSY;
> > +			} else {
> > +				list_del(&iopf_param->queue_list);
> > +				param->iopf_param = NULL;
> > +				ret = 0;
> > +			}
> > +		}
> > +		mutex_unlock(&param->lock);
> > +		mutex_unlock(&queue->lock);
> > +
> > +		/*
> > +		 * If there is an ongoing flush, wait for it to complete and
> > +		 * then retry. iopf_param isn't going away since we're the only
> > +		 * thread that can free it.
> > +		 */
> > +		if (ret == -EBUSY)
> > +			wait_event(iopf_param->wq_head, !iopf_param->busy);
> > +		else if (ret)
> > +			return ret;
> > +	} while (ret == -EBUSY);
> 
> I'm in two minds about the next comment (so up to you)...
> 
> Currently this looks a bit odd.  Would you be better off just having a separate
> parameter for busy and explicit separate handling for the error path?
> 
> 	bool busy;
> 	int ret = 0;
> 
> 	do {
> 		mutex_lock(&queue->lock);
> 		mutex_lock(&param->lock);
> 		iopf_param = param->iopf_param;
> 		if (iopf_param && iopf_param->queue == queue) {
> 			busy = iopf_param->busy;
> 			if (!busy) {
> 				list_del(&iopf_param->queue_list);
> 				param->iopf_param = NULL;
> 			}
> 		} else {
> 			ret = -EINVAL;
> 		}
> 		mutex_unlock(&param->lock);
> 		mutex_unlock(&queue->lock);
> 		if (ret)
> 			return ret;
> 		if (busy)
> 			wait_event(iopf_param->wq_head, !iopf_param->busy);
> 		
> 	} while (busy);
> 
> 	..

Sure, I think it looks better

Thanks,
Jean
