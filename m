Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3241D011
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347598AbhI2XiR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347606AbhI2XiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:38:09 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1962C061768
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x9so4075901qtv.0
        for <linux-pci@vger.kernel.org>; Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
        b=BPbV7Ye4Bg5a1ZTPc0nR9KOXAhWl4vBzAsDP0t40qxFSH4OCK6/MQKoFgPTEuzSC9v
         9WzoiGlY1hhlhin2gZEWJVK42YbLrmi7f51aphr87IllDIDa/mW2TlwOq98Zvj0JRk6r
         inxpNiGI/a0tzZNBGtrfuGtkApxUXeOUvY5k07EjRTxe3FM8zYJRfjjEr2wiowyupIsP
         pguKaqLo4Vxp8H1+LxCZCv8O7UiZItzZkw/1xqVdmL+zc9QUl9vc75MtsgPZmJ4AEECN
         dBdxRWVA8aWYCV8FKdHpO9CE7a3VgpFt7E/hUggJ2cfyrdgPqy3taLCfKIMAeO9CnW6s
         e4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p44CKw5NqI0dRYxuOA5K9AcDSEZdsWaIBA8jXRcCw5I=;
        b=hbjr2ao5GBgfoGEFBi1JBpa22r7lTB+AIbO/YL8i23VVi6yDQTAFY2zjEbBb9b7jll
         MwTZb/b9nx+DcFutCCvg4K0xKMixwWTYjIVheiXA/6cJPRhFs2f0TaCIttdYeeQtweS/
         EPh4NNfVvPmOAZAl8qD7kxiFy7NMNyVXKfnbznijwemKFzniG3dp41gBYookpZTwwxYs
         y9TkrfOShPqIN96Wa9Mv3say4cXgplf1xZ1ez88D67Vjy4rAP7m1IBU2A1fNP3n0s1Ua
         F0Ycvxbar+1vhUbcjo+7/O3io5xU+QJ9LtAvoCsDYznnJK6W3lk6IG4D6UBzbL2jItkF
         Zzqw==
X-Gm-Message-State: AOAM531waAMIz+e3I6mtczKiDYau2ozjUtb7a43NlGUsu6lJkKTxr6wu
        QyhsgOSHNjP91THlt7xNe/HIAw==
X-Google-Smtp-Source: ABdhPJyCMb0x8UTP251JMzz7qx/fZLPDIyTJit8sJRFPeoPnTFgHskOtgm8FIWQl2/TGWg7M25xovg==
X-Received: by 2002:a05:622a:492:: with SMTP id p18mr3159519qtx.282.1632958586146;
        Wed, 29 Sep 2021 16:36:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id f5sm706662qtp.44.2021.09.29.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 16:36:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVj7g-007iwP-Pe; Wed, 29 Sep 2021 20:36:24 -0300
Date:   Wed, 29 Sep 2021 20:36:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <20210929233624.GG3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
 <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
 <20210929232147.GD3544071@ziepe.ca>
 <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f56919-03ee-8326-10ee-8fbd9078b8e0@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 05:28:38PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2021-09-29 5:21 p.m., Jason Gunthorpe wrote:
> > On Wed, Sep 29, 2021 at 03:50:02PM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> >>> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
> >>>> Hi,
> >>>>
> >>>> This patchset continues my work to add userspace P2PDMA access using
> >>>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
> >>>> patches in this series, but the early P2PDMA cleanup and map_sg error
> >>>> changes from that series have been merged into v5.15-rc1. To address
> >>>> concerns that that series did not add any new functionality, I've added
> >>>> back the userspcae functionality from the original RFC[2] (but improved
> >>>> based on the original feedback).
> >>>
> >>> I really think this is the best series yet, it really looks nice
> >>> overall. I know the sg flag was a bit of a debate at the start, but it
> >>> serves an undeniable purpose and the resulting standard DMA APIs 'just
> >>> working' is really clean.
> >>
> >> Actually, so far, nobody has said anything negative about using the SG flag.
> >>
> >>> There is more possible here, we could also pass the new GUP flag in the
> >>> ib_umem code..
> >>
> >> Yes, that would be very useful.
> > 
> > You might actually prefer to do that then the bio changes to get the
> > infrastructur merged as it seems less "core"
> 
> I'm a little bit more concerned about my patch set growing too large.
> It's already at 20 patches and I think I'll need to add a couple more
> based on the feedback you've already provided. So I'm leaning toward
> pushing more functionality as future work.

I mean you could postpone the three block related patches and use a
single ib_umem patch instead as the consumer.

Jason
