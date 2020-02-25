Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A0116BD32
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgBYJYu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:24:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729864AbgBYJYt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:24:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so13785055wru.7
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2020 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f/BcuFESeD0nxQhG6MiD0u6r1X/PnHdRmEXqrbWhTtE=;
        b=zl3vF2DlbSqx5eFLLSUdDjI9EBwAJZ4gdDoR9UGpSvUPJOfbkv3eJR3zZrLTOKMU5r
         D1kDFHHNnWKKqrQV7qph5B4gnUnW3MYHNVP9WtLrfnDrCUvQMjwl171h+LwnhrjjAhUL
         ZdjznstMqGMEo0r7R+ZMNgE9YsZkix386pUoowGHr7Xeuj/plf1j8rEUOxYGQi94ARnr
         /AuqGhdu0td5MoZWNt7hEUNQw/YJTSVuPHT+6d5f6XwTZqTqrzty29h/tWMUE+qOVNNo
         O5UynFhd8cMEe83OPT8ZfIyYc0CAYZv4eLxgs1/afMqrI4bm73/HwhckO87ueeMlK+p9
         B/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/BcuFESeD0nxQhG6MiD0u6r1X/PnHdRmEXqrbWhTtE=;
        b=EBhrpZAGLV/ovmuPwB7n26m6PiSfe4LmfD9n+Yp1HwvFTV3dEjFvIgK0I735DUL6hh
         osFTBy/eD00gAFZdgmTBMw9TTsZIcfdyk31n2ENgnogbbG8jO69omcsaOuHyK+7fa0ha
         KAgayIJpb8U47CFLjXVSYruIKRN3mVxfAPXEWIlHz4uv6hwri4UffK7IqoyjLhKvl2C6
         fKy/WcivXWxO00Q3sBxcmaUR/2wZJaqQA1o0FsFKZTZ+0WBE62V9/4GLVMxtCjtefnHv
         svXh0F7pOjiSzTc7ZPWakH8D3eIuLmTVecoq3UB/5gUUK3ZiQ2ANOlJTYtvZ3LpXAPqM
         xsZw==
X-Gm-Message-State: APjAAAWVV32PsuFMTGv6Ghf+BvD6Zy5I4q5DNzjRcPWDzwMfPReU/NeC
        jLTTiFm7Ooln1Q0nxPYo9rIwsg==
X-Google-Smtp-Source: APXvYqzEBhx+1qou+rx6ieuBuVr+WsrtZbhL85bwQfWbU5iCMd2zUrtZQURsgfjNBpo6KHXv5wrHgA==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr1745887wre.390.1582622687476;
        Tue, 25 Feb 2020 01:24:47 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id k16sm23442823wru.0.2020.02.25.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 01:24:46 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:24:39 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, joro@8bytes.org, robh+dt@kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        robin.murphy@arm.com, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, Jonathan.Cameron@huawei.com,
        jacob.jun.pan@linux.intel.com, christian.koenig@amd.com,
        yi.l.liu@intel.com, zhangfei.gao@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dimitri Sivanich <sivanich@sgi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200225092439.GB375953@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224190056.GT31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > add a get/put scheme for the registration") provides a convenient way
> > for users to attach notifier data to an mm. However, it would be even
> > better to create this notifier data atomically.
> > 
> > Since the alloc_notifier() callback only takes an mm argument at the
> > moment, some users have to perform the allocation in two times.
> > alloc_notifier() initially creates an incomplete structure, which is
> > then finalized using more context once mmu_notifier_get() returns. This
> > second step requires carrying an initialization lock in the notifier
> > data and playing dirty tricks to order memory accesses against live
> > invalidation.
> 
> This was the intended pattern. Tthere shouldn't be an real issue as
> there shouldn't be any data on which to invalidate, ie the later patch
> does:
> 
> +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> 
> And that list is empty post-allocation, so no 'dirty tricks' required.

Before introducing this patch I had the following code:

+	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
+		/*
+		 * To ensure that we observe the initialization of io_mm fields
+		 * by io_mm_finalize() before the registration of this bond to
+		 * the list by io_mm_attach(), introduce an address dependency
+		 * between bond and io_mm. It pairs with the smp_store_release()
+		 * from list_add_rcu().
+		 */
+		io_mm = rcu_dereference(bond->io_mm);
+		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
+				       start, end - start);
+	}

(1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
(2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
(3) finally io_mm_attach() would add the bond to io_mm->devices.

Since the above code can run before (2) it needs to observe valid
io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
initialized by (3). Which I believe requires the address dependency from
the rcu_dereference() above or some stronger barrier to pair with the
list_add_rcu(). If io_mm->ctx and io_mm->ops are already valid before the
mmu notifier is published, then we don't need that stuff.

That's the main reason I would have liked moving everything to
alloc_notifier(), the locking below isn't a big deal.

> The other op callback is release, which also cannot be called as the
> caller must hold a mmget to establish the notifier.
> 
> So just use the locking that already exists. There is one function
> that calls io_mm_get() which immediately calls io_mm_attach, which
> immediately grabs the global iommu_sva_lock.
> 
> Thus init the pasid for the first time under that lock and everything
> is fine.

I agree with this, can't remember why I used a separate lock for
initialization rather than reusing iommu_sva_lock.

Thanks,
Jean

> 
> There is nothing inherently wrong with the approach in this patch, but
> it seems unneeded in this case..
> 
> Jason
