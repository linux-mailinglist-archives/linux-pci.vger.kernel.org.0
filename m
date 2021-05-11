Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6D437ABB6
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEKQUT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:20:19 -0400
Received: from ale.deltatee.com ([204.191.154.188]:53854 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbhEKQUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=KRREYiID4nTLAcd30iCtMu5qS4tYGdizddy6etGFynA=; b=QX2vn+ZSnkNIea3oIqxWCrg9tp
        n1sCb9KHpJoIaRXdY0nYk+A55R5+bJzf7lAUrmRIP+9tYXPMAY9zVdmvTrY8Zi4CN+nP4mJCwlXNi
        9EpP4/ubF7Zt56WkMmsltDxbS59EjBO3rKE9BgbNkI4JufYuR4lLRmoNsuerG4uBi5CFZyekeuaGh
        adS2eOEVb6LeYpnv785vjeHILX6oPibI9iYigpRsbyKCGjWpq95W7BYMUn3Ez26qYJDbXa8bQ4t+g
        9GEhUUbscgDYfAy9KDF7uFUAETOgR5Z55BuzayN3e/GMBH3ziI+KwOOahICDS35fDS9iJbAZ4bRN1
        OGZR8Z+g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lgV65-0006go-Tm; Tue, 11 May 2021 10:19:02 -0600
To:     Don Dutile <ddutile@redhat.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
 <20210408170123.8788-11-logang@deltatee.com>
 <92704199-4cee-3811-3902-08ccf6cc1f5f@redhat.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <185f39c0-d71c-5d24-9d87-951a72c3532d@deltatee.com>
Date:   Tue, 11 May 2021 10:19:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <92704199-4cee-3811-3902-08ccf6cc1f5f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ddutile@redhat.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-11 10:06 a.m., Don Dutile wrote:
> On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
>> Add a flags member to the dma_map_ops structure with one flag to
>> indicate support for PCI P2PDMA.
>>
>> Also, add a helper to check if a device supports PCI P2PDMA.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   include/linux/dma-map-ops.h |  3 +++
>>   include/linux/dma-mapping.h |  5 +++++
>>   kernel/dma/mapping.c        | 18 ++++++++++++++++++
>>   3 files changed, 26 insertions(+)
>>
>> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
>> index 51872e736e7b..481892822104 100644
>> --- a/include/linux/dma-map-ops.h
>> +++ b/include/linux/dma-map-ops.h
>> @@ -12,6 +12,9 @@
>>   struct cma;
>>   
>>   struct dma_map_ops {
>> +	unsigned int flags;
>> +#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
>> +
> I'm not a fan of in-line define's; if we're going to add a flags field to the dma-ops
> -- and logically it'd be good to have p2pdma go through the dma-ops struct --
> then let's move this up in front of the dma-ops description.

Already changed for v2.

> And now that the dma-ops struct is being 'opened' for p2pdma, should p2pdma ops be added
> to this struct, so all this work can be mimic'd/reflected/leveraged/refactored for CXL, GenZ, etc. p2pdma in (the near?) future?

v2 no longer has a specific op for p2pdma. We are now using
dma_map_sgtable() which already has the error return we need.

I think any work to support CXL, GenZ, etc will need to be done when
they add their own support. I can't and shouldn't guess at their needs now.

Logan
