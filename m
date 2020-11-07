Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187D82AA241
	for <lists+linux-pci@lfdr.de>; Sat,  7 Nov 2020 03:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgKGCuv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 21:50:51 -0500
Received: from ale.deltatee.com ([204.191.154.188]:35002 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKGCuv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 21:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=60km6xH0HSvahM5c30+DJ4g8BodPX7+0LmwNaM0K8BI=; b=ExYwdc+DkS+fkDeydObiKNmENV
        tHOCg7o9tz01AsRah8P/Sr/9fh7XNjnnO8jUpwDGiiOtI4fzZuc6CUz0kowPjTXWC6ng/SIFsgqYN
        EJHOk3xQTOWZhterUYWYUuqnSOJrTgIRuwbsS0EX7HcK+HPf6oJYHWV5Bct4py7lGeNLo3+V3BDQD
        y5yp6ooOKpOsyzsFqaAIcs+xYoIbgqvVKxiXPkS/46cCAeQ19J2mBvZiqs9XbCzRkYaVcg210o8Hy
        kosgowf22Fkc7d716zpVdUVQa11HzeqnKB3bS3yoy0lNdGfuHQmF/UGjLKyQSo4URkuNgC0n1iHYd
        T4gVkX0w==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kbEJI-00029J-SL; Fri, 06 Nov 2020 19:50:37 -0700
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
References: <20201106172206.GS36674@ziepe.ca>
 <b1e8dfce-d583-bed8-d04d-b7265a54c99f@deltatee.com>
 <20201106174223.GU36674@ziepe.ca>
 <2c2d2815-165e-2ef9-60d6-3ace7ff3aaa5@deltatee.com>
 <20201106180922.GV36674@ziepe.ca>
 <09885400-36f8-bc1d-27f0-a8adcf6104d4@deltatee.com>
 <20201106193024.GW36674@ziepe.ca>
 <03032637-0826-da76-aec2-121902b1c166@deltatee.com>
 <20201106195341.GA244516@ziepe.ca>
 <e6a99d54-b33a-0df1-ee33-4aa7a70124a6@deltatee.com>
 <20201107001457.GB244516@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6f202b79-fa90-7cda-9ac9-457aa451530f@deltatee.com>
Date:   Fri, 6 Nov 2020 19:50:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201107001457.GB244516@ziepe.ca>
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



On 2020-11-06 5:14 p.m., Jason Gunthorpe wrote:
> On Fri, Nov 06, 2020 at 01:03:26PM -0700, Logan Gunthorpe wrote:
>> I don't think a function like that will work for the p2pmem use case. In
>> order to implement proper page freeing I expect I'll need a loop around
>> the allocator and vm_insert_mixed()... Something roughly like:
>>
>> for (addr = vma->vm_start; addr < vma->vm_end; addr += PAGE_SIZE) {
>>         vaddr = pci_alloc_p2pmem(pdev, PAGE_SIZE);
>> 	ret = vmf_insert_mixed(vma, addr,
>>   		       __pfn_to_pfn_t(virt_to_pfn(vaddr), PFN_DEV | PFN_MAP));
>> }
>>
>> That way we can call pci_free_p2pmem() when a page's ref count goes to
>> zero. I suspect your use case will need to do something similar.
> 
> Yes, but I would say the pci_alloc_p2pmem() layer should be able to
> free pages on a page-by-page basis so you don't have to do stuff like
> the above.
> 
> There is often a lot of value in having physical contiguous addresses,
> so allocating page by page as well seems poor.

Agreed. But I'll have to dig to see if genalloc supports freeing blocks
in different sizes than the allocations.

Logan
