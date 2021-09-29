Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7941CDFE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbhI2V2H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:28:07 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58868 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhI2V2H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 17:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=nHl0IFgZgGpHvQgDpFAFAHI5VsGy7jlQRmnLx5A/xGM=; b=MCqUG28cCMzBbE1ij1ryNHEwuG
        vmZLEFq36tbkkbW136PBApl58FA1BmBPgQBO7Vy0W5ociLCy71GucZmvTbS4ZuGIJP9zwEllXw+LA
        UGWft03gK6gOYJgiD+dsK/1kgwTomHkZqRxsyNczjso4P1gx3Ij1JXLnu2IapCBmayItQTHeNpkS/
        DC6lggy8f7brCrKZtAqlb9CtUK1brfum4Ak2xaHEFeqKv/j0gS2y0/htYjsguEkp+SDSmGZN8QDmG
        6sMtXlUKlXg7yhYmw6GAdVCKl32z3ozsNy2BN4wHpD3K1QOk50H6mu+nC38p2AFa0sDw+7jDyE4cU
        jR2cdMMg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1mVh5f-0006Ii-Sf; Wed, 29 Sep 2021 15:26:13 -0600
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
 <20210916234100.122368-5-logang@deltatee.com>
 <20210928185552.GL3544071@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <907b0cd9-84b7-c6ef-30b3-3f52f2e0e5ba@deltatee.com>
Date:   Wed, 29 Sep 2021 15:26:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928185552.GL3544071@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-09-28 12:55 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
>> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
>> implementations. It takes an scatterlist segment that must point to a
>> pci_p2pdma struct page and will map it if the mapping requires a bus
>> address.
>>
>> The return value indicates whether the mapping required a bus address
>> or whether the caller still needs to map the segment normally. If the
>> segment should not be mapped, -EREMOTEIO is returned.
>>
>> This helper uses a state structure to track the changes to the
>> pgmap across calls and avoid needing to lookup into the xarray for
>> every page.
>>
>> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
>> dma_map_sg() implementations where the sg segment containing the page
>> differs from the sg segment containing the DMA address.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>>  2 files changed, 80 insertions(+)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index b656d8c801a7..58c34f1f1473 100644
>> +++ b/drivers/pci/p2pdma.c
>> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>>  }
>>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>>  
>> +/**
>> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
>> + * @state: State structure that should be declared outside of the for_each_sg()
>> + *	loop and initialized to zero.
>> + * @dev: DMA device that's doing the mapping operation
>> + * @sg: scatterlist segment to map
>> + *
>> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
>> + * the sg segment is the same for the page_link and the dma_address.
>> + *
>> + * Attempt to map a single segment in an SGL with the PCI bus address.
>> + * The segment must point to a PCI P2PDMA page and thus must be
>> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
>> + *
>> + * Returns the type of mapping used and maps the page if the type is
>> + * PCI_P2PDMA_MAP_BUS_ADDR.
>> + */
>> +enum pci_p2pdma_map_type
>> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
>> +		       struct scatterlist *sg)
>> +{
>> +	if (state->pgmap != sg_page(sg)->pgmap) {
>> +		state->pgmap = sg_page(sg)->pgmap;
>> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
>> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
>> +	}
> 
> Is this safe? I was just talking with Joao about this,
> 
>  https://lore.kernel.org/r/20210928180150.GI3544071@ziepe.ca
> 

I agree that taking the extra reference on the pagemap seems
unnecessary. However, it was convenient for the purposes of this
patchset to not have to check the page type for every page and only on
every new page map. But if we need to add a check directly to gup,
that'd probably be fine too.

> API wise I absolutely think this should be safe as written, but is it
> really?
> 
> Does pgmap ensure that a positive refcount struct page always has a
> valid pgmap pointer (and thus the mess in gup can be deleted) or does
> this need to get the pgmap as well to keep it alive?

Yes, the P2PDMA code ensures that the pgmap will not be deleted if there
is a positive refcount on any struct page.

LOgan
