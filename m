Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 728B9173A09
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 15:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgB1OkS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 09:40:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46038 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgB1OkS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 09:40:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id v2so3148159wrp.12
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 06:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5sNqZ3YeijPs+5KtJjbdpwW9wQl4IfZffWans/qZ1o0=;
        b=W7bdUIfMx3O78x3MrjIVsKRsl9VuaGaQ8RJO2ywZI1aX3QIlwAGIzKPWqYjHoD+vW1
         JtUVLqqz4E6wy3gm/2ZRW/dqIshjlixI005qkReVH+gYeOai2HO/J88IcmMVkSPXAuQl
         l8hOsEmHbmWDkNwHCbWOFPGElr3qpJOH57+L2wTJVYE3A9Xe0zXAYA5GT8PCML3fg24/
         8Lhoz494/IjPyBPWvxXnpABBajciFZcMPY6UaqnDVMW3HU7mhTvig03S9H+KcNFjXrCh
         aKge959ux7sLQBzGHd9k+3HWCwImhmgXOJ2WWUxziTIvhJSU7C6GOdz3KWqV0iGcNcAZ
         sDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5sNqZ3YeijPs+5KtJjbdpwW9wQl4IfZffWans/qZ1o0=;
        b=MipBIAWQ8CdArG+mcFKh1e7mrq+E9CKnmdy4RMVz5BaGRRc/kx5fU/WDPUc4u+X9BL
         y7z4XxPpYO7fdu/HhP37Aq6/t7/qKIiFasP0lU40v7089+hMZq4i72ggaZj5xn3/0qec
         FN62YWKCc3IOc1nxRrSPaIJCSSpHkSg6W5RpmZFsH2amPCtK5a9WKvw/d/fIptlm61Z1
         ISVKmZGJpQxJu8ZEczq9g/H2NsBkatC4Q01P3n3/YtMuYFmAeRM7jbVSq9zgE1zdOGk4
         LXWRoj7EX7kGipcQHS+jXK21EIr7/3sROHheZe4GJhjnZtG34wAg9kn27haBI2DIz1p+
         l1HA==
X-Gm-Message-State: APjAAAXZjvO/E3an/6UyRGHlWQ4j7BL7tqyAzMJyS6RVOyonfdam/m4F
        qcD30WJJxbnIKE2t5yijpi4uXQ==
X-Google-Smtp-Source: APXvYqyFhkVieyNAGLHTCM7H0ZO5J6+IJ9iMwcCnEK3SDNUGyZ2NMEDT1oz0JueN1tel+EkbePE54A==
X-Received: by 2002:adf:e506:: with SMTP id j6mr4995022wrm.309.1582900813931;
        Fri, 28 Feb 2020 06:40:13 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s5sm10763443wru.39.2020.02.28.06.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:40:13 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:40:07 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        christian.koenig@amd.com, yi.l.liu@intel.com,
        zhangfei.gao@linaro.org,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v4 02/26] iommu/sva: Manage process address spaces
Message-ID: <20200228144007.GB2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-3-jean-philippe@linaro.org>
 <20200226111320.3b6e6d3d@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226111320.3b6e6d3d@jacob-builder>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 26, 2020 at 11:13:20AM -0800, Jacob Pan wrote:
> Hi Jean,
> 
> A few comments inline. I am also trying to converge to the common sva
> APIs. I sent out the first step w/o iopage fault and the generic ops
> you have here.

Great, thanks for sending it out, it's on my list to look at

> On Mon, 24 Feb 2020 19:23:37 +0100
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > 
> > Add a small library to help IOMMU drivers manage process address
> > spaces bound to their devices. Register an MMU notifier to track
> > modification on each address space bound to one or more devices.
> > 
> > IOMMU drivers must implement the io_mm_ops and can then use the
> > helpers provided by this library to easily implement the SVA API
> > introduced by commit 26b25a2b98e4. The io_mm_ops are:
> > 
> > void *alloc(struct mm_struct *)
> >   Allocate a PASID context private to the IOMMU driver. There is a
> >   single context per mm. IOMMU drivers may perform arch-specific
> >   operations in there, for example pinning down a CPU ASID (on Arm).
> > 
> > int attach(struct device *, int pasid, void *ctx, bool attach_domain)
> >   Attach a context to the device, by setting up the PASID table entry.
> > 
> > int invalidate(struct device *, int pasid, void *ctx,
> >                unsigned long vaddr, size_t size)
> >   Invalidate TLB entries for this address range.
> > 
> > int detach(struct device *, int pasid, void *ctx, bool detach_domain)
> >   Detach a context from the device, by clearing the PASID table entry
> >   and invalidating cached entries.
> > 
> > void free(void *ctx)
> you meant release()?

