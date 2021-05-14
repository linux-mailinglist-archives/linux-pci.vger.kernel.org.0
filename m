Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9181380E08
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhENQTK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 12:19:10 -0400
Received: from ale.deltatee.com ([204.191.154.188]:60826 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhENQTJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 May 2021 12:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=UIw7EfWmD3A5GJzYN/3QOUOCIyHuFu16FWOPf7ANc9Y=; b=ifFUHGd+/63UwWC7Lc9/oor7EB
        2xjO0Kj1AlFEpeDAwbOKeW8D81UORdDKkPxs7CF9lZHYha50YtQkAW8SwcBLPjO/SrcXyl30YTRho
        MbfBoG89yDCZm/Gp8aa++DAJcvdvSRYMC7EbFLh8FinG05Ku9EKpgWTM/v4BVl4jTXyWC3/LqjVgu
        bdtOV6sJX1hy0+oEpb6EvH7KJiIfkE8Gl1VaVjCNeplN1uBeqW+034RUscz+xQLCn+ISPdE0nf+rC
        ggxbKXYoIRATTWu1GzOpzi2ZHRBR0QVMYKgJfXEoeRUmTpW6t1lgOr2s3tTG29i7Rquf1zkW1OwXB
        T6ym8TIw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lhaVY-000693-Pi; Fri, 14 May 2021 10:17:49 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-16-logang@deltatee.com> <20210514135712.GD4715@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6615c351-9c28-3a74-8c43-4aeb7993fb98@deltatee.com>
Date:   Fri, 14 May 2021 10:17:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210514135712.GD4715@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v2 15/22] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-14 7:57 a.m., Christoph Hellwig wrote:
>> +	for_each_sg(sgl, sg, nents, i) {
>> +		if (sg_is_dma_pci_p2pdma(sg)) {
>> +			sg_dma_unmark_pci_p2pdma(sg);
>> +		} else  {
> 
> Double space here.  We also don't really need the curly braces to start
> with.
> 
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>  	struct scatterlist *sg;
>> +	int i, ret;
>>  
>>  	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
> 
> Why not just:
> 
> 			switch (pci_p2pdma_map_segment(&p2pdma_state, dev,
> 					sg)) {
> 
> (even better with a shorter name for p2pdma_state so that it all fits on
> a single line)?
> 
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Mapping through host bridge should be
>> +				 * mapped normally, thus we do nothing
>> +				 * and continue below.
>> +				 */
> 
> I have a bit of a hard time parsing this comment.
> 
>> +		if (sg->dma_address == DMA_MAPPING_ERROR) {
>> +			ret = -EINVAL;
>>  			goto out_unmap;
>> +		}
>>  		sg_dma_len(sg) = sg->length;
>>  	}
>>  
>> @@ -411,7 +443,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>  
>>  out_unmap:
>>  	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
>> -	return -EINVAL;
>> +	return ret;
> 
> Maybe just initialize ret to -EINVAL at declaration time to simplify this
> a bit?
>

All fair points, will fix in v3.

Logan
