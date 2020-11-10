Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72CAA2AE443
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 00:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgKJXme (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Nov 2020 18:42:34 -0500
Received: from ale.deltatee.com ([204.191.154.188]:47714 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbgKJXm1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Nov 2020 18:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dq7zEId0NdZdINMNT6Dmw/UdigbwtVpJA5sVRfmfofg=; b=OGkZy1Uyl96LErvRAxZGS3VLh2
        UFPnmL68iQiGa7WAKcronB92llBdP3YlqIU+7eGuFKbqGjkT01WWufQfvYhwJQWb5f4Chtvv5u50S
        ehGDDouQf07lLymZnuvKlNikGX0MG5kw18tbF+W0I0l1dYdqjxKHukHshhL/MTMWuMcU1rwtN+iYD
        MX/dMQFi6k6B6yzwa4oKcYK28+bCU9oc5m4af9qikpCqZDiTpCgHOzow/uqJ6YsHG16ieCLyHb+Qi
        Uefg2Nrk14j0VCvqrjysb0S8rgDpYRYKseTyjfXOJtFFb2JZ0gOPhivVU3VIxjdTMfibx68jS04pG
        vJLX6QZg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kcdH8-0000kz-29; Tue, 10 Nov 2020 16:42:11 -0700
To:     Bjorn Helgaas <helgaas@kernel.org>
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
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20201110232513.GA705726@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b3918b58-1c46-4f9c-fcae-37fd47b6bfde@deltatee.com>
Date:   Tue, 10 Nov 2020 16:42:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201110232513.GA705726@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 03/15] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-11-10 4:25 p.m., Bjorn Helgaas wrote:
> On Fri, Nov 06, 2020 at 10:00:24AM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>> dma map functions to determine how to map a given p2pdma page.
> 
> s/dma/DMA/ for consistency (also below in function comment)
> 
>> pci_p2pdma_bus_offset() is also added to allow callers to get the bus
>> offset if they need to map the bus address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  drivers/pci/p2pdma.c       | 46 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 11 +++++++++
>>  2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index ea8472278b11..9961e779f430 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -930,6 +930,52 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_bus_offset - returns the bus offset for a given page
>> + * @page: page to get the offset for
>> + *
>> + * Must be passed a pci p2pdma page.
> 
> s/pci/PCI/
> 
>> + */
>> +u64 pci_p2pdma_bus_offset(struct page *page)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(page->pgmap);
>> +
>> +	WARN_ON(!is_pci_p2pdma_page(page));
>> +
>> +	return p2p_pgmap->bus_offset;
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_bus_offset);
>> +
>> +/**
>> + * pci_p2pdma_should_map_bus - determine if a dma mapping should use the
>> + *	bus address
>> + * @dev: device doing the DMA request
>> + * @pgmap: dev_pagemap structure for the mapping
>> + *
>> + * Returns 1 if the page should be mapped with a bus address, 0 otherwise
>> + * and -1 the device should not be mapping P2PDMA pages.
> 
> I think this is missing a word.
> 
> I'm not really sure how to interpret the "should" in
> pci_p2pdma_should_map_bus().  If this returns -1, does that mean the
> patches *cannot* be mapped?  They *could* be mapped, but you really
> *shouldn't*?  Something else?
> 
> 1 means page should be mapped with bus address.  0 means ... what,
> exactly?  It should be mapped with some different address?

1 means it must be mapped with a bus address
0 means it may be mapped normally (through the IOMMU or just with a
direct physical address)
-1 means it cannot be mapped and should fail (ie. if it must go through
the IOMMU, but the IOMMU is not in the whitelist).

> Sorry these are naive questions because I don't know how all this
> works.

Thanks for the review. Definitely points out some questionable language
that I used. I'll reword this if/when it goes further.

Logan