Yes

[...]
> > +/**
> > + * DOC: io_mm model
> > + *
> > + * The io_mm keeps track of process address spaces shared between
> > CPU and IOMMU.
> > + * The following example illustrates the relation between structures
> > + * iommu_domain, io_mm and iommu_sva. The iommu_sva struct is a bond
> > between
> > + * io_mm and device. A device can have multiple io_mm and an io_mm
> > may be bound
> > + * to multiple devices.
> > + *              ___________________________
> > + *             |  IOMMU domain A           |
> > + *             |  ________________         |
> > + *             | |  IOMMU group   |        +------- io_pgtables
> > + *             | |                |        |
> > + *             | |   dev 00:00.0 ----+------- bond 1 --- io_mm X
> > + *             | |________________|   \    |
> > + *             |                       '----- bond 2 ---.
> > + *             |___________________________|             \
> > + *              ___________________________               \
> > + *             |  IOMMU domain B           |             io_mm Y
> > + *             |  ________________         |             / /
> > + *             | |  IOMMU group   |        |            / /
> > + *             | |                |        |           / /
> > + *             | |   dev 00:01.0 ------------ bond 3 -' /
> > + *             | |   dev 00:01.1 ------------ bond 4 --'
> > + *             | |________________|        |
> > + *             |                           +------- io_pgtables
> > + *             |___________________________|
> > + *
> > + * In this example, device 00:00.0 is in domain A, devices 00:01.*
> > are in domain
> > + * B. All devices within the same domain access the same address
> > spaces.
> Hmm, devices in domain A has access to both X & Y, isn't it
> contradictory?

I guess it's unclear, this is meant to explain that any device in domain B
for example, would access all address spaces bound to any other device in
that domain.

> 
> > Device
> > + * 00:00.0 accesses address spaces X and Y, each corresponding to an
> > mm_struct.
> > + * Devices 00:01.* only access address space Y. In addition each
> > + * IOMMU_DOMAIN_DMA domain has a private address space, io_pgtable,
> > that is
> > + * managed with iommu_map()/iommu_unmap(), and isn't shared with the
> > CPU MMU.
> So this would allow IOVA and SVA co-exist in the same address space?

Hmm, not in the same address space, but they can co-exist in a device. In
fact the endpoint I'm testing (hisi zip accelerator) already needs normal
DMA alongside SVA for queue management. This one is integrated on an
Arm-based platform so shouldn't be a concern for VT-d at the moment, but
I suspect we might see more of this kind of device with mixed DMA.

In addition on Arm MSI addresses are translated by the IOMMU, and since
they are requests w/o PASID they need the private address space on entry 0.

Are you not planning to use the RID_PASID entry of Scalable-Mode
Context-Entry in VT-d?

> I guess this is the PASID 0 for DMA request w/o PASID. If that is the
> case, perhaps needs more explanation since the private address space
> also has a private PASID within the domain.

The last sentence refers to this private address space used for requests
w/o PASID. I don't like referring to it as "PASID 0" since it might be
more confusing. It's entry 0 of the PASID table reserved for requests
without PASID.

I think I should just remove this here sentence and try to make the last
paragraph of the comment, which referes to the same thing, clearer. I'll
also drop io_pgtables from the above diagram to keep things on point.

> > + *
> > + * To obtain the above configuration, users would for instance issue
> > the
> > + * following calls:
> > + *
> > + *     iommu_sva_bind_device(dev 00:00.0, mm X, ...) -> bond 1
> > + *     iommu_sva_bind_device(dev 00:00.0, mm Y, ...) -> bond 2
> > + *     iommu_sva_bind_device(dev 00:01.0, mm Y, ...) -> bond 3
> > + *     iommu_sva_bind_device(dev 00:01.1, mm Y, ...) -> bond 4
> > + *
> > + * A single Process Address Space ID (PASID) is allocated for each
> > mm. In the
> > + * example, devices use PASID 1 to read/write into address space X
> > and PASID 2
> > + * to read/write into address space Y. Calling iommu_sva_get_pasid()
> > on bond 1
> > + * returns 1, and calling it on bonds 2-4 returns 2.
> > + *
> > + * Hardware tables describing this configuration in the IOMMU would
> > typically
> > + * look like this:
> > + *
> > + *                                PASID tables
> > + *                                 of domain A
> > + *                              .->+--------+
> > + *                             / 0 |        |-------> io_pgtable
> > + *                            /    +--------+
> > + *            Device tables  /   1 |        |-------> pgd X
> > + *              +--------+  /      +--------+
> > + *      00:00.0 |      A |-'     2 |        |--.
> > + *              +--------+         +--------+   \
> > + *              :        :       3 |        |    \
> > + *              +--------+         +--------+     --> pgd Y
> > + *      00:01.0 |      B |--.                    /
> > + *              +--------+   \                  |
> > + *      00:01.1 |      B |----+   PASID tables  |
> > + *              +--------+     \   of domain B  |
> > + *                              '->+--------+   |
> > + *                               0 |        |-- | --> io_pgtable
> > + *                                 +--------+   |
> > + *                               1 |        |   |
> > + *                                 +--------+   |
> > + *                               2 |        |---'
> > + *                                 +--------+
> > + *                               3 |        |
> > + *                                 +--------+
> > + *
> > + * With this model, a single call binds all devices in a given
> > domain to an
> > + * address space. Other devices in the domain will get the same bond
> > implicitly.
> > + * However, users must issue one bind() for each device, because
> > IOMMUs may
> > + * implement SVA differently. Furthermore, mandating one bind() per
> > device
> > + * allows the driver to perform sanity-checks on device capabilities.
> > + *
> > + * In some IOMMUs, one entry of the PASID table (typically the first
> > one) can
> > + * hold non-PASID translations. In this case PASID 0 is reserved and
> > the first
> > + * entry points to the io_pgtable pointer. In other IOMMUs the
> > io_pgtable
> > + * pointer is held in the device table and PASID 0 is available to
> > the
> > + * allocator.
> > + */
[...]
> > +static struct iommu_sva *
> > +io_mm_attach(struct device *dev, struct io_mm *io_mm, void *drvdata)
> > +{
> > +	int ret = 0;
> > +	bool attach_domain = true;
> > +	struct iommu_bond *bond, *tmp;
> > +	struct iommu_domain *domain, *other;
> > +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
> > +
> > +	domain = iommu_get_domain_for_dev(dev);
> > +
> > +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> > +	if (!bond)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	bond->sva.dev	= dev;
> > +	bond->drvdata	= drvdata;
> > +	refcount_set(&bond->refs, 1);
> > +	RCU_INIT_POINTER(bond->io_mm, io_mm);
> > +
> > +	mutex_lock(&iommu_sva_lock);
> > +	/* Is it already bound to the device or domain? */
> > +	list_for_each_entry(tmp, &io_mm->devices, mm_head) {
> > +		if (tmp->sva.dev != dev) {
> > +			other =
> > iommu_get_domain_for_dev(tmp->sva.dev);
> > +			if (domain == other)
> > +				attach_domain = false;
> > +
> > +			continue;
> At this point, we already know this is a new device trying to attach to
> one of io_mm's existing domains.
>
> So there is no need to continue
> checking, right? Perhaps check like this?
> -               if (tmp->sva.dev != dev) {
> +               if (tmp->sva.dev != dev && attach_domain) {

That doesn't seem right, we need the 'continue'. I'll turn this around
into 'if (tmp->sva.dev == dev)' to make things more readable.

> > +		}
> > +
> > +		if (WARN_ON(tmp->drvdata != drvdata)) {
> > +			ret = -EINVAL;
> > +			goto err_free;
> > +		}
> > +
> > +		/*
> > +		 * Hold a single io_mm reference per bond. Note that
> > we can't
> > +		 * return an error after this, otherwise the caller
> > would drop
> > +		 * an additional reference to the io_mm.
> > +		 */
> > +		refcount_inc(&tmp->refs);
> > +		io_mm_put(io_mm);
> > +		kfree(bond);
> Can bond be allocated after searching for existing bond or domain? If
> so, we can avoid free bond here.

Yes, and I think we can simplify the whole function further. I think I
wrote it that way to have the kzalloc() be outside iommu_sva_lock, back
when it was a spinlock.

> > +		mutex_unlock(&iommu_sva_lock);
> > +		return &tmp->sva;
> > +	}
> > +
> > +	list_add_rcu(&bond->mm_head, &io_mm->devices);
> > +	param->nr_bonds++;
> > +	mutex_unlock(&iommu_sva_lock);
> > +
> > +	ret = io_mm->ops->attach(bond->sva.dev, io_mm->pasid,
> > io_mm->ctx,
> > +				 attach_domain);
> For VT-d, if a device trying to do SVA bind, there would not be a DMA
> domain. SVA should own the entire address space, no IOVA.

Do you mean PASID table rather than address space?

> So this
> attach() call is for VT-d driver to setup the first PASID table entry
> regardless attach_domain is true or false?

Yes ignoring the attach_domain parameter should be fine (more below). 

[...]
> > +static void iommu_sva_unbind_locked(struct iommu_bond *bond)
> > +{
> > +	struct device *dev = bond->sva.dev;
> > +	struct iommu_sva_param *param = dev->iommu_param->sva_param;
> > +
> > +	if (!refcount_dec_and_test(&bond->refs))
> > +		return;
> > +
> dont you need to free bond here?

We free it in the rcu callback below

> > +	io_mm_detach_locked(bond);
> > +	param->nr_bonds--;
> > +	kfree_rcu(bond, rcu_head);
> > +}
> > +
> > +void iommu_sva_unbind_generic(struct iommu_sva *handle)
> > +{
> > +	struct iommu_param *param = handle->dev->iommu_param;
> > +
> > +	if (WARN_ON(!param))
> > +		return;
> > +
> > +	mutex_lock(&param->sva_lock);
> > +	mutex_lock(&iommu_sva_lock);
> > +	iommu_sva_unbind_locked(to_iommu_bond(handle));
> > +	mutex_unlock(&iommu_sva_lock);
> > +	mutex_unlock(&param->sva_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_unbind_generic);
> > +
> > +/**
> > + * iommu_sva_enable() - Enable Shared Virtual Addressing for a device
> > + * @dev: the device
> > + * @sva_param: the parameters.
> > + *
> > + * Called by an IOMMU driver to setup the SVA parameters
> > + * @sva_param is duplicated and can be freed when this function
> > returns.
> > + *
> > + * Return 0 if initialization succeeded, or an error.
> > + */
> IOMMU vendor driver usually dont know when the device SVA feature will
> be used until bind call. So we pretty much have to call this for every
> device during init time?

Not necessarily. Before bind the device driver should call
iommu_dev_enable_feature(dev, IOMMU_FEAT_SVA), which is when SMMUv3
invokes iommu_sva_enable()

[...]
> > +struct io_mm_ops {
> > +	/* Allocate a PASID context for an mm */
> > +	void *(*alloc)(struct mm_struct *mm);
> > +
> > +	/*
> > +	 * Attach a PASID context to a device. Write the entry into
> > the PASID
> > +	 * table.
> > +	 *
> > +	 * @attach_domain is true when no other device in the IOMMU
> > domain is
> > +	 *   already attached to this context. IOMMU drivers that
> > share the
> > +	 *   PASID tables within a domain don't need to write the
> > PASID entry
> > +	 *   when @attach_domain is false.
> > +	 */
> If we have per device PASID table, then we need to set up PASID table
> entry regardless of the domain sharing.

Yes, the attach_domain is a hint for IOMMU drivers that handle PASID
tables per domain (SMMUv3). If PASID tables are per device then it can be
ignored. I added it to the interface because it's a lot more difficult to
check from within the SMMU driver, whereas iommu-sva already iterates over
all devices attached to an io_mm. Arguably the hint isn't as useful on
attach than on detach, where we must not clear the PASID table entry if
other devices in the domain are still using it.

> What is confusing to me is that
> domain is for DMA isolation on request w/o PASID, but with SVA we don't
> really care about domains. Sorry, it has been a long time since we
> discussed this. I think will work for VT-d but just wanted to make sure
> I understand the intentions.

No problem, it has been a while and I don't remember the rationale for
every choice. It's good to question whether they're still valid.

I find the per-domain PASID table to be a good model when reasoning about
IOMMU groups. In pci_device_group() a single group is created for devices
whose Requester ID alias, and they all get the same domain. In a buggy
system, if a device can issue DMA with the RID of another, then regardless
of PASID the IOMMU cannot isolate them. Having per-device PASID table
doesn't add any isolation but may hide the flaw from the user, if they
think that binding an mm to device A prevents a DMA-aliased device B from
accessing it.

This is hypothetical because we don't allow SVA for multi-device groups at
the moment (sanity-check would be messy) but maybe buggy implementations
will want this support in the future.

In the normal case, one device per domain, having PASID tables on the
domain rather than device doesn't make a difference. It makes a difference
if the user wants to put multiple devices in the same domain (e.g. VFIO
container). I don't know if that's a use-case.

Thanks,
Jean
