Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2120C5AE
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 06:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgF1ERQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 00:17:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgF1ERQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Jun 2020 00:17:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 04CB66A1A87053D56211;
        Sun, 28 Jun 2020 12:17:10 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.83) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 12:17:03 +0800
Subject: Re: [PATCH v3] PCI: Lock the pci_cfg_wait queue for the consistency
 of data
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <willy@infradead.org>,
        <wangxiongfeng2@huawei.com>, <wanghaibin.wang@huawei.com>,
        <guoheyi@huawei.com>, <yebiaoxiang@huawei.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
References: <20200624232309.GA2601999@bjorn-Precision-5520>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <cf73da1d-aa6d-e2e0-36eb-ce30b83288a6@huawei.com>
Date:   Sun, 28 Jun 2020 12:17:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200624232309.GA2601999@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.83]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Sorry for the late reply, I had Dragon Boat Festival these days.

On 2020/6/25 7:23, Bjorn Helgaas wrote:
> On Tue, Dec 10, 2019 at 11:15:27AM +0800, Xiang Zheng wrote:
>> 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
>> device") suggests that the "pci_lock" is sufficient, and all the
>> callers of pci_wait_cfg() are wrapped with the "pci_lock".
>>
>> However, since the commit cdcb33f98244 ("PCI: Avoid possible deadlock on
>> pci_lock and p->pi_lock") merged, the accesses to the pci_cfg_wait queue
>> are not safe anymore. This would cause kernel panic in a very low chance
>> (See more detailed information from the below link). A "pci_lock" is
>> insufficient and we need to hold an additional queue lock while read/write
>> the wait queue.
>>
>> So let's use the add_wait_queue()/remove_wait_queue() instead of
>> __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
>> functionality around the "schedule()" function to avoid reintroducing
>> the deadlock addressed by "cdcb33f98244".
> 
> I see that add_wait_queue() acquires the wq_head->lock, while
> __add_wait_queue() does not.
> 
> But I don't understand why the existing pci_lock is insufficient.  
> pci_cfg_wait is only used in pci_wait_cfg() and
> pci_cfg_access_unlock().
> 
> In pci_wait_cfg(), both __add_wait_queue() and __remove_wait_queue()
> are called while holding pci_lock, so that doesn't seem like the
> problem.
> 
> In pci_cfg_access_unlock(), we have:
> 
>   pci_cfg_access_unlock
>     wake_up_all(&pci_cfg_wait)
>       __wake_up(&pci_cfg_wait, ...)
>         __wake_up_common_lock(&pci_cfg_wait, ...)
> 	  spin_lock(&pci_cfg_wait->lock)
> 	  __wake_up_common(&pci_cfg_wait, ...)
> 	    list_for_each_entry_safe_from(...)
> 	      list_add_tail(...)                <-- problem?
> 	  spin_unlock(&pci_cfg_wait->lock)
> 
> Is the problem that the wake_up_all() modifies the pci_cfg_wait list
> without holding pci_lock?
> 
> If so, I don't quite see how the patch below fixes it.  Oh, wait,
> maybe I do ... by using add_wait_queue(), we protect the list using
> the *same* lock used by __wake_up_common_lock.  Is that it?
> 

Yes, my patch just protects the wait queue list by using add_wait_queue().
Simply using the add_wait_queue() instead of __add_wait_queue() will reintroduce
the deadlock addressed by "cdcb33f98244". So I move add_wait_queue() and
remote_wait_queue() around schedule() since they don't need to hold pci_lock.


>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> Cc: Heyi Guo <guoheyi@huawei.com>
>> Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
>> Link: https://lore.kernel.org/linux-pci/79827f2f-9b43-4411-1376-b9063b67aee3@huawei.com/
>> ---
>>
>> v3:
>>   Improve the commit subject and message.
>>
>> v2:
>>   Move the wait queue functionality around the "schedule()".
>>
>> ---
>>  drivers/pci/access.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 2fccb5762c76..09342a74e5ea 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -207,14 +207,14 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>>  {
>>  	DECLARE_WAITQUEUE(wait, current);
>>  
>> -	__add_wait_queue(&pci_cfg_wait, &wait);
>>  	do {
>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>  		raw_spin_unlock_irq(&pci_lock);
>> +		add_wait_queue(&pci_cfg_wait, &wait);
>>  		schedule();
>> +		remove_wait_queue(&pci_cfg_wait, &wait);
>>  		raw_spin_lock_irq(&pci_lock);
>>  	} while (dev->block_cfg_access);
>> -	__remove_wait_queue(&pci_cfg_wait, &wait);
>>  }
>>  
>>  /* Returns 0 on success, negative values indicate error. */
>> -- 
>> 2.19.1
>>
>>
> 
> .
> 

-- 
Thanks,
Xiang

