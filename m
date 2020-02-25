Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AAC16C352
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 15:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgBYOIQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 09:08:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42650 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbgBYOIQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 09:08:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id o28so11971683qkj.9
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2020 06:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rt78zreyzIjHr6yoxlPIHQMecYqp6DqMRSSz9rYV7h8=;
        b=Isrj4uisk1xkziFhawt/8rlAzaSUqp8STgmAQtTr204aEqpvtn33NNz3uBRGlTILtq
         mpyWpAoD6uNduHiL7HXHOhB8Qp4ymOGS5Sd+60cEBCq3seKkCyTFJierH2ip6ln3uFci
         ZA+aKPd1I1h+Bh7pYxiUdietKO7JVJzBXIz4XxcSE7+5Dfq2KFPATR8B2FbQa3Sb1OlF
         nlQLPzC3RedPDaZvQ+JqD/+8di3hj2TnyEdtdmjyjKXPSFHPmttr85IhBJwlgllvLlB2
         T3nZ6tG0sC/VDVBGYuQXY8FZ2FoIiQqFOAwhEGveqrKT84L0zsl1StN0KLacxl6FiNWQ
         1dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rt78zreyzIjHr6yoxlPIHQMecYqp6DqMRSSz9rYV7h8=;
        b=i4HxnmMZJnQKT8X3t28FceaZOY707rJBspoSzSZXex7ffTwCvc1vgzYdaY14HgmWS0
         pEIofoOTC9Wvk5RLctQqfUCoqwLjt9d7WN+4k88rK4gBZcnIZVEFqzsJ0Stn5TQoyCcU
         Qs0X+uJtRq5Njr+fQQZhx2M0dCqcxo3Qo+FUDo9FGoVlbI9FW025HIMabXn/zGtGeoUw
         Fa7YzyeHsX30k45S7S2ERnRmDKuloCMlRXDNniHC5bYUOpXjz9E+ZmXS1no8VRnMswd3
         2Tse2WIWUl+q/wlgF04e5UP6eNU01pGShkBgsCSwPycHY6Zh/2dCvux3QsnHztteJGug
         uF5g==
X-Gm-Message-State: APjAAAXAsQgzmDd2uUbKNeUDvXl0UECUG2QcMBChQd96chuHRqDAJphN
        LJba5fiL7kCDbuEWrIdsTtwxAA==
X-Google-Smtp-Source: APXvYqzoKfzZQNX2DE6QpwzMJc/kJ1wZx8yapE9f3rFQlORpnW5yrsgC7Cf2AglgqNASds83iDpsag==
X-Received: by 2002:ae9:e711:: with SMTP id m17mr13060092qka.393.1582639695367;
        Tue, 25 Feb 2020 06:08:15 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x14sm4057470qkf.99.2020.02.25.06.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Feb 2020 06:08:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j6asg-0000Vc-2U; Tue, 25 Feb 2020 10:08:14 -0400
Date:   Tue, 25 Feb 2020 10:08:14 -0400
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
Message-ID: <20200225140814.GW31668@ziepe.ca>
References: <20200224182401.353359-1-jean-philippe@linaro.org>
 <20200224182401.353359-2-jean-philippe@linaro.org>
 <20200224190056.GT31668@ziepe.ca>
 <20200225092439.GB375953@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225092439.GB375953@myrica>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 25, 2020 at 10:24:39AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Feb 24, 2020 at 03:00:56PM -0400, Jason Gunthorpe wrote:
> > On Mon, Feb 24, 2020 at 07:23:36PM +0100, Jean-Philippe Brucker wrote:
> > > The new allocation scheme introduced by 2c7933f53f6b ("mm/mmu_notifiers:
> > > add a get/put scheme for the registration") provides a convenient way
> > > for users to attach notifier data to an mm. However, it would be even
> > > better to create this notifier data atomically.
> > > 
> > > Since the alloc_notifier() callback only takes an mm argument at the
> > > moment, some users have to perform the allocation in two times.
> > > alloc_notifier() initially creates an incomplete structure, which is
> > > then finalized using more context once mmu_notifier_get() returns. This
> > > second step requires carrying an initialization lock in the notifier
> > > data and playing dirty tricks to order memory accesses against live
> > > invalidation.
> > 
> > This was the intended pattern. Tthere shouldn't be an real issue as
> > there shouldn't be any data on which to invalidate, ie the later patch
> > does:
> > 
> > +       list_for_each_entry_rcu(bond, &io_mm->devices, mm_head)
> > 
> > And that list is empty post-allocation, so no 'dirty tricks' required.
> 
> Before introducing this patch I had the following code:
> 
> +	list_for_each_entry_rcu(bond, &io_mm->devices, mm_head) {
> +		/*
> +		 * To ensure that we observe the initialization of io_mm fields
> +		 * by io_mm_finalize() before the registration of this bond to
> +		 * the list by io_mm_attach(), introduce an address dependency
> +		 * between bond and io_mm. It pairs with the smp_store_release()
> +		 * from list_add_rcu().
> +		 */
> +		io_mm = rcu_dereference(bond->io_mm);

A rcu_dereference isn't need here, just a normal derference is fine.

> +		io_mm->ops->invalidate(bond->sva.dev, io_mm->pasid, io_mm->ctx,
> +				       start, end - start);
> +	}
> 
> (1) io_mm_get() would obtain an empty io_mm from iommu_notifier_get().
> (2) then io_mm_finalize() would initialize io_mm->ops, io_mm->ctx, etc.
> (3) finally io_mm_attach() would add the bond to io_mm->devices.
> 
> Since the above code can run before (2) it needs to observe valid
> io_mm->ctx, io_mm->ops initialized by (2) after obtaining the bond
> initialized by (3). Which I believe requires the address dependency from
> the rcu_dereference() above or some stronger barrier to pair with the
> list_add_rcu().

The list_for_each_entry_rcu() is an acquire that already pairs with
the release in list_add_rcu(), all you need is a data dependency chain
starting on bond to be correct on ordering.

But this is super tricky :\

> If io_mm->ctx and io_mm->ops are already valid before the
> mmu notifier is published, then we don't need that stuff.

So, this trickyness with RCU is not a bad reason to introduce the priv
scheme, maybe explain it in the commit message?

Jason
