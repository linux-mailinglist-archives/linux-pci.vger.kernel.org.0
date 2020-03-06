Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2619917C2B0
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 17:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCFQP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 11:15:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgCFQP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Mar 2020 11:15:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id u9so2971500wml.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Mar 2020 08:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ao7/80FHIHDLP/KCunZJJgILy66emPF5N72zFy2TR8A=;
        b=ZzXz4A8vycCJh4RNBaNwHExa5FzLad69MAK4BZ+5/as1gVnRbY6GMPLpDuEkpCKWF6
         y6CsRjCx5QLX391p185dlNAY1Zcap1EnGsNaLq9XDn4MYET7xEWLNyB/6LDuPN6MRygC
         YZ5w1hGW0XSmAZgBTL6frJPrhb9fznVH9L9vwRNdIecRFk8QGoUr/L+Knolbah0v2qev
         1VwkncH2BAtFZIbRxurp6iliV7mw4l8C3XnXlu/qVJcZHUrF9gIymPJHAlq33QsB4aQ6
         QXgqfDAnyXp5rPLLQMnU0kpgkNyKPGKwvV48byaa1UK7DgR+lESHtDBsR9KfL7wvFZWh
         kldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ao7/80FHIHDLP/KCunZJJgILy66emPF5N72zFy2TR8A=;
        b=XPogQvWWGFbVF0cyGDpNL39oZiWl1nuxamjOo0SYtm7PmgxJW1QTe+aesyRQixnaGU
         lJE4Gptuzaai447Azbe0MvLL+O/MXGCUDExGM9yyvB4zuqa0CQWdTX+7XRZPStIFzEbb
         86EuA8HuBo/FdcCfQFun8oSsRCUM3PlUMgOuYiqBjT5Toh51+7eFq3OEeSx2h0G5mXRz
         88CpDrr1gUaBYbZS4iCSLrOTB7LqEzjr5zrR3da3tpWF9Z9MbTLC9+VjLddR3xXffpaR
         QUoY1wiCIch1bY7NttwpGIrig7hFo5oy7O+qBU7UXpqyqSl5RvEeODSzTYBLpqcOGwOB
         jRSQ==
X-Gm-Message-State: ANhLgQ22r9nCLF+5mJRdRKwlZgIwsmXW8J1sbOoBrff4vFRft67uYJZR
        HUvLRgnJpzjA1C4/Lj7Utb0VOQ==
X-Google-Smtp-Source: ADFU+vu2BwVlJ/z2C8XR7GuNqHPcvrDYuSW70Gsa5PRrlPgFIIEEdN81oD/hv1UjzmKlfbVNO9GZjg==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr5012462wmd.185.1583511326318;
        Fri, 06 Mar 2020 08:15:26 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i21sm3449182wmb.23.2020.03.06.08.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 08:15:25 -0800 (PST)
Date:   Fri, 6 Mar 2020 17:15:19 +0100
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
Message-ID: <20200306161519.GB99609@myrica>
References: <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
 <20200228151339.GS31668@ziepe.ca>
 <20200306095614.GA50020@myrica>
 <20200306130919.GJ31668@ziepe.ca>
 <20200306143556.GA99609@myrica>
 <20200306145245.GK31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306145245.GK31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 10:52:45AM -0400, Jason Gunthorpe wrote:
> On Fri, Mar 06, 2020 at 03:35:56PM +0100, Jean-Philippe Brucker wrote:
> > On Fri, Mar 06, 2020 at 09:09:19AM -0400, Jason Gunthorpe wrote:
> > > On Fri, Mar 06, 2020 at 10:56:14AM +0100, Jean-Philippe Brucker wrote:
> > > > I tried to keep it simple like that: normally mmu_notifier_get() is called
> > > > in bind(), and mmu_notifier_put() is called in unbind(). 
> > > > 
> > > > Multiple device drivers may call bind() with the same mm. Each bind()
> > > > calls mmu_notifier_get(), obtains the same io_mm, and returns a new bond
> > > > (a device<->mm link). Each bond is freed by calling unbind(), which calls
> > > > mmu_notifier_put().
> > > > 
> > > > That's the most common case. Now if the process is killed and the mm
> > > > disappears, we do need to avoid use-after-free caused by DMA of the
> > > > mappings and the page tables. 
> > > 
> > > This is why release must do invalidate all - but it doesn't need to do
> > > any more - as no SPTE can be established without a mmget() - and
> > > mmget() is no longer possible past release.
> > 
> > In our case we don't have SPTEs, the whole pgd is shared between MMU and
> > IOMMU (isolated using PASID tables).
> 
> Okay, but this just means that 'invalidate all' also requires
> switching the PASID to use some pgd that is permanently 'all fail'.
> 
> > At this point no one told the device to stop working on this queue,
> > it may still be doing DMA on this address space.
> 
> Sure, but there are lots of cases where a defective user space can
> cause pages under active DMA to disappear, like munmap for
> instance. Process exit is really no different, the PASID should take
> errors and the device & driver should do whatever error flow it has.

We do have the possibility to shut things down in order, so to me this
feels like a band-aid. The idea has come up before though [1], and I'm not
strongly opposed to this model, but I'm still not convinced it's
necessary. It does add more complexity to IOMMU drivers, to avoid printing
out the errors that we wouldn't otherwise see, whereas device drivers need
in any case to implement the logic that forces stop DMA.

Thanks,
Jean

[1] https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/

> 
> Involving a complex driver flow in the exit_mmap path seems like
> dangerous complexity to me.
> 
> Jason
