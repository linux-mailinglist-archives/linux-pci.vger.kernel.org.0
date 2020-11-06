Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA742A9E5D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 21:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgKFUDi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 15:03:38 -0500
Received: from ale.deltatee.com ([204.191.154.188]:60262 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgKFUDi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 15:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eezeT8sE0c+dvLmjvESICoKhAlzXaqNnjl5jvhsWtf0=; b=dA51HxqSCHR4JuZbkzzSmg3W+t
        yWkoDic2Ka2INSPCZAs/OVNcm6A8oiWD4xs5cZOJI6JCJWoyIEcMFYQuwDXpEP94JRNOq4Jm597IW
        zY9+kL0WMddHMYyhT16mkNx04/hEioF70ZnVXsKAV6asL35LsLIGi/hQcp4flbFRG6VUJKaDSYlQm
        BxfqzK/sL5Uezm0Q9/fKyVYifXoPOzisxNKpvC7XUXwFcrIJEQsQ7vt00oqimgL0c3rksAR1njMyZ
        RHfHxAGvibWkE0XP5Ny8DbZ0h152CMHqRJ4Aq7wirLss+0t12x4iriBT6mcS0XfaFdtJXuwn2twYA
        onotgqBQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kb7xI-0005Wu-TX; Fri, 06 Nov 2020 13:03:30 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
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
 <20201106195341.GA244516@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
Date:   Fri, 6 Nov 2020 13:03:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106195341.GA244516@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 14/15] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2020-11-06 12:53 p.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 12:44:59PM -0700, Logan Gunthorpe wrote:
>>
>>
>> On 2020-11-06 12:30 p.m., Jason Gunthorpe wrote:
>>>> I certainly can't make decisions for code that isn't currently
>>>> upstream.
>>>
>>> The rdma drivers are all upstream, what are you thinking about?
>>
>> Really? I feel like you should know what I mean here...
>>
>> I mean upstream code that actually uses the APIs that I'd have to
>> introduce. I can't say here's an API feature that no code uses but the
>> already upstream rdma driver might use eventually. It's fairly easy to
>> send patches that make the necessary changes when someone adds a use of
>> those changes inside the rdma code.
> 
> Sure, but that doesn't mean you have to actively design things to be
> unusable beyond this narrow case. The RDMA drivers are all there, all
> upstream, if this work is accepted then the changes to insert P2P
> pages into their existing mmap flows is a reasonable usecase to
> consider at this point when building core code APIs.
> 
> You shouldn't add dead code, but at least have a design in mind for
> what it needs to look like and some allowance.

I don't see anything I've done that's at odds with that. You will still
need to make changes to the p2pdma code to implement your use case.

>>>> Ultimately, if you aren't using the genpool you will have to implement
>>>> your own mmap operation that somehow allocates the pages and your own
>>>> page_free hook. 
>>>
>>> Sure, the mlx5 driver already has a specialized alloctor for it's BAR
>>> pages.
>>
>> So it *might* make sense to carve out a common helper to setup a VMA for
>> P2PDMA to do the vm_flags check and set VM_MIXEDMAP... but besides that,
>> there's no code that would be common to the two cases.
> 
> I think the whole insertion of P2PDMA pages into a VMA should be
> similar to io_remap_pfn() so all the VM flags, pgprot_decrypted and
> other subtle details are all in one place. (also it needs a
> pgprot_decrypted before doing vmf_insert, I just learned that this
> month)

I don't think a function like that will work for the p2pmem use case. In
order to implement proper page freeing I expect I'll need a loop around
the allocator and vm_insert_mixed()... Something roughly like:

for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
        vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
	ret = vmf_insert_mixed(vma, addr,
  		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
}

That way we can call pci_free_p2pmem() when a page's ref count goes to
zero. I suspect your use case will need to do something similar.

Logan
