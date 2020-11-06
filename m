Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF242A9E09
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 20:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgKFTa3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 14:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFTa3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 14:30:29 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6896EC0613D2
        for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2020 11:30:27 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so2142648qkb.7
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 11:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
        b=iJjd0FsgKSz4UMVJ0yEYuTXP+TTkCpe11X1VygTFEfMhBu4zVCI1R/v6juANR2qB4Q
         5Bels1w2oZzLmDsNDoThRLoK7kc/zdpwPO4UT6x6EAkceI8g/JOjAG91xGYl7kSFCQ/W
         ZbgarmDUY3PKv06eSLmj2WHCkLP1NnOHCZkgrx7CXQDuCJ/z7qt+/GjYjmsDayhhFmyK
         CViF4N4YOhwIP8BSr0EwEqNCdu9hb5mbPEEbp3iUTLeV3XnYywXW188JOM3kSYxEOLV5
         mfupyKsZCd/zGG/BUy47UXOrZMvD0veRq8OcWLdma8c/DrK5Km76/lwmXa36HDCDsiN4
         sXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFAruLUORQHUqfhAcqrK3kHFrju7FmZIpz+3LtddQik=;
        b=FL8k9govWZgmVbcYTnyEW+SA8W4cyKsXMwdN9IHubxjz+a5LKnnyDw1CVpyAE5jD3B
         lIvFZN2bi8ujUXwjgtAITI/6PVEveWus997dtsGpbCBMbg1o0omASOBVuL38RR81lYdW
         vyp3WkogN0TB5WAfx2G6ZLbIHwXKMcfUIO9GP7r1xfPBKhFeEzLtMXygKArBU7eTN9el
         LXrVRkKcSa8aycjoekG/b7NjXUjNlzD0Xk83HWIIAD5+zQP7dZAw5JDLxm5vRhk0j4j7
         H2cixXcCFWMBCstlLqpiViu0AHSzJ8gk3801Y3SEMdbOwspAIqF866jTA1sfAz/9Q92q
         RHMw==
X-Gm-Message-State: AOAM531gJCN47Z9zHS83OqkJN3r0HIcKKMmPj7G/qMPi2CCf9m3yZOws
        GZBu1aqmSs/GZXMJPHkigRS2tQ==
X-Google-Smtp-Source: ABdhPJze2F/Rq9sRVVe7Xk43RUxz3sel2lY1t652tRL/srA9lFIVY1sT0rqjvYUmBSCT+htfHCsU0Q==
X-Received: by 2002:a37:e40b:: with SMTP id y11mr3193612qkf.29.1604691026426;
        Fri, 06 Nov 2020 11:30:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id s2sm1115967qtw.44.2020.11.06.11.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:30:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb7RI-0011Hr-SE; Fri, 06 Nov 2020 15:30:24 -0400
Date:   Fri, 6 Nov 2020 15:30:24 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20201106193024.GW36674@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 11:20:05AM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 11:09 a.m., Jason Gunthorpe wrote:
> >> Ah, hmm, yes. I guess the pages have to be hooked and returned to the
> >> genalloc through free_devmap_managed_page(). 
> > 
> > That sounds about right, but in this case it doesn't need the VMA
> > operations.
> > 
> >> Seems like it might be doable... but it will complicate things for
> >> users that don't want to use the genpool (though no such users exist
> >> upstream).
> > 
> > I would like to use this stuff in RDMA pretty much immediately and the
> > genpool is harmful for those cases, so please don't make decisions
> > that are tying thing to genpool
> 
> I certainly can't make decisions for code that isn't currently
> upstream.

The rdma drivers are all upstream, what are you thinking about?

> Ultimately, if you aren't using the genpool you will have to implement
> your own mmap operation that somehow allocates the pages and your own
> page_free hook. 

Sure, the mlx5 driver already has a specialized alloctor for it's BAR
pages.

> I also don't expect this to be going upstream in the near term so don't
> get too excited about using it.

I don't know, it is actually not that horrible, the GUP and IOMMU
related changes are simpler than I expected

Jason
