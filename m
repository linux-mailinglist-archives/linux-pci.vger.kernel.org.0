Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1023F561E83
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 16:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiF3O5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiF3O5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 10:57:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EB831DA7E;
        Thu, 30 Jun 2022 07:57:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7FC61063;
        Thu, 30 Jun 2022 07:57:05 -0700 (PDT)
Received: from [10.57.85.25] (unknown [10.57.85.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C8C5A3F66F;
        Thu, 30 Jun 2022 07:57:01 -0700 (PDT)
Message-ID: <f9c1e41b-d2a8-61fe-0888-4f0f988912a7@arm.com>
Date:   Thu, 30 Jun 2022 15:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v7 08/21] iommu/dma: support PCI P2PDMA pages in dma-iommu
 map_sg
Content-Language: en-GB
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
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
 <f56181fb-7035-a775-22b1-77f97d6ec52c@deltatee.com>
 <7f0673e1-433b-65fb-1d2b-c3e4adeebf87@arm.com>
 <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <626de61d-e85e-bc9f-9e3d-836a408c859f@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2022-06-29 23:41, Logan Gunthorpe wrote:
> 
> 
> On 2022-06-29 13:15, Robin Murphy wrote:
>> On 2022-06-29 16:57, Logan Gunthorpe wrote:
>>>
>>>
>>>
>>> On 2022-06-29 06:07, Robin Murphy wrote:
>>>> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>>>>> When a PCI P2PDMA page is seen, set the IOVA length of the segment
>>>>> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
>>>>> apply the appropriate bus address to the segment. The IOVA is not
>>>>> created if the scatterlist only consists of P2PDMA pages.
>>>>>
>>>>> A P2PDMA page may have three possible outcomes when being mapped:
>>>>>      1) If the data path between the two devices doesn't go through
>>>>>         the root port, then it should be mapped with a PCI bus address
>>>>>      2) If the data path goes through the host bridge, it should be
>>>>> mapped
>>>>>         normally with an IOMMU IOVA.
>>>>>      3) It is not possible for the two devices to communicate and thus
>>>>>         the mapping operation should fail (and it will return
>>>>> -EREMOTEIO).
>>>>>
>>>>> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
>>>>> indicate bus address segments. On unmap, P2PDMA segments are skipped
>>>>> over when determining the start and end IOVA addresses.
>>>>>
>>>>> With this change, the flags variable in the dma_map_ops is set to
>>>>> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
>>>>>
>>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>> ---
>>>>>     drivers/iommu/dma-iommu.c | 68
>>>>> +++++++++++++++++++++++++++++++++++----
>>>>>     1 file changed, 61 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>>>>> index f90251572a5d..b01ca0c6a7ab 100644
>>>>> --- a/drivers/iommu/dma-iommu.c
>>>>> +++ b/drivers/iommu/dma-iommu.c
>>>>> @@ -21,6 +21,7 @@
>>>>>     #include <linux/iova.h>
>>>>>     #include <linux/irq.h>
>>>>>     #include <linux/list_sort.h>
>>>>> +#include <linux/memremap.h>
>>>>>     #include <linux/mm.h>
>>>>>     #include <linux/mutex.h>
>>>>>     #include <linux/pci.h>
>>>>> @@ -1062,6 +1063,16 @@ static int __finalise_sg(struct device *dev,
>>>>> struct scatterlist *sg, int nents,
>>>>>             sg_dma_address(s) = DMA_MAPPING_ERROR;
>>>>>             sg_dma_len(s) = 0;
>>>>>     +        if (is_pci_p2pdma_page(sg_page(s)) && !s_iova_len) {
>>>>
>>>> Logically, should we not be able to use sg_is_dma_bus_address() here? I
>>>> think it should be feasible, and simpler, to prepare the p2p segments
>>>> up-front, such that at this point all we need to do is restore the
>>>> original length (if even that, see below).
>>>
>>> Per my previous email, no, because sg_is_dma_bus_address() is not set
>>> yet and not meant to tell you something about the page. That flag will
>>> be set below by pci_p2pdma_map_bus_segment() and then checkd in
>>> iommu_dma_unmap_sg() to determine if the dma_address in the segment
>>> needs to be unmapped.
>>
>> I know it's not set yet as-is; I'm suggesting things should be
>> restructured so that it *would be*. In the logical design of this code,
>> the DMA addresses are effectively determined in iommu_dma_map_sg(), and
>> __finalise_sg() merely converts them from a relative to an absolute form
>> (along with undoing the other trickery). Thus the call to
>> pci_p2pdma_map_bus_segment() absolutely belongs in the main
>> iommu_map_sg() loop.
> 
> I don't see how that can work: __finalise_sg() does more than convert
> them from relative to absolute, it also figures out which SG entry will
> contain which dma_address segment. Which segment a P2PDMA address needs
> to be programmed into depends on the how 'cur' is calculated which in
> turn depends on things like seg_mask and max_len. This calculation is
> not done in iommu_dma_map_sg() so I don't see how there's any hope of
> assigning the bus address for the P2P segments in that function.
> 
> If there's a way to restructure things so that's possible that I'm not
> seeing, I'm open to it but it's certainly not immediately obvious.

Huh? It's still virtually the same thing; iommu_dma_map_sg() calls 
pci_p2pdma_map_bus_segment(s) and sets s->length to 0 if 
PCI_P2PDMA_MAP_BUS_ADDR, then __finalise_sg() can use 
sg_is_dma_bus_address(s) in place of is_pci_p2pdma_page(sg_page(s)), and 
just propagate the DMA address and original length from s to cur.

Here you've written a patch which looks to correctly interrupt any 
ongoing concatenation state and convey some data from the given input 
segment to the appropriate output segment, so I'm baffled by why you'd 
think you couldn't do what you've already done.

Thanks,
Robin.
