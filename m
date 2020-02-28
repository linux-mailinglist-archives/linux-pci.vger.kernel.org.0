Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D88173B1E
	for <lists+linux-pci@lfdr.de>; Fri, 28 Feb 2020 16:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgB1PNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Feb 2020 10:13:42 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42606 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgB1PNl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Feb 2020 10:13:41 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so1471310qvb.9
        for <linux-pci@vger.kernel.org>; Fri, 28 Feb 2020 07:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wq8nlNbsnwZz9fji3Cl/zgmv4zDoBKk4NoZF3W2wkDQ=;
        b=Ljgpp5xGPFtER1NGPwiitpNKYovODnCioFFOFLTyn2Ck/JR8HVTOx6j2p+g2nfn+c7
         ZZ4POl/CTaYoux0tyCmDMX6rtKyDdXnlMSGlJzLw9GbBTTzDfneWvjGmL5R0O0CGmHup
         2kp9E5S8Nxk8bHWYOZucZY6zoQaHVHi1zuuqGFV82FSHWkJZ4RoRvoylWAS0Wx4bc8K9
         VTIK4BTuE9ZYLVtjSIRYLN6ZaAkL0DcdWHFg4QbbWrjltc2/+KxfoeQyempXAsF7sI0A
         w3wliYOLVxCpNm799lBmqygk+nsWvEVxFVFJ7Lj2RQ/PkFIeGuOpHh4CgFZttaO2QJlZ
         F0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wq8nlNbsnwZz9fji3Cl/zgmv4zDoBKk4NoZF3W2wkDQ=;
        b=F7IcT5KCguYSURDCZ3caFhCpEytXdE/6JQMVTRhiyucBcEPuxpuBSXQf7bRabAdqYA
         PtWwSy5Fyzvvt8y3je9d1tLn5INhV3zBzdvAL1IlRehC3sSebDowxh/57mWPdtICjY4L
         3Gmckh4T6KhSWRAmvMSraHQx0C35RgP4aFSkpcLlLubLJ6inIPgErnC6bct2XzaHsqok
         hLZMxwjwj8DhzoxUnZZoxZAVUM5oFpafsprfQDl+e3or6L1Z1gWvZPYiWit/X77ilFPk
         Ftp0ytJDdcs1EC9czeklsxPcZLmLDBrVwGKLmkiQImbB8WXomB7U5Q/VEe0cs8QeDogj
         z/0w==
X-Gm-Message-State: APjAAAUPGo2LbFYHkBvGI17y1HcdtJNSC+bRXfWCinfU7hQ+MrZpPrkY
        +36QWpu/BvXo6ykdgv6mqdpXRA==
X-Google-Smtp-Source: APXvYqzNk6wZcWW+lmBBUW/lZq2ZIkoXwN/aWaAwf7XC2b5DqYukekLVZ6CR2bhdZGkTfI1iTFM0Cw==
X-Received: by 2002:a05:6214:a62:: with SMTP id ef2mr3484481qvb.109.1582902820845;
        Fri, 28 Feb 2020 07:13:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id a128sm5296832qkc.44.2020.02.28.07.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Feb 2020 07:13:40 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7hKe-0005qo-0Q; Fri, 28 Feb 2020 11:13:40 -0400
Date:   Fri, 28 Feb 2020 11:13:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
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
Message-ID: <20200228151339.GS31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
 <20200225140814.GW31668@ziepe.ca>
 <20200228143935.GA2156@myrica>
 <20200228144844.GQ31668@ziepe.ca>
 <20200228150427.GF2156@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228150427.GF2156@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 04:04:27PM +0100, Jean-Philippe Brucker wrote:
> On Fri, Feb 28, 2020 at 10:48:44AM -0400, Jason Gunthorpe wrote:
> > On Fri, Feb 28, 2020 at 03:39:35PM +0100, Jean-Philippe Brucker wrote:
> > > > > +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> > > > > +		/*
> > > > > +		 * To ensure that we observe the initialization of io_mm fields
> > > > > +		 * by io_mm_finalize() before the registration of this bond to
> > > > > +		 * the list by io_mm_attach(), introduce an address dependency
> > > > > +		 * between bond and io_mm. It pairs with the smp_store_release()
> > > > > +		 * from list_add_rcu().
> > > > > +		 */
> > > > > +		io_mm = rcu_dereference(bond->io_mm);
> > > > 
> > > > A rcu_dereference isn't need here, just a normal derference is fine.
> > > 
> > > bond->io_mm is annotated with __rcu (for iommu_sva_get_pasid_generic(),
> > > which does bond->io_mm under rcu_read_lock())
> > 
> > I'm surprised the bond->io_mm can change over the lifetime of the
> > bond memory..
> 
> The normal lifetime of the bond is between device driver calls to bind()
> and unbind(). If the mm exits early, though, we clear bond->io_mm. The
> bond is then stale but can only be freed when the device driver releases
> it with unbind().

I usually advocate for simple use of these APIs. The mm_notifier_get()
should happen in bind() and the matching put should happen in the
call_rcu callbcak that does the kfree. Then you can never get a stale
pointer. Don't worry about exit_mmap().

release() is an unusual callback and I see alot of places using it
wrong. The purpose of release is to invalidate_all, that is it.

Also, confusingly release may be called multiple times in some
situations, so it shouldn't disturb anything that might impact a 2nd
call.

Jason
