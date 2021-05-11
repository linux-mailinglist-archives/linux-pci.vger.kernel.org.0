Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A937AB64
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbhEKQHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231608AbhEKQHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7EwSkK3tCLzSwRdZ/4L1eSG5xJr+ckvT0VIiRU+l0cU=;
        b=RRvRHbmbxET52B94rLfyLWA8VI/sj7BAiVOkiqleREuLvTpvjb9d0RvALNxo7okcxPLnuQ
        jJ60IvnCQpEYcPmFAKPicN3qrQSkbR7CpP8tLkPh0Y+eJC3cVYCG+Ty9DQZ44KgUq2Wv1g
        cFScQ1npht2uChqH5Qo8kMNr2eDqdxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-FaCNBf4dPAaCfsJb1OSVVQ-1; Tue, 11 May 2021 12:05:57 -0400
X-MC-Unique: FaCNBf4dPAaCfsJb1OSVVQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92A21854E27;
        Tue, 11 May 2021 16:05:52 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 717785D9F2;
        Tue, 11 May 2021 16:05:50 +0000 (UTC)
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has not
 been set
To:     John Hubbard <jhubbard@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <87a2b8e9-f0ef-ec23-8427-3022a86b0ec5@redhat.com>
Date:   Tue, 11 May 2021 12:05:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/2/21 3:58 PM, John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> Attempt to find the mapping type for P2PDMA pages on the first
>> DMA map attempt if it has not been done ahead of time.
>>
>> Previously, the mapping type was expected to be calculated ahead of
>> time, but if pages are to come from userspace then there's no
>> way to ensure the path was checked ahead of time.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 473a08940fbc..2574a062a255 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -825,11 +825,18 @@ EXPORT_SYMBOL_GPL(pci_p2pmem_publish);
>>   static enum pci_p2pdma_map_type pci_p2pdma_map_type(struct pci_dev *provider,
>>                               struct pci_dev *client)
>>   {
>> +    enum pci_p2pdma_map_type ret;
>> +
>>       if (!provider->p2pdma)
>>           return PCI_P2PDMA_MAP_NOT_SUPPORTED;
>>   -    return xa_to_value(xa_load(&provider->p2pdma->map_types,
>> -                   map_types_idx(client)));
>> +    ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
>> +                  map_types_idx(client)));
>> +    if (ret != PCI_P2PDMA_MAP_UNKNOWN)
>> +        return ret;
>> +
>> +    return upstream_bridge_distance_warn(provider, client, NULL,
>> +                         GFP_ATOMIC);
>
> Returning a "bridge distance" from a "get map type" routine is jarring,
> and I think it is because of a pre-existing problem: the above function
> is severely misnamed. Let's try renaming it (and the other one) to
> approximately:
>
>     upstream_bridge_map_type_warn()
>     upstream_bridge_map_type()
>
> ...and that should fix that. Well, that, plus tweaking the kernel doc
> comments, which are also confused. I think someone started off thinking
> about distances through PCIe, but in the end, the routine boils down to
> just a few situations that are not distances at all.
>
+1. didn't like the 'distance' check  for a 'connection check" in the beginning, and looks like this is the time to clean it out.
:)

> Also, the above will read a little better if it is written like this:
>
>     ret = xa_to_value(xa_load(&provider->p2pdma->map_types,
>                   map_types_idx(client)));
>
>     if (ret == PCI_P2PDMA_MAP_UNKNOWN)
>         ret = upstream_bridge_map_type_warn(provider, client, NULL,
>                             GFP_ATOMIC);
>
>     return ret;
>
>
>>   }
>>     static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>> @@ -877,7 +884,6 @@ int pci_p2pdma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>>       case PCI_P2PDMA_MAP_BUS_ADDR:
>>           return __pci_p2pdma_map_sg(p2p_pgmap, dev, sg, nents);
>>       default:
>> -        WARN_ON_ONCE(1);
>
> Why? Or at least, why, in this patch? It looks like an accidental
> leftover from something, seeing as how it is not directly related to the
> patch, and is not mentioned at all.
>
>
> thanks,

