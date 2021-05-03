Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71355371AB1
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbhECQkq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 12:40:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57542 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhECQjY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 12:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=dSmIkEgoovxWGBpVylVoINIV5o3Q8VtLhML3KxH+PMo=; b=U5gnu37Q5tdnJt0UVKiBzJezpj
        IqCcs/0WSQIDSpfdFzonkxdTcUNjQHjikAPnSxVxQn0DCkzGgMt8Nz3DVjRcqWWdEG8zLGPmagzDC
        J9H0aGFKyiOB2qVIXrnUes62g6K3skfeOE9+YWIeCrCEVW1OG4wqxP32VscKV6wk3Mt8TBYxxlnw3
        T5o8DVDqzg1db0k3T9FSFUTj6f/NdflGL2Xa9GRMQ9CiTHqOcM6Ktbw05h2zQeSTsO4uCodAI4ATC
        wMbfiBATIfUk3ZD6HJiL+F8OjCcbuRuS/4FKIvtJJSZv77DwnJaxc7v7L5HiMkY3nBICXFhXi1Prt
        OAaZHUcg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldbaM-0004Bi-0O; Mon, 03 May 2021 10:38:19 -0600
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
 <20210408170123.8788-6-logang@deltatee.com>
 <c050bcae-e223-bb41-021f-b1fda572647b@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <09c6048c-ee02-e820-f268-5f317772962f@deltatee.com>
Date:   Mon, 3 May 2021 10:38:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c050bcae-e223-bb41-021f-b1fda572647b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-02 3:23 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
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
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   include/linux/dma-mapping.h | 15 +++++++++++
>>   kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
>>   2 files changed, 61 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
>> index 2a984cb4d1e0..50b8f586cf59 100644
>> --- a/include/linux/dma-mapping.h
>> +++ b/include/linux/dma-mapping.h
>> @@ -60,6 +60,12 @@
>>    * at least read-only at lesser-privileged levels).
>>    */
>>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
>> +/*
>> + * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
>> + * dma_map_sg_p2pdma() instead. Used internally to indicate that the
>> + * caller is using the dma_map_sg_p2pdma() interface.
>> + */
>> +#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
>>
> 
> As mentioned near the top of this file,
> Documentation/core-api/dma-attributes.rst also needs to be updated, for
> this new item.

As this attribute is not meant to be used by anyone outside the dma
functions, I don't think it should be documented here. (That's why it
has a double underscource prefix).

>>   /*
>>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
>> @@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>>   		enum dma_data_direction dir, unsigned long attrs);
>>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs);
>> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
>> +		int nents, enum dma_data_direction dir, unsigned long attrs);
>>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   				      int nents, enum dma_data_direction dir,
>>   				      unsigned long attrs);
>> @@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>   {
>>   	return 0;
>>   }
>> +static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
>> +		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>> +		unsigned long attrs)
>> +{
>> +	return 0;
>> +}
>>   static inline void dma_unmap_sg_attrs(struct device *dev,
>>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>>   		unsigned long attrs)
>> @@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
>>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>> +#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)
> 
> This hunk is fine, of course.
> 
> But, about pre-existing issues: note to self, or to anyone: send a patch to turn
> these into inline functions. The macro redirection here is not adding value, but
> it does make things just a little bit worse.
> 
> 
>>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
>> index b6a633679933..923089c4267b 100644
>> --- a/kernel/dma/mapping.c
>> +++ b/kernel/dma/mapping.c
>> @@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>>   }
>>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>>   
>> -/*
>> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> - * It should never return a value < 0.
>> - */
> 
> It would be better to leave the comment in place, given the non-standard
> return values. However, looking around here, it would be better if we go
> with the standard -ERRNO for error, and >0 for sucess.

The comment is actually left in place. The diff just makes it look like
it was removed. It is added back lower down in the diff.

> There are pre-existing BUG_ON() and WARN_ON_ONCE() items that are partly
> an attempt to compensate for not being able to return proper -ERRNO
> codes. For example, this:
> 
> 	    BUG_ON(!valid_dma_direction(dir));
> 
> ...arguably should be more like this:
> 
>          if(WARN_ON_ONCE(!valid_dma_direction(dir)))
>                  return -EINVAL;

Yes, but you'll have to see the discussion in the RFC. The complaint was
that the calling convention for dma_map_sg() is not expected to return
anything other than 0 or the number of entries mapped. It can't return a
negative error code. That's why BUG_ON(ents < 0) is in the existing
code. That's also why this series introduces the new dma_map_sg_p2pdma()
function. (Though, Jason has made some suggestions to further change this).

> 
>> -int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>> -		enum dma_data_direction dir, unsigned long attrs)
>> +static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>> +		int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>>   	int ents;
>> @@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>>   	else
>>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
>> +
>> +	return ents;
>> +}
>> +
>> +/*
>> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> + * It should never return a value < 0.
>> + */
>> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	int ents;
> 
> Pre-existing note, feel free to ignore: the ents and nents in the same
> routines together, are way too close to the each other in naming. Maybe
> using "requested_nents", or "nents_arg", for the incoming value, would
> help.

Ok, will change.

>> +
>> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>   	BUG_ON(ents < 0);
>>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>>   
>> @@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>>   }
>>   EXPORT_SYMBOL(dma_map_sg_attrs);
>>   
>> +/*
>> + * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
>> + * on success). This function must be used if PCI P2PDMA pages might
>> + * be in the scatterlist.
> 
> Let's turn this into a kernel doc comment block, seeing as how it clearly
> wants to be--you're almost there already. You've even reinvented @Return,
> below. :)

Just trying to follow the convention in this file. But I can make it a
kernel doc.

>> + *
>> + * On error this function may return:
>> + *    -ENOMEM indicating that there was not enough resources available and
>> + *      the transfer may be retried later
>> + *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
>> + *      be mapped by the specified device, retries will always fail
>> + *
>> + * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().
> 
> How about:
> 
> "The scatterlist should be unmapped via dma_unmap_sg[_attrs]()."

Ok

Logan
