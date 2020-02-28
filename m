Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC00173AA4
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgB1PEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:04:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42525 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgB1PEg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:04:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so3275439wre.9
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 07:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2wX7TVsRPWlph7pT/yUYa9EScRJx6Bt/ZtuI3MJeqc0=;
        b=QmD58Jr5s6XBLi75aKomne6pIfi3eAwBW2uYAgqcgi9rYL6G2b64JBuAhhJ1f4te+t
         YMUkbgfFABgR0aUFU4JS096/XwdfBA48niRJ6aEs7tCqepHjgsV+l2E6wcg2Pjfx8yDo
         nf2skHBkoT9WNffr5CVK3OP/PqPaYbv3aLmg1bq6Ck4RCaCb9gSeMd1pwHi25t4XMDZ2
         wTbnbrTrIL7bSS1pZZd4ftBNuWdi6gB3+KHzkO3i4r62kLW9iRm0F/3xPVeufpfeXlyV
         F/ABlN3x4IYUOzxYknE1CmZaru7JzdyANO9LsTAgaHuR2Jzumx6YW0C7y8C7WKLy44Wn
         wxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2wX7TVsRPWlph7pT/yUYa9EScRJx6Bt/ZtuI3MJeqc0=;
        b=Wjt31jsGVdCIobKI28pBkHYFAY8FiY4kDQblJlWvGWL775Zm9Uh+4TuQ1Uo5t5I9Wv
         8b1SoidaS1d8heLMe4iAktZGfUqx+zRea49jD5nxF5oEyFAHMFDem17YKpLmAj2pWqYD
         FkiJyRt9E/QxldWGqnEM/P8bSZwZ/0tCMpiWDaDwvfU3FbgDKmUehMHNTDP3e1/0OfVw
         tIhXwFN4efC9s7lnwihY2DqaIvDsBAvM1FlUZ8FcnwQBNTKZtBM+6WINKeYIdyWztqvB
         PtLotksD+9duq7DEKLbUhA/DykB1zJK1hFWgoerfO61ZBv0PW30bZZHsqt7+1aFSf2Tq
         6uNQ==
X-Gm-Message-State: APjAAAWf4eTY+cT4tHjQudYvnIUzmh6ZG52XKgYWTO8FzvFHaeSc7kFU
        v+iiYaqqOeaA7liI+7Ox4esZnA==
X-Google-Smtp-Source: APXvYqy8YEE7PhfU6kfB6vVMG12QSn14jY2m/pgfxhc5df3Dfge/vtzS0lAN1v8FM3HtzCFu1cbkug==
X-Received: by 2002:adf:b19d:: with SMTP id q29mr5140671wra.211.1582902275442;
        Fri, 28 Feb 2020 07:04:35 -0800 (PST)
Received: from myrica ([2001:171b:c9a8:fbc0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w19sm2377341wmc.22.2020.02.28.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:04:34 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:04:27 +0100
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
Message-ID: <20200228150427.GF2156@myrica>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228144844.GQ31668@ziepe.ca>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > +		/*
> > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > +		 * from list_add_rcu().
> > > > +		 */
> > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > 
> > > A rcu_dereference isn't need here, just a normal derference is fine.
> > 
> > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > which does bond->io_mm under rcu_read_lock())
> 
> I'm surprised the bond->io_mm can change over the lifetime of the
> bond memory..

The normal lifetime of the bond is between device driver calls to bind()
and unbind(). If the mm exits early, though, we clear bond->io_mm. The
bond is then stale but can only be freed when the device driver releases
it with unbind().

> 
> > > > If io_mm->ctx and io_mm->ops are already valid before the
> > > > mmu notifier is published, then we don't need that stuff.
> > > 
> > > So, this trickyness with RCU is not a bad reason to introduce the priv
> > > scheme, maybe explain it in the commit message?
> > 
> > Ok, I've added this to the commit message:
> > 
> >     The IOMMU SVA module, which attaches an mm to multiple devices,
> >     exemplifies this situation. In essence it does:
> > 
> >             mmu_notifier_get()
> >               alloc_notifier()
> >                  A = kzalloc()
> >               /* MMU notifier is published */
> >             A->ctx = ctx;                           // (1)
> >             device->A = A;
> >             list_add_rcu(device, A->devices);       // (2)
> > 
> >     The invalidate notifier, which may start running before A is fully
> >     initialized at (1), does the following:
> > 
> >             io_mm_invalidate(A)
> >               list_for_each_entry_rcu(device, A->devices)
> >                 A = device->A;                      // (3)
> 
> I would drop the work around from the decription, it is enough to say
> that the line below needs to observe (1) after (2) and this is
> trivially achieved by moving (1) to before publishing the notifier so
> the core MM locking can be used.

Ok, will do

Thanks,
Jean
