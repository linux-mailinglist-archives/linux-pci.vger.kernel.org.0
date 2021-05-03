Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00933718E8
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhECQJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 12:09:49 -0400
Received: from ale.deltatee.com ([204.191.154.188]:56724 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhECQJk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 12:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=5jxJ8b/HSUR/7BT5D5WyPEoFYv66JE4BKEKp4HTWf+Y=; b=XWOWwDZ6ZwrouJikaVp8dHiCsr
        I115w+HLBGME9bYlcrjafcglo1GZw06C+Elx221Hmed7QE1HotLNe7+fjXntv4waAOS13LuqEUEIn
        IW2dFINknX+ObrcY9YFIltZb/ozZzUEhKZ702sW1RXa0CfCJuy3VwVNPCow1cpShl+xJ8oX8jXLua
        CqCj1z1wi2T5bZLWF7vRp+RhStCsdQ/r35mSNu80y/H+7gL/KgizhTJPZjwewDohxqwmmbcgGrZd9
        r5urtV1BmH8V5hE2g/eDXD4Qmot0I0KTcAyTeTvQ6Z//Z9oet0bd7OsXbNybLVQ8NF0d8AtcoRbgL
        tLRcrxtw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1ldb7b-0003hs-5l; Mon, 03 May 2021 10:08:36 -0600
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
 <20210408170123.8788-3-logang@deltatee.com>
 <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d4091d87-7d9e-8cde-4e1c-01b877b6785f@deltatee.com>
Date:   Mon, 3 May 2021 10:08:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <d6220bff-83fc-6c03-76f7-32e9e00e40fd@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jhubbard@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-05-01 11:35 p.m., John Hubbard wrote:
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
>>   drivers/pci/p2pdma.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index bd89437faf06..473a08940fbc 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
>>   static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>>   				    bool same_host_bridge)
>>   {
>> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>>   	const struct pci_p2pdma_whitelist_entry *entry;
>> +	struct pci_dev *root = host->bus->self;
>>   	unsigned short vendor, device;
>>   
>> +	/*
>> +	 * This makes the assumption that the first device on the bus is the
>> +	 * bridge itself and it has the devfn of 00.0. This assumption should
>> +	 * hold for the devices in the white list above, and if there are cases
>> +	 * where this isn't true they will have to be dealt with when such a
>> +	 * case is added to the whitelist.
> 
> Actually, it makes the assumption that the first device *in the list*
> (the host->bus-devices list) is 00.0.  The previous code made the
> assumption that you wrote.

The comment notes two assumptions (although the grammar is poor, which I
will fix). Yes, the previous code made the second assumption, the new
code makes both assumptions.

> By the way, pre-existing code comment: pci_p2pdma_whitelist[] seems
> really short. From a naive point of view, I'd expect that there must be
> a lot more CPUs/chipsets that can do pci p2p, what do you think? I
> wonder if we have to be so super strict, anyway. It just seems extremely
> limited, and I suspect there will be some additions to the list as soon
> as we start to use this.

Yes, well unfortunately we have no other way to determine what host
bridges can communicate with P2P. We settled on a whitelist when the
series was first patch. Nobody likes that situation, but nobody has
found anything better. We've been hoping standards bodies would give us
a flag but I haven't heard anything about that. At least AMD has been
able to guarantee us that all CPUs newer than Zen will support so that
covers a large swath. It would be nice if we could say something similar
for Intel.

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

Because we hold a reference to a child device of the bus. So the host
bus device can't go away until the child device has been released. An
earlier version of the P2PDMA patchset had a lot more extraneous get
device calls until someone else pointed this out.

> You could add a new function, which is a cut-down version of pci_get_slot(),
> like this, and call this from __host_bridge_whitelist():
> 
> /*
>   * A special purpose variant of pci_get_slot() that doesn't take the pci_bus_sem
>   * lock, and only looks for the 00.0 bus-device-function. Once the PCI bus is
>   * up, it is safe to call this, because there will always be a top-level PCI
>   * root device.
>   *
>   * Other assumptions: the root device is the first device in the list, and the
>   * root device is numbered 00.0.
>   */
> struct pci_dev *pci_get_root_slot(struct pci_bus *bus)
> {
> 	struct pci_dev *root;
> 	unsigned devfn = PCI_DEVFN(0, 0);
> 
> 	root = list_first_entry_or_null(&bus->devices, struct pci_dev,
> 					bus_list);
> 	if (root->devfn == devfn)
> 		goto out;
> 
> 	root = NULL;
>   out:
> 	pci_dev_get(root);
> 	return root;
> }
> EXPORT_SYMBOL(pci_get_root_slot);
> 
> ...I think that's a lot clearer to the reader, about what's going on here.

Per above, I think the reference count is unnecessary. But I could wrap
it in a static function for clarity. (There's no reason to export this
function).

> Note that I'm not really sure if it *is* safe, I would need to ask other
> PCIe subsystem developers with more experience. But I don't think anyone
> is trying to make p2pdma calls so early that PCIe buses are uninitialized.

Yeah, it's impossible to make a p2pdma call before the PCIe bus is
initialized. They have to have access to at least one PCI device before
they can even attempt it.

Logan
