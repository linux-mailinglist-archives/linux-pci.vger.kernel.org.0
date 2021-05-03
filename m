Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D588371E12
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 19:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbhECRJB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 13:09:01 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58096 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbhECRF0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 13:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=XIo5o0eZ2ybUTNprcEF2/49WtyCaykR1qXGIExijWsM=; b=A4opownLuMAvZjkxn/S5VlDlz4
        qED8iUdb0jEoi6DzG3q5SA7kp8n+oxHLhbgsHmFUrOLUwQFlzg1FKL0fq5PkdsBhHJzqb0XviPegB
        kKRHngxYkYJ0UpPyjCO0lOMylnMndCw8cb5iA/v+hS3jma7ltHNInla8vLysBcmccx983fL/js4MY
        lPvFn13ECitpdcjFVe84V/mNNGwhgHPrgKLAxqbjwODcoPUPBoYb1uT61RMyXvJXAK4g98T3HsqhD
        FQzLgskh7qEpkiRSBuYU5Blwu7PNIvF93A+JxrLASdf+M6KJe0wh6+dC6naKCDSvBhDzOiFHiKtCi
        3JIqatrw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldbzZ-0004qY-4w; Mon, 03 May 2021 11:04:21 -0600
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
Message-ID: <8de928ab-2842-dac9-07ad-a098124f791f@deltatee.com>
Date:   Mon, 3 May 2021 11:04:18 -0600
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

Oops missed a comment:

On 2021-05-02 5:28 p.m., John Hubbard wrote:
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

I haven't measured it (it would be hard to measure), but I think it's
fairly clear here. Without the state, xa_load() would need to be called
on *every* page in an SGL that maps only P2PDMA memory from one device.
With the state, it only needs to be called once. xa_load() is cheap, but
it is not that cheap.

There's essentially the same optimization in get_user_pages for
ZONE_DEVICE pages. So, if it is necessary there, it should be necessary
here.

Logan
