Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B9533C1DC
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 17:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCOQba (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 12:31:30 -0400
Received: from ale.deltatee.com ([204.191.154.188]:52164 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhCOQa7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 12:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=TLEEbGguoFgREmZB/3d8+m/o/rHO6SzO5QZnLNcOSh0=; b=LMeid5maXhumpDhtUuT0T2tgJt
        ol9/bEh8ONmQIjUErwM7mTPXZ1CariYnc5Iw/Ra321VFnAuXOc7cZyrF/Oh3deuXUDml8vg4X+V3F
        dm6yEWcub7AMbQD1WI1UonXf5DW+ICkxZ1h5xdC7Ffwv1G0x9MtX7QA2tm/M9hFJ88vXUo1Nzf5SB
        P9kkd0JYhI5ah/y1eBjMZckyn6x/RLEV5sBgyhTRxDlRjDfZtUo+Nai4KkED0ZA0WOzqD0D2RtvCY
        S73e1NapCyNIPKDTwXar4Oz8rXKqzNZzn5eBvlCnYkJL+tXFA0w2raNvLWazJGM9RhSj7JUIcCIZd
        r2qI+iiw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lLq7B-0000Mv-Jy; Mon, 15 Mar 2021 10:30:46 -0600
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
 <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d34a2035-6077-8070-ea2c-b62a4a65422c@deltatee.com>
Date:   Mon, 15 Mar 2021 10:30:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
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



On 2021-03-12 7:32 p.m., Ira Weiny wrote:
> On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
>> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
>             ^^^^^^^^^^^^^^^^^^^^^^^^^
> 	    pci_p2pdma_dma_map_type() ???
> 
> FWIW I find this name confusing with pci_p2pdma_map_type() and looking at the
> implementation I'm not clear why pci_p2pdma_dma_map_type() needs to exist?

Yeah, there are subtle differences in prototype. But yes, they can
probably be combined. Will do for future postings.

>> + * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
>> + *	bus address, be mapped normally or fail
>> + * @dev: device doing the DMA request
>> + * @pgmap: dev_pagemap structure for the mapping
>> + *
>> + * Returns:
>> + *    1 - if the page should be mapped with a bus address,
>> + *    0 - if the page should be mapped normally through an IOMMU mapping or
>> + *        physical address; or
>> + *   -1 - if the device should not map the pages and an error should be
>> + *        returned
>> + */
>> +int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
>> +{
>> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
>> +	struct pci_dev *client;
>> +
>> +	if (!dev_is_pci(dev))
>> +		return -1;
>> +
>> +	client = to_pci_dev(dev);
>> +
>> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
>> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>> +		return 0;
>> +	case PCI_P2PDMA_MAP_BUS_ADDR:
>> +		return 1;
>> +	default:
>> +		return -1;
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);
> 
> I guess the main point here is to export this to the DMA layer?

Yes, that's correct.

Logan
