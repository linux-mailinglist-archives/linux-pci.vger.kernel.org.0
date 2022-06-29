Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C9B560509
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiF2P5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 11:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbiF2P5m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 11:57:42 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF598193FB;
        Wed, 29 Jun 2022 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=SVR0l1hJUb/SHapAzG2atHABZ/RRitWr1nc+ar7tRXg=; b=QyUF4DUaaZjROkuPI+1suf1xXG
        iYuJIT9YMfYCt00rup88G3A2fOs1LDo7hhHgWo0Ohlqb76yxSlp/vgMGwxd7TW5fYAkKL79lyXLKw
        X+zSU/4jS/f4D/m/J9gbb/UReLJ00H6u78LPJthJAR+juKfGgM94nvaKgzerE3D/pFN6SnvVDAoyK
        eto6eEiUJPslncF4lPynUlCOC3+9GHp8EcwRnCzPOaGuxwS0LB6WUPHazf3fFRXCJnGM+lmx17Hax
        rUH3mIYEFd4d/GhL3bWSdTf7itMjRaQRx0P2J2yU7oU/L88BMNHKeWYzP16i2n7FzmTTvUtv5REt6
        VgBg577w==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o6a4O-002RwK-3q; Wed, 29 Jun 2022 09:57:37 -0600
Message-ID: <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
Date:   Wed, 29 Jun 2022 09:57:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Minturn Dave B <dave.b.minturn@intel.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-9-logang@deltatee.com>
 <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <feecc6fe-a16e-11f2-33c8-3de7c96b9ad5@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, dave.b.minturn@intel.com, martin.oliveira@eideticom.com, rcampbell@nvidia.com, jgg@nvidia.com, jhubbard@nvidia.com, dave.hansen@linux.intel.com, willy@infradead.org, christian.koenig@amd.com, jgg@ziepe.ca, ckulkarnilinux@gmail.com, jason@jlekstrand.net, daniel.vetter@ffwll.ch, helgaas@kernel.org, dan.j.williams@intel.com, sbates@raithlin.com, ira.weiny@intel.com, hch@lst.de, jianxin.xiong@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-06-29 06:07, Robin Murphy wrote:
> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>> apply the appropriate bus address to the segment. The IOVA is not
>> created if the scatterlist only consists of P2PDMA pages.
>>
>> A P2PDMA page may have three possible outcomes when being mapped:
>>    1) If the data path between the two devices doesn't go through
>>       the root port, then it should be mapped with a PCI bus address
>>    2) If the data path goes through the host bridge, it should be mapped
>>       normally with an IOMMU IOVA.
>>    3) It is not possible for the two devices to communicate and thus
>>       the mapping operation should fail (and it will return -EREMOTEIO).
>>
>> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>> over when determining the start and end IOVA addresses.
>>
>> With this change, the flags variable in the dma_map_ops is set to
>> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>>   1 file changed, 61 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>> index f90251572a5d..b01ca0c6a7ab 100644
>> --- a/drivers/iommu/dma-iommu.c
>> +++ b/drivers/iommu/dma-iommu.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/iova.h>
>>   #include <linux/irq.h>
>>   #include <linux/list_sort.h>
>> +#include <linux/memremap.h>
>>   #include <linux/mm.h>
>>   #include <linux/mutex.h>
>>   #include <linux/pci.h>
>> @@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev,
>> struct scatterlist *sg, int nents,
>>           sg_dma_address(s) = DMA_MAPPING_ERROR;
>>           sg_dma_len(s) = 0;
>>   +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
> 
> Logically, should we not be able to use sg_is_dma_bus_address() here? I
> think it should be feasible, and simpler, to prepare the p2p segments
> up-front, such that at this point all we need to do is restore the
> original length (if even that, see below).

