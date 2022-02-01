Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD034A66AB
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 21:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiBAU5j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 15:57:39 -0500
Received: from ale.deltatee.com ([204.191.154.188]:57830 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBAU5i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 15:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=cJSKxOJIzFWJNB/4kEdPj9SAYSFCsRpghMAEka+ai04=; b=inRrrLF05DauLsozmFhswOyT+U
        WPSDQkzNTcNkRZ8czrnUNGLopNg88HLX9pdCK4UlXF1bzYf1BKgtsKpvGypPta7CHlcUOku9K9vge
        +NAO35wcF3CTICM/mBTLmVIVzczzqTvX+VVkIJTevRDS2LfYWgy1a6+2EUp3AAiQR5ChqflV0MWso
        oxckJk6HwJ98oVn/PvRLw3x09cOhCMFDyStF8NnTcjdXZ77YjfG+lzhwmhLo1H71ALY2CJFwigpj+
        UdeGbDqFGDIIDyWwb0VsLflcq8qGQM/ErCZ1YgjT6Xi6D86QbJbPGca8MIAn8BpFKQVINH97Ks3w6
        NHJute4A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1nF0D7-009dre-2I; Tue, 01 Feb 2022 13:57:10 -0700
To:     Jonathan Derrick <jonathan.derrick@linux.dev>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-9-logang@deltatee.com>
 <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bd83b26d-2f35-cd0a-bb20-a4626d8d48a7@deltatee.com>
Date:   Tue, 1 Feb 2022 13:57:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <6c939012-8d68-fbb5-50c6-3fe757a31b48@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jonathan.derrick@linux.dev
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v5 08/24] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2022-02-01 1:53 p.m., Jonathan Derrick wrote:
> 
> 
> On 1/27/2022 5:25 PM, Logan Gunthorpe wrote:
>> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
>> PCI P2PDMA pages directly without a hack in the callers. This allows
>> for heterogeneous SGLs that contain both P2PDMA and regular pages.
>>
>> A P2PDMA page may have three possible outcomes when being mapped:
>>    1) If the data path between the two devices doesn't go through the
>>       root port, then it should be mapped with a PCI bus address
>>    2) If the data path goes through the host bridge, it should be mapped
>>       normally, as though it were a CPU physical address
>>    3) It is not possible for the two devices to communicate and thus
>>       the mapping operation should fail (and it will return -EREMOTEIO).
>>
>> SGL segments that contain PCI bus addresses are marked with
>> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
>>
>> P2PDMA mappings are also failed if swiotlb needs to be used on the
>> mapping.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   kernel/dma/direct.c | 43 +++++++++++++++++++++++++++++++++++++------
>>   kernel/dma/direct.h |  7 ++++++-
>>   2 files changed, 43 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
>> index 50f48e9e4598..975df5f3aaf9 100644
>> --- a/kernel/dma/direct.c
>> +++ b/kernel/dma/direct.c
>> @@ -461,29 +461,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>>   		arch_sync_dma_for_cpu_all();
>>   }
>>   
>> +/*
>> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
>> + * require any further action as they contain a bus address.
>> + */
>>   void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>>   		int nents, enum dma_data_direction dir, unsigned long attrs)
>>   {
>>   	struct scatterlist *sg;
>>   	int i;
>>   
>> -	for_each_sg(sgl, sg, nents, i)
>> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
>> -			     attrs);
>> +	for_each_sg(sgl,  sg, nents, i) {
>> +		if (sg_is_dma_bus_address(sg))
>> +			sg_dma_unmark_bus_address(sg);
>> +		else
>> +			dma_direct_unmap_page(dev, sg->dma_address,
>> +					      sg_dma_len(sg), dir, attrs);
>> +	}
>>   }
>>   #endif
>>   
>>   int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>>   		enum dma_data_direction dir, unsigned long attrs)
>>   {
>> -	int i;
>> +	struct pci_p2pdma_map_state p2pdma_state = {};
>> +	enum pci_p2pdma_map_type map;
>>   	struct scatterlist *sg;
>> +	int i, ret;
>>   
>>   	for_each_sg(sgl, sg, nents, i) {
>> +		if (is_pci_p2pdma_page(sg_page(sg))) {
>> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
>> +			switch (map) {
>> +			case PCI_P2PDMA_MAP_BUS_ADDR:
>> +				continue;
>> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +				/*
>> +				 * Any P2P mapping that traverses the PCI
>> +				 * host bridge must be mapped with CPU physical
>> +				 * address and not PCI bus addresses. This is
>> +				 * done with dma_direct_map_page() below.
>> +				 */
>> +				break;
>> +			default:
>> +				ret = -EREMOTEIO;
>> +				goto out_unmap;
>> +			}
>> +		}
> I'm a little confused about this code. Would there be a case where the mapping needs
> to be checked for each sg in the list? And if some sg in the sgl can be mapped
> differently, would we want to continue checking the rest of the sg in the sgl instead
> of breaking out of the loop completely?

Yes, the code supports heterogeneous SGLs with P2PDMA and regular
memory; it's also theoretically possible to mix P2PDMA memory for
different devices. So yes, the mapping must be checked for every SG in
the list. It can't just see one SG that points to P2PDMA memory and
assume the rest are all good.

Logan
