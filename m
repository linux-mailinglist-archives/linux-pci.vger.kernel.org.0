Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C605D37AB53
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhEKQGo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231355AbhEKQGn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Z2k7kEMuOxvMNfv9wyuet8mFypiPJLma4wFOmFQFhU=;
        b=UgAv0poP5eOdNcZI7JJQNujJzdA6qJNVrrSoWKPdcary+JlmutyrggXX/TkD1G1ARdDk/Q
        w6HoEuWy1pEovUbpbn0dZoJV9H7KfDHQkU81wMjXYSqxdLGi8E6+iyHljkb++fhuowA30V
        WcfQjKKS45nJrvQx2Fuc30Y6sOlGkhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-Z7LXlEqAMSavyp-h4tVVsA-1; Tue, 11 May 2021 12:05:32 -0400
X-MC-Unique: Z7LXlEqAMSavyp-h4tVVsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73FD4107ACED;
        Tue, 11 May 2021 16:05:29 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B81FA5C232;
        Tue, 11 May 2021 16:05:26 +0000 (UTC)
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
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
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <a23fdb9c-f653-e766-89e1-98550658724c@redhat.com>
Date:   Tue, 11 May 2021 12:05:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/1/21 11:58 PM, John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> In order to call upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. The only reason it does sleep is to allocate the seqbuf
>> to print which devices are within the ACS path.
>>
>> Switch the kmalloc call to use a passed in gfp_mask and don't print that
>> message if the buffer fails to be allocated.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>   drivers/pci/p2pdma.c | 21 +++++++++++----------
>>   1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index 196382630363..bd89437faf06 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>>     static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>   {
>> -    if (!buf)
>> +    if (!buf || !buf->buffer)
>
> This is not great, sort of from an overall design point of view, even though
> it makes the rest of the patch work. See below for other ideas, that will
> avoid the need for this sort of odd point fix.
>
+1.
In fact, I didn't see how the kmalloc was changed... you refactored the code to pass-in the
GFP_KERNEL that was originally hard-coded into upstream_bridge_distance_warn();
I don't see how that avoided the kmalloc() call.
in fact, I also see you lost a failed kmalloc() check, so it seems to have taken a step back.

>>           return;
>>         seq_buf_printf(buf, "%s;", pci_name(pdev));
>> @@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>>     static enum pci_p2pdma_map_type
>>   upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
>> -                  int *dist)
>> +                  int *dist, gfp_t gfp_mask)
>>   {
>>       struct seq_buf acs_list;
>>       bool acs_redirects;
>>       int ret;
>>   -    seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
>> -    if (!acs_list.buffer)
>> -        return -ENOMEM;
>
> Another odd thing: this used to check for memory failure and just give
> up, and now it doesn't. Yes, I realize that it all still works at the
> moment, but this is quirky and we shouldn't stop here.
>
> Instead, a cleaner approach would be to push the memory allocation
> slightly higher up the call stack, out to the
> pci_p2pdma_distance_many(). So pci_p2pdma_distance_many() should make
> the kmalloc() call, and fail out if it can't get a page for the seq_buf
> buffer. Then you don't have to do all this odd stuff.
>
> Furthermore, the call sites can then decide for themselves which GFP
> flags, GFP_ATOMIC or GFP_KERNEL or whatever they want for kmalloc().
>
agree, good proposal to avoid a sleep due to kmalloc().

> A related thing: this whole exercise would go better if there were a
> preparatory patch or two that changed the return codes in this file to
> something less crazy. There are too many functions that can fail, but
> are treated as if they sort-of-mostly-would-never-fail, in the hopes of
> using the return value directly for counting and such. This is badly
> mistaken, and it leads developers to try to avoid returning -ENOMEM
> (which is what we need here).
>
> Really, these functions should all be doing "0 for success, -ERRNO for
> failure, and pass other values, including results, in the arg list".
>
WFM!

>
>> +    seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
>>         ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
>>                          &acs_list);
>>       if (acs_redirects) {
>>           pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>>                pci_name(provider));
>> -        /* Drop final semicolon */
>> -        acs_list.buffer[acs_list.len-1] = 0;
>> -        pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
>> -             acs_list.buffer);
>> +
>> +        if (acs_list.buffer) {
>> +            /* Drop final semicolon */
>> +            acs_list.buffer[acs_list.len - 1] = 0;
>> +            pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
>> +                 acs_list.buffer);
>> +        }
>>       }
>>         if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
>> @@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>>             if (verbose)
>>               ret = upstream_bridge_distance_warn(provider,
>> -                    pci_client, &distance);
>> +                    pci_client, &distance, GFP_KERNEL);
>>           else
>>               ret = upstream_bridge_distance(provider, pci_client,
>>                                  &distance, NULL, NULL);
>>
>
> thanks,