Per my previous email, no, because sg_is_dma_bus_address() is not set
yet and not meant to tell you something about the page. That flag will
be set below by pci_p2pdma_map_bus_segment() and then checkd in
iommu_dma_unmap_sg() to determine if the dma_address in the segment
needs to be unmapped.

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
>>           /*
>>            * Now fill in the real DMA data. If...
>>            * - there is a valid output segment to append to
>> @@ -1158,6 +1169,8 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>       struct iova_domain *iovad = &cookie->iovad;
>>       struct scatterlist *s, *prev = NULL;
>>       int prot = dma_info_to_prot(dir, dev_is_dma_coherent(dev), attrs);
>> +    struct dev_pagemap *pgmap = NULL;
>> +    enum pci_p2pdma_map_type map_type;
>>       dma_addr_t iova;
>>       size_t iova_len = 0;
>>       unsigned long mask = dma_get_seg_boundary(dev);
>> @@ -1193,6 +1206,35 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>           s_length = iova_align(iovad, s_length + s_iova_off);
>>           s->length = s_length;
>>   +        if (is_pci_p2pdma_page(sg_page(s))) {
>> +            if (sg_page(s)->pgmap != pgmap) {
>> +                pgmap = sg_page(s)->pgmap;
>> +                map_type = pci_p2pdma_map_type(pgmap, dev);
>> +            }
> 
> There's a definite code smell here, but per above and below I think we
> *should* actually call the new helper instead of copy-pasting half of it.


> 
>> +
>> +            switch (map_type) {
>> +            case PCI_P2PDMA_MAP_BUS_ADDR:
>> +                /*
>> +                 * A zero length will be ignored by
>> +                 * iommu_map_sg() and then can be detected
> 
> If that is required behaviour then it needs an explicit check in
> iommu_map_sg() to guarantee (and document) it. It's only by chance that
> __iommu_map() happens to return success for size == 0 *if* all the other
> arguments still line up, which is a far cry from a safe no-op.

What should such a check look like? I could certainly add some comments
to iommu_map_sg(), but I don't see what the code would need to check for...

> However, rather than play yet more silly tricks, I think it would make
> even more sense to make iommu_map_sg() properly aware and able to skip
> direct p2p segments on its own. Once it becomes normal to pass mixed
> scatterlists around, it's only a matter of time until one ends up being
> handed to a driver which manages its own IOMMU domain, and then what?

I suppose we can add another call to is_pci_p2pdma_page() inside
iommu_map_sg() if you think that is cleaner. Seems like more work on the
fast path to me, but I'm not opposed to it.

>> +                 * in __finalise_sg() to actually map the
>> +                 * bus address.
>> +                 */
>> +                s->length = 0;
>> +                continue;
>> +            case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +                /*
>> +                 * Mapping through host bridge should be
>> +                 * mapped with regular IOVAs, thus we
>> +                 * do nothing here and continue below.
>> +                 */
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
>> @@ -1215,6 +1257,9 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>           prev = s;
>>       }
>>   +    if (!iova_len)
>> +        return __finalise_sg(dev, sg, nents, 0);
>> +
>>       iova = iommu_dma_alloc_iova(domain, iova_len, dma_get_mask(dev),
>> dev);
>>       if (!iova) {
>>           ret = -ENOMEM;
>> @@ -1236,7 +1281,7 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>   out_restore_sg:
>>       __invalidate_sg(sg, nents);
>>   out:
>> -    if (ret != -ENOMEM)
>> +    if (ret != -ENOMEM && ret != -EREMOTEIO)
>>           return -EINVAL;
>>       return ret;
>>   }
>> @@ -1244,7 +1289,7 @@ static int iommu_dma_map_sg(struct device *dev,
>> struct scatterlist *sg,
>>   static void iommu_dma_unmap_sg(struct device *dev, struct
>> scatterlist *sg,
>>           int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -    dma_addr_t start, end;
>> +    dma_addr_t end, start = DMA_MAPPING_ERROR;
> 
> There are several things I don't like about this logic, I'd rather have
> "end = 0" here...

Ok, I think that should work.

>>       struct scatterlist *tmp;
>>       int i;
>>   @@ -1260,14 +1305,22 @@ static void iommu_dma_unmap_sg(struct device
>> *dev, struct scatterlist *sg,
>>        * The scatterlist segments are mapped into a single
>>        * contiguous IOVA allocation, so this is incredibly easy.
>>        */
> 
> [ This comment rather stops being true :( ]

Not exactly. Sure there are some segments in the SGL that have bus
addresses, but all the regular IOVAs still have a single contiguous
allocation and only require one call to  __iommu_dma_unmap(). The only
trick issues is finding the first and last actual IOVA SG to get the range.

> 
>> -    start = sg_dma_address(sg);
>> -    for_each_sg(sg_next(sg), tmp, nents - 1, i) {
> 
> ...then generalise the first-element special case here into a dedicated
> "walk to the first non-p2p element" loop...

Ok, I'll see what I can do for that.

Logan
