Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B951F36CEC5
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 00:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhD0WvO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 18:51:14 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42486 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhD0WvN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 18:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=PBZp6uxAp8nlNU5Rm16hkR47Rwe8xrGWtpeD+dKWkk4=; b=c2SnI7NAl3/gr4SFEOqWfEjO9J
        1JGnC7Zf5KDX7iHl6Y4Xf/2xqN/Sf5EK4N3LedlbB9Fd00L3W9uy4hRpaf9AzRR6bhJRwlUH+3jQV
        JGHEoIAnzvnTbXFFloa9dmt/bebMlHu8p0eMd7ujtwQMFSXPtCaCZfLSEapIfvrwoLvjkcmHaak0S
        os4Ry++J+BA4Zjy4rlpJGfScH23wq+QuJ1EnvUrl/i2hoEb1GA+PElTtZrctT7avrcp051HeAQJHt
        MommdMIRXxQ8f7+NTw6YINNchc1V2k8mSpMibhQPjTbiWcdM3d674C2MzQOyDshqLUX3ERNg5eNxi
        Yzo0Jtug==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lbWWo-0002hR-Kh; Tue, 27 Apr 2021 16:50:04 -0600
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
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-6-logang@deltatee.com>
 <20210427192232.GO2047089@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <74473159-b4d7-89c8-9dae-7e983b22ef2b@deltatee.com>
Date:   Tue, 27 Apr 2021 16:49:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427192232.GO2047089@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_FREE,NICE_REPLY_A autolearn=no autolearn_force=no version=3.4.2
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 1:22 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> dma_map_sg() either returns a positive number indicating the number
>> of entries mapped or zero indicating that resources were not available
>> to create the mapping. When zero is returned, it is always safe to retry
>> the mapping later once resources have been freed.
>>
>> Once P2PDMA pages are mixed into the SGL there may be pages that may
>> never be successfully mapped with a given device because that device may
>> not actually be able to access those pages. Thus, multiple error
>> conditions will need to be distinguished to determine weather a retry
>> is safe.
>>
>> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
>> convention from dma_map_sg(). The function will return a positive
>> integer on success or a negative errno on failure.
>>
>> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
>> indicate that a P2PDMA page is not mappable.
>>
>> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
>> level implementations that P2PDMA pages are allowed and to warn if a
>> caller introduces them into the regular dma_map_sg() interface.
> 
> So this new API is all about being able to return an error code
> because auditing the old API is basically terrifying?
> 
> OK, but why name everything new P2PDMA? It seems nicer to give this
> some generic name and have some general program to gradually deprecate
> normal non-error-capable dma_map_sg() ?
> 
> I think that will raise less questions when subsystem people see the
> changes, as I was wondering why RW was being moved to use what looked
> like a p2pdma only API.
> 
> dma_map_sg_or_err() would have been clearer
> 
> The flag is also clearer as to the purpose if it is named
> __DMA_ATTR_ERROR_ALLOWED

I'm not opposed to these names. I can use them for v2 if there are no
other opinions.

Logan
