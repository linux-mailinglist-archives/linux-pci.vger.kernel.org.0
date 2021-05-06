Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101A7375DBE
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 02:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhEGAAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 20:00:42 -0400
Received: from ale.deltatee.com ([204.191.154.188]:47798 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbhEGAAk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 May 2021 20:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=lutt0mRx1qejbd/KzcxWOBkc0pyjO3VgQZn/+HsAIag=; b=tOkHvek+83IjhQiCfL3GVpPHEz
        LbEurXfHUNzzROcmLSSaXdORwYe+S8wQ6YjP5FgHzL9zkBxCjtspkcXueFktPt+htL2KCkKjDRsVz
        XNPqDPGyecK4bVgZjR7aY4L+2UdND3io9SpayZY9JC9Uy3qCZf1PBs5rh0jltsjsMA/11ad/lPH5t
        6D8zdFq+sLfJGKtZwY1Pnu6OienaGECcsL3fXAMUzp0UrL3pnzVq2Q+UHbYalfgJfJ62E3S4NkH7S
        pPOK7AfODC/AgmfHxvesokiRhS/Kv0C7N5MH0STByLV9tzPPH4hzVaNIbd0DDNo4be13qKrwmr3gV
        I6qRFqDw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lentq-0003Fs-1C; Thu, 06 May 2021 17:59:23 -0600
To:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20210408170123.8788-12-logang@deltatee.com>
 <560b2653-ad00-9cc3-0645-df7aff278321@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <196d2d78-2c63-74cf-743d-1f3322431f88@deltatee.com>
Date:   Thu, 6 May 2021 17:59:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <560b2653-ad00-9cc3-0645-df7aff278321@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 11/16] iommu/dma: Support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry, I think I missed responding to this one so here are the answers:

On 2021-05-02 7:14 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
>>
>> Similar to dma-direct, the sg_mark_pci_p2pdma() flag is used to
>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>> over when determining the start and end IOVA addresses.
>>
>> With this change, the flags variable in the dma_map_ops is
>> set to DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for
>> P2PDMA pages.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 66 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index af765c813cc8..ef49635f9819 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/mm.h>
>>   #include <linux/mutex.h>
>>   #include <linux/pci.h>
>> +#include <linux/pci-p2pdma.h>
>>   #include <linux/swiotlb.h>
>>   #include <linux/scatterlist.h>
>>   #include <linux/vmalloc.h>
>> @@ -864,6 +865,16 @@ static int __finalise_sg(struct device *dev,
>> struct scatterlist *sg, int nents,
>>           sg_dma_address(s) = DMA_MAPPING_ERROR;
>>           sg_dma_len(s) = 0;
>>   +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
> 
> Newbie question: I'm in the dark as to why the !s_iova_len check is there,
> can you please enlighten me?

The loop in iommu_dma_map_sg() will decide what to do with P2PDMA pages.
If it is to map it with the bus address it will set s_iova_len to zero
so that no space is allocated in the IOVA. If it is to map it through
the host bridge, then it it will leave s_iova_len alone and create the
appropriate mapping with the CPU physical address.

This condition notices that s_iova_len was set to zero and fills in a SG
segment with the PCI bus address for that region.


> 
>> +            if (i > 0)
>> +                cur = sg_next(cur);
>> +
>> +            pci_p2pdma_map_bus_segment(s, cur);
>> +            count++;
>> +            cur_len = 0;
>> +            continue;
>> +        }
>> +
> 
> This is really an if/else condition. And arguably, it would be better
> to split out two subroutines, and call one or the other depending on
> the result of if is_pci_p2pdma_page(), instead of this "continue" approach.

I really disagree here. Putting the exceptional condition in it's own if
statement and leaving the normal case un-indented is easier to read and
understand. It also saves an extra level of indentation in code that is
already starting to look a little squished.


>>           /*
>>            * Now fill in the real DMA data. If...
>>            * - there is a valid output segment to append to
>> @@ -961,10 +972,12 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>       struct iova_domain *iovad = &cookie->iovad;
>>       struct scatterlist *s, *prev = NULL;
>>       int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>> +    struct dev_pagemap *pgmap = NULL;
>> +    enum pci_p2pdma_map_type map_type;
>>       dma_addr_t iova;
>>       size_t iova_len = 0;
>>       unsigned long mask = dma_get_seg_boundary(dev);
>> -    int i;
>> +    int i, ret = 0;
>>         if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
>>           iommu_deferred_attach(dev, domain))
>> @@ -993,6 +1006,31 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>           s_length = iova_align(iovad, s_length + s_iova_off);
>>           s->length = s_length;
>>   +        if (is_pci_p2pdma_page(sg_page(s))) {
>> +            if (sg_page(s)->pgmap != pgmap) {
>> +                pgmap = sg_page(s)->pgmap;
>> +                map_type = pci_p2pdma_map_type(pgmap, dev,
>> +                                   attrs);
>> +            }
>> +
>> +            switch (map_type) {
>> +            case PCI_P2PDMA_MAP_BUS_ADDR:
>> +                /*
>> +                 * A zero length will be ignored by
>> +                 * iommu_map_sg() and then can be detected
>> +                 * in __finalise_sg() to actually map the
>> +                 * bus address.
>> +                 */
>> +                s->length = 0;
>> +                continue;
>> +            case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +                break;
>> +            default:
>> +                ret = -EREMOTEIO;
>> +                goto out_restore_sg;
>> +            }
>> +        }
>> +
>>           /*
>>            * Due to the alignment of our single IOVA allocation, we can
>>            * depend on these assumptions about the segment boundary mask:
>> @@ -1015,6 +1053,9 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>           prev = s;
>>       }
>>   +    if (!iova_len)
>> +        return __finalise_sg(dev, sg, nents, 0);
>> +
> 
> ohhh, we're really slicing up this function pretty severely, what with the
> continue and the early out and several other control flow changes. I think
> it would be better to spend some time factoring this function into two
> cases, now that you're adding a second case for PCI P2PDMA. Roughly,
> two subroutines would do it.

I don't see how we can factor this into two cases. The SGL may contain
normal pages or P2PDMA pages or a mix of both and we have to create an
IOVA area for all the regions that map the CPU physical address (ie
normal pages and some P2PDMA pages) then also insert segments for any
PCI bus address.

> As it is, this leaves behind a routine that is extremely hard to mentally
> verify as correct.

Yes, this is tricky code, but not that incomprehensible. Most of the
difficulty is in understanding how it works before adding the P2PDMA bits.

There are two loops: one to prepare the IOVA region and another to fill
in the SGL. We have to add cases in both loops to skip the segments that
need to be mapped with the bus address in the first loop, and insert the
dma SGL segments in the second loop.

Logan
