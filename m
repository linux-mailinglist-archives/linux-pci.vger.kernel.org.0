Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9236CD37
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 22:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhD0Utx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 16:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239045AbhD0Uts (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 16:49:48 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E58AC06175F
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i24so11991635edy.8
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
        b=qEfkSh7MGE8PVxlqCWGjjSgsiEnsnVBnvrjRNNxqQEj5HU0k4aWay+siPtJdTOW5Xf
         zVOpXzCXY0HakOzD/zAOFn8Rvsn7R9MMypGaIbyqQ5mvyZd62oAMQzRju3r4ZZ6Dbh4Z
         PGwXTw7U7ke5bt4PusVhU/FjOe6PO8GyPwyQEOdOvEKEQO2whSN6EREZEHU4BumJ0tUN
         wYRqkBp8E0mktosAXmG+bLKjKBN+4yGMkELK1CaFKSqtKceOXNV5kbTOZ4Y9znDBNz7U
         OaKb8R39/BDxfS854M5MpP4bM8rl5sKWIpgUHtqb2i2Vtr8Gvv6JoSyU7i78Aj09c75j
         QnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
        b=ta/Gau+LkPe4ND2Y5URxUm7Zjk4jqfYntOY3fRDzsg4El2iX1eSM+xGdoPIsmMgnyV
         rJel0T/PVUetztLaSViCf+A3ut5Yo0K6/Ey2xTwoUzZht07m1fOafpO0dws/Xus4jlAS
         7ma1Oe8HNzgIM9Flqij601UvXkmxps54fg7yIkmRR9wqamDjZNUfcgVR9BFWeaP0Yg7O
         0oK7R0oQeihAlLXAw7WxQ+ABZBlrrWof8uduhaN5McEnZRcVxMEXbTy+Eh1eHIQ4xedd
         zTDyBnx7U+B/UNWCbA2GED4U6zcslJmjui7m0nXjKje+AIrh9w0dAQvHIguw/1eISW4K
         ccBQ==
X-Gm-Message-State: AOAM530X5h14Hiy8BNiQ+CAIyp1rR11eg50PWAbKfXrqmb3z2dhgPi9K
        CSrMMgc/UJ0V4JJUEJWBE+JM6/CRLhAQHhVuuiHPVA==
X-Google-Smtp-Source: ABdhPJyFMNunA2bOW/HTfw7I2Fxc07FXNBNlKOc55ZJx0surGmu20mPs7uTrsxToUeLXW66T1s7Gq8IAg4lX/ItiTU4=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr6553464edw.97.1619556543314;
 Tue, 27 Apr 2021 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210408170123.8788-1-logang@deltatee.com> <20210427192838.GP2047089@ziepe.ca>
 <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
In-Reply-To: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 27 Apr 2021 13:48:58 -0700
Message-ID: <CAPcyv4h-YVLHTCnXhTy5DVbhXndWZnhcKerDdS=+wDjWzZc4Fg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
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
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 27, 2021 at 1:22 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to to add P2PDMA support to the common
> >> dma map operations. This allows for creating SGLs that have both P2PDMA
> >> and regular pages which is a necessary step to allowing P2PDMA pages in
> >> userspace.
> >>
> >> The earlier RFC[1] generated a lot of great feedback and I heard no show
> >> stopping objections. Thus, I've incorporated all the feedback and have
> >> decided to post this as a proper patch series with hopes of eventually
> >> getting it in mainline.
> >>
> >> I'm happy to do a few more passes if anyone has any further feedback
> >> or better ideas.
> >
> > For the user of the DMA API the idea seems reasonable enough, the next
> > steps to integrate with pin_user_pages() seem fairly straightfoward
> > too
> >
> > Was there no feedback on this at all?
> >
>
> oops, I meant to review this a lot sooner, because this whole p2pdma thing is
> actually very interesting and important...somehow it slipped but I'll take
> a look now.

Still in my queue as well behind Joao's memmap consolidation series,
and a recent copy_mc_to_iter() fix series from Al.
