Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30A7917DDE5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Mar 2020 11:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCIKsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Mar 2020 06:48:41 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2520 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725956AbgCIKsl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Mar 2020 06:48:41 -0400
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E289F9BDFECA97C73EEA;
        Mon,  9 Mar 2020 10:48:39 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 9 Mar 2020 10:48:39 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 9 Mar 2020
 10:48:39 +0000
Date:   Mon, 9 Mar 2020 10:48:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-mm@kvack.org>,
        <joro@8bytes.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <kevin.tian@intel.com>,
        <baolu.lu@linux.intel.com>, <jacob.jun.pan@linux.intel.com>,
        <christian.koenig@amd.com>, <yi.l.liu@intel.com>,
        <zhangfei.gao@linaro.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 23/26] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20200309104826.000052c1@Huawei.com>
In-Reply-To: <20200304140833.GB646000@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
        <20200224182401.353359-24-jean-philippe@linaro.org>
        <20200227181726.00007c9a@Huawei.com>
        <20200304140833.GB646000@myrica>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 4 Mar 2020 15:08:33 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Feb 27, 2020 at 06:17:26PM +0000, Jonathan Cameron wrote:
> > On Mon, 24 Feb 2020 19:23:58 +0100
> > Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> >   
> > > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > 
> > > The SMMU provides a Stall model for handling page faults in platform
> > > devices. It is similar to PCI PRI, but doesn't require devices to have
> > > their own translation cache. Instead, faulting transactions are parked and
> > > the OS is given a chance to fix the page tables and retry the transaction.
> > > 
> > > Enable stall for devices that support it (opt-in by firmware). When an
> > > event corresponds to a translation error, call the IOMMU fault handler. If
> > > the fault is recoverable, it will call us back to terminate or continue
> > > the stall.
> > > 
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>  
> > One question inline.
> > 
> > Thanks,
> >   
> > > ---
> > >  drivers/iommu/arm-smmu-v3.c | 271 ++++++++++++++++++++++++++++++++++--
> > >  drivers/iommu/of_iommu.c    |   5 +-
> > >  include/linux/iommu.h       |   2 +
> > >  3 files changed, 269 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > > index 6a5987cce03f..da5dda5ba26a 100644
> > > --- a/drivers/iommu/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm-smmu-v3.c
> > > @@ -374,6 +374,13 @@  
> > 
> >   
> > > +/*
> > > + * arm_smmu_flush_evtq - wait until all events currently in the queue have been
> > > + *                       consumed.
> > > + *
> > > + * Wait until the evtq thread finished a batch, or until the queue is empty.
> > > + * Note that we don't handle overflows on q->batch. If it occurs, just wait for
> > > + * the queue to be empty.
> > > + */
> > > +static int arm_smmu_flush_evtq(void *cookie, struct device *dev, int pasid)
> > > +{
> > > +	int ret;
> > > +	u64 batch;
> > > +	struct arm_smmu_device *smmu = cookie;
> > > +	struct arm_smmu_queue *q = &smmu->evtq.q;
> > > +
> > > +	spin_lock(&q->wq.lock);
> > > +	if (queue_sync_prod_in(q) == -EOVERFLOW)
> > > +		dev_err(smmu->dev, "evtq overflow detected -- requests lost\n");
> > > +
> > > +	batch = q->batch;  
> > 
> > So this is trying to be sure we have advanced the queue 2 spots?  
> 
> So we call arm_smmu_flush_evtq() before decommissioning a PASID, to make
> sure that there aren't any pending event for this PASID languishing in the
> fault queues.
> 
> The main test is queue_empty(). If that succeeds then we know that there
> aren't any pending event (and the PASID is safe to reuse). But if new
> events are constantly added to the queue then we wait for the evtq thread
> to handle a full batch, where one batch corresponds to the queue size. For
> that we take the batch number when entering flush(), and wait for the evtq
> thread to increment it twice.
> 
> > Is there a potential race here?  q->batch could have updated before we take
> > a local copy.  
> 
> Yes we're just checking on the progress of the evtq thread. All accesses
> to batch are made while holding the wq lock.
> 
> Flush is a rare event so the lock isn't contended, but the wake_up() that
> this patch introduces in arm_smmu_evtq_thread() does add some overhead
> (0.85% of arm_smmu_evtq_thread(), according to perf). It would be nice to
> get rid of it but I haven't found anything clever yet.
> 

Thanks.  Maybe worth a few comments in the code as this is a bit esoteric.

Thanks,

Jonathan

> Thanks,
> Jean
> 
> >   
> > > +	ret = wait_event_interruptible_locked(q->wq, queue_empty(&q->llq) ||
> > > +					      q->batch >= batch + 2);
> > > +	spin_unlock(&q->wq.lock);
> > > +
> > > +	return ret;
> > > +}
> > > +  
> > ...
> >   


