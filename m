Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012062A9E4F
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 20:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgKFTxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 14:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbgKFTxo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 14:53:44 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DA7C0613D2
        for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2020 11:53:43 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so1624477qtx.3
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 11:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
        b=FudZRGzAxEFk9lGKJUSPzsyZKArhHRwyzmRlvf+GFC+ATQPjzcBbVOeDLLB7moiVUf
         ObxxpnS/zZJpTm82iWz+fyi9jGs/I9YeNae0ROJk7xm4ksGu3vErOwXPC3998pjQlR5p
         4czYVsKEbRHoddebJV0noju3HQZREanU58l+vhPFj17Ta8rGMwytFISX8XsKNrHR+BX8
         lRJNDwJeHT2t31rpqbAdGGp0+akczI7HoAc6Ksjc1BT3ksZah6pY+y3OqCayYTmpzL+D
         Vcc6mEGa7A07b9rAWqQo7QjWrLXkk8WsSTWPLKnX0XjNAe7EuqN+sDQBd5I1lutR9Gx3
         kmvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sU45ASLE3qTNEeDnzXy0mWmjw/B5hdl1YB3C1dRGzkI=;
        b=m2awEoAPm5jQAz3M17v47SuBOAE3kPoJG0cNa/LWzkWuXGDTQBvdtlhm7mrLlOKYOs
         ur0mtG9K11GXe7VQomdefNzuGdQiASttx9gr4UE9lPis6+LusMMmPhbhg8qcIdtOUr34
         +ucSHwSbznJ09p5GIhx+WCZNWl1uLw2PF+5kUs4rA9k/y0to09mT3hwpUCAct/iJT4UD
         ljeeHXsRc+Mt6c37e//41Pt1i+dHlKnfGBFV9MHep8hrluyjQYK7cy4B52MNxGsoSybr
         ihZn/2yVmKTCnYck2LungWWT0RBV5dHHP47O18J0X5bFBBrdZvJf0QBv7pwqqB/aiE2f
         34Ag==
X-Gm-Message-State: AOAM533LowWhwKfFVX4kb/9bJ8qij/JGtG9U66/OxDNZ7AwrSesJVtOx
        KtVDuu8L0etf4TotbMYbUbFoSw==
X-Google-Smtp-Source: ABdhPJwcMytaU5RLKIBqp2abyuS1iVFiLHOqHqGF/QD5vN1zrtKnu5OM6Laul9BgJOP5lCmGBjWjKA==
X-Received: by 2002:aed:32c7:: with SMTP id z65mr3146052qtd.266.1604692422443;
        Fri, 06 Nov 2020 11:53:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r41sm1239041qtj.23.2020.11.06.11.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 11:53:41 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kb7np-0011j7-5m; Fri, 06 Nov 2020 15:53:41 -0400
Date:   Fri, 6 Nov 2020 15:53:41 -0400
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
Message-ID: <20201106195341.GA244516@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-15-logang@deltatee.com>
 <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 12:44:59PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 2020-11-06 12:30 p.m., Jason Gunthorpe wrote:
> >> I certainly can't make decisions for code that isn't currently
> >> upstream.
> > 
> > The rdma drivers are all upstream, what are you thinking about?
> 
> Really? I feel like you should know what I mean here...
> 
> I mean upstream code that actually uses the APIs that I'd have to
> introduce. I can't say here's an API feature that no code uses but the
> already upstream rdma driver might use eventually. It's fairly easy to
> send patches that make the necessary changes when someone adds a use of
> those changes inside the rdma code.

Sure, but that doesn't mean you have to actively design things to be
unusable beyond this narrow case. The RDMA drivers are all there, all
upstream, if this work is accepted then the changes to insert P2P
pages into their existing mmap flows is a reasonable usecase to
consider at this point when building core code APIs.

You shouldn't add dead code, but at least have a design in mind for
what it needs to look like and some allowance.

> >> Ultimately, if you aren't using the genpool you will have to implement
> >> your own mmap operation that somehow allocates the pages and your own
> >> page_free hook. 
> > 
> > Sure, the mlx5 driver already has a specialized alloctor for it's BAR
> > pages.
> 
> So it *might* make sense to carve out a common helper to setup a VMA for
> P2PDMA to do the vm_flags check and set VM_MIXEDMAP... but besides that,
> there's no code that would be common to the two cases.

I think the whole insertion of P2PDMA pages into a VMA should be
similar to io_remap_pfn() so all the VM flags, pgprot_decrypted and
other subtle details are all in one place. (also it needs a
pgprot_decrypted before doing vmf_insert, I just learned that this
month)

> >> I also don't expect this to be going upstream in the near term so don't
> >> get too excited about using it.
> > 
> > I don't know, it is actually not that horrible, the GUP and IOMMU
> > related changes are simpler than I expected
> 
> I think the deal breaker is the SGL hack and the fact that there are
> important IOMMU implementations that won't have support.

Yes, that is pretty hacky, maybe someone will have a better idea

Jason
