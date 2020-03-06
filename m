Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0649917C056
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 15:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFOgG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 09:36:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37037 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFOgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 09:36:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id a141so2622884wme.2
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IdtX3txS1Rj5y4dz7wIKkSyvH1Rw1XFvTfdagNbM2bU=;
        b=YUvu6JjSjCjKSmfeTWzbk/mitLMbkxf3DfR+DN3duN1k0wQoKseoCpJQmbriD7dA70
         8lgpo6K+CWIlciFI2d54YI7ZPsG+7USrqrtkCgGFribhynpJBKxPSj45NC0zhWSn5/1Z
         QvmV51OgAMAsAphmeqXjhnhQfdicOmQ0U7o3dvPsmvRBEofJYP3mrx+y2ArtO8DyqDRd
         AoHZI/gJNMRX2c9O4/4ju3VY+bc3DPpqGuP494u/tNGEkyfhkaHCaRUslOhxBuZx0TnN
         OtknlK8DNrF218Ds29fpJK9GhchaEDI0LjqY89n2JxWqqXctj4YRUS+77wC9cESbAUFC
         0YDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IdtX3txS1Rj5y4dz7wIKkSyvH1Rw1XFvTfdagNbM2bU=;
        b=Wjv9rN5loAbNiEqZMu1ICMxag3Z6TeQfG0quOgolhvYT484KcezSrTA9H9AZWvlRNs
         HNltKwqpOWUKo4lqGb3BkDAJq7PPZAZef/irU6SUV/LvHLCJLHxx4wDxQ2on8jXgMmNO
         A2QEHqE6KnBOrUQLORD0nfYFDUd0o17jNj0j7lTQRTmjXjDDIGtkj9Wtb9piv+xmVHMn
         C321knX2nQhTsWsRnC+hW++R8bCyH2T3OICHwGp1I+W6jAL5urc0bjwSxTwe+wHfzysw
         SBQueWINwI5tcwnzD0xENDkqFoIexuE23bEfOnkTAFy2zdYjy+CXj+jYJGDBVrQab9Sn
         m9sg==
X-Gm-Message-State: ANhLgQ1HqAuuo7doMESGmu17yV9G2qF3O5+WVfKeuT6zMoRqs60FX9aK
        yXQRvEAfe4DaaCJAnUF85+9mPg==
X-Google-Smtp-Source: ADFU+vso3XaLrSLsJHyy38nS4lkcofYSES+LpI4xvlFWzpkLgomnvoNduJx+7dNPFwc8Wt+DimCgxg==
X-Received: by 2002:a7b:ca52:: with SMTP id m18mr4589811wml.168.1583505363558;
        Fri, 06 Mar 2020 06:36:03 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w8sm15370244wmm.0.2020.03.06.06.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 06:36:02 -0800 (PST)
Date:   Fri, 6 Mar 2020 15:35:56 +0100
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
Message-ID: <20200306143556.GA99609@myrica>
References: <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306130919.GJ31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > in bind(), and mmu_notifier_put() is called in unbind(). 
> > 
> > Multiple device drivers may call bind() with the same mm. Each bind()
> > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > mmu_notifier_put().
> > 
> > That's the most common case. Now if the process is killed and the mm
> > disappears, we do need to avoid use-after-free caused by DMA of the
> > mappings and the page tables. 
> 
> This is why release must do invalidate all - but it doesn't need to do
> any more - as no SPTE can be established without a mmget() - and
> mmget() is no longer possible past release.

In our case we don't have SPTEs, the whole pgd is shared between MMU and
IOMMU (isolated using PASID tables).

Taking the concrete example of the crypto accelerator:

1. A process opens a queue in the accelerator. That queue is bound to the
   address space: a PASID is allocated for the mm, and mm->pgd is written
   into the IOMMU PASID table.
2. The process queues some work and waits. In the background, the
   accelerators performs DMA on the process address space, by using the
   mm's PASID.
3. Now the process gets killed, and release() is called.

At this point no one told the device to stop working on this queue, it may
still be doing DMA on this address space. So the first thing we do is
notify the device driver that the bond is going away, and that it must
stop the queue and flush remaining DMA transactions for this PASID.

Then we also clear the pgd from the IOMMU PASID table. If we only did
invalidate-all and somehow the queue wasn't properly stopped, concurrent
DMA would immediately form new IOTLB entries since the page tables haven't
been wiped at this point. And later, it would use-after-free page tables
and mappings. Whereas with a clear pgd it would just generate IOMMU fault
events, which are undesirable but harmless.

Thanks,
Jean

> > So the release() callback, before doing invalidate_all, stops DMA
> > and clears the page table pointer on the IOMMU side. It detaches all
> > bonds from the io_mm, calling mmu_notifier_put() for each of
> > them. After release(), bond objects still exists and device drivers
> > still need to free them with unbind(), but they don't point to an
> > io_mm anymore.
> 
> Why is so much work needed in release? It really should just be
> invalidate all, usually trying to sort out all the locking for the
> more complicated stuff is not worthwhile.
> 
> If other stuff is implicitly relying on the mm being alive and release
> to fence against that then it is already racy. If it doesn't, then why
> bother doing complicated work in release?
> 
> > > Then you can never get a stale
> > > pointer. Don't worry about exit_mmap().
> > > 
> > > release() is an unusual callback and I see alot of places using it
> > > wrong. The purpose of release is to invalidate_all, that is it.
> > > 
> > > Also, confusingly release may be called multiple times in some
> > > situations, so it shouldn't disturb anything that might impact a 2nd
> > > call.
> > 
> > I hadn't realized that. The current implementation should be safe against
> > it, as release() is a nop if the io_mm doesn't have bonds anymore. Do you
> > have an example of such a situation?  I'm trying to write tests for this
> > kind of corner cases.
> 
> Hmm, let me think. Ah, you have to be using mmu_notifier_unregister()
> to get that race. This is one of the things that get/put don't suffer
> from - but they conversely don't guarantee that release() will be
> called, so it is up to the caller to ensure everything is fenced
> before calling put.
> 
> Jason
