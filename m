Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA7741F29F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhJAREH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 13:04:07 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60568 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhJAREG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 13:04:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=bYDtmI7g7itWVy9sZ7LZkZ5dph2F7VuLw3CuGucti2U=; b=s+nPOYtyQCnFiiolUwnh/1xJPy
        jCHFyQWGtLHmjRe53BoYJrs5hmHckB4NFM/qIqfZZZO5lTiS7WvK2SdMyNLJFlg/bu1oE74AOhejB
        d8wOCUasBDys2glJalldfVv6TUiPSaUxZQRWbLKjUapjMR9RAWlxkjwxG02a9pFpI4Gm2d9rkTZvo
        MUIcjHvQyuIvcitOyZoy7CF5UB1SgjTDqFkjiJJQCp52iC4QOlz1FBbMJh3IJ15gS9P3+8jQvA8Pp
        ZwM053wanqfZc2CKQodO+KbEyKtRkTlqcOjGOp7F5HI4U+2r/Iy2q0dU7FPTXU8n5UDQG6zzytd/7
        FnJI3MUg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mWLv1-0002AH-Aj; Fri, 01 Oct 2021 11:01:56 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca> <20211001134856.GN3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
Date:   Fri, 1 Oct 2021 11:01:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211001134856.GN3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, dan.j.williams@intel.com, hch@lst.de, Felix.Kuehling@amd.com, apopple@nvidia.com, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NATURALLY,NICE_REPLY_A
        autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-10-01 7:48 a.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 09:36:52PM -0300, Jason Gunthorpe wrote:
> 
>> Why would DAX want to do this in the first place?? This means the
>> address space zap is much more important that just speeding up
>> destruction, it is essential for correctness since the PTEs are not
>> holding refcounts naturally...
> 
> It is not really for this series to fix, but I think the whole thing
> is probably racy once you start allowing pte_special pages to be
> accessed by GUP.
> 
> If we look at unmapping the PTE relative to GUP fast the important
> sequence is how the TLB flushing doesn't decrement the page refcount
> until after it knows any concurrent GUP fast is completed. This is
> arch specific, eg it could be done async through a call_rcu handler.
> 
> This ensures that pages can't cross back into the free pool and be
> reallocated until we know for certain that nobody is walking the PTEs
> and could potentially take an additional reference on it. The scheme
> cannot rely on the page refcount being 0 because oce it goes into the
> free pool it could be immeidately reallocated back to a non-zero
> refcount.
> 
> A DAX user that simply does an address space invalidation doesn't
> sequence itself with any of this mechanism. So we can race with a
> thread doing GUP fast and another thread re-cycling the page into
> another use - creating a leakage of the page from one security context
> to another.
> 
> This seems to be made worse for the pgmap stuff due to the wonky
> refcount usage - at least if the refcount had dropped to zero gup fast
> would be blocked for a time, but even that doesn't happen.
> 
> In short, I think using pg special for anything that can be returned
> by gup fast (and maybe even gup!) is racy/wrong. We must have the
> normal refcount mechanism work for correctness of the recycling flow.

I'm not quite following all of this. I'm not entirely sure how fs/dax
works in this regard, but for device-dax (and similarly p2pdma) it
doesn't seem as bad as you say.

In device-dax, the refcount is only used to prevent the device, and
therefore the pages, from going away on device unbind. Pages cannot be
recycled, as you say, as they are mapped linearly within the device. The
address space invalidation is done only when the device is unbound.
Before the invalidation, an active flag is cleared to ensure no new
mappings can be created while the unmap is proceeding.
unmap_mapping_range() should sequence itself with the TLB flush and
GUP-fast using the same mechanism it does for regular pages. As far as I
can see, by the time unmap_mapping_range() returns, we should be
confident that there are no pages left in any mapping (seeing no new
pages could be added since before the call). Then before finishing the
unbind, device-dax decrements the refcount of all pages and then waits
for the refcount of all pages to go to zero. Thus, any pages that
successfully were got with GUP, during or before unmap_mapping_range
should hold a reference and once all those references are returned,
unbind can finish.

P2PDMA follows this pattern, except pages are not mapped linearly and
are returned to the genalloc when their refcount falls to 1. This only
happens after a VMA is closed which should imply the PTEs have already
been unlinked from the pages. And the same situation occurs on unbind
with a flag preventing new mappings from being created before
unmap_mapping_range(), etc.

Not to say that all this couldn't use a big conceptual cleanup. A
similar question exists with the single find_special_page() user
(xen/gntdev) and it's definitely not clear what the differences are
between the find_special_page() and vmf_insert_mixed() techniques and
when one should be used over the other. Or could they both be merged to
use the same technique?

Logan
