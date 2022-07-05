Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F9D56649C
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 10:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiGEHvQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 03:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiGEHvP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 03:51:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0C5DF4B;
        Tue,  5 Jul 2022 00:51:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7CBB668AA6; Tue,  5 Jul 2022 09:51:08 +0200 (CEST)
Date:   Tue, 5 Jul 2022 09:51:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Message-ID: <20220705075108.GB17451@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de> <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com> <20220629175906.GU23621@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629175906.GU23621@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 02:59:06PM -0300, Jason Gunthorpe wrote:
> I've tried in the past, this is not a good idea. There is no way to
> handle failures when a VMA is dup'd and if you rely on private_data
> you almost certainly have to alloc here.
> 
> Then there is the issue of making the locking work on invalidation
> which is crazy ugly.
> 
> > I was not a fan of the extra code for this either, but I was given to
> > understand that it was the standard way to collect and cleanup VMAs.
> 
> Christoph you tried tried to clean it once globally, what happened to
> that?

Al pointed out that there are various places that rely on having a
separate file system.  I might be able to go back to it and see
if we could at least do it for some users.

But what also really matters here:  I don't want every user that
wants to be able to mmap a character device to do all this work.
The layering is simply wrong, it needs some character device
based helpers, not be open code everywhere.

In fact I'm not even sure this should be a character device, it seems
to fit it way better with the PCI sysfs hierchacy, just like how we
map MMIO resources, which these are anyway.  And once it is on sysfs
we do have a uniqueue inode and need none of the pseudofs stuff, and
don't need all the glue code in nvme either.
