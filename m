Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B119D56081C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 19:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbiF2R7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 13:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiF2R7K (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 13:59:10 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33F2AD
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 10:59:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z1so8695486qvp.9
        for <linux-pci@vger.kernel.org>; Wed, 29 Jun 2022 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
        b=SKmcghAf6nlxb3TYM9q+L2K6WvoAOg3jhiALBKso44zP0sXfB8bfiUedLcgKzgwJgh
         iTJCket4ICkaBkiO0QMT6a7oZweniTqMyqfh5UKIWBSdtteoys0WU0gLpwmQxcuZ4T0C
         B5EZV3F+pSyyuE/TubvDD1bjbB6DXWKJyou3V2eDANW0FMx1qb5IymBGqRBGbaBO/qpz
         ziWT+UQffo2LDKQOaJhYTyVo3/P9yrGTwX9E3INhoqRXiDqc6Jau79+OQONuVBZZne7a
         MzNQ3dTgqHtk/dbWQmfNzsZcoGEiW6sxYQ0kC+3zRe5EegJZ5dxZXRpFz6xNN0CByfx0
         8ESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ngWx43aEx+7T9A14R2LGOmGQG6CiD1NPE7ELlQTW2Yo=;
        b=zbBP5lahgDb5cq0i62gI0sl/EH9CBbnGjGyFdk8mEE2gKUeubVwE4wxglaeT3HB4jA
         8zpWd4Lp7YPm65keQdd43yuEIxjKJHO0rkCAZ73mPYsiZR6QYEwp9w6cDc7k7eVs0f4u
         iyTwpBZUS6g9GsVPk7faL1Nml/eO4Iv/XyHRvKJ4UKVnaAOlQSh16+iY88ACS+p1sMLG
         4oNV47vXnHcnvxNYGB11fJ7UrPw1AyQqmtFYGncsEcML5hfYmQpnr/0ESJXkbvrWL05L
         OwiqbbgD4D/mfpCsGisWs/Wp9ZGcOEKkI1FjfHboMd3YTvYByoLMZ6xcVhzH8iRsoGig
         iVhQ==
X-Gm-Message-State: AJIora/A9a1zaWGQQvzOQpwZsUWsdgRmdnuEPYiIZXwqZqOnmzUh1LtK
        JAzRisobsljefmSbxy4Xz4MQeA==
X-Google-Smtp-Source: AGRyM1tbrZ7P9r+hmIBmAW2EDXMkZbkavnNkEyNTe14M5A9CnmgPVypEPOrPgPFspFUz9zUokVYXKQ==
X-Received: by 2002:a05:6214:ac2:b0:46e:7e2a:ada with SMTP id g2-20020a0562140ac200b0046e7e2a0adamr8831887qvi.81.1656525547889;
        Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c13-20020a05620a164d00b006a6a4b43c01sm12832373qko.38.2022.06.29.10.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:59:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1o6bxy-003bBJ-Q7; Wed, 29 Jun 2022 14:59:06 -0300
Date:   Wed, 29 Jun 2022 14:59:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
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
Message-ID: <20220629175906.GU23621@ziepe.ca>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com>
 <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 10:00:09AM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-06-29 00:48, Christoph Hellwig wrote:
> > On Wed, Jun 15, 2022 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> >> A pseudo mount is used to allocate an inode for each PCI device. The
> >> inode's address_space is used in the file doing the mmap so that all
> >> VMAs are collected and can be unmapped if the PCI device is unbound.
> >> After unmapping, the VMAs are iterated through and their pages are
> >> put so the device can continue to be unbound. An active flag is used
> >> to signal to VMAs not to allocate any further P2P memory once the
> >> removal process starts. The flag is synchronized with concurrent
> >> access with an RCU lock.
> > 
> > Can't we come up with a way of doing this without all the pseudo-fs
> > garbagage?  I really hate all the overhead for that in the next
> > nvme patch as well.
> 
> I assume you still want to be able to unmap the VMAs on unbind and not
> just hang?
> 
> I'll see if I can come up with something to do the a similar thing using
> vm_private data or some such.

I've tried in the past, this is not a good idea. There is no way to
handle failures when a VMA is dup'd and if you rely on private_data
you almost certainly have to alloc here.

Then there is the issue of making the locking work on invalidation
which is crazy ugly.

> I was not a fan of the extra code for this either, but I was given to
> understand that it was the standard way to collect and cleanup VMAs.

Christoph you tried tried to clean it once globally, what happened to
that?

All that is needed here is a way to get a unique inode for the PCI
memory.

Jason
