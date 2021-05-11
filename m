Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6C37ABD7
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbhEKQYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:24:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231437AbhEKQYj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620750212;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3M6tTHlyFNKQwbGOtrLH1dHnpAA9L/D3mvAYYkgV538=;
        b=HFdExlKg8EqxzBOOaH7hRhKKJ9DSZNzMVgfNvJS94XYqqMloJL86ko7miWWLcqJWSYch8P
        jNu+yi36iC6c9p0IC7lhnf8B16chhJ5CIeLUDVmHj+8ufmUNWWhoC3iCED13fxia6BZckc
        FEggNvQI8/8ZGxh+rnq73EG+Z3xqDws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-e2fb4B8yPWyJlQzkc_nNww-1; Tue, 11 May 2021 12:23:16 -0400
X-MC-Unique: e2fb4B8yPWyJlQzkc_nNww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687B38015D0;
        Tue, 11 May 2021 16:23:13 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968105DEAD;
        Tue, 11 May 2021 16:23:10 +0000 (UTC)
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
To:     Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
 <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <c078b970-7531-8834-e26f-e653e7db4c20@redhat.com>
Date:   Tue, 11 May 2021 12:23:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <36b86579-da30-0671-26e9-75977a265742@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/11/21 12:12 PM, Logan Gunthorpe wrote:
>
> On 2021-05-11 10:05 a.m., Don Dutile wrote:
>> On 5/1/21 11:58 PM, John Hubbard wrote:
>>> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>>>> In order to call upstream_bridge_distance_warn() from a dma_map function,
>>>> it must not sleep. The only reason it does sleep is to allocate the seqbuf
>>>> to print which devices are within the ACS path.
>>>>
>>>> Switch the kmalloc call to use a passed in gfp_mask and don't print that
>>>> message if the buffer fails to be allocated.
>>>>
>>>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>    drivers/pci/p2pdma.c | 21 +++++++++++----------
>>>>    1 file changed, 11 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>>>> index 196382630363..bd89437faf06 100644
>>>> --- a/drivers/pci/p2pdma.c
>>>> +++ b/drivers/pci/p2pdma.c
>>>> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>>>>      static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>>>    {
>>>> -    if (!buf)
>>>> +    if (!buf || !buf->buffer)
>>> This is not great, sort of from an overall design point of view, even though
>>> it makes the rest of the patch work. See below for other ideas, that will
>>> avoid the need for this sort of odd point fix.
>>>
>> +1.
>> In fact, I didn't see how the kmalloc was changed... you refactored the code to pass-in the
>> GFP_KERNEL that was originally hard-coded into upstream_bridge_distance_warn();
>> I don't see how that avoided the kmalloc() call.
>> in fact, I also see you lost a failed kmalloc() check, so it seems to have taken a step back.
> I've changed this in v2 to just use some memory allocated on the stack.
> Avoids this argument all together.
>
> Logan
>
Looking fwd to the v2; again, my apologies for the delay, and the redundancy it's adding to your feedback review & changes.
-Don

