Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5755604D2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbiF2Pjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 11:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233843AbiF2Pjc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 11:39:32 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923936172;
        Wed, 29 Jun 2022 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=O0wtNrY7uERkcVmDzn9Qzn0QOjEuS076HETf2WzjME4=; b=fcBq3BeNtwnbwtK5Y2Ik7xDHNX
        R2UXfuLGRfqLKYw2O//6lyhArxbX+eYSq7C1KjshVcSK35zRKyY1/m5BoX90BANeJxKsWQHWzpJfH
        RLRIfLr01lR+my9+2IpdU/iMUoeB9400EApUEEHjJe6aaYg5O0DxWTZXa/RxPY1IK4XGp8wIPTO+B
        n0noULDLnowj1XntvqsDZQQRPCkqagswEtT4sxIgVQ1daNBO6u/6PpMAZgin/duxNTYcVdNOEKaTU
        0nCYR6bUVRS/Ok2+w20mNj06bY59NCDNF5cCXwNLFbRetVx9eUzGy9o9+U3YM2hjMTGWYbrJXVGen
        0sKA+1AQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1o6Zmm-002RkM-SQ; Wed, 29 Jun 2022 09:39:25 -0600
Message-ID: <c42b5ee3-5d4f-7e44-8885-26b8417208ae@deltatee.com>
Date:   Wed, 29 Jun 2022 09:39:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-2-logang@deltatee.com>
 <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <b56d9b93-c59f-5764-e599-d9718edb42d3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, kch@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v7 01/21] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2022-06-29 03:05, Robin Murphy wrote:
> On 2022-06-15 17:12, Logan Gunthorpe wrote:
>> Make use of the third free LSB in scatterlist's page_link on 64bit
>> systems.
>>
>> The extra bit will be used by dma_[un]map_sg_p2pdma() to determine when a
>> given SGL segments dma_address points to a PCI bus address.
>> dma_unmap_sg_p2pdma() will need to perform different cleanup when a
>> segment is marked as a bus address.
>>
>> The new bit will only be used when CONFIG_PCI_P2PDMA is set; this means
>> PCI P2PDMA will require CONFIG_64BIT. This should be acceptable as the
>> majority of P2PDMA use cases are restricted to newer root complexes and
>> roughly require the extra address space for memory BARs used in the
>> transactions.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
>>   drivers/pci/Kconfig         |  5 +++++
>>   include/linux/scatterlist.h | 44 ++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 48 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>> index 133c73207782..5cc7cba1941f 100644
>> --- a/drivers/pci/Kconfig
>> +++ b/drivers/pci/Kconfig
>> @@ -164,6 +164,11 @@ config PCI_PASID
>>   config PCI_P2PDMA
>>       bool "PCI peer-to-peer transfer support"
>>       depends on ZONE_DEVICE
>> +    #
>> +    # The need for the scatterlist DMA bus address flag means PCI P2PDMA
>> +    # requires 64bit
>> +    #
>> +    depends on 64BIT
>>       select GENERIC_ALLOCATOR
>>       help
>>         Enableѕ drivers to do PCI peer-to-peer transactions to and from
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index 7ff9d6386c12..6561ca8aead8 100644
>> --- a/include/linux/scatterlist.h
>> +++ b/include/linux/scatterlist.h
>> @@ -64,12 +64,24 @@ struct sg_append_table {
>>   #define SG_CHAIN    0x01UL
>>   #define SG_END        0x02UL
>>   +/*
>> + * bit 2 is the third free bit in the page_link on 64bit systems which
>> + * is used by dma_unmap_sg() to determine if the dma_address is a
>> + * bus address when doing P2PDMA.
>> + */
>> +#ifdef CONFIG_PCI_P2PDMA
>> +#define SG_DMA_BUS_ADDRESS    0x04UL
>> +static_assert(__alignof__(struct page) >= 8);
>> +#else
>> +#define SG_DMA_BUS_ADDRESS    0x00UL
>> +#endif
>> +
>>   /*
>>    * We overload the LSB of the page pointer to indicate whether it's
>>    * a valid sg entry, or whether it points to the start of a new
>> scatterlist.
>>    * Those low bits are there for everyone! (thanks mason :-)
>>    */
>> -#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END)
>> +#define SG_PAGE_LINK_MASK (SG_CHAIN | SG_END | SG_DMA_BUS_ADDRESS)
>>     static inline unsigned int __sg_flags(struct scatterlist *sg)
>>   {
>> @@ -91,6 +103,11 @@ static inline bool sg_is_last(struct scatterlist *sg)
>>       return __sg_flags(sg) & SG_END;
>>   }
>>   +static inline bool sg_is_dma_bus_address(struct scatterlist *sg)
>> +{
>> +    return __sg_flags(sg) & SG_DMA_BUS_ADDRESS;
>> +}
>> +
>>   /**
>>    * sg_assign_page - Assign a given page to an SG entry
>>    * @sg:            SG entry
>> @@ -245,6 +262,31 @@ static inline void sg_unmark_end(struct
>> scatterlist *sg)
>>       sg->page_link &= ~SG_END;
>>   }
>>   +/**
>> + * sg_dma_mark_bus address - Mark the scatterlist entry as a bus address
>> + * @sg:         SG entryScatterlist
> 
> entryScatterlist?
> 
>> + *
>> + * Description:
>> + *   Marks the passed in sg entry to indicate that the dma_address is
>> + *   a bus address and doesn't need to be unmapped.
>> + **/
>> +static inline void sg_dma_mark_bus_address(struct scatterlist *sg)
>> +{
>> +    sg->page_link |= SG_DMA_BUS_ADDRESS;
>> +}
>> +
>> +/**
>> + * sg_unmark_pci_p2pdma - Unmark the scatterlist entry as a bus address
>> + * @sg:         SG entryScatterlist
>> + *
>> + * Description:
>> + *   Clears the bus address mark.
>> + **/
>> +static inline void sg_dma_unmark_bus_address(struct scatterlist *sg)
>> +{
>> +    sg->page_link &= ~SG_DMA_BUS_ADDRESS;
>> +}
> 
> Does this serve any useful purpose? If a page is determined to be device
> memory, it's not going to suddenly stop being device memory, and if the
> underlying sg is recycled to point elsewhere then sg_assign_page() will
> still (correctly) clear this flag anyway. Trying to reason about this
> beyond superficial API symmetry - i.e. why exactly would a caller need
> to call it, and what would the implications be of failing to do so -
> seems to lead straight to confusion.
> 
> In fact I'd be inclined to have sg_assign_page() be responsible for
> setting the flag automatically as well, and thus not need
> sg_dma_mark_bus_address() either, however I can see the argument for
> doing it this way round to not entangle the APIs too much, so I don't
> have any great objection to that.

Yes, I think you misunderstand what this is for. The SG_DMA_BUS_ADDDRESS
flag doesn't mark the segment for the page, but for the dma address. It
cannot be set in sg_assign_page() seeing it's not a property of the page
but a property of the dma_address in the sgl.

It's not meant for use by regular SG users, it's only meant for use
inside DMA mapping implementations. The purpose is to know whether a
given dma_address in the SGL is a bus address or regular memory because
the two different types must be unmapped differently. We can't rely on
the page because, as you know, many dma_map_sg() the dma_address entry
in the sgl does not map to the same memory as the page. Or to put it
another way: is_pci_p2pdma_page(sg->page) does not imply that
sg->dma_address points to a bus address.

Does that make sense?

Logan
