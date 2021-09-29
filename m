Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F9A41CDE4
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346874AbhI2VR5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:17:57 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58738 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhI2VR4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:17:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=RfrWfjCRN+UowtRVbNA3b2L6enFhSnjdcCuQt0d3QdI=; b=sx8iDLgZqm9oV/jPtvYl6hWxOJ
        izKJEIZpDyBIKLWz8FDerUW5k2MT7pPtfUTyZiEU6bE7HoV7pneW/CZR2zMIxsytGbyq8vFegsKGv
        49LSCi3qE6cFcuu3ANDMzF0wHUfqas6dQodjbfxt/8zHWnBhP9N8kOEENBNUjLrsTXNl90Sahn8H0
        HAUhhk1jLu1tfiA5AYOXEg4lkZh0pmHiPlunotwWT39n20HVUlZzMB6xXhNwz+2qZPfnc/8Ia0J5E
        FZIAlxHcWmAecE99N9j4B2rg3AG9XIO/VHcG1DdeZNocY4lVPpt+WxirDMZKAHuss1OBzFQ0yFB23
        svZcaJZQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVgvW-0006Bq-H1; Wed, 29 Sep 2021 15:15:43 -0600
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-2-logang@deltatee.com>
 <20210928183219.GJ3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3f3abc6b-0a80-dbb6-f9dc-8a4cc33c975c@deltatee.com>
Date:   Wed, 29 Sep 2021 15:15:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928183219.GJ3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,NICE_REPLY_A autolearn=ham
        autolearn_force=no version=3.4.2
Subject: Re: [PATCH v3 01/20] lib/scatterlist: add flag for indicating P2PDMA
 segments in an SGL
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-28 12:32 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:41PM -0600, Logan Gunthorpe wrote:
>>  config PCI_P2PDMA
>>  	bool "PCI peer-to-peer transfer support"
>> -	depends on ZONE_DEVICE
>> +	depends on ZONE_DEVICE && 64BIT
> 
> Perhaps a comment to explain what the 64bit is doing?

Added.

>>  	select GENERIC_ALLOCATOR
>>  	help
>>  	  Enableѕ drivers to do PCI peer-to-peer transactions to and from
>> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
>> index 266754a55327..e62b1cf6386f 100644
>> +++ b/include/linux/scatterlist.h
>> @@ -64,6 +64,21 @@ struct sg_append_table {
>>  #define SG_CHAIN	0x01UL
>>  #define SG_END		0x02UL
>>  
>> +/*
>> + * bit 2 is the third free bit in the page_link on 64bit systems which
>> + * is used by dma_unmap_sg() to determine if the dma_address is a PCI
>> + * bus address when doing P2PDMA.
>> + * Note: CONFIG_PCI_P2PDMA depends on CONFIG_64BIT because of this.
>> + */
>> +
>> +#ifdef CONFIG_PCI_P2PDMA
>> +#define SG_DMA_PCI_P2PDMA	0x04UL
> 
> Add a 
> 	static_assert(__alignof__(void *) == 8);
> 
> ?

Good idea. Though, I think your line isn't quite correct. I've added:

static_assert(__alignof__(struct page) >= 8);

>> +#define sg_is_dma_pci_p2pdma(sg) ((sg)->page_link & SG_DMA_PCI_P2PDMA)
> 
> I've been encouraging people to use static inlines more..

I also prefer static inlines, but I usually follow the style of the code
I'm changing. In any case, I've changed to static inlines similar to
your example.

>>  /**
>>   * sg_assign_page - Assign a given page to an SG entry
>> @@ -86,13 +103,13 @@ struct sg_append_table {
>>   **/
>>  static inline void sg_assign_page(struct scatterlist *sg, struct page *page)
>>  {
>> -	unsigned long page_link = sg->page_link & (SG_CHAIN | SG_END);
>> +	unsigned long page_link = sg->page_link & SG_PAGE_LINK_MASK;
> 
> I think this should just be '& SG_END', sg_assign_page() doesn't look
> like it should ever be used on a sg_chain entry, so this is just
> trying to preserve the end stamp.

Perhaps, but I'm not comfortable making that change in this patch or
series. Though, I've reverted this specific change in my patch so
sg_assign_page() will clear SG_DMA_PCI_P2PDMA.

Logan
