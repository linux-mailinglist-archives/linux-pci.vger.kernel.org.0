Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74220173A06
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 15:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgB1Ojp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 09:39:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43623 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgB1Ojo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 09:39:44 -0500
Received: by mail-wr1-f67.google.com with SMTP id e10so1766316wrr.10
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 06:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0bZtBK6HC94nIEacPL+V6SajMXEMTp9BAFVguJlaz+Q=;
        b=v7jFCl7OdeBWLjzPqqQAjqPrO/bujVk3YQ+hyShHLUfXRhZTEjht+G1EeKmiALwmrF
         +K7WW2uAYpZmtBzezuv2w6JdJBKpUdrsVHMYifTW3ola4TSC2f9DFxhquGsIb9CwsYcj
         I013dyyZ6/sIBNapnY1ANl/WmtPXa7OasfQA2NEYVXDTycNT7T/szrd8fPkyKttzDOhS
         AkrRy0wJlbcKiLL14UW8NPqnhuTmdqHG+yqHosj5GBL25ODsv4IeTcjj/P24pxnowkqO
         vgOp2+gPP2nbd/AjqXRm5VyhdRF+ZL9iukIU6Y4I/BilXyOX38XdNblyty+GogNj1crk
         MH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bZtBK6HC94nIEacPL+V6SajMXEMTp9BAFVguJlaz+Q=;
        b=p+mK1RqJUa2u5QfnPmI4onWnn1xfvcGPNUfg9nTrVvKQEloxWfIqGyHREEVT4bWD5y
         VPxTZWr6ybuz2tLQpLcsTRSOThr65yRZgl0Wj581LAtLLFWfjwc3LXlHIU6rujgAELNA
         b52Tcr5SM3flAAIrehNoSaI7nfDCnryoyWkuozbLP+hSgtTKLQG926oVRy0sxQeI2H+I
         SDx9RuCZOPADp69IhzGfJTjOstKMvpSsVhHRN12KlE0UjYaFQ7UkrqFEw+vJh9tkIof7
         2WSnS26oRa+QkN3ASOYIrxjW7j4iCjHqCJC5FLb/NjtZLI3u9yRFAIcXtwUKs2W+g3Hs
         cbJQ==
X-Gm-Message-State: APjAAAXqz+s2Rg4EGrv3j/kJHa5tVesye53m2LednIUMKuO/8ilRLVzW
        4fUzUDULFEQSeN1g0tI1fUEGLQ==
X-Google-Smtp-Source: APXvYqy36tgbgxq6aX9f3yrenPgU8REug1w3SCjW1FgRUfJhNgTMxVBJWR+Ek+IeYzLIg7r0rI/Bvg==
X-Received: by 2002:adf:ec0e:: with SMTP id x14mr4896046wrn.270.1582900782663;
        Fri, 28 Feb 2020 06:39:42 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id a7sm2294800wmj.12.2020.02.28.06.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:39:42 -0800 (PST)
Date:   Fri, 28 Feb 2020 15:39:35 +0100
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
Message-ID: <20200228143935.GA2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225140814.GW31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 10:08:14AM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2020 at 10:24:39AM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > > > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > > > add a get/put scheme for the registration") provides a convenient way
> > > > for users to attach notifier data to an mm. However, it would be even
> > > > better to create this notifier data atomically.
> > > > 
> > > > Since the alloc_notifier() callback only takes an mm argument at the
> > > > moment, some users have to perform the allocation in two times.
> > > > alloc_notifier() initially creates an incomplete structure, which is
> > > > then finalized using more context once mmu_notifier_get() returns. This
> > > > second step requires carrying an initialization lock in the notifier
> > > > data and playing dirty tricks to order memory accesses against live
> > > > invalidation.
> > > 
> > > This was the intended pattern. Tthere shouldn't be an real issue as
> > > there shouldn't be any data on which to invalidate, ie the later patch
> > > does:
> > > 
> > > +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> > > 
> > > And that list is empty post-allocation, so no 'dirty tricks' required.
> > 
> > Before introducing this patch I had the following code:
> > 
> > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > +		/*
> > +		 * To ensure that we observe the initialization of io_mm fields
> > +		 * by io_mm_finalize() before the registration of this bond to
> > +		 * the list by io_mm_attach(), introduce an address dependency
> > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > +		 * from list_add_rcu().
> > +		 */
> > +		io_mm = rcu_dereference(bond->io_mm);
> 
> A rcu_dereference isn't need here, just a normal derference is fine.

bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
which does bond->io_mm under rcu_read_lock())

> 
> > +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> > +				       start, end - start);
> > +	}
> > 
> > (1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
> > (2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
> > (3) finally io_mm_attach() would add the bond to io_mm->devices.
> > 
> > Since the above code can run before (2) it needs to observe valid
> > io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
> > initialized by (3). Which I believe requires the address dependency from
> > the rcu_dereference() above or some stronger barrier to pair with the
> > list_add_rcu().
> 
> The list_for_each_entry_rcu() is an acquire that already pairs with
> the release in list_add_rcu(), all you need is a data dependency chain
> starting on bond to be correct on ordering.
> 
> But this is super tricky :\
> 
> > If io_mm->ctx and io_mm->ops are already valid before the
> > mmu notifier is published, then we don't need that stuff.
> 
> So, this trickyness with RCU is not a bad reason to introduce the priv
> scheme, maybe explain it in the commit message?

Ok, I've added this to the commit message:

    The IOMMU SVA module, which attaches an mm to multiple devices,
    exemplifies this situation. In essence it does:

            mmu_notifier_get()
              alloc_notifier()
                 A = kzalloc()
              /* MMU notifier is published */
            A->ctx = ctx;                           // (1)
            device->A = A;
            list_add_rcu(device, A->devices);       // (2)

    The invalidate notifier, which may start running before A is fully
    initialized at (1), does the following:

            io_mm_invalidate(A)
              list_for_each_entry_rcu(device, A->devices)
                A = device->A;                      // (3)
                device->invalidate(A->ctx)

    To ensure that an invalidate() thread observes write (1) before (2), it
    needs the address dependency (3). The resulting code is subtle and
    difficult to understand. If instead we fully initialize object A before
    publishing the MMU notifier, we don't need the complexity added by (3).


I'll try to improve the wording before sending next version.

Thanks,
Jean
