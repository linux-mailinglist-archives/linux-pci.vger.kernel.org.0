Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4916AFE1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 20:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgBXTA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 14:00:59 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33619 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgBXTA7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Feb 2020 14:00:59 -0500
Received: by mail-qv1-f65.google.com with SMTP id ek2so4618663qvb.0
        for <linux-pci@vger.kernel.org>; Mon, 24 Feb 2020 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nS4y9b6My/7+JIxHts6eLm8z0C4thsb5l3wuyiXD29Q=;
        b=FnR6SEUSqjm6pva9hmjZjjMQWlNtH8BimVmLzNHoyK5KObnwJJd4v62FvcucQXR613
         Vs8HRCZGupCTQ5IZ0JUUxDfBksnOmCrAaBY+t9FVQ6WaO9/f1nfENMH64EtLf6mQOl3A
         ULGnEHBvxwQ+J67AeNEUPMlBMuj+D9qb1H5X2oBhmsBZnIHcb4yro7ts8Lp+wdj45jEW
         v76e8KPBbvQd89kU+MetflzO8JQksrPwRwleGV8a9HuL+52ruaZpjBkc9Ny6pYP+Y1YO
         IlJp1zbAGL4jPjja65grNuAP/DFEdsR9iZ2aPGrstIS0jUFiDV/TkZWtZDP/2nIWRKh9
         659A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nS4y9b6My/7+JIxHts6eLm8z0C4thsb5l3wuyiXD29Q=;
        b=ZjDyEdmbuaGyFcIzJn2BJeAozVexf1sP4r4k+xwsDGrUykSj3Us9u0qVm3yEmP/QpH
         KsIR1iIPAY/MAYW58X/YjOto8SeaT1VzyZOmsBksRrAw0EXfEhM86Wd95J0jAAf1QAEG
         s0ZuDl7Z2MidOy22ww1OXlZvr+7wbR2LORRzOFjmzQzdhkQh6TE9D70SishW7JAegP5V
         UzLgGRT4v5ysSyQ8/uCBfmTbmTaZv9t3y+6ffWeJ3S+4fdw+CNJSaOozivN/oW8ht6lo
         +iEaXdxPEVafwUhGZlvg2+lVRPeHFd2XUPwObEianKYb5XgcnFPXv+31TAWJNSd1tQBM
         1dfw==
X-Gm-Message-State: APjAAAXWoyjlqTB6bH70z5o4hpf0CFalRaBdtEukWgXDu+KTfgxtZECI
        3e/is0wpGaepLiZj9YosEi6oyQ==
X-Google-Smtp-Source: APXvYqyNbYKidHbzZ1XJJ2LbIhIEjWa9RFdUt4bTzm6wm+o3ErpK3Y9OIJTvmpvQbXJ0sVD9TGvEfA==
X-Received: by 2002:ad4:4b21:: with SMTP id s1mr47274639qvw.81.1582570858491;
        Mon, 24 Feb 2020 11:00:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m17sm6086872qki.128.2020.02.24.11.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 11:00:57 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6IyO-0005Dy-Tk; Mon, 24 Feb 2020 15:00:56 -0400
Date:   Mon, 24 Feb 2020 15:00:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
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
Message-ID: <20200224190056.GT31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224182401.353359-2-jean-philippe@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> add a get/put scheme for the registration") provides a convenient way
> for users to attach notifier data to an mm. However, it would be even
> better to create this notifier data atomically.
> 
> Since the alloc_notifier() callback only takes an mm argument at the
> moment, some users have to perform the allocation in two times.
> alloc_notifier() initially creates an incomplete structure, which is
> then finalized using more context once mmu_notifier_get() returns. This
> second step requires carrying an initialization lock in the notifier
> data and playing dirty tricks to order memory accesses against live
> invalidation.

This was the intended pattern. Tthere shouldn't be an real issue as
there shouldn't be any data on which to invalidate, ie the later patch
does:

+       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)

And that list is empty post-allocation, so no 'dirty tricks' required.

The other op callback is release, which also cannot be called as the
caller must hold a mmget to establish the notifier.

So just use the locking that already exists. There is one function
that calls io_mm_get() which immediately calls io_mm_attach, which
immediately grabs the global iommu_sva_lock.

Thus init the pasid for the first time under that lock and everything
is fine.

There is nothing inherently wrong with the approach in this patch, but
it seems unneeded in this case..

Jason
