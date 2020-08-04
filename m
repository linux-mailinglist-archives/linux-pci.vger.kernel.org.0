Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7253D23B70C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 10:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgHDItp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 04:49:45 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:35136 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726233AbgHDItp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 4 Aug 2020 04:49:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U4jVMG6_1596530971;
Received: from B-J2UMLVDL-1650.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0U4jVMG6_1596530971)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 16:49:39 +0800
Subject: Re: [PATCH v2] virtio_ring: use alloc_pages_node for NUMA-aware
 allocation
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jiang Liu <liuj97@gmail.com>, linux-pci@vger.kernel.org,
        bhelgaas@google.com
References: <20200721070013.62894-1-shile.zhang@linux.alibaba.com>
 <20200721041550-mutt-send-email-mst@kernel.org>
 <d16c8191-3837-8734-8cdf-ae6dd75725f7@linux.alibaba.com>
 <222b40f1-a36c-0375-e965-cd949e8b9eeb@linux.alibaba.com>
Message-ID: <d01f138c-9ec7-1740-77f1-6577f7f0b7d4@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 16:49:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <222b40f1-a36c-0375-e965-cd949e8b9eeb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Michael & Bjorn,

Sorry for the ping,
but how about this patch/issue? any comments/suggestions?

Thanks!

On 2020/7/27 21:10, Shile Zhang wrote:
> 
> 
> On 2020/7/21 19:28, Shile Zhang wrote:
>>
>>
>> On 2020/7/21 16:18, Michael S. Tsirkin wrote:
>>> On Tue, Jul 21, 2020 at 03:00:13PM +0800, Shile Zhang wrote:
>>>> Use alloc_pages_node() allocate memory for vring queue with proper
>>>> NUMA affinity.
>>>>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Suggested-by: Jiang Liu <liuj97@gmail.com>
>>>> Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
>>>
>>> Do you observe any performance gains from this patch?
>>
>> Thanks for your comments!
>> Yes, the bandwidth can boost more than doubled (from 30Gbps to 80GBps) 
>> with this changes in my test env (8 numa nodes), with netperf test.
>>
>>>
>>> I also wonder why isn't the probe code run on the correct numa node?
>>> That would fix a wide class of issues like this without need to tweak
>>> drivers.
>>
>> Good point, I'll check this, thanks!
> 
> Sorry, I have no idea about how the probe code to grab the appropriate 
> NUMA node.
> 
>>
>>>
>>> Bjorn, what do you think? Was this considered?
> 
> Hi Bjorn, Could you please give any comments about this issue?
> Thanks!
> 
>>>
>>>> ---
>>>> Changelog
>>>> v1 -> v2:
>>>> - fixed compile warning reported by LKP.
>>>> ---
>>>>   drivers/virtio/virtio_ring.c | 10 ++++++----
>>>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/virtio/virtio_ring.c 
>>>> b/drivers/virtio/virtio_ring.c
>>>> index 58b96baa8d48..d38fd6872c8c 100644
>>>> --- a/drivers/virtio/virtio_ring.c
>>>> +++ b/drivers/virtio/virtio_ring.c
>>>> @@ -276,9 +276,11 @@ static void *vring_alloc_queue(struct 
>>>> virtio_device *vdev, size_t size,
>>>>           return dma_alloc_coherent(vdev->dev.parent, size,
>>>>                         dma_handle, flag);
>>>>       } else {
>>>> -        void *queue = alloc_pages_exact(PAGE_ALIGN(size), flag);
>>>> -
>>>> -        if (queue) {
>>>> +        void *queue = NULL;
>>>> +        struct page *page = 
>>>> alloc_pages_node(dev_to_node(vdev->dev.parent),
>>>> +                             flag, get_order(size));
>>>> +        if (page) {
>>>> +            queue = page_address(page);
>>>>               phys_addr_t phys_addr = virt_to_phys(queue);
>>>>               *dma_handle = (dma_addr_t)phys_addr;
>>>> @@ -308,7 +310,7 @@ static void vring_free_queue(struct 
>>>> virtio_device *vdev, size_t size,
>>>>       if (vring_use_dma_api(vdev))
>>>>           dma_free_coherent(vdev->dev.parent, size, queue, dma_handle);
>>>>       else
>>>> -        free_pages_exact(queue, PAGE_ALIGN(size));
>>>> +        free_pages((unsigned long)queue, get_order(size));
>>>>   }
>>>>   /*
>>>> -- 
>>>> 2.24.0.rc2
