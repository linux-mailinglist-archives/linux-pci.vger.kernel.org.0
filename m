Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66A17B9A8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 10:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgCFJ4Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 04:56:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50626 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgCFJ4Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 04:56:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1675508wmb.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7WA8KxQFlE6B8qCgTFRQ+YrpY3GYXgfg/QOgK1f77sM=;
        b=Z+vSL2j8scoLCGNkZyokN15xJq1aniWOej9xa0jO1y/7aiSn6wUVH8PGc2mmDoSxkx
         hKYfJxAN6zemdGqm+/m/AwAvjWPnxYO3i8iNXAcdbEHhdhF9uUqrEmLCTqWr8lqHMzAU
         5/u3kcwg3w6H2MZgNCyva5KikrewAvfB8ctsMOZd35NBMW7AF0sSL8FLlPXq2+tABW5v
         3eEcsqfJCErJCgsWy2UZ9D2YLRkwKUkct1WRvgXbWkdGsl+/AqLCS6/4rzZZzbeHMXAb
         aQFr7GnLr8aSRBGzmvQjRCLEcf731bgNW+CD7gus6HHQ+MyynH9kPWMxpkl+lZZbqIIM
         Kw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7WA8KxQFlE6B8qCgTFRQ+YrpY3GYXgfg/QOgK1f77sM=;
        b=LEYpLY+3hyW/mlNUV8a7x9NPTyf5ph4Qpj5BaHdw0S3EvcccJIJWzO1nDWFee7PCVv
         FNuN05uvbvJXZGesAj6Fczc1EklMKJ60vmmv3vNBAY6cv3kswvlipnCNQX+fB92dh1gJ
         JN0Lj9iyuTS25JBZHEqdSzDQqrdcJhODlaUy2lgkOeVsODPxd5ChzdfLv0C0UfMv1EIF
         11RS41pIXYW71KNnUd1Kj7I0HR/Pg/eaC2VFHR6NMHtiJHjcLGwVB2NVKn6UUMARezi2
         mlZchZ42aI72BOeKd7SviKN4qz6ggbx+v7nbhysjy/rLTQJydquxk4BN1/Id9bKrLCz9
         6elA==
X-Gm-Message-State: ANhLgQ0JtS69HFWNUeWXWxOpV3/j7MOZu/1uhFqVxkdhVdBpGTgvVLMt
        /Tmxe82A/YuPsa651NhXdtuCZw==
X-Google-Smtp-Source: ADFU+vuU7aA2moxG0tbzibZ6qR77dGIj+dzVr37QpTQa4MjhQ67tVPECKIRxafVKMX7XzMD/CpXXyA==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr3243910wmj.6.1583488582036;
        Fri, 06 Mar 2020 01:56:22 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id m25sm12484502wml.35.2020.03.06.01.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 01:56:21 -0800 (PST)
Date:   Fri, 6 Mar 2020 10:56:14 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, will@kernel.org,
        Dimitri Sivanich <sivanich@sgi.com>, catalin.marinas@arm.com,
        zhangfei.gao@linaro.org, devicetree@vger.kernel.org,
        kevin.tian@intel.com, Arnd Bergmann <arnd@arndb.de>,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        robin.murphy@arm.com, christian.koenig@amd.com
Subject: Re: [PATCH v4 01/26] mm/mmu_notifiers: pass private data down to
 alloc_notifier()
Message-ID: <20200306095614.GA50020@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228151339.GS31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 11:13:40AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2020 at 04:04:27PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > > > +		/*
> > > > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > > > +		 * from list_add_rcu().
> > > > > > +		 */
> > > > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > > > 
> > > > > A rcu_dereference isn't need here, just a normal derference is fine.
> > > > 
> > > > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > > > which does bond->io_mm under rcu_read_lock())
> > > 
> > > I'm surprised the bond->io_mm can change over the lifetime of the
> > > bond memory..
> > 
> > The normal lifetime of the bond is between device driver calls to bind()
> > and unbind(). If the mm exits early, though, we clear bond->io_mm. The
> > bond is then stale but can only be freed when the device driver releases
> > it with unbind().
> 
> I usually advocate for simple use of these APIs. The mm_notifier_get()
> should happen in bind() and the matching put should happen in the
> call_rcu callbcak that does the kfree.

I tried to keep it simple like that: normally mmu_notifier_get() is called
in bind(), and mmu_notifier_put() is called in unbind(). 

Multiple device drivers may call bind() with the same mm. Each bind()
calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
(a device<->mm link). Each bond is freed by calling unbind(), which calls
mmu_notifier_put().

That's the most common case. Now if the process is killed and the mm
disappears, we do need to avoid use-after-free caused by DMA of the
mappings and the page tables. So the release() callback, before doing
invalidate_all, stops DMA and clears the page table pointer on the IOMMU
side. It detaches all bonds from the io_mm, calling mmu_notifier_put() for
each of them. After release(), bond objects still exists and device
drivers still need to free them with unbind(), but they don't point to an
io_mm anymore.

> Then you can never get a stale
> pointer. Don't worry about exit_mmap().
> 
> release() is an unusual callback and I see alot of places using it
> wrong. The purpose of release is to invalidate_all, that is it.
> 
> Also, confusingly release may be called multiple times in some
> situations, so it shouldn't disturb anything that might impact a 2nd
> call.

I hadn't realized that. The current implementation should be safe against
it, as release() is a nop if the io_mm doesn't have bonds anymore. Do you
have an example of such a situation?  I'm trying to write tests for this
kind of corner cases.

Thanks,
Jean
