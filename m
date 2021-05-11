Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF07937AB62
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhEKQG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42488 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231549AbhEKQG4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrrdEBLqCOmDZJ+zOkXaPF7O/7nbLIRMtWhGOzsY1Zc=;
        b=VWa2s+HwWpIWWJZ/Mxn6LNjjw07GiLIJOYVupnNLLEZQ3UmkJvF6f8N3ZyqQib/44gGkUG
        59OEIonBN6Ch9KGHK0T9kDhtEri7CuFUY4xxZqWiLQ1g8cJsPXiIgje77i273RiR4hQc4M
        IJn9MECMDwER/zy6vbOwi5mbJMjYmFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-IY58VNbdOuCPlC-_betBlg-1; Tue, 11 May 2021 12:05:47 -0400
X-MC-Unique: IY58VNbdOuCPlC-_betBlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CE848186E1;
        Tue, 11 May 2021 16:05:44 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AD745D9F2;
        Tue, 11 May 2021 16:05:40 +0000 (UTC)
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
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
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <a6830332-c866-451f-3c6a-585cbf295ff8@redhat.com>
Date:   Tue, 11 May 2021 12:05:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/2/21 1:35 AM, John Hubbard wrote:
> On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
>> In order to use upstream_bridge_distance_warn() from a dma_map function,
>> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
>> might sleep.
>>
>> In order to avoid this, try to get the host bridge's device from
>> bus->self, and if that is not set, just get the first element in the
>> device list. It should be impossible for the host bridge's device to
>> go away while references are held on child devices, so the first element
>> should not be able to change and, thus, this should be safe.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bd89437faf06..473a08940fbc 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>>                       bool same_host_bridge)
>>   {
>> -    struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>>       const struct pci_p2pdma_whitelist_entry *entry;
>> +    struct pci_dev *root = host->bus->self;
>>       unsigned short vendor, device;
>>   +    /*
>> +     * This makes the assumption that the first device on the bus is the
>> +     * bridge itself and it has the devfn of 00.0. This assumption should
>> +     * hold for the devices in the white list above, and if there are cases
>> +     * where this isn't true they will have to be dealt with when such a
>> +     * case is added to the whitelist.
>
> Actually, it makes the assumption that the first device *in the list*
> (the host->bus-devices list) is 00.0.  The previous code made the
> assumption that you wrote.
>
> By the way, pre-existing code comment: pci_p2pdma_whitelist[] seems
> really short. From a naive point of view, I'd expect that there must be
> a lot more CPUs/chipsets that can do pci p2p, what do you think? I
> wonder if we have to be so super strict, anyway. It just seems extremely
> limited, and I suspect there will be some additions to the list as soon
> as we start to use this.
>
>
>> +     */
>>       if (!root)
>> +        root = list_first_entry_or_null(&host->bus->devices,
>> +                        struct pci_dev, bus_list);
>
> OK, yes this avoids taking the pci_bus_sem, but it's kind of cheating.
> Why is it OK to avoid taking any locks in order to retrieve the
> first entry from the list, but in order to retrieve any other entry, you
> have to aquire the pci_bus_sem, and get a reference as well? Something
> is inconsistent there.
>
> The new version here also no longer takes a reference on the device,
> which is also cheating. But I'm guessing that the unstated assumption
> here is that there is always at least one entry in the list. But if
> that's true, then it's better to show clearly that assumption, instead
> of hiding it in an implicit call that skips both locking and reference
> counting.
>
> You could add a new function, which is a cut-down version of pci_get_slot(),
> like this, and call this from __host_bridge_whitelist():
>
> /*
>  * A special purpose variant of pci_get_slot() that doesn't take the pci_bus_sem
>  * lock, and only looks for the 00.0 bus-device-function. Once the PCI bus is
>  * up, it is safe to call this, because there will always be a top-level PCI
>  * root device.
>  *
>  * Other assumptions: the root device is the first device in the list, and the
>  * root device is numbered 00.0.
>  */
> struct pci_dev *pci_get_root_slot(struct pci_bus *bus)
> {
>     struct pci_dev *root;
>     unsigned devfn = PCI_DEVFN(0, 0);
>
>     root = list_first_entry_or_null(&bus->devices, struct pci_dev,
>                     bus_list);
>     if (root->devfn == devfn)
>         goto out;
>
... add a flag (set for p2pdma use)  to the function to print out what the root->devfn is, and what
the device is so the needed quirk &/or modification can added to handle when this assumption fails;
or make it a prdebug that can be flipped on for this failing situation, again, to add needed change to accomodate.

>     root = NULL;
>  out:
>     pci_dev_get(root);
>     return root;
> }
> EXPORT_SYMBOL(pci_get_root_slot);
>
> ...I think that's a lot clearer to the reader, about what's going on here.
>
> Note that I'm not really sure if it *is* safe, I would need to ask other
> PCIe subsystem developers with more experience. But I don't think anyone
> is trying to make p2pdma calls so early that PCIe buses are uninitialized.
>
>
>> +
>> +    if (!root || root->devfn)
>>           return false;
>>         vendor = root->vendor;
>>       device = root->device;
>> -    pci_dev_put(root);
and the reason to remove the dev_put is b/c it can sleep as well?
is that ok, given the dev_get that John put into the new pci_get_root_slot()?
... seems like a locking version with no get/put's is needed, or, fix the host-bridge setups so no !NULL self pointers.


>>         for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
>>           if (vendor != entry->vendor || device != entry->device)
>>
>
> thanks,

