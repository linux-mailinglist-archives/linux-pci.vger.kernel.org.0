Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF6736CEFD
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 00:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239127AbhD0W5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 18:57:05 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42750 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239079AbhD0W5F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 18:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=wchQRjaAM+wKsrfBxsOPGilEcofAMBFmBR5ncEuDJho=; b=EZ9ht7CInMnHYcsaW5R8aYmMj8
        09YKECmF6J1dtTcoVOL5n2vPnyFNuRfpmprAgXcM6moL4NCgJapVcFrAT1GmK88ZLOtBdgfU20kW0
        RY5WUjwcQBwsrdUL/HEpU3IS5o0FdSpggofru2z8+77w/Q3RnCRgS0wmH1jea1qn6LdToqi4OZ/4X
        rrypsgRTfhC4D/uJIb+BWvm1Uqf3s8+RISCE2/zVjkKMttAX0hK4dVgX2qSTi/K1a5II8R6cm3X27
        wVPZcln5l7w31LXIB1N6D4Cr8zR08kHA3166WgpMkT/o5LCOPvawHT2vKIJITGvqFOCPEE8VRwxVk
        JkwiHqmg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lbWcl-0002mT-O1; Tue, 27 Apr 2021 16:56:12 -0600
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
 <20210408170123.8788-10-logang@deltatee.com>
 <20210427193351.GR2047089@ziepe.ca> <20210427194013.GS2047089@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9835b877-25ba-83f8-ed39-999cfc1ad415@deltatee.com>
Date:   Tue, 27 Apr 2021 16:56:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427194013.GS2047089@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 1:40 p.m., Jason Gunthorpe wrote:
> On Tue, Apr 27, 2021 at 04:33:51PM -0300, Jason Gunthorpe wrote:
>> On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
>>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>>> PCI P2PDMA pages directly without a hack in the callers. This allows
>>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>>
>>> SGL segments that contain PCI bus addresses are marked with
>>> sg_mark_pci_p2pdma() and are ignored when unmapped.
>>>
>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>>> index 002268262c9a..108dfb4ecbd5 100644
>>> +++ b/kernel/dma/direct.c
>>> @@ -13,6 +13,7 @@
>>>  #include <linux/vmalloc.h>
>>>  #include <linux/set_memory.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/pci-p2pdma.h>
>>>  #include "direct.h"
>>>  
>>>  /*
>>> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>>  	struct scatterlist *sg;
>>>  	int i;
>>>  
>>> -	for_each_sg(sgl, sg, nents, i)
>>> +	for_each_sg(sgl, sg, nents, i) {
>>> +		if (sg_is_pci_p2pdma(sg)) {
>>> +			sg_unmark_pci_p2pdma(sg);
>>
>> This doesn't seem nice, the DMA layer should only alter the DMA
>> portion of the SG, not the other portions. Is it necessary?
> 
> Oh, I got it completely wrong what this is for.
> 
> This should be named sg_dma_mark_pci_p2p() and similar for other
> functions to make it clear it is part of the DMA side of the SG
> interface (eg it is like sg_dma_address, sg_dma_len, etc)

Fair point. Yes, I'll rename this for the next version.

Logan
