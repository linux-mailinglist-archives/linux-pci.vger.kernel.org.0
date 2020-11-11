Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1A62AF2C1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 14:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgKKN6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 08:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgKKN6K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 08:58:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F24C0613D1
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 05:58:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p8so2627828wrx.5
        for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2020 05:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bg58Nuvlkki+FL9k9rnhWH9yWYXQkDaY8dFISymQNf4=;
        b=PX5YSlcxcGmSZg8r/sp2D0I5JTHOJyKFcuVZxLO1fiouCfjYWFBADilQDWAd0Zg9Sd
         HIfJ/J4cOjkRzfvjnj1WMh/LKncrPEtfWeva76W8jYJ5GBV9QsvF6eKzhO5TLf58/h3Y
         9SHRXS3ggYLKFZJgaiWZUr0gnAEq+xCsESwyC2lrlYNo+T1yDCho+DSiFZax7SLWk8Kc
         qS+/kEN2EY8zDLbcFnyYa3Hzli6iLHqYJh3b8/FneQUgK84gqG6h1k7T94Ji4UfDLetv
         p3Xs14pIjTNueMnPgMl2lVXzAS9+JjhDnXFy1NouXt6C7VZY0sEXk+8MnG75YWkKX/C+
         MxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bg58Nuvlkki+FL9k9rnhWH9yWYXQkDaY8dFISymQNf4=;
        b=nQ+tA0C/ccbe6JRm4bDodeDm8vfXKwVV8L9WCeAqWBKWhkay5fvxxjiMZGUyUSOyXy
         MEBhuEgRj9fvswFYclgxf9MSTQGZz8UDPETMWdqrRzhC6sDKaAA4GTr8fdCCwn+n8sdA
         PymQ1rHUZ2ltYDCSyIw1EhjOJnGgQnJmtg0PRH0ppkMH13UU6TAOtTQ4l1qUcQiezdsr
         dMB1IHdFP2rgfPhrKdPSKOr4BC/NIpWNki1zZ+MAQELPIpxMxNLn0yed9e6nLJF2dXSF
         xf/g/O9MqQvEaWc+qATTyh5GDX6i7y4UUqoIUY1kRBePAiFjnwh6hPhyNFAfsWl3SZ4g
         X4iw==
X-Gm-Message-State: AOAM533bGt3ZsNtjrE0blT7Hb2+1Mq7e+LuNnNL+7rjV31y6dXdIkc2Z
        PtAJioVvgfZNMZO8iR8ecMjTew==
X-Google-Smtp-Source: ABdhPJw6IjBDWuhoEyhqDsHpEgNzVVOxVUrrMBm3b8SRWwCRsVl0IlzCByu/s34c5pnWmTrWJJOQPA==
X-Received: by 2002:adf:f9cb:: with SMTP id w11mr26381611wrr.1.1605103089202;
        Wed, 11 Nov 2020 05:58:09 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id b8sm2551407wmj.9.2020.11.11.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:58:08 -0800 (PST)
Date:   Wed, 11 Nov 2020 14:57:50 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Xiang Zheng <zhengxiang9@huawei.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, fenghua.yu@intel.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        catalin.marinas@arm.com, joro@8bytes.org, robin.murphy@arm.com,
        hch@infradead.org, zhangfei.gao@linaro.org,
        Jonathan.Cameron@huawei.com, felix.kuehling@amd.com,
        xuzaibo@huawei.com, will@kernel.org, christian.koenig@amd.com,
        baolu.lu@linux.intel.com, Wang Haibin <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH v7 04/24] iommu: Add a page fault handler
Message-ID: <20201111135750.GA2617489@myrica>
References: <20200519175502.2504091-1-jean-philippe@linaro.org>
 <20200519175502.2504091-5-jean-philippe@linaro.org>
 <422e84da-9ccb-5452-8cbf-f472d2ad16b5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422e84da-9ccb-5452-8cbf-f472d2ad16b5@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Xiang,

Thank you for reviewing this. I forgot to send a reply, sorry for the
delay.

On Fri, May 29, 2020 at 05:18:27PM +0800, Xiang Zheng wrote:
> Hi,
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
> > +/**
> > + * iopf_queue_free - Free IOPF queue
> > + * @queue: queue to free
> > + *
> > + * Counterpart to iopf_queue_alloc(). The driver must not be queuing faults or
> > + * adding/removing devices on this queue anymore.
> > + */
> > +void iopf_queue_free(struct iopf_queue *queue)
> > +{
> > +	struct iopf_device_param *iopf_param, *next;
> > +
> > +	if (!queue)
> > +		return;
> > +
> > +	list_for_each_entry_safe(iopf_param, next, &queue->devices, queue_list)
> > +		iopf_queue_remove_device(queue, iopf_param->dev);
> > +
> > +	destroy_workqueue(queue->wq);
> 
> Do we need to free iopf_group(s) here in case the work queue of the group(s) are not
> scheduled yet? If that occurs, we might leak memory here.

Partial groups are freed by iopf_queue_remove_device(), and all other
groups are freed when destroy_workqueue() executes the remaining work.

Thanks,
Jean
