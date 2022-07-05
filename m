Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2421567456
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 18:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiGEQaX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiGEQaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 12:30:02 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325981CFC8
        for <linux-pci@vger.kernel.org>; Tue,  5 Jul 2022 09:30:01 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l14so14439506qtx.2
        for <linux-pci@vger.kernel.org>; Tue, 05 Jul 2022 09:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=ARfWpr8plwJhNlfMsfgbkLKFpSjayQPH+TVLj9njVh+9ZVwwYS0Q5lpx3QESUlwiJ0
         Xau0D8DTEtlBLA2TKJjGb0eWyuHzYJSySzH16w8i60Ucpq6lkPkx/9MUbSA7H8PkF9mf
         vy2eLsJPe5CP1cJVF8B6Y7AsRY7nQqxYHkWBv4hIekpX2n63jyIHOZts2vGssV+p6X7i
         o5tnF3lXu1HBK0CIU9B+BuQxS3B79T/BqxNUUNBMTSi7dFTn3cejUhBmCkHwZYPAldDy
         CzT6wuFA6Z8An5ETNanvoj5+zinJwVg3guVjtkzMtWjvDNeS+j8gPF7lh16xjKsVoTSd
         rVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sChclduKae/84cDz0BrZ+MP0tp+PTlAr9CZeDjfj13Q=;
        b=1ujjbTucs/RCiWeFVTQGhLff2iQMW9hvBalagdNBgnSOV66hG7wru8zrXtCbtaDa5Q
         G9fT/lLmq3SZHn1LvwyQF3UkK8uoc3pGAr3cDzSKO9rYqXgKC99Aok/r53L7e5ieAZb8
         H9zJtAiBwv7KIJ2MixRbrcO1lpAXXm9YGY0nRTBDnd0sQSYv5AskPgyr1qPpvAMEnBl7
         mWIkLbzKnVCPSVGzCGCuHbzX5ZHLs9qgkdmo8oANW7gJOg6Db+Adu2EI0LjU1hk9c8Qp
         s18Yhyt2l2sx3I7/uopKNJVdRr4DKq0GhMWinePJhmegQQVx4rzuyPly+F4iYJKu2GGe
         0w4w==
X-Gm-Message-State: AJIora9T3skjBh88H5NzDANmfkrd8d3w8dY8alS/QL7KrmFsgbPjdEsE
        bnYk+uFUAaPA4TDtMHWXq+zmJg==
X-Google-Smtp-Source: AGRyM1tPLgF/oa5jp6ch7h66vURUmccxqkvEu70fGN2pQIZRW9uE0+BIJoib0UJtgkigroai62+FZA==
X-Received: by 2002:a05:6214:27cc:b0:470:9aaa:94b5 with SMTP id ge12-20020a05621427cc00b004709aaa94b5mr32033702qvb.129.1657038600343;
        Tue, 05 Jul 2022 09:30:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006b25570d1c2sm11328498qkh.12.2022.07.05.09.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 09:29:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o8lR1-006YYv-9I; Tue, 05 Jul 2022 13:29:59 -0300
Date:   Tue, 5 Jul 2022 13:29:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <20220705162959.GH23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca>
 <20220705161240.GB13721@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705161240.GB13721@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 05, 2022 at 06:12:40PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:51:02AM -0300, Jason Gunthorpe wrote:
> > > In fact I'm not even sure this should be a character device, it seems
> > > to fit it way better with the PCI sysfs hierchacy, just like how we
> > > map MMIO resources, which these are anyway.  And once it is on sysfs
> > > we do have a uniqueue inode and need none of the pseudofs stuff, and
> > > don't need all the glue code in nvme either.
> > 
> > Shouldn't there be an allocator here? It feels a bit weird that the
> > entire CMB is given to a single process, it is a sharable resource,
> > isn't it?
> 
> Making the entire area given by the device to the p2p allocator available
> to user space seems sensible to me.  That is what the current series does,
> and what a sysfs interface would do as well.

That makes openning the mmap exclusive with the in-kernel allocator -
so it means opening the mmap fails if something else is using a P2P
page and once the mmap is open all kernel side P2P allocations will
fail?

Which seems inelegant, I would expect the the mmap operation to
request some pages from the P2P allocator and provide them to
userspace so user and kernel workflows can co-exist using the same
CMB.

Jason
