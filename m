Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4302A371D65
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbhECQ6v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 12:58:51 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57990 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhECQ4M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 12:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=h9d5zovbtXKtO9TZYvlu4xL+neDJxYxd4FL4V4x+RQk=; b=XA3VMJFHu22LiuYRgV7sx4Rs8c
        3591aoMHNv/NjUeysIvMIemFNGQvvxhSeVFLCIfBFEcN01AnLU0454DR7x9i5+KbkpS9wQvmvTDlB
        wmDUyJnbQ8AY0II0FjrcE9U2lfVByEIa3k4pk83kSjB2pgdejDq3f35QdxYnU45zXwOvnAdMTmYRD
        sEhVGLAwVXWpBZYAFJ1g4iWMaNWdT8a2zstO8bergFsL7t06RcmqF22XWsu1q8nTiQZBV3QbpBlvX
        aEpoRPohuyyWFgct68cZTIlU40n9PYIaNeseQ9Io2WJOjCS7wWDIUSo6hGwSJE0qOa2JxxSZtGHpi
        RmunKpRw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldbqc-0004SZ-Bi; Mon, 03 May 2021 10:55:07 -0600
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
 <20210408170123.8788-10-logang@deltatee.com>
 <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aa0698ba-abad-8c07-2962-d66b6a7affd9@deltatee.com>
Date:   Mon, 3 May 2021 10:55:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <37fa46c7-2c24-1808-16e9-e543f4601279@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-02 5:28 p.m., John Hubbard wrote:
>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 
> This routine now deserves a little bit of commenting, now that it is
> doing less obvious things. How about something like this:
> 
> /*
>   * Unmaps pages, except for PCI_P2PDMA pages, which were never mapped in the
>   * first place. Instead of unmapping PCI_P2PDMA entries, simply remove the
>   * SG_PCI_P2PDMA mark
>   */
> void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> 		int nents, enum dma_data_direction dir, unsigned long attrs)
> {
> 

Ok.

>>   	struct scatterlist *sg;
>>   	int i;
>>   
>> -	for_each_sg(sgl, sg, nents, i)
>> +	for_each_sg(sgl, sg, nents, i) {
>> +		if (sg_is_pci_p2pdma(sg)) {
>> +			sg_unmark_pci_p2pdma(sg);
>> +			continue;
>> +		}
>> +
>>   		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>>   			     attrs);
>> +	}
> 
> The same thing can be achieved with fewer lines and a bit more clarity.
> Can we please do it like this instead:
> 
> 	for_each_sg(sgl, sg, nents, i) {
> 		if (sg_is_pci_p2pdma(sg))
> 			sg_unmark_pci_p2pdma(sg);
> 		else
> 			dma_direct_unmap_page(dev, sg->dma_address,
> 					      sg_dma_len(sg), dir, attrs);
> 	}
> 
> 

That's debatable (the way I did it emphasizes the common case). But I'll
consider changing it.

> 
> Also here, a block comment for the function would be nice. How about
> approximately this:
> 
> /*
>   * Maps each SG segment. Returns the number of entries mapped, or 0 upon
>   * failure. If any entry could not be mapped, then no entries are mapped.
>   */
> 
> I'll stop complaining about the pre-existing return code conventions,
> since by now you know what I was thinking of saying. :)

Not really part of this patchset... Seems like if you think there should
be a comment like that here, you should send a patch. But this patch
starts returning a negative value here.

>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
> 
> Is it worth putting this stuff on the stack--is there a noticeable
> performance improvement from caching the state? Because if it's
> invisible, then simplicity is better. I suspect you're right, and that
> it *is* worth it, but it's good to know for real.
> 
>>   	struct scatterlist *sg;
>> +	int i, ret = 0;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
>> +						     attrs);
>> +			if (ret < 0) {
>> +				goto out_unmap;
>> +			} else if (ret) {
>> +				ret = 0;
>> +				continue;
> 
> Is this a bug? If neither of those "if" branches fires (ret == 0), then
> the code (probably unintentionally) falls through and continues on to
> attempt to call dma_direct_map_page()--despite being a PCI_P2PDMA page!

No, it's not a bug. Per the documentation of pci_p2pdma_map_segment(),
if it returns zero the segment should be mapped normally. P2PDMA pages
must be mapped with physical addresses (or IOVA addresses) if the TLPS
for the transaction will go through the host bridge.

> See below for suggestions:
> 
>> +			}
>> +		}
>> +
>>   		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>>   				sg->offset, sg->length, dir, attrs);
>>   		if (sg->dma_address == DMA_MAPPING_ERROR)
> 
> This is another case in which "continue" is misleading and not as good
> as "else". Because unless I'm wrong above, you really only want to take
> one path *or* the other.

No, per above, it's not one path or the other. If it's a P2PDMA page it
may still need to be mapped normally.

> Also, the "else if (ret)" can be simplified to just setting ret = 0
> unconditionally.

I don't follow. If ret is set, we need to unset it before the end of the
loop.

> Given all that, here's a suggested alternative, which is both shorter
> and clearer, IMHO:
> 
> 	for_each_sg(sgl, sg, nents, i) {
> 		if (is_pci_p2pdma_page(sg_page(sg))) {
> 			ret = pci_p2pdma_map_segment(&p2pdma_state, dev, sg,
> 						     attrs);
> 			if (ret < 0)
> 				goto out_unmap;
> 			else
> 				ret = 0;
> 		} else {
> 			sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
> 					sg->offset, sg->length, dir, attrs);
> 			if (sg->dma_address == DMA_MAPPING_ERROR)
> 				goto out_unmap;
> 			sg_dma_len(sg) = sg->length;
> 		}
> 	}

No, per the comments above, this does not accomplish the same thing and
is not correct.

I'll try to add a comment to the code to make it more clearer. But the
kernel doc on pci_p2pdma_map_segment() does mention what must be done
for different return values explicitly.

Logan
