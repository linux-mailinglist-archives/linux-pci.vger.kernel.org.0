Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D846E1791EB
	for <lists+linux-pci@lfdr.de>; Wed,  4 Mar 2020 15:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgCDOIn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Mar 2020 09:08:43 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36437 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgCDOIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Mar 2020 09:08:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id j16so2576342wrt.3
        for <linux-pci@vger.kernel.org>; Wed, 04 Mar 2020 06:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdUvMeA1bV5hMUNi9Uc9NGFwMrBhsdhhT6ZmBGFQFek=;
        b=ziaLQQMTnCJ7YSxd5sV95qsFJ5sMZH3rtvhOIq0q24OYVAeSN/juNgdJKUXVth7dmC
         +1cTjWWP/8vKz1/4KANL8PnAFbMAGOTkEIQvePO7fVK5ahr5EsdFhICYSslnU6Q/U3YP
         eaY+UNIzqcl1QfHqCD3sojdDlJ5DGbhtfT0Zz1unRHzAIht9z91VeCVs9QSOLqrFrm47
         yYvlbSX/dMxmGH7JaXW06sQkDqq+gICORzdo63QS61gI1f3znBgEbBwZYbXIUzNXW34m
         9I41VXjpTFujhXGbhcU+sCmTSxEf+GPlgeOR7llOnK3kpBjcJOHvuvpYAM84w3umrZVW
         WibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdUvMeA1bV5hMUNi9Uc9NGFwMrBhsdhhT6ZmBGFQFek=;
        b=t1YrAqwEKhB0CyPtXd0g9QlyP4fiAPctDs2FJ/iihkJ+OoSx9DRVOF2AVyKQCEod5n
         /XzGPGM9QJYrznRdTVK9PIYEFwtPwtWRr60hmoBB8ZLRwaP1Qs+/ztYwDDvqD39M7q+I
         is66XqPEhOhl0XRjpT1WnTTe2MyGSQhHbi0NLF8mskDfBmJax565fk9TEcjjTu8J88wv
         sfIsxdU+WiaQ0icAF1MUxVjTKKW24uX8BNxx3S9AlzxULotFs2RfEUezm7xIi8wMLFOS
         NShn2Vp3Jqz3C/Sfcu1Oh1+j/nRxOAOVctWjYTAK6i/TuIMElgufW0+UWkZGM0gbJodZ
         j/pg==
X-Gm-Message-State: ANhLgQ10N6Y+FtNVy52YCa86limU6wbPlQVVblXNpE4CeXFF0lTg5AH7
        udJy2CsEqDYsdSQnGXvviIRY6A==
X-Google-Smtp-Source: ADFU+vv0sKAwmtjvye94x9YIogv5zw/a9rZvkYsOZEBQWXGc8PUw1JEbwM9HPDBC/WwH/q9h2REFKg==
X-Received: by 2002:a5d:4b82:: with SMTP id b2mr4303504wrt.102.1583330920810;
        Wed, 04 Mar 2020 06:08:40 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id p17sm36750450wre.89.2020.03.04.06.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 06:08:39 -0800 (PST)
Date:   Wed, 4 Mar 2020 15:08:33 +0100
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
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200304140833.GB646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-24-jean-philippe@linaro.org>
 <20200227181726.00007c9a@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227181726.00007c9a@Huawei.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 27, 2020 at 06:17:26PM +0000, Jonathan Cameron wrote:
> On Mon, 24 Feb 2020 19:23:58 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > The SMMU provides a Stall model for handling page faults in platform
> > devices. It is similar to PCI PRI, but doesn't require devices to have
> > their own translation cache. Instead, faulting transactions are parked and
> > the OS is given a chance to fix the page tables and retry the transaction.
> > 
> > Enable stall for devices that support it (opt-in by firmware). When an
> > event corresponds to a translation error, call the IOMMU fault handler. If
> > the fault is recoverable, it will call us back to terminate or continue
> > the stall.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> One question inline.
> 
> Thanks,
> 
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> >  drivers/iommu/of_iommu.c    |   5 +-
> >  include/linux/iommu.h       |   2 +
> >  3 files changed, 269 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 6a5987cce03f..da5dda5ba26a 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -374,6 +374,13 @@
> 
> 
> > +/*
> > + * arm_smmu_flush_evtq - wait until all events currently in the queue have been
> > + *                       consumed.
> > + *
> > + * Wait until the evtq thread finished a batch, or until the queue is empty.
> > + * Note that we don't handle overflows on q->batch. If it occurs, just wait for
> > + * the queue to be empty.
> > + */
> > +static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
> > +{
> > +	int ret;
> > +	u64 batch;
> > +	struct arm_smmu_device *smmu = cookie;
> > +	struct arm_smmu_queue *q = &smmu->evtq.q;
> > +
> > +	spin_lock(&q->wq.lock);
> > +	if (queue_sync_prod_in(q) == -EOVERFLOW)
> > +		dev_err(smmu->dev, "evtq overflow detected -- requests lost\n");
> > +
> > +	batch = q->batch;
> 
> So this is trying to be sure we have advanced the queue 2 spots?

So we call arm_smmu_flush_evtq() before decommissioning a PASID, to make
sure that there aren't any pending event for this PASID languishing in the
fault queues.

The main test is queue_empty(). If that succeeds then we know that there
aren't any pending event (and the PASID is safe to reuse). But if new
events are constantly added to the queue then we wait for the evtq thread
to handle a full batch, where one batch corresponds to the queue size. For
that we take the batch number when entering flush(), and wait for the evtq
thread to increment it twice.

> Is there a potential race here?  q->batch could have updated before we take
> a local copy.

Yes we're just checking on the progress of the evtq thread. All accesses
to batch are made while holding the wq lock.

Flush is a rare event so the lock isn't contended, but the wake_up() that
this patch introduces in arm_smmu_evtq_thread() does add some overhead
(0.85% of arm_smmu_evtq_thread(), according to perf). It would be nice to
get rid of it but I haven't found anything clever yet.

Thanks,
Jean

> 
> > +	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
> > +					      q->batch >= batch + 2);
> > +	spin_unlock(&q->wq.lock);
> > +
> > +	return ret;
> > +}
> > +
> ...
> 
