Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FFA41EEDF
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 15:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJANuo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhJANun (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 09:50:43 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E45C061775
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 06:48:59 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id x12so9123003qkf.9
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 06:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
        b=i2nZSJalGl2HFR2lljteQga9LLzznj1VY4sKfMFrOuI5TPw+9fxa9Y7VF6ORCDu6gf
         s1VZcbmu8prmAySSW0muDV9sPFy+ocsOAHMu7czDjdTka8/r9gDirvuLv+DjNcMP+yu2
         2vpgG0jpIzFJO3o2EESr3Knc9sAVcu/3zrGpfyryk0rXsa3CM7UVEgJZI2lyiRkkfNpM
         06X0/la9ZF1/JOw1nIH1hT6QVKTk7TJuv33hiHw5ih9p7MWcfmzNHEd0oxDuij3diKPb
         ruwnbMTM1vlfPcAVocSCOhTaVtV1FJ3tIhW47hPjbC6RUYlSTDx8/p4BvGKL4lQu/579
         YBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LG5nuVM12UKCUvMUz/H7oZ+JnPtb7xeOrg+cdikjdUw=;
        b=y0vXFYfsA8h8rOGULDtO2FHNN26H/svlgYKv5aWPYCWPcSM5yktIUesFYm6YKg2d+E
         HL5+8LZOaBcyPvdXXHCmhF1BYaa1ERaqf9yp64JKNoD5zo7GO+xX43iHwu3Px9TjD2ZT
         bS3CHIC/Z9b8IHyin8NFBGYTkIEC4LMnmqKEb4Qz2ayXv3Om3zu3BmMnbw3Oyu8bwrGa
         DHMfrdEokt7y1p/TiYZZxcww7OAXD/RzLTDCsGMIjk53WGYDHosNDkstyVmC4dQHzOc9
         nTNGoU7dszgiOu9EpRf198kZdji2KbyuxmHKvz5rDKLM+6UnxQfaaP6oV6//9gKcU1g2
         iwlw==
X-Gm-Message-State: AOAM531bqGLsWJhEwiklPnBjQ3gZ2ek03Fn2RRAPjF7SbMW6KtFGsJ1Z
        keFn6FDomKwp1D1K2uuILHXQvQ==
X-Google-Smtp-Source: ABdhPJxAWiRAix1MOnP+fusB3RWFs4aefuUjIqiau0+pjC7MwPUEHTq7EjNfCISJpSPUQC5qQMYTaw==
X-Received: by 2002:a37:65d6:: with SMTP id z205mr9907719qkb.522.1633096138367;
        Fri, 01 Oct 2021 06:48:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u19sm3747206qtx.40.2021.10.01.06.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 06:48:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWIuG-008R2P-Oj; Fri, 01 Oct 2021 10:48:56 -0300
Date:   Fri, 1 Oct 2021 10:48:56 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001134856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210930003652.GH3544071@ziepe.ca>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 09:36:52PM -0300, Jason Gunthorpe wrote:

> Why would DAX want to do this in the first place?? This means the
> address space zap is much more important that just speeding up
> destruction, it is essential for correctness since the PTEs are not
> holding refcounts naturally...

It is not really for this series to fix, but I think the whole thing
is probably racy once you start allowing pte_special pages to be
accessed by GUP.

If we look at unmapping the PTE relative to GUP fast the important
sequence is how the TLB flushing doesn't decrement the page refcount
until after it knows any concurrent GUP fast is completed. This is
arch specific, eg it could be done async through a call_rcu handler.

This ensures that pages can't cross back into the free pool and be
reallocated until we know for certain that nobody is walking the PTEs
and could potentially take an additional reference on it. The scheme
cannot rely on the page refcount being 0 because oce it goes into the
free pool it could be immeidately reallocated back to a non-zero
refcount.

A DAX user that simply does an address space invalidation doesn't
sequence itself with any of this mechanism. So we can race with a
thread doing GUP fast and another thread re-cycling the page into
another use - creating a leakage of the page from one security context
to another.

This seems to be made worse for the pgmap stuff due to the wonky
refcount usage - at least if the refcount had dropped to zero gup fast
would be blocked for a time, but even that doesn't happen.

In short, I think using pg special for anything that can be returned
by gup fast (and maybe even gup!) is racy/wrong. We must have the
normal refcount mechanism work for correctness of the recycling flow.

I don't know why DAX did this, I think we should be talking about
udoing it all of it, not just the wonky refcounting Alistair and Felix
are working on, but also the use of MIXEDMAP and pte special for
struct page backed memory.

Jason
