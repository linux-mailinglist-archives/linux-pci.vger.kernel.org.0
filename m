Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276BD371B0D
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 18:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhECQnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 12:43:10 -0400
Received: from ale.deltatee.com ([204.191.154.188]:57712 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbhECQk7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 12:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=f3Yr8sCXxE6UDrZoKKM6KXdKnffWXsnxW1/wIjh8k4A=; b=KEBNlEo7fZE8oPSxjxUqE7MmyT
        127yU5GY+VbA0DuEsKtpgx7QIgzkFQHqXPgY9U0COrkNxD66a5bIJIo1pfD0XYxRz6DvC2BQHPrPj
        eL4xUpcfQzpRIIJ/Y7WBM96E9w9oCFIfUY8grm9AeAmMeMtk4c6ieeoJb2bz1mdkFiuWyEzB8BRPm
        stRVyubPxgtevJySALuOfdPQk0ykwr7G5kqAO9LSV7h7O6tyiZ/S2SuuoVNffPgaXyXDMPHhoIBq1
        0nrgSmo8NrgcGPW6+bz50YQknsxlCNblp2Ogz1cUQWF2cEw0Eu7bXo5Q5eYWVgbOrbBfd9eHVDK3c
        6xtpL6VA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldbbu-0004G9-Ev; Mon, 03 May 2021 10:39:55 -0600
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
 <20210408170123.8788-8-logang@deltatee.com>
 <c2712ed0-6d44-014a-f669-dfda63d1c861@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <31b17b7d-f6de-c205-d1a3-e570928605f4@deltatee.com>
Date:   Mon, 3 May 2021 10:39:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <c2712ed0-6d44-014a-f669-dfda63d1c861@nvidia.com>
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
Subject: Re: [PATCH 07/16] PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-02 4:44 p.m., John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> pci_p2pdma_map_type() will be needed by the dma-iommu map_sg
>> implementation because it will need to determine the mapping type
>> ahead of actually doing the mapping to create the actual iommu mapping.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c       | 34 +++++++++++++++++++++++-----------
>>   include/linux/pci-p2pdma.h | 15 +++++++++++++++
>>   2 files changed, 38 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bcb1a6d6119d..38c93f57a941 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -20,13 +20,6 @@
>>   #include <linux/seq_buf.h>
>>   #include <linux/xarray.h>
>>   
>> -enum pci_p2pdma_map_type {
>> -	PCI_P2PDMA_MAP_UNKNOWN = 0,
>> -	PCI_P2PDMA_MAP_NOT_SUPPORTED,
>> -	PCI_P2PDMA_MAP_BUS_ADDR,
>> -	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE,
>> -};
>> -
>>   struct pci_p2pdma {
>>   	struct gen_pool *pool;
>>   	bool p2pmem_published;
>> @@ -822,13 +815,30 @@ void pci_p2pmem_publish(struct pci_dev *pdev, bool publish)
>>   }
>>   EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>>   
>> -static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>> -						    struct device *dev)
>> +/**
>> + * pci_p2pdma_map_type - return the type of mapping that should be used for
>> + *	a given device and pgmap
>> + * @pgmap: the pagemap of a page to determine the mapping type for
>> + * @dev: device that is mapping the page
>> + * @dma_attrs: the attributes passed to the dma_map operation --
>> + *	this is so they can be checked to ensure P2PDMA pages were not
>> + *	introduced into an incorrect interface (like dma_map_sg). *
>> + *
>> + * Returns one of:
>> + *	PCI_P2PDMA_MAP_NOT_SUPPORTED - The mapping should not be done
>> + *	PCI_P2PDMA_MAP_BUS_ADDR - The mapping should use the PCI bus address
>> + *	PCI_P2PDMA_MAP_THRU_HOST_BRIDGE - The mapping should be done directly
>> + */
>> +enum pci_p2pdma_map_type pci_p2pdma_map_type(struct dev_pagemap *pgmap,
>> +		struct device *dev, unsigned long dma_attrs)
>>   {
>>   	struct pci_dev *provider = to_p2p_pgmap(pgmap)->provider;
>>   	enum pci_p2pdma_map_type ret;
>>   	struct pci_dev *client;
>>   
>> +	WARN_ONCE(!(dma_attrs & __DMA_ATTR_PCI_P2PDMA),
>> +		  "PCI P2PDMA pages were mapped with dma_map_sg!");
> 
> This really ought to also return -EINVAL, assuming that my review suggestions
> about return types, in earlier patches, are acceptable.

That can't happen because, by convention, dma_map_sg() cannot return
-EINVAL. I think the best we can do is proceed normally and just warn
loudly.

Logan
