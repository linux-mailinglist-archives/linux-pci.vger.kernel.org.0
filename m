Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1854933C1BB
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhCOQ1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:27:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:49644 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbhCOQ1d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 12:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=m8eFPt4Ky/TIsfccDRiBKAA6Im8fSHoSL1rWmfMykMo=; b=litugTKON8LXh2E4fNWf+tdFsh
        q2CsD9IDYGKKVIawn8gamhxRH644MuufqFWDCKKprPoZHtnAsUpBhIfbDLYsRIwcTEv0TojuuQngh
        9J3WiaV60JpGFYmjOv2GNCbeGl6swiX0xF3BgMcQ26cgzBguK1z1MH20QdPZRSQUkmZ+cHM0b8weO
        nMw1zNo5ZDzrtWTjylir56GRiIHipKmvmqBkHqMQTaNXL2ccxzXkV9uRTIH6IoeArfVAH59w8/LqW
        lQKk+yTetQfXb8ka5Hd5m4l/qqdvdrI67gA7aRHbkH+i+GOkWx0VzhB9jVE/dO+eFCXLyB281bkpf
        Y9mF4fFg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lLq3k-0000KL-25; Mon, 15 Mar 2021 10:27:13 -0600
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
 <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7509243d-b605-953b-6941-72876a60d527@deltatee.com>
Date:   Mon, 15 Mar 2021 10:27:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313013856.GA3402637@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ira.weiny@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-03-12 6:38 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>> DMA map functions to determine how to map a given p2pdma page.
>>
>> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
>> offset if they need to map the bus address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c       | 50 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 11 +++++++++
>>  2 files changed, 61 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 7f6836732bce..66d16b7eb668 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -912,6 +912,56 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
>> + * @page: page to get the offset for
>> + *
>> + * Must be passed a PCI p2pdma page.
>> + */
>> +u64 pci_p2pdma_bus_offset(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
>> +
>> +	WARN_ON(!is_pci_p2pdma_page(page));
> 
> Shouldn't this check be before the to_p2p_pgmap() call?  

The to_p2p_pgmap() call is just doing pointer arithmetic, so strictly
speaking it doesn't need to be before. We just can't access p2p_pgmap
until it has been checked.

> And I've been told not
> to introduce WARN_ON's.  Should this be?
> 
> 	if (!is_pci_p2pdma_page(page))
> 		return -1;

In this case the WARN_ON is just to guard against misuse of the
function. It should never happen unless a developer changes the code in
a way that is incorrect. So I think that's the correct use of WARN_ON.
Though I might change it to WARN and return, that seems safer.

Logan
