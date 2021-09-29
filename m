Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7641D028
	for <lists+linux-pci@lfdr.de>; Thu, 30 Sep 2021 01:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347714AbhI2Xvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 19:51:37 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60818 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346489AbhI2Xvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 19:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=CF1glsl0sDpUoLLLlbcLe5Gc4XdktP0X8AUw9yuV+0g=; b=rvxtjSxpHJKvRAjCfIxwxyzLCo
        dRJ/VOphU+DYr/cLIiwms1Pg/YVQDCtjAHmMCtg4knvS9jKPhUP3W9zeT0sdqnnr19BzDAVDwHcJL
        62apJcXTTKU8FDisFW4B9PimKftGde3SQ3trXz6cjnJ/Evi3tlcLZEqDfaxS6gD5YvgZuTfG7y4pX
        oR1EByfJZsQ+MR2/beWAzNsR3w97B0sy/qeoE6eY3ixGA2UuZc4eGCIy14pEdxW+aVGSSXG81FppK
        Xrz2ZHFGtdpweiT0vhas7k+vEPmBvbSrqdraw89wTlivVK/1sYC95Wf2aWqcT52GNBphDrX7tSAFc
        Jo1/zcsg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVjKW-0008TE-PC; Wed, 29 Sep 2021 17:49:41 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
Date:   Wed, 29 Sep 2021 17:49:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929233540.GF3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-29 5:35 p.m., Jason Gunthorpe wrote:
> On Wed, Sep 29, 2021 at 05:27:22PM -0600, Logan Gunthorpe wrote:
> 
>>> finish_fault() should set the pte_devmap - eg by passing the
>>> PFN_DEV|PFN_MAP somehow through the vma->vm_page_prot to mk_pte() or
>>> otherwise signaling do_set_pte() that it should set those PTE bits
>>> when it creates the entry.
>>>
>>> (or there should be a vmf_* helper for this special case, but using
>>> the vmf->page seems righter to me)
>>
>> I'm not opposed to this. Though I'm not sure what's best here.
>>
>>>> If we don't set pte_devmap(), then every single page that GUP
>>>> processes needs to check if it's a ZONE_DEVICE page and also if it's
>>>> a P2PDMA page (thus dereferencing pgmap) in order to satisfy the
>>>> requirements of FOLL_PCI_P2PDMA.
>>>
>>> Definately not suggesting not to set pte_devmap(), only that
>>> VM_MIXEDMAP should not be set on VMAs that only contain struct
>>> pages. That is an abuse of what it is intended for.
>>>
>>> At the very least there should be a big comment above the usage
>>> explaining that this is just working around a limitation in
>>> finish_fault() where it cannot set the PFN_DEV|PFN_MAP bits today.
>>
>> Is it? Documentation on vmf_insert_mixed() and VM_MIXEDMAP is not good
>> and the intention is not clear. I got the impression that mm people
>> wanted those interfaces used for users of pte_devmap().
> 
> I thought VM_MIXEDMAP was quite clear:
> 
> #define VM_MIXEDMAP	0x10000000	/* Can contain "struct page" and pure PFN pages */
> 
> This VMA does not include PFN pages, so it should not be tagged
> VM_MIXEDMAP.
> 
> Aside from enabling the special vmf_ API, it only controls some
> special behavior in vm_normal_page:
> 
>  * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
>  * page" backing, however the difference is that _all_ pages with a struct
>  * page (that is, those where pfn_valid is true) are refcounted and considered
>  * normal pages by the VM. The disadvantage is that pages are refcounted
>  * (which can be slower and simply not an option for some PFNMAP users). The
>  * advantage is that we don't have to follow the strict linearity rule of
>  * PFNMAP mappings in order to support COWable mappings.
> 
> Which again does not describe this case.

Some of this seems out of date. Pretty sure the pages are not refcounted
with vmf_insert_mixed() and vmf_insert_mixed() is currently the only way
to use VM_MIXEDMAP mappings.

>> device-dax uses these interfaces and as far as I can see it also only
>> contains struct pages (or at least  dev_dax_huge_fault() calls
>> pfn_to_page() on every page when VM_FAULT_NOPAGE happens).
> 
> hacky hacky :)
> 
> I think DAX probably did it that way for the same reason you are
> doing it that way - no other choice without changing something

Sure but if you look at other vmf_insert_mixed() (of which there are
few) you see similar patterns. Seems more like it was documented with
one thing in mind but then used in a completely different manner. Which
is why I suggested the documentation was not so good.

Logan
