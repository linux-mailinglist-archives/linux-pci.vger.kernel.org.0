Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E9F36CEFA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 00:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhD0W4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 18:56:55 -0400
Received: from ale.deltatee.com ([204.191.154.188]:42710 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbhD0W4x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 18:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=9cMqKeVqpV09cXzdKEdeF1wGWj3NSvz6cLLXzNXUCD8=; b=bZ0qGVskfkWJrx7xQzfuMkoJWn
        uXsbXCfWUy5H+XPJj218MIPSekFTaV56i4dZC9FFheUYyXLbwiAPhK3Bq+k3tBDvz0B7hbOVfR/Pw
        rU0TsIsdHTeMVZuRSJHe4unPK2tJx/470PpEKYmwqqNM5SMKswk4DlpwIILF3MrN0C47OMfdXi5S2
        BmumlWMKxYppg3kVyzDdH2wUlAdUddF9ynHCOu6+qhXaeoKWzLwiJNa8Oc5YWsvB9LSQXNNpokW3c
        /UfXKIphBb3KBrtAfzVBu1rR4lQSws2cuqBfu3uWRWvY4NniZl2lxAPi8Nr5LTxNRFv7wpixJqrf/
        2mQpmzmw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lbWcM-0002ln-Cs; Tue, 27 Apr 2021 16:55:47 -0600
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
 <20210427193157.GQ2047089@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com>
Date:   Tue, 27 Apr 2021 16:55:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427193157.GQ2047089@ziepe.ca>
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
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-04-27 1:31 p.m., Jason Gunthorpe wrote:
> On Thu, Apr 08, 2021 at 11:01:12AM -0600, Logan Gunthorpe wrote:
>> +/*
>> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
>> + * It should never return a value < 0.
>> + */
> 
> Also it is weird a function that can't return 0 is returning an int type

Yes, Christoph mentioned in the last series that this should probably
change to an unsigned but I wasn't really sure if that change should be
a part of the P2PDMA series.

>> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>> +		enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	int ents;
>> +
>> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>>  	BUG_ON(ents < 0);
> 
> if (WARN_ON(ents < 0))
>      return 0;
> 
> instead of bug on?

It was BUG_ON in the original code. So I felt I should leave it.

> Also, I see only 8 users of this function. How about just fix them all
> to support negative returns and use this as the p2p API instead of
> adding new API?

Well there might be 8 users of dma_map_sg_attrs() but there are a very
large number of dma_map_sg(). Seems odd to me to single out the first as
requiring these changes, but leave the latter.

> Add the opposite logic flag, 'DMA_ATTRS_NO_ERROR' and pass it through
> the other api entry callers that can't handle it?

I'm not that opposed to this. But it will make this series a fair bit
longer to change the 8 map_sg_attrs() usages.

Logan
